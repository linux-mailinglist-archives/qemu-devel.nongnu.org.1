Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7272759F62
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 22:14:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMDY4-0001bA-9D; Wed, 19 Jul 2023 16:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qMDXz-0001Xp-Cm; Wed, 19 Jul 2023 16:13:19 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qMDXw-0001ct-N4; Wed, 19 Jul 2023 16:13:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5B61015166;
 Wed, 19 Jul 2023 23:13:13 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 733E7181F7;
 Wed, 19 Jul 2023 23:13:11 +0300 (MSK)
Message-ID: <437f0e05-f052-cb78-418f-054378c6ae68@tls.msk.ru>
Date: Wed, 19 Jul 2023 23:13:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 1/1] hw/nvme: fix endianness issue for shadow doorbells
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@redhat.com>
References: <20230719073605.98222-3-its@irrelevant.dk>
 <20230719073605.98222-4-its@irrelevant.dk>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230719073605.98222-4-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

19.07.2023 10:36, Klaus Jensen wrote:
pu(req->cmd.dptr.prp2);
> +    uint32_t v;

>           if (sq) {
> +            v = cpu_to_le32(sq->tail);

> -            pci_dma_write(pci, sq->db_addr, &sq->tail, sizeof(sq->tail));
> +            pci_dma_write(pci, sq->db_addr, &v, sizeof(sq->tail));

This and similar cases hurts my eyes.

Why we pass address of v here, but use sizeof(sq->tail) ?

Yes, I know both in theory should be of the same size, but heck,
this is puzzling at best, and confusing in a regular case.

Dunno how it slipped in the review, it instantly catched my eye
in a row of applied patches..

Also, why v is computed a few lines before it is used, with
some expressions between the assignment and usage?

How about the following patch:

From: Michael Tokarev <mjt@tls.msk.ru>
Date: Wed, 19 Jul 2023 23:10:53 +0300
Subject: [PATCH trivial] hw/nvme: fix sizeof() misuse and move endianness conversions
  closer to users

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Fixes: ea3c76f1494d0
---
  hw/nvme/ctrl.c | 17 +++++++----------
  1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index dadc2dc7da..e33b28cf66 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6820,6 +6820,4 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)

          if (sq) {
-            v = cpu_to_le32(sq->tail);
-
              /*
               * CAP.DSTRD is 0, so offset of ith sq db_addr is (i<<3)
@@ -6829,5 +6827,6 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
              sq->db_addr = dbs_addr + (i << 3);
              sq->ei_addr = eis_addr + (i << 3);
-            pci_dma_write(pci, sq->db_addr, &v, sizeof(sq->tail));
+            v = cpu_to_le32(sq->tail);
+            pci_dma_write(pci, sq->db_addr, &v, sizeof(v));

              if (n->params.ioeventfd && sq->sqid != 0) {
@@ -6839,10 +6838,9 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)

          if (cq) {
-            v = cpu_to_le32(cq->head);
-
              /* CAP.DSTRD is 0, so offset of ith cq db_addr is (i<<3)+(1<<2) */
              cq->db_addr = dbs_addr + (i << 3) + (1 << 2);
              cq->ei_addr = eis_addr + (i << 3) + (1 << 2);
-            pci_dma_write(pci, cq->db_addr, &v, sizeof(cq->head));
+            v = cpu_to_le32(cq->head);
+            pci_dma_write(pci, cq->db_addr, &v, sizeof(v));

              if (n->params.ioeventfd && cq->cqid != 0) {
@@ -7661,5 +7659,5 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
          if (!qid && n->dbbuf_enabled) {
              v = cpu_to_le32(cq->head);
-            pci_dma_write(pci, cq->db_addr, &v, sizeof(cq->head));
+            pci_dma_write(pci, cq->db_addr, &v, sizeof(v));
          }
          if (start_sqs) {
@@ -7721,6 +7719,4 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
          sq->tail = new_tail;
          if (!qid && n->dbbuf_enabled) {
-            v = cpu_to_le32(sq->tail);
-
              /*
               * The spec states "the host shall also update the controller's
@@ -7736,5 +7732,6 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
               * so we can't trust reading it for an appropriate sq tail.
               */
-            pci_dma_write(pci, sq->db_addr, &v, sizeof(sq->tail));
+            v = cpu_to_le32(sq->tail);
+            pci_dma_write(pci, sq->db_addr, &v, sizeof(v));
          }



