Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DF67D82D8
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 14:42:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvzg1-0000Pt-2Q; Thu, 26 Oct 2023 08:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qvzfz-0000Ou-7t
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 08:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qvzfx-0003ho-AC
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 08:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698324083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rm7xHyPU7UrFKbHExCp3hETRS4Uo99zPiXo0roR67+8=;
 b=QFjyIE5GZRM5Z1LrTDHmmsdFnHkn5esDKVa86igyjjkVFwytOBkpnrea9FAZcHHOJH+xX7
 5cRO1Tgcg42g0PkHQ12stZlNQQ5HTBEB5H2Mo+x5EaTShgvpjcF0w91jTs5UH7TMoT7+qk
 QM558qFri/9PGDkC7Xk2dWB4Px74FWY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-zdYIW5_GPyKXdkfuxbWH4A-1; Thu, 26 Oct 2023 08:41:18 -0400
X-MC-Unique: zdYIW5_GPyKXdkfuxbWH4A-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9ae57d8b502so57750366b.2
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 05:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698324066; x=1698928866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rm7xHyPU7UrFKbHExCp3hETRS4Uo99zPiXo0roR67+8=;
 b=hAtY438/c8Ayc0LxheLstW8Cad4Jy+clFotgDvUE6baR8L6+e7fYrKLizZwBoCvJ6d
 DHjj8VxeACKr4oQ7zp27LfFZVe99x587INar1ot7rS5mWBpUlqwzXoGZ5bdWZXg0ho/M
 pAYC5UZdQkuHadJlPh5YkEmrrNyuJLE7k7Tecu+aHINHLRV/0px9Tjh4ECyIY5j9Bq/l
 Y2kt1GjyDxgPRIC+K/JzdmxAZDmo+M3jjib/JCQmSDbZEyAcRUXCmCcaP1aBri1tIbr/
 YNQKbXfCxYv/TmMSIDwpfx3VByeA6EqJ8jQZwBescgeXnZ6QtKt3D+vTKfCsr0u3ob4X
 oXNw==
X-Gm-Message-State: AOJu0YzzgxWtJJ3KinFR4CbJTOk+RVfzkyEqbHUwqDNA4ihqg1F3Hc67
 YdQ5J+voxNMuTH0Yu6/GxglIF3hKE0gwzTiiDg00Gii+C63dd4QH5Ba6WVsxYetWyktdOp7N1X0
 j5m7TF9rHXKlFZoA=
X-Received: by 2002:a17:907:60cd:b0:9be:466c:1824 with SMTP id
 hv13-20020a17090760cd00b009be466c1824mr13930129ejc.11.1698324066277; 
 Thu, 26 Oct 2023 05:41:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd1kNJ+8iILLv3/Fkd8Bgd8X+xynvrLJFevhzZvdzUfnWFG5M+ino9hXRwPWzgdclmMTwWYQ==
X-Received: by 2002:a17:907:60cd:b0:9be:466c:1824 with SMTP id
 hv13-20020a17090760cd00b009be466c1824mr13930110ejc.11.1698324065904; 
 Thu, 26 Oct 2023 05:41:05 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 lt13-20020a170906fa8d00b009c4cb1553edsm11620259ejb.95.2023.10.26.05.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 05:41:04 -0700 (PDT)
Date: Thu, 26 Oct 2023 14:41:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <maz@kernel.org>,
 <jean-philippe@linaro.org>, <jonathan.cameron@huawei.com>,
 <lpieralisi@kernel.org>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <andrew.jones@linux.dev>,
 <david@redhat.com>, <philmd@linaro.org>, <eric.auger@redhat.com>,
 <oliver.upton@linux.dev>, <pbonzini@redhat.com>, <mst@redhat.com>,
 <will@kernel.org>, <gshan@redhat.com>, <rafael@kernel.org>,
 <alex.bennee@linaro.org>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <linuxarm@huawei.com>
Subject: Re: [PATCH V6 0/9] Add architecture agnostic code to support vCPU
 Hotplug
Message-ID: <20231026144103.565a9566@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231013105129.25648-1-salil.mehta@huawei.com>
References: <20231013105129.25648-1-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 13 Oct 2023 11:51:20 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> Virtual CPU hotplug support is being added across various architectures[1=
][3].
> This series adds various code bits common across all architectures:
>=20
> 1. vCPU creation and Parking code refactor [Patch 1]
> 2. Update ACPI GED framework to support vCPU Hotplug [Patch 4,6,7]
> 3. ACPI CPUs AML code change [Patch 5]
> 4. Helper functions to support unrealization of CPU objects [Patch 8,9]
> 5. Misc [Patch 2,3]

Thanks Salil!

Overall series looks good to me (modulo some points, I'd like to be address=
ed)
I'll do some testing and follow with per patch review tomorrow.=20

> Repository:
>=20
> [*] https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2.commo=
n.v6
>=20
>=20
> Revision History:
>=20
> Patch-set  V5 -> V6
> 1. Addressed Gavin Shan's comments
>    - Fixed the assert() ranges of address spaces
>    - Rebased the patch-set to latest changes in the qemu.git
>    - Added Reviewed-by tags for patches {8,9}
> 2. Addressed Jonathan Cameron's comments
>    - Updated commit-log for [Patch V5 1/9] with mention of trace events
>    - Added Reviewed-by tags for patches {1,5}
> 3. Added Tested-by tags from Xianglai Li
> 4. Fixed checkpatch.pl error "Qemu -> QEMU" in [Patch V5 1/9]=20
> Link: https://lore.kernel.org/qemu-devel/20231011194355.15628-1-salil.meh=
ta@huawei.com/
>=20
> Patch-set  V4 -> V5
> 1. Addressed Gavin Shan's comments
>    - Fixed the trace events print string for kvm_{create,get,park,destroy=
}_vcpu
>    - Added Reviewed-by tag for patch {1}
> 2. Added Shaoqin Huang's Reviewed-by tags for Patches {2,3}
> 3. Added Tested-by Tag from Vishnu Pajjuri to the patch-set
> 4. Dropped the ARM specific [Patch V4 10/10]
> Link: https://lore.kernel.org/qemu-devel/20231009203601.17584-1-salil.meh=
ta@huawei.com/
>=20
> Patch-set  V3 -> V4
> 1. Addressed David Hilderbrand's comments
>    - Fixed the wrong doc comment of kvm_park_vcpu API prototype
>    - Added Reviewed-by tags for patches {2,4}
> Link: https://lore.kernel.org/qemu-devel/20231009112812.10612-1-salil.meh=
ta@huawei.com/
>=20
> Patch-set  V2 -> V3
> 1. Addressed Jonathan Cameron's comments
>    - Fixed 'vcpu-id' type wrongly changed from 'unsigned long' to 'intege=
r'
>    - Removed unnecessary use of variable 'vcpu_id' in kvm_park_vcpu
>    - Updated [Patch V2 3/10] commit-log with details of ACPI_CPU_SCAN_MET=
HOD macro
>    - Updated [Patch V2 5/10] commit-log with details of conditional event=
 handler method
>    - Added Reviewed-by tags for patches {2,3,4,6,7}
> 2. Addressed Gavin Shan's comments
>    - Remove unnecessary use of variable 'vcpu_id' in kvm_par_vcpu
>    - Fixed return value in kvm_get_vcpu from -1 to -ENOENT
>    - Reset the value of 'gdb_num_g_regs' in gdb_unregister_coprocessor_all
>    - Fixed the kvm_{create,park}_vcpu prototypes docs
>    - Added Reviewed-by tags for patches {2,3,4,5,6,7,9,10}
> 3. Addressed one earlier missed comment by Alex Benn=C3=A9e in RFC V1
>    - Added traces instead of DPRINTF in the newly added and some existing=
 functions
> Link: https://lore.kernel.org/qemu-devel/20230930001933.2660-1-salil.meht=
a@huawei.com/
>=20
> Patch-set V1 -> V2
> 1. Addressed Alex Benn=C3=A9e's comments
>    - Refactored the kvm_create_vcpu logic to get rid of goto
>    - Added the docs for kvm_{create,park}_vcpu prototypes
>    - Splitted the gdbstub and AddressSpace destruction change into separa=
te patches
>    - Added Reviewed-by tags for patches {2,10}
> Link: https://lore.kernel.org/qemu-devel/20230929124304.13672-1-salil.meh=
ta@huawei.com/
>=20
> References:
>=20
> [1] https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta=
@huawei.com/
> [2] https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/
> [3] https://lore.kernel.org/qemu-devel/cover.1695697701.git.lixianglai@lo=
ongson.cn/
>=20
>=20
> Salil Mehta (9):
>   accel/kvm: Extract common KVM vCPU {creation,parking} code
>   hw/acpi: Move CPU ctrl-dev MMIO region len macro to common header file
>   hw/acpi: Add ACPI CPU hotplug init stub
>   hw/acpi: Init GED framework with CPU hotplug events
>   hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
>   hw/acpi: Update GED _EVT method AML with CPU scan
>   hw/acpi: Update ACPI GED framework to support vCPU Hotplug
>   physmem: Add helper function to destroy CPU AddressSpace
>   gdbstub: Add helper function to unregister GDB register space
>=20
>  accel/kvm/kvm-all.c                    | 64 ++++++++++++++++++++------
>  accel/kvm/trace-events                 |  4 ++
>  gdbstub/gdbstub.c                      | 12 +++++
>  hw/acpi/acpi-cpu-hotplug-stub.c        |  6 +++
>  hw/acpi/cpu.c                          | 27 +++++++----
>  hw/acpi/generic_event_device.c         | 22 +++++++++
>  hw/i386/acpi-build.c                   |  3 +-
>  include/exec/cpu-common.h              |  8 ++++
>  include/exec/gdbstub.h                 |  5 ++
>  include/hw/acpi/cpu.h                  |  5 +-
>  include/hw/acpi/cpu_hotplug.h          |  4 ++
>  include/hw/acpi/generic_event_device.h |  5 ++
>  include/hw/core/cpu.h                  |  1 +
>  include/sysemu/kvm.h                   | 16 +++++++
>  system/physmem.c                       | 29 ++++++++++++
>  15 files changed, 184 insertions(+), 27 deletions(-)
>=20


