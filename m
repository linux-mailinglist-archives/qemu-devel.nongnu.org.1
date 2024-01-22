Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CDD8371AF
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 20:02:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRzXD-0005gv-8l; Mon, 22 Jan 2024 14:00:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzXB-0005gC-9c; Mon, 22 Jan 2024 14:00:37 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzX7-000256-53; Mon, 22 Jan 2024 14:00:36 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-559cef15db5so8054675a12.0; 
 Mon, 22 Jan 2024 11:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705950031; x=1706554831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJj4/sPsUc3WFPNiDK5H2Uhaq/LbbdIs1YuKh3jTyws=;
 b=cUYNcGAXT6hIE22KvVSWevEHMvV5ku6IqwySOytxWeEb3pVSu4lq/XB2VykLpR9ENe
 t26Ft7PFjF8mmc833EkfPwIZ+1HcbVigysKIm3g4joP4A4hjyg1Ab/9q3KGGwUcbgRTX
 61eXMYxpyXmiYtv5BcYBE81oTTmYXoaVshS0ef8oB6JXyQSgnAslg52utoH58lyEKNMm
 rBN+yz+VAfUUCHfEbt2l234OBMpqoIIpNY/oOAdDCUHSHUgqpgfpShIZgimcr/huxyey
 MkeImh8n2iEe0I1E52A1viV/OQiRK9zUAiXULNw9xadWWKdNUCQjj0rSjDMtTDDhkgrf
 wD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705950031; x=1706554831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KJj4/sPsUc3WFPNiDK5H2Uhaq/LbbdIs1YuKh3jTyws=;
 b=jSehBPvOGwwrJs3bWTJA9DCTgGFYPBe6lPajYgtOymsx+6Tcr6Z4DC6j+5TZyWRbST
 HgWN6WVRWw67IgWpt0k2jsNjblBVUw2KOBOAkzkOPk9pWf+kif0jJ4rm+Lo9bY42v/q4
 jF7Nc6NTZfc0UKYxVFRxkghhqPM0okNRPSYyoV2iJwf7WSTiZSv9gP2KQIdrPAii5xfv
 7/xZUsVyEyWuggvNVrmSfG4Mfm2H4w7wfVuLOut8ers56cxD9kWHcmPLSRyjQuA3TbOg
 LbYS/UniqOokISV+j6tylYQllodz+0SgTq+K6Eah3iuotkOaCxg4RRcIt5uMNb8YLKVD
 AjOA==
X-Gm-Message-State: AOJu0Yzpjstg1Mq2O8xy/nD+zklIzmvhiuST2ZrUOqmZd+UgKWu7KtF+
 QwIYzjUFHItjcEJQoGDNoXKgMRkUbZ4//odlfl1oRXPaiy47CWYZWK1ozPXlzhw=
X-Google-Smtp-Source: AGHT+IGFAs5rXOG2DKYBICletP8EEBgE0H7Xp9XT442x3o4lsUAV8kLTcFZ9teQYwBjjz6kQ+gX4pg==
X-Received: by 2002:a17:906:32ce:b0:a26:f7ea:7cb6 with SMTP id
 k14-20020a17090632ce00b00a26f7ea7cb6mr6992790ejk.16.1705950030674; 
 Mon, 22 Jan 2024 11:00:30 -0800 (PST)
Received: from localhost.localdomain ([2a02:2454:367:1500:fa08:d4d:b569:ac2d])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a170906a38300b00a298d735a1bsm13842413ejz.149.2024.01.22.11.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 11:00:30 -0800 (PST)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 dmitry.fomichev@wdc.com, hare@suse.de, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 dlemoal@kernel.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Sam Li <faithilikerun@gmail.com>
Subject: [RFC v3 5/7] hw/nvme: make the metadata of ZNS emulation persistent
Date: Mon, 22 Jan 2024 20:00:11 +0100
Message-Id: <20240122190013.41302-6-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122190013.41302-1-faithilikerun@gmail.com>
References: <20240122190013.41302-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x52a.google.com
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

The NVMe ZNS devices follow NVMe ZNS spec but the state of namespace
zones does not persist accross restarts of QEMU. This patch makes the
metadata of ZNS emulation persistent by using new block layer APIs. The
ZNS device calls zone report and zone mgmt APIs from the block layer
which will handle zone state transition and manage zone resources.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/qcow2.c                    |    3 +
 hw/nvme/ctrl.c                   | 1115 +++++++-----------------------
 hw/nvme/ns.c                     |   77 +--
 hw/nvme/nvme.h                   |   85 +--
 include/block/block-common.h     |    8 +
 include/block/block_int-common.h |    2 +
 6 files changed, 264 insertions(+), 1026 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 5098edf656..0bb249fa6e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5107,6 +5107,9 @@ qcow2_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
     case BLK_ZO_RESET:
         ret = qcow2_reset_zone(bs, index, len);
         break;
+    case BLK_ZO_OFFLINE:
+        /* There are no transitions from the offline state to any other state */
+        break;
     default:
         error_report("Unsupported zone op: 0x%x", op);
         ret = -ENOTSUP;
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index dae6f00e4f..e31aa52c06 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -372,67 +372,6 @@ static inline bool nvme_parse_pid(NvmeNamespace *ns, uint16_t pid,
     return nvme_ph_valid(ns, *ph) && nvme_rg_valid(ns->endgrp, *rg);
 }
 
-static void nvme_assign_zone_state(NvmeNamespace *ns, NvmeZone *zone,
-                                   NvmeZoneState state)
-{
-    if (QTAILQ_IN_USE(zone, entry)) {
-        switch (nvme_get_zone_state(zone)) {
-        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
-            QTAILQ_REMOVE(&ns->exp_open_zones, zone, entry);
-            break;
-        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
-            QTAILQ_REMOVE(&ns->imp_open_zones, zone, entry);
-            break;
-        case NVME_ZONE_STATE_CLOSED:
-            QTAILQ_REMOVE(&ns->closed_zones, zone, entry);
-            break;
-        case NVME_ZONE_STATE_FULL:
-            QTAILQ_REMOVE(&ns->full_zones, zone, entry);
-        default:
-            ;
-        }
-    }
-
-    nvme_set_zone_state(zone, state);
-
-    switch (state) {
-    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
-        QTAILQ_INSERT_TAIL(&ns->exp_open_zones, zone, entry);
-        break;
-    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
-        QTAILQ_INSERT_TAIL(&ns->imp_open_zones, zone, entry);
-        break;
-    case NVME_ZONE_STATE_CLOSED:
-        QTAILQ_INSERT_TAIL(&ns->closed_zones, zone, entry);
-        break;
-    case NVME_ZONE_STATE_FULL:
-        QTAILQ_INSERT_TAIL(&ns->full_zones, zone, entry);
-    case NVME_ZONE_STATE_READ_ONLY:
-        break;
-    default:
-        zone->d.za = 0;
-    }
-}
-
-static uint16_t nvme_zns_check_resources(NvmeNamespace *ns, uint32_t act,
-                                         uint32_t opn, uint32_t zrwa)
-{
-    if (zrwa > ns->zns.numzrwa) {
-        return NVME_NOZRWA | NVME_DNR;
-    }
-
-    return NVME_SUCCESS;
-}
-
-/*
- * Check if we can open a zone without exceeding open/active limits.
- * AOR stands for "Active and Open Resources" (see TP 4053 section 2.5).
- */
-static uint16_t nvme_aor_check(NvmeNamespace *ns, uint32_t act, uint32_t opn)
-{
-    return nvme_zns_check_resources(ns, act, opn, 0);
-}
-
 static NvmeFdpEvent *nvme_fdp_alloc_event(NvmeCtrl *n, NvmeFdpEventBuffer *ebuf)
 {
     NvmeFdpEvent *ret = NULL;
@@ -1769,355 +1708,11 @@ static inline uint32_t nvme_zone_idx(NvmeNamespace *ns, uint64_t slba)
                                     slba / ns->zone_size;
 }
 
-static inline NvmeZone *nvme_get_zone_by_slba(NvmeNamespace *ns, uint64_t slba)
-{
-    uint32_t zone_idx = nvme_zone_idx(ns, slba);
-
-    if (zone_idx >= ns->num_zones) {
-        return NULL;
-    }
-
-    return &ns->zone_array[zone_idx];
-}
-
-static uint16_t nvme_check_zone_state_for_write(NvmeZone *zone)
-{
-    uint64_t zslba = zone->d.zslba;
-
-    switch (nvme_get_zone_state(zone)) {
-    case NVME_ZONE_STATE_EMPTY:
-    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
-    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
-    case NVME_ZONE_STATE_CLOSED:
-        return NVME_SUCCESS;
-    case NVME_ZONE_STATE_FULL:
-        trace_pci_nvme_err_zone_is_full(zslba);
-        return NVME_ZONE_FULL;
-    case NVME_ZONE_STATE_OFFLINE:
-        trace_pci_nvme_err_zone_is_offline(zslba);
-        return NVME_ZONE_OFFLINE;
-    case NVME_ZONE_STATE_READ_ONLY:
-        trace_pci_nvme_err_zone_is_read_only(zslba);
-        return NVME_ZONE_READ_ONLY;
-    default:
-        assert(false);
-    }
-
-    return NVME_INTERNAL_DEV_ERROR;
-}
-
-static uint16_t nvme_check_zone_write(NvmeNamespace *ns, NvmeZone *zone,
-                                      uint64_t slba, uint32_t nlb)
-{
-    uint64_t zcap = nvme_zone_wr_boundary(zone);
-    uint16_t status;
-
-    status = nvme_check_zone_state_for_write(zone);
-    if (status) {
-        return status;
-    }
-
-    if (zone->d.za & NVME_ZA_ZRWA_VALID) {
-        uint64_t ezrwa = zone->w_ptr + 2 * ns->zns.zrwas;
-
-        if (slba < zone->w_ptr || slba + nlb > ezrwa) {
-            trace_pci_nvme_err_zone_invalid_write(slba, zone->w_ptr);
-            return NVME_ZONE_INVALID_WRITE;
-        }
-    } else {
-        if (unlikely(slba != zone->w_ptr)) {
-            trace_pci_nvme_err_write_not_at_wp(slba, zone->d.zslba,
-                                               zone->w_ptr);
-            return NVME_ZONE_INVALID_WRITE;
-        }
-    }
-
-    if (unlikely((slba + nlb) > zcap)) {
-        trace_pci_nvme_err_zone_boundary(slba, nlb, zcap);
-        return NVME_ZONE_BOUNDARY_ERROR;
-    }
-
-    return NVME_SUCCESS;
-}
-
-static uint16_t nvme_check_zone_state_for_read(NvmeZone *zone)
-{
-    switch (nvme_get_zone_state(zone)) {
-    case NVME_ZONE_STATE_EMPTY:
-    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
-    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
-    case NVME_ZONE_STATE_FULL:
-    case NVME_ZONE_STATE_CLOSED:
-    case NVME_ZONE_STATE_READ_ONLY:
-        return NVME_SUCCESS;
-    case NVME_ZONE_STATE_OFFLINE:
-        trace_pci_nvme_err_zone_is_offline(zone->d.zslba);
-        return NVME_ZONE_OFFLINE;
-    default:
-        assert(false);
-    }
-
-    return NVME_INTERNAL_DEV_ERROR;
-}
-
-static uint16_t nvme_check_zone_read(NvmeNamespace *ns, uint64_t slba,
-                                     uint32_t nlb)
-{
-    NvmeZone *zone;
-    uint64_t bndry, end;
-    uint16_t status;
-
-    zone = nvme_get_zone_by_slba(ns, slba);
-    assert(zone);
-
-    bndry = nvme_zone_rd_boundary(ns, zone);
-    end = slba + nlb;
-
-    status = nvme_check_zone_state_for_read(zone);
-    if (status) {
-        ;
-    } else if (unlikely(end > bndry)) {
-        if (!ns->params.cross_zone_read) {
-            status = NVME_ZONE_BOUNDARY_ERROR;
-        } else {
-            /*
-             * Read across zone boundary - check that all subsequent
-             * zones that are being read have an appropriate state.
-             */
-            do {
-                zone++;
-                status = nvme_check_zone_state_for_read(zone);
-                if (status) {
-                    break;
-                }
-            } while (end > nvme_zone_rd_boundary(ns, zone));
-        }
-    }
-
-    return status;
-}
-
-static uint16_t nvme_zrm_finish(NvmeNamespace *ns, NvmeZone *zone)
-{
-    switch (nvme_get_zone_state(zone)) {
-    case NVME_ZONE_STATE_FULL:
-        return NVME_SUCCESS;
-
-    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
-    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
-        nvme_aor_dec_open(ns);
-        /* fallthrough */
-    case NVME_ZONE_STATE_CLOSED:
-        nvme_aor_dec_active(ns);
-
-        if (zone->d.za & NVME_ZA_ZRWA_VALID) {
-            zone->d.za &= ~NVME_ZA_ZRWA_VALID;
-            if (ns->params.numzrwa) {
-                ns->zns.numzrwa++;
-            }
-        }
-
-        /* fallthrough */
-    case NVME_ZONE_STATE_EMPTY:
-        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_FULL);
-        return NVME_SUCCESS;
-
-    default:
-        return NVME_ZONE_INVAL_TRANSITION;
-    }
-}
-
-static uint16_t nvme_zrm_close(NvmeNamespace *ns, NvmeZone *zone)
-{
-    switch (nvme_get_zone_state(zone)) {
-    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
-    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
-        nvme_aor_dec_open(ns);
-        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_CLOSED);
-        /* fall through */
-    case NVME_ZONE_STATE_CLOSED:
-        return NVME_SUCCESS;
-
-    default:
-        return NVME_ZONE_INVAL_TRANSITION;
-    }
-}
-
-static uint16_t nvme_zrm_reset(NvmeNamespace *ns, NvmeZone *zone)
-{
-    switch (nvme_get_zone_state(zone)) {
-    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
-    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
-        nvme_aor_dec_open(ns);
-        /* fallthrough */
-    case NVME_ZONE_STATE_CLOSED:
-        nvme_aor_dec_active(ns);
-
-        if (zone->d.za & NVME_ZA_ZRWA_VALID) {
-            if (ns->params.numzrwa) {
-                ns->zns.numzrwa++;
-            }
-        }
-
-        /* fallthrough */
-    case NVME_ZONE_STATE_FULL:
-        zone->w_ptr = zone->d.zslba;
-        zone->d.wp = zone->w_ptr;
-        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_EMPTY);
-        /* fallthrough */
-    case NVME_ZONE_STATE_EMPTY:
-        return NVME_SUCCESS;
-
-    default:
-        return NVME_ZONE_INVAL_TRANSITION;
-    }
-}
-
-static void nvme_zrm_auto_transition_zone(NvmeNamespace *ns)
-{
-    NvmeZone *zone;
-    int moz = blk_get_max_open_zones(ns->blkconf.blk);
-
-    if (moz && ns->nr_open_zones == moz) {
-        zone = QTAILQ_FIRST(&ns->imp_open_zones);
-        if (zone) {
-            /*
-             * Automatically close this implicitly open zone.
-             */
-            QTAILQ_REMOVE(&ns->imp_open_zones, zone, entry);
-            nvme_zrm_close(ns, zone);
-        }
-    }
-}
-
 enum {
     NVME_ZRM_AUTO = 1 << 0,
     NVME_ZRM_ZRWA = 1 << 1,
 };
 
-static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, NvmeNamespace *ns,
-                                    NvmeZone *zone, int flags)
-{
-    int act = 0;
-    uint16_t status;
-
-    switch (nvme_get_zone_state(zone)) {
-    case NVME_ZONE_STATE_EMPTY:
-        act = 1;
-
-        /* fallthrough */
-
-    case NVME_ZONE_STATE_CLOSED:
-        if (n->params.auto_transition_zones) {
-            nvme_zrm_auto_transition_zone(ns);
-        }
-        status = nvme_zns_check_resources(ns, act, 1,
-                                          (flags & NVME_ZRM_ZRWA) ? 1 : 0);
-        if (status) {
-            return status;
-        }
-
-        if (act) {
-            nvme_aor_inc_active(ns);
-        }
-
-        nvme_aor_inc_open(ns);
-
-        if (flags & NVME_ZRM_AUTO) {
-            nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_IMPLICITLY_OPEN);
-            return NVME_SUCCESS;
-        }
-
-        /* fallthrough */
-
-    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
-        if (flags & NVME_ZRM_AUTO) {
-            return NVME_SUCCESS;
-        }
-
-        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_EXPLICITLY_OPEN);
-
-        /* fallthrough */
-
-    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
-        if (flags & NVME_ZRM_ZRWA) {
-            ns->zns.numzrwa--;
-
-            zone->d.za |= NVME_ZA_ZRWA_VALID;
-        }
-
-        return NVME_SUCCESS;
-
-    default:
-        return NVME_ZONE_INVAL_TRANSITION;
-    }
-}
-
-static inline uint16_t nvme_zrm_auto(NvmeCtrl *n, NvmeNamespace *ns,
-                                     NvmeZone *zone)
-{
-    return nvme_zrm_open_flags(n, ns, zone, NVME_ZRM_AUTO);
-}
-
-static void nvme_advance_zone_wp(NvmeNamespace *ns, NvmeZone *zone,
-                                 uint32_t nlb)
-{
-    zone->d.wp += nlb;
-
-    if (zone->d.wp == nvme_zone_wr_boundary(zone)) {
-        nvme_zrm_finish(ns, zone);
-    }
-}
-
-static void nvme_zoned_zrwa_implicit_flush(NvmeNamespace *ns, NvmeZone *zone,
-                                           uint32_t nlbc)
-{
-    uint16_t nzrwafgs = DIV_ROUND_UP(nlbc, ns->zns.zrwafg);
-
-    nlbc = nzrwafgs * ns->zns.zrwafg;
-
-    trace_pci_nvme_zoned_zrwa_implicit_flush(zone->d.zslba, nlbc);
-
-    zone->w_ptr += nlbc;
-
-    nvme_advance_zone_wp(ns, zone, nlbc);
-}
-
-static void nvme_finalize_zoned_write(NvmeNamespace *ns, NvmeRequest *req)
-{
-    NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
-    NvmeZone *zone;
-    uint64_t slba;
-    uint32_t nlb;
-
-    slba = le64_to_cpu(rw->slba);
-    nlb = le16_to_cpu(rw->nlb) + 1;
-    zone = nvme_get_zone_by_slba(ns, slba);
-    assert(zone);
-
-    if (zone->d.za & NVME_ZA_ZRWA_VALID) {
-        uint64_t ezrwa = zone->w_ptr + ns->zns.zrwas - 1;
-        uint64_t elba = slba + nlb - 1;
-
-        if (elba > ezrwa) {
-            nvme_zoned_zrwa_implicit_flush(ns, zone, elba - ezrwa);
-        }
-
-        return;
-    }
-
-    nvme_advance_zone_wp(ns, zone, nlb);
-}
-
-static inline bool nvme_is_write(NvmeRequest *req)
-{
-    NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
-
-    return rw->opcode == NVME_CMD_WRITE ||
-           rw->opcode == NVME_CMD_ZONE_APPEND ||
-           rw->opcode == NVME_CMD_WRITE_ZEROES;
-}
-
 static void nvme_misc_cb(void *opaque, int ret)
 {
     NvmeRequest *req = opaque;
@@ -2148,10 +1743,6 @@ void nvme_rw_complete_cb(void *opaque, int ret)
         block_acct_done(stats, acct);
     }
 
-    if (blk_get_zone_model(blk) && nvme_is_write(req)) {
-        nvme_finalize_zoned_write(ns, req);
-    }
-
     nvme_enqueue_req_completion(nvme_cq(req), req);
 }
 
@@ -2856,8 +2447,6 @@ static inline uint16_t nvme_check_copy_mcl(NvmeNamespace *ns,
 static void nvme_copy_out_completed_cb(void *opaque, int ret)
 {
     NvmeCopyAIOCB *iocb = opaque;
-    NvmeRequest *req = iocb->req;
-    NvmeNamespace *ns = req->ns;
     uint32_t nlb;
 
     nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, NULL,
@@ -2870,10 +2459,6 @@ static void nvme_copy_out_completed_cb(void *opaque, int ret)
         goto out;
     }
 
-    if (blk_get_zone_model(ns->blkconf.blk)) {
-        nvme_advance_zone_wp(ns, iocb->zone, nlb);
-    }
-
     iocb->idx++;
     iocb->slba += nlb;
 out:
@@ -2982,17 +2567,6 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
         goto invalid;
     }
 
-    if (blk_get_zone_model(ns->blkconf.blk)) {
-        status = nvme_check_zone_write(ns, iocb->zone, iocb->slba, nlb);
-        if (status) {
-            goto invalid;
-        }
-
-        if (!(iocb->zone->d.za & NVME_ZA_ZRWA_VALID)) {
-            iocb->zone->w_ptr += nlb;
-        }
-    }
-
     qemu_iovec_reset(&iocb->iov);
     qemu_iovec_add(&iocb->iov, iocb->bounce, len);
 
@@ -3076,13 +2650,6 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
         }
     }
 
-    if (blk_get_zone_model(ns->blkconf.blk)) {
-        status = nvme_check_zone_read(ns, slba, nlb);
-        if (status) {
-            goto invalid;
-        }
-    }
-
     qemu_iovec_reset(&iocb->iov);
     qemu_iovec_add(&iocb->iov, iocb->bounce, len);
 
@@ -3152,19 +2719,6 @@ static uint16_t nvme_copy(NvmeCtrl *n, NvmeRequest *req)
 
     iocb->slba = le64_to_cpu(copy->sdlba);
 
-    if (blk_get_zone_model(ns->blkconf.blk)) {
-        iocb->zone = nvme_get_zone_by_slba(ns, iocb->slba);
-        if (!iocb->zone) {
-            status = NVME_LBA_RANGE | NVME_DNR;
-            goto invalid;
-        }
-
-        status = nvme_zrm_auto(n, ns, iocb->zone);
-        if (status) {
-            goto invalid;
-        }
-    }
-
     status = nvme_check_copy_mcl(ns, iocb, nr);
     if (status) {
         goto invalid;
@@ -3422,14 +2976,6 @@ static uint16_t nvme_read(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
-    if (blk_get_zone_model(blk)) {
-        status = nvme_check_zone_read(ns, slba, nlb);
-        if (status) {
-            trace_pci_nvme_err_zone_read_not_ok(slba, nlb, status);
-            goto invalid;
-        }
-    }
-
     if (NVME_ERR_REC_DULBE(ns->features.err_rec)) {
         status = nvme_check_dulbe(ns, slba, nlb);
         if (status) {
@@ -3505,8 +3051,6 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
     uint64_t data_size = nvme_l2b(ns, nlb);
     uint64_t mapped_size = data_size;
     uint64_t data_offset;
-    NvmeZone *zone;
-    NvmeZonedResult *res = (NvmeZonedResult *)&req->cqe;
     BlockBackend *blk = ns->blkconf.blk;
     uint16_t status;
 
@@ -3538,32 +3082,20 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
     }
 
     if (blk_get_zone_model(blk)) {
-        zone = nvme_get_zone_by_slba(ns, slba);
-        assert(zone);
+        uint32_t zone_size = blk_get_zone_size(blk);
+        uint32_t zone_idx = slba / zone_size;
+        int64_t zone_start = zone_idx * zone_size;
 
         if (append) {
             bool piremap = !!(ctrl & NVME_RW_PIREMAP);
 
-            if (unlikely(zone->d.za & NVME_ZA_ZRWA_VALID)) {
-                return NVME_INVALID_ZONE_OP | NVME_DNR;
-            }
-
-            if (unlikely(slba != zone->d.zslba)) {
-                trace_pci_nvme_err_append_not_at_start(slba, zone->d.zslba);
-                status = NVME_INVALID_FIELD;
-                goto invalid;
-            }
-
             if (n->params.zasl &&
                 data_size > (uint64_t)n->page_size << n->params.zasl) {
                 trace_pci_nvme_err_zasl(data_size);
                 return NVME_INVALID_FIELD | NVME_DNR;
             }
 
-            slba = zone->w_ptr;
             rw->slba = cpu_to_le64(slba);
-            res->slba = cpu_to_le64(slba);
-
             switch (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
             case NVME_ID_NS_DPS_TYPE_1:
                 if (!piremap) {
@@ -3575,7 +3107,7 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
             case NVME_ID_NS_DPS_TYPE_2:
                 if (piremap) {
                     uint32_t reftag = le32_to_cpu(rw->reftag);
-                    rw->reftag = cpu_to_le32(reftag + (slba - zone->d.zslba));
+                    rw->reftag = cpu_to_le32(reftag + (slba - zone_start));
                 }
 
                 break;
@@ -3589,19 +3121,6 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
             }
         }
 
-        status = nvme_check_zone_write(ns, zone, slba, nlb);
-        if (status) {
-            goto invalid;
-        }
-
-        status = nvme_zrm_auto(n, ns, zone);
-        if (status) {
-            goto invalid;
-        }
-
-        if (!(zone->d.za & NVME_ZA_ZRWA_VALID)) {
-            zone->w_ptr += nlb;
-        }
     } else if (ns->endgrp && ns->endgrp->fdp.enabled) {
         nvme_do_write_fdp(n, req, slba, nlb);
     }
@@ -3644,6 +3163,23 @@ static inline uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
     return nvme_do_write(n, req, false, true);
 }
 
+typedef struct NvmeZoneCmdAIOCB {
+    NvmeRequest *req;
+    NvmeCmd *cmd;
+    NvmeCtrl *n;
+
+    union {
+        struct {
+          uint32_t partial;
+          unsigned int nr_zones;
+          BlockZoneDescriptor *zones;
+        } zone_report_data;
+        struct {
+          int64_t offset;
+        } zone_append_data;
+    };
+} NvmeZoneCmdAIOCB;
+
 static inline uint16_t nvme_zone_append(NvmeCtrl *n, NvmeRequest *req)
 {
     return nvme_do_write(n, req, true, false);
@@ -3655,7 +3191,7 @@ static uint16_t nvme_get_mgmt_zone_slba_idx(NvmeNamespace *ns, NvmeCmd *c,
     uint32_t dw10 = le32_to_cpu(c->cdw10);
     uint32_t dw11 = le32_to_cpu(c->cdw11);
 
-    if (blk_get_zone_model(ns->blkconf.blk)) {
+    if (!blk_get_zone_model(ns->blkconf.blk)) {
         trace_pci_nvme_err_invalid_opc(c->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
@@ -3673,198 +3209,21 @@ static uint16_t nvme_get_mgmt_zone_slba_idx(NvmeNamespace *ns, NvmeCmd *c,
     return NVME_SUCCESS;
 }
 
-typedef uint16_t (*op_handler_t)(NvmeNamespace *, NvmeZone *, NvmeZoneState,
-                                 NvmeRequest *);
-
-enum NvmeZoneProcessingMask {
-    NVME_PROC_CURRENT_ZONE    = 0,
-    NVME_PROC_OPENED_ZONES    = 1 << 0,
-    NVME_PROC_CLOSED_ZONES    = 1 << 1,
-    NVME_PROC_READ_ONLY_ZONES = 1 << 2,
-    NVME_PROC_FULL_ZONES      = 1 << 3,
-};
-
-static uint16_t nvme_open_zone(NvmeNamespace *ns, NvmeZone *zone,
-                               NvmeZoneState state, NvmeRequest *req)
-{
-    NvmeZoneSendCmd *cmd = (NvmeZoneSendCmd *)&req->cmd;
-    int flags = 0;
-
-    if (cmd->zsflags & NVME_ZSFLAG_ZRWA_ALLOC) {
-        uint16_t ozcs = le16_to_cpu(ns->id_ns_zoned->ozcs);
-
-        if (!(ozcs & NVME_ID_NS_ZONED_OZCS_ZRWASUP)) {
-            return NVME_INVALID_ZONE_OP | NVME_DNR;
-        }
-
-        if (zone->w_ptr % ns->zns.zrwafg) {
-            return NVME_NOZRWA | NVME_DNR;
-        }
-
-        flags = NVME_ZRM_ZRWA;
-    }
-
-    return nvme_zrm_open_flags(nvme_ctrl(req), ns, zone, flags);
-}
-
-static uint16_t nvme_close_zone(NvmeNamespace *ns, NvmeZone *zone,
-                                NvmeZoneState state, NvmeRequest *req)
-{
-    return nvme_zrm_close(ns, zone);
-}
-
-static uint16_t nvme_finish_zone(NvmeNamespace *ns, NvmeZone *zone,
-                                 NvmeZoneState state, NvmeRequest *req)
-{
-    return nvme_zrm_finish(ns, zone);
-}
-
-static uint16_t nvme_offline_zone(NvmeNamespace *ns, NvmeZone *zone,
-                                  NvmeZoneState state, NvmeRequest *req)
-{
-    switch (state) {
-    case NVME_ZONE_STATE_READ_ONLY:
-        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_OFFLINE);
-        /* fall through */
-    case NVME_ZONE_STATE_OFFLINE:
-        return NVME_SUCCESS;
-    default:
-        return NVME_ZONE_INVAL_TRANSITION;
-    }
-}
-
-static uint16_t nvme_set_zd_ext(NvmeNamespace *ns, NvmeZone *zone)
-{
-    uint16_t status;
-    uint8_t state = nvme_get_zone_state(zone);
-
-    if (state == NVME_ZONE_STATE_EMPTY) {
-        status = nvme_aor_check(ns, 1, 0);
-        if (status) {
-            return status;
-        }
-        nvme_aor_inc_active(ns);
-        zone->d.za |= NVME_ZA_ZD_EXT_VALID;
-        nvme_assign_zone_state(ns, zone, NVME_ZONE_STATE_CLOSED);
-        return NVME_SUCCESS;
-    }
-
-    return NVME_ZONE_INVAL_TRANSITION;
-}
-
-static uint16_t nvme_bulk_proc_zone(NvmeNamespace *ns, NvmeZone *zone,
-                                    enum NvmeZoneProcessingMask proc_mask,
-                                    op_handler_t op_hndlr, NvmeRequest *req)
-{
-    uint16_t status = NVME_SUCCESS;
-    NvmeZoneState zs = nvme_get_zone_state(zone);
-    bool proc_zone;
-
-    switch (zs) {
-    case NVME_ZONE_STATE_IMPLICITLY_OPEN:
-    case NVME_ZONE_STATE_EXPLICITLY_OPEN:
-        proc_zone = proc_mask & NVME_PROC_OPENED_ZONES;
-        break;
-    case NVME_ZONE_STATE_CLOSED:
-        proc_zone = proc_mask & NVME_PROC_CLOSED_ZONES;
-        break;
-    case NVME_ZONE_STATE_READ_ONLY:
-        proc_zone = proc_mask & NVME_PROC_READ_ONLY_ZONES;
-        break;
-    case NVME_ZONE_STATE_FULL:
-        proc_zone = proc_mask & NVME_PROC_FULL_ZONES;
-        break;
-    default:
-        proc_zone = false;
-    }
-
-    if (proc_zone) {
-        status = op_hndlr(ns, zone, zs, req);
-    }
-
-    return status;
-}
-
-static uint16_t nvme_do_zone_op(NvmeNamespace *ns, NvmeZone *zone,
-                                enum NvmeZoneProcessingMask proc_mask,
-                                op_handler_t op_hndlr, NvmeRequest *req)
-{
-    NvmeZone *next;
-    uint16_t status = NVME_SUCCESS;
-    int i;
-
-    if (!proc_mask) {
-        status = op_hndlr(ns, zone, nvme_get_zone_state(zone), req);
-    } else {
-        if (proc_mask & NVME_PROC_CLOSED_ZONES) {
-            QTAILQ_FOREACH_SAFE(zone, &ns->closed_zones, entry, next) {
-                status = nvme_bulk_proc_zone(ns, zone, proc_mask, op_hndlr,
-                                             req);
-                if (status && status != NVME_NO_COMPLETE) {
-                    goto out;
-                }
-            }
-        }
-        if (proc_mask & NVME_PROC_OPENED_ZONES) {
-            QTAILQ_FOREACH_SAFE(zone, &ns->imp_open_zones, entry, next) {
-                status = nvme_bulk_proc_zone(ns, zone, proc_mask, op_hndlr,
-                                             req);
-                if (status && status != NVME_NO_COMPLETE) {
-                    goto out;
-                }
-            }
-
-            QTAILQ_FOREACH_SAFE(zone, &ns->exp_open_zones, entry, next) {
-                status = nvme_bulk_proc_zone(ns, zone, proc_mask, op_hndlr,
-                                             req);
-                if (status && status != NVME_NO_COMPLETE) {
-                    goto out;
-                }
-            }
-        }
-        if (proc_mask & NVME_PROC_FULL_ZONES) {
-            QTAILQ_FOREACH_SAFE(zone, &ns->full_zones, entry, next) {
-                status = nvme_bulk_proc_zone(ns, zone, proc_mask, op_hndlr,
-                                             req);
-                if (status && status != NVME_NO_COMPLETE) {
-                    goto out;
-                }
-            }
-        }
-
-        if (proc_mask & NVME_PROC_READ_ONLY_ZONES) {
-            for (i = 0; i < ns->num_zones; i++, zone++) {
-                status = nvme_bulk_proc_zone(ns, zone, proc_mask, op_hndlr,
-                                             req);
-                if (status && status != NVME_NO_COMPLETE) {
-                    goto out;
-                }
-            }
-        }
-    }
-
-out:
-    return status;
-}
-
-typedef struct NvmeZoneResetAIOCB {
+typedef struct NvmeZoneMgmtAIOCB {
     BlockAIOCB common;
     BlockAIOCB *aiocb;
     NvmeRequest *req;
     int ret;
 
     bool all;
-    int idx;
-    NvmeZone *zone;
-} NvmeZoneResetAIOCB;
+    uint64_t offset;
+    uint64_t len;
+    BlockZoneOp op;
+} NvmeZoneMgmtAIOCB;
 
-static void nvme_zone_reset_cancel(BlockAIOCB *aiocb)
+static void nvme_zone_mgmt_send_cancel(BlockAIOCB *aiocb)
 {
-    NvmeZoneResetAIOCB *iocb = container_of(aiocb, NvmeZoneResetAIOCB, common);
-    NvmeRequest *req = iocb->req;
-    NvmeNamespace *ns = req->ns;
-
-    iocb->idx = ns->num_zones;
+    NvmeZoneMgmtAIOCB *iocb = container_of(aiocb, NvmeZoneMgmtAIOCB, common);
 
     iocb->ret = -ECANCELED;
 
@@ -3874,117 +3233,66 @@ static void nvme_zone_reset_cancel(BlockAIOCB *aiocb)
     }
 }
 
-static const AIOCBInfo nvme_zone_reset_aiocb_info = {
-    .aiocb_size = sizeof(NvmeZoneResetAIOCB),
-    .cancel_async = nvme_zone_reset_cancel,
+static const AIOCBInfo nvme_zone_mgmt_aiocb_info = {
+    .aiocb_size = sizeof(NvmeZoneMgmtAIOCB),
+    .cancel_async = nvme_zone_mgmt_send_cancel,
 };
 
-static void nvme_zone_reset_cb(void *opaque, int ret);
+static void nvme_zone_mgmt_send_cb(void *opaque, int ret);
 
-static void nvme_zone_reset_epilogue_cb(void *opaque, int ret)
+static void nvme_zone_mgmt_send_epilogue_cb(void *opaque, int ret)
 {
-    NvmeZoneResetAIOCB *iocb = opaque;
-    NvmeRequest *req = iocb->req;
-    NvmeNamespace *ns = req->ns;
-    int64_t moff;
-    int count;
+    NvmeZoneMgmtAIOCB *iocb = opaque;
+    NvmeNamespace *ns = iocb->req->ns;
 
     if (ret < 0 || iocb->ret < 0 || !ns->lbaf.ms) {
-        goto out;
+        iocb->ret = ret;
+        error_report("Invalid zone mgmt op %d", ret);
+        goto done;
     }
 
-    moff = nvme_moff(ns, iocb->zone->d.zslba);
-    count = nvme_m2b(ns, ns->zone_size);
-
-    iocb->aiocb = blk_aio_pwrite_zeroes(ns->blkconf.blk, moff, count,
-                                        BDRV_REQ_MAY_UNMAP,
-                                        nvme_zone_reset_cb, iocb);
     return;
 
-out:
-    nvme_zone_reset_cb(iocb, ret);
+done:
+    iocb->aiocb = NULL;
+    iocb->common.cb(iocb->common.opaque, iocb->ret);
+    qemu_aio_unref(iocb);
 }
 
-static void nvme_zone_reset_cb(void *opaque, int ret)
+static void nvme_zone_mgmt_send_cb(void *opaque, int ret)
 {
-    NvmeZoneResetAIOCB *iocb = opaque;
+    NvmeZoneMgmtAIOCB *iocb = opaque;
     NvmeRequest *req = iocb->req;
     NvmeNamespace *ns = req->ns;
+    BlockBackend *blk = ns->blkconf.blk;
 
-    if (iocb->ret < 0) {
-        goto done;
-    } else if (ret < 0) {
-        iocb->ret = ret;
-        goto done;
-    }
-
-    if (iocb->zone) {
-        nvme_zrm_reset(ns, iocb->zone);
-
-        if (!iocb->all) {
-            goto done;
-        }
-    }
-
-    while (iocb->idx < ns->num_zones) {
-        NvmeZone *zone = &ns->zone_array[iocb->idx++];
-
-        switch (nvme_get_zone_state(zone)) {
-        case NVME_ZONE_STATE_EMPTY:
-            if (!iocb->all) {
-                goto done;
-            }
-
-            continue;
-
-        case NVME_ZONE_STATE_EXPLICITLY_OPEN:
-        case NVME_ZONE_STATE_IMPLICITLY_OPEN:
-        case NVME_ZONE_STATE_CLOSED:
-        case NVME_ZONE_STATE_FULL:
-            iocb->zone = zone;
-            break;
-
-        default:
-            continue;
-        }
-
-        trace_pci_nvme_zns_zone_reset(zone->d.zslba);
-
-        iocb->aiocb = blk_aio_pwrite_zeroes(ns->blkconf.blk,
-                                            nvme_l2b(ns, zone->d.zslba),
-                                            nvme_l2b(ns, ns->zone_size),
-                                            BDRV_REQ_MAY_UNMAP,
-                                            nvme_zone_reset_epilogue_cb,
-                                            iocb);
-        return;
-    }
-
-done:
-    iocb->aiocb = NULL;
-
-    iocb->common.cb(iocb->common.opaque, iocb->ret);
-    qemu_aio_unref(iocb);
+    iocb->aiocb = blk_aio_zone_mgmt(blk, iocb->op, iocb->offset,
+                                    iocb->len,
+                                    nvme_zone_mgmt_send_epilogue_cb, iocb);
+    return;
 }
 
-static uint16_t nvme_zone_mgmt_send_zrwa_flush(NvmeCtrl *n, NvmeZone *zone,
+static uint16_t nvme_zone_mgmt_send_zrwa_flush(NvmeCtrl *n, uint32_t zidx,
                                                uint64_t elba, NvmeRequest *req)
 {
     NvmeNamespace *ns = req->ns;
     uint16_t ozcs = le16_to_cpu(ns->id_ns_zoned->ozcs);
-    uint64_t wp = zone->d.wp;
-    uint32_t nlb = elba - wp + 1;
-    uint16_t status;
-
+    BlockZoneWps *wps = blk_get_zone_wps(ns->blkconf.blk);
+    uint64_t *wp = &wps->wp[zidx];
+    uint64_t raw_wpv = BDRV_ZP_GET_WP(*wp);
+    uint8_t za = BDRV_ZP_GET_ZA(raw_wpv);
+    uint64_t wpv = BDRV_ZP_GET_WP(raw_wpv);
+    uint32_t nlb = elba - wpv + 1;
 
     if (!(ozcs & NVME_ID_NS_ZONED_OZCS_ZRWASUP)) {
         return NVME_INVALID_ZONE_OP | NVME_DNR;
     }
 
-    if (!(zone->d.za & NVME_ZA_ZRWA_VALID)) {
+    if (!(za & NVME_ZA_ZRWA_VALID)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    if (elba < wp || elba > wp + ns->zns.zrwas) {
+    if (elba < wpv || elba > wpv + ns->zns.zrwas) {
         return NVME_ZONE_BOUNDARY_ERROR | NVME_DNR;
     }
 
@@ -3992,37 +3300,36 @@ static uint16_t nvme_zone_mgmt_send_zrwa_flush(NvmeCtrl *n, NvmeZone *zone,
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    status = nvme_zrm_auto(n, ns, zone);
-    if (status) {
-        return status;
-    }
-
-    zone->w_ptr += nlb;
-
-    nvme_advance_zone_wp(ns, zone, nlb);
+    *wp += nlb;
 
     return NVME_SUCCESS;
 }
 
 static inline uint8_t *nvme_get_zd_extension(NvmeNamespace *ns,
-                                        uint32_t zone_idx)
+                                             uint32_t zone_idx)
 {
     return &ns->zd_extensions[zone_idx * blk_get_zd_ext_size(ns->blkconf.blk)];
 }
 
+#define BLK_ZO_UNSUP 0x22
 static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeZoneSendCmd *cmd = (NvmeZoneSendCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
-    NvmeZone *zone;
-    NvmeZoneResetAIOCB *iocb;
-    uint8_t *zd_ext;
+    NvmeZoneMgmtAIOCB *iocb;
     uint64_t slba = 0;
     uint32_t zone_idx = 0;
     uint16_t status;
     uint8_t action = cmd->zsa;
+    uint8_t *zd_ext;
+    uint64_t offset, len;
+    BlockBackend *blk = ns->blkconf.blk;
+    uint32_t zone_size = blk_get_zone_size(blk);
+    uint64_t size = zone_size * blk_get_nr_zones(blk);
+    BlockZoneOp op = BLK_ZO_UNSUP;
+    /* support flag, true when the op is supported */
+    bool flag = true;
     bool all;
-    enum NvmeZoneProcessingMask proc_mask = NVME_PROC_CURRENT_ZONE;
 
     all = cmd->zsflags & NVME_ZSFLAG_SELECT_ALL;
 
@@ -4033,82 +3340,51 @@ static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
         if (status) {
             return status;
         }
-    }
-
-    zone = &ns->zone_array[zone_idx];
-    if (slba != zone->d.zslba && action != NVME_ZONE_ACTION_ZRWA_FLUSH) {
-        trace_pci_nvme_err_unaligned_zone_cmd(action, slba, zone->d.zslba);
-        return NVME_INVALID_FIELD | NVME_DNR;
+        len = zone_size;
+    } else {
+        len = size;
     }
 
     switch (action) {
 
     case NVME_ZONE_ACTION_OPEN:
-        if (all) {
-            proc_mask = NVME_PROC_CLOSED_ZONES;
-        }
+        op = BLK_ZO_OPEN;
         trace_pci_nvme_open_zone(slba, zone_idx, all);
-        status = nvme_do_zone_op(ns, zone, proc_mask, nvme_open_zone, req);
         break;
 
     case NVME_ZONE_ACTION_CLOSE:
-        if (all) {
-            proc_mask = NVME_PROC_OPENED_ZONES;
-        }
+        op = BLK_ZO_CLOSE;
         trace_pci_nvme_close_zone(slba, zone_idx, all);
-        status = nvme_do_zone_op(ns, zone, proc_mask, nvme_close_zone, req);
         break;
 
     case NVME_ZONE_ACTION_FINISH:
-        if (all) {
-            proc_mask = NVME_PROC_OPENED_ZONES | NVME_PROC_CLOSED_ZONES;
-        }
+        op = BLK_ZO_FINISH;
         trace_pci_nvme_finish_zone(slba, zone_idx, all);
-        status = nvme_do_zone_op(ns, zone, proc_mask, nvme_finish_zone, req);
         break;
 
     case NVME_ZONE_ACTION_RESET:
+        op = BLK_ZO_RESET;
         trace_pci_nvme_reset_zone(slba, zone_idx, all);
-
-        iocb = blk_aio_get(&nvme_zone_reset_aiocb_info, ns->blkconf.blk,
-                           nvme_misc_cb, req);
-
-        iocb->req = req;
-        iocb->ret = 0;
-        iocb->all = all;
-        iocb->idx = zone_idx;
-        iocb->zone = NULL;
-
-        req->aiocb = &iocb->common;
-        nvme_zone_reset_cb(iocb, 0);
-
-        return NVME_NO_COMPLETE;
+        break;
 
     case NVME_ZONE_ACTION_OFFLINE:
-        if (all) {
-            proc_mask = NVME_PROC_READ_ONLY_ZONES;
-        }
+        op = BLK_ZO_OFFLINE;
         trace_pci_nvme_offline_zone(slba, zone_idx, all);
-        status = nvme_do_zone_op(ns, zone, proc_mask, nvme_offline_zone, req);
         break;
 
     case NVME_ZONE_ACTION_SET_ZD_EXT:
+        int zd_ext_size = blk_get_zd_ext_size(blk);
         trace_pci_nvme_set_descriptor_extension(slba, zone_idx);
-        if (all || !blk_get_zd_ext_size(ns->blkconf.blk)) {
+        if (all || !zd_ext_size) {
             return NVME_INVALID_FIELD | NVME_DNR;
         }
         zd_ext = nvme_get_zd_extension(ns, zone_idx);
-        status = nvme_h2c(n, zd_ext, blk_get_zd_ext_size(ns->blkconf.blk), req);
+        status = nvme_h2c(n, zd_ext, zd_ext_size, req);
         if (status) {
             trace_pci_nvme_err_zd_extension_map_error(zone_idx);
             return status;
         }
-
-        status = nvme_set_zd_ext(ns, zone);
-        if (status == NVME_SUCCESS) {
-            trace_pci_nvme_zd_extension_set(zone_idx);
-            return status;
-        }
+        trace_pci_nvme_zd_extension_set(zone_idx);
         break;
 
     case NVME_ZONE_ACTION_ZRWA_FLUSH:
@@ -4116,16 +3392,34 @@ static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
             return NVME_INVALID_FIELD | NVME_DNR;
         }
 
-        return nvme_zone_mgmt_send_zrwa_flush(n, zone, slba, req);
+        return nvme_zone_mgmt_send_zrwa_flush(n, zone_idx, slba, req);
 
     default:
         trace_pci_nvme_err_invalid_mgmt_action(action);
         status = NVME_INVALID_FIELD;
     }
 
+    if (flag && (op != BLK_ZO_UNSUP)) {
+        iocb = blk_aio_get(&nvme_zone_mgmt_aiocb_info, ns->blkconf.blk,
+                           nvme_misc_cb, req);
+        iocb->req = req;
+        iocb->ret = 0;
+        iocb->all = all;
+        /* Convert it to bytes for accessing block layers */
+        offset = nvme_l2b(ns, slba);
+        iocb->offset = offset;
+        iocb->len = len;
+        iocb->op = op;
+
+        req->aiocb = &iocb->common;
+        nvme_zone_mgmt_send_cb(iocb, 0);
+
+        return NVME_NO_COMPLETE;
+    }
+
     if (status == NVME_ZONE_INVAL_TRANSITION) {
         trace_pci_nvme_err_invalid_zone_state_transition(action, slba,
-                                                         zone->d.za);
+                                                         TO_DO_ZA);
     }
     if (status) {
         status |= NVME_DNR;
@@ -4134,50 +3428,144 @@ static uint16_t nvme_zone_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
     return status;
 }
 
-static bool nvme_zone_matches_filter(uint32_t zafs, NvmeZone *zl)
+static bool nvme_zone_matches_filter(uint32_t zafs, BlockZoneState zs)
 {
-    NvmeZoneState zs = nvme_get_zone_state(zl);
-
     switch (zafs) {
     case NVME_ZONE_REPORT_ALL:
         return true;
     case NVME_ZONE_REPORT_EMPTY:
-        return zs == NVME_ZONE_STATE_EMPTY;
+        return zs == BLK_ZS_EMPTY;
     case NVME_ZONE_REPORT_IMPLICITLY_OPEN:
-        return zs == NVME_ZONE_STATE_IMPLICITLY_OPEN;
+        return zs == BLK_ZS_IOPEN;
     case NVME_ZONE_REPORT_EXPLICITLY_OPEN:
-        return zs == NVME_ZONE_STATE_EXPLICITLY_OPEN;
+        return zs == BLK_ZS_EOPEN;
     case NVME_ZONE_REPORT_CLOSED:
-        return zs == NVME_ZONE_STATE_CLOSED;
+        return zs == BLK_ZS_CLOSED;
     case NVME_ZONE_REPORT_FULL:
-        return zs == NVME_ZONE_STATE_FULL;
+        return zs == BLK_ZS_FULL;
     case NVME_ZONE_REPORT_READ_ONLY:
-        return zs == NVME_ZONE_STATE_READ_ONLY;
+        return zs == BLK_ZS_RDONLY;
     case NVME_ZONE_REPORT_OFFLINE:
-        return zs == NVME_ZONE_STATE_OFFLINE;
+        return zs == BLK_ZS_OFFLINE;
     default:
         return false;
     }
 }
 
+static void nvme_zone_mgmt_recv_completed_cb(void *opaque, int ret)
+{
+    NvmeZoneCmdAIOCB *iocb = opaque;
+    NvmeRequest *req = iocb->req;
+    NvmeCmd *cmd = iocb->cmd;
+    uint32_t dw13 = le32_to_cpu(cmd->cdw13);
+    int64_t zrp_size, j = 0;
+    uint32_t zrasf;
+    g_autofree void *buf = NULL;
+    void *buf_p;
+    NvmeZoneReportHeader *zrp_hdr;
+    uint64_t nz = iocb->zone_report_data.nr_zones;
+    BlockZoneDescriptor *in_zone = iocb->zone_report_data.zones;
+    NvmeZoneDescr *out_zone;
+
+    if (ret < 0) {
+        error_report("Invalid zone recv %d", ret);
+        goto out;
+    }
+
+    zrasf = (dw13 >> 8) & 0xff;
+    if (zrasf > NVME_ZONE_REPORT_OFFLINE) {
+        error_report("Nvme invalid field");
+        return;
+    }
+
+    zrp_size = sizeof(NvmeZoneReportHeader) + sizeof(NvmeZoneDescr) * nz;
+    buf = g_malloc0(zrp_size);
+
+    zrp_hdr = buf;
+    zrp_hdr->nr_zones = cpu_to_le64(nz);
+    buf_p = buf + sizeof(NvmeZoneReportHeader);
+
+    for (; j < nz; j++) {
+        out_zone = buf_p;
+        buf_p += sizeof(NvmeZoneDescr);
+
+        BlockZoneState zs = in_zone[j].state;
+        if (!nvme_zone_matches_filter(zrasf, zs)) {
+            continue;
+        }
+
+        *out_zone = (NvmeZoneDescr) {
+            .zslba = nvme_b2l(req->ns, in_zone[j].start),
+            .zcap = nvme_b2l(req->ns, in_zone[j].cap),
+            .wp = nvme_b2l(req->ns, in_zone[j].wp),
+        };
+
+        switch (in_zone[j].type) {
+        case BLK_ZT_CONV:
+            out_zone->zt = NVME_ZONE_TYPE_RESERVED;
+            break;
+        case BLK_ZT_SWR:
+            out_zone->zt = NVME_ZONE_TYPE_SEQ_WRITE;
+            break;
+        case BLK_ZT_SWP:
+            out_zone->zt = NVME_ZONE_TYPE_RESERVED;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        switch (zs) {
+        case BLK_ZS_RDONLY:
+            out_zone->zs = NVME_ZONE_STATE_READ_ONLY << 4;
+            break;
+        case BLK_ZS_OFFLINE:
+            out_zone->zs = NVME_ZONE_STATE_OFFLINE << 4;
+            break;
+        case BLK_ZS_EMPTY:
+            out_zone->zs = NVME_ZONE_STATE_EMPTY << 4;
+            break;
+        case BLK_ZS_CLOSED:
+            out_zone->zs = NVME_ZONE_STATE_CLOSED << 4;
+            break;
+        case BLK_ZS_FULL:
+            out_zone->zs = NVME_ZONE_STATE_FULL << 4;
+            break;
+        case BLK_ZS_EOPEN:
+            out_zone->zs = NVME_ZONE_STATE_EXPLICITLY_OPEN << 4;
+            break;
+        case BLK_ZS_IOPEN:
+            out_zone->zs = NVME_ZONE_STATE_IMPLICITLY_OPEN << 4;
+            break;
+        case BLK_ZS_NOT_WP:
+            out_zone->zs = NVME_ZONE_STATE_RESERVED << 4;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    nvme_c2h(iocb->n, (uint8_t *)buf, zrp_size, req);
+
+out:
+    g_free(iocb->zone_report_data.zones);
+    g_free(iocb);
+    return;
+}
+
 static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeCmd *cmd = (NvmeCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
+    BlockBackend *blk = ns->blkconf.blk;
+    NvmeZoneCmdAIOCB *iocb;
     /* cdw12 is zero-based number of dwords to return. Convert to bytes */
     uint32_t data_size = (le32_to_cpu(cmd->cdw12) + 1) << 2;
     uint32_t dw13 = le32_to_cpu(cmd->cdw13);
-    uint32_t zone_idx, zra, zrasf, partial;
-    uint64_t max_zones, nr_zones = 0;
+    uint32_t zone_idx, zra, zrasf, partial, nr_zones;
     uint16_t status;
     uint64_t slba;
-    NvmeZoneDescr *z;
-    NvmeZone *zone;
-    NvmeZoneReportHeader *header;
-    void *buf, *buf_p;
     size_t zone_entry_sz;
-    int i;
-
+    int64_t offset;
     req->status = NVME_SUCCESS;
 
     status = nvme_get_mgmt_zone_slba_idx(ns, cmd, &slba, &zone_idx);
@@ -4208,64 +3596,31 @@ static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
         return status;
     }
 
-    partial = (dw13 >> 16) & 0x01;
-
     zone_entry_sz = sizeof(NvmeZoneDescr);
     if (zra == NVME_ZONE_REPORT_EXTENDED) {
-        zone_entry_sz += blk_get_zd_ext_size(ns->blkconf.blk) ;
+        zone_entry_sz += blk_get_zd_ext_size(ns->blkconf.blk);
     }
 
-    max_zones = (data_size - sizeof(NvmeZoneReportHeader)) / zone_entry_sz;
-    buf = g_malloc0(data_size);
-
-    zone = &ns->zone_array[zone_idx];
-    for (i = zone_idx; i < ns->num_zones; i++) {
-        if (partial && nr_zones >= max_zones) {
-            break;
-        }
-        if (nvme_zone_matches_filter(zrasf, zone++)) {
-            nr_zones++;
-        }
-    }
-    header = buf;
-    header->nr_zones = cpu_to_le64(nr_zones);
-
-    buf_p = buf + sizeof(NvmeZoneReportHeader);
-    for (; zone_idx < ns->num_zones && max_zones > 0; zone_idx++) {
-        zone = &ns->zone_array[zone_idx];
-        if (nvme_zone_matches_filter(zrasf, zone)) {
-            z = buf_p;
-            buf_p += sizeof(NvmeZoneDescr);
-
-            z->zt = zone->d.zt;
-            z->zs = zone->d.zs;
-            z->zcap = cpu_to_le64(zone->d.zcap);
-            z->zslba = cpu_to_le64(zone->d.zslba);
-            z->za = zone->d.za;
-
-            if (nvme_wp_is_valid(zone)) {
-                z->wp = cpu_to_le64(zone->d.wp);
-            } else {
-                z->wp = cpu_to_le64(~0ULL);
-            }
-
-            if (zra == NVME_ZONE_REPORT_EXTENDED) {
-                int zd_ext_size = blk_get_zd_ext_size(ns->blkconf.blk);
-                if (zone->d.za & NVME_ZA_ZD_EXT_VALID) {
-                    memcpy(buf_p, nvme_get_zd_extension(ns, zone_idx),
-                           zd_ext_size);
-                }
-                buf_p += zd_ext_size;
-            }
-
-            max_zones--;
-        }
+    offset = nvme_l2b(ns, slba);
+    nr_zones = (data_size - sizeof(NvmeZoneReportHeader)) / zone_entry_sz;
+    partial = (dw13 >> 16) & 0x01;
+    if (!partial) {
+        nr_zones = blk_get_nr_zones(blk);
+        offset = 0;
     }
 
-    status = nvme_c2h(n, (uint8_t *)buf, data_size, req);
-
-    g_free(buf);
-
+    iocb = g_malloc0(sizeof(NvmeZoneCmdAIOCB));
+    iocb->req = req;
+    iocb->n = n;
+    iocb->cmd = cmd;
+    iocb->zone_report_data.nr_zones = nr_zones;
+    iocb->zone_report_data.zones = g_malloc0(
+        sizeof(BlockZoneDescriptor) * nr_zones);
+
+    blk_aio_zone_report(blk, offset,
+                        &iocb->zone_report_data.nr_zones,
+                        iocb->zone_report_data.zones,
+                        nvme_zone_mgmt_recv_completed_cb, iocb);
     return status;
 }
 
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 45c08391f5..63106a0f27 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -219,36 +219,10 @@ static int nvme_ns_zoned_check_calc_geometry(NvmeNamespace *ns, Error **errp)
 static void nvme_ns_zoned_init_state(NvmeNamespace *ns)
 {
     BlockBackend *blk = ns->blkconf.blk;
-    uint64_t start = 0, zone_size = ns->zone_size;
-    uint64_t capacity = ns->num_zones * zone_size;
-    NvmeZone *zone;
-    int i;
-
-    ns->zone_array = g_new0(NvmeZone, ns->num_zones);
     if (blk_get_zone_extension(blk)) {
         ns->zd_extensions = blk_get_zone_extension(blk);
     }
 
-    QTAILQ_INIT(&ns->exp_open_zones);
-    QTAILQ_INIT(&ns->imp_open_zones);
-    QTAILQ_INIT(&ns->closed_zones);
-    QTAILQ_INIT(&ns->full_zones);
-
-    zone = ns->zone_array;
-    for (i = 0; i < ns->num_zones; i++, zone++) {
-        if (start + zone_size > capacity) {
-            zone_size = capacity - start;
-        }
-        zone->d.zt = NVME_ZONE_TYPE_SEQ_WRITE;
-        nvme_set_zone_state(zone, NVME_ZONE_STATE_EMPTY);
-        zone->d.za = 0;
-        zone->d.zcap = ns->zone_capacity;
-        zone->d.zslba = start;
-        zone->d.wp = start;
-        zone->w_ptr = start;
-        start += zone_size;
-    }
-
     ns->zone_size_log2 = 0;
     if (is_power_of_2(ns->zone_size)) {
         ns->zone_size_log2 = 63 - clz64(ns->zone_size);
@@ -319,56 +293,12 @@ static void nvme_ns_init_zoned(NvmeNamespace *ns)
     ns->id_ns_zoned = id_ns_z;
 }
 
-static void nvme_clear_zone(NvmeNamespace *ns, NvmeZone *zone)
-{
-    uint8_t state;
-
-    zone->w_ptr = zone->d.wp;
-    state = nvme_get_zone_state(zone);
-    if (zone->d.wp != zone->d.zslba ||
-        (zone->d.za & NVME_ZA_ZD_EXT_VALID)) {
-        if (state != NVME_ZONE_STATE_CLOSED) {
-            trace_pci_nvme_clear_ns_close(state, zone->d.zslba);
-            nvme_set_zone_state(zone, NVME_ZONE_STATE_CLOSED);
-        }
-        nvme_aor_inc_active(ns);
-        QTAILQ_INSERT_HEAD(&ns->closed_zones, zone, entry);
-    } else {
-        trace_pci_nvme_clear_ns_reset(state, zone->d.zslba);
-        if (zone->d.za & NVME_ZA_ZRWA_VALID) {
-            zone->d.za &= ~NVME_ZA_ZRWA_VALID;
-            ns->zns.numzrwa++;
-        }
-        nvme_set_zone_state(zone, NVME_ZONE_STATE_EMPTY);
-    }
-}
-
 /*
  * Close all the zones that are currently open.
  */
 static void nvme_zoned_ns_shutdown(NvmeNamespace *ns)
 {
-    NvmeZone *zone, *next;
-
-    QTAILQ_FOREACH_SAFE(zone, &ns->closed_zones, entry, next) {
-        QTAILQ_REMOVE(&ns->closed_zones, zone, entry);
-        nvme_aor_dec_active(ns);
-        nvme_clear_zone(ns, zone);
-    }
-    QTAILQ_FOREACH_SAFE(zone, &ns->imp_open_zones, entry, next) {
-        QTAILQ_REMOVE(&ns->imp_open_zones, zone, entry);
-        nvme_aor_dec_open(ns);
-        nvme_aor_dec_active(ns);
-        nvme_clear_zone(ns, zone);
-    }
-    QTAILQ_FOREACH_SAFE(zone, &ns->exp_open_zones, entry, next) {
-        QTAILQ_REMOVE(&ns->exp_open_zones, zone, entry);
-        nvme_aor_dec_open(ns);
-        nvme_aor_dec_active(ns);
-        nvme_clear_zone(ns, zone);
-    }
-
-    assert(ns->nr_open_zones == 0);
+    /* Set states (exp/imp_open/closed/full) to empty */
 }
 
 static NvmeRuHandle *nvme_find_ruh_by_attr(NvmeEnduranceGroup *endgrp,
@@ -662,7 +592,6 @@ void nvme_ns_cleanup(NvmeNamespace *ns)
 {
     if (blk_get_zone_model(ns->blkconf.blk)) {
         g_free(ns->id_ns_zoned);
-        g_free(ns->zone_array);
     }
 
     if (ns->endgrp && ns->endgrp->fdp.enabled) {
@@ -776,10 +705,6 @@ static Property nvme_ns_props[] = {
     DEFINE_PROP_UINT8("msrc", NvmeNamespace, params.msrc, 127),
     DEFINE_PROP_BOOL("zoned.cross_read", NvmeNamespace,
                      params.cross_zone_read, false),
-    DEFINE_PROP_UINT32("zoned.max_active", NvmeNamespace,
-                       params.max_active_zones, 0),
-    DEFINE_PROP_UINT32("zoned.max_open", NvmeNamespace,
-                       params.max_open_zones, 0),
     DEFINE_PROP_UINT32("zoned.numzrwa", NvmeNamespace, params.numzrwa, 0),
     DEFINE_PROP_SIZE("zoned.zrwas", NvmeNamespace, params.zrwas, 0),
     DEFINE_PROP_SIZE("zoned.zrwafg", NvmeNamespace, params.zrwafg, -1),
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 37007952fc..c2d1b07f88 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -150,6 +150,9 @@ static inline NvmeNamespace *nvme_subsys_ns(NvmeSubsystem *subsys,
 #define NVME_NS(obj) \
     OBJECT_CHECK(NvmeNamespace, (obj), TYPE_NVME_NS)
 
+#define TO_DO_STATE 0
+#define TO_DO_ZA 0
+
 typedef struct NvmeZone {
     NvmeZoneDescr   d;
     uint64_t        w_ptr;
@@ -190,8 +193,6 @@ typedef struct NvmeNamespaceParams {
     uint8_t  msrc;
 
     bool     cross_zone_read;
-    uint32_t max_active_zones;
-    uint32_t max_open_zones;
 
     uint32_t numzrwa;
     uint64_t zrwas;
@@ -228,11 +229,10 @@ typedef struct NvmeNamespace {
     QTAILQ_ENTRY(NvmeNamespace) entry;
 
     NvmeIdNsZoned   *id_ns_zoned;
-    NvmeZone        *zone_array;
-    QTAILQ_HEAD(, NvmeZone) exp_open_zones;
-    QTAILQ_HEAD(, NvmeZone) imp_open_zones;
-    QTAILQ_HEAD(, NvmeZone) closed_zones;
-    QTAILQ_HEAD(, NvmeZone) full_zones;
+    uint32_t        *exp_open_zones;
+    uint32_t        *imp_open_zones;
+    uint32_t        *closed_zones;
+    uint32_t        *full_zones;
     uint32_t        num_zones;
     uint64_t        zone_size;
     uint64_t        zone_capacity;
@@ -265,6 +265,12 @@ static inline uint32_t nvme_nsid(NvmeNamespace *ns)
     return 0;
 }
 
+/* Bytes to LBAs */
+static inline uint64_t nvme_b2l(NvmeNamespace *ns, uint64_t lba)
+{
+    return lba >> ns->lbaf.ds;
+}
+
 static inline size_t nvme_l2b(NvmeNamespace *ns, uint64_t lba)
 {
     return lba << ns->lbaf.ds;
@@ -285,70 +291,9 @@ static inline bool nvme_ns_ext(NvmeNamespace *ns)
     return !!NVME_ID_NS_FLBAS_EXTENDED(ns->id_ns.flbas);
 }
 
-static inline NvmeZoneState nvme_get_zone_state(NvmeZone *zone)
+static inline NvmeZoneState nvme_get_zone_state(uint64_t wp)
 {
-    return zone->d.zs >> 4;
-}
-
-static inline void nvme_set_zone_state(NvmeZone *zone, NvmeZoneState state)
-{
-    zone->d.zs = state << 4;
-}
-
-static inline uint64_t nvme_zone_rd_boundary(NvmeNamespace *ns, NvmeZone *zone)
-{
-    return zone->d.zslba + ns->zone_size;
-}
-
-static inline uint64_t nvme_zone_wr_boundary(NvmeZone *zone)
-{
-    return zone->d.zslba + zone->d.zcap;
-}
-
-static inline bool nvme_wp_is_valid(NvmeZone *zone)
-{
-    uint8_t st = nvme_get_zone_state(zone);
-
-    return st != NVME_ZONE_STATE_FULL &&
-           st != NVME_ZONE_STATE_READ_ONLY &&
-           st != NVME_ZONE_STATE_OFFLINE;
-}
-
-static inline void nvme_aor_inc_open(NvmeNamespace *ns)
-{
-    assert(ns->nr_open_zones >= 0);
-    if (ns->params.max_open_zones) {
-        ns->nr_open_zones++;
-        assert(ns->nr_open_zones <= ns->params.max_open_zones);
-    }
-}
-
-static inline void nvme_aor_dec_open(NvmeNamespace *ns)
-{
-    if (ns->params.max_open_zones) {
-        assert(ns->nr_open_zones > 0);
-        ns->nr_open_zones--;
-    }
-    assert(ns->nr_open_zones >= 0);
-}
-
-static inline void nvme_aor_inc_active(NvmeNamespace *ns)
-{
-    assert(ns->nr_active_zones >= 0);
-    if (ns->params.max_active_zones) {
-        ns->nr_active_zones++;
-        assert(ns->nr_active_zones <= ns->params.max_active_zones);
-    }
-}
-
-static inline void nvme_aor_dec_active(NvmeNamespace *ns)
-{
-    if (ns->params.max_active_zones) {
-        assert(ns->nr_active_zones > 0);
-        ns->nr_active_zones--;
-        assert(ns->nr_active_zones >= ns->nr_open_zones);
-    }
-    assert(ns->nr_active_zones >= 0);
+    return wp >> 60;
 }
 
 static inline void nvme_fdp_stat_inc(uint64_t *a, uint64_t b)
diff --git a/include/block/block-common.h b/include/block/block-common.h
index a846023a09..7690b05149 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -87,6 +87,7 @@ typedef enum BlockZoneOp {
     BLK_ZO_CLOSE,
     BLK_ZO_FINISH,
     BLK_ZO_RESET,
+    BLK_ZO_OFFLINE,
 } BlockZoneOp;
 
 typedef enum BlockZoneModel {
@@ -266,6 +267,13 @@ typedef enum {
  */
 #define BDRV_ZT_IS_CONV(wp)    (wp & (1ULL << 63))
 
+/*
+ * Clear the zone state, type and attribute information in the wp.
+ */
+#define BDRV_ZP_GET_WP(wp)     ((wp << 6) >> 6)
+#define BDRV_ZP_GET_ZS(wp)     (wp >> 60)
+#define BDRV_ZP_GET_ZA(wp)      (wp & ((1ULL << 8) - 1ULL) << 51)
+
 #define BDRV_REQUEST_MAX_SECTORS MIN_CONST(SIZE_MAX >> BDRV_SECTOR_BITS, \
                                            INT_MAX >> BDRV_SECTOR_BITS)
 #define BDRV_REQUEST_MAX_BYTES (BDRV_REQUEST_MAX_SECTORS << BDRV_SECTOR_BITS)
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 825b8dac55..9a81f99eee 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -916,6 +916,8 @@ typedef struct BlockLimits {
 
     /* size of data that is associated with a zone in bytes */
     uint32_t zd_extension_size;
+
+    uint8_t zone_attribute;
 } BlockLimits;
 
 typedef struct BdrvOpBlocker BdrvOpBlocker;
-- 
2.40.1


