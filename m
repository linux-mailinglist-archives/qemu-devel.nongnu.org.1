Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7162C81EE75
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 12:05:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIRhf-0002gH-FP; Wed, 27 Dec 2023 06:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rIRhd-0002g5-OW
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 06:03:57 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rIRhb-0005U5-M6
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 06:03:57 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d3cfb1568eso41798195ad.1
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 03:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703675034; x=1704279834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BdDTgjjxLt9E37YCivfYfS0xjf6IyKej+Bf8MIAFJSE=;
 b=nQRxIFm/blZ6s+W1rVvuNA0uoxe14gmYFON7yL7nwG1HJBt0M9COIxRhCMeh7GFrEj
 b6Z/5FdPu5Z7EIcqcSQkBv/u8hosXl9EnGu+GhnGfM16KcnkS5eXFPet5EJ+Q+EcVwn7
 OOoSNxd06BWEprzj7OBArX9TZmcFkni1I2713n67WFKaentqIkpc6LK5WxVUz7iU5OZa
 OZZnt2tSpu9Gsa4zsNO4VoRNgew27VnmDZo9bviZEtdsmFcsXG4jTDTziVRPdk6OfWbz
 BrRVnCZJ3U7StlMEfne4JDWnTDFbbApomU0XEuSr4zwJYoaRPL3K/QtT0Na8kwfUSBxH
 1N3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703675034; x=1704279834;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BdDTgjjxLt9E37YCivfYfS0xjf6IyKej+Bf8MIAFJSE=;
 b=ICUBVZSXV/HpGYwAlY0sOxo+i8RGXtPcxDOOA5IxXbLEC39qDs5kSvRK/HtM0wAhES
 a0YDDNBcPSFxH5B8/P8nOFM7aI4QorAamEQgXS+3QV1Wa0/vpLl/AvgMlI8wAdIpLqw2
 XR+UnZStvw8PY3G2Y2TF3kO0JUc2eHM3c+xxxlOTEgCYSGMkLa/+PEJnI4251Fy/OZSE
 CkJR7TT/MQ7q3+l2K7g5JDzeI1LQZsEmb7WXNPgAoSVgcjl1HqHQfwYl8p34OwcaSHXg
 6TkXHkpUH6r4ORESx7fN7786E7UWw4G1SlwCBkxjnS41/IBRMkxhNV4ORa43jgv+KiUz
 3uwg==
X-Gm-Message-State: AOJu0YxdCItpBiADk2Fa1xjv/qZ61GNRj1Xr8en1uWWVyOgIyJBMwmBi
 6JmbNxiGBLi4QSbvDBgDH3k=
X-Google-Smtp-Source: AGHT+IEIFa4AeAx1SysZ/AmzpNWK9EwklAsYFjucXZh3tsDDJ7J7ehN8Xyz65n56trvaEu8wdhlmbg==
X-Received: by 2002:a17:902:d58b:b0:1d4:5939:523a with SMTP id
 k11-20020a170902d58b00b001d45939523amr5968655plh.33.1703675033899; 
 Wed, 27 Dec 2023 03:03:53 -0800 (PST)
Received: from ?IPV6:2001:ee0:50f4:9050:2642:9396:4367:b8d1?
 ([2001:ee0:50f4:9050:2642:9396:4367:b8d1])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a170902e54700b001d0cd351baesm11611050plf.13.2023.12.27.03.03.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 03:03:53 -0800 (PST)
Message-ID: <1e2bb825-e102-4b75-898d-6ef53175a1cf@gmail.com>
Date: Wed, 27 Dec 2023 18:03:46 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/7] Support x2APIC mode with TCG accelerator
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Joao Martins <joao.m.martins@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <lists@philjordan.eu>,
 Santosh Shukla <santosh.shukla@amd.com>
References: <20231225164101.105958-1-minhquangbui99@gmail.com>
 <20231226042009-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20231226042009-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On 12/26/23 16:21, Michael S. Tsirkin wrote:
> On Mon, Dec 25, 2023 at 11:40:54PM +0700, Bui Quang Minh wrote:
>> Hi everyone,
>>
>> This series implements x2APIC mode in userspace local APIC and the
>> RDMSR/WRMSR helper to access x2APIC registers in x2APIC mode. Intel iommu
>> and AMD iommu are adjusted to support x2APIC interrupt remapping. With this
>> series, we can now boot Linux kernel into x2APIC mode with TCG accelerator
>> using either Intel or AMD iommu.
>>
>> Testing to boot my own built Linux 6.3.0-rc2, the kernel successfully boot
>> with enabled x2APIC and can enumerate CPU with APIC ID 257
>>
>> Using Intel IOMMU
>>
>> qemu/build/qemu-system-x86_64 \
>>    -smp 2,maxcpus=260 \
>>    -cpu qemu64,x2apic=on \
>>    -machine q35 \
>>    -device intel-iommu,intremap=on,eim=on \
>>    -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>>    -m 2G \
>>    -kernel $KERNEL_DIR \
>>    -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
>>    -drive file=$IMAGE_DIR,format=raw \
>>    -nographic \
>>    -s
>>
>> Using AMD IOMMU
>>
>> qemu/build/qemu-system-x86_64 \
>>    -smp 2,maxcpus=260 \
>>    -cpu qemu64,x2apic=on \
>>    -machine q35 \
>>    -device amd-iommu,intremap=on,xtsup=on \
>>    -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>>    -m 2G \
>>    -kernel $KERNEL_DIR \
>>    -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
>>    -drive file=$IMAGE_DIR,format=raw \
>>    -nographic \
>>    -s
>>
>> Testing the emulated userspace APIC with kvm-unit-tests, disable test
>> device with this patch
> 
> Seems to break build for windows/amd64
> https://gitlab.com/mstredhat/qemu/-/pipelines/1118886361/failures

The failure is because when CONFIG_AMD_IOMMU=n, amd_iommu.c is not built 
so the linker cannot find the definition of 
amdvi_extended_feature_register (amdvi_extended_feature_register is used 
in acpi-build.c). I create a stub to solve this problem and it passes 
all CI tests. I will squash the following changes into patch 6. What do 
you think about this?

diff --git a/hw/i386/amd_iommu_stub.c b/hw/i386/amd_iommu_stub.c
new file mode 100644
index 0000000000..d62a3732e6
--- /dev/null
+++ b/hw/i386/amd_iommu_stub.c
@@ -0,0 +1,26 @@
+/*
+ * Stubs for AMD IOMMU emulation
+ *
+ * Copyright (C) 2023 Bui Quang Minh <minhquangbui99@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "amd_iommu.h"
+
+uint64_t amdvi_extended_feature_register(AMDVIState *s)
+{
+    return AMDVI_DEFAULT_EXT_FEATURES;
+}
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 369c6bf823..d38637b046 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -9,7 +9,8 @@ i386_ss.add(files(

  i386_ss.add(when: 'CONFIG_X86_IOMMU', if_true: files('x86-iommu.c'),
                                        if_false: files('x86-iommu-stub.c'))
-i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'))
+i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
+                                      if_false: files('amd_iommu_stub.c'))
  i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
  i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('microvm.c', 
'acpi-microvm.c', 'microvm-dt.c'))
  i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))


Thanks,
Quang Minh.

