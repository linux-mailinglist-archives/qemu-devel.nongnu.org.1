Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0338D5914
	for <lists+qemu-devel@lfdr.de>; Fri, 31 May 2024 05:37:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCt4K-00083I-Vn; Thu, 30 May 2024 23:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sCt4J-00082X-AC
 for qemu-devel@nongnu.org; Thu, 30 May 2024 23:36:39 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sCt45-0003i6-Dl
 for qemu-devel@nongnu.org; Thu, 30 May 2024 23:36:38 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2c1a99b75d8so1161597a91.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 20:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1717126584; x=1717731384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=to2iHP/tTwYZCF9RaEg4ZhQdtljfSMeOwZnTiKHbyNU=;
 b=cQQYCH5rSDnx/INbe5Yw60iauoMQawg6h16FXgZv5z+0yGfobvSt+sLR1f0cdTAcWI
 vULQ8GaOcOPYOrlO6n46QxPb3S5LtLS/XZHnspHcgsjQ7IvjHLTx//vp7ShjFneBt4qR
 hAYNbx0Ua6799cVTXw+3aqSjiUV+m9uRKNE2AY8IOZODwRGuAMuhRqj/KNNTWsw/UCNM
 JB4w7URgOiOa5upcFCLolgKQZe3HBdS0kA21cJFJptO7Ba08q4GGMpYMKlv0Dcw7L+YH
 yn3FmqsipG/p7tojeYO17Vrk74PV2srfMWjTd9hX9VA6J2MF5w09IzmKXWqnR4OMZdj4
 mhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717126584; x=1717731384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=to2iHP/tTwYZCF9RaEg4ZhQdtljfSMeOwZnTiKHbyNU=;
 b=WQAkjrc4sQU7+2sFu1XSF5PFZT3SBh3pZk5LIw1MuJGeBt2XaDm1SAD4iBoYlZhaiC
 /3OcCpWDUjhEFJGliaXjfSbmgN/R6af/4yRnBJFXHPTRvwnEHI2OtQUvJsc8tGKy5kbw
 bH1b0RCanykgNuQ4eZkywYShnPLGF94nfhCfZbYs+qYac5NAojg2TyimDUj2goyshjnQ
 JxFqchwfAiMYYr0CbZuWLBcwSQAHRxyugyIfAIRpdYIQol4amu4EB/Gb7HbVMnihS45w
 NfngQqUhngPE7jQrWfitcqA88izz5WgXebLW8Caw+Qayh0I5LlFI61jL3WJtVAfzSROR
 ejRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVarLSr8vff6tO6ESNtxDTIyzps313NAEy5iM12g3A+UlYFq4ANnyy+L0/oL6UmXlSrS1a+w2/77W6YS8wcuU5Wrf++a98=
X-Gm-Message-State: AOJu0YxdSdn7AJI7ifNczMTSz5CDIomwELeXsgQecFqVFc7JXoUQ0/QJ
 XeUatCHzS4lL2jEfZPWKalvfpbSu9JFh76nvGQoiJeHbTb5201vxVpnMb/+ICA0=
X-Google-Smtp-Source: AGHT+IEGgYY9kVlnsejgmSaUeazr0XNhkquSquSkpZhEOsSpj6dfTfMRoNnIk5quYZQsqipYyt+J7g==
X-Received: by 2002:a17:90a:b390:b0:2a5:e087:768a with SMTP id
 98e67ed59e1d1-2c1dc58fd6dmr670119a91.29.1717126583977; 
 Thu, 30 May 2024 20:36:23 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.142])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a777e989sm2457629a91.29.2024.05.30.20.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 20:36:23 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v4 10/10] block/iscsi: add persistent reservation in/out driver
Date: Fri, 31 May 2024 11:34:55 +0800
Message-Id: <20240531033455.3774806-11-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240531033455.3774806-1-luchangqi.123@bytedance.com>
References: <20240531033455.3774806-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add persistent reservation in/out operations for iscsi driver.
The following methods are implemented: bdrv_co_pr_read_keys,
bdrv_co_pr_read_reservation, bdrv_co_pr_register, bdrv_co_pr_reserve,
bdrv_co_pr_release, bdrv_co_pr_clear and bdrv_co_pr_preempt.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 block/iscsi.c | 443 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 443 insertions(+)

diff --git a/block/iscsi.c b/block/iscsi.c
index 2ff14b7472..d94ebe35bd 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -96,6 +96,7 @@ typedef struct IscsiLun {
     unsigned long *allocmap_valid;
     long allocmap_size;
     int cluster_size;
+    uint8_t pr_cap;
     bool use_16_for_rw;
     bool write_protected;
     bool lbpme;
@@ -280,6 +281,8 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
                     iTask->err_code = -error;
                     iTask->err_str = g_strdup(iscsi_get_error(iscsi));
                 }
+            } else if (status == SCSI_STATUS_RESERVATION_CONFLICT) {
+                iTask->err_code = -EBADE;
             }
         }
     }
@@ -1792,6 +1795,52 @@ static void iscsi_save_designator(IscsiLun *lun,
     }
 }
 
+static void iscsi_get_pr_cap_sync(IscsiLun *iscsilun, Error **errp)
+{
+    struct scsi_task *task = NULL;
+    struct scsi_persistent_reserve_in_report_capabilities *rc = NULL;
+    int retries = ISCSI_CMD_RETRIES;
+    int xferlen = sizeof(struct scsi_persistent_reserve_in_report_capabilities);
+
+    do {
+        if (task != NULL) {
+            scsi_free_scsi_task(task);
+            task = NULL;
+        }
+
+        task = iscsi_persistent_reserve_in_sync(iscsilun->iscsi,
+               iscsilun->lun, SCSI_PR_IN_REPORT_CAPABILITIES, xferlen);
+        if (task != NULL && task->status == SCSI_STATUS_GOOD) {
+                rc = scsi_datain_unmarshall(task);
+                if (rc == NULL) {
+                    error_setg(errp,
+                    "iSCSI: Failed to unmarshall report capabilities data.");
+                } else {
+                    iscsilun->pr_cap =
+                    scsi_pr_cap_to_block(rc->persistent_reservation_type_mask);
+                    iscsilun->pr_cap |= (rc->ptpl_a) ? BLK_PR_CAP_PTPL : 0;
+                }
+                break;
+            }
+
+        if (task != NULL && task->status == SCSI_STATUS_CHECK_CONDITION
+            && task->sense.key == SCSI_SENSE_UNIT_ATTENTION) {
+            break;
+        }
+
+    } while (task != NULL && task->status == SCSI_STATUS_CHECK_CONDITION
+             && task->sense.key == SCSI_SENSE_UNIT_ATTENTION
+             && retries-- > 0);
+
+    if (task == NULL || task->status != SCSI_STATUS_GOOD) {
+        error_setg(errp, "iSCSI: failed to send report capabilities command");
+    }
+
+    if (task) {
+        scsi_free_scsi_task(task);
+    }
+}
+
 static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
                       Error **errp)
 {
@@ -2024,6 +2073,11 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
         bs->supported_zero_flags = BDRV_REQ_MAY_UNMAP;
     }
 
+    iscsi_get_pr_cap_sync(iscsilun, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+    }
 out:
     qemu_opts_del(opts);
     g_free(initiator_name);
@@ -2110,6 +2164,8 @@ static void iscsi_refresh_limits(BlockDriverState *bs, Error **errp)
         bs->bl.opt_transfer = pow2floor(iscsilun->bl.opt_xfer_len *
                                         iscsilun->block_size);
     }
+
+    bs->bl.pr_cap = iscsilun->pr_cap;
 }
 
 /* Note that this will not re-establish a connection with an iSCSI target - it
@@ -2408,6 +2464,385 @@ out_unlock:
     return r;
 }
 
+static int coroutine_fn
+iscsi_co_pr_read_keys(BlockDriverState *bs, uint32_t *generation,
+                      uint32_t num_keys, uint64_t *keys)
+{
+    IscsiLun *iscsilun = bs->opaque;
+    QEMUIOVector qiov;
+    struct IscsiTask iTask;
+    int xferlen = sizeof(struct scsi_persistent_reserve_in_read_keys) +
+                  sizeof(uint64_t) * num_keys;
+    uint8_t *buf = g_malloc0(xferlen);
+    int32_t num_collect_keys = 0;
+    int r = 0;
+
+    qemu_iovec_init_buf(&qiov, buf, xferlen);
+    iscsi_co_init_iscsitask(iscsilun, &iTask);
+    qemu_mutex_lock(&iscsilun->mutex);
+retry:
+    iTask.task = iscsi_persistent_reserve_in_task(iscsilun->iscsi,
+                 iscsilun->lun, SCSI_PR_IN_READ_KEYS, xferlen,
+                 iscsi_co_generic_cb, &iTask);
+
+    if (iTask.task == NULL) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return -ENOMEM;
+    }
+
+    scsi_task_set_iov_in(iTask.task, (struct scsi_iovec *)qiov.iov, qiov.niov);
+    iscsi_co_wait_for_task(&iTask, iscsilun);
+
+    if (iTask.task != NULL) {
+        scsi_free_scsi_task(iTask.task);
+        iTask.task = NULL;
+    }
+
+    if (iTask.do_retry) {
+        iTask.complete = 0;
+        goto retry;
+    }
+
+    if (iTask.status != SCSI_STATUS_GOOD) {
+        error_report("iSCSI PERSISTENT_RESERVE_IN failed: %s", iTask.err_str);
+        r = iTask.err_code;
+        goto out;
+    }
+
+    memcpy(generation, &buf[0], 4);
+    *generation = be32_to_cpu(*generation);
+    memcpy(&num_collect_keys, &buf[4], 4);
+    num_collect_keys = be32_to_cpu(num_collect_keys) / sizeof(uint64_t);
+    if (num_collect_keys > num_keys) {
+        r = -EINVAL;
+        goto out;
+    }
+
+    for (int i = 0; i < num_collect_keys; i++) {
+        memcpy(&keys[i], &buf[8 + i * 8], 8);
+        keys[i] = be64_to_cpu(keys[i]);
+    }
+    r = num_collect_keys;
+
+out:
+    qemu_mutex_unlock(&iscsilun->mutex);
+    g_free(iTask.err_str);
+    g_free(buf);
+    return r;
+}
+
+static int coroutine_fn
+iscsi_co_pr_read_reservation(BlockDriverState *bs, uint32_t *generation,
+                             uint64_t *key, BlockPrType *type)
+{
+    IscsiLun *iscsilun = bs->opaque;
+    QEMUIOVector qiov;
+    struct IscsiTask iTask;
+    int xferlen = sizeof(struct scsi_persistent_reserve_in_read_reservation);
+    uint8_t *buf = g_malloc0(xferlen);
+    uint8_t scope_type = 0;
+    int32_t num_collect_keys = 0;
+    int r = 0;
+
+    qemu_iovec_init_buf(&qiov, buf, xferlen);
+    iscsi_co_init_iscsitask(iscsilun, &iTask);
+    qemu_mutex_lock(&iscsilun->mutex);
+retry:
+    iTask.task = iscsi_persistent_reserve_in_task(iscsilun->iscsi,
+                 iscsilun->lun, SCSI_PR_IN_READ_RESERVATION,
+                 xferlen, iscsi_co_generic_cb, &iTask);
+
+    if (iTask.task == NULL) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return -ENOMEM;
+    }
+
+    scsi_task_set_iov_in(iTask.task, (struct scsi_iovec *)qiov.iov, qiov.niov);
+    iscsi_co_wait_for_task(&iTask, iscsilun);
+
+    if (iTask.task != NULL) {
+        scsi_free_scsi_task(iTask.task);
+        iTask.task = NULL;
+    }
+
+    if (iTask.do_retry) {
+        iTask.complete = 0;
+        goto retry;
+    }
+
+    if (iTask.status != SCSI_STATUS_GOOD) {
+        error_report("iSCSI PERSISTENT_RESERVE_IN failed: %s", iTask.err_str);
+        r = iTask.err_code;
+        goto out;
+    }
+
+    memcpy(generation, &buf[0], 4);
+    *generation = be32_to_cpu(*generation);
+    memcpy(key, &buf[8], 8);
+    *key = be64_to_cpu(*key);
+    memcpy(&scope_type, &buf[21], 1);
+    *type = scsi_pr_type_to_block(scope_type & 0xf);
+    memcpy(&num_collect_keys, &buf[4], 4);
+    r = be32_to_cpu(num_collect_keys) / sizeof(uint64_t);
+out:
+    qemu_mutex_unlock(&iscsilun->mutex);
+    g_free(iTask.err_str);
+    g_free(buf);
+    return r;
+}
+
+static int coroutine_fn
+iscsi_co_pr_register(BlockDriverState *bs, uint64_t old_key,
+                     uint64_t new_key, BlockPrType type,
+                     bool ptpl, bool ignore_key)
+{
+    IscsiLun *iscsilun = bs->opaque;
+    struct IscsiTask iTask;
+    struct scsi_persistent_reserve_out_basic *basic;
+    SCSIPrOutAction action = ignore_key ? SCSI_PR_OUT_REG_AND_IGNORE_KEY :
+                                          SCSI_PR_OUT_REGISTER;
+    int r = 0;
+
+    basic = g_new0(struct scsi_persistent_reserve_out_basic, 1);
+    basic->reservation_key = old_key;
+    basic->service_action_reservation_key = new_key;
+    basic->aptpl = ptpl ? 1 : 0;
+
+    iscsi_co_init_iscsitask(iscsilun, &iTask);
+    qemu_mutex_lock(&iscsilun->mutex);
+retry:
+    iTask.task = iscsi_persistent_reserve_out_task(iscsilun->iscsi,
+                 iscsilun->lun, action, 0, block_pr_type_to_scsi(type),
+                 basic, iscsi_co_generic_cb, &iTask);
+
+    if (iTask.task == NULL) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return -ENOMEM;
+    }
+
+    iscsi_co_wait_for_task(&iTask, iscsilun);
+
+    if (iTask.task != NULL) {
+        scsi_free_scsi_task(iTask.task);
+        iTask.task = NULL;
+    }
+
+    if (iTask.do_retry) {
+        iTask.complete = 0;
+        goto retry;
+    }
+
+    if (iTask.status != SCSI_STATUS_GOOD) {
+        error_report("iSCSI PERSISTENT_RESERVE_OUT failed: %s", iTask.err_str);
+        r = iTask.err_code;
+    }
+
+    qemu_mutex_unlock(&iscsilun->mutex);
+
+    g_free(iTask.err_str);
+    g_free(basic);
+    return r;
+}
+
+static int coroutine_fn
+iscsi_co_pr_reserve(BlockDriverState *bs, uint64_t key, BlockPrType type)
+{
+    IscsiLun *iscsilun = bs->opaque;
+    struct IscsiTask iTask;
+    struct scsi_persistent_reserve_out_basic *basic;
+    int r = 0;
+
+    basic = g_new0(struct scsi_persistent_reserve_out_basic, 1);
+    basic->reservation_key = key;
+
+    iscsi_co_init_iscsitask(iscsilun, &iTask);
+    qemu_mutex_lock(&iscsilun->mutex);
+retry:
+    iTask.task = iscsi_persistent_reserve_out_task(iscsilun->iscsi,
+                 iscsilun->lun, SCSI_PR_OUT_RESERVE, 0,
+                 block_pr_type_to_scsi(type), basic,
+                 iscsi_co_generic_cb, &iTask);
+
+    if (iTask.task == NULL) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return -ENOMEM;
+    }
+
+
+    iscsi_co_wait_for_task(&iTask, iscsilun);
+
+    if (iTask.task != NULL) {
+        scsi_free_scsi_task(iTask.task);
+        iTask.task = NULL;
+    }
+
+    if (iTask.do_retry) {
+        iTask.complete = 0;
+        goto retry;
+    }
+
+    if (iTask.status != SCSI_STATUS_GOOD) {
+        error_report("iSCSI PERSISTENT_RESERVE_OUT failed: %s", iTask.err_str);
+        r = iTask.err_code;
+    }
+
+    qemu_mutex_unlock(&iscsilun->mutex);
+
+    g_free(iTask.err_str);
+    g_free(basic);
+    return r;
+}
+
+static int coroutine_fn
+iscsi_co_pr_release(BlockDriverState *bs, uint64_t key, BlockPrType type)
+{
+    IscsiLun *iscsilun = bs->opaque;
+    struct IscsiTask iTask;
+    struct scsi_persistent_reserve_out_basic *basic;
+    int r = 0;
+
+    basic = g_new0(struct scsi_persistent_reserve_out_basic, 1);
+    basic->reservation_key = key;
+
+    iscsi_co_init_iscsitask(iscsilun, &iTask);
+    qemu_mutex_lock(&iscsilun->mutex);
+retry:
+    iTask.task = iscsi_persistent_reserve_out_task(iscsilun->iscsi,
+                 iscsilun->lun, SCSI_PR_OUT_RELEASE, 0,
+                 block_pr_type_to_scsi(type), basic,
+                 iscsi_co_generic_cb, &iTask);
+
+    if (iTask.task == NULL) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return -ENOMEM;
+    }
+
+
+    iscsi_co_wait_for_task(&iTask, iscsilun);
+
+    if (iTask.task != NULL) {
+        scsi_free_scsi_task(iTask.task);
+        iTask.task = NULL;
+    }
+
+    if (iTask.do_retry) {
+        iTask.complete = 0;
+        goto retry;
+    }
+
+    if (iTask.status != SCSI_STATUS_GOOD) {
+        error_report("iSCSI PERSISTENT_RESERVE_OUT failed: %s", iTask.err_str);
+        r = iTask.err_code;
+    }
+
+    qemu_mutex_unlock(&iscsilun->mutex);
+
+    g_free(iTask.err_str);
+    g_free(basic);
+    return r;
+}
+
+static int coroutine_fn
+iscsi_co_pr_clear(BlockDriverState *bs, uint64_t key)
+{
+    IscsiLun *iscsilun = bs->opaque;
+    struct IscsiTask iTask;
+    struct scsi_persistent_reserve_out_basic *basic;
+    int r = 0;
+
+    basic = g_new0(struct scsi_persistent_reserve_out_basic, 1);
+    basic->reservation_key = key;
+
+    iscsi_co_init_iscsitask(iscsilun, &iTask);
+    qemu_mutex_lock(&iscsilun->mutex);
+retry:
+    iTask.task = iscsi_persistent_reserve_out_task(iscsilun->iscsi,
+                 iscsilun->lun, SCSI_PR_OUT_CLEAR, 0, 0, basic,
+                 iscsi_co_generic_cb, &iTask);
+
+    if (iTask.task == NULL) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return -ENOMEM;
+    }
+
+
+    iscsi_co_wait_for_task(&iTask, iscsilun);
+
+    if (iTask.task != NULL) {
+        scsi_free_scsi_task(iTask.task);
+        iTask.task = NULL;
+    }
+
+    if (iTask.do_retry) {
+        iTask.complete = 0;
+        goto retry;
+    }
+
+    if (iTask.status != SCSI_STATUS_GOOD) {
+        error_report("iSCSI PERSISTENT_RESERVE_OUT failed: %s", iTask.err_str);
+        r = iTask.err_code;
+    }
+
+    qemu_mutex_unlock(&iscsilun->mutex);
+
+    g_free(iTask.err_str);
+    g_free(basic);
+    return r;
+}
+
+static int coroutine_fn
+iscsi_co_pr_preempt(BlockDriverState *bs, uint64_t old_key,
+                    uint64_t new_key, BlockPrType type, bool abort)
+{
+    IscsiLun *iscsilun = bs->opaque;
+    struct IscsiTask iTask;
+    struct scsi_persistent_reserve_out_basic *basic;
+    SCSIPrOutAction action = abort ? SCSI_PR_OUT_PREEMPT_AND_ABORT :
+                                     SCSI_PR_OUT_PREEMPT;
+    int r = 0;
+
+    basic = g_new0(struct scsi_persistent_reserve_out_basic, 1);
+    basic->reservation_key = old_key;
+    basic->service_action_reservation_key = new_key;
+
+    iscsi_co_init_iscsitask(iscsilun, &iTask);
+    qemu_mutex_lock(&iscsilun->mutex);
+retry:
+    iTask.task = iscsi_persistent_reserve_out_task(iscsilun->iscsi,
+                 iscsilun->lun, action, 0, block_pr_type_to_scsi(type),
+                 basic, iscsi_co_generic_cb, &iTask);
+
+    if (iTask.task == NULL) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return -ENOMEM;
+    }
+
+
+    iscsi_co_wait_for_task(&iTask, iscsilun);
+
+    if (iTask.task != NULL) {
+        scsi_free_scsi_task(iTask.task);
+        iTask.task = NULL;
+    }
+
+    if (iTask.do_retry) {
+        iTask.complete = 0;
+        goto retry;
+    }
+
+    if (iTask.status != SCSI_STATUS_GOOD) {
+        error_report("iSCSI PERSISTENT_RESERVE_OUT failed: %s", iTask.err_str);
+        r = iTask.err_code;
+    }
+
+    qemu_mutex_unlock(&iscsilun->mutex);
+
+
+    g_free(iTask.err_str);
+    g_free(basic);
+    return r;
+}
+
 
 static const char *const iscsi_strong_runtime_opts[] = {
     "transport",
@@ -2451,6 +2886,14 @@ static BlockDriver bdrv_iscsi = {
     .bdrv_co_writev        = iscsi_co_writev,
     .bdrv_co_flush_to_disk = iscsi_co_flush,
 
+    .bdrv_co_pr_read_keys     = iscsi_co_pr_read_keys,
+    .bdrv_co_pr_read_reservation = iscsi_co_pr_read_reservation,
+    .bdrv_co_pr_register      = iscsi_co_pr_register,
+    .bdrv_co_pr_reserve       = iscsi_co_pr_reserve,
+    .bdrv_co_pr_release       = iscsi_co_pr_release,
+    .bdrv_co_pr_clear         = iscsi_co_pr_clear,
+    .bdrv_co_pr_preempt       = iscsi_co_pr_preempt,
+
 #ifdef __linux__
     .bdrv_aio_ioctl   = iscsi_aio_ioctl,
 #endif
-- 
2.20.1


