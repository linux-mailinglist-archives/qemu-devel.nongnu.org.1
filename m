Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEF8747B10
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 03:29:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGrJA-0003SF-Cv; Tue, 04 Jul 2023 21:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGrJ8-0003RM-93; Tue, 04 Jul 2023 21:27:50 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGrJ6-0004Hy-Og; Tue, 04 Jul 2023 21:27:50 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5634d8d1db0so4168686eaf.0; 
 Tue, 04 Jul 2023 18:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688520467; x=1691112467;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2IGSmC6XzpLnFvRCArLOhSytR3jbi3nhXMUdZjC9M/o=;
 b=TbUMBAYRY3X7nzV8lu7NCmzdAexOFj3Dypys8le8OxU283v6GSHLzxNuFArnS7TbbU
 ye/E4Vp/170sLdU1L21gmZiJN/z0esUGponbO+TJV12HQwyFlT6UDR9noMCCl/txerRu
 YwWvzK4Dj0qjvv1jZIAL/Dvl+afsODafvvNkTDYZbpNSzEPNr0yylI/6kiTFoY3OR+qv
 GRRwRHGtfX3fu0CSe3U6+4f396XB4y51sBKOwZrwgco0wHnyrjOhskRyoGmh1pJROx2F
 rZBvWDJkPmfODV/tEoDPHuA2ujy0c3znQmj+Q4liVLuEUImEOt/YvmsN63DICkDg+kWa
 JVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688520467; x=1691112467;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2IGSmC6XzpLnFvRCArLOhSytR3jbi3nhXMUdZjC9M/o=;
 b=PWn5SKpJwRTM8y0H0jg2XWe+nItC2yI++sXGxIvfvvipMkCj0gQIubZP4/igQt3yRE
 0je47pOrRuXcQ9NhXwtqRZu/i5a5ylD3cnY/HK5xVVL7DUabFw0xDasTr47t0ElsJUZ2
 yavrl+dQ3ebsse9asItl7qZHqvjjHuzcAgaywPPXwdb/mG3sXEdN6WpwagEcWpeIqfeP
 vWCxVenwIlG43efw8Dq+IOQKaiM7b91U6854/Yaa72e5LWIxkhkT+HzTlOSBEa6rn76C
 juU1Ps+DnY/ZJetKPJbnkk2LgStSaxyX2mLJsgHsk+e/tWYBq0rOEZ4AFeGcDenh1BRO
 1v4g==
X-Gm-Message-State: ABy/qLYOhw1oFJ0XrSoSkmzwdpHTyYowbkEZuLelf8DCTFSL8x5GGdSr
 58hzut3i+HXKQ48b8jitYwU=
X-Google-Smtp-Source: APBJJlHzHCRsyQ9y3pWggLoP9Rw6iMIQbLpF8R4h6yjigq4j4xS3L+MwaKRTVKSfx1k6DQSYhWhNpQ==
X-Received: by 2002:a05:6358:f5c:b0:135:2309:c3bd with SMTP id
 c28-20020a0563580f5c00b001352309c3bdmr2714101rwj.15.1688520466711; 
 Tue, 04 Jul 2023 18:27:46 -0700 (PDT)
Received: from wheely.local0.net ([61.68.2.145])
 by smtp.gmail.com with ESMTPSA id
 y19-20020aa78553000000b0066f37665a63sm11641678pfn.73.2023.07.04.18.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 18:27:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH] ppc/pnv: Set P10 core xscom region size to match hardware
Date: Wed,  5 Jul 2023 11:27:36 +1000
Message-Id: <20230705012736.20020-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc2c.google.com
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

The P10 core xscom memory regions overlap because the size is wrong.
The P10 core+L2 xscom region size is allocated as 0x1000 (with some
unused ranges). "EC" is used as a closer match, as "EX" includes L3
which has a disjoint xscom range that would require a different
region if it were implemented.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_core.c          | 3 +--
 include/hw/ppc/pnv_xscom.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index b7223bb445..ffbc29cbf4 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -299,9 +299,8 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
     }
 
     snprintf(name, sizeof(name), "xscom-core.%d", cc->core_id);
-    /* TODO: check PNV_XSCOM_EX_SIZE for p10 */
     pnv_xscom_region_init(&pc->xscom_regs, OBJECT(dev), pcc->xscom_ops,
-                          pc, name, PNV_XSCOM_EX_SIZE);
+                          pc, name, PNV10_XSCOM_EC_SIZE);
 
     qemu_register_reset(pnv_core_reset, pc);
     return;
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index f7da9a1dc6..a4c9d95dc5 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -133,7 +133,7 @@ struct PnvXScomInterfaceClass {
 
 #define PNV10_XSCOM_EC_BASE(core) \
     ((uint64_t) PNV10_XSCOM_EQ_BASE(core) | PNV10_XSCOM_EC(core & 0x3))
-#define PNV10_XSCOM_EC_SIZE        0x100000
+#define PNV10_XSCOM_EC_SIZE        0x1000
 
 #define PNV10_XSCOM_PSIHB_BASE     0x3011D00
 #define PNV10_XSCOM_PSIHB_SIZE     0x100
-- 
2.40.1


