Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AC6737BFF
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 09:25:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBsCe-0007PP-GF; Wed, 21 Jun 2023 03:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qBsCX-0007Lp-RO
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:24:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qBsCW-0005JR-2x
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687332261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xw5oVW0ioyxua/KLQz7cxNYsMkJmpVvqA39iPvp9m+E=;
 b=gege5FNoMzshCuaGkeNH0pqObrokyv6oLuekA2nH+wNyut+BvCyDq/8Rx4dEvRciqE1a29
 b9TgqSlwiCf11DZQU/Zc9NpeeurndBie17dFHB203KxpTwO7bYqPqreFTzK167MPNQRg39
 DCrUXnAeXAFzf5CdEBAc9vunFNwIOao=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-0ntag1jDMb-rdEUqTdzPIQ-1; Wed, 21 Jun 2023 03:24:19 -0400
X-MC-Unique: 0ntag1jDMb-rdEUqTdzPIQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f90ab2de48so71647205e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 00:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687332258; x=1689924258;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xw5oVW0ioyxua/KLQz7cxNYsMkJmpVvqA39iPvp9m+E=;
 b=Q3ybjV02kV3pqq8ohsMft755PZqnW4TVOuZVDAFQUmf9NTYEyLqVSDyzJoTV/CtpTZ
 9YMieB9fcjEPcHEWrayvwQmY0JCJgDlU3O6qdMbz2tZUdSU5PDjTQ1VUMbUNXAoJD+Wj
 XEU5sP6CZmWefdM1c9svn4/OboAARGMPwB2KBKgxaDKbmi7d/2HcM2YvvoLhJpJxEazi
 ZLWc8C4YkWGxw9o01mY+jJz1/8bxM3cmAKzz5mYutLDsR7qBeNxOej28n/rRgJVMXD8/
 AH33u2Bkskk/4PndzUsrUoYXfdoHntDi4c+N95nfmGPMokI3FoYGoPEx0O+ERRUTjFfN
 XC3A==
X-Gm-Message-State: AC+VfDykT+LEj32pgjGwysU5cz+ZNkiwbZTrb8O2h2LdtsvT3Sk9tFtq
 e+rxyOl8CQXwrA4nd9j9ov9VXUTKuD6bZIeBYXb6HpAzXW6ppzBtUNefu/1WJ983QcMuBk94U1o
 Hz31t2UyOwPiVCkQ=
X-Received: by 2002:a05:600c:218d:b0:3f9:b8d0:1bfd with SMTP id
 e13-20020a05600c218d00b003f9b8d01bfdmr4257145wme.4.1687332258526; 
 Wed, 21 Jun 2023 00:24:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5WDbputscjvt79vGTPlMEwO+vGpk29NAtDsI2Z3qA5wtg0M9SnVKWIqaOPgvWDQxhT+gimJg==
X-Received: by 2002:a05:600c:218d:b0:3f9:b8d0:1bfd with SMTP id
 e13-20020a05600c218d00b003f9b8d01bfdmr4257132wme.4.1687332258221; 
 Wed, 21 Jun 2023 00:24:18 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a1cf70f000000b003f8d770e935sm15467560wmh.0.2023.06.21.00.24.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 00:24:17 -0700 (PDT)
Message-ID: <5e440af9-e0c6-ed13-c17a-ae069939ed67@redhat.com>
Date: Wed, 21 Jun 2023 09:24:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hw/mips: Improve the default USB settings in the
 loongson3-virt machine
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20230525064731.1854107-1-thuth@redhat.com>
 <5795da20-a2f6-e606-27bd-a23fc72346fc@redhat.com>
 <10ef6b88-0770-65bb-b6dd-217a5f731d14@tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <10ef6b88-0770-65bb-b6dd-217a5f731d14@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 08/06/2023 20.31, Michael Tokarev wrote:
> 07.06.2023 13:26, Thomas Huth wrote:
>> On 25/05/2023 08.47, Thomas Huth wrote:
>>> It's possible to compile QEMU without the USB devices (e.g. when using
>>> "--without-default-devices" as option for the "configure" script).
>>> To be still able to run the loongson3-virt machine in default mode with
>>> such a QEMU binary, we have to check here for the availability of the
>>> devices first before instantiating them.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   The alternative would be to use a "#ifdef CONFIG_USB_OHCI_PCI" etc.
>>>   ... not sure what is nicer ... what do you think?
>>>
>>>   hw/mips/loongson3_virt.c | 10 +++++++---
>>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
>>> index 216812f660..a0afb17030 100644
>>> --- a/hw/mips/loongson3_virt.c
>>> +++ b/hw/mips/loongson3_virt.c
>>> @@ -447,10 +447,14 @@ static inline void 
>>> loongson3_virt_devices_init(MachineState *machine,
>>>       pci_vga_init(pci_bus);
>>> -    if (defaults_enabled()) {
>>> +    if (defaults_enabled() && module_object_class_by_name("pci-ohci")) {
>>>           pci_create_simple(pci_bus, -1, "pci-ohci");
>>> -        usb_create_simple(usb_bus_find(-1), "usb-kbd");
>>> -        usb_create_simple(usb_bus_find(-1), "usb-tablet");
>>> +        if (module_object_class_by_name("usb-kbd")) {
>>> +            usb_create_simple(usb_bus_find(-1), "usb-kbd");
>>> +        }
>>> +        if (module_object_class_by_name("usb-tablet")) {
>>> +            usb_create_simple(usb_bus_find(-1), "usb-tablet");
>>> +        }
> 
> It looks like kbd/tablet don't need to have an if around, because
> hw/usb/usb-hid.c is always compiled when CONFIG_USB is enabled,
> and enabling CONFIG_USB_OHCI automatically selects CONFIG_USB.

Oh, right! So this can be simplified, indeed.

> I guess this whole code can be guarded by #if CONFIG_USB_OHCI..#endif,
> instead of using runtime checking of device availability.

Yes, that's the alternative ... I'll respin the patch with that to see how 
it looks like.

> Notes:
> 
> Other places don't check if ohci or other usb controllers are available.

Those likely use "select" instead of "imply" in their Kconfig, so the OHCI 
controller is always included.

> We have TYPE_PCI_OHCI #define which isn't used in places where pci-ohci
> is requested, - probably need to move it to a common header (it is
> defined in hw/usb/hcd-ohci-pci.c now).

Yes, sounds like a cleanup that could be done in an additional patch.

> roms/config.seabios-128k turns USB_OHCI off.

That's the config of the seabios ROM - not (directly) related to the config 
of the QEMU binaries.

  Thomas


