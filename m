Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22738757A4F
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 13:20:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLijM-0007mQ-Ga; Tue, 18 Jul 2023 07:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLijH-0007lP-Il
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 07:18:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLijE-0005b9-BA
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 07:18:55 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbea147034so51740435e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 04:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689679130; x=1692271130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ixa5pKk1DIBcQi6glIw4iPlbI6H7hcpj0mg95KZPglc=;
 b=OIg5C7JFstK3hn26lZFYQ67rWEesZfmIrABO0FVBNw+MsETTKKPaqsiJSIj9zSFCdl
 tM9iyo/tZfWbtkaUiAcegPDwxfC5fox/Rpv/r4gC10hkV8Fj6eihZfXVDmo/PxTi6/r9
 gP2a7Ffled8RMmylRNZndhaTutYqTvSGPbUIVqtcRJKI/CbTv8FMlyFfbz/9Syv3MEh6
 iIsnLXSed1voqWcb2Kdx+UZ28oDR0iED8uYo/11AdaeoRv6dAjSL4z0EA4dNdctig9a+
 P77Mhf0REFJrkcnTUGTCDnAKsphaaJalNDII4+irEwcZBe/J8ALzFzMe6crJB1Zqs6Gt
 dT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689679130; x=1692271130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ixa5pKk1DIBcQi6glIw4iPlbI6H7hcpj0mg95KZPglc=;
 b=BHIrjL4N8WgX5Afx9liFL6F5ln+dohqMJLzI9jLFOVZEuVkQhVsPy9KbMahipQGuJv
 gnIozc7jYr1kq2iZB621BlFOgA0lSJ+bZ/4AsI5eIDHC+RbkV3/xU/gYK2I/oVB2y9yt
 EcOViul9PKwAHfs7ep11vhZv/chgev9/6foWaYSsbtx9BVQObO01CzX0k4PdiybBDQzE
 xNQ2sJKsq8wvSNN4MBwIb8J2mWSNzUGiJ/UaVaTOys5VN+nX8icN3OBN7QzGvZTkVBwG
 YK/yVEaDgnU6+v7iChG8MPoij4vekaNM/a62zonPxz3m0e5Q8caG6uvNkYMWK6+khHq4
 r99w==
X-Gm-Message-State: ABy/qLaxykj9W3mveDWzWsOLkK/ctd9JrHEL3M7NqzY0WpNUAbYQHk/S
 YO8mz9zrlUF5eJAftPvFA0qD8g==
X-Google-Smtp-Source: APBJJlGnR5EPrfOkL9nLvw8k3Hedb8g7sIjxeYQreYPVqDxTxGCe4KDZRqbDrcRrxuPsR2jkhLwQyQ==
X-Received: by 2002:a1c:7204:0:b0:3f9:b7cc:723 with SMTP id
 n4-20020a1c7204000000b003f9b7cc0723mr1591311wmc.21.1689679130078; 
 Tue, 18 Jul 2023 04:18:50 -0700 (PDT)
Received: from [192.168.94.175] (140.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.140]) by smtp.gmail.com with ESMTPSA id
 m13-20020a7bce0d000000b003fbaa2903f4sm1894775wmc.19.2023.07.18.04.18.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jul 2023 04:18:49 -0700 (PDT)
Message-ID: <376e5e45-a3e7-0029-603a-b7ad9673fac4@linaro.org>
Date: Tue, 18 Jul 2023 13:18:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/nvme: fix endianness issue for shadow doorbells
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20230718103511.53767-2-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230718103511.53767-2-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 18/7/23 12:35, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> In commit 2fda0726e514 ("hw/nvme: fix missing endian conversions for
> doorbell buffers"), we fixed shadow doorbells for big-endian guests
> running on little endian hosts. But I did not fix little-endian guests
> on big-endian hosts. Fix this.
> 
> Solves issue #1765.
> 
> Fixes: 3f7fe8de3d49 ("hw/nvme: Implement shadow doorbell buffer support")
> Cc: qemu-stable@nongnu.org
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
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

Or use the PCI DMA ldst API which does the swapping for you:

   stl_le_pci_dma(pci, sq->db_addr, sq->tail, MEMTXATTRS_UNSPECIFIED);

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

   stl_le_pci_dma(pci, cq->db_addr, cq->head, MEMTXATTRS_UNSPECIFIED);

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

   stl_le_pci_dma(pci, cq->db_addr, cq->head, MEMTXATTRS_UNSPECIFIED);

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

   stl_le_pci_dma(pci, sq->db_addr, sq->tail, MEMTXATTRS_UNSPECIFIED);

>           }
>   
>           qemu_bh_schedule(sq->bh);


