Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2E5831B21
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:11:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQT6F-00059L-Kv; Thu, 18 Jan 2024 09:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQT6D-00058x-Hg; Thu, 18 Jan 2024 09:10:29 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQT6B-0000uU-Nd; Thu, 18 Jan 2024 09:10:29 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6dac225bf42so6606938b3a.0; 
 Thu, 18 Jan 2024 06:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705587026; x=1706191826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cSs51jCTaxuPt7JZH7N+SR57yUi0hzkGNoCB45S0rmY=;
 b=QieSQB+PwJ7pvMzwK+A8mJaMS3vbANHaFexgn3F3jvBKV1QOYmwpL6Mbc4sZs3b2Nh
 EjqioPRrEBT/fKsvC1a6Ti8Epj21Ld5+BIpmqWrLclYrsl6WFwXgW2RmoNIiMyncoOP+
 LxOI5xZlZ/s8qLmh4ILlsdl2yQ+B/tiXm5tnsJ6PElnKbjUyu0m36FYZM9NLl1RLGhXn
 Klh+xysedsV5VvVwMdZTDK7cKDAu+azXV6AWEGyQHd3u5dOvzXQNbZrr/I9Uun4QT2Uh
 lgFt0ASqzDyWqEPM50Bu7m7/Q5WzympXenoLew/w9aHkcSrgAFA9+GHLg2mMCwq3qUVj
 BIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705587026; x=1706191826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cSs51jCTaxuPt7JZH7N+SR57yUi0hzkGNoCB45S0rmY=;
 b=usP4XCAbMQphtOmUx4XNxGvsz2CqBXZpjpp/WQ5lPLwg4Bg2yLSO7CjGcIBv94Y6so
 YJqLskZG/yFNor7T2lQvtJSQUnOwUtko0ABhW33blfIaaF+oyGgnCbg/624GIqL0lkBk
 ag/xTTmZgQudOsJoiV6v3ppdNcGkzzO7aWMsSv0x9+DXvzA6Bd3HDA6EsgVHli+RjE+s
 vsA7ZkSc+q2mT8Z6rCRA17rW3hNZ0U2q0j7yMpRhUe/bHmxozWsWWNayhFafPTytx9Oz
 fKOok8OlxGdpH18d5t01bX8FKX1CRhF13EjfMyi3YDL3JMK7LlClC+wZ3vJ7a4/ILNCZ
 5NUA==
X-Gm-Message-State: AOJu0YxO6AjK/uEMPsJgx5QWk0J2aSxpVIsFJK/4WVQu+x2LH6sZ3mVC
 /lw3fIqRfzaqSHr+bgeo9Nvv2fMDhkglm+Zk2ipf+Au4UnX/YaU3NC60OlLe
X-Google-Smtp-Source: AGHT+IGi0P1WdUd210usWT5ODKorGBOrtFAjNLtcicN14e33ImXjg/Pjy0lD1KUUrQXV19TK4NFuOA==
X-Received: by 2002:a05:6a00:2d01:b0:6d9:b8e3:8f28 with SMTP id
 fa1-20020a056a002d0100b006d9b8e38f28mr1058381pfb.44.1705587026030; 
 Thu, 18 Jan 2024 06:10:26 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a62be12000000b006db3149eacasm3323336pff.104.2024.01.18.06.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:10:25 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 5/8] ppc/spapr: Add pa-features for POWER10 machines
Date: Fri, 19 Jan 2024 00:09:39 +1000
Message-ID: <20240118140942.164319-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118140942.164319-1-npiggin@gmail.com>
References: <20240118140942.164319-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1e1946de59..2f58d8f292 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -265,6 +265,36 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
         /* 60: NM atomic, 62: RNG */
         0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
     };
+    /* 3.1 removes SAO, HTM support */
+    uint8_t pa_features_31[] = { 74, 0,
+        /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
+        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
+        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
+        /* 6: DS207 */
+        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
+        /* 16: Vector */
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
+        /* 18: Vec. Scalar, 20: Vec. XOR */
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
+        /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
+        /* 32: LE atomic, 34: EBB + ext EBB */
+        0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
+        /* 38: Copy/Paste, 40: Radix MMU */
+        0x00, 0x00, 0x80, 0x00, 0x80, 0x00, /* 36 - 41 */
+        /* 42: PM, 44: PC RA, 46: SC vec'd */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
+        /* 48: SIMD, 50: QP BFP, 52: String */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
+        /* 54: DecFP, 56: DecI, 58: SHA */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
+        /* 60: NM atomic, 62: RNG */
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
+        /* 68: DEXCR[SBHE|IBRTPDUS|SRAPD|NPHIE|PHIE] */
+        0x00, 0x00, 0xce, 0x00, 0x00, 0x00, /* 66 - 71 */
+        /* 72: Hash Check */
+        0x80, 0x00, /* 73 */
+    };
     uint8_t *pa_features = NULL;
     size_t pa_size;
 
@@ -280,6 +310,10 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
         pa_features = pa_features_300;
         pa_size = sizeof(pa_features_300);
     }
+    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0, cpu->compat_pvr)) {
+        pa_features = pa_features_31;
+        pa_size = sizeof(pa_features_31);
+    }
     if (!pa_features) {
         return;
     }
-- 
2.42.0


