Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F017FAB1908
	for <lists+qemu-devel@lfdr.de>; Fri,  9 May 2025 17:42:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDPr6-0007Aa-Kq; Fri, 09 May 2025 11:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uDPr0-00079f-Vd
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:41:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uDPqw-0001fr-1X
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746805291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QOLaybYm4U7uIKxuBSKD+ubf4Ws7sD4/jVMWvakjmJ0=;
 b=V2LKgok1qr3rPgl69qnYJ563SFfAqKHKB3bk4Vc8Q0T+u37W586qY6youJ6ajndIFG4Sh+
 KkWmKYDGE+MdmspUXLCFeDp6U4M2cB1XNCdVQ/ZY00Hm84i+v6CGIvxyKo7FfzayogUYB1
 fz6Rz1fJ5Dr1CDU8hjmGjTP/XQ653d4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-r46dfEtiMmOF1mlHInGG4Q-1; Fri, 09 May 2025 11:41:30 -0400
X-MC-Unique: r46dfEtiMmOF1mlHInGG4Q-1
X-Mimecast-MFC-AGG-ID: r46dfEtiMmOF1mlHInGG4Q_1746805289
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43efa869b19so15032595e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 08:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746805289; x=1747410089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QOLaybYm4U7uIKxuBSKD+ubf4Ws7sD4/jVMWvakjmJ0=;
 b=RebTtaUlEzffzXQyuFFNr6JGptdsIzc7zEA5q4tWXtpH9Hew+e2t2jaUKGqf/CKGd6
 qq5d5qlGBCmS0JGDBVKagn3Yf5kcTXm7Zbn/nCNRdFNsW5p9j0pKXEGppxLDSAn/IVAl
 e3uNlrFwxDJ0yk7XEh05zSSEn6QZQFlSB/yaHf8T58YyWDSIT+/VeILnP/UxuySyE8zh
 CYK6VIw0G8OkeqzD2pRbU+I1YbLZUO8hjjW5OIsaDri1M+Jzu1KCbOUEfNOq5Rdh0QUg
 cQZOOt+fxGNKKnrWZPy81OngN6b8KqzO2BU0do452Nm2AaYl8NcAqafd4ltS3UNoXpvr
 tbfA==
X-Gm-Message-State: AOJu0YyB3mc+Ic3UHmRzIPt2tHoUnZGdryOXzMit0CwDHxGwL1qrsg2N
 tOP82wX1xJVrF2UHma4s2Cp467p0RPbm4EAW548LwNnJymRg4elNd9gFdBAh/43qFL0dhRnmHHp
 f9BEIeMSg1HMCSy+79VfKa78augJbfTK2q/0byMhki9dZ9KDRVmvf
X-Gm-Gg: ASbGncunUwq8v0C5knhegVG/GJGl3tTwBMi1JgV1vN/ZYs9BLRYBYlAh61JL8bb5nP7
 n3Ew3gn0BP3J3OzVv9r/lBQrfnhxzDXjgFe5QdBbkH5cHggNgVeCiHzk0soe5iNtEE+Oo5Z384G
 xVQdOSSnSsss7b6QhvZ3GzCHg+BzZh2tKrPbBLgAQwMysKDoQwA9LEApEpaP/WyBwoLwTkRup+3
 Dj9yqn4jRyQwcqblD8H7FDBxYANUoHsFAOpM5UYH7dputHn+m41VbzRUVzCw4FfsJExBQsSgmxb
 szRHsvEKK7FR9Wy3w7atIXP9FIJnyAme
X-Received: by 2002:a5d:5984:0:b0:3a0:a0d1:1131 with SMTP id
 ffacd0b85a97d-3a1f643ab18mr3673893f8f.7.1746805289152; 
 Fri, 09 May 2025 08:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeXwnOQIA5iqmq6aNcokUi8KYZ3Caz1PT8VQbuQhO6YtpVywVdoQp89AyDaZzMhCBLxiiXHw==
X-Received: by 2002:a5d:5984:0:b0:3a0:a0d1:1131 with SMTP id
 ffacd0b85a97d-3a1f643ab18mr3673848f8f.7.1746805288681; 
 Fri, 09 May 2025 08:41:28 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ecaeasm3581262f8f.28.2025.05.09.08.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 08:41:28 -0700 (PDT)
Date: Fri, 9 May 2025 17:41:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laurent
 Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu
 <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-riscv@nongnu.org, Weiwei Li
 <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>, Zhao Liu
 <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>, Helge Deller
 <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha
 <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, Jason
 Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4 07/27] hw/i386/x86: Remove
 X86MachineClass::fwcfg_dma_enabled field
Message-ID: <20250509174125.41bc03a3@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250508133550.81391-8-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-8-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu,  8 May 2025 15:35:30 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The X86MachineClass::fwcfg_dma_enabled boolean was only used
> by the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
> removed. Remove it and simplify.
>=20
> 'multiboot.bin' isn't used anymore, we'll remove it in the
> next commit.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/i386/x86.h | 2 --
>  hw/i386/microvm.c     | 3 ---
>  hw/i386/multiboot.c   | 7 +------
>  hw/i386/x86-common.c  | 3 +--
>  hw/i386/x86.c         | 2 --
>  5 files changed, 2 insertions(+), 15 deletions(-)
>=20
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index fc460b82f82..29d37af11e6 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -29,8 +29,6 @@
>  struct X86MachineClass {
>      MachineClass parent;
> =20
> -    /* use DMA capable linuxboot option rom */
> -    bool fwcfg_dma_enabled;
>      /* CPU and apic information: */
>      bool apic_xrupt_override;
>  };
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index e0daf0d4fc3..b1262fb1523 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -637,7 +637,6 @@ GlobalProperty microvm_properties[] =3D {
> =20
>  static void microvm_class_init(ObjectClass *oc, const void *data)
>  {
> -    X86MachineClass *x86mc =3D X86_MACHINE_CLASS(oc);
>      MicrovmMachineClass *mmc =3D MICROVM_MACHINE_CLASS(oc);
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>      HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
> @@ -671,8 +670,6 @@ static void microvm_class_init(ObjectClass *oc, const=
 void *data)
>      hc->unplug_request =3D microvm_device_unplug_request_cb;
>      hc->unplug =3D microvm_device_unplug_cb;
> =20
> -    x86mc->fwcfg_dma_enabled =3D true;
> -
>      object_class_property_add(oc, MICROVM_MACHINE_RTC, "OnOffAuto",
>                                microvm_machine_get_rtc,
>                                microvm_machine_set_rtc,
> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
> index 6e6b96bc345..bfa7e8f1e83 100644
> --- a/hw/i386/multiboot.c
> +++ b/hw/i386/multiboot.c
> @@ -153,7 +153,6 @@ int load_multiboot(X86MachineState *x86ms,
>                     int kernel_file_size,
>                     uint8_t *header)
>  {
> -    bool multiboot_dma_enabled =3D X86_MACHINE_GET_CLASS(x86ms)->fwcfg_d=
ma_enabled;
>      int i, is_multiboot =3D 0;
>      uint32_t flags =3D 0;
>      uint32_t mh_entry_addr;
> @@ -402,11 +401,7 @@ int load_multiboot(X86MachineState *x86ms,
>      fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, mb_bootinfo_data,
>                       sizeof(bootinfo));
> =20
> -    if (multiboot_dma_enabled) {
> -        option_rom[nb_option_roms].name =3D "multiboot_dma.bin";
> -    } else {
> -        option_rom[nb_option_roms].name =3D "multiboot.bin";

shouldn't we remove "multiboot.bin" as well?

> -    }
> +    option_rom[nb_option_roms].name =3D "multiboot_dma.bin";
>      option_rom[nb_option_roms].bootindex =3D 0;
>      nb_option_roms++;
> =20
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index 1b0671c5239..27254a0e9f1 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -634,7 +634,6 @@ void x86_load_linux(X86MachineState *x86ms,
>                      int acpi_data_size,
>                      bool pvh_enabled)
>  {
> -    bool linuxboot_dma_enabled =3D X86_MACHINE_GET_CLASS(x86ms)->fwcfg_d=
ma_enabled;
>      uint16_t protocol;
>      int setup_size, kernel_size, cmdline_size;
>      int dtb_size, setup_data_offset;
> @@ -993,7 +992,7 @@ void x86_load_linux(X86MachineState *x86ms,
> =20
>      option_rom[nb_option_roms].bootindex =3D 0;
>      option_rom[nb_option_roms].name =3D "linuxboot.bin";
> -    if (linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
> +    if (fw_cfg_dma_enabled(fw_cfg)) {
>          option_rom[nb_option_roms].name =3D "linuxboot_dma.bin";
>      }
>      nb_option_roms++;
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index f80533df1c5..dbf104d60af 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -375,14 +375,12 @@ static void x86_machine_initfn(Object *obj)
>  static void x86_machine_class_init(ObjectClass *oc, const void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> -    X86MachineClass *x86mc =3D X86_MACHINE_CLASS(oc);
>      NMIClass *nc =3D NMI_CLASS(oc);
> =20
>      mc->cpu_index_to_instance_props =3D x86_cpu_index_to_props;
>      mc->get_default_cpu_node_id =3D x86_get_default_cpu_node_id;
>      mc->possible_cpu_arch_ids =3D x86_possible_cpu_arch_ids;
>      mc->kvm_type =3D x86_kvm_type;
> -    x86mc->fwcfg_dma_enabled =3D true;
>      nc->nmi_monitor_handler =3D x86_nmi;
> =20
>      object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto",


