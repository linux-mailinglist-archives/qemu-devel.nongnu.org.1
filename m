Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E1AB89C45
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Sep 2025 16:00:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbcV-0004dl-1I; Fri, 19 Sep 2025 09:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1uzaKu-0001yL-FF; Fri, 19 Sep 2025 08:35:36 -0400
Received: from mail.avm.de ([2001:bf0:244:244::120])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1uzaKe-00005F-KV; Fri, 19 Sep 2025 08:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1758285309; bh=jiNBsQqL3y3YuuTa2svOPt+IvT9nmWDVRYocIZVDxks=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=iKgN4NqKHQnAr7Fd2YxOE8fnWwUhHvU5WqHGiYPrvSbDWlfxT/xqmt5KYSVsAkPV9
 Zjzc70vZfPXZ8EHh2yjG9q43ZR2UZkv/1+qov2Xa0/NW7vR7UH2pitgboyqwzx72cb
 Ul46hSnhix4AYlVsSxBJojzSmYPtcjAK1yFEu3S0=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.53.4)
 (envelope-from <c.speich@avm.de>)
 id 68cd4dfd-c042-7f0000032729-7f0000018850-1
 for <multiple-recipients>; Fri, 19 Sep 2025 14:35:09 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Fri, 19 Sep 2025 14:35:09 +0200 (CEST)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2025091914351038-13016 ;
 Fri, 19 Sep 2025 14:35:10 +0200 
From: Christian Speich <c.speich@avm.de>
Date: Fri, 19 Sep 2025 14:34:41 +0200
Subject: [PATCH 2/4] hw/sd/sdhci: Don't use bounce buffer for ADMA
MIME-Version: 1.0
Message-Id: <20250919-sdcard-performance-b4-v1-2-e1037e481a19@avm.de>
References: <20250919-sdcard-performance-b4-v1-0-e1037e481a19@avm.de>
In-Reply-To: <20250919-sdcard-performance-b4-v1-0-e1037e481a19@avm.de>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, qemu-block@nongnu.org, Christian Speich
 <c.speich@avm.de>
X-Mailer: b4 0.14.2
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 19.09.2025 14:35:10,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 19.09.2025 14:35:10, Serialize complete at 19.09.2025 14:35:10
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-purgate-ID: 149429::1758285309-1BE79DB6-AA9E6793/0/0
X-purgate-type: clean
X-purgate-size: 6515
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=2001:bf0:244:244::120;
 envelope-from=c.speich@avm.de; helo=mail.avm.de
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Sep 2025 09:57:38 -0400
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

Currently, ADMA will temporarily store data into a local bounce buffer
when transferring it. This will produce unneeded copies of the data and
limit us to the bounce buffer size for each step.

This patch now maps the requested DMA address and passes this buffer
directly to sdbus_{read,write}_data. This allows to pass much larger
buffers down to increase the performance. sdbus_{read,write}_data is
already able to handle arbitrary length and alignments, so we do not
need to ensure this.

Signed-off-by: Christian Speich <c.speich@avm.de>
---
 hw/sd/sdhci.c | 102 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 55 insertions(+), 47 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 3c897e54b721075a3ebd215e027fb73a65ff39b2..94ba23a8da990e69fd59c039e4fdd25b98929dfd 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -774,7 +774,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
 
 static void sdhci_do_adma(SDHCIState *s)
 {
-    unsigned int begin, length;
+    unsigned int length;
     const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
     const MemTxAttrs attrs = { .memory = true };
     ADMADescr dscr = {};
@@ -816,66 +816,74 @@ static void sdhci_do_adma(SDHCIState *s)
             if (s->trnmod & SDHC_TRNS_READ) {
                 s->prnsts |= SDHC_DOING_READ;
                 while (length) {
-                    if (s->data_count == 0) {
-                        sdbus_read_data(&s->sdbus, s->fifo_buffer, block_size);
-                    }
-                    begin = s->data_count;
-                    if ((length + begin) < block_size) {
-                        s->data_count = length + begin;
-                        length = 0;
-                     } else {
-                        s->data_count = block_size;
-                        length -= block_size - begin;
-                    }
-                    res = dma_memory_write(s->dma_as, dscr.addr,
-                                           &s->fifo_buffer[begin],
-                                           s->data_count - begin,
-                                           attrs);
-                    if (res != MEMTX_OK) {
+                    dma_addr_t dma_len = length;
+
+                    void *buf = dma_memory_map(s->dma_as, dscr.addr, &dma_len,
+                                               DMA_DIRECTION_FROM_DEVICE,
+                                               attrs);
+
+                    if (buf == NULL) {
+                        res = MEMTX_ERROR;
                         break;
+                    } else {
+                        res = MEMTX_OK;
                     }
-                    dscr.addr += s->data_count - begin;
-                    if (s->data_count == block_size) {
-                        s->data_count = 0;
-                        if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
-                            s->blkcnt--;
-                            if (s->blkcnt == 0) {
-                                break;
-                            }
+
+                    sdbus_read_data(&s->sdbus, buf, dma_len);
+                    length -= dma_len;
+                    dscr.addr += dma_len;
+
+                    dma_memory_unmap(s->dma_as, buf, dma_len,
+                                     DMA_DIRECTION_FROM_DEVICE, dma_len);
+
+                    if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
+                        size_t transfered = s->data_count + dma_len;
+
+                        s->blkcnt -= transfered / block_size;
+                        s->data_count = transfered % block_size;
+
+                        if (s->blkcnt == 0) {
+                            s->data_count = 0;
+                            break;
                         }
                     }
                 }
             } else {
                 s->prnsts |= SDHC_DOING_WRITE;
                 while (length) {
-                    begin = s->data_count;
-                    if ((length + begin) < block_size) {
-                        s->data_count = length + begin;
-                        length = 0;
-                     } else {
-                        s->data_count = block_size;
-                        length -= block_size - begin;
-                    }
-                    res = dma_memory_read(s->dma_as, dscr.addr,
-                                          &s->fifo_buffer[begin],
-                                          s->data_count - begin,
-                                          attrs);
-                    if (res != MEMTX_OK) {
+                    dma_addr_t dma_len = length;
+
+                    void *buf = dma_memory_map(s->dma_as, dscr.addr, &dma_len,
+                                               DMA_DIRECTION_TO_DEVICE, attrs);
+
+                    if (buf == NULL) {
+                        res = MEMTX_ERROR;
                         break;
+                    } else {
+                        res = MEMTX_OK;
                     }
-                    dscr.addr += s->data_count - begin;
-                    if (s->data_count == block_size) {
-                        sdbus_write_data(&s->sdbus, s->fifo_buffer, block_size);
-                        s->data_count = 0;
-                        if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
-                            s->blkcnt--;
-                            if (s->blkcnt == 0) {
-                                break;
-                            }
+
+                    sdbus_write_data(&s->sdbus, buf, dma_len);
+                    length -= dma_len;
+                    dscr.addr += dma_len;
+
+                    dma_memory_unmap(s->dma_as, buf, dma_len,
+                                     DMA_DIRECTION_TO_DEVICE, dma_len);
+
+                    if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
+                        size_t transfered = s->data_count + dma_len;
+
+                        s->blkcnt -= transfered / block_size;
+                        s->data_count = transfered % block_size;
+
+                        if (s->blkcnt == 0) {
+                            s->data_count = 0;
+                            break;
                         }
                     }
                 }
             }
+
             if (res != MEMTX_OK) {
                 s->data_count = 0;
                 if (s->errintstsen & SDHC_EISEN_ADMAERR) {

-- 
2.43.0


