Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF2A831C08
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:09:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTzW-0007eh-Qw; Thu, 18 Jan 2024 10:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTzV-0007ay-3w; Thu, 18 Jan 2024 10:07:37 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTzT-00082P-DO; Thu, 18 Jan 2024 10:07:36 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d5cdb4a444so38963585ad.1; 
 Thu, 18 Jan 2024 07:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590453; x=1706195253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5CDxYZCUiWvKFx47cxZtJKz1K9wTPn4qMj5HdK/Feg=;
 b=KCJOo8ocu9S/057duWH9PGAIwvi9FiMGxhyshGM5tOkxkxKpNVQehEg+tkhWlMfRSP
 +JOlVf3o855uEzpNjEv/pp2zN8X4bXDVXkj5extH3JX/M8+YiL9ZMreBfXGXIMDYiWOR
 pMzlwJb75ilrSTFVFXqgHTwkJjl0BsHnCHHXv9lNniOylkq9/IdJqFE+3APV/N6SRJnL
 KSOnJu6z01m0e6uV9Lf/Jn2PbkYCoHKl8Dy7ADvgDyjhz9vPVrfAOblmVYhB2xGaG9Nz
 WSU+zBmVEaYcUYJ36BGGSykIhH3CZsSQFNrtfg5//3LxlgkmIfQK5eL6JmuLib65veZK
 D7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590453; x=1706195253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t5CDxYZCUiWvKFx47cxZtJKz1K9wTPn4qMj5HdK/Feg=;
 b=VxRMI8LfRiOwKerC+NcAE2oZY94qrmHpGQlZ0JRwSa/qgXXMcODNPR4mmCS+OKbdT7
 w0tzgA2XmS8h7qOaJFG82mH5STmyHK15Zx+QhvT+L5j52TTZ89Lm0Fc62HDoRRchtny8
 0iizzZPtRoACxqhdgJ2Qkua18iHuiC2RTb/xC4+pFV9SCcSMND8K1ToFuQ0iRp25GSsf
 YcSyseS5ssGpAb5ZyIASz9HUc8B41U22tSi2PC14gYQH4HvddoIN1hYqbeyDzgddvmrN
 GS53E3h+7/KXjGYEez37eNcSOd/qTpAsVd9eqF0ZKdYtqsrqkmWH0xik7VcsQO6VxDEo
 qLGw==
X-Gm-Message-State: AOJu0Yyu6HkpipgTKBnoQ+8lGKbOTDN4hzFX1YC+FTIqLyWlqWJoYeWc
 OjRn/oHy459n8YdMVGl9n2tc5v2WTVvdyIhN/iJkaY3fUic/KSRt/LeVAl/Z
X-Google-Smtp-Source: AGHT+IFUA8W9BrfkJZH8EGw+TlICUZQCjmQ7kvSYXkmQqW1K4iRIjShcy9F35ZzE3zy7l7L4ikBIiA==
X-Received: by 2002:a17:902:7581:b0:1d4:b50d:dba9 with SMTP id
 j1-20020a170902758100b001d4b50ddba9mr1072233pll.71.1705590453307; 
 Thu, 18 Jan 2024 07:07:33 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:07:33 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 08/26] target/ppc: Fix move-to timebase SPR access permissions
Date: Fri, 19 Jan 2024 01:06:26 +1000
Message-ID: <20240118150644.177371-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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
index ead4acede4..25258986e3 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -473,18 +473,33 @@ void register_generic_sprs(PowerPCCPU *cpu)
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


