Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4D874335A
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 05:57:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF5F3-0008JJ-On; Thu, 29 Jun 2023 23:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qF5Ey-0008H8-CT; Thu, 29 Jun 2023 23:56:12 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qF5Ev-00023x-GR; Thu, 29 Jun 2023 23:56:12 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5636426c1b3so875588eaf.1; 
 Thu, 29 Jun 2023 20:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688097363; x=1690689363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HdyqwSG21wTwZ4cu1DuC0qeGTIiHIj6/66NCJsv9PoQ=;
 b=sT/NCZkYPcd1I/coRu0C2DqPVBnmZzxjLSzhT5FBWAQCJ8j5u9TPg5wu/mUct1BWtH
 qVuUHQPgMmsF+n3YBmHlb1O+FKAQiKV9F7Ysar6rPXn7xMCJkFHWXYehl9g+zvNujmwY
 tsk2N26FB48ehWjs/sP14fLvzFsEkE85t6u5ec1KGTAcy7Lm2f9HWbbE+p3Hx0QmaxLq
 4tj+Ij09+Jvrbra1YaT1UyHQtB5ACs01xpqCsQPNerLK+o3L9InGacHe30H4mRV+Cbi1
 IXSss/Tf/0GsUWGt6RO/vC4LNGvX2FodT+fmfVt+fPqudx1mXe14QqYqapriIZN//dEN
 W5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688097363; x=1690689363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HdyqwSG21wTwZ4cu1DuC0qeGTIiHIj6/66NCJsv9PoQ=;
 b=gtu62ucTy0EEg5qsSY7pNsjC9jNgoX0RfeTf4K2sYttA+A0nbTsIHF+da6HTJ8tPYI
 2K0XFLUPfHXaOQ5PrOAss8Rxkbv6B4eaca3XuL1BWQAANrLgFQJUXm8WZsY9vUrTNoZ+
 BPApYDFb8yg1pqnwkZ5wIRYRvZCRRGkOu4bN2IFOd36vJGjAHJ0rl4pq6/b51lMNOKE0
 ZjaXncD8dl+uw+12SvIF7nLBEbaCls7aRDrIb/WvcxV9sUkjKGn8lgKW2fni3L9GNBzu
 RmmHVym5irbLjn9cvULEu9EHJYXP/pJJ2NAiZvkm+lhm7IyOOIDbciYkOTm45GTiTXMi
 J8NQ==
X-Gm-Message-State: ABy/qLaeItFOHX3VKFB6JOQzKfhrdvRxMIxTRYgMfz5SbcqrOL0IQmwY
 49l2kZ9I0/Wwz5mVcCUJr0KwNlinoMY=
X-Google-Smtp-Source: APBJJlHZmjdHfWVdoAk6IURdl1GZnplDdFdflhT0FUjd4ayk/8UoPEBzW9ojNKZsqPgCXaS05+J3vg==
X-Received: by 2002:a05:6871:288:b0:1b0:4ee7:a753 with SMTP id
 i8-20020a056871028800b001b04ee7a753mr2345677oae.37.1688097363354; 
 Thu, 29 Jun 2023 20:56:03 -0700 (PDT)
Received: from voyager.lan ([45.124.203.15]) by smtp.gmail.com with ESMTPSA id
 29-20020a17090a195d00b0025ef39c0f87sm10639290pjh.0.2023.06.29.20.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 20:56:02 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH 1/4] ppc/pnv: quad xscom callbacks are P9 specific
Date: Fri, 30 Jun 2023 13:25:44 +0930
Message-Id: <20230630035547.80329-2-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230630035547.80329-1-joel@jms.id.au>
References: <20230630035547.80329-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=joel.stan@gmail.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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

Rename the to include P9 in the name in preparation for adding P10
versions.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/ppc/pnv_core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 0bc3ad41c81c..0b1c3cccfebc 100644
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
@@ -379,8 +379,8 @@ static uint64_t pnv_quad_xscom_read(void *opaque, hwaddr addr,
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


