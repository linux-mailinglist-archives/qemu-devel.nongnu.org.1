Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F8582A433
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:47:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhLb-0000iK-88; Wed, 10 Jan 2024 17:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhLT-0008O7-3N
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:47 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhLR-0003eh-0e
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:46 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4299f424e55so13856471cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926804; x=1705531604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l6wrsnSxRLOGGrrUU+5wUcOLIX0LsFSMqYGfjSPgVvg=;
 b=ggFbARp8NPvInqFOwGI5nHC0vFTLa36s3vWpz6isQtkVfzjzJCV4zro3TJ70xUMHna
 qjqwkOwCliguvY3EWxnj8n5FNQccG3coDrIcfMLKEMfPqzq7dGTyvNSglxn48b2crU0v
 G2nBiHtmif05hWZIGz3VKfo2GKcfIyztk0L3lR1QhCuT59warXhNxdjP1igDkQQtaK+s
 Rc777fIk1f1zAGRjZ5tGTLS5drWE7JQKXAPc29Vnipvym2l0dFkJJkviO9B7JpmVAUWV
 B5uiDZ2aBhMPMNGzAQNk+qkzeKxqCqUSBkpjh8v2q2OcSv9vDK9RRTCu1fBwNZvnQydf
 axSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926804; x=1705531604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l6wrsnSxRLOGGrrUU+5wUcOLIX0LsFSMqYGfjSPgVvg=;
 b=N3CPFD72RBgigbGn5Zx0gIjbRziPiBj8Yzaq4AejIp7RjNmpRoQsoQUybPl05++9Uu
 5QossCJcXNAtUSPfjRINTZeMyLx3Ej3yjGyVPHBK7wFsjYHv1jokenVP/GjndGb+OTO4
 +987LowWaFKHTcSFooa/AfqPDouJrn9r7/LmNlr2QnLf3a0mcA2ImkKy6LiDPDEGjURz
 uMvqQYBvibA/zUARJ6/4VAyizSoL8l82Oat5FgqjGMwMyRjLe0vWTlhty3C79EXo+RDA
 YACOlXhBbcCf2TLQIh5kKVFpxryncQ7OcBwMas32ORB2LMuJBm6j+reOpB1IsLc1IiMU
 kEVQ==
X-Gm-Message-State: AOJu0Yy9sJj08flJE7RPyTWJNnMNA41fzlN5hEiJUuvr76YiJxPELsyg
 kmgC9bP6X21+dA3j9OjTvd2+AFaXODWYTjX/seMeahSfU4+x5iF5
X-Google-Smtp-Source: AGHT+IFARdK+VrmfEJTba1kHd/29lJ/JnfFaa7oDFALtZ+dqC4oJajBJ4TrIoNmYWvOJ/OC7Tpb8hQ==
X-Received: by 2002:ac8:7f10:0:b0:429:9b17:5910 with SMTP id
 f16-20020ac87f10000000b004299b175910mr296003qtk.136.1704926804016; 
 Wed, 10 Jan 2024 14:46:44 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:46:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 32/38] tcg/ppc: Tidy up tcg_target_const_match
Date: Thu, 11 Jan 2024 09:44:02 +1100
Message-Id: <20240110224408.10444-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x835.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index b9323baa86..26e0bc31d7 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -282,31 +282,36 @@ static bool reloc_pc34(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 }
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, int ct,
+static bool tcg_target_const_match(int64_t sval, int ct,
                                    TCGType type, TCGCond cond, int vece)
 {
+    uint64_t uval = sval;
+
     if (ct & TCG_CT_CONST) {
         return 1;
     }
 
-    /* The only 32-bit constraint we use aside from
-       TCG_CT_CONST is TCG_CT_CONST_S16.  */
     if (type == TCG_TYPE_I32) {
-        val = (int32_t)val;
+        uval = (uint32_t)sval;
+        sval = (int32_t)sval;
     }
 
-    if ((ct & TCG_CT_CONST_S16) && val == (int16_t)val) {
+    if ((ct & TCG_CT_CONST_S16) && sval == (int16_t)sval) {
         return 1;
-    } else if ((ct & TCG_CT_CONST_S32) && val == (int32_t)val) {
+    }
+    if ((ct & TCG_CT_CONST_S32) && sval == (int32_t)sval) {
         return 1;
-    } else if ((ct & TCG_CT_CONST_U32) && val == (uint32_t)val) {
+    }
+    if ((ct & TCG_CT_CONST_U32) && uval == (uint32_t)uval) {
         return 1;
-    } else if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
+    }
+    if ((ct & TCG_CT_CONST_ZERO) && sval == 0) {
         return 1;
-    } else if ((ct & TCG_CT_CONST_MONE) && val == -1) {
+    }
+    if ((ct & TCG_CT_CONST_MONE) && sval == -1) {
         return 1;
-    } else if ((ct & TCG_CT_CONST_WSZ)
-               && val == (type == TCG_TYPE_I32 ? 32 : 64)) {
+    }
+    if ((ct & TCG_CT_CONST_WSZ) && sval == (type == TCG_TYPE_I32 ? 32 : 64)) {
         return 1;
     }
     return 0;
-- 
2.34.1


