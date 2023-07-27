Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D5F764CB4
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 10:25:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOvmd-0000Rb-2Q; Thu, 27 Jul 2023 03:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qOvmP-0000Qd-4H
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:51:25 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qOvmL-00007N-UV
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:51:23 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so688461f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 00:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690444280; x=1691049080;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cdITa7Wq+4eiw2rue221D0NdRfR3sO7CGc4YXAsZpSM=;
 b=dfYJocuFX58uoB/lZ0qThGXsuRnYBqoi2FczdSNLnCnSLRkoXQNPGbqscm7s7QXOSN
 FzoaNjtTp1pw3G8AB/C3WBb/v9Zz3wGvjPSXwnd1tulDZflBAM4cuGfoGR1wdiHy6AFZ
 5q0vMBOhdGuruljsur4GtxG4GXwZ3LFBQ+M0P42xj2Z/CF4Bp1ugHEu03XySzsE/w6Rv
 e3tLkfZjHy2gcfPMYGmyNb0TTPZzYIjuHmlBn6DFAGXNUbGNinTQdXCLw9kMAbzGHws0
 VCKrVaqyn4ggI8nOXizWAKwD2ChUSnPLwNivjjwqz+Yd0tnZLxTXX19ahk1XvABnQXge
 Zigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690444280; x=1691049080;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdITa7Wq+4eiw2rue221D0NdRfR3sO7CGc4YXAsZpSM=;
 b=GI/JRJi8CuFkjW2YYUMGNcNKZidQnNMZJYjomcY8bV/YckopunE9E0DLHXdwCrnWBE
 0xDbf/uDWVdgi1BsrsWUr/24nUjbYiHMS95MRMIpCfNE/WYzPf6odvK6W/BdJD5bbL/j
 LaQrAnVJQTIDVd8gnJQGnHYHYqbG7lYrDNXInwr05dt6GeiuCpwQTKchkGFf6VF17w6x
 XnHwng4V1LBdSm1nrT866goCvgzsyM7dJnKBihmsWmWrO+5daEwrb8S3bW8ZQhjCEQDn
 TQmc8zPTLglmuPs84lKUKOoVWvE9cXOVo9gf4dj2+h8TBJr8HBQDXQC28i8JyTQUmKVm
 FfEw==
X-Gm-Message-State: ABy/qLY8DJBy9e2kuiF+Cu8zNKrX6N44ERhctWkhD1yNjxkd5fpWIc5q
 IfXQzjRyGEfkgQD4FPNmrUg=
X-Google-Smtp-Source: APBJJlGbm9sqXaDx4iRrqGi6MDRxZyjeroAuBLvHzibVYdsWVshwxb9/DgAr9sAx8eQh64NKb/DGLQ==
X-Received: by 2002:a5d:45cf:0:b0:313:f1c8:a963 with SMTP id
 b15-20020a5d45cf000000b00313f1c8a963mr1266338wrs.2.1690444280046; 
 Thu, 27 Jul 2023 00:51:20 -0700 (PDT)
Received: from [192.168.12.179] (54-240-197-231.amazon.com. [54.240.197.231])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a5d4941000000b00314427091a2sm1172046wrs.98.2023.07.27.00.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 00:51:19 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <3aaaa43e-b129-35aa-f07d-d50200a4c2ec@xen.org>
Date: Thu, 27 Jul 2023 08:51:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] xen-platform: do full PCI reset during unplug of IDE
 devices
Content-Language: en-US
To: Olaf Hering <olaf@aepfle.de>, xen-devel@lists.xenproject.org,
 qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230720072950.20198-1-olaf@aepfle.de>
Organization: Xen Project
In-Reply-To: <20230720072950.20198-1-olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 20/07/2023 08:29, Olaf Hering wrote:
> The IDE unplug function needs to reset the entire PCI device, to make
> sure all state is initialized to defaults. This is done by calling
> pci_device_reset, which resets not only the chip specific registers, but
> also all PCI state. This fixes "unplug" in a Xen HVM domU with the
> modular legacy xenlinux PV drivers.
> 
> Commit ee358e919e38 ("hw/ide/piix: Convert reset handler to
> DeviceReset") changed the way how the the disks are unplugged. Prior
> this commit the PCI device remained unchanged. After this change,
> piix_ide_reset is exercised after the "unplug" command, which was not
> the case prior that commit. This function resets the command register.
> As a result the ata_piix driver inside the domU will see a disabled PCI
> device. The generic PCI code will reenable the PCI device. On the qemu
> side, this runs pci_default_write_config/pci_update_mappings. Here a
> changed address is returned by pci_bar_address, this is the address
> which was truncated in piix_ide_reset. In case of a Xen HVM domU, the
> address changes from 0xc120 to 0xc100. This truncation was a bug in
> piix_ide_reset, which was fixed in commit 230dfd9257 ("hw/ide/piix:
> properly initialize the BMIBA register"). If pci_xen_ide_unplug had used
> pci_device_reset, the PCI registers would have been properly reset, and
> commit ee358e919e38 would have not introduced a regression for this
> specific domU environment.
> 
> While the unplug is supposed to hide the IDE disks, the changed BMIBA
> address broke the UHCI device. In case the domU has an USB tablet
> configured, to recive absolute pointer coordinates for the GUI, it will
> cause a hang during device discovery of the partly discovered USB hid
> device. Reading the USBSTS word size register will fail. The access ends
> up in the QEMU piix-bmdma device, instead of the expected uhci device.
> Here a byte size request is expected, and a value of ~0 is returned. As
> a result the UCHI driver sees an error state in the register, and turns
> off the UHCI controller.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>   hw/i386/xen/xen_platform.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


