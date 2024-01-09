Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90321828991
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 17:03:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNEXz-0002Jh-S4; Tue, 09 Jan 2024 11:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNEXt-0002IV-7G
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 11:01:41 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNEXr-0003Fd-89
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 11:01:40 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2045bedb806so2753156fac.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 08:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704816097; x=1705420897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vaFk0hby1wLEbkRZ6447wz5y4wmYgdj3zM3KMgbT8m0=;
 b=rIowzgic1mwLs7DtF4r7/b05oiv6d3Jm0KZcFe4R6tQRy5GSjzDsSikzO3MzIBnEPY
 dh+doSxtnuAS/LyyFYMqAGfJ4FsPbgh2OVcyXiT3Ns57WiRqdU9NrBakiHmOYrleFyG4
 9yk17nt0N5MNXAvLCPpj4cOaice7LQcY8UaU7SljNmJOa3iNBLLOsghVB4GgLh15Ctjm
 266osqHszEto7A1M1CfA7bR1qwh8FWqWkrH+52ar9Xo0HKnRpohaWJGpczEep0B9mn0G
 iOmXUmtn422F23Nj6usX+g+cD7QAgaBbEWCmlMd+xoEi3E3JcFPwF27JT5jEIinoY5WH
 k/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704816097; x=1705420897;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vaFk0hby1wLEbkRZ6447wz5y4wmYgdj3zM3KMgbT8m0=;
 b=IoaF0Bw3MDmv843fM4dmFyxEjPHMcUhH81JCMLDkk1tNXdHjpSz57d+M2FX0BOLO/B
 2iujlgos2bFd3O2raiUzCrzoEomGdUF2vkDG5SjcHBFw6D0Qv9WZi6ivtQOm2Ak1ANcf
 dhxeyTquxv3Jh5nWJGqdgKFywBpPx5QzH5IPy0WhiEQB14WNgwyrNrUAAJIo/R9rpKUe
 NRhFsVpgQI9y7kQJ53TnsLS9EeU7cuuAiyggKhQq5YAj4/C2A5mTtzBWHk8005+QVffv
 C3mIQNA10Q+yD/jp4QriyfdGW/R8OKRdZk/pBnb2CjU3YXXtRFUQvywRls7LxShUXSAO
 PX4Q==
X-Gm-Message-State: AOJu0Yw3Ay7PSctNTsjTCTXPcNHWMdOXSxSoPhaU1mlFQdFzOBvPn9MJ
 7KpstL/vRkDIPCEZQUuv7jH8y6GCh+mfSWCvDJScBNniSF3SeA==
X-Google-Smtp-Source: AGHT+IGzKI8qdoV3mHngFderVIAH1CYbqgQPJgz21ji7amlSjPtifG6Y2yHb9CPBnBHfVHspc/RboQ==
X-Received: by 2002:a05:6871:80c7:b0:204:1583:c42a with SMTP id
 sm7-20020a05687180c700b002041583c42amr7822317oab.65.1704816096813; 
 Tue, 09 Jan 2024 08:01:36 -0800 (PST)
Received: from [192.168.47.227] ([172.58.111.136])
 by smtp.gmail.com with ESMTPSA id
 w3-20020a9d77c3000000b006dbfdb1c9b2sm410181otl.43.2024.01.09.08.01.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 08:01:36 -0800 (PST)
Message-ID: <5c6768a6-a487-4a82-a4e1-374dff074610@linaro.org>
Date: Wed, 10 Jan 2024 03:01:26 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] hw/hppa/machine: Disable default devices with
 --nodefaults option
To: Helge Deller <deller@gmx.de>, deller@kernel.org, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>
References: <20240107132237.50553-1-deller@kernel.org>
 <20240107132237.50553-3-deller@kernel.org>
 <3cc1664c-9f5c-4d2f-b8f3-f8880c110e10@linaro.org>
 <1fde7d36-420a-4df5-821e-bcd4819ac6b7@gmx.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <1fde7d36-420a-4df5-821e-bcd4819ac6b7@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/9/24 22:16, Helge Deller wrote:
> On 1/9/24 10:57, Richard Henderson wrote:
>> On 1/8/24 00:22, deller@kernel.org wrote:
>>> From: Helge Deller <deller@gmx.de>
>>>
>>> Add support for the qemu --nodefaults option, which will disable the
>>> following default devices:
>>> - lsi53c895a SCSI controller,
>>> - artist graphics card,
>>> - LASI 82596 NIC,
>>> - tulip PCI NIC,
>>> - second serial PCI card,
>>> - USB OHCI controller.
>>>
>>> Adding this option is very useful to allow manual testing and
>>> debugging of the other possible devices on the command line.
>>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>> ---
>>>   hw/hppa/machine.c | 15 +++++++++------
>>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>> index b11907617e..8017002a2a 100644
>>> --- a/hw/hppa/machine.c
>>> +++ b/hw/hppa/machine.c
>>> @@ -346,11 +346,14 @@ static void machine_HP_common_init_tail(MachineState *machine, 
>>> PCIBus *pci_bus,
>>>       SysBusDevice *s;
>>>       /* SCSI disk setup. */
>>> -    dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
>>> -    lsi53c8xx_handle_legacy_cmdline(dev);
>>> +    if (defaults_enabled()) {
>>> +        dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
>>> +        lsi53c8xx_handle_legacy_cmdline(dev);
>>> +    }
>>>       /* Graphics setup. */
>>> -    if (machine->enable_graphics && vga_interface_type != VGA_NONE) {
>>> +    if (defaults_enabled() && machine->enable_graphics &&
>>> +        vga_interface_type != VGA_NONE) {
>>>           vga_interface_created = true;
>>>           dev = qdev_new("artist");
>>>           s = SYS_BUS_DEVICE(dev);
>>> @@ -360,7 +363,7 @@ static void machine_HP_common_init_tail(MachineState *machine, 
>>> PCIBus *pci_bus,
>>>       }
>>>       /* Network setup. */
>>> -    if (enable_lasi_lan()) {
>>> +    if (defaults_enabled() && enable_lasi_lan()) {
>>>           lasi_82596_init(addr_space, translate(NULL, LASI_LAN_HPA),
>>>                           qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA));
>>>       }
>>> @@ -385,7 +388,7 @@ static void machine_HP_common_init_tail(MachineState *machine, 
>>> PCIBus *pci_bus,
>>>       pci_set_word(&pci_dev->config[PCI_SUBSYSTEM_ID], 0x1227); /* Powerbar */
>>>       /* create a second serial PCI card when running Astro */
>>> -    if (!lasi_dev) {
>>> +    if (defaults_enabled() && !lasi_dev) {
>>>           pci_dev = pci_new(-1, "pci-serial-4x");
>>>           qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(1));
>>>           qdev_prop_set_chr(DEVICE(pci_dev), "chardev2", serial_hd(2));
>>> @@ -395,7 +398,7 @@ static void machine_HP_common_init_tail(MachineState *machine, 
>>> PCIBus *pci_bus,
>>>       }
>>>       /* create USB OHCI controller for USB keyboard & mouse on Astro machines */
>>> -    if (!lasi_dev && machine->enable_graphics) {
>>> +    if (defaults_enabled() && !lasi_dev && machine->enable_graphics) {
>>>           pci_create_simple(pci_bus, -1, "pci-ohci");
>>>           usb_create_simple(usb_bus_find(-1), "usb-kbd");
>>>           usb_create_simple(usb_bus_find(-1), "usb-mouse");
>>
>> This almost doubles the uses of default_enabled in the entire tree.
>> I wonder if some of them are redundant or should be using a different
>> test.
> 
> Any proposal?
> Maybe introduce a local variable hppa_bare_metal = !defaults_enabled();
> and use that instead?

No, not like that.

In casual review I am surprised that !defaults_enabled() does not already imply 
!enable_graphics, unless the command-line goes on to explicitly add a graphics device.

Am I missing something?


r~

