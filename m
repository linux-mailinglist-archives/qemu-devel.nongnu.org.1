Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDA9800ABD
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 13:19:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r92T1-0005or-FW; Fri, 01 Dec 2023 07:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r92S5-0005Xb-30; Fri, 01 Dec 2023 07:17:03 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r92S3-0006La-3g; Fri, 01 Dec 2023 07:17:00 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6cdd584591eso2009535b3a.2; 
 Fri, 01 Dec 2023 04:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701433017; x=1702037817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3eBHorYzeWRYIe6CR3hkTCvrYn8Bc1IR+gf3wCmm4l0=;
 b=Us/UG5BMRR5cxfy3IE5VLN+fe+hI42UxfibKBrXdcAmK/czfxTifr4jBaMfKNFw1zq
 l3n7fnbVvQhVAYCxRw8nv6MLCHAgHNc2b2gDuhotrYYEF0uKaNWynOb4pkvRFfBM9np8
 iZU2R0UFHjYVaJrgXnf/D4+mXNChiiqWiqqt/ri5abK77jPUPWYpJNcpeYRwzpha5XzY
 Np54HsrAX4VJwmZdsNQucbaM5eILQ13OMFS5D7km06pWeoLUx12pSdsZ8IaMEeg6Wjcn
 LnJUHQcW1qwXkMq3q+CsOP/zbxeZgZ+YPsyV5cwkvRFKcOGiHLkHQSxYq1pb8bRBPUMS
 m4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701433017; x=1702037817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3eBHorYzeWRYIe6CR3hkTCvrYn8Bc1IR+gf3wCmm4l0=;
 b=sM5hdyGcbaHTr6QXmIKOhgynnztGMmtOE61NU56jj9wg/6JRVzUuT+50ons2otoi8J
 yQNm3lNFuV6fz2tbwfLYnGM724YVeDntg1mnTZDrJ/IoH51TI+I6FOyjrNajENNlsXeQ
 VDf0+SUKZaUSW0Mjm14cipZnuKIw92RLOJVbqAh1lneU8Zzqq1d18G0/sNoJ6uuiARiS
 FkRzU6ZU3j5/gGWrtU1fDSWLy2TNBBEhYbIQBDrUP3LRucMzjVDWz5Bm3oID4FzS+7mJ
 FfbLmNraUKZsVEO+1aJ3wpIDWgiPrN8w8ArJwZpuq4Ms/13b9FSLLC/xCG5V7dy3gKEl
 oaVQ==
X-Gm-Message-State: AOJu0Yz+NPVDffkQIncJ6Rw1L4JhhaJOBjURdy4ybVFY4o7vkG9wZ3QD
 vggZ4gahhGT0UPyfW3Q5suyV7pT1+p4=
X-Google-Smtp-Source: AGHT+IG71d2Q4UtgNWy945gm3jCSHZYQgluMi4wbw1w3b7bIRi024NtYZq5ekvoAA+TCAMWtoyT4oQ==
X-Received: by 2002:aa7:981d:0:b0:6cd:f399:be00 with SMTP id
 e29-20020aa7981d000000b006cdf399be00mr3703834pfl.28.1701433015828; 
 Fri, 01 Dec 2023 04:16:55 -0800 (PST)
Received: from wheely.local0.net ([124.170.16.164])
 by smtp.gmail.com with ESMTPSA id
 r19-20020aa78b93000000b006cdd39faaaesm2830782pfd.20.2023.12.01.04.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 04:16:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 3/8] target/ppc: Fix move-to timebase SPR access permissions
Date: Fri,  1 Dec 2023 22:16:31 +1000
Message-ID: <20231201121636.142694-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201121636.142694-1-npiggin@gmail.com>
References: <20231201121636.142694-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

Reviewed-by: Cédric Le Goater <clg@kaod.org>
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


