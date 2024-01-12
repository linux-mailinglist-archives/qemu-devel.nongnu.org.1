Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD0B82BAAC
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 06:10:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO9nD-0002at-4U; Fri, 12 Jan 2024 00:09:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rO9nB-0002aj-Dc
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 00:09:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rO9n9-00066t-EY
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 00:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705036153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=y/5b7z4Y2j9rR2SbW3Dac+udHhxw/BOKOHrkRRjI+tY=;
 b=Bttfj7OkdWt9dJ0Xcrda5DxhPVel3YjR+Lz9EcMVT9FXR5UozX+/ITGvXAb8sh9PHyGf1R
 RxlBNvh7aZsRiYKbfyTXjiJ0re7srP5V5nDJNNPSgROcfhGSy0oqA1DyhxpRr2yE2c1HDf
 MNlmw6UH8UfK6oMrHvbhyprCAeRjSgA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-px5cgRmJMfSMKGX5cBfvYg-1; Fri, 12 Jan 2024 00:09:10 -0500
X-MC-Unique: px5cgRmJMfSMKGX5cBfvYg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5582c0179b5so1953615a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 21:09:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705036149; x=1705640949;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y/5b7z4Y2j9rR2SbW3Dac+udHhxw/BOKOHrkRRjI+tY=;
 b=nUCVz2jP9Ep+AoYhCZkH2XdtF1DFbMFQqNY1ekXgj9bLIWFkP/l1Jvt6eBWFG5f+9G
 v/B+3C4hGdfzHISnbC8U9/dpV+Lsfi0J/90YJ11Q/n8h5V5T29ZcIrPX9YhoEWl2Zw87
 kOVkC7o+xNlfRR487C8fOY5+/7yMJgbEkiMHG0x5buIP9zYVjwKXYS5cg5OTLdM1H1Tu
 YljwWgXmuTkpHHxFXGKFBdQzTSSJAmfCHzwfPsvzIMTFw0iSveWvoa8NbHga+XFTAbmf
 1aOomYMtEPn6A6wRmObaCivuulpxPl+kfMtHuAZbVkiepiggOLcSgWpoc0Jdxe2O8Ess
 IggQ==
X-Gm-Message-State: AOJu0Yyo3WmJdUXqQYSBh9FNe9pknP1Uf87ej0GEQ2k720HHBSikd9h5
 NIg7Kg0P64Yj9Uo415rKGGfRF1JdFZhCTAur8IN+hJQmHdYWVHNmWNCh9FBtGZSyj52qDIQ/3ui
 VoLlhhuFAinAwovbIlQxZBwc=
X-Received: by 2002:aa7:d50e:0:b0:554:5ed8:3072 with SMTP id
 y14-20020aa7d50e000000b005545ed83072mr316047edq.55.1705036149146; 
 Thu, 11 Jan 2024 21:09:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENN8JKPeibGkvOtandKK2i45t6JHXdvMc2iM6w82FO+NzOOEd7jkks2cgSAB72rUceSu70qQ==
X-Received: by 2002:aa7:d50e:0:b0:554:5ed8:3072 with SMTP id
 y14-20020aa7d50e000000b005545ed83072mr316038edq.55.1705036148813; 
 Thu, 11 Jan 2024 21:09:08 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-232.web.vodafone.de.
 [109.43.176.232]) by smtp.gmail.com with ESMTPSA id
 q11-20020aa7d44b000000b00555fd008741sm1356200edr.95.2024.01.11.21.09.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 21:09:08 -0800 (PST)
Message-ID: <9496438f-a12b-4eca-8b2d-c8c6bbc52e69@redhat.com>
Date: Fri, 12 Jan 2024 06:09:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] hw/hppa/machine: Disable default devices with
 --nodefaults option
To: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>, deller@kernel.org,
 qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>
References: <20240107132237.50553-1-deller@kernel.org>
 <20240107132237.50553-3-deller@kernel.org>
 <3cc1664c-9f5c-4d2f-b8f3-f8880c110e10@linaro.org>
 <1fde7d36-420a-4df5-821e-bcd4819ac6b7@gmx.de>
 <5c6768a6-a487-4a82-a4e1-374dff074610@linaro.org>
 <9942e915-3eef-4e3f-bd2c-7719082e7eee@gmx.de>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <9942e915-3eef-4e3f-bd2c-7719082e7eee@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/01/2024 23.28, Helge Deller wrote:
> On 1/9/24 17:01, Richard Henderson wrote:
>> On 1/9/24 22:16, Helge Deller wrote:
>>> On 1/9/24 10:57, Richard Henderson wrote:
>>>> On 1/8/24 00:22, deller@kernel.org wrote:
>>>>> From: Helge Deller <deller@gmx.de>
>>>>>
>>>>> Add support for the qemu --nodefaults option, which will disable the
>>>>> following default devices:
>>>>> - lsi53c895a SCSI controller,
>>>>> - artist graphics card,
>>>>> - LASI 82596 NIC,
>>>>> - tulip PCI NIC,
>>>>> - second serial PCI card,
>>>>> - USB OHCI controller.
>>>>>
>>>>> Adding this option is very useful to allow manual testing and
>>>>> debugging of the other possible devices on the command line.
>>>>>
>>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>>> ---
>>>>>   hw/hppa/machine.c | 15 +++++++++------
>>>>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>>>> index b11907617e..8017002a2a 100644
>>>>> --- a/hw/hppa/machine.c
>>>>> +++ b/hw/hppa/machine.c
>>>>> @@ -346,11 +346,14 @@ static void 
>>>>> machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>>>>>       SysBusDevice *s;
>>>>>       /* SCSI disk setup. */
>>>>> -    dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
>>>>> -    lsi53c8xx_handle_legacy_cmdline(dev);
>>>>> +    if (defaults_enabled()) {
>>>>> +        dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
>>>>> +        lsi53c8xx_handle_legacy_cmdline(dev);
>>>>> +    }
>>>>>       /* Graphics setup. */
>>>>> -    if (machine->enable_graphics && vga_interface_type != VGA_NONE) {
>>>>> +    if (defaults_enabled() && machine->enable_graphics &&
>>>>> +        vga_interface_type != VGA_NONE) {
>>>>>           vga_interface_created = true;
>>>>>           dev = qdev_new("artist");
>>>>>           s = SYS_BUS_DEVICE(dev);
>>>>> @@ -360,7 +363,7 @@ static void 
>>>>> machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>>>>>       }
>>>>>       /* Network setup. */
>>>>> -    if (enable_lasi_lan()) {
>>>>> +    if (defaults_enabled() && enable_lasi_lan()) {
>>>>>           lasi_82596_init(addr_space, translate(NULL, LASI_LAN_HPA),
>>>>>                           qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA));
>>>>>       }
>>>>> @@ -385,7 +388,7 @@ static void 
>>>>> machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>>>>>       pci_set_word(&pci_dev->config[PCI_SUBSYSTEM_ID], 0x1227); /* 
>>>>> Powerbar */
>>>>>       /* create a second serial PCI card when running Astro */
>>>>> -    if (!lasi_dev) {
>>>>> +    if (defaults_enabled() && !lasi_dev) {
>>>>>           pci_dev = pci_new(-1, "pci-serial-4x");
>>>>>           qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(1));
>>>>>           qdev_prop_set_chr(DEVICE(pci_dev), "chardev2", serial_hd(2));
>>>>> @@ -395,7 +398,7 @@ static void 
>>>>> machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>>>>>       }
>>>>>       /* create USB OHCI controller for USB keyboard & mouse on Astro 
>>>>> machines */
>>>>> -    if (!lasi_dev && machine->enable_graphics) {
>>>>> +    if (defaults_enabled() && !lasi_dev && machine->enable_graphics) {
>>>>>           pci_create_simple(pci_bus, -1, "pci-ohci");
>>>>>           usb_create_simple(usb_bus_find(-1), "usb-kbd");
>>>>>           usb_create_simple(usb_bus_find(-1), "usb-mouse");
>>>>
>>>> This almost doubles the uses of default_enabled in the entire tree.
>>>> I wonder if some of them are redundant or should be using a different
>>>> test.
>>>
>>> Any proposal?
>>> Maybe introduce a local variable hppa_bare_metal = !defaults_enabled();
>>> and use that instead?
>>
>> No, not like that.
> 
> Ok.
> 
>> In casual review I am surprised that !defaults_enabled() does not
>> already imply !enable_graphics, unless the command-line goes on to
>> explicitly add a graphics device.
>> Am I missing something?
> 
> Will check that tommorow. If it does I'll remove that additional check.
> 
> But what other do you suggest in general how I should address your
> concerns here?

IIRC enable_graphics is not influenced by --nodefaults, but it should be 
possible to simply check vga_interface_type only - that should get set to 
VGA_NONE when the user started QEMU with --nodefaults.

For networking, other boards normally check nd_table[0]. And for serial, you 
can check whether serial_hd(0) returns a non-NULL value.

For checking whether you have to create SCSI devices by default, you can 
check drive_get_max_bus(IF_SCSI), I think.

  HTH,
   Thomas


