Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC87746919
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 07:43:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGYoD-0003U5-Lr; Tue, 04 Jul 2023 01:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qGYnx-0003PZ-MU; Tue, 04 Jul 2023 01:42:26 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qGYns-00045S-Rr; Tue, 04 Jul 2023 01:42:23 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1b8033987baso31214055ad.0; 
 Mon, 03 Jul 2023 22:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688449338; x=1691041338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7eoUd+iblNvNzIFTkrpWth12Z0eS/m6oGNV7VBXjms=;
 b=FtS3Mme61xbr9JohVKHc8tXV6o9aM949Yx+RRakjCPugcDeFzuWa/ZTfeL+O9AOxhS
 BsLyl9YBzcH18Vw3rc1mhucBIZGJRm8/N/cjsVoSvGAkaktitTKsH1fm4AffxnHtmEp1
 0sc87VfyuLcw+EKvvXf9qGavOf8NlrMfMRkcVmtLHprb8dmxPtvJ0QlBma5Qvg136GNA
 Ifm19qPCMDgkS1VHFo5ev4Bp9aEyV3mRrdpczTF6wLhAEWVYJCAQ8SIIROCtRLG+wbAO
 nVYtlJSE45t1Y2Ms2d9iteWGrzKq9gU8YdJIvlV5m5UySOH1sf189CNNotdVEgIKaE/t
 jy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688449338; x=1691041338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q7eoUd+iblNvNzIFTkrpWth12Z0eS/m6oGNV7VBXjms=;
 b=LdbjzCxtPuNtouyMTtscIvPCk+p2MkC0MjnxFOW/tJ8gLLvE1MLk/+3R09t9OxgV+C
 o5ryd8EpFdUiV67geXm4Od8oUDb3pyjRRGcWLC/tz7fHK3CwpJl7chr+QWkMXGn4ozPU
 hp4g70KtaNN689kHti8oIlkIsZQ67aOg5J8+t/2TRZfGct81ieo8KMmMpw0n1r3hmb7B
 /ltKE7FSq/Et9iDvYelez126OFW1TQmkJmATQ9YseYCmEslVGYFw6Dmp8j101oO3iPH1
 7Z2pjariypEBZbDcfxwWQj99pD9xHNxFznlquTQ2hLuTYsNFS/nIxUZG7Ksd8ysx2IVN
 sWeQ==
X-Gm-Message-State: ABy/qLZCnjLjTQDFBhSSzPFw/UHWjDU0pNNQFBygQb15mGssjH2QnaRQ
 SFSVTMZPoN3nngYOuR5nf4U=
X-Google-Smtp-Source: APBJJlHEU6nTRQrnvWwkgQDEBPInw5K7GA3+PYa2S3cH4hhgDmtt3rOL35smoHU6ShPeJr7Jyy56qg==
X-Received: by 2002:a17:902:d4ca:b0:1b8:224f:e823 with SMTP id
 o10-20020a170902d4ca00b001b8224fe823mr19794904plg.7.1688449338529; 
 Mon, 03 Jul 2023 22:42:18 -0700 (PDT)
Received: from localhost.localdomain
 (2403-5808-8af8-0-7926-51ea-3ff2-71dd.ip6.aussiebb.net.
 [2403:5808:8af8:0:7926:51ea:3ff2:71dd])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a17090311c900b001ae59169f05sm16261879plh.182.2023.07.03.22.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 22:42:17 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 1/5] ppc/pnv: quad xscom callbacks are P9 specific
Date: Tue,  4 Jul 2023 15:12:00 +0930
Message-Id: <20230704054204.168547-2-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230704054204.168547-1-joel@jms.id.au>
References: <20230704054204.168547-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Rename the functions to include P9 in the name in preparation for adding
P10 versions.

Correct the unimp read message while we're changing the function.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: Fix unimp print, and grammar in the commit message
---
 hw/ppc/pnv_core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 0bc3ad41c81c..0f451b3b6e1f 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -360,8 +360,8 @@ DEFINE_TYPES(pnv_core_infos)
 
 #define P9X_EX_NCU_SPEC_BAR                     0x11010
 
-static uint64_t pnv_quad_xscom_read(void *opaque, hwaddr addr,
-                                    unsigned int width)
+static uint64_t pnv_quad_power9_xscom_read(void *opaque, hwaddr addr,
+                                           unsigned int width)
 {
     uint32_t offset = addr >> 3;
     uint64_t val = -1;
@@ -372,15 +372,15 @@ static uint64_t pnv_quad_xscom_read(void *opaque, hwaddr addr,
         val = 0;
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
+        qemu_log_mask(LOG_UNIMP, "%s: reading @0x%08x\n", __func__,
                       offset);
     }
 
     return val;
 }
 
-static void pnv_quad_xscom_write(void *opaque, hwaddr addr, uint64_t val,
-                                 unsigned int width)
+static void pnv_quad_power9_xscom_write(void *opaque, hwaddr addr, uint64_t val,
+                                        unsigned int width)
 {
     uint32_t offset = addr >> 3;
 
@@ -394,9 +394,9 @@ static void pnv_quad_xscom_write(void *opaque, hwaddr addr, uint64_t val,
     }
 }
 
-static const MemoryRegionOps pnv_quad_xscom_ops = {
-    .read = pnv_quad_xscom_read,
-    .write = pnv_quad_xscom_write,
+static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
+    .read = pnv_quad_power9_xscom_read,
+    .write = pnv_quad_power9_xscom_write,
     .valid.min_access_size = 8,
     .valid.max_access_size = 8,
     .impl.min_access_size = 8,
@@ -410,7 +410,8 @@ static void pnv_quad_realize(DeviceState *dev, Error **errp)
     char name[32];
 
     snprintf(name, sizeof(name), "xscom-quad.%d", eq->quad_id);
-    pnv_xscom_region_init(&eq->xscom_regs, OBJECT(dev), &pnv_quad_xscom_ops,
+    pnv_xscom_region_init(&eq->xscom_regs, OBJECT(dev),
+                          &pnv_quad_power9_xscom_ops,
                           eq, name, PNV9_XSCOM_EQ_SIZE);
 }
 
-- 
2.40.1


