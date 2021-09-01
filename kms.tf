data "aws_iam_policy_document" "msk_kms_key_policy" {
  statement {
    sid    = "Allow account to access all KMS"
    effect = "Allow"

    principals {
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
      type = "AWS"
    }

    actions = [
      "kms:*"
    ]
    resources = ["*"]
  }
}

resource "aws_kms_key" "msk_kms_key" {
  description             = "KMS Key for MSK Cluster"
  enable_key_rotation     = true
  deletion_window_in_days = 10
  policy                  = data.aws_iam_policy_document.msk_kms_key_policy.json
}

resource "aws_kms_alias" "msk_kms_key_alias" {
  target_key_id = aws_kms_key.msk_kms_key.key_id

  depends_on = [
    aws_kms_key.msk_kms_key
  ]
}
