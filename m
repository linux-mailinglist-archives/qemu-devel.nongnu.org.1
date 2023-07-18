Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 195DC757B5C
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 14:07:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLjSn-00077R-LB; Tue, 18 Jul 2023 08:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLjSR-00073T-BX
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 08:05:36 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLjSP-0001dc-Md
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 08:05:35 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fbb281eec6so8951136e87.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 05:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689681932; x=1692273932;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6EaR0kpRJKScviy29Nsg+Af0LrXnX8r2QnaKIYRUCn4=;
 b=PH0NBYFfV/3ESJy/QFnsn6raqBE98fxqwe35toBcXllm0Lh4wJOzomNsD8xXsY9/s1
 Te6+OE55FruHT0lQ50GmSxO3NyoXZZ8wTrD/Xo70ldyyPkoNWBd4bl8ggHgDAnve88GG
 KP551YIGf9y51+WOCmT5fMFHgs28Xj/VohThWFCtWFUH+WaHo8PeJNwsQOJpzWZoDKGb
 Yfb8UjenFgiIV2AUdYKc9+lNT/DvoIOsq1KwaPs2F4BwgNSOv6SMhZYR5lZwCaHhJq5J
 gp7VXPDqUv+msHbVM+/aWTDr5paqvC9Fd+K9HzXaio0KXkGaSxF2g5cFv+o9e59jBwq8
 HwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689681932; x=1692273932;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6EaR0kpRJKScviy29Nsg+Af0LrXnX8r2QnaKIYRUCn4=;
 b=P4u3iYl3N26re6I6BmyFXP8QYORVl/6+aaxZszJudPD4MHXT9Dgv/fFikNJ1/jG9hM
 q788L8kY1LPxmhLL0XPiD0XKShhKLhgHAP5gTiczBELc6Qxq7cAwTE2rWDJtMYaxEO0n
 rt5bCEs40K50JRvGL+DhwR6uz1iTXNFwDl0tlO0AvdTeGnbHW8Bo786W5qqiY4dC+un/
 +ToFTuN6pUUCqXI5kx9Aptse95YIStefS1smfeN3AOFMfmSeVLHuEpgsq+3MKCOKg69a
 A2PolF79j55y0yghzFzNZW/kYIrySUwBSYcHXmvNCS6VNvj57dB5qcs3z0yspH6i4wfZ
 +xuA==
X-Gm-Message-State: ABy/qLbl7j741vQn8V+kQgy1ELWezytjEwqFg6DUHwmzvdXkN932MP6D
 6i4uqUj6VsoZ2pB+HdNK8/yAvQ==
X-Google-Smtp-Source: APBJJlGHLUKhXftwDkNmvC51RXfil8YhiZJEbnauro5Bb9MY88645wXDzmCrrn+UE8ujHUgI/OlrBw==
X-Received: by 2002:a05:6512:2384:b0:4f8:7781:9870 with SMTP id
 c4-20020a056512238400b004f877819870mr12508307lfv.60.1689681931903; 
 Tue, 18 Jul 2023 05:05:31 -0700 (PDT)
Received: from [192.168.94.175] (140.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.140]) by smtp.gmail.com with ESMTPSA id
 fo7-20020a05600c690700b003fc3b03e630sm9652312wmb.0.2023.07.18.05.05.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jul 2023 05:05:31 -0700 (PDT)
Message-ID: <0b316a42-5ef2-47a7-24f6-02d59965144c@linaro.org>
Date: Tue, 18 Jul 2023 14:05:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/nvme: fix endianness issue for shadow doorbells
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>
References: <20230718103511.53767-2-its@irrelevant.dk>
 <376e5e45-a3e7-0029-603a-b7ad9673fac4@linaro.org>
 <ZLZ4yhYyfNzHqoDn@cormorant.local>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZLZ4yhYyfNzHqoDn@cormorant.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

On 18/7/23 13:34, Klaus Jensen wrote:
> On Jul 18 13:18, Philippe Mathieu-Daudé wrote:
>> On 18/7/23 12:35, Klaus Jensen wrote:
>>> From: Klaus Jensen <k.jensen@samsung.com>
>>>
>>> In commit 2fda0726e514 ("hw/nvme: fix missing endian conversions for
>>> doorbell buffers"), we fixed shadow doorbells for big-endian guests
>>> running on little endian hosts. But I did not fix little-endian guests
>>> on big-endian hosts. Fix this.
>>>
>>> Solves issue #1765.
>>>
>>> Fixes: 3f7fe8de3d49 ("hw/nvme: Implement shadow doorbell buffer support")
>>> Cc: qemu-stable@nongnu.org
>>> Reported-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>>> ---
>>>    hw/nvme/ctrl.c | 18 +++++++++++++-----
>>>    1 file changed, 13 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
>>> index 8e8e870b9a80..dadc2dc7da10 100644
>>> --- a/hw/nvme/ctrl.c
>>> +++ b/hw/nvme/ctrl.c
>>> @@ -6801,6 +6801,7 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
>>>        PCIDevice *pci = PCI_DEVICE(n);
>>>        uint64_t dbs_addr = le64_to_cpu(req->cmd.dptr.prp1);
>>>        uint64_t eis_addr = le64_to_cpu(req->cmd.dptr.prp2);
>>> +    uint32_t v;
>>>        int i;
>>>        /* Address should be page aligned */
>>> @@ -6818,6 +6819,8 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
>>>            NvmeCQueue *cq = n->cq[i];
>>>            if (sq) {
>>> +            v = cpu_to_le32(sq->tail);
>>> +
>>>                /*
>>>                 * CAP.DSTRD is 0, so offset of ith sq db_addr is (i<<3)
>>>                 * nvme_process_db() uses this hard-coded way to calculate
>>> @@ -6825,7 +6828,7 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
>>>                 */
>>>                sq->db_addr = dbs_addr + (i << 3);
>>>                sq->ei_addr = eis_addr + (i << 3);
>>> -            pci_dma_write(pci, sq->db_addr, &sq->tail, sizeof(sq->tail));
>>> +            pci_dma_write(pci, sq->db_addr, &v, sizeof(sq->tail));
>>
>> Or use the PCI DMA ldst API which does the swapping for you:
>>
>>    stl_le_pci_dma(pci, sq->db_addr, sq->tail, MEMTXATTRS_UNSPECIFIED);
>>
> 
> Nice! That's definitely preferable. I'll queue that up for next, but
> leave this patch as-is since it's been tested on a real big-endian host
> and gotten its tags ;)

OK, then:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


