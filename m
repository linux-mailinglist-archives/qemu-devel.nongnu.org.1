Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B63B70F6CA
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 14:44:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1nq9-0004De-Jn; Wed, 24 May 2023 08:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1nq8-0004DH-EL
 for qemu-devel@nongnu.org; Wed, 24 May 2023 08:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1nq6-000665-SS
 for qemu-devel@nongnu.org; Wed, 24 May 2023 08:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684932218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vEfzOcj9WqNCaGm2ABmHziCO8hRgXBMPJM05WJCER7s=;
 b=OtjNX7rHhrDPLpltkQ+i/KrKsG44lr1NaF+WfLtM/fqyoxD0szWsnyqSK3TJBWF7wjELim
 KU3uyL2P3By2vriV4PwLEfS2eBym9oI7OwLGORn6NGF76HmZ62xrCe6S/qfkq+dyNhkH2f
 9KGndLWjJdFbnApgho4l1VyV4VOQeGM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-9Qk4ZSrfNfeDUpy7qRHjew-1; Wed, 24 May 2023 08:43:36 -0400
X-MC-Unique: 9Qk4ZSrfNfeDUpy7qRHjew-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3095483ea29so349394f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 05:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684932215; x=1687524215;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vEfzOcj9WqNCaGm2ABmHziCO8hRgXBMPJM05WJCER7s=;
 b=EPDGgNO0ydY3YOB05NJgye6S3Cn0dkTDuEKR8j/CeVAMgsfCED+nSxkOgy7CXVteNK
 YQ6Smd/wY9Em4sTZKIjci6k4iVS6WUNJQWabdzg4PgSTQ5n/d7t2Cm5x8X3CpCGQ9KIf
 ucYRUcDEyVW2K0pbENt5io2PUnjNlnC0XRT9XwzeGF8/YHEH9DGVmcnKz8W9FSS7dc1V
 qammdXA3e11Kkoxae8vhXwyen6InDXwpr3L1vjAbM/4Es9GfEMTqjIqfqdBkeVeBNb+7
 Ppl34jbKKsQEWLaFUU5ur/yrTmYa1LB4UAm3AFQqMSKbFWjVGtQer5lmX7ntCi+Lc3Ox
 S9/g==
X-Gm-Message-State: AC+VfDzS4ncJCCs//3N+TlrlNcmBSvZHvYo2NnjmFmIwY9E49PVUCFje
 APNlAwBi0Frl1o4r+7IinyUaa7C+Gb47eM9MjHwJLp0UPH+B5mi3o81sMZiliBit+pzK0HQhm2K
 JwhMRWPUIK/nkCE4=
X-Received: by 2002:a5d:6d4d:0:b0:309:3ddc:1c8c with SMTP id
 k13-20020a5d6d4d000000b003093ddc1c8cmr12022627wri.20.1684932215512; 
 Wed, 24 May 2023 05:43:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4fwj/N+PGUEwKnjrk0aM1XMUmY+iRunUZocpqbCH/V19REvRrUBpaOF041exxPSBbhu53xgw==
X-Received: by 2002:a5d:6d4d:0:b0:309:3ddc:1c8c with SMTP id
 k13-20020a5d6d4d000000b003093ddc1c8cmr12022615wri.20.1684932215233; 
 Wed, 24 May 2023 05:43:35 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 x15-20020a1c7c0f000000b003f4266965fbsm2278604wmc.5.2023.05.24.05.43.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 05:43:34 -0700 (PDT)
Message-ID: <8dae908f-cec0-e563-1f24-26747c2ad61f@redhat.com>
Date: Wed, 24 May 2023 14:43:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] hw/mips: Use MachineClass->default_nic in the virt machine
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>
References: <20230524122559.28863-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230524122559.28863-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 24/05/2023 14.25, Philippe Mathieu-Daudé wrote:
> Mark the default NIC via the new MachineClass->default_nic setting
> so that the machine-defaults code in vl.c can decide whether the
> default NIC is usable or not (for example when compiling with the
> "--without-default-devices" configure switch).
> 
> Inspired-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20230523110435.1375774-1-thuth@redhat.com>
> ---
>   hw/mips/loongson3_virt.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> index 25534288dd..216812f660 100644
> --- a/hw/mips/loongson3_virt.c
> +++ b/hw/mips/loongson3_virt.c
> @@ -406,6 +406,7 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
>       PCIBus *pci_bus;
>       DeviceState *dev;
>       MemoryRegion *mmio_reg, *ecam_reg;
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
>       LoongsonMachineState *s = LOONGSON_MACHINE(machine);
>   
>       dev = qdev_new(TYPE_GPEX_HOST);
> @@ -456,7 +457,7 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
>           NICInfo *nd = &nd_table[i];
>   
>           if (!nd->model) {
> -            nd->model = g_strdup("virtio");
> +            nd->model = g_strdup(mc->default_nic);
>           }
>   
>           pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
> @@ -619,6 +620,7 @@ static void loongson3v_machine_class_init(ObjectClass *oc, void *data)
>       mc->default_ram_size = 1600 * MiB;
>       mc->kvm_type = mips_kvm_type;
>       mc->minimum_page_bits = 14;
> +    mc->default_nic = "virtio-net-pci";
>   }

Reviewed-by: Thomas Huth <thuth@redhat.com>


