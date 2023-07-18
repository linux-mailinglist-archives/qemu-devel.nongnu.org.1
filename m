Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 521F87579E4
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:56:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLiND-0004Dj-F7; Tue, 18 Jul 2023 06:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qLiNC-0004DQ-0A
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qLiNA-00053q-CH
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689677762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZ3jd+QDygSaJaS8tMYgCWnkTPafW0H1bfWvGaTpaTs=;
 b=EFXfsqWYKfV4Keau6jED4JwEg0IEsmk+h9/uf/6jJelm5VcshtKEYErdjfcLyvdhjWtNo8
 2UrteiJyNZ25WFDWZpC/JgaJYAaOyOrhycPVOlU8GWJwcVOIvGUv+sRjcPFS6B3c70RuKE
 jQBWfNlf3o9nex1Mfj96lj+buq77Nxk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-r2peHfMhO4OmmHKGymoHUA-1; Tue, 18 Jul 2023 06:43:13 -0400
X-MC-Unique: r2peHfMhO4OmmHKGymoHUA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-403a4cdbfa2so52462821cf.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 03:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689676993; x=1690281793;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sZ3jd+QDygSaJaS8tMYgCWnkTPafW0H1bfWvGaTpaTs=;
 b=F4rqtbvED4+FNhbiYSOA1sK9k7h9nvk7TqgOy4uWK7FhqeHdwaFuKlN4hD1q9PkikA
 nQQ0FUmuIIufSm+blX1JkeapgS0a4hYvRkP/trB69PSDfX22TNnVSM9/8QI8xHTtR2z5
 /mCPevLXUvRCFVbPQ9paGJ9QtNAKHNoSpR3gm9r2DVVZplp0NpB7h2+S+ZES9RqiYMyo
 YDH7yoSgvV0/w53RLpaMqJKwf3+rXCXCo31ONMa1IosD6P/VsZOSmaX89Dom7QyRmTx9
 D4pQSLFGs5UXE3Eu8hGFYMUWGSUVrP/vXbfGN9sl5D33F+KpMuPJlE8E6anj8Pjy4XMx
 cyvQ==
X-Gm-Message-State: ABy/qLad4ZgGs2eg4B0RD+hu2tsTH/TH8EYMLgxuYtIXV3+OmPPNPXKj
 ph8os8QVhoYH6Ln+DxUZi0V3JNxOK6pEXpKmJqzEMGNu7/UV0T4cqitN2kZvTtxRUfkKx6wc/Je
 K0cqCqjB/cljZNt4=
X-Received: by 2002:a05:622a:2c9:b0:403:a707:4ce8 with SMTP id
 a9-20020a05622a02c900b00403a7074ce8mr20301538qtx.14.1689676992792; 
 Tue, 18 Jul 2023 03:43:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEfAc0RAW51Q57+5kHaOjBNY385azWVdgDwm1CpukcUR7H6/nuc2BdE+p3QBn6/yuEdIBWyqA==
X-Received: by 2002:a05:622a:2c9:b0:403:a707:4ce8 with SMTP id
 a9-20020a05622a02c900b00403a7074ce8mr20301525qtx.14.1689676992513; 
 Tue, 18 Jul 2023 03:43:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4?
 ([2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4])
 by smtp.gmail.com with ESMTPSA id
 ew13-20020a05622a514d00b00403b1fb1f48sm560643qtb.17.2023.07.18.03.43.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jul 2023 03:43:12 -0700 (PDT)
Message-ID: <beb86eee-b51e-2e6e-baee-2b562291aefd@redhat.com>
Date: Tue, 18 Jul 2023 12:43:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/nvme: fix endianness issue for shadow doorbells
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20230718103511.53767-2-its@irrelevant.dk>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230718103511.53767-2-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.097, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/18/23 12:35, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> In commit 2fda0726e514 ("hw/nvme: fix missing endian conversions for
> doorbell buffers"), we fixed shadow doorbells for big-endian guests
> running on little endian hosts. But I did not fix little-endian guests
> on big-endian hosts. Fix this.
> 
> Solves issue #1765.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1765

> Fixes: 3f7fe8de3d49 ("hw/nvme: Implement shadow doorbell buffer support")
> Cc: qemu-stable@nongnu.org
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Tested-by: Cédric Le Goater <clg@redhat.com>

with a PowerNV QEMU machine running on a s390x LPAR.

Thanks,

C.


> ---
>   hw/nvme/ctrl.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 8e8e870b9a80..dadc2dc7da10 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -6801,6 +6801,7 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
>       PCIDevice *pci = PCI_DEVICE(n);
>       uint64_t dbs_addr = le64_to_cpu(req->cmd.dptr.prp1);
>       uint64_t eis_addr = le64_to_cpu(req->cmd.dptr.prp2);
> +    uint32_t v;
>       int i;
>   
>       /* Address should be page aligned */
> @@ -6818,6 +6819,8 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
>           NvmeCQueue *cq = n->cq[i];
>   
>           if (sq) {
> +            v = cpu_to_le32(sq->tail);
> +
>               /*
>                * CAP.DSTRD is 0, so offset of ith sq db_addr is (i<<3)
>                * nvme_process_db() uses this hard-coded way to calculate
> @@ -6825,7 +6828,7 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
>                */
>               sq->db_addr = dbs_addr + (i << 3);
>               sq->ei_addr = eis_addr + (i << 3);
> -            pci_dma_write(pci, sq->db_addr, &sq->tail, sizeof(sq->tail));
> +            pci_dma_write(pci, sq->db_addr, &v, sizeof(sq->tail));
>   
>               if (n->params.ioeventfd && sq->sqid != 0) {
>                   if (!nvme_init_sq_ioeventfd(sq)) {
> @@ -6835,10 +6838,12 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
>           }
>   
>           if (cq) {
> +            v = cpu_to_le32(cq->head);
> +
>               /* CAP.DSTRD is 0, so offset of ith cq db_addr is (i<<3)+(1<<2) */
>               cq->db_addr = dbs_addr + (i << 3) + (1 << 2);
>               cq->ei_addr = eis_addr + (i << 3) + (1 << 2);
> -            pci_dma_write(pci, cq->db_addr, &cq->head, sizeof(cq->head));
> +            pci_dma_write(pci, cq->db_addr, &v, sizeof(cq->head));
>   
>               if (n->params.ioeventfd && cq->cqid != 0) {
>                   if (!nvme_init_cq_ioeventfd(cq)) {
> @@ -7587,7 +7592,7 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr addr, unsigned size)
>   static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>   {
>       PCIDevice *pci = PCI_DEVICE(n);
> -    uint32_t qid;
> +    uint32_t qid, v;
>   
>       if (unlikely(addr & ((1 << 2) - 1))) {
>           NVME_GUEST_ERR(pci_nvme_ub_db_wr_misaligned,
> @@ -7654,7 +7659,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>           start_sqs = nvme_cq_full(cq) ? 1 : 0;
>           cq->head = new_head;
>           if (!qid && n->dbbuf_enabled) {
> -            pci_dma_write(pci, cq->db_addr, &cq->head, sizeof(cq->head));
> +            v = cpu_to_le32(cq->head);
> +            pci_dma_write(pci, cq->db_addr, &v, sizeof(cq->head));
>           }
>           if (start_sqs) {
>               NvmeSQueue *sq;
> @@ -7714,6 +7720,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>   
>           sq->tail = new_tail;
>           if (!qid && n->dbbuf_enabled) {
> +            v = cpu_to_le32(sq->tail);
> +
>               /*
>                * The spec states "the host shall also update the controller's
>                * corresponding doorbell property to match the value of that entry
> @@ -7727,7 +7735,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>                * including ones that run on Linux, are not updating Admin Queues,
>                * so we can't trust reading it for an appropriate sq tail.
>                */
> -            pci_dma_write(pci, sq->db_addr, &sq->tail, sizeof(sq->tail));
> +            pci_dma_write(pci, sq->db_addr, &v, sizeof(sq->tail));
>           }
>   
>           qemu_bh_schedule(sq->bh);


