Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0249831C17
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:13:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQU1J-0001ul-VS; Thu, 18 Jan 2024 10:09:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU0e-0000pb-Dy; Thu, 18 Jan 2024 10:08:49 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU0c-0008Bx-TB; Thu, 18 Jan 2024 10:08:48 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d54b765414so86155335ad.0; 
 Thu, 18 Jan 2024 07:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590525; x=1706195325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hUdj6WKY9Qn89EMql4fMiJee+5kL6htC5XUyQS2sFG0=;
 b=DEPoTfn/hk/H9L3AAfl7G8d7qOm3GVzyqV91xWb2SJzEa1CQXEL2Moegq16oGTvMj4
 GnLsSu2NZcy4fmKvCykPu6mlIpIDTR4hczSDjAKoQ+2rOENpp8RFG/nu+t/oSzumCCpn
 Z8L2kj/sO27tNn1BOpuOXJj6WdDBqL6/q02vriiWVWtPK9HUinZM/LKJN50x8G2l87Oc
 y4idTDSxj7IRZu0uUIz3G/dkJ3Q7h/ybve/PuxZVXISzIkm/DZTxAx0IJvAb0iwlVSXP
 zUSlYQIeHCngzs7QLgpTfWk3ElpYN6FIYkjCx/FyXY/yfjcvfg1BjvNLmKC9pcVgX7L0
 RohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590525; x=1706195325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hUdj6WKY9Qn89EMql4fMiJee+5kL6htC5XUyQS2sFG0=;
 b=rud17x0Qx+w5ICWIU436DmhQhUTj/MspkXzARow3idG8YkCPxYlnhN+Nf5rXBQ4zt3
 zBu/5t0AIEyiE8PBrchHLCrO9OKJHGYgxjcmKwTGzJjbXlGstV8ZqPrX46XWwOfnDKuQ
 dtA5NvkmT5IMpYEtBkRRQPkYMUBkHjMkHgODOT2Y0xU/0U3rpGjv6bD3zVgKFE4aSUym
 Kw1tPVZxAOA8GL9Yku24jVLVY+DDVDFzvXpxNBp+epBtHrREL0iQFqJNVNYpVfzIQsMl
 kxhmp9FHSXtU43APQmvLpKZ0cEniAOPNUG/tFm7UqoutNAETnJdfW6aOS/doqYt5t437
 bv4g==
X-Gm-Message-State: AOJu0YxnuhmgDbT4m3ZhaW/9CTiavCnyhmcCR8Y4KXkoxl+fGqfXW72m
 csbwTpCQRjAZcwYxOG6tt4ZXwN6Z/xehgJ1jCTUX0CQz5qR/siLimjJYSFHw
X-Google-Smtp-Source: AGHT+IE3Bk+Aapaz7hxewKTTP+NEKzaWSkYWHvD06qqjXlaZeYAv1wTqldwKpz/LMXiFKvZFRZ/lew==
X-Received: by 2002:a17:902:edc3:b0:1d6:a72:8107 with SMTP id
 q3-20020a170902edc300b001d60a728107mr956182plk.25.1705590525015; 
 Thu, 18 Jan 2024 07:08:45 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:08:44 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 24/26] target/ppc: Implement LDBAR, TTR SPRs
Date: Fri, 19 Jan 2024 01:06:42 +1000
Message-ID: <20240118150644.177371-25-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

LDBAR, TTR are a Power-specific SPRs. These simple implementations
are enough for IBM proprietary firmware for now.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h      |  2 ++
 target/ppc/cpu_init.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 8397ddaf18..b6a955b9b7 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2088,6 +2088,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_DEXCR             (0x33C)
 #define SPR_IC                (0x350)
 #define SPR_VTB               (0x351)
+#define SPR_LDBAR             (0x352)
 #define SPR_MMCRC             (0x353)
 #define SPR_PSSCR             (0x357)
 #define SPR_440_INV0          (0x370)
@@ -2134,6 +2135,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_440_IVLIM         (0x399)
 #define SPR_TSCR              (0x399)
 #define SPR_750_DMAU          (0x39A)
+#define SPR_POWER_TTR         (0x39A)
 #define SPR_750_DMAL          (0x39B)
 #define SPR_440_RSTCFG        (0x39B)
 #define SPR_BOOKE_DCDBTRL     (0x39C)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 0a42e14338..31d535d501 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5695,6 +5695,16 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
                  &spr_access_nop, &spr_write_generic,
                  &spr_access_nop, &spr_write_generic,
                  0x00000000);
+    spr_register_hv(env, SPR_LDBAR, "LDBAR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_core_lpar_write_generic,
+                 0x00000000);
+    spr_register_hv(env, SPR_POWER_TTR, "TTR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_core_write_generic,
+                 0x00000000);
 #endif
 }
 
-- 
2.42.0


