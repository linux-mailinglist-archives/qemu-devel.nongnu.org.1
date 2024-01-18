Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D07831C1E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:14:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQU26-0002qS-2m; Thu, 18 Jan 2024 10:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU0W-0000jg-32; Thu, 18 Jan 2024 10:08:41 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU0U-0008An-F9; Thu, 18 Jan 2024 10:08:39 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d5cdb4a444so38971335ad.1; 
 Thu, 18 Jan 2024 07:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590516; x=1706195316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ooQJ6uHYwAgBkZWiyBocoGTq2xThpOfp5kB1ww8K8as=;
 b=V23TxaCBfTMOIuuRL9I6ej5ymLmPq63fc6+YWqGU9s38XXqKHMU0zOy1FzZD/Bt46y
 BD3o3BTBuaPouGaVEYELbxrDuckzFPxtaOHk5Oe0SG4h0kJZyfpxoOf4V0J7aZv8HNxR
 31rKm9Vn/HEBtjXet3OBna8Z6BaOqxv6L73D5k39vDI1mE1kocyJQids7Sixjc4zl+VI
 txgTG5CNsutWAapAjIBjTxTbtLXje1lSUBLkgon9SGWcohDCZRaA57aCbqOx0RmaQO9F
 yLPPyu7nx3OZfs6A3CZPdcJxOvJgnutsOqXobB0XCAkB61ZgiIJYW5QcC1xug96QHztc
 1w+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590516; x=1706195316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ooQJ6uHYwAgBkZWiyBocoGTq2xThpOfp5kB1ww8K8as=;
 b=RD6tVeYT9EjeY2yqhyDe+7wBLPNOK0uzUwuMQGSOyIKElFAAZuE3Ph9TKhEPpOLBGK
 92j5tIEAwb4xyQD7BQTS7If6ac0qZUR5OCusbhxPgUNAYX3eROVysqXrF7kKb7BPAi05
 7oY6hOXAyq7mQNd11Ce58h/GKbmy2FPXS8JFPwz9p6+8rGsLd2m9b5Kqfj/PLLCLWcJS
 cJJWcg50gX0hc2hgF6/PxgyVkkpITIhtfym2nFCbHtOhcklpjBzOcg4iqKJMi4kOn/Hd
 eyqV7PAF46UY0k0gCrFNYowXV2SHyeYhUjaw+zbzWONQ4Oam6i8AX66mTsQ3n5NzyrLT
 O2iQ==
X-Gm-Message-State: AOJu0YyphFZSxJBFl0SxbW5lHagkLTKKOfaJzeuT1plyK2R3+cKezJr2
 9ArMOb4r3QLKOvFII9DSqwJpAbzu00UscjOXEDP1Hw+ts9AWg+O/KGuRRY9y
X-Google-Smtp-Source: AGHT+IFDqTsK1ZuUNW5RR9dIWrRZhRXPACABjuAfVA4IwL3xnsxKHdjKxq+NrE2F6bpCWD/EEfgDCg==
X-Received: by 2002:a17:902:e887:b0:1d4:79b6:101a with SMTP id
 w7-20020a170902e88700b001d479b6101amr1274422plg.41.1705590516580; 
 Thu, 18 Jan 2024 07:08:36 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:08:36 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 22/26] target/ppc: Add SMT support to simple SPRs
Date: Fri, 19 Jan 2024 01:06:40 +1000
Message-ID: <20240118150644.177371-23-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
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

AMOR, MMCRC, HRMOR, TSCR, HMEER, RPR SPRs are per-core or per-LPAR
registers with simple (generic) implementations.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index a479c122d3..0a42e14338 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -246,7 +246,7 @@ static void register_amr_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_AMOR, "AMOR",
                     SPR_NOACCESS, SPR_NOACCESS,
                     SPR_NOACCESS, SPR_NOACCESS,
-                    &spr_read_generic, &spr_write_generic,
+                    &spr_read_generic, &spr_core_lpar_write_generic,
                     0);
 #endif /* !CONFIG_USER_ONLY */
 }
@@ -5400,7 +5400,7 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_MMCRC, "MMCRC",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic32,
+                 &spr_read_generic, &spr_core_write_generic32,
                  0x00000000);
     spr_register_hv(env, SPR_MMCRH, "MMCRH",
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -5440,7 +5440,7 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_HRMOR, "HRMOR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
+                 &spr_read_generic, &spr_core_write_generic,
                  0x00000000);
 }
 
@@ -5668,7 +5668,7 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_TSCR, "TSCR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic32,
+                 &spr_read_generic, &spr_core_write_generic32,
                  0x00000000);
     spr_register_hv(env, SPR_HMER, "HMER",
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -5678,7 +5678,7 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_HMEER, "HMEER",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
+                 &spr_read_generic, &spr_core_write_generic,
                  0x00000000);
     spr_register_hv(env, SPR_TFMR, "TFMR",
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -5754,7 +5754,7 @@ static void register_power8_rpr_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_RPR, "RPR",
                     SPR_NOACCESS, SPR_NOACCESS,
                     SPR_NOACCESS, SPR_NOACCESS,
-                    &spr_read_generic, &spr_write_generic,
+                    &spr_read_generic, &spr_core_write_generic,
                     0x00000103070F1F3F);
 #endif
 }
-- 
2.42.0


