Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0B07C803C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:27:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD60-0001ip-8V; Fri, 13 Oct 2023 04:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5S-0007wi-9d
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:59 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5O-0007OM-HE
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:58 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507962561adso1371911e87.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183991; x=1697788791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QiMWjDPU72IsVNa9l2Ta4NPkoq4odvg3UORhQ7BascA=;
 b=Aj1Y83vQAO6YgzvckAe3gb62NBgi2hbuKJkg582lIkbEnwZz9mgoB8Uls8zyia1UlG
 701QP6/YH6hRakpmvg5JIFEPkDNvQbAcfg2bhC+ZP04YTfCh06uoWq2ac3eugRmrpTvU
 DPDodwaUhHLDXtJH3+uO48U5JOKNob0WDOOa7iSucXdmaqkjAwZ37JXy+yx983wYiWMS
 NJVZ2RbaZFKTFFXmNozYw6dzORCvBjIizG1pRBdWx7pdVDNYypQrgLs5IyiheAM1prSk
 2IyN2Ay3lR7cD+y+Bq0rR9uamooD2Kta3V3ecu0PK2NhhRGYif9TG3fAX+o4H+QE2ww6
 UKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183991; x=1697788791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QiMWjDPU72IsVNa9l2Ta4NPkoq4odvg3UORhQ7BascA=;
 b=geYLMG0LyETlEX106LDVpvlmtlfH+NxBcOfJ/vxtlL8Aw6cCkw1EUgiCxiw57/rl3i
 RLYyHkTqdrgAVQCyUY5g/6/L2FOV4A42rdVXoy1TYjvfGtAnCKhzpJw3BRGk8WYzJywO
 VrPgI8y2d6KSgeGy01C9byKWgqre3XPHyXqELK+cyqb4FYpYlb7wNDVzbl6VY5JmzWoL
 gt2DhXYG1z8SC8EXpJ83uYtKS67KfDL2RADmjbTQ4KJCkDUrMGYDF8LsA4GMAnWXE8ay
 8Wu2MqAYkudwssWY3PvEFd6lmwVwoh1bhBOLQSCvQNTLvErPoY+Igxozf0msCAwEnP3U
 6ZvA==
X-Gm-Message-State: AOJu0Yxvovy+MBHrQzCm2+c+0+z4z5bGiaFclqQzgObZ37YSfbXwE+Gj
 wKzXvPiYc4M7b15JfnJIKKNJGVPDWLnAICVwthw=
X-Google-Smtp-Source: AGHT+IHzJqRi8VwV+b9ORKHndCtRGT3t1PnNdmpY5FvA4dDZh8/fxZA38uIsR9/RsWmGWepdGDaoYA==
X-Received: by 2002:ac2:5e69:0:b0:505:6fcd:dc32 with SMTP id
 a9-20020ac25e69000000b005056fcddc32mr19173839lfr.28.1697183991174; 
 Fri, 13 Oct 2023 00:59:51 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:50 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org (open list:nvme)
Subject: [RFC PATCH v2 65/78] hw/nvme: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:32 +0300
Message-Id: <19e648431bdf3967c309a17b74fe775d92a72dc9.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
@@ -1912,29 +1912,29 @@ static uint16_t nvme_check_zone_read(NvmeNamespace *ns, uint64_t slba,
 static uint16_t nvme_zrm_finish(NvmeNamespace *ns, NvmeZone *zone)
 {
     switch (nvme_get_zone_state(zone)) {
     case NVME_ZONE_STATE_FULL:
         return NVME_SUCCESS;
 
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
         nvme_aor_dec_open(ns);
-        /* fallthrough */
+        fallthrough;
     case NVME_ZONE_STATE_CLOSED:
         nvme_aor_dec_active(ns);
 
         if (zone->d.za & NVME_ZA_ZRWA_VALID) {
             zone->d.za &= ~NVME_ZA_ZRWA_VALID;
             if (ns->params.numzrwa) {
                 ns->zns.numzrwa++;
             }
         }
 
-        /* fallthrough */
+        fallthrough;
     case NVME_ZONE_STATE_EMPTY:
         nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_FULL);
         return NVME_SUCCESS;
 
     default:
         return NVME_ZONE_INVAL_TRANSITION;
     }
 }
@@ -1942,15 +1942,15 @@ static uint16_t nvme_zrm_finish(NvmeNamespace *ns, NvmeZone *zone)
 static uint16_t nvme_zrm_close(NvmeNamespace *ns, NvmeZone *zone)
 {
     switch (nvme_get_zone_state(zone)) {
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
         nvme_aor_dec_open(ns);
         nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_CLOSED);
-        /* fall through */
+        fallthrough;
     case NVME_ZONE_STATE_CLOSED:
         return NVME_SUCCESS;
 
     default:
         return NVME_ZONE_INVAL_TRANSITION;
     }
 }
@@ -1958,29 +1958,29 @@ static uint16_t nvme_zrm_close(NvmeNamespace *ns, NvmeZone *zone)
 static uint16_t nvme_zrm_reset(NvmeNamespace *ns, NvmeZone *zone)
 {
     switch (nvme_get_zone_state(zone)) {
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
         nvme_aor_dec_open(ns);
-        /* fallthrough */
+        fallthrough;
     case NVME_ZONE_STATE_CLOSED:
         nvme_aor_dec_active(ns);
 
         if (zone->d.za & NVME_ZA_ZRWA_VALID) {
             if (ns->params.numzrwa) {
                 ns->zns.numzrwa++;
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
 
     default:
         return NVME_ZONE_INVAL_TRANSITION;
     }
 }
@@ -2010,57 +2010,57 @@ enum {
 static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, NvmeNamespace *ns,
                                     NvmeZone *zone, int flags)
 {
     int act = 0;
     uint16_t status;
 
     switch (nvme_get_zone_state(zone)) {
     case NVME_ZONE_STATE_EMPTY:
         act = 1;
 
-        /* fallthrough */
+        fallthrough;
 
     case NVME_ZONE_STATE_CLOSED:
         if (n->params.auto_transition_zones) {
             nvme_zrm_auto_transition_zone(ns);
         }
         status = nvme_zns_check_resources(ns, act, 1,
                                           (flags & NVME_ZRM_ZRWA) ? 1 : 0);
         if (status) {
             return status;
         }
 
         if (act) {
             nvme_aor_inc_active(ns);
         }
 
         nvme_aor_inc_open(ns);
 
         if (flags & NVME_ZRM_AUTO) {
             nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_IMPLICITLY_OPEN);
             return NVME_SUCCESS;
         }
 
-        /* fallthrough */
+        fallthrough;
 
     case NVME_ZONE_STATE_IMPLICITLY_OPEN:
         if (flags & NVME_ZRM_AUTO) {
             return NVME_SUCCESS;
         }
 
         nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_EXPLICITLY_OPEN);
 
-        /* fallthrough */
+        fallthrough;
 
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
         if (flags & NVME_ZRM_ZRWA) {
             ns->zns.numzrwa--;
 
             zone->d.za |= NVME_ZA_ZRWA_VALID;
         }
 
         return NVME_SUCCESS;
 
     default:
         return NVME_ZONE_INVAL_TRANSITION;
     }
 }
@@ -3508,135 +3508,135 @@ static void nvme_do_write_fdp(NvmeCtrl *n, NvmeRequest *req, uint64_t slba,
 static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
                               bool wrz)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
     uint64_t slba = le64_to_cpu(rw->slba);
     uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
     uint16_t ctrl = le16_to_cpu(rw->control);
     uint8_t prinfo = NVME_RW_PRINFO(ctrl);
     uint64_t data_size = nvme_l2b(ns, nlb);
     uint64_t mapped_size = data_size;
     uint64_t data_offset;
     NvmeZone *zone;
     NvmeZonedResult *res = (NvmeZonedResult *)&req->cqe;
     BlockBackend *blk = ns->blkconf.blk;
     uint16_t status;
 
     if (nvme_ns_ext(ns)) {
         mapped_size += nvme_m2b(ns, nlb);
 
         if (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
             bool pract = prinfo & NVME_PRINFO_PRACT;
 
             if (pract && ns->lbaf.ms == nvme_pi_tuple_size(ns)) {
                 mapped_size -= nvme_m2b(ns, nlb);
             }
         }
     }
 
     trace_pci_nvme_write(nvme_cid(req), nvme_io_opc_str(rw->opcode),
                          nvme_nsid(ns), nlb, mapped_size, slba);
 
     if (!wrz) {
         status = nvme_check_mdts(n, mapped_size);
         if (status) {
             goto invalid;
         }
     }
 
     status = nvme_check_bounds(ns, slba, nlb);
     if (status) {
         goto invalid;
     }
 
     if (ns->params.zoned) {
         zone = nvme_get_zone_by_slba(ns, slba);
         assert(zone);
 
         if (append) {
             bool piremap = !!(ctrl & NVME_RW_PIREMAP);
 
             if (unlikely(zone->d.za & NVME_ZA_ZRWA_VALID)) {
                 return NVME_INVALID_ZONE_OP | NVME_DNR;
             }
 
             if (unlikely(slba != zone->d.zslba)) {
                 trace_pci_nvme_err_append_not_at_start(slba, zone->d.zslba);
                 status = NVME_INVALID_FIELD;
                 goto invalid;
             }
 
             if (n->params.zasl &&
                 data_size > (uint64_t)n->page_size << n->params.zasl) {
                 trace_pci_nvme_err_zasl(data_size);
                 return NVME_INVALID_FIELD | NVME_DNR;
             }
 
             slba = zone->w_ptr;
             rw->slba = cpu_to_le64(slba);
             res->slba = cpu_to_le64(slba);
 
             switch (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
             case NVME_ID_NS_DPS_TYPE_1:
                 if (!piremap) {
                     return NVME_INVALID_PROT_INFO | NVME_DNR;
                 }
 
-                /* fallthrough */
+                fallthrough;
 
             case NVME_ID_NS_DPS_TYPE_2:
                 if (piremap) {
                     uint32_t reftag = le32_to_cpu(rw->reftag);
                     rw->reftag = cpu_to_le32(reftag + (slba - zone->d.zslba));
                 }
 
                 break;
 
             case NVME_ID_NS_DPS_TYPE_3:
                 if (piremap) {
                     return NVME_INVALID_PROT_INFO | NVME_DNR;
                 }
 
                 break;
             }
         }
 
         status = nvme_check_zone_write(ns, zone, slba, nlb);
         if (status) {
             goto invalid;
         }
 
         status = nvme_zrm_auto(n, ns, zone);
         if (status) {
             goto invalid;
         }
 
         if (!(zone->d.za & NVME_ZA_ZRWA_VALID)) {
             zone->w_ptr += nlb;
         }
     } else if (ns->endgrp && ns->endgrp->fdp.enabled) {
         nvme_do_write_fdp(n, req, slba, nlb);
     }
 
     data_offset = nvme_l2b(ns, slba);
 
     if (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
         return nvme_dif_rw(n, req);
     }
 
     if (!wrz) {
         status = nvme_map_data(n, nlb, req);
         if (status) {
             goto invalid;
         }
 
         block_acct_start(blk_get_stats(blk), &req->acct, data_size,
                          BLOCK_ACCT_WRITE);
         nvme_blk_write(blk, data_offset, BDRV_SECTOR_SIZE, nvme_rw_cb, req);
     } else {
         req->aiocb = blk_aio_pwrite_zeroes(blk, data_offset, data_size,
                                            BDRV_REQ_MAY_UNMAP, nvme_rw_cb,
                                            req);
     }
 
     return NVME_NO_COMPLETE;
@@ -3734,13 +3734,13 @@ static uint16_t nvme_finish_zone(NvmeNamespace *ns, NvmeZone *zone,
 static uint16_t nvme_offline_zone(NvmeNamespace *ns, NvmeZone *zone,
                                   NvmeZoneState state, NvmeRequest *req)
 {
     switch (state) {
     case NVME_ZONE_STATE_READ_ONLY:
         nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_OFFLINE);
-        /* fall through */
+        fallthrough;
     case NVME_ZONE_STATE_OFFLINE:
         return NVME_SUCCESS;
     default:
         return NVME_ZONE_INVAL_TRANSITION;
     }
 }
@@ -4902,39 +4902,39 @@ static uint16_t nvme_changed_nslist(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
 static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint8_t csi, uint32_t buf_len,
                                  uint64_t off, NvmeRequest *req)
 {
     NvmeEffectsLog log = {};
     const uint32_t *src_iocs = NULL;
     uint32_t trans_len;
 
     if (off >= sizeof(log)) {
         trace_pci_nvme_err_invalid_log_page_offset(off, sizeof(log));
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
     switch (NVME_CC_CSS(ldl_le_p(&n->bar.cc))) {
     case NVME_CC_CSS_NVM:
         src_iocs = nvme_cse_iocs_nvm;
-        /* fall through */
+        fallthrough;
     case NVME_CC_CSS_ADMIN_ONLY:
         break;
     case NVME_CC_CSS_CSI:
         switch (csi) {
         case NVME_CSI_NVM:
             src_iocs = nvme_cse_iocs_nvm;
             break;
         case NVME_CSI_ZONED:
             src_iocs = nvme_cse_iocs_zoned;
             break;
         }
     }
 
     memcpy(log.acs, nvme_cse_acs, sizeof(nvme_cse_acs));
 
     if (src_iocs) {
         memcpy(log.iocs, src_iocs, sizeof(log.iocs));
     }
 
     trans_len = MIN(sizeof(log) - off, buf_len);
 
     return nvme_c2h(n, ((uint8_t *)&log) + off, trans_len, req);
 }
diff --git a/hw/nvme/dif.c b/hw/nvme/dif.c
index 01b19c3373..00dd96bdb3 100644
--- a/hw/nvme/dif.c
+++ b/hw/nvme/dif.c
@@ -153,58 +153,58 @@ void nvme_dif_pract_generate_dif(NvmeNamespace *ns, uint8_t *buf, size_t len,
 static uint16_t nvme_dif_prchk_crc16(NvmeNamespace *ns, NvmeDifTuple *dif,
                                      uint8_t *buf, uint8_t *mbuf, size_t pil,
                                      uint8_t prinfo, uint16_t apptag,
                                      uint16_t appmask, uint64_t reftag)
 {
     switch (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
     case NVME_ID_NS_DPS_TYPE_3:
         if (be32_to_cpu(dif->g16.reftag) != 0xffffffff) {
             break;
         }
 
-        /* fallthrough */
+        fallthrough;
     case NVME_ID_NS_DPS_TYPE_1:
     case NVME_ID_NS_DPS_TYPE_2:
         if (be16_to_cpu(dif->g16.apptag) != 0xffff) {
             break;
         }
 
         trace_pci_nvme_dif_prchk_disabled_crc16(be16_to_cpu(dif->g16.apptag),
                                                 be32_to_cpu(dif->g16.reftag));
 
         return NVME_SUCCESS;
     }
 
     if (prinfo & NVME_PRINFO_PRCHK_GUARD) {
         uint16_t crc = crc16_t10dif(0x0, buf, ns->lbasz);
 
         if (pil) {
             crc = crc16_t10dif(crc, mbuf, pil);
         }
 
         trace_pci_nvme_dif_prchk_guard_crc16(be16_to_cpu(dif->g16.guard), crc);
 
         if (be16_to_cpu(dif->g16.guard) != crc) {
             return NVME_E2E_GUARD_ERROR;
         }
     }
 
     if (prinfo & NVME_PRINFO_PRCHK_APP) {
         trace_pci_nvme_dif_prchk_apptag(be16_to_cpu(dif->g16.apptag), apptag,
                                         appmask);
 
         if ((be16_to_cpu(dif->g16.apptag) & appmask) != (apptag & appmask)) {
             return NVME_E2E_APP_ERROR;
         }
     }
 
     if (prinfo & NVME_PRINFO_PRCHK_REF) {
         trace_pci_nvme_dif_prchk_reftag_crc16(be32_to_cpu(dif->g16.reftag),
                                               reftag);
 
         if (be32_to_cpu(dif->g16.reftag) != reftag) {
             return NVME_E2E_REF_ERROR;
         }
     }
 
     return NVME_SUCCESS;
 }
@@ -212,66 +212,66 @@ static uint16_t nvme_dif_prchk_crc16(NvmeNamespace *ns, NvmeDifTuple *dif,
 static uint16_t nvme_dif_prchk_crc64(NvmeNamespace *ns, NvmeDifTuple *dif,
                                      uint8_t *buf, uint8_t *mbuf, size_t pil,
                                      uint8_t prinfo, uint16_t apptag,
                                      uint16_t appmask, uint64_t reftag)
 {
     uint64_t r = 0;
 
     r |= (uint64_t)dif->g64.sr[0] << 40;
     r |= (uint64_t)dif->g64.sr[1] << 32;
     r |= (uint64_t)dif->g64.sr[2] << 24;
     r |= (uint64_t)dif->g64.sr[3] << 16;
     r |= (uint64_t)dif->g64.sr[4] << 8;
     r |= (uint64_t)dif->g64.sr[5];
 
     switch (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
     case NVME_ID_NS_DPS_TYPE_3:
         if (r != 0xffffffffffff) {
             break;
         }
 
-        /* fallthrough */
+        fallthrough;
     case NVME_ID_NS_DPS_TYPE_1:
     case NVME_ID_NS_DPS_TYPE_2:
         if (be16_to_cpu(dif->g64.apptag) != 0xffff) {
             break;
         }
 
         trace_pci_nvme_dif_prchk_disabled_crc64(be16_to_cpu(dif->g16.apptag),
                                                 r);
 
         return NVME_SUCCESS;
     }
 
     if (prinfo & NVME_PRINFO_PRCHK_GUARD) {
         uint64_t crc = crc64_nvme(~0ULL, buf, ns->lbasz);
 
         if (pil) {
             crc = crc64_nvme(~crc, mbuf, pil);
         }
 
         trace_pci_nvme_dif_prchk_guard_crc64(be64_to_cpu(dif->g64.guard), crc);
 
         if (be64_to_cpu(dif->g64.guard) != crc) {
             return NVME_E2E_GUARD_ERROR;
         }
     }
 
     if (prinfo & NVME_PRINFO_PRCHK_APP) {
         trace_pci_nvme_dif_prchk_apptag(be16_to_cpu(dif->g64.apptag), apptag,
                                         appmask);
 
         if ((be16_to_cpu(dif->g64.apptag) & appmask) != (apptag & appmask)) {
             return NVME_E2E_APP_ERROR;
         }
     }
 
     if (prinfo & NVME_PRINFO_PRCHK_REF) {
         trace_pci_nvme_dif_prchk_reftag_crc64(r, reftag);
 
         if (r != reftag) {
             return NVME_E2E_REF_ERROR;
         }
     }
 
     return NVME_SUCCESS;
 }
-- 
2.39.2


