Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6157F5C59
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 11:32:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r66z7-00065V-Dv; Thu, 23 Nov 2023 05:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r66z1-00060T-Er; Thu, 23 Nov 2023 05:30:55 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r66yq-0006hE-3d; Thu, 23 Nov 2023 05:30:49 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cf5901b4c8so5964275ad.1; 
 Thu, 23 Nov 2023 02:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700735437; x=1701340237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLN3173ytZytDQJzXh3TbGBGR8cSN5dnqSH5vQSBFXg=;
 b=kymaj8p82qivzfdpZcUddLzzqvaVGc97tmTa+YZa+VBY0IdEag5SM9Or55TR8CZmc9
 +1riFSfkpm9l92KlWOm5SSlLfh5hUSh/31mOaRSaBhdaAuDu+9yFGP4jwtv2FX7n6xba
 5AMJX8CPGmSiq1bm1AjpaohrZ8DOigUjQd5+q6gGcX2nqNcTaKCbZ9U4tZmqX6hmcxfB
 XIafxeXSE0I/kWyMZL7dWFAqzCgI8UqWYoknkAQe21jXPu477rW8lfbX6us5n3WefYmo
 SZqhYAIi14MFfcNlC8PbTnEQjp/XYPvfMSiA6cR5kVhGHNgC7aC0o58geAHT07Nxprt1
 Sdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700735437; x=1701340237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GLN3173ytZytDQJzXh3TbGBGR8cSN5dnqSH5vQSBFXg=;
 b=JzlHZdGXWK6K4E1neldXigRBDMN1wVPBA71s/j/TTN07/+hoyvRbfSTLHYsPPhXD0I
 iGbk2CDlWQ3gZW4eJdSvuFDwuvcw48VMrdLmaVw9WBTohLHeLC+H94ooWfN5iA3LfqeW
 RZEIqi8M27rcm4CQ7X3SNsF40LCxjjIqFZN5KAlMLNV2A/39pb+PIEvrDr60DfpdlaB1
 YxsG7lw6UPmS6ey0uBQMWtGJEawiGTy13G41LdE8/U34CrwLLX8sAZ/pn+HUcQFVlnQ7
 WPYldRC9YVHgKjl4Hq4UzLuT7p2MTJ584H0I5e7ZcWewtRSPRfLfEGVuFX3PeDTAQB8m
 1gEg==
X-Gm-Message-State: AOJu0Yw63E2gcKza2YRzOanM6BqUPRcjJ/+ad6v9Jfr7b30zHZu136nV
 GJiVDpl34F7rAb9S5HCyAlzDG3jK8oA=
X-Google-Smtp-Source: AGHT+IFsnUGWEdsR98/abcHI52xHLIsOVq0zDI9MWOUrkbg+YeT1nwFJbXiNCDPLsrYJ5np0xn4RRw==
X-Received: by 2002:a17:902:9044:b0:1cc:29ed:96ae with SMTP id
 w4-20020a170902904400b001cc29ed96aemr4911816plz.41.1700735436998; 
 Thu, 23 Nov 2023 02:30:36 -0800 (PST)
Received: from wheely.local0.net (60-240-124-93.tpgi.com.au. [60.240.124.93])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a170902d38400b001cc1dff5b86sm1009070pld.244.2023.11.23.02.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 02:30:36 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 3/7] target/ppc: Fix move-to timebase SPR access permissions
Date: Thu, 23 Nov 2023 20:30:14 +1000
Message-ID: <20231123103018.172383-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123103018.172383-1-npiggin@gmail.com>
References: <20231123103018.172383-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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


