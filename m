Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 080458D5912
	for <lists+qemu-devel@lfdr.de>; Fri, 31 May 2024 05:37:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCt46-0007l9-Kn; Thu, 30 May 2024 23:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sCt43-0007ji-7X
 for qemu-devel@nongnu.org; Thu, 30 May 2024 23:36:23 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sCt40-0003hO-Qj
 for qemu-devel@nongnu.org; Thu, 30 May 2024 23:36:22 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c19bba897bso1240690a91.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 20:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1717126579; x=1717731379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e4D3PnngqHPxRDkeRL1R+Rvt/tviYzI+zsCa4n3NVaA=;
 b=jz2xkSdel00rRYv/TFLUIcCC3FKER7G9SO2F0l++iDpTVPFY4bYPFy3iqdsW+O38mS
 0d298BSo9obcH39J7PjHGLXlRV0qeb62h3h1egT/i2O/gbkx6/LK/LoEn5emgAP2olli
 5fUOyplTA6IE3JbgkQGczjC1JgfcEkIj/Hb8lvrbnq2MhBD6L8VhPCiukMAhFY2O6Qa0
 UUKNTS3CfdoFD4PBHMsewTC1pILjcJC64+U8kG0R4dvMJ+Ar8IiIwVAE+HlWE9Bn/Kyu
 asiwHjN7joluTUJ2zf855OQk4ADAHQzIRUetFdLuh8ySwLP+Yza51ZR3y/gL0m3QdmKR
 imtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717126579; x=1717731379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e4D3PnngqHPxRDkeRL1R+Rvt/tviYzI+zsCa4n3NVaA=;
 b=pgvqDVgYVHrarq2oFNjmFOXROZnzm0o0i9PpbN1a1vPzGv0HShM8NgpgwOKKv5JlnJ
 A8jTDs7XKVZYQdbRsHdZwDn/3TOXrSgnsU39ZaIQ89owf35BqmYVt5yaGa0q+BwGpJ89
 /h9m/leNY59aH9sz/qJlfYtSppXe+3NN5ZGJNKVDKNgE/1kFcPwf2NGtshTUVhKm49BV
 fC81Px4myW6XqWMQSuYaCyREzoKfk25jWcthRAc2pt36f/BRHWMI+SpiCF25U33TIzIu
 JcOpDBfRhsn1r/tllQGCg89NirA+hnzQ7+/Es9ojfevLxaJsPHBeSf1NuYLT8Ux5Hqxr
 U2Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlQ1piy1LNQcAkie/dCKyxGf5lLz46FRJiFLDznYAz5sBw1IHxiwLMBaMf4EwARFFM9SLUGC+YhJ/UPpi4EUVuk7XdhQ0=
X-Gm-Message-State: AOJu0Yw7dAI/ll+85S4QoAgwJwuK1J8SA7rDZRtBFzKjcD2ZZB162/pN
 o/TjK/zHxRJxc4qCRQmT0YO1HjiI5k2OI1wIz+73cjYQlMHZMuSuks02NzaxUm4=
X-Google-Smtp-Source: AGHT+IE1DNPoCGppe51f93TW86HmFUa44hFycmtOA7E5H6GYUJcQoDU+UD5iaj04SbT/IHWe+h4TaQ==
X-Received: by 2002:a17:90b:218c:b0:2b9:78b9:fefe with SMTP id
 98e67ed59e1d1-2c1dc5cd72bmr556675a91.47.1717126579315; 
 Thu, 30 May 2024 20:36:19 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.142])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a777e989sm2457629a91.29.2024.05.30.20.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 20:36:18 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v4 09/10] hw/nvme: add reservation protocal command
Date: Fri, 31 May 2024 11:34:54 +0800
Message-Id: <20240531033455.3774806-10-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240531033455.3774806-1-luchangqi.123@bytedance.com>
References: <20240531033455.3774806-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add reservation acquire, reservation register,
reservation release and reservation report commands
in the nvme device layer.

By introducing these commands, this enables the nvme
device to perform reservation-related tasks, including
querying keys, querying reservation status, registering
reservation keys, initiating and releasing reservations,
as well as clearing and preempting reservations held by
other keys.

These commands are crucial for management and control of
shared storage resources in a persistent manner.
Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 hw/nvme/ctrl.c       | 321 ++++++++++++++++++++++++++++++++++++++++++-
 hw/nvme/nvme.h       |   4 +
 include/block/nvme.h |  37 +++++
 3 files changed, 361 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 182307a48b..033abd0afe 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -294,6 +294,10 @@ static const uint32_t nvme_cse_iocs_nvm[256] = {
     [NVME_CMD_COMPARE]              = NVME_CMD_EFF_CSUPP,
     [NVME_CMD_IO_MGMT_RECV]         = NVME_CMD_EFF_CSUPP,
     [NVME_CMD_IO_MGMT_SEND]         = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
+    [NVME_CMD_RESV_REGISTER]        = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_RESV_REPORT]          = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_RESV_ACQUIRE]         = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_RESV_RELEASE]         = NVME_CMD_EFF_CSUPP,
 };
 
 static const uint32_t nvme_cse_iocs_zoned[256] = {
@@ -308,6 +312,10 @@ static const uint32_t nvme_cse_iocs_zoned[256] = {
     [NVME_CMD_ZONE_APPEND]          = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_CMD_ZONE_MGMT_SEND]       = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_CMD_ZONE_MGMT_RECV]       = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_RESV_REGISTER]        = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_RESV_REPORT]          = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_RESV_ACQUIRE]         = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_RESV_RELEASE]         = NVME_CMD_EFF_CSUPP,
 };
 
 static void nvme_process_sq(void *opaque);
@@ -1745,6 +1753,7 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
 
     switch (req->cmd.opcode) {
     case NVME_CMD_READ:
+    case NVME_CMD_RESV_REPORT:
         status = NVME_UNRECOVERED_READ;
         break;
     case NVME_CMD_FLUSH:
@@ -1752,6 +1761,9 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
     case NVME_CMD_WRITE_ZEROES:
     case NVME_CMD_ZONE_APPEND:
     case NVME_CMD_COPY:
+    case NVME_CMD_RESV_REGISTER:
+    case NVME_CMD_RESV_ACQUIRE:
+    case NVME_CMD_RESV_RELEASE:
         status = NVME_WRITE_FAULT;
         break;
     default:
@@ -2127,7 +2139,10 @@ static inline bool nvme_is_write(NvmeRequest *req)
 
     return rw->opcode == NVME_CMD_WRITE ||
            rw->opcode == NVME_CMD_ZONE_APPEND ||
-           rw->opcode == NVME_CMD_WRITE_ZEROES;
+           rw->opcode == NVME_CMD_WRITE_ZEROES ||
+           rw->opcode == NVME_CMD_RESV_REGISTER ||
+           rw->opcode == NVME_CMD_RESV_ACQUIRE ||
+           rw->opcode == NVME_CMD_RESV_RELEASE;
 }
 
 static void nvme_misc_cb(void *opaque, int ret)
@@ -2692,6 +2707,302 @@ static uint16_t nvme_verify(NvmeCtrl *n, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
 
+typedef struct NvmeKeyInfo {
+    uint64_t cr_key;
+    uint64_t nr_key;
+} NvmeKeyInfo;
+
+static uint16_t nvme_resv_register(NvmeCtrl *n, NvmeRequest *req)
+{
+    int ret;
+    NvmeKeyInfo key_info;
+    NvmeNamespace *ns = req->ns;
+    uint32_t cdw10 = le32_to_cpu(req->cmd.cdw10);
+    bool ignore_key = cdw10 >> 3 & 0x1;
+    uint8_t action = cdw10 & 0x7;
+    uint8_t ptpl = cdw10 >> 30 & 0x3;
+    bool aptpl;
+
+    switch (ptpl) {
+    case NVME_RESV_PTPL_NO_CHANGE:
+        aptpl = (ns->id_ns.rescap & NVME_PR_CAP_PTPL) ? true : false;
+        break;
+    case NVME_RESV_PTPL_DISABLE:
+        aptpl = false;
+        break;
+    case NVME_RESV_PTPL_ENABLE:
+        aptpl = true;
+        break;
+    default:
+        return NVME_INVALID_FIELD;
+    }
+
+    ret = nvme_h2c(n, (uint8_t *)&key_info, sizeof(NvmeKeyInfo), req);
+    if (ret) {
+        return ret;
+    }
+
+    switch (action) {
+    case NVME_RESV_REGISTER_ACTION_REGISTER:
+        req->aiocb = blk_aio_pr_register(ns->blkconf.blk, 0,
+                                         key_info.nr_key, 0, aptpl,
+                                         ignore_key, nvme_misc_cb,
+                                         req);
+        break;
+    case NVME_RESV_REGISTER_ACTION_UNREGISTER:
+        req->aiocb = blk_aio_pr_register(ns->blkconf.blk, key_info.cr_key, 0,
+                                         0, aptpl, ignore_key,
+                                         nvme_misc_cb, req);
+        break;
+    case NVME_RESV_REGISTER_ACTION_REPLACE:
+        req->aiocb = blk_aio_pr_register(ns->blkconf.blk, key_info.cr_key,
+                                         key_info.nr_key, 0, aptpl, ignore_key,
+                                         nvme_misc_cb, req);
+        break;
+    default:
+        return NVME_INVALID_FIELD;
+    }
+
+    return NVME_NO_COMPLETE;
+}
+
+static uint16_t nvme_resv_release(NvmeCtrl *n, NvmeRequest *req)
+{
+    int ret;
+    uint64_t cr_key;
+    NvmeNamespace *ns = req->ns;
+    uint32_t cdw10 = le32_to_cpu(req->cmd.cdw10);
+    uint8_t action = cdw10 & 0x7;
+    NvmeResvType type = cdw10 >> 8 & 0xff;
+
+    ret = nvme_h2c(n, (uint8_t *)&cr_key, sizeof(cr_key), req);
+    if (ret) {
+        return ret;
+    }
+
+    switch (action) {
+    case NVME_RESV_RELEASE_ACTION_RELEASE:
+        req->aiocb = blk_aio_pr_release(ns->blkconf.blk, cr_key,
+                                        nvme_pr_type_to_block(type),
+                                        nvme_misc_cb, req);
+        break;
+    case NVME_RESV_RELEASE_ACTION_CLEAR:
+        req->aiocb = blk_aio_pr_clear(ns->blkconf.blk, cr_key,
+                                      nvme_misc_cb, req);
+        break;
+    default:
+        return NVME_INVALID_FIELD;
+    }
+
+    return NVME_NO_COMPLETE;
+}
+
+static uint16_t nvme_resv_acquire(NvmeCtrl *n, NvmeRequest *req)
+{
+    int ret;
+    NvmeKeyInfo key_info;
+    NvmeNamespace *ns = req->ns;
+    uint32_t cdw10 = le32_to_cpu(req->cmd.cdw10);
+    uint8_t action = cdw10 & 0x7;
+    NvmeResvType type = cdw10 >> 8 & 0xff;
+
+    ret = nvme_h2c(n, (uint8_t *)&key_info, sizeof(NvmeKeyInfo), req);
+    if (ret) {
+        return ret;
+    }
+
+    switch (action) {
+    case NVME_RESV_ACQUIRE_ACTION_ACQUIRE:
+        req->aiocb = blk_aio_pr_reserve(ns->blkconf.blk, key_info.cr_key,
+                                        nvme_pr_type_to_block(type),
+                                        nvme_misc_cb, req);
+        break;
+    case NVME_RESV_ACQUIRE_ACTION_PREEMPT:
+        req->aiocb = blk_aio_pr_preempt(ns->blkconf.blk,
+                     key_info.cr_key, key_info.nr_key,
+                     nvme_pr_type_to_block(type),
+                     false, nvme_misc_cb, req);
+        break;
+    case NVME_RESV_ACQUIRE_ACTION_PREEMPT_AND_ABORT:
+        req->aiocb = blk_aio_pr_preempt(ns->blkconf.blk, key_info.cr_key,
+                                        key_info.nr_key, type, true,
+                                        nvme_misc_cb, req);
+        break;
+    default:
+        return NVME_INVALID_FIELD;
+    }
+
+    return NVME_NO_COMPLETE;
+}
+
+typedef struct NvmeResvKeys {
+    uint32_t generation;
+    uint32_t num_keys;
+    uint64_t *keys;
+    NvmeRequest *req;
+} NvmeResvKeys;
+
+typedef struct NvmeReadReservation {
+    uint32_t generation;
+    uint64_t key;
+    BlockPrType type;
+    NvmeRequest *req;
+    NvmeResvKeys *keys_info;
+} NvmeReadReservation;
+
+static int nvme_read_reservation_cb(NvmeReadReservation *reservation)
+{
+    int rc;
+    NvmeReservationStatus *nvme_status;
+    NvmeRequest *req = reservation->req;
+    NvmeCtrl *n = req->sq->ctrl;
+    NvmeResvKeys *keys_info = reservation->keys_info;
+    int len = sizeof(NvmeReservationStatusHeader) +
+              sizeof(NvmeRegisteredCtrl) * keys_info->num_keys;
+
+    nvme_status = g_malloc(len);
+    nvme_status->header.gen = reservation->generation;
+    nvme_status->header.rtype = block_pr_type_to_nvme(reservation->type);
+    nvme_status->header.regctl = keys_info->num_keys;
+    for (int i = 0; i < keys_info->num_keys; i++) {
+        nvme_status->regctl_ds[i].cntlid = nvme_ctrl(req)->cntlid;
+        nvme_status->regctl_ds[i].rkey = keys_info->keys[i];
+        nvme_status->regctl_ds[i].rcsts = keys_info->keys[i] ==
+                                          reservation->key ? 1 : 0;
+        /* hostid is not supported currently */
+        memset(&nvme_status->regctl_ds[i].hostid, 0, 8);
+    }
+
+    rc = nvme_c2h(n, (uint8_t *)nvme_status, len, req);
+    g_free(nvme_status);
+    return rc;
+}
+
+static int nvme_read_reservation_ext_cb(NvmeReadReservation *reservation)
+{
+    int rc;
+    NvmeReservationStatusExt *nvme_status_ext;
+    NvmeRequest *req = reservation->req;
+    NvmeCtrl *n = req->sq->ctrl;
+    NvmeResvKeys *keys_info = reservation->keys_info;
+    int len = sizeof(NvmeReservationStatusHeader) +
+              sizeof(uint8_t) * 40 +
+              sizeof(NvmeRegisteredCtrlExt) * keys_info->num_keys;
+
+    nvme_status_ext = g_malloc(len);
+    nvme_status_ext->header.gen = cpu_to_be32(reservation->generation);
+    nvme_status_ext->header.rtype = block_pr_type_to_nvme(reservation->type);
+    nvme_status_ext->header.regctl = cpu_to_be16(keys_info->num_keys);
+
+    for (int i = 0; i < keys_info->num_keys; i++) {
+        uint16_t ctnlid = nvme_ctrl(req)->cntlid;
+        nvme_status_ext->regctl_eds[i].cntlid = cpu_to_be16(ctnlid);
+        nvme_status_ext->regctl_eds[i].rkey = cpu_to_be64(keys_info->keys[i]);
+        nvme_status_ext->regctl_eds[i].rcsts = keys_info->keys[i] ==
+                                               reservation->key ? 1 : 0;
+        /* hostid is not supported currently */
+        memset(&nvme_status_ext->regctl_eds[i].hostid, 0, 16);
+    }
+
+    rc = nvme_c2h(n, (uint8_t *)nvme_status_ext, len, req);
+    g_free(nvme_status_ext);
+    return rc;
+}
+
+static void nvme_resv_read_reservation_cb(void *opaque, int ret)
+{
+    NvmeReadReservation *reservation = opaque;
+    NvmeRequest *req = reservation->req;
+    bool eds = req->cmd.cdw11 & 0x1;
+    NvmeResvKeys *keys_info = reservation->keys_info;
+
+    if (ret < 0) {
+        goto out;
+    }
+
+    if (eds) {
+        ret = nvme_read_reservation_ext_cb(reservation);
+    } else {
+        ret = nvme_read_reservation_cb(reservation);
+    }
+
+out:
+    g_free(keys_info);
+    g_free(reservation);
+    nvme_misc_cb(req, ret);
+}
+
+static void nvme_resv_read_keys_cb(void *opaque, int ret)
+{
+    NvmeResvKeys *keys_info = opaque;
+    NvmeRequest *req = keys_info->req;
+    NvmeNamespace *ns = req->ns;
+    NvmeReadReservation *reservation;
+
+    if (ret < 0) {
+        goto out;
+    }
+
+    keys_info->num_keys = MIN(ret, keys_info->num_keys);
+    reservation = g_new0(NvmeReadReservation, 1);
+    memset(reservation, 0, sizeof(*reservation));
+    reservation->req = req;
+    reservation->keys_info = keys_info;
+
+    req->aiocb = blk_aio_pr_read_reservation(ns->blkconf.blk,
+                 &reservation->generation, &reservation->key,
+                 &reservation->type, nvme_resv_read_reservation_cb,
+                 reservation);
+    return;
+
+out:
+    g_free(keys_info);
+    nvme_misc_cb(req, ret);
+}
+
+
+static uint16_t nvme_resv_report(NvmeCtrl *n, NvmeRequest *req)
+{
+    int num_keys;
+    uint32_t cdw10 = req->cmd.cdw10;
+    uint32_t cdw11 = req->cmd.cdw11;
+    int buflen = (cdw10 + 1) * sizeof(uint32_t);
+    bool eds = cdw11 & 0x1;
+    NvmeNamespace *ns = req->ns;
+    NvmeResvKeys *keys_info;
+
+    if (eds) {
+        if (buflen < sizeof(NvmeReservationStatusHeader) +
+           sizeof(uint8_t) * 40) {
+            return NVME_INVALID_FIELD;
+        }
+
+        num_keys = (buflen - sizeof(NvmeReservationStatusHeader) -
+                   sizeof(uint8_t) * 40) /
+                   sizeof(struct NvmeRegisteredCtrlExt);
+    } else {
+        if (buflen < sizeof(NvmeReservationStatusHeader)) {
+            return NVME_INVALID_FIELD;
+        }
+
+        num_keys = (buflen - sizeof(NvmeReservationStatusHeader)) /
+                   sizeof(struct NvmeRegisteredCtrl);
+    }
+
+    keys_info = g_new0(NvmeResvKeys, 1);
+    keys_info->generation = 0;
+    /* num_keys is the maximum number of keys that can be transmitted */
+    keys_info->num_keys = num_keys;
+    keys_info->keys = g_malloc(sizeof(uint64_t) * num_keys);
+    keys_info->req = req;
+
+    req->aiocb = blk_aio_pr_read_keys(ns->blkconf.blk, &keys_info->generation,
+                                      keys_info->num_keys, keys_info->keys,
+                                      nvme_resv_read_keys_cb, keys_info);
+
+    return NVME_NO_COMPLETE;
+}
+
 typedef struct NvmeCopyAIOCB {
     BlockAIOCB common;
     BlockAIOCB *aiocb;
@@ -4469,6 +4780,14 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
         return nvme_dsm(n, req);
     case NVME_CMD_VERIFY:
         return nvme_verify(n, req);
+    case NVME_CMD_RESV_REGISTER:
+        return nvme_resv_register(n, req);
+    case NVME_CMD_RESV_REPORT:
+        return nvme_resv_report(n, req);
+    case NVME_CMD_RESV_ACQUIRE:
+        return nvme_resv_acquire(n, req);
+    case NVME_CMD_RESV_RELEASE:
+        return nvme_resv_release(n, req);
     case NVME_CMD_COPY:
         return nvme_copy(n, req);
     case NVME_CMD_ZONE_MGMT_SEND:
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index b1ad27c8f2..808b26f086 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -470,6 +470,10 @@ static inline const char *nvme_io_opc_str(uint8_t opc)
     case NVME_CMD_ZONE_MGMT_SEND:   return "NVME_ZONED_CMD_MGMT_SEND";
     case NVME_CMD_ZONE_MGMT_RECV:   return "NVME_ZONED_CMD_MGMT_RECV";
     case NVME_CMD_ZONE_APPEND:      return "NVME_ZONED_CMD_ZONE_APPEND";
+    case NVME_CMD_RESV_REGISTER:    return "NVME_CMD_RESV_REGISTER";
+    case NVME_CMD_RESV_REPORT:      return "NVME_CMD_RESV_REPORT";
+    case NVME_CMD_RESV_ACQUIRE:     return "NVME_CMD_RESV_ACQUIRE";
+    case NVME_CMD_RESV_RELEASE:     return "NVME_CMD_RESV_RELEASE";
     default:                        return "NVME_NVM_CMD_UNKNOWN";
     }
 }
diff --git a/include/block/nvme.h b/include/block/nvme.h
index da6ccb0f3b..3e88b8be69 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -702,6 +702,43 @@ typedef enum NVMEPrCap {
                       NVME_PR_CAP_EX_AC_AR),
 } NvmePrCap;
 
+typedef struct QEMU_PACKED NvmeRegisteredCtrl {
+    uint16_t    cntlid;
+    uint8_t     rcsts;
+    uint8_t     rsvd3[5];
+    uint8_t     hostid[8];
+    uint64_t    rkey;
+} NvmeRegisteredCtrl;
+
+typedef struct QEMU_PACKED NvmeRegisteredCtrlExt {
+    uint16_t  cntlid;
+    uint8_t   rcsts;
+    uint8_t   rsvd3[5];
+    uint64_t  rkey;
+    uint8_t   hostid[16];
+    uint8_t   rsvd32[32];
+} NvmeRegisteredCtrlExt;
+
+typedef struct QEMU_PACKED NvmeReservationStatusHeader {
+    uint32_t  gen;
+    uint8_t   rtype;
+    uint16_t  regctl;
+    uint16_t  resv5;
+    uint8_t   ptpls;
+    uint8_t   resv10[14];
+} NvmeReservationStatusHeader;
+
+typedef struct QEMU_PACKED NvmeReservationStatus {
+    struct NvmeReservationStatusHeader header;
+    struct NvmeRegisteredCtrl regctl_ds[];
+} NvmeReservationStatus;
+
+typedef struct QEMU_PACKED NvmeReservationStatusExt {
+    struct NvmeReservationStatusHeader header;
+    uint8_t   rsvd24[40];
+    struct NvmeRegisteredCtrlExt regctl_eds[];
+} NvmeReservationStatusExt;
+
 typedef struct QEMU_PACKED NvmeDeleteQ {
     uint8_t     opcode;
     uint8_t     flags;
-- 
2.20.1


