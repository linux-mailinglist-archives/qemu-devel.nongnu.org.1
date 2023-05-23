Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7842A70DBF4
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:06:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Ql6-0002QK-Jv; Tue, 23 May 2023 08:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1Ql3-0002Oa-PE
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:04:53 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1Ql1-0008QP-N0
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:04:53 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-306dbad5182so4831567f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684843490; x=1687435490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BdpkvDlA4UmVXiobxDu+YLmGZsz0CGX9FJr5LiiDCI0=;
 b=BoxleB2f7RstIIcpPHNcsvRnHU8L1GFuE1Al8cFMs94kTlJF5SUvWSUaeklvXVMrVR
 YXFEFDFlxrYSn2dIsA2bZSk6Y9avndyIKCielqXpXoTXnu7P3lO+VzvB8D63QujxU9V3
 nzB1bC7UGRoD1cci8/E4tnSBUQMJrmIJ+3fFsY4qNiVpyeIb0Rv6+ATcDpmmIVp9lfx1
 TJWjf3uOQSWBURWt4rGXli8R8qBkaap5TqEmqXXHn54vEEsthKCgmvUQtv2tm+hXSrd7
 RLTAeBr2KTgnVZrfUZPr6TMdsvxrxM9ErM88uXPTeZoc2oCtPhekPbMwmyCDg7Gim2S4
 Syrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684843490; x=1687435490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BdpkvDlA4UmVXiobxDu+YLmGZsz0CGX9FJr5LiiDCI0=;
 b=fj8z2SIhi8Y4FdLQgQ5DLpf/fAPq9AE08/Bt58O0L7Myp6+YxeD02R0vmkQXqsZcaD
 nO59fLNhsbYPq04bVqXm6Rkgo8+73LPOv+aIaPRGoVNTb3WGyIYoCSq6K25guUY0+9xO
 cRAIaW2CrM7qjGB1nSlDiICwaA8mQ980GIihX7bq3aePcA/7xDnXvqMC2Hlmc5JO+DiE
 v3l/ynqSK9bH5dU8tRY3APWAO0EmRp6Jr6kIfCuR4bKhnYrf12Tyfb5GH94QkkmNFA2+
 1dSFDfLPeypmEuSaZcPbpFE5BUeOGppu1nhpm8ah4pYDebwLc3rCkwjC0baubRvLiIEw
 2G7A==
X-Gm-Message-State: AC+VfDxRKS+q3pina0uoEL6obA9jG4DF7E/9MqfCDoJwLJAYmwzHnVKg
 HV4kxrNgqHJyIFwvMxIK+jvOp0yJrSSZODf4ZIU=
X-Google-Smtp-Source: ACHHUZ5ZK1lDkOho+A3gbtZGDhv7L7hv+ZXAO/6krdbnXAQ9+VjWRCFXbHU7snz95PCiVGXrMr/iQg==
X-Received: by 2002:a05:6000:1285:b0:307:a58f:5f7b with SMTP id
 f5-20020a056000128500b00307a58f5f7bmr10123157wrx.64.1684843489899; 
 Tue, 23 May 2023 05:04:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l17-20020adfe591000000b003079c402762sm10848778wrm.19.2023.05.23.05.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 05:04:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/6] docs: Document decodetree named field syntax
Date: Tue, 23 May 2023 13:04:43 +0100
Message-Id: <20230523120447.728365-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523120447.728365-1-peter.maydell@linaro.org>
References: <20230523120447.728365-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Document the named field syntax that we want to implement for the
decodetree script.  This allows a field to be defined in terms of
some other field that the instruction pattern has already set, for
example:

   %sz_imm 10:3 sz:3 !function=expand_sz_imm

to allow a function to be passed both an immediate field from the
instruction and also a sz value which might have been specified by
the instruction pattern directly (sz=1, etc) rather than being a
simple field within the instruction.

Note that the restriction on not having the format referring to the
pattern and the pattern referring to the format simultaneously is a
restriction of the decoder generator rather than inherently being a
silly thing to do.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/decodetree.rst | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/docs/devel/decodetree.rst b/docs/devel/decodetree.rst
index 49ea50c2a7f..e3392aa7057 100644
--- a/docs/devel/decodetree.rst
+++ b/docs/devel/decodetree.rst
@@ -23,22 +23,42 @@ Fields
 
 Syntax::
 
-  field_def     := '%' identifier ( unnamed_field )* ( !function=identifier )?
+  field_def     := '%' identifier ( field )* ( !function=identifier )?
+  field         := unnamed_field | named_field
   unnamed_field := number ':' ( 's' ) number
+  named_field   := identifier ':' ( 's' ) number
 
 For *unnamed_field*, the first number is the least-significant bit position
 of the field and the second number is the length of the field.  If the 's' is
-present, the field is considered signed.  If multiple ``unnamed_fields`` are
-present, they are concatenated.  In this way one can define disjoint fields.
+present, the field is considered signed.
+
+A *named_field* refers to some other field in the instruction pattern
+or format. Regardless of the length of the other field where it is
+defined, it will be inserted into this field with the specified
+signedness and bit width.
+
+Field definitions that involve loops (i.e. where a field is defined
+directly or indirectly in terms of itself) are errors.
+
+A format can include fields that refer to named fields that are
+defined in the instruction pattern(s) that use the format.
+Conversely, an instruction pattern can include fields that refer to
+named fields that are defined in the format it uses. However you
+cannot currently do both at once (i.e. pattern P uses format F; F has
+a field A that refers to a named field B that is defined in P, and P
+has a field C that refers to a named field D that is defined in F).
+
+If multiple ``fields`` are present, they are concatenated.
+In this way one can define disjoint fields.
 
 If ``!function`` is specified, the concatenated result is passed through the
 named function, taking and returning an integral value.
 
-One may use ``!function`` with zero ``unnamed_fields``.  This case is called
+One may use ``!function`` with zero ``fields``.  This case is called
 a *parameter*, and the named function is only passed the ``DisasContext``
 and returns an integral value extracted from there.
 
-A field with no ``unnamed_fields`` and no ``!function`` is in error.
+A field with no ``fields`` and no ``!function`` is in error.
 
 Field examples:
 
@@ -56,6 +76,9 @@ Field examples:
 | %shimm8 5:s8 13:1         | expand_shimm8(sextract(i, 5, 8) << 1 |      |
 |   !function=expand_shimm8 |               extract(i, 13, 1))            |
 +---------------------------+---------------------------------------------+
+| %sz_imm 10:2 sz:3         | expand_sz_imm(extract(i, 10, 2) << 3 |      |
+|   !function=expand_sz_imm |               extract(a->sz, 0, 3))         |
++---------------------------+---------------------------------------------+
 
 Argument Sets
 =============
-- 
2.34.1


