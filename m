Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B5A746E19
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 11:58:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGcnV-0003Xh-VR; Tue, 04 Jul 2023 05:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGcnR-0003U9-85
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:58:10 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGcnO-0004YX-Mf
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:58:08 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3143493728dso2575354f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 02:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688464685; x=1691056685;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3TZ+UvEYx6Ftl2BaoG8tclqhyIuRHrM19HM1yauUwaY=;
 b=T+JDO2Ry3WoscfbHNBS9RIp6MqwPb7/ziuZbZi8pJpSCUQY4tFJcOUd/508C7abCj5
 EVWT1R6tI3z7vMzQNrdihGfo9KCiBjNyiAGEUxLX5dqR9sXH+KmEcCFeQVEQaY8BbjSi
 e1vNzqiegOY6jIvF96KZ4rbw2PcpEClga8uSdzw8lsvWR1NBpaI1n0pKRr4iOwda3KHs
 yHt94CzCbnfz8N3jtObDB7s9yGqmhcjdCs2vjrltAwEZDsxPJkPsLUD9/zfYcZ9gHkoY
 wPFMVosWbWXCCCoCt3iFwqvm9Yy5lPd+wdpqjQEz9UUpbG0OHGPwc+HiV9sRRGqVxkxb
 J4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688464685; x=1691056685;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3TZ+UvEYx6Ftl2BaoG8tclqhyIuRHrM19HM1yauUwaY=;
 b=bCtRog0cmasQFUZQYfpHa9syNJsh8E0z809ofv33cqiBBn1nna00cITFeyTIl13yOp
 NfgT4sC/ldMWl9ItB4Hs91QCfsDlbr8nUuFGaqw89XBkKbxM+z07aVeBiIgmyv5eLCj6
 lT+6ViZvov4PbhuGTwMiV33x32OkPddhJZTqwzC91lZopedSEgtrCGd5WsF1SXEnBbWY
 +JU/YUB5Wmv6KQj/Q2ODeeRTjXsvtj8tkKGiWjKgpoTfyKJxpN11xk+LBjMnWcHru+M4
 Y+D4xbI6ka1yhkPk93AP338n3tk8IZWuUHxidLDErb01yhfwkNdE9z+YdhXY5C/z5cbC
 AI7g==
X-Gm-Message-State: ABy/qLYdEcn6ocZCNAXIFOJX2Z0IEOJEBsTx1c2YdnBmEKaLcMODh4Ww
 JtgkM1r+z567nXoqWHffeQ+5Yj6fyK4Jctc6pJI0Ng==
X-Google-Smtp-Source: APBJJlEqbXtHlO3V1VfA8ZzRB3LrjT9Z2qJdIxCE5MgBwWE1WfIIrwpCn9wxbv/UBjfxhu77WoJaxA==
X-Received: by 2002:a5d:58e9:0:b0:314:14be:1004 with SMTP id
 f9-20020a5d58e9000000b0031414be1004mr11250971wrd.63.1688464684970; 
 Tue, 04 Jul 2023 02:58:04 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a056000104800b003143ba62cf4sm2970420wrx.86.2023.07.04.02.57.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 02:58:04 -0700 (PDT)
Message-ID: <b16e90fd-f12b-a4ce-eec9-6c915ee69030@linaro.org>
Date: Tue, 4 Jul 2023 11:57:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 12/13] ppc440_pcix: Don't use iomem for regs
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1688421085.git.balaton@eik.bme.hu>
 <576b54159060392c8bc12a63c665928053b58f24.1688421085.git.balaton@eik.bme.hu>
 <01cd4046-1f7e-beb5-d999-84db6ae23d3e@linaro.org>
 <bc068e12-9a87-23fa-e39e-dd28a233a5b3@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <bc068e12-9a87-23fa-e39e-dd28a233a5b3@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 4/7/23 11:37, BALATON Zoltan wrote:
> On Tue, 4 Jul 2023, Philippe Mathieu-Daudé wrote:
>> On 4/7/23 00:02, BALATON Zoltan wrote:
>>> The iomem memory region is better used for the PCI IO space but
>>> currently used for registers. Stop using it for that to allow this to
>>> be cleaned up in the next patch.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>   hw/ppc/ppc440_pcix.c | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
>>> index adfecf1e76..ee2dc44f67 100644
>>> --- a/hw/ppc/ppc440_pcix.c
>>> +++ b/hw/ppc/ppc440_pcix.c
>>> @@ -484,6 +484,7 @@ static void ppc440_pcix_realize(DeviceState *dev, 
>>> Error **errp)
>>>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>>>       PPC440PCIXState *s;
>>>       PCIHostState *h;
>>> +    MemoryRegion *regs = g_new(MemoryRegion, 1);
>>
>> Why not hold it within PPC440PCIXState?
> 
> Because it's never needed after this function.

But we can't free() it because it has to stay valid as long as
PPC440PCIXState is in use. So it seems to belong there.

> 
> Regards,
> BALATON Zoltan
> 
>>>       h = PCI_HOST_BRIDGE(dev);
>>>       s = PPC440_PCIX_HOST(dev);
>>> @@ -507,11 +508,11 @@ static void ppc440_pcix_realize(DeviceState 
>>> *dev, Error **errp)
>>>                             h, "pci-conf-idx", 4);
>>>       memory_region_init_io(&h->data_mem, OBJECT(s), 
>>> &pci_host_data_le_ops,
>>>                             h, "pci-conf-data", 4);
>>> -    memory_region_init_io(&s->iomem, OBJECT(s), &pci_reg_ops, s,
>>> -                          "pci.reg", PPC440_REG_SIZE);
>>> +    memory_region_init_io(regs, OBJECT(s), &pci_reg_ops, s, "pci-reg",
>>> +                          PPC440_REG_SIZE);
>>>       memory_region_add_subregion(&s->container, PCIC0_CFGADDR, 
>>> &h->conf_mem);
>>>       memory_region_add_subregion(&s->container, PCIC0_CFGDATA, 
>>> &h->data_mem);
>>> -    memory_region_add_subregion(&s->container, PPC440_REG_BASE, 
>>> &s->iomem);
>>> +    memory_region_add_subregion(&s->container, PPC440_REG_BASE, regs);
>>>       sysbus_init_mmio(sbd, &s->container);
>>>   }
>>>
>>
>>
>>


