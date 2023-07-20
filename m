Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F1875B3E7
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 18:11:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMWFQ-0001WF-GR; Thu, 20 Jul 2023 12:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qMWFI-0001Uc-Im
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qMWFE-0008SJ-HS
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689869471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3LKYxGef4eO8ZKKytPixy2C7/r7nCGXzaXB6jlWYN9U=;
 b=JbncMOMDtYnk1um67fDvvvWR1r52SN3F+qb9vGVlBgPJ/cnSAnTZqH7FUajvw5Dstr7/E1
 Sa26AK8KLFCX0b5kiJduYy55npjUk+CMdOEmWtZJG4Hp7xWgriq8c4si74P/TFs1Txz3p0
 vHKTR6j4yf4zMr8hbYyD004aNrpgn6E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-uK-Tia9mNSaJ0yb756tgrA-1; Thu, 20 Jul 2023 12:11:07 -0400
X-MC-Unique: uK-Tia9mNSaJ0yb756tgrA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30793c16c78so589725f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 09:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689869463; x=1690474263;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3LKYxGef4eO8ZKKytPixy2C7/r7nCGXzaXB6jlWYN9U=;
 b=IAyuXftQRKzUwM/ndxclbOtK9Oh7a11GxA79jXSBXOI9pmyDLadEp95ykenODiruS8
 ZycWXdQ4e+rdb8pnF4IQRlg/NrkZCAFAw9FZvMxzFzlNcE7sn90NpEucUTn4+wftuaL2
 3bGsjm6bdm4s4ZbxjyYjBVu72z78eVrt8ghQ9fWB9fNnbdHsu0Vp/E5alnEvw89c4qPg
 uK3ZBEw+Lu7kUqT5xAN5mL+9RZ757MFVfdABnpjHMGNg53gPZtk2OCpeAX6hYIgkfiww
 s6iviYI5SC6dmerkosg58BbjiqCFSa71UcgYQm+szZFOYBi5zzxfrqLUG1YRp0zdqhKd
 VC5A==
X-Gm-Message-State: ABy/qLaollBSL31iZR0LZhSg9ePhPeDATfgDLQtSbq3nI6dSpzFY/8mO
 qG9PiDtCkJ6zjZaE2ab0YWW3P2ueO5wEZ/GBPUOcvgBq9UaJuKFhCjymkV9UpkXn23Cqe++cKpc
 Met5+bS7q89HlD6Q=
X-Received: by 2002:a5d:410a:0:b0:316:ecd9:aa3c with SMTP id
 l10-20020a5d410a000000b00316ecd9aa3cmr2667520wrp.5.1689869462982; 
 Thu, 20 Jul 2023 09:11:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGkVAVBikU7tCLqtxWgXE27La2A6qGOUjyeoCKwk2kYREkdYX5lHvByObXOKtM2/XYBJ7S7QA==
X-Received: by 2002:a5d:410a:0:b0:316:ecd9:aa3c with SMTP id
 l10-20020a5d410a000000b00316ecd9aa3cmr2667496wrp.5.1689869462557; 
 Thu, 20 Jul 2023 09:11:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:9283:b79f:cbb3:327a?
 ([2a01:e0a:9e2:9000:9283:b79f:cbb3:327a])
 by smtp.gmail.com with ESMTPSA id
 cr18-20020a05600004f200b003141a3c4353sm1709966wrb.30.2023.07.20.09.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jul 2023 09:11:01 -0700 (PDT)
Message-ID: <583b9cb3-4c12-9364-c166-f688d5cbf924@redhat.com>
Date: Thu, 20 Jul 2023 18:11:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/nvme: use stl/ldl pci dma api
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
References: <20230720094223.27767-2-its@irrelevant.dk>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230720094223.27767-2-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/20/23 11:42, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Use the stl/ldl pci dma api for writing/reading doorbells. This removes
> the explicit endian conversions.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>

on big and little endian hosts,

Thanks,

C.


> ---
>   hw/nvme/ctrl.c | 42 +++++++++++++-----------------------------
>   1 file changed, 13 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index dadc2dc7da10..f2e5a2fa737b 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -1468,20 +1468,16 @@ static inline void nvme_blk_write(BlockBackend *blk, int64_t offset,
>   
>   static void nvme_update_cq_eventidx(const NvmeCQueue *cq)
>   {
> -    uint32_t v = cpu_to_le32(cq->head);
> -
>       trace_pci_nvme_update_cq_eventidx(cq->cqid, cq->head);
>   
> -    pci_dma_write(PCI_DEVICE(cq->ctrl), cq->ei_addr, &v, sizeof(v));
> +    stl_le_pci_dma(PCI_DEVICE(cq->ctrl), cq->ei_addr, cq->head,
> +                   MEMTXATTRS_UNSPECIFIED);
>   }
>   
>   static void nvme_update_cq_head(NvmeCQueue *cq)
>   {
> -    uint32_t v;
> -
> -    pci_dma_read(PCI_DEVICE(cq->ctrl), cq->db_addr, &v, sizeof(v));
> -
> -    cq->head = le32_to_cpu(v);
> +    ldl_le_pci_dma(PCI_DEVICE(cq->ctrl), cq->db_addr, &cq->head,
> +                   MEMTXATTRS_UNSPECIFIED);
>   
>       trace_pci_nvme_update_cq_head(cq->cqid, cq->head);
>   }
> @@ -6801,7 +6797,6 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
>       PCIDevice *pci = PCI_DEVICE(n);
>       uint64_t dbs_addr = le64_to_cpu(req->cmd.dptr.prp1);
>       uint64_t eis_addr = le64_to_cpu(req->cmd.dptr.prp2);
> -    uint32_t v;
>       int i;
>   
>       /* Address should be page aligned */
> @@ -6819,8 +6814,6 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
>           NvmeCQueue *cq = n->cq[i];
>   
>           if (sq) {
> -            v = cpu_to_le32(sq->tail);
> -
>               /*
>                * CAP.DSTRD is 0, so offset of ith sq db_addr is (i<<3)
>                * nvme_process_db() uses this hard-coded way to calculate
> @@ -6828,7 +6821,7 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
>                */
>               sq->db_addr = dbs_addr + (i << 3);
>               sq->ei_addr = eis_addr + (i << 3);
> -            pci_dma_write(pci, sq->db_addr, &v, sizeof(sq->tail));
> +            stl_le_pci_dma(pci, sq->db_addr, sq->tail, MEMTXATTRS_UNSPECIFIED);
>   
>               if (n->params.ioeventfd && sq->sqid != 0) {
>                   if (!nvme_init_sq_ioeventfd(sq)) {
> @@ -6838,12 +6831,10 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
>           }
>   
>           if (cq) {
> -            v = cpu_to_le32(cq->head);
> -
>               /* CAP.DSTRD is 0, so offset of ith cq db_addr is (i<<3)+(1<<2) */
>               cq->db_addr = dbs_addr + (i << 3) + (1 << 2);
>               cq->ei_addr = eis_addr + (i << 3) + (1 << 2);
> -            pci_dma_write(pci, cq->db_addr, &v, sizeof(cq->head));
> +            stl_le_pci_dma(pci, cq->db_addr, cq->head, MEMTXATTRS_UNSPECIFIED);
>   
>               if (n->params.ioeventfd && cq->cqid != 0) {
>                   if (!nvme_init_cq_ioeventfd(cq)) {
> @@ -6974,20 +6965,16 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
>   
>   static void nvme_update_sq_eventidx(const NvmeSQueue *sq)
>   {
> -    uint32_t v = cpu_to_le32(sq->tail);
> -
>       trace_pci_nvme_update_sq_eventidx(sq->sqid, sq->tail);
>   
> -    pci_dma_write(PCI_DEVICE(sq->ctrl), sq->ei_addr, &v, sizeof(v));
> +    stl_le_pci_dma(PCI_DEVICE(sq->ctrl), sq->ei_addr, sq->tail,
> +                   MEMTXATTRS_UNSPECIFIED);
>   }
>   
>   static void nvme_update_sq_tail(NvmeSQueue *sq)
>   {
> -    uint32_t v;
> -
> -    pci_dma_read(PCI_DEVICE(sq->ctrl), sq->db_addr, &v, sizeof(v));
> -
> -    sq->tail = le32_to_cpu(v);
> +    ldl_le_pci_dma(PCI_DEVICE(sq->ctrl), sq->db_addr, &sq->tail,
> +                   MEMTXATTRS_UNSPECIFIED);
>   
>       trace_pci_nvme_update_sq_tail(sq->sqid, sq->tail);
>   }
> @@ -7592,7 +7579,7 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr addr, unsigned size)
>   static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>   {
>       PCIDevice *pci = PCI_DEVICE(n);
> -    uint32_t qid, v;
> +    uint32_t qid;
>   
>       if (unlikely(addr & ((1 << 2) - 1))) {
>           NVME_GUEST_ERR(pci_nvme_ub_db_wr_misaligned,
> @@ -7659,8 +7646,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>           start_sqs = nvme_cq_full(cq) ? 1 : 0;
>           cq->head = new_head;
>           if (!qid && n->dbbuf_enabled) {
> -            v = cpu_to_le32(cq->head);
> -            pci_dma_write(pci, cq->db_addr, &v, sizeof(cq->head));
> +            stl_le_pci_dma(pci, cq->db_addr, cq->head, MEMTXATTRS_UNSPECIFIED);
>           }
>           if (start_sqs) {
>               NvmeSQueue *sq;
> @@ -7720,8 +7706,6 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>   
>           sq->tail = new_tail;
>           if (!qid && n->dbbuf_enabled) {
> -            v = cpu_to_le32(sq->tail);
> -
>               /*
>                * The spec states "the host shall also update the controller's
>                * corresponding doorbell property to match the value of that entry
> @@ -7735,7 +7719,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>                * including ones that run on Linux, are not updating Admin Queues,
>                * so we can't trust reading it for an appropriate sq tail.
>                */
> -            pci_dma_write(pci, sq->db_addr, &v, sizeof(sq->tail));
> +            stl_le_pci_dma(pci, sq->db_addr, sq->tail, MEMTXATTRS_UNSPECIFIED);
>           }
>   
>           qemu_bh_schedule(sq->bh);


