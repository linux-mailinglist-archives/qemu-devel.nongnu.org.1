Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A8D7154DC
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 07:19:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3rkj-0003lI-68; Tue, 30 May 2023 01:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q3rkg-0003kt-Dv
 for qemu-devel@nongnu.org; Tue, 30 May 2023 01:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q3rkQ-0000sa-PB
 for qemu-devel@nongnu.org; Tue, 30 May 2023 01:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685423897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u/99Wl6t+Q9nAshtBRmGb4v26jXbFJPr3F1yojolH3A=;
 b=KojIu47nO6/Nsy/dyx5667DwVm6ERfLwwUUkshTKtEWnY006I3sWIhv3v+/kdCjPYDwa3K
 bOS1l8R2TR7DZaYY/brXJmI0mEXOGVMw2nXcwNyU+dECL5gUn1PWcw7byC5ENzlRDcp9uD
 0hpbP0L6LN7QiFEAucncKtlyej4+E0Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-ON32nkopN2C9o2MpyTHhBw-1; Tue, 30 May 2023 01:18:15 -0400
X-MC-Unique: ON32nkopN2C9o2MpyTHhBw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f60f085cd2so14502105e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 22:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685423894; x=1688015894;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u/99Wl6t+Q9nAshtBRmGb4v26jXbFJPr3F1yojolH3A=;
 b=Lt33obkdqUUtBOf3OiXITUN9rHbNj/s8H99jBeGjWg0bR5F/MD9j7neTrVzXCTSIpW
 pLlaZtZ0L6NRM5klMYxwLd2U+XCEZc3rVKVhDmLMHGd3XxB5PBIns5aSAieTSvNrnAMG
 FxpACyZ6TtrsbxwNLJr+DAZ+o+mOJzIfFyd1Mc8TE6k28tyusTEwSaJm+uSmA6HDrVQy
 Uh/sbkZ/BIWmS1PyVoVM1vSK3UGcN4ve4SPgJdrYFbzBfiXkZRrLIvi0ezyBEq25XGzA
 q4c8BphYhbDoYhF/tSCPjgmbSXoWy4VTXlnZTDNLr7baig/YiZxOh+vntFfIiyVS5Rsm
 irfQ==
X-Gm-Message-State: AC+VfDyS5DFpxbgOr5srXEhxuZEsSRWnAE1vMx3GkefiZQ81AOlx+A3V
 iuS7G2PM/kK8zrWjZxKLCdHU07sbUTIEqPabOWsdfyb6UI90hXKgd7qY7PlQOzoaIQS4l+r7fst
 aQfTOcIf/yniVT6k=
X-Received: by 2002:a1c:7303:0:b0:3f4:24c8:f7c6 with SMTP id
 d3-20020a1c7303000000b003f424c8f7c6mr620670wmb.16.1685423894093; 
 Mon, 29 May 2023 22:18:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7e3esTGZeLGgMxIhm00coRH/XErxpfGkSD2deaOJqJPuy/NP/zb3qHiQIhvuwq9Vx7wAGUWw==
X-Received: by 2002:a1c:7303:0:b0:3f4:24c8:f7c6 with SMTP id
 d3-20020a1c7303000000b003f424c8f7c6mr620659wmb.16.1685423893804; 
 Mon, 29 May 2023 22:18:13 -0700 (PDT)
Received: from [192.168.8.105] (tmo-065-8.customers.d1-online.com.
 [80.187.65.8]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5d4152000000b0030aeb3731d0sm1868022wrq.98.2023.05.29.22.18.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 May 2023 22:18:13 -0700 (PDT)
Message-ID: <b17dd72f-1176-ad01-eae5-9c502826d0d4@redhat.com>
Date: Tue, 30 May 2023 07:18:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] hw/ppc/mac_newworld: Check for the availability of
 pci-ohci before using it
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230526125323.2386324-1-thuth@redhat.com>
 <e2854ac5-e786-fcdf-453a-5a4fd343e871@eik.bme.hu>
 <a36c6acc-6b27-884a-cf2a-521435feed40@ilande.co.uk>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <a36c6acc-6b27-884a-cf2a-521435feed40@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 26/05/2023 19.24, Mark Cave-Ayland wrote:
> On 26/05/2023 14:30, BALATON Zoltan wrote:
> 
>> On Fri, 26 May 2023, Thomas Huth wrote:
>>> pci-ohci might habe been disabled in the QEMU binary (e.g. when "configure"
>>> has been run with "--without-default-devices"). Thus we should check
>>> for its availability before blindly using it.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>> hw/ppc/mac_newworld.c | 3 ++-
>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
>>> index 535710314a..c7cca430e1 100644
>>> --- a/hw/ppc/mac_newworld.c
>>> +++ b/hw/ppc/mac_newworld.c
>>> @@ -349,7 +349,8 @@ static void ppc_core99_init(MachineState *machine)
>>>                                     sysbus_mmio_get_region(s, 3));
>>>     }
>>>
>>> -    machine->usb |= defaults_enabled() && !machine->usb_disabled;
>>> +    machine->usb |= defaults_enabled() && !machine->usb_disabled &&
>>> +                    module_object_class_by_name("pci-ohci") != 0;
>>
>> Considering that PowerMacs have an OHCI controller built in soldered to 
>> the motherboard should this depend on it instead and not rely on pulling 
>> it in with PCI_DEVICES and --without-default-devices disabling it?
>>
>> Currently it's not quite emulating a real Mac but I think we should aim 
>> for going that way rather than to keep emulating random Mac hardware.
> 
> Indeed that's correct: New World Macs should always have USB ports built-in. 
> I guess the problem here is that this isn't being indicated correctly via 
> Kconfig and/or the machine->usb_disabled logic?

Yes, the other solution to the problem is to add a proper "select" statement 
to the Kconfig file. I can also send a patch for that instead.

The other question is whether the OHCI device should always be instantiated, 
even if QEMU had been started with "--nodefaults"? ... otherwise you could 
not hot-plug USB devices to this machine during runtime...

  Thomas


