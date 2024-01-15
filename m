Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B19B782DD9F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 17:30:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPPqs-00085a-Js; Mon, 15 Jan 2024 11:30:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPPqm-00084q-C1
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:30:12 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPPqj-0005s9-Qf
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:30:11 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a2c179aa5c4so550082066b.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 08:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705336207; x=1705941007; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GcQnhLosvyie/RI0W8e4uz5170hW5hrYZug7xttdnHM=;
 b=dWowo+3JFr7j/pHUMTMhKEDvoDfT5otbfwZETE/PgY3EIFcXRmV+gveLihzOg09+U5
 dcQhmY36js/rirUBk6rwtI7sd9PSlWLNLaDhtGlxDfRSC4kqRTmAR1pCaHTaV/M/InhG
 thrbqLHUNz+Ysyyi8LuTUFb1bvx2ATPuISyAvonAawxkZNwCRLq+/qCSjfbHfDJ2HmP7
 yYRH9TLthGGScGFQg/lwkWAqh38U4Mv2JBmduBXMZRsZRMUU68xkH23AamwZPOlBh9V3
 DkIanlOHRWHNvgN42uc5YJMSFYVYZE/dIQxBs20bNGtGc06hNWb6jbiUVsQJphJBK8hd
 /nPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705336207; x=1705941007;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GcQnhLosvyie/RI0W8e4uz5170hW5hrYZug7xttdnHM=;
 b=w5edB8vU4ITSPuL1hABDxJjBErB2BEpRz6Iz1ooTOGVHTnH1kKnAaQIWy5m3o+hC7j
 Exrnz6C7xCOCCLoWGNRoZ+dMGqzaGQxRXnQ5gMiYTe7SpCpdEmwXJQtJ58FLwyX9fnIa
 PQIcEWDWDwS7rfonVk29NHG/ocxa+Lk5AZHlSAen1WpOg4rdOFOqDbSN36bBlmzDPsK+
 gLqYPY88r7dgv0LmbJqGkc5fzQRne+m5M8bIpvoCikdolqufZNp2smk5GzzSgnp2gxs0
 L/l298ggzkxr+MK/d/7T7zqGJEfctgebCVU5LS3Z2pIAhHvTDIyvYpyb1jJhbXAjVR75
 nN+w==
X-Gm-Message-State: AOJu0Yx5BsqYNJBjDpT+1+ejND4mfg+Xgz0fkG0HEpXt+/vTF0pXx+9K
 cOJ/lrVs8zOQfZw/6g1CPEjImmO2lAx0XA==
X-Google-Smtp-Source: AGHT+IEWrV9reMWMtB5jih4E9qm6ayUOJk8Wjw2768CMT1/ZFdOrcSqH+EZohZMfFcFtx5cPlb64QQ==
X-Received: by 2002:a17:906:5299:b0:a2b:1df5:47c3 with SMTP id
 c25-20020a170906529900b00a2b1df547c3mr3064326ejm.87.1705336207503; 
 Mon, 15 Jan 2024 08:30:07 -0800 (PST)
Received: from [192.168.69.100] ([176.187.209.30])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a170906c00400b00a298adde5a1sm5425980ejz.189.2024.01.15.08.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 08:30:07 -0800 (PST)
Message-ID: <bcfd42d5-1c48-4126-913a-a5251c3cc9c7@linaro.org>
Date: Mon, 15 Jan 2024 17:30:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/arm: Add EHCI/OHCI controllers to Allwinner R40
 and Bananapi board
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth
 <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>
References: <20240113191651.1313226-1-linux@roeck-us.net>
 <20240113191651.1313226-2-linux@roeck-us.net>
 <56f692d8-41b1-4126-96b9-80d274624984@linaro.org>
 <56fde49f-7dc6-4f8e-9bbf-0336a20a9ebf@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <56fde49f-7dc6-4f8e-9bbf-0336a20a9ebf@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 15/1/24 17:12, Guenter Roeck wrote:
> On 1/15/24 03:02, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 13/1/24 20:16, Guenter Roeck wrote:
>>> Allwinner R40 supports two USB host ports shared between a USB 2.0 EHCI
>>> host controller and a USB 1.1 OHCI host controller. Add support for both
>>> of them.
>>>
>>> If machine USB support is not enabled, create unimplemented devices
>>> for the USB memory ranges to avoid crashes when booting Linux.
>>
>> I never really understood the reason for machine_usb() and had on my
>> TODO to do some archeology research to figure it out since quite some
>> time. Having to map an UnimpDevice due to CLI options seems like an
>> anti-pattern when the device is indeed implemented in the repository.
>>
> 
> Me not either. I copied the code from aw_a10_init(), trying to use the
> same pattern. I am perfectly fine with making it unconditional, but then
> I would argue that it should be unconditional for Allwinner A10 as well
> (not that I really care much, just for consistency).

Certainly, but I'd rather have a global pattern cleanup, not just
Allwinner based machines. Looking at the repository:

$ git grep -w machine_usb hw/
hw/arm/allwinner-a10.c:82:    if (machine_usb(current_machine)) {
hw/arm/allwinner-a10.c:168:    if (machine_usb(current_machine)) {
hw/arm/nseries.c:1356:    if (machine_usb(machine)) {
hw/arm/realview.c:288:        if (machine_usb(machine)) {
hw/arm/realview.c-289-            pci_create_simple(pci_bus, -1, 
"pci-ohci");
hw/arm/versatilepb.c:276:    if (machine_usb(machine)) {
hw/arm/versatilepb.c-277-        pci_create_simple(pci_bus, -1, "pci-ohci");
hw/core/machine.c:1175:bool machine_usb(MachineState *machine)
hw/i386/acpi-microvm.c:88:    if (machine_usb(MACHINE(mms))) {
hw/i386/acpi-microvm.c-89-        xhci_sysbus_build_aml(scope, 
MICROVM_XHCI_BASE, MICROVM_XHCI_IRQ);
hw/i386/microvm.c:218:    if (x86_machine_is_acpi_enabled(x86ms) && 
machine_usb(MACHINE(mms))) {
hw/i386/microvm.c-225-        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 
MICROVM_XHCI_BASE);
hw/i386/pc_piix.c:267: 
machine_usb(machine), &error_abort);
hw/i386/pc_q35.c:321:    if (machine_usb(machine)) {
hw/i386/pc_q35.c-323-        ehci_create_ich9_with_companions(host_bus, 
0x1d);
hw/ppc/mac_oldworld.c:300:    if (machine_usb(machine)) {
hw/ppc/mac_oldworld.c-301-        pci_create_simple(pci_bus, -1, 
"pci-ohci");

I'd classify that as "USB controller over MMIO / over some bus (PCI)".

The "plug a PCI-to-USB card by default" seems a valid use case (except
for Q35 which is a Frankenstein case, ICH9 chipset is like ARM SoC,
USB bus is always there).

IMHO all the MMIO uses should be corrected.

> The "-usb" option says "enable on-board USB host controller (if not
> enabled by default)". Unfortunately, that doesn't tell me much,
> and most specifically it doesn't tell me how to enable it by default.
> One option I can think of would be to enable it on the machine level,
> i.e., from bananapi_m2u.c, but then, again, I don't see if/how
> that is done for other boards. Any suggestions ?
> 
> Of course, I could discuss this with the person who implemented this
> code for A10, but it turns out that was me, for no good reason than
> that I tried to follow the pattern I had seen elsewhere without really
> understanding what I was doing.
> 
> So should I drop the conditional from H40 and send a separate patch
> to drop it from the A10 code as well, following your line of argument ?
> Or drop it and leave A10 alone ?

Well your patch isn't invalid, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I'm just worried we are taking a bad path here and would rather avoid
it if possible...

Regards,

Phil.

