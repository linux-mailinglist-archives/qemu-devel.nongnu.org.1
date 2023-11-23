Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D1C7F5C5A
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 11:32:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r66z4-000643-NX; Thu, 23 Nov 2023 05:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r66yf-0005qn-ET; Thu, 23 Nov 2023 05:30:37 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r66yd-0006co-T8; Thu, 23 Nov 2023 05:30:33 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cf98ffc257so347395ad.3; 
 Thu, 23 Nov 2023 02:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700735429; x=1701340229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vAfZHkGk9vxz48DJuLY5Nn6nkh7yrBPGZD6fhwC4MOM=;
 b=bLTcBSJpeM5T92OhQ3MGCoVQumupL8P620r57NfK8XK0gF6FAI9XwXVRHWdypNYtKv
 MxoQxm50JR96+53e77iirWOlJv6FqwUmvnJPnT6VEOjRfbP9it1TbYbrKra6GpTRs06e
 Bm8R4MA7e8cOFoi9wd4LnOyp/QkWkVJT6friG4bSaxxMRI7x8mZcgl501qNGv3Ani4GS
 W+m8/lWChwWy6J3jgFs0cDG+MPJHyDUEQXzRkCjc9eJ6vFN3K9pmhTV0IdtVm2xtQ8qj
 LovUWymHkKdjrjcXJiweogXHJKeFBj1gEf2CQ1kdq+rhw4IE2RdPM/N8m6BGTM3b0OnP
 KZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700735429; x=1701340229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vAfZHkGk9vxz48DJuLY5Nn6nkh7yrBPGZD6fhwC4MOM=;
 b=pb4cWH+KD9r1h7GRB9qkcrWnZwbmVGG9gT6sLsYA3WEg6FsfQEkYfcfqQxItLtPKqU
 uBLiEcX5c1C8AqMnSg/tBjWa1x/QffAbN5Xxt2+VStBBTo1Aiode1/pZL8qlnMDVFy+w
 x5GleDpHsrpiCw8sA8Q5FGwMdZ36xLUdDKLBHhQHIjBXx1CH5NHshhZRjVyjr6ZkjK4h
 p1NBBmHwJs7n8MxlauyitPTsBmR8EOfTFTuIYroeTaVsbt3gH1zsg9HljOhdO4jkv4vY
 fmOHnPx/gaE3j8Ybq+3zjMyLudUdG8Y/9qY/VBFQLv2JoglXAthk648ESrmSvNozi0oA
 zYXQ==
X-Gm-Message-State: AOJu0Yxb3LEaDflM0xZc4gggoMl68Lz7IHJL9YXsgUs1r1coM4LrV7Kx
 KuIlt2JSOPRVqhzicaQ8Iex1LdI+XHw=
X-Google-Smtp-Source: AGHT+IGdp/OGvOlKU+5ZEuqMjIobYpSuOEEGDJXXcEjl1+pDQMpnOkBGxgbH6Qa2dXLNDh68sXRe0Q==
X-Received: by 2002:a17:903:1d0:b0:1cf:665a:925 with SMTP id
 e16-20020a17090301d000b001cf665a0925mr5456543plh.38.1700735429364; 
 Thu, 23 Nov 2023 02:30:29 -0800 (PST)
Received: from wheely.local0.net (60-240-124-93.tpgi.com.au. [60.240.124.93])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a170902d38400b001cc1dff5b86sm1009070pld.244.2023.11.23.02.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 02:30:29 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 1/7] target/ppc: Rename TBL to TB on 64-bit
Date: Thu, 23 Nov 2023 20:30:12 +1000
Message-ID: <20231123103018.172383-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123103018.172383-1-npiggin@gmail.com>
References: <20231123103018.172383-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper_regs.c  | 4 ++++
 target/ppc/ppc-qmp-cmds.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index f380342d4d..8c00ed8c06 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -460,7 +460,11 @@ void register_generic_sprs(PowerPCCPU *cpu)
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
index f9acc21056..ffaff59e78 100644
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


