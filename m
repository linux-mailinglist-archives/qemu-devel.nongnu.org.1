Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B21D97C80E2
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDt5-0007bG-3E; Fri, 13 Oct 2023 04:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsW-0006nR-SM
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:41 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsS-0001ZI-Gg
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:39 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-307d20548adso1690673f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187035; x=1697791835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PzXSlWto6Dozd2Y6vU5bVUq3uMy8ag3n4bBAdj0AtWc=;
 b=WWS5iwmKTOAlvnOmkFG5ncYKbCss9VEKFT/apEgKM2sa6E2xSEzMUxLUa3CW0Ye2Iu
 zD+Q4TDYDrJSf+ibZQ/raRTILlgCfCsrwCUVhk7H5Asjl/ufl2crU98vHWmWmVK3xO2Q
 brd9VU/LSGru9+GVNjhMOq1TJadow3NYupaOBadOhzlMDeMudvq+LUi3T6HQWYWdSQr3
 azj/RLWZ4eCBNzFZUok3skbnWYWcBfaiP9cTOB+iv1hNc4mclBg5q43imE/mWC3/xydq
 1jwlNRqyQ6yIpFw2e0nUjUI+vwNWkhZaZDEQ+67zeYObi4WP+k8pYww+cATSRgHvgW70
 NgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187035; x=1697791835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PzXSlWto6Dozd2Y6vU5bVUq3uMy8ag3n4bBAdj0AtWc=;
 b=YCkLgRlsAe44VZHO8qe6Q3okNaVLC3talujISGMsRLmjyXy0cchXZQaLx+q4N6GKOd
 b3GVn1BZwmY/wI77Jq9CGPEGBguEG6zm1xfHgw07nFBxbpYQFyGrYU3KNdeJvohHrt0x
 PL68c9CxDicVpvZuaARl3SmbXSWy3iZgSuK4YUZf+gJw+EnBKww4EaIPikrfEEf4o0eS
 iJzMlMrOeT2V4HdLn5Z1l+BLNkIATmbhVDEPB3pqzoTTdl0E4zcv6bDo83V3uUOx+K4P
 ZR1WVXf/ro5SyIzRl5D6aEz3CyCi7Oa47S7aFDbwZZT2SX7dyVZosl5I8iSywIjig4Ph
 gLHQ==
X-Gm-Message-State: AOJu0YzcCeU2cxbntOGwy0Lx3ihwh7/hlABnMU8odNJJ6ttngD9ksJ9a
 cCRlJHmg+X2alSAnriEYlBzRDTqaLXYnssMvIFM=
X-Google-Smtp-Source: AGHT+IGpmgETiGO0TtvSHROnHxvsFNajt5SSqAKI5FMC5kteWa5kSDqODbyyg6BVHDPrLtecgZpXqg==
X-Received: by 2002:adf:a487:0:b0:32d:6c35:db55 with SMTP id
 g7-20020adfa487000000b0032d6c35db55mr8027921wrb.29.1697187034908; 
 Fri, 13 Oct 2023 01:50:34 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:34 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org (open list:nvme)
Subject: [RFC PATCH v3 65/78] hw/nvme: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:33 +0300
Message-Id: <82f908be2888b88fd93f1c5531f54d25d1da1a59.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/nvme/ctrl.c | 24 ++++++++++++------------
 hw/nvme/dif.c  |  4 ++--
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f026245d1e..acb2012fb9 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1918,7 +1918,7 @@ static uint16_t nvme_zrm_finish(NvmeNamespace *ns, NvmeZone *zone)
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
         nvme_aor_dec_open(ns);
-        /* fallthrough */
+        fallthrough;
     case NVME_ZONE_STATE_CLOSED:
         nvme_aor_dec_active(ns);
 
@@ -1929,7 +1929,7 @@ static uint16_t nvme_zrm_finish(NvmeNamespace *ns, NvmeZone *zone)
             }
         }
 
-        /* fallthrough */
+        fallthrough;
     case NVME_ZONE_STATE_EMPTY:
         nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_FULL);
         return NVME_SUCCESS;
@@ -1946,7 +1946,7 @@ static uint16_t nvme_zrm_close(NvmeNamespace *ns, NvmeZone *zone)
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
         nvme_aor_dec_open(ns);
         nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_CLOSED);
-        /* fall through */
+        fallthrough;
     case NVME_ZONE_STATE_CLOSED:
         return NVME_SUCCESS;
 
@@ -1961,7 +1961,7 @@ static uint16_t nvme_zrm_reset(NvmeNamespace *ns, NvmeZone *zone)
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
         nvme_aor_dec_open(ns);
-        /* fallthrough */
+        fallthrough;
     case NVME_ZONE_STATE_CLOSED:
         nvme_aor_dec_active(ns);
 
@@ -1971,12 +1971,12 @@ static uint16_t nvme_zrm_reset(NvmeNamespace *ns, NvmeZone *zone)
             }
         }
 
-        /* fallthrough */
+        fallthrough;
     case NVME_ZONE_STATE_FULL:
         zone->w_ptr = zone->d.zslba;
         zone->d.wp = zone->w_ptr;
         nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_EMPTY);
-        /* fallthrough */
+        fallthrough;
     case NVME_ZONE_STATE_EMPTY:
         return NVME_SUCCESS;
 
@@ -2017,7 +2017,7 @@ static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, NvmeNamespace *ns,
     case NVME_ZONE_STATE_EMPTY:
         act = 1;
 
-        /* fallthrough */
+        fallthrough;
 
     case NVME_ZONE_STATE_CLOSED:
         if (n->params.auto_transition_zones) {
@@ -2040,7 +2040,7 @@ static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, NvmeNamespace *ns,
             return NVME_SUCCESS;
         }
 
-        /* fallthrough */
+        fallthrough;
 
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
         if (flags & NVME_ZRM_AUTO) {
@@ -2049,7 +2049,7 @@ static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, NvmeNamespace *ns,
 
         nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_EXPLICITLY_OPEN);
 
-        /* fallthrough */
+        fallthrough;
 
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
         if (flags & NVME_ZRM_ZRWA) {
@@ -3582,7 +3582,7 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
                     return NVME_INVALID_PROT_INFO | NVME_DNR;
                 }
 
-                /* fallthrough */
+                fallthrough;
 
             case NVME_ID_NS_DPS_TYPE_2:
                 if (piremap) {
@@ -3737,7 +3737,7 @@ static uint16_t nvme_offline_zone(NvmeNamespace *ns, NvmeZone *zone,
     switch (state) {
     case NVME_ZONE_STATE_READ_ONLY:
         nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_OFFLINE);
-        /* fall through */
+        fallthrough;
     case NVME_ZONE_STATE_OFFLINE:
         return NVME_SUCCESS;
     default:
@@ -4914,7 +4914,7 @@ static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint8_t csi, uint32_t buf_len,
     switch (NVME_CC_CSS(ldl_le_p(&n->bar.cc))) {
     case NVME_CC_CSS_NVM:
         src_iocs = nvme_cse_iocs_nvm;
-        /* fall through */
+        fallthrough;
     case NVME_CC_CSS_ADMIN_ONLY:
         break;
     case NVME_CC_CSS_CSI:
diff --git a/hw/nvme/dif.c b/hw/nvme/dif.c
index 01b19c3373..00dd96bdb3 100644
--- a/hw/nvme/dif.c
+++ b/hw/nvme/dif.c
@@ -161,7 +161,7 @@ static uint16_t nvme_dif_prchk_crc16(NvmeNamespace *ns, NvmeDifTuple *dif,
             break;
         }
 
-        /* fallthrough */
+        fallthrough;
     case NVME_ID_NS_DPS_TYPE_1:
     case NVME_ID_NS_DPS_TYPE_2:
         if (be16_to_cpu(dif->g16.apptag) != 0xffff) {
@@ -229,7 +229,7 @@ static uint16_t nvme_dif_prchk_crc64(NvmeNamespace *ns, NvmeDifTuple *dif,
             break;
         }
 
-        /* fallthrough */
+        fallthrough;
     case NVME_ID_NS_DPS_TYPE_1:
     case NVME_ID_NS_DPS_TYPE_2:
         if (be16_to_cpu(dif->g64.apptag) != 0xffff) {
-- 
2.39.2


