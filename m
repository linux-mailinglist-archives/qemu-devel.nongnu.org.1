Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D3C831C0C
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:10:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTzR-0007SM-9f; Thu, 18 Jan 2024 10:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTzM-0007RM-Om; Thu, 18 Jan 2024 10:07:28 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTzL-00081J-2o; Thu, 18 Jan 2024 10:07:28 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d45f182fa2so98684145ad.3; 
 Thu, 18 Jan 2024 07:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590445; x=1706195245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4m5mjUVL9rjwHlUn6uT+N1jOE8tzUY/F2A+0bElZSs=;
 b=G7XL0pG96SpsKwbxxQ/uS0NvOxH6Rnwi/nFWgshZpZCXGzsBKqGM+5jGOL5+RszcZf
 N7wNxoAGjjqONjFH5tGRkxZXIp5tFM4Tu+45wILuzMhPo4LY8Z6KxMUsk0ZpH3+GC0jO
 6Mgyj/LVDSMVGuSadgEWTCiIg4mRdZXckZ6jbTgT09D/AOWSp1NMkdvh15z7n968E4TR
 YDON3Yayvi+VY/ek39E9g8FX5ffC3FNbuZAP99aRvGAzrWsop55i6bKo3oLbQxOZqFHH
 WXGM2ZPC+Prq2QJeeUcdiLwtCzh5g84Dh+VCBYjx0C+8VKxhbi45tWkMeOiovyy19AxZ
 axzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590445; x=1706195245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y4m5mjUVL9rjwHlUn6uT+N1jOE8tzUY/F2A+0bElZSs=;
 b=ItMLbp5TYIGKZ58EoRrtvJw+6oXAkCLj0Mq6B+Gsq+zToZn2k529ug+jxqMoFIKjm8
 4rz4WOZy4bw7T9SD+/0OzgiPPGlDdH981EMNACtB0HB4xpFchuyR/nUmk7uvHi3a2uL+
 UFB73BhLRpNhdiOkoj2NlLnFawyHA2rd7RxevD9VNrtiviKbWCuXThq/FriDfqXn8jjf
 DnuTlIQFncPxzhOw/WEhP5upDK149MXdIuaqKcUWMJ+ySrSibxIu2b6r9QD8H0YVxvgF
 NfJ7yRFThnib2unm3HODeWqU1wWn7GOlEB9Gh7Gk00zwu5IM2tu9n8Clm5u4ka/HI45q
 VMOg==
X-Gm-Message-State: AOJu0YxFNN4gfVtfmJ+3Zkb4YOlOM1Gq60LWA0vdiAE0N/bNWzj4jx9A
 4jvUEBEl41oGQgMleN8S1+rVGxu2iIKqAfNO9zxYMKeW3VwhGoaJoHgWhTPG
X-Google-Smtp-Source: AGHT+IHSPraKweHcfsjeomBFjo2gg80s15k2CCHCI4JWAsxdaQfroPUAAwwly6523ixGpF2syJgZbw==
X-Received: by 2002:a17:902:e5cb:b0:1d7:af2:869b with SMTP id
 u11-20020a170902e5cb00b001d70af2869bmr900334plf.114.1705590445018; 
 Thu, 18 Jan 2024 07:07:25 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:07:24 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 06/26] target/ppc: Rename TBL to TB on 64-bit
Date: Fri, 19 Jan 2024 01:06:24 +1000
Message-ID: <20240118150644.177371-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

From the earliest PowerPC ISA, TBR (later SPR) 268 has been called TB
and accessed with mftb instruction. The problem is that TB is the name
of the 64-bit register, and 32-bit implementations can only read the
lower half with one instruction, so 268 has also been called TBL and
it does only read TBL on 32-bit.

Change SPR 268 to be called TB on 64-bit implementations.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper_regs.c  | 4 ++++
 target/ppc/ppc-qmp-cmds.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 3aea8ff8ac..7d8e041fb3 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -465,7 +465,11 @@ void register_generic_sprs(PowerPCCPU *cpu)
     }
 
     /* Time base */
+#if defined(TARGET_PPC64)
+    spr_register(env, SPR_VTBL,  "TB",
+#else
     spr_register(env, SPR_VTBL,  "TBL",
+#endif
                  &spr_read_tbl, SPR_NOACCESS,
                  &spr_read_tbl, SPR_NOACCESS,
                  0x00000000);
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index c0c137d9d7..ee0b99fce7 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -103,7 +103,11 @@ const MonitorDef monitor_defs[] = {
     { "xer", 0, &monitor_get_xer },
     { "msr", offsetof(CPUPPCState, msr) },
     { "tbu", 0, &monitor_get_tbu, },
+#if defined(TARGET_PPC64)
+    { "tb", 0, &monitor_get_tbl, },
+#else
     { "tbl", 0, &monitor_get_tbl, },
+#endif
     { NULL },
 };
 
-- 
2.42.0


