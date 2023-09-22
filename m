Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7507AAF82
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 12:30:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjdPZ-0005h2-QF; Fri, 22 Sep 2023 06:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjdPX-0005gD-BA
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:29:23 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjdPV-0007yo-CK
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:29:23 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5033918c09eso3170826e87.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 03:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695378559; x=1695983359; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dtqr/bwW/e0727PreleJLDQ/WfEhK5yG5v4iGEkskj8=;
 b=lNVIOLm1ziqaZ+aZhPszE68qEjXVNF4wbXn+fPI8gbKa9c4mh/A1eXx+B3U1FY1HVz
 onGFk8P2m7ZV+n+MwHuFxl1Ur1/JZ1PwlmMuIEfZ3VLgR4aAcvpDtU+iCIRT6vLPyaTy
 53Ic/4iVosgHDTwbM+Z5PzFIcflmdzekT/fFdPadtOm4ONVmgf5AeHIB3JZFizOz/vZl
 bqwrFzQkyuQqRB6R8EXZ/tp7KybTingJa5DpMZbwr5oigOAh0ZiZlof+ggIE3PRu6nkW
 YK7lNGYah7pe7iyiif9nTRquPNFjhPXT+SlPquRISj42syYjI0hvMSaotKw/P7d23Bo0
 +SDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695378559; x=1695983359;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dtqr/bwW/e0727PreleJLDQ/WfEhK5yG5v4iGEkskj8=;
 b=Cf4xDrSUXDvvk7r+b39cUFiqaRexl73+dkg8cWwC7eywNVdlt3FDDvV8sALZkiaC3a
 /eJQ1IJbb5GjgdguuMZd9cmfi1FCltzQ5nFW8ZzGnv5ETxTgytFIQdkldA+nmtAbNacM
 anS1LNzvHK66AL1xUCS3/qRqPM3Pl/A3VbGwqScRw0sJe6bazbliil2GHcuevJlvOeqK
 JjLNNGe0TuxfcDdex0ZiJQsTVzUCwURJvsLrCFo+O8CRAryNB3Q13iT7i1ozI84bcnbR
 uLzcedJZaecQ2eWmRRalZsgfeuHAMtMwg3Ilzbfq1UICpuLi9aKi5pgWM0JTTSir1qmK
 2rZg==
X-Gm-Message-State: AOJu0YzONd4KkyCLG6muwk6XiVSs7gVcAesSph2PFLg+WprwUWOvXyZc
 pzo5LcKO8ELNzi0LaWsh0ENA7w==
X-Google-Smtp-Source: AGHT+IGX58hs8A+zQFvjpIM5qp2bh5Rp0UOjPxZKNiyGvrfvj/4gEZyQdq2cXmtpPQWHbziL4NCsMw==
X-Received: by 2002:a05:6512:2312:b0:504:3c1f:cbda with SMTP id
 o18-20020a056512231200b005043c1fcbdamr1143063lfu.1.1695378559213; 
 Fri, 22 Sep 2023 03:29:19 -0700 (PDT)
Received: from [192.168.144.175] ([93.23.15.147])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a5d49c7000000b003176aa612b1sm4068903wrs.38.2023.09.22.03.29.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 03:29:18 -0700 (PDT)
Message-ID: <d1d3f256-ec18-80fb-aef9-a3d558057733@linaro.org>
Date: Fri, 22 Sep 2023 12:29:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] hw/sd/sdhci: Block Size Register bits [14:12] is lost
Content-Language: en-US
To: "Gao, Lu" <Lu.Gao@verisilicon.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Wen, Jianxian" <Jianxian.Wen@verisilicon.com>,
 Bin Meng <bin.meng@windriver.com>,
 "open list:SD (Secure Card)" <qemu-block@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>, Prasad J Pandit <pjp@fedoraproject.org>
References: <20220321055618.4026-1-lu.gao@verisilicon.com>
 <f15d8c9a-2a6f-1126-785f-0176eb78c3ec@amsat.org>
 <34781C803212B140A51E6B66D9092E5D01FA5C9937@SHASXM03.verisilicon.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <34781C803212B140A51E6B66D9092E5D01FA5C9937@SHASXM03.verisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/12/22 09:54, Gao, Lu wrote:
> Hello,
> 
> Just want to check whether we can have it merged? Any other comments?

Oops sorry, I see I had this patch tagged for a merge request
but I lost track of it (likely when switching emails).

Patch queued!

> 
> Thanks a lot!
> B.R.
> 
> -----Original Message-----
> From: Philippe Mathieu-Daudé [mailto:philippe.mathieu.daude@gmail.com] On Behalf Of Philippe Mathieu-Daudé
> Sent: Tuesday, May 31, 2022 6:09 PM
> To: Gao, Lu; qemu-devel@nongnu.org
> Cc: Wen, Jianxian; Bin Meng; open list:SD (Secure Card); Alexander Bulekov; Prasad J Pandit
> Subject: Re: [PATCH] hw/sd/sdhci: Block Size Register bits [14:12] is lost
> 
> On 21/3/22 06:56, Lu Gao wrote:
>> Block Size Register bits [14:12] is SDMA Buffer Boundary, it is missed
>> in register write, but it is needed in SDMA transfer. e.g. it will be
>> used in sdhci_sdma_transfer_multi_blocks to calculate boundary_ variables.
>>
>> Missing this field will cause wrong operation for different SDMA Buffer
>> Boundary settings.
> 
> Fixes: d7dfca0807 ("hw/sdhci: introduce standard SD host controller")
> Fixes: dfba99f17f ("hw/sdhci: Fix DMA Transfer Block Size field")
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
>> Signed-off-by: Lu Gao <lu.gao@verisilicon.com>
>> Signed-off-by: Jianxian Wen <jianxian.wen@verisilicon.com>
>> ---
>>    hw/sd/sdhci.c | 15 +++++++++++----
>>    1 file changed, 11 insertions(+), 4 deletions(-)


