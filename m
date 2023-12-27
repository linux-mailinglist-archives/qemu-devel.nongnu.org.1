Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B1681EFC9
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 16:36:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIVwE-0007gC-7k; Wed, 27 Dec 2023 10:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rIVwB-0007fn-Ue
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 10:35:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rIVw9-0001l7-MR
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 10:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703691312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kvB8v2X1tjNOGTCR/1vbRUZuz5NXiTe6d4oO03jr27w=;
 b=fykGppPLpz2rSb3+drGt3JdD4jzArfvUFclE8nbHwcQbADbs2NEGD62/vkjFFcxwXBVfH3
 zgLoy25XpPV7vxjyLX881Wac7xJeVYi6VMVaJ6CtMLTO73cLhY/HZoT57I2TonPm9ExQks
 gbLs64YnxwAiQqOIf7iSRYmLyr3eKbY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-6Loot7wdN569f1gCSVLiNA-1; Wed, 27 Dec 2023 10:35:10 -0500
X-MC-Unique: 6Loot7wdN569f1gCSVLiNA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40d43ca3fafso42991865e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 07:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703691309; x=1704296109;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kvB8v2X1tjNOGTCR/1vbRUZuz5NXiTe6d4oO03jr27w=;
 b=FlLBklop+5Kay8pVQ5+pdKb+4fEt1EpRuFNeS9NTh/aAYfpvAOdX9Nv72GTvLGg74q
 I5pDYst6c4j/EfGy+lpinSlxIpv9/pc5xxX6y110sGuycUNU9c8femYm9Ec+n0AZnhvN
 osc/Wc2vBrCp4MQPRkYz31mLqG207oQl6KOiFtmodpGrSzuu4ktdRnTQVCZj6WjFCw3M
 YaF+yy+loByg0NmxpNSPN7VHyzhQcu2VDem4ymLy2SqFi1whUGz2GfDsfz/Ksqyl5CA5
 rh/sA6i690g2dyIkRpZGNugknUM05Uj1PWOB5p6hHH1KEsxtQPIF/K3zHXZs91wF6HK9
 5lzw==
X-Gm-Message-State: AOJu0Yy1/CBuYaPeDmRjZd74Mo5QycRRpOPm22FZzF892Jjd/lVfyOGM
 2qH/A6rQI/E9jah0nHQCazS9Saf7fq6FvyuF3OMDhYFKbaLKOw5jSt8uY+eWxja2E89J7o3QetY
 1/9OEfJEK8qedTxzuyvso0Fs=
X-Received: by 2002:a05:600c:520c:b0:40d:60a9:14bd with SMTP id
 fb12-20020a05600c520c00b0040d60a914bdmr294506wmb.10.1703691308927; 
 Wed, 27 Dec 2023 07:35:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGdxnd1DkbUQtWHH9U/LZdYrj7YpZxpYOw2cElEb+jflMSjgxuRkxwFxqLOgyJJnV+IUaHCw==
X-Received: by 2002:a05:600c:520c:b0:40d:60a9:14bd with SMTP id
 fb12-20020a05600c520c00b0040d60a914bdmr294490wmb.10.1703691308501; 
 Wed, 27 Dec 2023 07:35:08 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 o20-20020a05600c4fd400b004094d4292aesm24295612wmq.18.2023.12.27.07.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 07:35:07 -0800 (PST)
Date: Wed, 27 Dec 2023 10:35:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <lists@philjordan.eu>,
 Santosh Shukla <santosh.shukla@amd.com>
Subject: Re: [PATCH v11 0/7] Support x2APIC mode with TCG accelerator
Message-ID: <20231227103414-mutt-send-email-mst@kernel.org>
References: <20231225164101.105958-1-minhquangbui99@gmail.com>
 <20231226042009-mutt-send-email-mst@kernel.org>
 <1e2bb825-e102-4b75-898d-6ef53175a1cf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e2bb825-e102-4b75-898d-6ef53175a1cf@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.755,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Dec 27, 2023 at 06:03:46PM +0700, Bui Quang Minh wrote:
> On 12/26/23 16:21, Michael S. Tsirkin wrote:
> > On Mon, Dec 25, 2023 at 11:40:54PM +0700, Bui Quang Minh wrote:
> > > Hi everyone,
> > > 
> > > This series implements x2APIC mode in userspace local APIC and the
> > > RDMSR/WRMSR helper to access x2APIC registers in x2APIC mode. Intel iommu
> > > and AMD iommu are adjusted to support x2APIC interrupt remapping. With this
> > > series, we can now boot Linux kernel into x2APIC mode with TCG accelerator
> > > using either Intel or AMD iommu.
> > > 
> > > Testing to boot my own built Linux 6.3.0-rc2, the kernel successfully boot
> > > with enabled x2APIC and can enumerate CPU with APIC ID 257
> > > 
> > > Using Intel IOMMU
> > > 
> > > qemu/build/qemu-system-x86_64 \
> > >    -smp 2,maxcpus=260 \
> > >    -cpu qemu64,x2apic=on \
> > >    -machine q35 \
> > >    -device intel-iommu,intremap=on,eim=on \
> > >    -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
> > >    -m 2G \
> > >    -kernel $KERNEL_DIR \
> > >    -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
> > >    -drive file=$IMAGE_DIR,format=raw \
> > >    -nographic \
> > >    -s
> > > 
> > > Using AMD IOMMU
> > > 
> > > qemu/build/qemu-system-x86_64 \
> > >    -smp 2,maxcpus=260 \
> > >    -cpu qemu64,x2apic=on \
> > >    -machine q35 \
> > >    -device amd-iommu,intremap=on,xtsup=on \
> > >    -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
> > >    -m 2G \
> > >    -kernel $KERNEL_DIR \
> > >    -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
> > >    -drive file=$IMAGE_DIR,format=raw \
> > >    -nographic \
> > >    -s
> > > 
> > > Testing the emulated userspace APIC with kvm-unit-tests, disable test
> > > device with this patch
> > 
> > Seems to break build for windows/amd64
> > https://gitlab.com/mstredhat/qemu/-/pipelines/1118886361/failures
> 
> The failure is because when CONFIG_AMD_IOMMU=n, amd_iommu.c is not built so
> the linker cannot find the definition of amdvi_extended_feature_register
> (amdvi_extended_feature_register is used in acpi-build.c). I create a stub
> to solve this problem and it passes all CI tests. I will squash the
> following changes into patch 6. What do you think about this?
> 
> diff --git a/hw/i386/amd_iommu_stub.c b/hw/i386/amd_iommu_stub.c

I'd probably call it amd_iommu-stub.c even if the mix of _ and - looks
weird, but this is how all other stubs are called.
Document this in the commit log too please.

> new file mode 100644
> index 0000000000..d62a3732e6
> --- /dev/null
> +++ b/hw/i386/amd_iommu_stub.c
> @@ -0,0 +1,26 @@
> +/*
> + * Stubs for AMD IOMMU emulation
> + *
> + * Copyright (C) 2023 Bui Quang Minh <minhquangbui99@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "amd_iommu.h"
> +
> +uint64_t amdvi_extended_feature_register(AMDVIState *s)
> +{
> +    return AMDVI_DEFAULT_EXT_FEATURES;
> +}
> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> index 369c6bf823..d38637b046 100644
> --- a/hw/i386/meson.build
> +++ b/hw/i386/meson.build
> @@ -9,7 +9,8 @@ i386_ss.add(files(
> 
>  i386_ss.add(when: 'CONFIG_X86_IOMMU', if_true: files('x86-iommu.c'),
>                                        if_false: files('x86-iommu-stub.c'))
> -i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'))
> +i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
> +                                      if_false: files('amd_iommu_stub.c'))
>  i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
>  i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('microvm.c',
> 'acpi-microvm.c', 'microvm-dt.c'))
>  i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
> 
> 
> Thanks,
> Quang Minh.


