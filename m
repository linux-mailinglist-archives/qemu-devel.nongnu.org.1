Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9A57F6C6A
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 07:41:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6PsC-0002C7-B7; Fri, 24 Nov 2023 01:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6Ps7-0002BZ-5M; Fri, 24 Nov 2023 01:41:03 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6Ps5-0006Bu-Fg; Fri, 24 Nov 2023 01:41:02 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6cb74a527ceso1324828b3a.2; 
 Thu, 23 Nov 2023 22:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700808059; x=1701412859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLN3173ytZytDQJzXh3TbGBGR8cSN5dnqSH5vQSBFXg=;
 b=limw8foDS85J4M8fzPnytLWYnEiQuTJUWhKVvLMYCaa1M3NlpxnxDQOeBzZSaIhVV0
 GZdmIWzu9kbbK/pxqN0+KP0M8MizrvF6TYfO26r5IZ7TwqoAuZP55JkmWHnjquzHq1J8
 RcFOcZzSiVReccYWEN/ZwbeevnWjg0lwgeYLWEboRBx+CsUVo6KhjjgVdwGrZv4EKv5D
 MRUEBAXwOLGfX4WIDUlzvmw3dVxpqe8o0/HgW1f55HC7v6gs4LiolBO3Ly3LHCkE7M1D
 qsnSm1VMlYoveBOSnxRq/lnOrCf1jpNl9ulCIhU4qa7He1c97zhKrDfI00+cRHKD7pEp
 mewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700808059; x=1701412859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GLN3173ytZytDQJzXh3TbGBGR8cSN5dnqSH5vQSBFXg=;
 b=ISyUFta2rWxTlR45cnEoxCiAmlQHCFYuh37HmtstCW+hmf2NT1uK8Cv+O2oywEK0RQ
 ATTFQmHEssCdHC9altMGFP08ZIVBn8CS37/YZtcbnotvB9otSo5GrSqxi24NXc0OPOep
 KO2CatTgJaeOAQK/JTjurfLlgmpyDqQd54w4cRuLaKP2EymSAeWq3cqb65fwfmgAfyY8
 OjeJTDuH+8iKv3fdgbpdbiHFeHXYFBUuw1oUDYelaP+ejjWs+3AnLuHLZbuSDnH+Q7ej
 HMGhCYDP8agb129ikBLoisApkjURMiSwEuFLcyIGTVuZe8dAjvBdPuFcBCtRC2k/UOyg
 NCLQ==
X-Gm-Message-State: AOJu0YwgGeSaFQEpo/5lOITXpWZz+O/8TeZf352UzcdOhgUE00fK3JVu
 Uq7B0AJFRiZyKJ7SYgrzHzL2vH/cDhT1ow==
X-Google-Smtp-Source: AGHT+IEGsbLwvjcGZjuTjw4ixQPjEfJHst2GD43r7SJ9jq85BR/557C3cyGRbcv6GqAM7gC2SyYq5A==
X-Received: by 2002:a05:6a00:428c:b0:6cb:8b47:cb6c with SMTP id
 bx12-20020a056a00428c00b006cb8b47cb6cmr1959708pfb.6.1700808059318; 
 Thu, 23 Nov 2023 22:40:59 -0800 (PST)
Received: from wheely.local0.net ([1.145.239.154])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a62f249000000b006cb8a8a4bbfsm2152013pfl.186.2023.11.23.22.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 22:40:58 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 3/7] target/ppc: Fix move-to timebase SPR access permissions
Date: Fri, 24 Nov 2023 16:39:57 +1000
Message-ID: <20231124064001.198572-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124064001.198572-1-npiggin@gmail.com>
References: <20231124064001.198572-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The move-to timebase registers TBU and TBL can not be read, and they
can not be written in supervisor mode on hypervisor-capable CPUs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper_regs.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 6f190ab13b..f1493ddca0 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -468,18 +468,33 @@ void register_generic_sprs(PowerPCCPU *cpu)
                  &spr_read_tbl, SPR_NOACCESS,
                  &spr_read_tbl, SPR_NOACCESS,
                  0x00000000);
-    spr_register(env, SPR_WR_TBL, "TBL",
-                 &spr_read_tbl, SPR_NOACCESS,
-                 &spr_read_tbl, &spr_write_tbl,
-                 0x00000000);
     spr_register(env, SPR_TBU, "TBU",
                  &spr_read_tbu, SPR_NOACCESS,
                  &spr_read_tbu, SPR_NOACCESS,
                  0x00000000);
-    spr_register(env, SPR_WR_TBU, "TBU",
-                 &spr_read_tbu, SPR_NOACCESS,
-                 &spr_read_tbu, &spr_write_tbu,
-                 0x00000000);
+#ifndef CONFIG_USER_ONLY
+    if (env->has_hv_mode) {
+        spr_register_hv(env, SPR_WR_TBL, "TBL",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, &spr_write_tbl,
+                        0x00000000);
+        spr_register_hv(env, SPR_WR_TBU, "TBU",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, &spr_write_tbu,
+                        0x00000000);
+    } else {
+        spr_register(env, SPR_WR_TBL, "TBL",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     SPR_NOACCESS, &spr_write_tbl,
+                     0x00000000);
+        spr_register(env, SPR_WR_TBU, "TBU",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     SPR_NOACCESS, &spr_write_tbu,
+                     0x00000000);
+    }
+#endif
 }
 
 void register_non_embedded_sprs(CPUPPCState *env)
-- 
2.42.0


