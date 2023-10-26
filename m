Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF60C7D7963
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:26:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2n-00070h-7U; Wed, 25 Oct 2023 20:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2h-0006zd-0A
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:07 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2Q-0004pd-8P
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:04 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1ca215cc713so2016885ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279348; x=1698884148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a6T/c3A96Bz3wE+bsJljf0ySAcIsMHNjnW78siXjVBI=;
 b=yCAN3Aw4444XqOT64d85qGq5ufleB0tXDzpiplpEiLDAF9V2CdX16bBumSvm7EfKpo
 U6Hc8t/jucAFW5AfxwIFaErPB9XO3xQlGB4a3SF9jnqPZQ3MvFKcVTPw56CkB+XEP1pz
 JRfdero6Ud6Po+fKY0fSgzxc1fKFZAfQOnkZCeEWIn/VPtX5vRldDILbFknyoaiUhvkI
 Lrs8CIShWTQYctvwBdj4s8ScuwWkOTpfxGKDB/UhvbRIy1Pmktna7AKUukU5GFEOxG17
 kRMcpMACI+KJpywxm0TDUtoaSBxqegznfzFdCG0K8rnZdqPJ7Y2crh3vwltAUP5W/fjj
 VEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279348; x=1698884148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6T/c3A96Bz3wE+bsJljf0ySAcIsMHNjnW78siXjVBI=;
 b=qZaZ+BkmU0POHBp3trLdA7gaYHj0UoSKw/o7yi/T3EJzq7YLUDUQXF1i/m4VHM96ou
 PsKaEg2UmiaubdcGIcGDQJg8bYiM1JhmAOSoILvE+k/dd0MgYHT9v8ooze/NoqcOvJ04
 Q1K0KYl+hFhA3Prrgd90TqvlfVQM4ybEuwdbMUq+nD0sHYZou8gqvvPOLXe6fHnjUkW+
 y+6IvkYGSPrFLSeayCMELF1LibhNgfYc3DGtptX2wa+rQkRV72PRdUI+leRFkTnlDaaW
 JVG16yGaHMkKAuiOEpHazlhAK9678tk41P0RTtmUhQQ/oa7Fd9CFCuwPEKtxv5Cut8Oz
 6HTA==
X-Gm-Message-State: AOJu0YwonhOT5zMg3Os4rM5Mq8JMs6PTWkFqldHbT4V/1CZ1h/0ukkGM
 0pPJP8z1yb2osFjCRo+AfxHtTaLn6F1HycQmTz0=
X-Google-Smtp-Source: AGHT+IGSED9kxEI5GOLUvQcbo9shOVqJ3gEAw8/TxeLZoDYuQRhsR1k779EDhb0U7EDfmslWrvBMCw==
X-Received: by 2002:a17:902:c404:b0:1c7:8345:f377 with SMTP id
 k4-20020a170902c40400b001c78345f377mr18274565plk.29.1698279348361; 
 Wed, 25 Oct 2023 17:15:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:15:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 03/94] target/sparc: Avoid helper_raise_exception in
 helper_st_asi
Date: Wed, 25 Oct 2023 17:13:44 -0700
Message-Id: <20231026001542.1141412-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Always use cpu_raise_exception_ra with GETPC for unwind.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/ldst_helper.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 246de86c98..09066d5487 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1650,7 +1650,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             int idx = ((asi & 2) >> 1) | ((asi & 8) >> 2);
             env->dmmu.sun4v_tsb_pointers[idx] = val;
         } else {
-            helper_raise_exception(env, TT_ILL_INSN);
+            goto illegal_insn;
         }
         break;
     case 0x33:
@@ -1662,7 +1662,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
              */
             env->dmmu.sun4v_ctx_config[(asi & 8) >> 3] = val;
         } else {
-            helper_raise_exception(env, TT_ILL_INSN);
+            goto illegal_insn;
         }
         break;
     case 0x35:
@@ -1679,7 +1679,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             int idx = ((asi & 2) >> 1) | ((asi & 8) >> 2);
             env->immu.sun4v_tsb_pointers[idx] = val;
         } else {
-            helper_raise_exception(env, TT_ILL_INSN);
+            goto illegal_insn;
         }
       break;
     case 0x37:
@@ -1691,7 +1691,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
              */
             env->immu.sun4v_ctx_config[(asi & 8) >> 3] = val;
         } else {
-          helper_raise_exception(env, TT_ILL_INSN);
+            goto illegal_insn;
         }
         break;
     case ASI_UPA_CONFIG: /* UPA config */
@@ -1920,6 +1920,8 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
     default:
         sparc_raise_mmu_fault(cs, addr, true, false, 1, size, GETPC());
         return;
+    illegal_insn:
+        cpu_raise_exception_ra(env, TT_ILL_INSN, GETPC());
     }
 }
 #endif /* CONFIG_USER_ONLY */
-- 
2.34.1


