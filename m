Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB907831B26
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:12:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQT64-0004zr-Kv; Thu, 18 Jan 2024 09:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQT60-0004w4-Ho; Thu, 18 Jan 2024 09:10:16 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQT5x-0000sM-DC; Thu, 18 Jan 2024 09:10:16 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6daf9d5f111so10063497b3a.0; 
 Thu, 18 Jan 2024 06:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705587009; x=1706191809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nhpTemOWW0eKHDpq5+DOtRyqlGrRk4XHyHUl6XdyOQg=;
 b=QuBI/6bMHEQK5zDytw3GG0YM98WmxM8JrOmZ5efVWXrPSSiMewRZy4JkITqRlWTKfz
 gGzR4g72s/e3YTtmk5Gu5SPkIQWkFo6YK2/8I/irAo2F0Ey5sTxpmJPIiDdh+FsHarsE
 IUvBoroc43dHpMELXiOiGDiokRjeSrAREDGsVko6+UO5GBx/4D9PmcvWkyJ5G4kf2PJg
 TCWmFx2u7Xn3VigIPLC+Pyt3aZ/jaMag8qyRgCbm7ZWSKBX1MlPOPAv/I9LLUIukOrAu
 tjQSNoH0V2lIakBovplJMxuOMQoHKsd6KSi7hPY7xZNgxDwUB8y4D/389+Bdbqt321CG
 HehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705587009; x=1706191809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nhpTemOWW0eKHDpq5+DOtRyqlGrRk4XHyHUl6XdyOQg=;
 b=UXaaz/AwKXZENmgfV7KPumWXP3mkZokhiLwRHWKxfOguzPXa2g8gVGV13gxdRaQwaY
 5Ad4VRG2fjx8b3PwOI0/doOviZqa0Ulxi04Fw416eFKHNaQrgvlSVlPPhwG4MTbcyKu/
 YE8ZlZ0GD99M3iWrniyebpb417xF2fjI6PTZTZSfiZfe3BCGsjCn3oBegpYTC2x2Z7m7
 i4+9jW/HF4r4oPDywq3Fu6F+N3RBG2VjX4AiCaZy2w96SZphS7P5r02Zou2YtxQMiqzs
 vx4pJu6fRSkWouL3mjE+G8TA1GS+VGXTzrLxxAggXGhfzGZn+GsiqF8hUCrLEzaP9MKm
 l90A==
X-Gm-Message-State: AOJu0Yy6loH/ugvoa/BXuDRmaG4eZwtG9sKxOLTx9c/B/qBfDbHLCGcc
 FBUJaA9lpaA7c0K/PB9DDmySdh/uwdRR76cty/2bW1S81BkiNwy3A39W60s3
X-Google-Smtp-Source: AGHT+IGqkm8TEsTCatBIJ00Pm71wtHkVQVuS4duKAcUbqmzGpJ0hOE/Ep/h8seQlGRv5MJk/0KMNOA==
X-Received: by 2002:a05:6a21:999b:b0:19a:fd2b:5a75 with SMTP id
 ve27-20020a056a21999b00b0019afd2b5a75mr942555pzb.3.1705587009490; 
 Thu, 18 Jan 2024 06:10:09 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a62be12000000b006db3149eacasm3323336pff.104.2024.01.18.06.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:10:09 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 1/8] target/ppc: POWER10 does not have transactional memory
Date: Fri, 19 Jan 2024 00:09:35 +1000
Message-ID: <20240118140942.164319-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118140942.164319-1-npiggin@gmail.com>
References: <20240118140942.164319-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

POWER10 hardware implements a degenerate transactional memory facility
in POWER8/9 PCR compatibility modes to permit migration from older
CPUs, but POWER10 / ISA v3.1 mode does not support it so the CPU model
should not support it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 9df606d523..5c1d0adca8 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6576,7 +6576,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
                         PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
                         PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
                         PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
-                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310 |
+                        PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310 |
                         PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206;
     pcc->msr_mask = (1ull << MSR_SF) |
                     (1ull << MSR_HV) |
@@ -6620,7 +6620,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
     pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
                  POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
                  POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
-                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
+                 POWERPC_FLAG_VSX | POWERPC_FLAG_SCV;
     pcc->l1_dcache_size = 0x8000;
     pcc->l1_icache_size = 0x8000;
 }
-- 
2.42.0


