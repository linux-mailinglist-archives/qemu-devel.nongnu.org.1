Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F927E338A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:07:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CPR-0000v8-Cf; Mon, 06 Nov 2023 22:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COY-000786-1c
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:52 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COL-0000gt-6m
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:49 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc3c51f830so39153385ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326269; x=1699931069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KL35RIOske5ZEwNLa4RVHtpQpzTuLRW6sfRRvrTR5m0=;
 b=MzgFRuWFKtZbJwKZnanyVC88CkfPlmmleZ//TETgp8meUAiiCpBlXy6T6fLj/o/IYz
 gI19GYSLTohQxYXax/z8jjp9eYLS5dJy12vA8R/RQzvF5o6iil4oIqPtdmq25nkoZ/1J
 BFL09MYAJZTE3eS57YJnrRWkfBVPdRvzzGltnOpHipbkOxXWVIAKZkmzHgdrPkjSGn1m
 ApTVQwMsvwH+wouazY6PnhkPVKjmHfg3IZbw80dSWK+pzonbvxSvKf8j6XNkoGI7GCmr
 KjigDrBTLwKFDLo19ABLW69OX0JmNh+43kpbrqbTPDFMEtjLBiqiNVeWFiwQm0k5ieMb
 jk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326269; x=1699931069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KL35RIOske5ZEwNLa4RVHtpQpzTuLRW6sfRRvrTR5m0=;
 b=l5Q5nauiaP86NC+qD/qpY1VTnHjog2N1ueHDJP1cDecbpBt1cUEycAsE+1ZNP42aVM
 GUNVnNeeLUhUaSr69NZQOW/u9h5GDfCc6fmPeOriX/bVzMoDH/eeP66FtXMOiKdTbAVS
 v3eIAxasqA3s4opoyIDyD8ubpNgqiTq7yXgbtGQUgMy8Tnqin4uViRR/MBiGNy7YRCgV
 du7L9p1LVHmC9/ofjooMpLVqkU5l1ChifD/pFV6oPnvr9EC03+FpRzdCORk29UuWqffs
 3FI59BvVLtc+qvFSWd8GRDzBpSc/qIp6ZpIwLkKK0YuatfRMn1yTWnjhMQjvNDTlkfcH
 xsJQ==
X-Gm-Message-State: AOJu0Yx5DOLhY2ZTteFriF6/MYbySjAE1+V3eYPFBumbGpV3SWI+oom9
 GfxSKo4Csq7Qtl/JjJkTlf0TywejdmtlF+rOG74=
X-Google-Smtp-Source: AGHT+IGxyJCaAvF7n9EwjhfGryKul8JeUvOZMNxxKnCj/csy14Otif3Eh10THDZhytzh3mqPwwvK2g==
X-Received: by 2002:a17:902:e887:b0:1cc:7b2f:7216 with SMTP id
 w7-20020a170902e88700b001cc7b2f7216mr16630499plg.29.1699326269646; 
 Mon, 06 Nov 2023 19:04:29 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/85] target/hppa: Mask inputs in copy_iaoq_entry
Date: Mon,  6 Nov 2023 19:03:10 -0800
Message-Id: <20231107030407.8979-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Ensure that the destination is always a valid GVA offset.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c2db2782f4..cf05d8b6e4 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -720,10 +720,22 @@ static target_ureg gva_offset_mask(DisasContext *ctx)
 static void copy_iaoq_entry(DisasContext *ctx, TCGv_reg dest,
                             target_ureg ival, TCGv_reg vval)
 {
-    if (unlikely(ival == -1)) {
+    target_ureg mask = gva_offset_mask(ctx);
+
+    if (ival != -1) {
+        tcg_gen_movi_reg(dest, ival & mask);
+        return;
+    }
+    tcg_debug_assert(vval != NULL);
+
+    /*
+     * We know that the IAOQ is already properly masked.
+     * This optimization is primarily for "iaoq_f = iaoq_b".
+     */
+    if (vval == cpu_iaoq_f || vval == cpu_iaoq_b) {
         tcg_gen_mov_reg(dest, vval);
     } else {
-        tcg_gen_movi_reg(dest, ival);
+        tcg_gen_andi_reg(dest, vval, mask);
     }
 }
 
-- 
2.34.1


