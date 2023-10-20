Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 275677D0648
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 03:54:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtegA-0005a8-TU; Thu, 19 Oct 2023 21:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qteg8-0005Zs-Nq; Thu, 19 Oct 2023 21:51:56 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qteg3-0007pp-EL; Thu, 19 Oct 2023 21:51:56 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c9d3a21f7aso2526405ad.2; 
 Thu, 19 Oct 2023 18:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697766709; x=1698371509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UqVljF1Zd2bCM4IoCM+RiNnnJ9kVIWmsOs+VPacpCnQ=;
 b=mvUsvnPqIi7BbCgIAco1mpAX3YwHWtA8EG/JoQAQKfxlEG/Ujmb+MVLKdlrtJ+b5jT
 WaFn5VOGATqYbSYBAiESdnG7fUYBiOnR4j0hKf8k2eYaiuYaCLJp0KBGuaIdl8pvib+2
 g0BM5ZTow/jqBkemqE4JAqGfRp+sP3teOLBWqcMAzBxph+F1ULWiUvWG/FuU1PVCcPpC
 rroWW6frOiezFtq95vfYURA7EZ0iCSnhmkcFA92dTZiMp07Ks/K8EbKOVHolDK7B4g60
 NnfYaW8P8Q+pBxSC5+eH7WrB+DjdSSyo5KV1iJnItKOTn5XdTL68c2vTAhlDKyyr/AAH
 nRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697766709; x=1698371509;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UqVljF1Zd2bCM4IoCM+RiNnnJ9kVIWmsOs+VPacpCnQ=;
 b=El5kqWAc8OQhMcnhQ8eD590ePWOCTbsTRQf7gWjTV4yUSRr+s/fKAXcXUMQ7SKdm6/
 SkpZ4KtTxvo5tywWGm25NGDYn2LL+khQ5xFlj1SmS7bB6xMWggdWzyMKZ3fAyxxrWEh9
 TWrlnqk8LD0OMp/sA5+WWau/O9W1QapccL4p5znUVwygjyBqu16FPTyotMPK6rLAHhA3
 xcUqzeqIHUyVBCVmTGfWhjEsudHwSNjyM6027CQhNziHQlT18Gaj3s/vTxQphLzqkIfL
 9LxR/0x+nGZGacAQk8S4aAWbGGT6+pToTIYPaGulYLqGhFQla101fACR+55OaSdIL+NA
 Fjcw==
X-Gm-Message-State: AOJu0Yy9ngGK8cG/D2tKwVQyJZYXk5C+U2f+PtTWsniALCypZPU3Lu9O
 5e8xPCVMOukpeyoRoNa522ZyMVwfYBY8SA==
X-Google-Smtp-Source: AGHT+IHVxP3i3+BQpll9l4LokX2vmBMvgMm1Er5RWi+u9drlueef1rNdoOqB3bh4M0954AH0Q80DpQ==
X-Received: by 2002:a17:902:d2ca:b0:1ca:1224:547a with SMTP id
 n10-20020a170902d2ca00b001ca1224547amr703348plc.23.1697766707929; 
 Thu, 19 Oct 2023 18:51:47 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a170902d35500b001ca4cc783b6sm362597plk.36.2023.10.19.18.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 18:51:47 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, kwolf@redhat.com, hreitz@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 qemu-block@nongnu.org
Subject: [PATCH] hw/ufs: Modify lu.c to share codes with SCSI subsystem
Date: Fri, 20 Oct 2023 10:51:06 +0900
Message-Id: <9fd0dc1f55724fa79011be231cc27bf4aab11157.1697764912.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch removes the code that ufs-lu was duplicating from
scsi-hd and allows them to share code.

It makes ufs-lu have a virtual scsi-bus and scsi-hd internally.
This allows scsi related commands to be passed thorugh to the scsi-hd.
The query request and nop command work the same as the existing logic.

Well-known lus do not have a virtual scsi-bus and scsi-hd, and
handle the necessary scsi commands by emulating them directly.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/lu.c            | 1473 +++++++---------------------------------
 hw/ufs/trace-events    |   25 -
 hw/ufs/ufs.c           |  202 +-----
 hw/ufs/ufs.h           |   36 +-
 include/block/ufs.h    |    2 +-
 tests/qtest/ufs-test.c |   37 +-
 6 files changed, 315 insertions(+), 1460 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 13b5e37b53..81bfff9b4e 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -19,57 +19,117 @@
 #include "trace.h"
 #include "ufs.h"
 
-/*
- * The code below handling SCSI commands is copied from hw/scsi/scsi-disk.c,
- * with minor adjustments to make it work for UFS.
- */
+#define SCSI_COMMAND_FAIL (-1)
 
-#define SCSI_DMA_BUF_SIZE (128 * KiB)
-#define SCSI_MAX_INQUIRY_LEN 256
-#define SCSI_INQUIRY_DATA_SIZE 36
-#define SCSI_MAX_MODE_LEN 256
-
-typedef struct UfsSCSIReq {
-    SCSIRequest req;
-    /* Both sector and sector_count are in terms of BDRV_SECTOR_SIZE bytes.  */
-    uint64_t sector;
-    uint32_t sector_count;
-    uint32_t buflen;
-    bool started;
-    bool need_fua_emulation;
-    struct iovec iov;
-    QEMUIOVector qiov;
-    BlockAcctCookie acct;
-} UfsSCSIReq;
-
-static void ufs_scsi_free_request(SCSIRequest *req)
+static void ufs_build_upiu_sense_data(UfsRequest *req, uint8_t *sense,
+                                      uint32_t sense_len)
 {
-    UfsSCSIReq *r = DO_UPCAST(UfsSCSIReq, req, req);
+    req->rsp_upiu.sr.sense_data_len = cpu_to_be16(sense_len);
+    assert(sense_len <= SCSI_SENSE_LEN);
+    memcpy(req->rsp_upiu.sr.sense_data, sense, sense_len);
+}
+
+static void ufs_build_scsi_response_upiu(UfsRequest *req, uint8_t *sense,
+                                         uint32_t sense_len,
+                                         uint32_t transfered_len,
+                                         int16_t status)
+{
+    uint32_t expected_len = be32_to_cpu(req->req_upiu.sc.exp_data_transfer_len);
+    uint8_t flags = 0, response = UFS_COMMAND_RESULT_SUCCESS;
+    uint16_t data_segment_length;
+
+    if (expected_len > transfered_len) {
+        req->rsp_upiu.sr.residual_transfer_count =
+            cpu_to_be32(expected_len - transfered_len);
+        flags |= UFS_UPIU_FLAG_UNDERFLOW;
+    } else if (expected_len < transfered_len) {
+        req->rsp_upiu.sr.residual_transfer_count =
+            cpu_to_be32(transfered_len - expected_len);
+        flags |= UFS_UPIU_FLAG_OVERFLOW;
+    }
 
-    qemu_vfree(r->iov.iov_base);
+    if (status != 0) {
+        ufs_build_upiu_sense_data(req, sense, sense_len);
+        response = UFS_COMMAND_RESULT_FAIL;
+    }
+
+    data_segment_length =
+        cpu_to_be16(sense_len + sizeof(req->rsp_upiu.sr.sense_data_len));
+    ufs_build_upiu_header(req, UFS_UPIU_TRANSACTION_RESPONSE, flags, response,
+                          status, data_segment_length);
 }
 
-static void scsi_check_condition(UfsSCSIReq *r, SCSISense sense)
+static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
 {
-    trace_ufs_scsi_check_condition(r->req.tag, sense.key, sense.asc,
-                                   sense.ascq);
-    scsi_req_build_sense(&r->req, sense);
-    scsi_req_complete(&r->req, CHECK_CONDITION);
+    UfsRequest *req = scsi_req->hba_private;
+    int16_t status = scsi_req->status;
+
+    uint32_t transfered_len = scsi_req->cmd.xfer - resid;
+
+    ufs_build_scsi_response_upiu(req, scsi_req->sense, scsi_req->sense_len,
+                                 transfered_len, status);
+
+    ufs_complete_req(req, UFS_REQUEST_SUCCESS);
+
+    scsi_req->hba_private = NULL;
+    scsi_req_unref(scsi_req);
 }
 
-static int ufs_scsi_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf,
-                                     uint32_t outbuf_len)
+static QEMUSGList *ufs_get_sg_list(SCSIRequest *scsi_req)
 {
-    UfsHc *u = UFS(req->bus->qbus.parent);
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, req->dev);
-    uint8_t page_code = req->cmd.buf[2];
-    int start, buflen = 0;
+    UfsRequest *req = scsi_req->hba_private;
+    return req->sg;
+}
+
+static const struct SCSIBusInfo ufs_scsi_info = {
+    .tcq = true,
+    .max_target = 0,
+    .max_lun = UFS_MAX_LUS,
+    .max_channel = 0,
+
+    .get_sg_list = ufs_get_sg_list,
+    .complete = ufs_scsi_command_complete,
+};
+
+static int ufs_emulate_report_luns(UfsRequest *req, uint8_t *outbuf,
+                                   uint32_t outbuf_len)
+{
+    UfsHc *u = req->hc;
+    int len = 0;
 
-    if (outbuf_len < SCSI_INQUIRY_DATA_SIZE) {
-        return -1;
+    /* TODO: Support for cases where SELECT REPORT is 1 and 2 */
+    if (req->req_upiu.sc.cdb[2] != 0) {
+        return SCSI_COMMAND_FAIL;
     }
 
-    outbuf[buflen++] = lu->qdev.type & 0x1f;
+    len += 8;
+
+    for (uint8_t lun = 0; lun < UFS_MAX_LUS; ++lun) {
+        if (u->lus[lun]) {
+            if (len + 8 > outbuf_len) {
+                break;
+            }
+
+            memset(outbuf + len, 0, 8);
+            outbuf[len] = 0;
+            outbuf[len + 1] = lun;
+            len += 8;
+        }
+    }
+
+    /* store the LUN list length */
+    stl_be_p(outbuf, len - 8);
+
+    return len;
+}
+
+static int ufs_scsi_emulate_vpd_page(UfsRequest *req, uint8_t *outbuf,
+                                     uint32_t outbuf_len)
+{
+    uint8_t page_code = req->req_upiu.sc.cdb[2];
+    int start, buflen = 0;
+
+    outbuf[buflen++] = TYPE_WLUN;
     outbuf[buflen++] = page_code;
     outbuf[buflen++] = 0x00;
     outbuf[buflen++] = 0x00;
@@ -78,36 +138,12 @@ static int ufs_scsi_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf,
     switch (page_code) {
     case 0x00: /* Supported page codes, mandatory */
     {
-        trace_ufs_scsi_emulate_vpd_page_00(req->cmd.xfer);
         outbuf[buflen++] = 0x00; /* list of supported pages (this page) */
-        if (u->params.serial) {
-            outbuf[buflen++] = 0x80; /* unit serial number */
-        }
         outbuf[buflen++] = 0x87; /* mode page policy */
         break;
     }
-    case 0x80: /* Device serial number, optional */
-    {
-        int l;
-
-        if (!u->params.serial) {
-            trace_ufs_scsi_emulate_vpd_page_80_not_supported();
-            return -1;
-        }
-
-        l = strlen(u->params.serial);
-        if (l > SCSI_INQUIRY_DATA_SIZE) {
-            l = SCSI_INQUIRY_DATA_SIZE;
-        }
-
-        trace_ufs_scsi_emulate_vpd_page_80(req->cmd.xfer);
-        memcpy(outbuf + buflen, u->params.serial, l);
-        buflen += l;
-        break;
-    }
     case 0x87: /* Mode Page Policy, mandatory */
     {
-        trace_ufs_scsi_emulate_vpd_page_87(req->cmd.xfer);
         outbuf[buflen++] = 0x3f; /* apply to all mode pages and subpages */
         outbuf[buflen++] = 0xff;
         outbuf[buflen++] = 0; /* shared */
@@ -115,7 +151,7 @@ static int ufs_scsi_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf,
         break;
     }
     default:
-        return -1;
+        return SCSI_COMMAND_FAIL;
     }
     /* done with EVPD */
     assert(buflen - start <= 255);
@@ -123,1150 +159,130 @@ static int ufs_scsi_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf,
     return buflen;
 }
 
-static int ufs_scsi_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf,
+static int ufs_emulate_wlun_inquiry(UfsRequest *req, uint8_t *outbuf,
                                     uint32_t outbuf_len)
 {
-    int buflen = 0;
-
-    if (outbuf_len < SCSI_INQUIRY_DATA_SIZE) {
-        return -1;
+    if (outbuf_len < SCSI_INQUIRY_LEN) {
+        return 0;
     }
 
-    if (req->cmd.buf[1] & 0x1) {
+    if (req->req_upiu.sc.cdb[1] & 0x1) {
         /* Vital product data */
         return ufs_scsi_emulate_vpd_page(req, outbuf, outbuf_len);
     }
 
     /* Standard INQUIRY data */
-    if (req->cmd.buf[2] != 0) {
-        return -1;
+    if (req->req_upiu.sc.cdb[2] != 0) {
+        return SCSI_COMMAND_FAIL;
     }
 
-    /* PAGE CODE == 0 */
-    buflen = req->cmd.xfer;
-    if (buflen > SCSI_MAX_INQUIRY_LEN) {
-        buflen = SCSI_MAX_INQUIRY_LEN;
-    }
-
-    if (is_wlun(req->lun)) {
-        outbuf[0] = TYPE_WLUN;
-    } else {
-        outbuf[0] = 0;
-    }
+    outbuf[0] = TYPE_WLUN;
     outbuf[1] = 0;
-
-    strpadcpy((char *)&outbuf[16], 16, "QEMU UFS", ' ');
+    outbuf[2] = 0x6; /* SPC-4 */
+    outbuf[3] = 0x2;
+    outbuf[4] = 31;
+    outbuf[5] = 0;
+    outbuf[6] = 0;
+    outbuf[7] = 0x2;
     strpadcpy((char *)&outbuf[8], 8, "QEMU", ' ');
-
+    strpadcpy((char *)&outbuf[16], 16, "QEMU UFS", ' ');
     memset(&outbuf[32], 0, 4);
 
-    outbuf[2] = 0x06; /* SPC-4 */
-    outbuf[3] = 0x2;
-
-    if (buflen > SCSI_INQUIRY_DATA_SIZE) {
-        outbuf[4] = buflen - 5; /* Additional Length = (Len - 1) - 4 */
-    } else {
-        /*
-         * If the allocation length of CDB is too small, the additional
-         * length is not adjusted
-         */
-        outbuf[4] = SCSI_INQUIRY_DATA_SIZE - 5;
-    }
-
-    /* Support TCQ.  */
-    outbuf[7] = req->bus->info->tcq ? 0x02 : 0;
-    return buflen;
-}
-
-static int mode_sense_page(UfsLu *lu, int page, uint8_t **p_outbuf,
-                           int page_control)
-{
-    static const int mode_sense_valid[0x3f] = {
-        [MODE_PAGE_CACHING] = 1,
-        [MODE_PAGE_R_W_ERROR] = 1,
-        [MODE_PAGE_CONTROL] = 1,
-    };
-
-    uint8_t *p = *p_outbuf + 2;
-    int length;
-
-    assert(page < ARRAY_SIZE(mode_sense_valid));
-    if ((mode_sense_valid[page]) == 0) {
-        return -1;
-    }
-
-    /*
-     * If Changeable Values are requested, a mask denoting those mode parameters
-     * that are changeable shall be returned. As we currently don't support
-     * parameter changes via MODE_SELECT all bits are returned set to zero.
-     * The buffer was already memset to zero by the caller of this function.
-     */
-    switch (page) {
-    case MODE_PAGE_CACHING:
-        length = 0x12;
-        if (page_control == 1 || /* Changeable Values */
-            blk_enable_write_cache(lu->qdev.conf.blk)) {
-            p[0] = 4; /* WCE */
-        }
-        break;
-
-    case MODE_PAGE_R_W_ERROR:
-        length = 10;
-        if (page_control == 1) { /* Changeable Values */
-            break;
-        }
-        p[0] = 0x80; /* Automatic Write Reallocation Enabled */
-        break;
-
-    case MODE_PAGE_CONTROL:
-        length = 10;
-        if (page_control == 1) { /* Changeable Values */
-            break;
-        }
-        p[1] = 0x10; /* Queue Algorithm modifier */
-        p[8] = 0xff; /* Busy Timeout Period */
-        p[9] = 0xff;
-        break;
-
-    default:
-        return -1;
-    }
-
-    assert(length < 256);
-    (*p_outbuf)[0] = page;
-    (*p_outbuf)[1] = length;
-    *p_outbuf += length + 2;
-    return length + 2;
+    return SCSI_INQUIRY_LEN;
 }
 
-static int ufs_scsi_emulate_mode_sense(UfsSCSIReq *r, uint8_t *outbuf)
+static UfsReqResult ufs_emulate_scsi_cmd(UfsLu *lu, UfsRequest *req)
 {
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, r->req.dev);
-    bool dbd;
-    int page, buflen, ret, page_control;
-    uint8_t *p;
-    uint8_t dev_specific_param = 0;
-
-    dbd = (r->req.cmd.buf[1] & 0x8) != 0;
-    if (!dbd) {
-        return -1;
-    }
+    uint8_t lun = lu->lun;
+    uint8_t outbuf[4096];
+    uint8_t sense_buf[UFS_SENSE_SIZE];
+    uint8_t scsi_status;
+    int len = 0;
 
-    page = r->req.cmd.buf[2] & 0x3f;
-    page_control = (r->req.cmd.buf[2] & 0xc0) >> 6;
-
-    trace_ufs_scsi_emulate_mode_sense((r->req.cmd.buf[0] == MODE_SENSE) ? 6 :
-                                                                          10,
-                                      page, r->req.cmd.xfer, page_control);
-    memset(outbuf, 0, r->req.cmd.xfer);
-    p = outbuf;
-
-    if (!blk_is_writable(lu->qdev.conf.blk)) {
-        dev_specific_param |= 0x80; /* Readonly.  */
-    }
-
-    p[2] = 0; /* Medium type.  */
-    p[3] = dev_specific_param;
-    p[6] = p[7] = 0; /* Block descriptor length.  */
-    p += 8;
-
-    if (page_control == 3) {
-        /* Saved Values */
-        scsi_check_condition(r, SENSE_CODE(SAVING_PARAMS_NOT_SUPPORTED));
-        return -1;
-    }
-
-    if (page == 0x3f) {
-        for (page = 0; page <= 0x3e; page++) {
-            mode_sense_page(lu, page, &p, page_control);
-        }
-    } else {
-        ret = mode_sense_page(lu, page, &p, page_control);
-        if (ret == -1) {
-            return -1;
-        }
-    }
-
-    buflen = p - outbuf;
-    /*
-     * The mode data length field specifies the length in bytes of the
-     * following data that is available to be transferred. The mode data
-     * length does not include itself.
-     */
-    outbuf[0] = ((buflen - 2) >> 8) & 0xff;
-    outbuf[1] = (buflen - 2) & 0xff;
-    return buflen;
-}
-
-/*
- * scsi_handle_rw_error has two return values.  False means that the error
- * must be ignored, true means that the error has been processed and the
- * caller should not do anything else for this request.  Note that
- * scsi_handle_rw_error always manages its reference counts, independent
- * of the return value.
- */
-static bool scsi_handle_rw_error(UfsSCSIReq *r, int ret, bool acct_failed)
-{
-    bool is_read = (r->req.cmd.mode == SCSI_XFER_FROM_DEV);
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, r->req.dev);
-    SCSISense sense = SENSE_CODE(NO_SENSE);
-    int error = 0;
-    bool req_has_sense = false;
-    BlockErrorAction action;
-    int status;
-
-    if (ret < 0) {
-        status = scsi_sense_from_errno(-ret, &sense);
-        error = -ret;
-    } else {
-        /* A passthrough command has completed with nonzero status.  */
-        status = ret;
-        if (status == CHECK_CONDITION) {
-            req_has_sense = true;
-            error = scsi_sense_buf_to_errno(r->req.sense, sizeof(r->req.sense));
+    switch (req->req_upiu.sc.cdb[0]) {
+    case REPORT_LUNS:
+        len = ufs_emulate_report_luns(req, outbuf, sizeof(outbuf));
+        if (len == SCSI_COMMAND_FAIL) {
+            scsi_build_sense(sense_buf, SENSE_CODE(INVALID_FIELD));
+            scsi_status = CHECK_CONDITION;
         } else {
-            error = EINVAL;
+            scsi_status = GOOD;
         }
-    }
-
-    /*
-     * Check whether the error has to be handled by the guest or should
-     * rather follow the rerror=/werror= settings.  Guest-handled errors
-     * are usually retried immediately, so do not post them to QMP and
-     * do not account them as failed I/O.
-     */
-    if (req_has_sense && scsi_sense_buf_is_guest_recoverable(
-                             r->req.sense, sizeof(r->req.sense))) {
-        action = BLOCK_ERROR_ACTION_REPORT;
-        acct_failed = false;
-    } else {
-        action = blk_get_error_action(lu->qdev.conf.blk, is_read, error);
-        blk_error_action(lu->qdev.conf.blk, action, is_read, error);
-    }
-
-    switch (action) {
-    case BLOCK_ERROR_ACTION_REPORT:
-        if (acct_failed) {
-            block_acct_failed(blk_get_stats(lu->qdev.conf.blk), &r->acct);
-        }
-        if (!req_has_sense && status == CHECK_CONDITION) {
-            scsi_req_build_sense(&r->req, sense);
-        }
-        scsi_req_complete(&r->req, status);
-        return true;
-
-    case BLOCK_ERROR_ACTION_IGNORE:
-        return false;
-
-    case BLOCK_ERROR_ACTION_STOP:
-        scsi_req_retry(&r->req);
-        return true;
-
-    default:
-        g_assert_not_reached();
-    }
-}
-
-static bool ufs_scsi_req_check_error(UfsSCSIReq *r, int ret, bool acct_failed)
-{
-    if (r->req.io_canceled) {
-        scsi_req_cancel_complete(&r->req);
-        return true;
-    }
-
-    if (ret < 0) {
-        return scsi_handle_rw_error(r, ret, acct_failed);
-    }
-
-    return false;
-}
-
-static void scsi_aio_complete(void *opaque, int ret)
-{
-    UfsSCSIReq *r = (UfsSCSIReq *)opaque;
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, r->req.dev);
-
-    assert(r->req.aiocb != NULL);
-    r->req.aiocb = NULL;
-    aio_context_acquire(blk_get_aio_context(lu->qdev.conf.blk));
-    if (ufs_scsi_req_check_error(r, ret, true)) {
-        goto done;
-    }
-
-    block_acct_done(blk_get_stats(lu->qdev.conf.blk), &r->acct);
-    scsi_req_complete(&r->req, GOOD);
-
-done:
-    aio_context_release(blk_get_aio_context(lu->qdev.conf.blk));
-    scsi_req_unref(&r->req);
-}
-
-static int32_t ufs_scsi_emulate_command(SCSIRequest *req, uint8_t *buf)
-{
-    UfsSCSIReq *r = DO_UPCAST(UfsSCSIReq, req, req);
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, req->dev);
-    uint32_t last_block = 0;
-    uint8_t *outbuf;
-    int buflen;
-
-    switch (req->cmd.buf[0]) {
-    case INQUIRY:
-    case MODE_SENSE_10:
-    case START_STOP:
-    case REQUEST_SENSE:
-        break;
-
-    default:
-        if (!blk_is_available(lu->qdev.conf.blk)) {
-            scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
-            return 0;
-        }
-        break;
-    }
-
-    /*
-     * FIXME: we shouldn't return anything bigger than 4k, but the code
-     * requires the buffer to be as big as req->cmd.xfer in several
-     * places.  So, do not allow CDBs with a very large ALLOCATION
-     * LENGTH.  The real fix would be to modify scsi_read_data and
-     * dma_buf_read, so that they return data beyond the buflen
-     * as all zeros.
-     */
-    if (req->cmd.xfer > 65536) {
-        goto illegal_request;
-    }
-    r->buflen = MAX(4096, req->cmd.xfer);
-
-    if (!r->iov.iov_base) {
-        r->iov.iov_base = blk_blockalign(lu->qdev.conf.blk, r->buflen);
-    }
-
-    outbuf = r->iov.iov_base;
-    memset(outbuf, 0, r->buflen);
-    switch (req->cmd.buf[0]) {
-    case TEST_UNIT_READY:
-        assert(blk_is_available(lu->qdev.conf.blk));
         break;
     case INQUIRY:
-        buflen = ufs_scsi_emulate_inquiry(req, outbuf, r->buflen);
-        if (buflen < 0) {
-            goto illegal_request;
-        }
-        break;
-    case MODE_SENSE_10:
-        buflen = ufs_scsi_emulate_mode_sense(r, outbuf);
-        if (buflen < 0) {
-            goto illegal_request;
+        len = ufs_emulate_wlun_inquiry(req, outbuf, sizeof(outbuf));
+        if (len == SCSI_COMMAND_FAIL) {
+            scsi_build_sense(sense_buf, SENSE_CODE(INVALID_FIELD));
+            scsi_status = CHECK_CONDITION;
+        } else {
+            scsi_status = GOOD;
         }
         break;
-    case READ_CAPACITY_10:
-        /* The normal LEN field for this command is zero.  */
-        memset(outbuf, 0, 8);
-        if (lu->qdev.max_lba > 0) {
-            last_block = lu->qdev.max_lba - 1;
-        };
-        outbuf[0] = (last_block >> 24) & 0xff;
-        outbuf[1] = (last_block >> 16) & 0xff;
-        outbuf[2] = (last_block >> 8) & 0xff;
-        outbuf[3] = last_block & 0xff;
-        outbuf[4] = (lu->qdev.blocksize >> 24) & 0xff;
-        outbuf[5] = (lu->qdev.blocksize >> 16) & 0xff;
-        outbuf[6] = (lu->qdev.blocksize >> 8) & 0xff;
-        outbuf[7] = lu->qdev.blocksize & 0xff;
-        break;
     case REQUEST_SENSE:
-        /* Just return "NO SENSE".  */
-        buflen = scsi_convert_sense(NULL, 0, outbuf, r->buflen,
-                                    (req->cmd.buf[1] & 1) == 0);
-        if (buflen < 0) {
-            goto illegal_request;
-        }
-        break;
-    case SYNCHRONIZE_CACHE:
-        /* The request is used as the AIO opaque value, so add a ref.  */
-        scsi_req_ref(&r->req);
-        block_acct_start(blk_get_stats(lu->qdev.conf.blk), &r->acct, 0,
-                         BLOCK_ACCT_FLUSH);
-        r->req.aiocb = blk_aio_flush(lu->qdev.conf.blk, scsi_aio_complete, r);
-        return 0;
-    case VERIFY_10:
-        trace_ufs_scsi_emulate_command_VERIFY((req->cmd.buf[1] >> 1) & 3);
-        if (req->cmd.buf[1] & 6) {
-            goto illegal_request;
-        }
-        break;
-    case SERVICE_ACTION_IN_16:
-        /* Service Action In subcommands. */
-        if ((req->cmd.buf[1] & 31) == SAI_READ_CAPACITY_16) {
-            trace_ufs_scsi_emulate_command_SAI_16();
-            memset(outbuf, 0, req->cmd.xfer);
-
-            if (lu->qdev.max_lba > 0) {
-                last_block = lu->qdev.max_lba - 1;
-            };
-            outbuf[0] = 0;
-            outbuf[1] = 0;
-            outbuf[2] = 0;
-            outbuf[3] = 0;
-            outbuf[4] = (last_block >> 24) & 0xff;
-            outbuf[5] = (last_block >> 16) & 0xff;
-            outbuf[6] = (last_block >> 8) & 0xff;
-            outbuf[7] = last_block & 0xff;
-            outbuf[8] = (lu->qdev.blocksize >> 24) & 0xff;
-            outbuf[9] = (lu->qdev.blocksize >> 16) & 0xff;
-            outbuf[10] = (lu->qdev.blocksize >> 8) & 0xff;
-            outbuf[11] = lu->qdev.blocksize & 0xff;
-            outbuf[12] = 0;
-            outbuf[13] = get_physical_block_exp(&lu->qdev.conf);
-
-            if (lu->unit_desc.provisioning_type == 2 ||
-                lu->unit_desc.provisioning_type == 3) {
-                outbuf[14] = 0x80;
-            }
-            /* Protection, exponent and lowest lba field left blank. */
-            break;
-        }
-        trace_ufs_scsi_emulate_command_SAI_unsupported();
-        goto illegal_request;
-    case MODE_SELECT_10:
-        trace_ufs_scsi_emulate_command_MODE_SELECT_10(r->req.cmd.xfer);
+        /* Just return no sense data */
+        len = scsi_build_sense_buf(outbuf, sizeof(outbuf), SENSE_CODE(NO_SENSE),
+                                   true);
+        scsi_status = GOOD;
         break;
     case START_STOP:
-        /*
-         * TODO: START_STOP is not yet implemented. It always returns success.
-         * Revisit it when ufs power management is implemented.
-         */
-        trace_ufs_scsi_emulate_command_START_STOP();
-        break;
-    case FORMAT_UNIT:
-        trace_ufs_scsi_emulate_command_FORMAT_UNIT();
-        break;
-    case SEND_DIAGNOSTIC:
-        trace_ufs_scsi_emulate_command_SEND_DIAGNOSTIC();
-        break;
-    default:
-        trace_ufs_scsi_emulate_command_UNKNOWN(buf[0],
-                                               scsi_command_name(buf[0]));
-        scsi_check_condition(r, SENSE_CODE(INVALID_OPCODE));
-        return 0;
-    }
-    assert(!r->req.aiocb);
-    r->iov.iov_len = MIN(r->buflen, req->cmd.xfer);
-    if (r->iov.iov_len == 0) {
-        scsi_req_complete(&r->req, GOOD);
-    }
-    if (r->req.cmd.mode == SCSI_XFER_TO_DEV) {
-        assert(r->iov.iov_len == req->cmd.xfer);
-        return -r->iov.iov_len;
-    } else {
-        return r->iov.iov_len;
-    }
-
-illegal_request:
-    if (r->req.status == -1) {
-        scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
-    }
-    return 0;
-}
-
-static void ufs_scsi_emulate_read_data(SCSIRequest *req)
-{
-    UfsSCSIReq *r = DO_UPCAST(UfsSCSIReq, req, req);
-    int buflen = r->iov.iov_len;
-
-    if (buflen) {
-        trace_ufs_scsi_emulate_read_data(buflen);
-        r->iov.iov_len = 0;
-        r->started = true;
-        scsi_req_data(&r->req, buflen);
-        return;
-    }
-
-    /* This also clears the sense buffer for REQUEST SENSE.  */
-    scsi_req_complete(&r->req, GOOD);
-}
-
-static int ufs_scsi_check_mode_select(UfsLu *lu, int page, uint8_t *inbuf,
-                                      int inlen)
-{
-    uint8_t mode_current[SCSI_MAX_MODE_LEN];
-    uint8_t mode_changeable[SCSI_MAX_MODE_LEN];
-    uint8_t *p;
-    int len, expected_len, changeable_len, i;
-
-    /*
-     * The input buffer does not include the page header, so it is
-     * off by 2 bytes.
-     */
-    expected_len = inlen + 2;
-    if (expected_len > SCSI_MAX_MODE_LEN) {
-        return -1;
-    }
-
-    /* MODE_PAGE_ALLS is only valid for MODE SENSE commands */
-    if (page == MODE_PAGE_ALLS) {
-        return -1;
-    }
-
-    p = mode_current;
-    memset(mode_current, 0, inlen + 2);
-    len = mode_sense_page(lu, page, &p, 0);
-    if (len < 0 || len != expected_len) {
-        return -1;
-    }
-
-    p = mode_changeable;
-    memset(mode_changeable, 0, inlen + 2);
-    changeable_len = mode_sense_page(lu, page, &p, 1);
-    assert(changeable_len == len);
-
-    /*
-     * Check that unchangeable bits are the same as what MODE SENSE
-     * would return.
-     */
-    for (i = 2; i < len; i++) {
-        if (((mode_current[i] ^ inbuf[i - 2]) & ~mode_changeable[i]) != 0) {
-            return -1;
+        /* TODO: Revisit it when Power Management is implemented */
+        if (lun == UFS_UPIU_UFS_DEVICE_WLUN) {
+            scsi_status = GOOD;
+            break;
         }
-    }
-    return 0;
-}
-
-static void ufs_scsi_apply_mode_select(UfsLu *lu, int page, uint8_t *p)
-{
-    switch (page) {
-    case MODE_PAGE_CACHING:
-        blk_set_enable_write_cache(lu->qdev.conf.blk, (p[0] & 4) != 0);
-        break;
-
+        /* fallthrough */
     default:
-        break;
+        scsi_build_sense(sense_buf, SENSE_CODE(INVALID_OPCODE));
+        scsi_status = CHECK_CONDITION;
     }
-}
-
-static int mode_select_pages(UfsSCSIReq *r, uint8_t *p, int len, bool change)
-{
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, r->req.dev);
-
-    while (len > 0) {
-        int page, page_len;
 
-        page = p[0] & 0x3f;
-        if (p[0] & 0x40) {
-            goto invalid_param;
-        } else {
-            if (len < 2) {
-                goto invalid_param_len;
-            }
-            page_len = p[1];
-            p += 2;
-            len -= 2;
-        }
-
-        if (page_len > len) {
-            goto invalid_param_len;
-        }
-
-        if (!change) {
-            if (ufs_scsi_check_mode_select(lu, page, p, page_len) < 0) {
-                goto invalid_param;
-            }
-        } else {
-            ufs_scsi_apply_mode_select(lu, page, p);
-        }
-
-        p += page_len;
-        len -= page_len;
+    len = MIN(len, (int)req->data_len);
+    if (scsi_status == GOOD && len > 0 &&
+        dma_buf_read(outbuf, len, NULL, req->sg, MEMTXATTRS_UNSPECIFIED) !=
+            MEMTX_OK) {
+        return UFS_REQUEST_FAIL;
     }
-    return 0;
-
-invalid_param:
-    scsi_check_condition(r, SENSE_CODE(INVALID_PARAM));
-    return -1;
 
-invalid_param_len:
-    scsi_check_condition(r, SENSE_CODE(INVALID_PARAM_LEN));
-    return -1;
+    ufs_build_scsi_response_upiu(req, sense_buf, sizeof(sense_buf), len,
+                                 scsi_status);
+    return UFS_REQUEST_SUCCESS;
 }
 
-static void ufs_scsi_emulate_mode_select(UfsSCSIReq *r, uint8_t *inbuf)
+static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
 {
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, r->req.dev);
-    uint8_t *p = inbuf;
-    int len = r->req.cmd.xfer;
-    int hdr_len = 8;
-    int bd_len;
-    int pass;
-
-    /* We only support PF=1, SP=0.  */
-    if ((r->req.cmd.buf[1] & 0x11) != 0x10) {
-        goto invalid_field;
-    }
-
-    if (len < hdr_len) {
-        goto invalid_param_len;
-    }
-
-    bd_len = lduw_be_p(&p[6]);
-    if (bd_len != 0) {
-        goto invalid_param;
-    }
-
-    len -= hdr_len;
-    p += hdr_len;
-
-    /* Ensure no change is made if there is an error!  */
-    for (pass = 0; pass < 2; pass++) {
-        if (mode_select_pages(r, p, len, pass == 1) < 0) {
-            assert(pass == 0);
-            return;
-        }
-    }
-
-    if (!blk_enable_write_cache(lu->qdev.conf.blk)) {
-        /* The request is used as the AIO opaque value, so add a ref.  */
-        scsi_req_ref(&r->req);
-        block_acct_start(blk_get_stats(lu->qdev.conf.blk), &r->acct, 0,
-                         BLOCK_ACCT_FLUSH);
-        r->req.aiocb = blk_aio_flush(lu->qdev.conf.blk, scsi_aio_complete, r);
-        return;
-    }
-
-    scsi_req_complete(&r->req, GOOD);
-    return;
-
-invalid_param:
-    scsi_check_condition(r, SENSE_CODE(INVALID_PARAM));
-    return;
+    uint8_t task_tag = req->req_upiu.header.task_tag;
 
-invalid_param_len:
-    scsi_check_condition(r, SENSE_CODE(INVALID_PARAM_LEN));
-    return;
-
-invalid_field:
-    scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
-}
-
-/* block_num and nb_blocks expected to be in qdev blocksize */
-static inline bool check_lba_range(UfsLu *lu, uint64_t block_num,
-                                   uint32_t nb_blocks)
-{
     /*
-     * The first line tests that no overflow happens when computing the last
-     * block.  The second line tests that the last accessed block is in
-     * range.
-     *
-     * Careful, the computations should not underflow for nb_blocks == 0,
-     * and a 0-block read to the first LBA beyond the end of device is
-     * valid.
+     * Each ufs-lu has its own independent virtual SCSI bus. Therefore, we can't
+     * use scsi_target_emulate_report_luns() which gets all lu information over
+     * the SCSI bus. Therefore, we use ufs_emulate_scsi_cmd() like the
+     * well-known lu.
      */
-    return (block_num <= block_num + nb_blocks &&
-            block_num + nb_blocks <= lu->qdev.max_lba + 1);
-}
-
-static void ufs_scsi_emulate_write_data(SCSIRequest *req)
-{
-    UfsSCSIReq *r = DO_UPCAST(UfsSCSIReq, req, req);
-
-    if (r->iov.iov_len) {
-        int buflen = r->iov.iov_len;
-        trace_ufs_scsi_emulate_write_data(buflen);
-        r->iov.iov_len = 0;
-        scsi_req_data(&r->req, buflen);
-        return;
-    }
-
-    switch (req->cmd.buf[0]) {
-    case MODE_SELECT_10:
-        /* This also clears the sense buffer for REQUEST SENSE.  */
-        ufs_scsi_emulate_mode_select(r, r->iov.iov_base);
-        break;
-    default:
-        abort();
-    }
-}
-
-/* Return a pointer to the data buffer.  */
-static uint8_t *ufs_scsi_get_buf(SCSIRequest *req)
-{
-    UfsSCSIReq *r = DO_UPCAST(UfsSCSIReq, req, req);
-
-    return (uint8_t *)r->iov.iov_base;
-}
-
-static int32_t ufs_scsi_dma_command(SCSIRequest *req, uint8_t *buf)
-{
-    UfsSCSIReq *r = DO_UPCAST(UfsSCSIReq, req, req);
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, req->dev);
-    uint32_t len;
-    uint8_t command;
-
-    command = buf[0];
-
-    if (!blk_is_available(lu->qdev.conf.blk)) {
-        scsi_check_condition(r, SENSE_CODE(NO_MEDIUM));
-        return 0;
-    }
-
-    len = scsi_data_cdb_xfer(r->req.cmd.buf);
-    switch (command) {
-    case READ_6:
-    case READ_10:
-        trace_ufs_scsi_dma_command_READ(r->req.cmd.lba, len);
-        if (r->req.cmd.buf[1] & 0xe0) {
-            goto illegal_request;
-        }
-        if (!check_lba_range(lu, r->req.cmd.lba, len)) {
-            goto illegal_lba;
-        }
-        r->sector = r->req.cmd.lba * (lu->qdev.blocksize / BDRV_SECTOR_SIZE);
-        r->sector_count = len * (lu->qdev.blocksize / BDRV_SECTOR_SIZE);
-        break;
-    case WRITE_6:
-    case WRITE_10:
-        trace_ufs_scsi_dma_command_WRITE(r->req.cmd.lba, len);
-        if (!blk_is_writable(lu->qdev.conf.blk)) {
-            scsi_check_condition(r, SENSE_CODE(WRITE_PROTECTED));
-            return 0;
-        }
-        if (r->req.cmd.buf[1] & 0xe0) {
-            goto illegal_request;
-        }
-        if (!check_lba_range(lu, r->req.cmd.lba, len)) {
-            goto illegal_lba;
-        }
-        r->sector = r->req.cmd.lba * (lu->qdev.blocksize / BDRV_SECTOR_SIZE);
-        r->sector_count = len * (lu->qdev.blocksize / BDRV_SECTOR_SIZE);
-        break;
-    default:
-        abort();
-    illegal_request:
-        scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
-        return 0;
-    illegal_lba:
-        scsi_check_condition(r, SENSE_CODE(LBA_OUT_OF_RANGE));
-        return 0;
-    }
-    r->need_fua_emulation = ((r->req.cmd.buf[1] & 8) != 0);
-    if (r->sector_count == 0) {
-        scsi_req_complete(&r->req, GOOD);
-    }
-    assert(r->iov.iov_len == 0);
-    if (r->req.cmd.mode == SCSI_XFER_TO_DEV) {
-        return -r->sector_count * BDRV_SECTOR_SIZE;
-    } else {
-        return r->sector_count * BDRV_SECTOR_SIZE;
-    }
-}
-
-static void scsi_write_do_fua(UfsSCSIReq *r)
-{
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, r->req.dev);
-
-    assert(r->req.aiocb == NULL);
-    assert(!r->req.io_canceled);
-
-    if (r->need_fua_emulation) {
-        block_acct_start(blk_get_stats(lu->qdev.conf.blk), &r->acct, 0,
-                         BLOCK_ACCT_FLUSH);
-        r->req.aiocb = blk_aio_flush(lu->qdev.conf.blk, scsi_aio_complete, r);
-        return;
-    }
-
-    scsi_req_complete(&r->req, GOOD);
-    scsi_req_unref(&r->req);
-}
-
-static void scsi_dma_complete_noio(UfsSCSIReq *r, int ret)
-{
-    assert(r->req.aiocb == NULL);
-    if (ufs_scsi_req_check_error(r, ret, false)) {
-        goto done;
-    }
-
-    r->sector += r->sector_count;
-    r->sector_count = 0;
-    if (r->req.cmd.mode == SCSI_XFER_TO_DEV) {
-        scsi_write_do_fua(r);
-        return;
-    } else {
-        scsi_req_complete(&r->req, GOOD);
-    }
-
-done:
-    scsi_req_unref(&r->req);
-}
-
-static void scsi_dma_complete(void *opaque, int ret)
-{
-    UfsSCSIReq *r = (UfsSCSIReq *)opaque;
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, r->req.dev);
-
-    assert(r->req.aiocb != NULL);
-    r->req.aiocb = NULL;
-
-    aio_context_acquire(blk_get_aio_context(lu->qdev.conf.blk));
-    if (ret < 0) {
-        block_acct_failed(blk_get_stats(lu->qdev.conf.blk), &r->acct);
-    } else {
-        block_acct_done(blk_get_stats(lu->qdev.conf.blk), &r->acct);
-    }
-    scsi_dma_complete_noio(r, ret);
-    aio_context_release(blk_get_aio_context(lu->qdev.conf.blk));
-}
-
-static BlockAIOCB *scsi_dma_readv(int64_t offset, QEMUIOVector *iov,
-                                  BlockCompletionFunc *cb, void *cb_opaque,
-                                  void *opaque)
-{
-    UfsSCSIReq *r = opaque;
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, r->req.dev);
-    return blk_aio_preadv(lu->qdev.conf.blk, offset, iov, 0, cb, cb_opaque);
-}
-
-static void scsi_init_iovec(UfsSCSIReq *r, size_t size)
-{
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, r->req.dev);
-
-    if (!r->iov.iov_base) {
-        r->buflen = size;
-        r->iov.iov_base = blk_blockalign(lu->qdev.conf.blk, r->buflen);
+    if (req->req_upiu.sc.cdb[0] == REPORT_LUNS) {
+        return ufs_emulate_scsi_cmd(lu, req);
     }
-    r->iov.iov_len = MIN(r->sector_count * BDRV_SECTOR_SIZE, r->buflen);
-    qemu_iovec_init_external(&r->qiov, &r->iov, 1);
-}
 
-static void scsi_read_complete_noio(UfsSCSIReq *r, int ret)
-{
-    uint32_t n;
+    SCSIRequest *scsi_req =
+        scsi_req_new(lu->scsi_dev, task_tag, lu->lun, req->req_upiu.sc.cdb,
+                     UFS_CDB_SIZE, req);
 
-    assert(r->req.aiocb == NULL);
-    if (ufs_scsi_req_check_error(r, ret, false)) {
-        goto done;
+    uint32_t len = scsi_req_enqueue(scsi_req);
+    if (len) {
+        scsi_req_continue(scsi_req);
     }
 
-    n = r->qiov.size / BDRV_SECTOR_SIZE;
-    r->sector += n;
-    r->sector_count -= n;
-    scsi_req_data(&r->req, r->qiov.size);
-
-done:
-    scsi_req_unref(&r->req);
-}
-
-static void scsi_read_complete(void *opaque, int ret)
-{
-    UfsSCSIReq *r = (UfsSCSIReq *)opaque;
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, r->req.dev);
-
-    assert(r->req.aiocb != NULL);
-    r->req.aiocb = NULL;
-    trace_ufs_scsi_read_data_count(r->sector_count);
-    aio_context_acquire(blk_get_aio_context(lu->qdev.conf.blk));
-    if (ret < 0) {
-        block_acct_failed(blk_get_stats(lu->qdev.conf.blk), &r->acct);
-    } else {
-        block_acct_done(blk_get_stats(lu->qdev.conf.blk), &r->acct);
-        trace_ufs_scsi_read_complete(r->req.tag, r->qiov.size);
-    }
-    scsi_read_complete_noio(r, ret);
-    aio_context_release(blk_get_aio_context(lu->qdev.conf.blk));
-}
-
-/* Actually issue a read to the block device.  */
-static void scsi_do_read(UfsSCSIReq *r, int ret)
-{
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, r->req.dev);
-
-    assert(r->req.aiocb == NULL);
-    if (ufs_scsi_req_check_error(r, ret, false)) {
-        goto done;
-    }
-
-    /* The request is used as the AIO opaque value, so add a ref.  */
-    scsi_req_ref(&r->req);
-
-    if (r->req.sg) {
-        dma_acct_start(lu->qdev.conf.blk, &r->acct, r->req.sg, BLOCK_ACCT_READ);
-        r->req.residual -= r->req.sg->size;
-        r->req.aiocb = dma_blk_io(
-            blk_get_aio_context(lu->qdev.conf.blk), r->req.sg,
-            r->sector << BDRV_SECTOR_BITS, BDRV_SECTOR_SIZE, scsi_dma_readv, r,
-            scsi_dma_complete, r, DMA_DIRECTION_FROM_DEVICE);
-    } else {
-        scsi_init_iovec(r, SCSI_DMA_BUF_SIZE);
-        block_acct_start(blk_get_stats(lu->qdev.conf.blk), &r->acct,
-                         r->qiov.size, BLOCK_ACCT_READ);
-        r->req.aiocb = scsi_dma_readv(r->sector << BDRV_SECTOR_BITS, &r->qiov,
-                                      scsi_read_complete, r, r);
-    }
-
-done:
-    scsi_req_unref(&r->req);
-}
-
-static void scsi_do_read_cb(void *opaque, int ret)
-{
-    UfsSCSIReq *r = (UfsSCSIReq *)opaque;
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, r->req.dev);
-
-    assert(r->req.aiocb != NULL);
-    r->req.aiocb = NULL;
-
-    aio_context_acquire(blk_get_aio_context(lu->qdev.conf.blk));
-    if (ret < 0) {
-        block_acct_failed(blk_get_stats(lu->qdev.conf.blk), &r->acct);
-    } else {
-        block_acct_done(blk_get_stats(lu->qdev.conf.blk), &r->acct);
-    }
-    scsi_do_read(opaque, ret);
-    aio_context_release(blk_get_aio_context(lu->qdev.conf.blk));
-}
-
-/* Read more data from scsi device into buffer.  */
-static void scsi_read_data(SCSIRequest *req)
-{
-    UfsSCSIReq *r = DO_UPCAST(UfsSCSIReq, req, req);
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, r->req.dev);
-    bool first;
-
-    trace_ufs_scsi_read_data_count(r->sector_count);
-    if (r->sector_count == 0) {
-        /* This also clears the sense buffer for REQUEST SENSE.  */
-        scsi_req_complete(&r->req, GOOD);
-        return;
-    }
-
-    /* No data transfer may already be in progress */
-    assert(r->req.aiocb == NULL);
-
-    /* The request is used as the AIO opaque value, so add a ref.  */
-    scsi_req_ref(&r->req);
-    if (r->req.cmd.mode == SCSI_XFER_TO_DEV) {
-        trace_ufs_scsi_read_data_invalid();
-        scsi_read_complete_noio(r, -EINVAL);
-        return;
-    }
-
-    if (!blk_is_available(req->dev->conf.blk)) {
-        scsi_read_complete_noio(r, -ENOMEDIUM);
-        return;
-    }
-
-    first = !r->started;
-    r->started = true;
-    if (first && r->need_fua_emulation) {
-        block_acct_start(blk_get_stats(lu->qdev.conf.blk), &r->acct, 0,
-                         BLOCK_ACCT_FLUSH);
-        r->req.aiocb = blk_aio_flush(lu->qdev.conf.blk, scsi_do_read_cb, r);
-    } else {
-        scsi_do_read(r, 0);
-    }
-}
-
-static void scsi_write_complete_noio(UfsSCSIReq *r, int ret)
-{
-    uint32_t n;
-
-    assert(r->req.aiocb == NULL);
-    if (ufs_scsi_req_check_error(r, ret, false)) {
-        goto done;
-    }
-
-    n = r->qiov.size / BDRV_SECTOR_SIZE;
-    r->sector += n;
-    r->sector_count -= n;
-    if (r->sector_count == 0) {
-        scsi_write_do_fua(r);
-        return;
-    } else {
-        scsi_init_iovec(r, SCSI_DMA_BUF_SIZE);
-        trace_ufs_scsi_write_complete_noio(r->req.tag, r->qiov.size);
-        scsi_req_data(&r->req, r->qiov.size);
-    }
-
-done:
-    scsi_req_unref(&r->req);
-}
-
-static void scsi_write_complete(void *opaque, int ret)
-{
-    UfsSCSIReq *r = (UfsSCSIReq *)opaque;
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, r->req.dev);
-
-    assert(r->req.aiocb != NULL);
-    r->req.aiocb = NULL;
-
-    aio_context_acquire(blk_get_aio_context(lu->qdev.conf.blk));
-    if (ret < 0) {
-        block_acct_failed(blk_get_stats(lu->qdev.conf.blk), &r->acct);
-    } else {
-        block_acct_done(blk_get_stats(lu->qdev.conf.blk), &r->acct);
-    }
-    scsi_write_complete_noio(r, ret);
-    aio_context_release(blk_get_aio_context(lu->qdev.conf.blk));
-}
-
-static BlockAIOCB *scsi_dma_writev(int64_t offset, QEMUIOVector *iov,
-                                   BlockCompletionFunc *cb, void *cb_opaque,
-                                   void *opaque)
-{
-    UfsSCSIReq *r = opaque;
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, r->req.dev);
-    return blk_aio_pwritev(lu->qdev.conf.blk, offset, iov, 0, cb, cb_opaque);
-}
-
-static void scsi_write_data(SCSIRequest *req)
-{
-    UfsSCSIReq *r = DO_UPCAST(UfsSCSIReq, req, req);
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, r->req.dev);
-
-    /* No data transfer may already be in progress */
-    assert(r->req.aiocb == NULL);
-
-    /* The request is used as the AIO opaque value, so add a ref.  */
-    scsi_req_ref(&r->req);
-    if (r->req.cmd.mode != SCSI_XFER_TO_DEV) {
-        trace_ufs_scsi_write_data_invalid();
-        scsi_write_complete_noio(r, -EINVAL);
-        return;
-    }
-
-    if (!r->req.sg && !r->qiov.size) {
-        /* Called for the first time.  Ask the driver to send us more data.  */
-        r->started = true;
-        scsi_write_complete_noio(r, 0);
-        return;
-    }
-    if (!blk_is_available(req->dev->conf.blk)) {
-        scsi_write_complete_noio(r, -ENOMEDIUM);
-        return;
-    }
-
-    if (r->req.sg) {
-        dma_acct_start(lu->qdev.conf.blk, &r->acct, r->req.sg,
-                       BLOCK_ACCT_WRITE);
-        r->req.residual -= r->req.sg->size;
-        r->req.aiocb = dma_blk_io(
-            blk_get_aio_context(lu->qdev.conf.blk), r->req.sg,
-            r->sector << BDRV_SECTOR_BITS, BDRV_SECTOR_SIZE, scsi_dma_writev, r,
-            scsi_dma_complete, r, DMA_DIRECTION_TO_DEVICE);
-    } else {
-        block_acct_start(blk_get_stats(lu->qdev.conf.blk), &r->acct,
-                         r->qiov.size, BLOCK_ACCT_WRITE);
-        r->req.aiocb = scsi_dma_writev(r->sector << BDRV_SECTOR_BITS, &r->qiov,
-                                       scsi_write_complete, r, r);
-    }
-}
-
-static const SCSIReqOps ufs_scsi_emulate_reqops = {
-    .size = sizeof(UfsSCSIReq),
-    .free_req = ufs_scsi_free_request,
-    .send_command = ufs_scsi_emulate_command,
-    .read_data = ufs_scsi_emulate_read_data,
-    .write_data = ufs_scsi_emulate_write_data,
-    .get_buf = ufs_scsi_get_buf,
-};
-
-static const SCSIReqOps ufs_scsi_dma_reqops = {
-    .size = sizeof(UfsSCSIReq),
-    .free_req = ufs_scsi_free_request,
-    .send_command = ufs_scsi_dma_command,
-    .read_data = scsi_read_data,
-    .write_data = scsi_write_data,
-    .get_buf = ufs_scsi_get_buf,
-};
-
-/*
- * Following commands are not yet supported
- * PRE_FETCH(10),
- * UNMAP,
- * WRITE_BUFFER, READ_BUFFER,
- * SECURITY_PROTOCOL_IN, SECURITY_PROTOCOL_OUT
- */
-static const SCSIReqOps *const ufs_scsi_reqops_dispatch[256] = {
-    [TEST_UNIT_READY] = &ufs_scsi_emulate_reqops,
-    [INQUIRY] = &ufs_scsi_emulate_reqops,
-    [MODE_SENSE_10] = &ufs_scsi_emulate_reqops,
-    [START_STOP] = &ufs_scsi_emulate_reqops,
-    [READ_CAPACITY_10] = &ufs_scsi_emulate_reqops,
-    [REQUEST_SENSE] = &ufs_scsi_emulate_reqops,
-    [SYNCHRONIZE_CACHE] = &ufs_scsi_emulate_reqops,
-    [MODE_SELECT_10] = &ufs_scsi_emulate_reqops,
-    [VERIFY_10] = &ufs_scsi_emulate_reqops,
-    [FORMAT_UNIT] = &ufs_scsi_emulate_reqops,
-    [SERVICE_ACTION_IN_16] = &ufs_scsi_emulate_reqops,
-    [SEND_DIAGNOSTIC] = &ufs_scsi_emulate_reqops,
-
-    [READ_6] = &ufs_scsi_dma_reqops,
-    [READ_10] = &ufs_scsi_dma_reqops,
-    [WRITE_6] = &ufs_scsi_dma_reqops,
-    [WRITE_10] = &ufs_scsi_dma_reqops,
-};
-
-static SCSIRequest *scsi_new_request(SCSIDevice *dev, uint32_t tag,
-                                     uint32_t lun, uint8_t *buf,
-                                     void *hba_private)
-{
-    UfsLu *lu = DO_UPCAST(UfsLu, qdev, dev);
-    SCSIRequest *req;
-    const SCSIReqOps *ops;
-    uint8_t command;
-
-    command = buf[0];
-    ops = ufs_scsi_reqops_dispatch[command];
-    if (!ops) {
-        ops = &ufs_scsi_emulate_reqops;
-    }
-    req = scsi_req_alloc(ops, &lu->qdev, tag, lun, hba_private);
-
-    return req;
+    return UFS_REQUEST_NO_COMPLETE;
 }
 
 static Property ufs_lu_props[] = {
-    DEFINE_PROP_DRIVE("drive", UfsLu, qdev.conf.blk),
+    DEFINE_PROP_DRIVE("drive", UfsLu, conf.blk),
+    DEFINE_PROP_UINT8("lun", UfsLu, lun, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static bool ufs_lu_brdv_init(UfsLu *lu, Error **errp)
-{
-    SCSIDevice *dev = &lu->qdev;
-    bool read_only;
-
-    if (!lu->qdev.conf.blk) {
-        error_setg(errp, "drive property not set");
-        return false;
-    }
-
-    if (!blkconf_blocksizes(&lu->qdev.conf, errp)) {
-        return false;
-    }
-
-    if (blk_get_aio_context(lu->qdev.conf.blk) != qemu_get_aio_context() &&
-        !lu->qdev.hba_supports_iothread) {
-        error_setg(errp, "HBA does not support iothreads");
-        return false;
-    }
-
-    read_only = !blk_supports_write_perm(lu->qdev.conf.blk);
-
-    if (!blkconf_apply_backend_options(&dev->conf, read_only,
-                                       dev->type == TYPE_DISK, errp)) {
-        return false;
-    }
-
-    if (blk_is_sg(lu->qdev.conf.blk)) {
-        error_setg(errp, "unwanted /dev/sg*");
-        return false;
-    }
-
-    blk_iostatus_enable(lu->qdev.conf.blk);
-    return true;
-}
-
 static bool ufs_add_lu(UfsHc *u, UfsLu *lu, Error **errp)
 {
-    BlockBackend *blk = lu->qdev.conf.blk;
+    BlockBackend *blk = lu->conf.blk;
     int64_t brdv_len = blk_getlength(blk);
     uint64_t raw_dev_cap =
         be64_to_cpu(u->geometry_desc.total_raw_device_capacity);
@@ -1288,156 +304,143 @@ static bool ufs_add_lu(UfsHc *u, UfsLu *lu, Error **errp)
     return true;
 }
 
-static inline uint8_t ufs_log2(uint64_t input)
+void ufs_init_wlu(UfsLu *wlu, uint8_t wlun)
 {
-    int log = 0;
-    while (input >>= 1) {
-        log++;
-    }
-    return log;
+    wlu->lun = wlun;
+    wlu->scsi_op = &ufs_emulate_scsi_cmd;
 }
 
 static void ufs_init_lu(UfsLu *lu)
 {
-    BlockBackend *blk = lu->qdev.conf.blk;
+    BlockBackend *blk = lu->conf.blk;
     int64_t brdv_len = blk_getlength(blk);
 
-    lu->lun = lu->qdev.lun;
     memset(&lu->unit_desc, 0, sizeof(lu->unit_desc));
     lu->unit_desc.length = sizeof(UnitDescriptor);
     lu->unit_desc.descriptor_idn = UFS_QUERY_DESC_IDN_UNIT;
     lu->unit_desc.lu_enable = 0x01;
-    lu->unit_desc.logical_block_size = ufs_log2(lu->qdev.blocksize);
-    lu->unit_desc.unit_index = lu->qdev.lun;
+    lu->unit_desc.logical_block_size = UFS_BLOCK_SIZE_SHIFT;
+    lu->unit_desc.unit_index = lu->lun;
     lu->unit_desc.logical_block_count =
         cpu_to_be64(brdv_len / (1 << lu->unit_desc.logical_block_size));
+
+    lu->scsi_op = &ufs_process_scsi_cmd;
 }
 
 static bool ufs_lu_check_constraints(UfsLu *lu, Error **errp)
 {
-    if (!lu->qdev.conf.blk) {
+    if (!lu->conf.blk) {
         error_setg(errp, "drive property not set");
         return false;
     }
 
-    if (lu->qdev.channel != 0) {
-        error_setg(errp, "ufs logical unit does not support channel");
+    if (lu->lun >= UFS_MAX_LUS) {
+        error_setg(errp, "lun must be between 0 and %d", UFS_MAX_LUS - 1);
         return false;
     }
 
-    if (lu->qdev.lun >= UFS_MAX_LUS) {
-        error_setg(errp, "lun must be between 1 and %d", UFS_MAX_LUS - 1);
-        return false;
+    return true;
+}
+
+static void ufs_init_scsi_device(UfsLu *lu, BlockBackend *blk, Error **errp)
+{
+    DeviceState *scsi_dev;
+
+    scsi_bus_init(&lu->bus, sizeof(lu->bus), DEVICE(lu), &ufs_scsi_info);
+
+    blk_ref(blk);
+    blk_detach_dev(blk, DEVICE(lu));
+    lu->conf.blk = NULL;
+
+    /*
+     * The ufs-lu is the device that is wrapping the scsi-hd. It owns a virtual
+     * SCSI bus that serves the scsi-hd.
+     */
+    scsi_dev = qdev_new("scsi-hd");
+    object_property_add_child(OBJECT(&lu->bus), "ufs-scsi", OBJECT(scsi_dev));
+
+    qdev_prop_set_uint32(scsi_dev, "physical_block_size", UFS_BLOCK_SIZE);
+    qdev_prop_set_uint32(scsi_dev, "logical_block_size", UFS_BLOCK_SIZE);
+    qdev_prop_set_uint32(scsi_dev, "scsi-id", 0);
+    qdev_prop_set_uint32(scsi_dev, "lun", lu->lun);
+    if (!qdev_prop_set_drive_err(scsi_dev, "drive", blk, errp)) {
+        object_unparent(OBJECT(scsi_dev));
+        return;
     }
 
-    return true;
+    if (!qdev_realize_and_unref(scsi_dev, &lu->bus.qbus, errp)) {
+        object_unparent(OBJECT(scsi_dev));
+        return;
+    }
+
+    blk_unref(blk);
+    lu->scsi_dev = SCSI_DEVICE(scsi_dev);
 }
 
-static void ufs_lu_realize(SCSIDevice *dev, Error **errp)
+static void ufs_lu_realize(DeviceState *dev, Error **errp)
 {
     UfsLu *lu = DO_UPCAST(UfsLu, qdev, dev);
-    BusState *s = qdev_get_parent_bus(&dev->qdev);
+    BusState *s = qdev_get_parent_bus(dev);
     UfsHc *u = UFS(s->parent);
-    AioContext *ctx = NULL;
-    uint64_t nb_sectors, nb_blocks;
+    BlockBackend *blk = lu->conf.blk;
 
     if (!ufs_lu_check_constraints(lu, errp)) {
         return;
     }
 
-    ctx = blk_get_aio_context(lu->qdev.conf.blk);
-    aio_context_acquire(ctx);
-    if (!blkconf_blocksizes(&lu->qdev.conf, errp)) {
-        goto out;
+    if (!blk) {
+        error_setg(errp, "drive property not set");
+        return;
+    }
+
+    if (!blkconf_blocksizes(&lu->conf, errp)) {
+        return;
     }
 
-    lu->qdev.blocksize = UFS_BLOCK_SIZE;
-    blk_get_geometry(lu->qdev.conf.blk, &nb_sectors);
-    nb_blocks = nb_sectors / (lu->qdev.blocksize / BDRV_SECTOR_SIZE);
-    if (nb_blocks > UINT32_MAX) {
-        nb_blocks = UINT32_MAX;
+    if (!blkconf_apply_backend_options(&lu->conf, !blk_supports_write_perm(blk),
+                                       true, errp)) {
+        return;
     }
-    lu->qdev.max_lba = nb_blocks;
-    lu->qdev.type = TYPE_DISK;
 
     ufs_init_lu(lu);
     if (!ufs_add_lu(u, lu, errp)) {
-        goto out;
+        return;
     }
 
-    ufs_lu_brdv_init(lu, errp);
-
-out:
-    aio_context_release(ctx);
+    ufs_init_scsi_device(lu, blk, errp);
 }
 
-static void ufs_lu_unrealize(SCSIDevice *dev)
+static void ufs_lu_unrealize(DeviceState *dev)
 {
     UfsLu *lu = DO_UPCAST(UfsLu, qdev, dev);
 
-    blk_drain(lu->qdev.conf.blk);
-}
-
-static void ufs_wlu_realize(DeviceState *qdev, Error **errp)
-{
-    UfsWLu *wlu = UFSWLU(qdev);
-    SCSIDevice *dev = &wlu->qdev;
-
-    if (!is_wlun(dev->lun)) {
-        error_setg(errp, "not well-known logical unit number");
-        return;
+    if (lu->scsi_dev) {
+        object_unref(OBJECT(lu->scsi_dev));
+        lu->scsi_dev = NULL;
     }
-
-    QTAILQ_INIT(&dev->requests);
 }
 
 static void ufs_lu_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-    SCSIDeviceClass *sc = SCSI_DEVICE_CLASS(oc);
 
-    sc->realize = ufs_lu_realize;
-    sc->unrealize = ufs_lu_unrealize;
-    sc->alloc_req = scsi_new_request;
+    dc->realize = ufs_lu_realize;
+    dc->unrealize = ufs_lu_unrealize;
     dc->bus_type = TYPE_UFS_BUS;
     device_class_set_props(dc, ufs_lu_props);
     dc->desc = "Virtual UFS logical unit";
 }
 
-static void ufs_wlu_class_init(ObjectClass *oc, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(oc);
-    SCSIDeviceClass *sc = SCSI_DEVICE_CLASS(oc);
-
-    /*
-     * The realize() function of TYPE_SCSI_DEVICE causes a segmentation fault
-     * if a block drive does not exist. Define a new realize function for
-     * well-known LUs that do not have a block drive.
-     */
-    dc->realize = ufs_wlu_realize;
-    sc->alloc_req = scsi_new_request;
-    dc->bus_type = TYPE_UFS_BUS;
-    dc->desc = "Virtual UFS well-known logical unit";
-}
-
 static const TypeInfo ufs_lu_info = {
     .name = TYPE_UFS_LU,
-    .parent = TYPE_SCSI_DEVICE,
+    .parent = TYPE_DEVICE,
     .class_init = ufs_lu_class_init,
     .instance_size = sizeof(UfsLu),
 };
 
-static const TypeInfo ufs_wlu_info = {
-    .name = TYPE_UFS_WLU,
-    .parent = TYPE_SCSI_DEVICE,
-    .class_init = ufs_wlu_class_init,
-    .instance_size = sizeof(UfsWLu),
-};
-
 static void ufs_lu_register_types(void)
 {
     type_register_static(&ufs_lu_info);
-    type_register_static(&ufs_wlu_info);
 }
 
 type_init(ufs_lu_register_types)
diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 1e55fb0d08..665e1a942b 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -12,31 +12,6 @@ ufs_exec_scsi_cmd(uint32_t slot, uint8_t lun, uint8_t opcode) "slot %"PRIu32", l
 ufs_exec_query_cmd(uint32_t slot, uint8_t opcode) "slot %"PRIu32", opcode 0x%"PRIx8""
 ufs_process_uiccmd(uint32_t uiccmd, uint32_t ucmdarg1, uint32_t ucmdarg2, uint32_t ucmdarg3) "uiccmd 0x%"PRIx32", ucmdarg1 0x%"PRIx32", ucmdarg2 0x%"PRIx32", ucmdarg3 0x%"PRIx32""
 
-# lu.c
-ufs_scsi_check_condition(uint32_t tag, uint8_t key, uint8_t asc, uint8_t ascq) "Command complete tag=0x%x sense=%d/%d/%d"
-ufs_scsi_read_complete(uint32_t tag, size_t size) "Data ready tag=0x%x len=%zd"
-ufs_scsi_read_data_count(uint32_t sector_count) "Read sector_count=%d"
-ufs_scsi_read_data_invalid(void) "Data transfer direction invalid"
-ufs_scsi_write_complete_noio(uint32_t tag, size_t size) "Write complete tag=0x%x more=%zd"
-ufs_scsi_write_data_invalid(void) "Data transfer direction invalid"
-ufs_scsi_emulate_vpd_page_00(size_t xfer) "Inquiry EVPD[Supported pages] buffer size %zd"
-ufs_scsi_emulate_vpd_page_80_not_supported(void) "Inquiry EVPD[Serial number] not supported"
-ufs_scsi_emulate_vpd_page_80(size_t xfer) "Inquiry EVPD[Serial number] buffer size %zd"
-ufs_scsi_emulate_vpd_page_87(size_t xfer) "Inquiry EVPD[Mode Page Policy] buffer size %zd"
-ufs_scsi_emulate_mode_sense(int cmd, int page, size_t xfer, int control) "Mode Sense(%d) (page %d, xfer %zd, page_control %d)"
-ufs_scsi_emulate_read_data(int buflen) "Read buf_len=%d"
-ufs_scsi_emulate_write_data(int buflen) "Write buf_len=%d"
-ufs_scsi_emulate_command_START_STOP(void) "START STOP UNIT"
-ufs_scsi_emulate_command_FORMAT_UNIT(void) "FORMAT UNIT"
-ufs_scsi_emulate_command_SEND_DIAGNOSTIC(void) "SEND DIAGNOSTIC"
-ufs_scsi_emulate_command_SAI_16(void) "SAI READ CAPACITY(16)"
-ufs_scsi_emulate_command_SAI_unsupported(void) "Unsupported Service Action In"
-ufs_scsi_emulate_command_MODE_SELECT_10(size_t xfer) "Mode Select(10) (len %zd)"
-ufs_scsi_emulate_command_VERIFY(int bytchk) "Verify (bytchk %d)"
-ufs_scsi_emulate_command_UNKNOWN(int cmd, const char *name) "Unknown SCSI command (0x%2.2x=%s)"
-ufs_scsi_dma_command_READ(uint64_t lba, uint32_t len) "Read (block %" PRIu64 ", count %u)"
-ufs_scsi_dma_command_WRITE(uint64_t lba, int len) "Write (block %" PRIu64 ", count %u)"
-
 # error condition
 ufs_err_dma_read_utrd(uint32_t slot, uint64_t addr) "failed to read utrd. UTRLDBR slot %"PRIu32", UTRD dma addr %"PRIu64""
 ufs_err_dma_read_req_upiu(uint32_t slot, uint64_t addr) "failed to read req upiu. UTRLDBR slot %"PRIu32", request upiu addr %"PRIu64""
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 2e6d582cc3..68c5f1f6c9 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
+#include "scsi/constants.h"
 #include "trace.h"
 #include "ufs.h"
 
@@ -62,8 +63,6 @@ static MemTxResult ufs_addr_write(UfsHc *u, hwaddr addr, const void *buf,
     return pci_dma_write(PCI_DEVICE(u), addr, buf, size);
 }
 
-static void ufs_complete_req(UfsRequest *req, UfsReqResult req_result);
-
 static inline hwaddr ufs_get_utrd_addr(UfsHc *u, uint32_t slot)
 {
     hwaddr utrl_base_addr = (((hwaddr)u->reg.utrlbau) << 32) + u->reg.utrlba;
@@ -163,11 +162,13 @@ static MemTxResult ufs_dma_read_prdt(UfsRequest *req)
 
     req->sg = g_malloc0(sizeof(QEMUSGList));
     pci_dma_sglist_init(req->sg, PCI_DEVICE(u), prdt_len);
+    req->data_len = 0;
 
     for (uint16_t i = 0; i < prdt_len; ++i) {
         hwaddr data_dma_addr = le64_to_cpu(prd_entries[i].addr);
         uint32_t data_byte_count = le32_to_cpu(prd_entries[i].size) + 1;
         qemu_sglist_add(req->sg, data_dma_addr, data_byte_count);
+        req->data_len += data_byte_count;
     }
     return MEMTX_OK;
 }
@@ -433,23 +434,10 @@ static const MemoryRegionOps ufs_mmio_ops = {
     },
 };
 
-static QEMUSGList *ufs_get_sg_list(SCSIRequest *scsi_req)
-{
-    UfsRequest *req = scsi_req->hba_private;
-    return req->sg;
-}
-
-static void ufs_build_upiu_sense_data(UfsRequest *req, SCSIRequest *scsi_req)
-{
-    req->rsp_upiu.sr.sense_data_len = cpu_to_be16(scsi_req->sense_len);
-    assert(scsi_req->sense_len <= SCSI_SENSE_LEN);
-    memcpy(req->rsp_upiu.sr.sense_data, scsi_req->sense, scsi_req->sense_len);
-}
 
-static void ufs_build_upiu_header(UfsRequest *req, uint8_t trans_type,
-                                  uint8_t flags, uint8_t response,
-                                  uint8_t scsi_status,
-                                  uint16_t data_segment_length)
+void ufs_build_upiu_header(UfsRequest *req, uint8_t trans_type, uint8_t flags,
+                           uint8_t response, uint8_t scsi_status,
+                           uint16_t data_segment_length)
 {
     memcpy(&req->rsp_upiu.header, &req->req_upiu.header, sizeof(UtpUpiuHeader));
     req->rsp_upiu.header.trans_type = trans_type;
@@ -459,96 +447,38 @@ static void ufs_build_upiu_header(UfsRequest *req, uint8_t trans_type,
     req->rsp_upiu.header.data_segment_length = cpu_to_be16(data_segment_length);
 }
 
-static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
-{
-    UfsRequest *req = scsi_req->hba_private;
-    int16_t status = scsi_req->status;
-    uint32_t expected_len = be32_to_cpu(req->req_upiu.sc.exp_data_transfer_len);
-    uint32_t transfered_len = scsi_req->cmd.xfer - resid;
-    uint8_t flags = 0, response = UFS_COMMAND_RESULT_SUCESS;
-    uint16_t data_segment_length;
-
-    if (expected_len > transfered_len) {
-        req->rsp_upiu.sr.residual_transfer_count =
-            cpu_to_be32(expected_len - transfered_len);
-        flags |= UFS_UPIU_FLAG_UNDERFLOW;
-    } else if (expected_len < transfered_len) {
-        req->rsp_upiu.sr.residual_transfer_count =
-            cpu_to_be32(transfered_len - expected_len);
-        flags |= UFS_UPIU_FLAG_OVERFLOW;
-    }
-
-    if (status != 0) {
-        ufs_build_upiu_sense_data(req, scsi_req);
-        response = UFS_COMMAND_RESULT_FAIL;
-    }
-
-    data_segment_length = cpu_to_be16(scsi_req->sense_len +
-                                      sizeof(req->rsp_upiu.sr.sense_data_len));
-    ufs_build_upiu_header(req, UFS_UPIU_TRANSACTION_RESPONSE, flags, response,
-                          status, data_segment_length);
-
-    ufs_complete_req(req, UFS_REQUEST_SUCCESS);
-
-    scsi_req->hba_private = NULL;
-    scsi_req_unref(scsi_req);
-}
-
-static const struct SCSIBusInfo ufs_scsi_info = {
-    .tcq = true,
-    .max_target = 0,
-    .max_lun = UFS_MAX_LUS,
-    .max_channel = 0,
-
-    .get_sg_list = ufs_get_sg_list,
-    .complete = ufs_scsi_command_complete,
-};
-
 static UfsReqResult ufs_exec_scsi_cmd(UfsRequest *req)
 {
     UfsHc *u = req->hc;
     uint8_t lun = req->req_upiu.header.lun;
-    uint8_t task_tag = req->req_upiu.header.task_tag;
-    SCSIDevice *dev = NULL;
+
+    UfsLu *lu = NULL;
 
     trace_ufs_exec_scsi_cmd(req->slot, lun, req->req_upiu.sc.cdb[0]);
 
-    if (!is_wlun(lun)) {
-        if (lun >= u->device_desc.number_lu) {
-            trace_ufs_err_scsi_cmd_invalid_lun(lun);
-            return UFS_REQUEST_FAIL;
-        } else if (u->lus[lun] == NULL) {
-            trace_ufs_err_scsi_cmd_invalid_lun(lun);
-            return UFS_REQUEST_FAIL;
-        }
+    if (!is_wlun(lun) && (lun >= UFS_MAX_LUS || u->lus[lun] == NULL)) {
+        trace_ufs_err_scsi_cmd_invalid_lun(lun);
+        return UFS_REQUEST_FAIL;
     }
 
     switch (lun) {
     case UFS_UPIU_REPORT_LUNS_WLUN:
-        dev = &u->report_wlu->qdev;
+        lu = &u->report_wlu;
         break;
     case UFS_UPIU_UFS_DEVICE_WLUN:
-        dev = &u->dev_wlu->qdev;
+        lu = &u->dev_wlu;
         break;
     case UFS_UPIU_BOOT_WLUN:
-        dev = &u->boot_wlu->qdev;
+        lu = &u->boot_wlu;
         break;
     case UFS_UPIU_RPMB_WLUN:
-        dev = &u->rpmb_wlu->qdev;
+        lu = &u->rpmb_wlu;
         break;
     default:
-        dev = &u->lus[lun]->qdev;
-    }
-
-    SCSIRequest *scsi_req = scsi_req_new(
-        dev, task_tag, lun, req->req_upiu.sc.cdb, UFS_CDB_SIZE, req);
-
-    uint32_t len = scsi_req_enqueue(scsi_req);
-    if (len) {
-        scsi_req_continue(scsi_req);
+        lu = u->lus[lun];
     }
 
-    return UFS_REQUEST_NO_COMPLETE;
+    return lu->scsi_op(lu, req);
 }
 
 static UfsReqResult ufs_exec_nop_cmd(UfsRequest *req)
@@ -1137,7 +1067,7 @@ static void ufs_process_req(void *opaque)
     }
 }
 
-static void ufs_complete_req(UfsRequest *req, UfsReqResult req_result)
+void ufs_complete_req(UfsRequest *req, UfsReqResult req_result)
 {
     UfsHc *u = req->hc;
     assert(req->state == UFS_REQUEST_RUNNING);
@@ -1159,6 +1089,7 @@ static void ufs_clear_req(UfsRequest *req)
         qemu_sglist_destroy(req->sg);
         g_free(req->sg);
         req->sg = NULL;
+        req->data_len = 0;
     }
 
     memset(&req->utrd, 0, sizeof(req->utrd));
@@ -1317,28 +1248,6 @@ static void ufs_init_hc(UfsHc *u)
     u->flags.permanently_disable_fw_update = 1;
 }
 
-static bool ufs_init_wlu(UfsHc *u, UfsWLu **wlu, uint8_t wlun, Error **errp)
-{
-    UfsWLu *new_wlu = UFSWLU(qdev_new(TYPE_UFS_WLU));
-
-    qdev_prop_set_uint32(DEVICE(new_wlu), "lun", wlun);
-
-    /*
-     * The well-known lu shares the same bus as the normal lu. If the well-known
-     * lu writes the same channel value as the normal lu, the report will be
-     * made not only for the normal lu but also for the well-known lu at
-     * REPORT_LUN time. To prevent this, the channel value of normal lu is fixed
-     * to 0 and the channel value of well-known lu is fixed to 1.
-     */
-    qdev_prop_set_uint32(DEVICE(new_wlu), "channel", 1);
-    if (!qdev_realize_and_unref(DEVICE(new_wlu), BUS(&u->bus), errp)) {
-        return false;
-    }
-
-    *wlu = new_wlu;
-    return true;
-}
-
 static void ufs_realize(PCIDevice *pci_dev, Error **errp)
 {
     UfsHc *u = UFS(pci_dev);
@@ -1349,53 +1258,21 @@ static void ufs_realize(PCIDevice *pci_dev, Error **errp)
 
     qbus_init(&u->bus, sizeof(UfsBus), TYPE_UFS_BUS, &pci_dev->qdev,
               u->parent_obj.qdev.id);
-    u->bus.parent_bus.info = &ufs_scsi_info;
 
     ufs_init_state(u);
     ufs_init_hc(u);
     ufs_init_pci(u, pci_dev);
 
-    if (!ufs_init_wlu(u, &u->report_wlu, UFS_UPIU_REPORT_LUNS_WLUN, errp)) {
-        return;
-    }
-
-    if (!ufs_init_wlu(u, &u->dev_wlu, UFS_UPIU_UFS_DEVICE_WLUN, errp)) {
-        return;
-    }
-
-    if (!ufs_init_wlu(u, &u->boot_wlu, UFS_UPIU_BOOT_WLUN, errp)) {
-        return;
-    }
-
-    if (!ufs_init_wlu(u, &u->rpmb_wlu, UFS_UPIU_RPMB_WLUN, errp)) {
-        return;
-    }
+    ufs_init_wlu(&u->report_wlu, UFS_UPIU_REPORT_LUNS_WLUN);
+    ufs_init_wlu(&u->dev_wlu, UFS_UPIU_UFS_DEVICE_WLUN);
+    ufs_init_wlu(&u->boot_wlu, UFS_UPIU_BOOT_WLUN);
+    ufs_init_wlu(&u->rpmb_wlu, UFS_UPIU_RPMB_WLUN);
 }
 
 static void ufs_exit(PCIDevice *pci_dev)
 {
     UfsHc *u = UFS(pci_dev);
 
-    if (u->dev_wlu) {
-        object_unref(OBJECT(u->dev_wlu));
-        u->dev_wlu = NULL;
-    }
-
-    if (u->report_wlu) {
-        object_unref(OBJECT(u->report_wlu));
-        u->report_wlu = NULL;
-    }
-
-    if (u->rpmb_wlu) {
-        object_unref(OBJECT(u->rpmb_wlu));
-        u->rpmb_wlu = NULL;
-    }
-
-    if (u->boot_wlu) {
-        object_unref(OBJECT(u->boot_wlu));
-        u->boot_wlu = NULL;
-    }
-
     qemu_bh_delete(u->doorbell_bh);
     qemu_bh_delete(u->complete_bh);
 
@@ -1437,43 +1314,18 @@ static void ufs_class_init(ObjectClass *oc, void *data)
 static bool ufs_bus_check_address(BusState *qbus, DeviceState *qdev,
                                   Error **errp)
 {
-    SCSIDevice *dev = SCSI_DEVICE(qdev);
-    UfsBusClass *ubc = UFS_BUS_GET_CLASS(qbus);
-    UfsHc *u = UFS(qbus->parent);
-
-    if (strcmp(object_get_typename(OBJECT(dev)), TYPE_UFS_WLU) == 0) {
-        if (dev->lun != UFS_UPIU_REPORT_LUNS_WLUN &&
-            dev->lun != UFS_UPIU_UFS_DEVICE_WLUN &&
-            dev->lun != UFS_UPIU_BOOT_WLUN && dev->lun != UFS_UPIU_RPMB_WLUN) {
-            error_setg(errp, "bad well-known lun: %d", dev->lun);
-            return false;
-        }
-
-        if ((dev->lun == UFS_UPIU_REPORT_LUNS_WLUN && u->report_wlu != NULL) ||
-            (dev->lun == UFS_UPIU_UFS_DEVICE_WLUN && u->dev_wlu != NULL) ||
-            (dev->lun == UFS_UPIU_BOOT_WLUN && u->boot_wlu != NULL) ||
-            (dev->lun == UFS_UPIU_RPMB_WLUN && u->rpmb_wlu != NULL)) {
-            error_setg(errp, "well-known lun %d already exists", dev->lun);
-            return false;
-        }
-
-        return true;
-    }
-
-    if (strcmp(object_get_typename(OBJECT(dev)), TYPE_UFS_LU) != 0) {
+    if (strcmp(object_get_typename(OBJECT(qdev)), TYPE_UFS_LU) != 0) {
         error_setg(errp, "%s cannot be connected to ufs-bus",
-                   object_get_typename(OBJECT(dev)));
+                   object_get_typename(OBJECT(qdev)));
         return false;
     }
 
-    return ubc->parent_check_address(qbus, qdev, errp);
+    return true;
 }
 
 static void ufs_bus_class_init(ObjectClass *class, void *data)
 {
     BusClass *bc = BUS_CLASS(class);
-    UfsBusClass *ubc = UFS_BUS_CLASS(class);
-    ubc->parent_check_address = bc->check_address;
     bc->check_address = ufs_bus_check_address;
 }
 
@@ -1487,7 +1339,7 @@ static const TypeInfo ufs_info = {
 
 static const TypeInfo ufs_bus_info = {
     .name = TYPE_UFS_BUS,
-    .parent = TYPE_SCSI_BUS,
+    .parent = TYPE_BUS,
     .class_init = ufs_bus_class_init,
     .class_size = sizeof(UfsBusClass),
     .instance_size = sizeof(UfsBus),
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index f244228617..8fda94f4ef 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -16,7 +16,8 @@
 #include "block/ufs.h"
 
 #define UFS_MAX_LUS 32
-#define UFS_BLOCK_SIZE 4096
+#define UFS_BLOCK_SIZE_SHIFT 12
+#define UFS_BLOCK_SIZE (1 << UFS_BLOCK_SIZE_SHIFT)
 
 typedef struct UfsBusClass {
     BusClass parent_class;
@@ -24,7 +25,7 @@ typedef struct UfsBusClass {
 } UfsBusClass;
 
 typedef struct UfsBus {
-    SCSIBus parent_bus;
+    BusState parent_bus;
 } UfsBus;
 
 #define TYPE_UFS_BUS "ufs-bus"
@@ -55,19 +56,22 @@ typedef struct UfsRequest {
 
     /* for scsi command */
     QEMUSGList *sg;
+    uint32_t data_len;
 } UfsRequest;
 
+struct UfsLu;
+typedef UfsReqResult (*UfsScsiOp)(struct UfsLu *, UfsRequest *);
+
 typedef struct UfsLu {
-    SCSIDevice qdev;
+    DeviceState qdev;
     uint8_t lun;
     UnitDescriptor unit_desc;
+    SCSIBus bus;
+    SCSIDevice *scsi_dev;
+    BlockConf conf;
+    UfsScsiOp scsi_op;
 } UfsLu;
 
-typedef struct UfsWLu {
-    SCSIDevice qdev;
-    uint8_t lun;
-} UfsWLu;
-
 typedef struct UfsParams {
     char *serial;
     uint8_t nutrs; /* Number of UTP Transfer Request Slots */
@@ -84,10 +88,10 @@ typedef struct UfsHc {
     UfsRequest *req_list;
 
     UfsLu *lus[UFS_MAX_LUS];
-    UfsWLu *report_wlu;
-    UfsWLu *dev_wlu;
-    UfsWLu *boot_wlu;
-    UfsWLu *rpmb_wlu;
+    UfsLu report_wlu;
+    UfsLu dev_wlu;
+    UfsLu boot_wlu;
+    UfsLu rpmb_wlu;
     DeviceDescriptor device_desc;
     GeometryDescriptor geometry_desc;
     Attributes attributes;
@@ -104,9 +108,6 @@ typedef struct UfsHc {
 #define TYPE_UFS_LU "ufs-lu"
 #define UFSLU(obj) OBJECT_CHECK(UfsLu, (obj), TYPE_UFS_LU)
 
-#define TYPE_UFS_WLU "ufs-wlu"
-#define UFSWLU(obj) OBJECT_CHECK(UfsWLu, (obj), TYPE_UFS_WLU)
-
 typedef enum UfsQueryFlagPerm {
     UFS_QUERY_FLAG_NONE = 0x0,
     UFS_QUERY_FLAG_READ = 0x1,
@@ -128,4 +129,9 @@ static inline bool is_wlun(uint8_t lun)
             lun == UFS_UPIU_RPMB_WLUN);
 }
 
+void ufs_build_upiu_header(UfsRequest *req, uint8_t trans_type, uint8_t flags,
+                           uint8_t response, uint8_t scsi_status,
+                           uint16_t data_segment_length);
+void ufs_complete_req(UfsRequest *req, UfsReqResult req_result);
+void ufs_init_wlu(UfsLu *wlu, uint8_t wlun);
 #endif /* HW_UFS_UFS_H */
diff --git a/include/block/ufs.h b/include/block/ufs.h
index 7631a5af10..0b6ec0814d 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -379,7 +379,7 @@ typedef struct Attributes {
 
 /* Command response result code */
 typedef enum CommandRespCode {
-    UFS_COMMAND_RESULT_SUCESS = 0x00,
+    UFS_COMMAND_RESULT_SUCCESS = 0x00,
     UFS_COMMAND_RESULT_FAIL = 0x01,
 } CommandRespCode;
 
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 15d467630c..5daf8c9c49 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -425,6 +425,9 @@ static void ufstest_init(void *obj, void *data, QGuestAllocator *alloc)
     const uint8_t test_unit_ready_cdb[UFS_CDB_SIZE] = {
         TEST_UNIT_READY,
     };
+    const uint8_t request_sense_cdb[UFS_CDB_SIZE] = {
+        REQUEST_SENSE,
+    };
     UtpTransferReqDesc utrd;
     UtpUpiuRsp rsp_upiu;
 
@@ -440,6 +443,12 @@ static void ufstest_init(void *obj, void *data, QGuestAllocator *alloc)
     /* There is one logical unit whose lun is 0 */
     g_assert_cmpuint(buf[9], ==, 0);
 
+    /* Clear Unit Attention */
+    ufs_send_scsi_command(ufs, 0, 0, request_sense_cdb, NULL, 0, buf,
+                          sizeof(buf), &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+
     /* Check TEST_UNIT_READY */
     ufs_send_scsi_command(ufs, 0, 0, test_unit_ready_cdb, NULL, 0, NULL, 0,
                           &utrd, &rsp_upiu);
@@ -473,6 +482,9 @@ static void ufstest_read_write(void *obj, void *data, QGuestAllocator *alloc)
         0x00,
         0x00
     };
+    const uint8_t request_sense_cdb[UFS_CDB_SIZE] = {
+        REQUEST_SENSE,
+    };
     const uint8_t read_cdb[UFS_CDB_SIZE] = {
         /* READ(10) to LBA 0, transfer length 1 */
         READ_10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
@@ -484,32 +496,39 @@ static void ufstest_read_write(void *obj, void *data, QGuestAllocator *alloc)
     uint32_t block_size;
     UtpTransferReqDesc utrd;
     UtpUpiuRsp rsp_upiu;
+    const int test_lun = 1;
 
     ufs_init(ufs, alloc);
 
+    /* Clear Unit Attention */
+    ufs_send_scsi_command(ufs, 0, test_lun, request_sense_cdb, NULL, 0,
+                          read_buf, sizeof(read_buf), &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.scsi_status, ==, CHECK_CONDITION);
+
     /* Read capacity */
-    ufs_send_scsi_command(ufs, 0, 1, read_capacity_cdb, NULL, 0, read_buf,
-                          sizeof(read_buf), &utrd, &rsp_upiu);
+    ufs_send_scsi_command(ufs, 0, test_lun, read_capacity_cdb, NULL, 0,
+                          read_buf, sizeof(read_buf), &utrd, &rsp_upiu);
     g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.scsi_status, ==,
-                     UFS_COMMAND_RESULT_SUCESS);
+                     UFS_COMMAND_RESULT_SUCCESS);
     block_size = ldl_be_p(&read_buf[8]);
     g_assert_cmpuint(block_size, ==, 4096);
 
     /* Write data */
     memset(write_buf, 0xab, block_size);
-    ufs_send_scsi_command(ufs, 0, 1, write_cdb, write_buf, block_size, NULL, 0,
-                          &utrd, &rsp_upiu);
+    ufs_send_scsi_command(ufs, 0, test_lun, write_cdb, write_buf, block_size,
+                          NULL, 0, &utrd, &rsp_upiu);
     g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.scsi_status, ==,
-                     UFS_COMMAND_RESULT_SUCESS);
+                     UFS_COMMAND_RESULT_SUCCESS);
 
     /* Read data and verify */
-    ufs_send_scsi_command(ufs, 0, 1, read_cdb, NULL, 0, read_buf, block_size,
-                          &utrd, &rsp_upiu);
+    ufs_send_scsi_command(ufs, 0, test_lun, read_cdb, NULL, 0, read_buf,
+                          block_size, &utrd, &rsp_upiu);
     g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
     g_assert_cmpuint(rsp_upiu.header.scsi_status, ==,
-                     UFS_COMMAND_RESULT_SUCESS);
+                     UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpint(memcmp(read_buf, write_buf, block_size), ==, 0);
 
     ufs_exit(ufs, alloc);
-- 
2.34.1


