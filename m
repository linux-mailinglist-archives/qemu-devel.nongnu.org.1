Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 239EC793FB4
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:55:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtuq-0004aP-RY; Wed, 06 Sep 2023 10:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qdtul-0004Zm-UP
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qdtui-0000kp-HV
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694012026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A2ij4U3LGxfGgKaPn566F4TR/Sa72o3vAxqriT+B53k=;
 b=YWSFV7hhNddCY7oghPhrjCKyvROx713iTXERV4SLSoZYYVnzt9MGqb7dvRkvWZ2RSci2UD
 /gWbmCnRn22dlO5BNggQw7VyGOh+f8UVdxi0THXpaCvRdyBa/0rQ2KN97Ejz2b9Q9liBK+
 gbF8M7mElbaEFn0ngFtj7F8I3G//XdA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-erAVlviuOuaHLmP4bkIk3A-1; Wed, 06 Sep 2023 10:53:44 -0400
X-MC-Unique: erAVlviuOuaHLmP4bkIk3A-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-64f39876f01so40933686d6.2
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 07:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694012024; x=1694616824;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A2ij4U3LGxfGgKaPn566F4TR/Sa72o3vAxqriT+B53k=;
 b=gi4XrYktH9hufmkGHc3B/v420JSG/lJdEIWIpy1wuWiN32XXZqLiSCiNzvz55xpeXu
 BYTuFGsXGrYm6j1AHvoYeo+ygfod78IJ34r3uzJd/+QY6zGFNfmyVT9nU2HTxWeY/ViA
 /8KE4Z38SasuPgY1UedObU5LyxBUOFdplG3jQ7NjA05fthzEMBVsFC5nqT2U74t4VeOE
 52P5lFpBCh1YQpqZ8h44KoWwC9XYMnqO77XT++HdA5IFHKCTaxIwwsT0AnMhPGrcFc9Q
 L7hEElglQrDTYUlwdW5EzljFkNNbFF3CQHl17l30fZ5+EFCGE7y51mAOoHWbOwg87PaZ
 RWEA==
X-Gm-Message-State: AOJu0YzexmvSOuQNhUj0w6GFc+Wvbwz4OzhXTx9/RQgZOELAAfyY6je4
 JZV5esWuFINnj9qGxbsBQn3VCk3Owm6fckggF7W0sSl6eS8b2Vdwgql6RYE/qD3sD+gZ8I9Yhef
 GdUWql+6T6MAFKmw=
X-Received: by 2002:a0c:f508:0:b0:651:6349:fa7 with SMTP id
 j8-20020a0cf508000000b0065163490fa7mr14327619qvm.25.1694012023879; 
 Wed, 06 Sep 2023 07:53:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfxX2QPmBr7HHswyYz6khnCh8nPaSKo8QbOowrt0t3ZrsIWjZ0DtZa/4SHiSGekpW6j3HvCA==
X-Received: by 2002:a0c:f508:0:b0:651:6349:fa7 with SMTP id
 j8-20020a0cf508000000b0065163490fa7mr14327591qvm.25.1694012023463; 
 Wed, 06 Sep 2023 07:53:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 k4-20020a0cf284000000b0065160a2c8f0sm5492906qvl.138.2023.09.06.07.53.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 07:53:42 -0700 (PDT)
Message-ID: <1b02119a-fdd8-d91c-f765-800d2fd4f269@redhat.com>
Date: Wed, 6 Sep 2023 16:53:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v22 03/20] target/s390x/cpu topology: handle STSI(15) and
 build the SYSIB
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
References: <20230901155812.2696560-1-nsg@linux.ibm.com>
 <20230901155812.2696560-4-nsg@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20230901155812.2696560-4-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello Nina,

On 9/1/23 17:57, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> On interception of STSI(15.1.x) the System Information Block
> (SYSIB) is built from the list of pre-ordered topology entries.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   MAINTAINERS                      |   1 +
>   qapi/machine-target.json         |  14 ++
>   include/hw/s390x/cpu-topology.h  |  25 +++
>   include/hw/s390x/sclp.h          |   1 +
>   target/s390x/cpu.h               |  76 ++++++++
>   hw/s390x/cpu-topology.c          |   2 +
>   target/s390x/kvm/kvm.c           |   5 +-
>   target/s390x/kvm/stsi-topology.c | 296 +++++++++++++++++++++++++++++++
>   target/s390x/kvm/meson.build     |   3 +-
>   9 files changed, 421 insertions(+), 2 deletions(-)
>   create mode 100644 target/s390x/kvm/stsi-topology.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b10b83583f..692ce9f121 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1700,6 +1700,7 @@ M: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>   S: Supported
>   F: include/hw/s390x/cpu-topology.h
>   F: hw/s390x/cpu-topology.c
> +F: target/s390x/kvm/stsi-topology.c
>   
>   X86 Machines
>   ------------
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index f0a6b72414..275234a20f 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -361,3 +361,17 @@
>                      'TARGET_MIPS',
>                      'TARGET_LOONGARCH64',
>                      'TARGET_RISCV' ] } }
> +
> +##
> +# @CpuS390Polarization:
> +#
> +# An enumeration of cpu polarization that can be assumed by a virtual
> +# S390 CPU
> +#
> +# Since: 8.2
> +##
> +{ 'enum': 'CpuS390Polarization',
> +  'prefix': 'S390_CPU_POLARIZATION',
> +  'data': [ 'horizontal', 'vertical' ],

Since :

> +    'if': { 'all': [ 'TARGET_S390X' , 'CONFIG_KVM' ] }
> +}
> diff --git a/include/hw/s390x/cpu-topology.h b/include/hw/s390x/cpu-topology.h
> index 97b0af2795..fc15acf297 100644
> --- a/include/hw/s390x/cpu-topology.h
> +++ b/include/hw/s390x/cpu-topology.h
> @@ -15,10 +15,35 @@
>   #include "hw/boards.h"
>   #include "qapi/qapi-types-machine-target.h"
>   
> +#define S390_TOPOLOGY_CPU_IFL   0x03
> +
> +typedef union s390_topology_id {
> +    uint64_t id;
> +    struct {
> +        uint8_t _reserved0;
> +        uint8_t drawer;
> +        uint8_t book;
> +        uint8_t socket;
> +        uint8_t type;
> +        uint8_t inv_polarization;
> +        uint8_t not_dedicated;
> +        uint8_t origin;
> +    };
> +} s390_topology_id;
> +
> +typedef struct S390TopologyEntry {
> +    QTAILQ_ENTRY(S390TopologyEntry) next;
> +    s390_topology_id id;
> +    uint64_t mask;
> +} S390TopologyEntry;
> +
>   typedef struct S390Topology {
>       uint8_t *cores_per_socket;
> +    CpuS390Polarization polarization;

This won't compile for non s390x.
>   } S390Topology;
>   
> +typedef QTAILQ_HEAD(, S390TopologyEntry) S390TopologyList;
> +
>   #ifdef CONFIG_KVM
>   bool s390_has_topology(void);
>   void s390_topology_setup_cpu(MachineState *ms, S390CPU *cpu, Error **errp);
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index cf1f2efae2..c49051e17e 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -112,6 +112,7 @@ typedef struct CPUEntry {
>   } QEMU_PACKED CPUEntry;
>   
>   #define SCLP_READ_SCP_INFO_FIXED_CPU_OFFSET     128
> +#define SCLP_READ_SCP_INFO_MNEST                2
>   typedef struct ReadInfo {
>       SCCBHeader h;
>       uint16_t rnmax;
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 7ebd5e05b6..b8a0c02714 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -569,6 +569,29 @@ typedef struct SysIB_322 {
>   } SysIB_322;
>   QEMU_BUILD_BUG_ON(sizeof(SysIB_322) != 4096);
>   
> +/*
> + * Topology Magnitude fields (MAG) indicates the maximum number of
> + * topology list entries (TLE) at the corresponding nesting level.
> + */
> +#define S390_TOPOLOGY_MAG  6
> +#define S390_TOPOLOGY_MAG6 0
> +#define S390_TOPOLOGY_MAG5 1
> +#define S390_TOPOLOGY_MAG4 2
> +#define S390_TOPOLOGY_MAG3 3
> +#define S390_TOPOLOGY_MAG2 4
> +#define S390_TOPOLOGY_MAG1 5
> +/* Configuration topology */
> +typedef struct SysIB_151x {
> +    uint8_t  reserved0[2];
> +    uint16_t length;
> +    uint8_t  mag[S390_TOPOLOGY_MAG];
> +    uint8_t  reserved1;
> +    uint8_t  mnest;
> +    uint32_t reserved2;
> +    char tle[];
> +} SysIB_151x;
> +QEMU_BUILD_BUG_ON(sizeof(SysIB_151x) != 16);
> +
>   typedef union SysIB {
>       SysIB_111 sysib_111;
>       SysIB_121 sysib_121;
> @@ -576,9 +599,62 @@ typedef union SysIB {
>       SysIB_221 sysib_221;
>       SysIB_222 sysib_222;
>       SysIB_322 sysib_322;
> +    SysIB_151x sysib_151x;
>   } SysIB;
>   QEMU_BUILD_BUG_ON(sizeof(SysIB) != 4096);
>   
> +/*
> + * CPU Topology List provided by STSI with fc=15 provides a list
> + * of two different Topology List Entries (TLE) types to specify
> + * the topology hierarchy.
> + *
> + * - Container Topology List Entry
> + *   Defines a container to contain other Topology List Entries
> + *   of any type, nested containers or CPU.
> + * - CPU Topology List Entry
> + *   Specifies the CPUs position, type, entitlement and polarization
> + *   of the CPUs contained in the last Container TLE.
> + *
> + * There can be theoretically up to five levels of containers, QEMU
> + * uses only three levels, the drawer's, book's and socket's level.
> + *
> + * A container with a nesting level (NL) greater than 1 can only
> + * contain another container of nesting level NL-1.
> + *
> + * A container of nesting level 1 (socket), contains as many CPU TLE
> + * as needed to describe the position and qualities of all CPUs inside
> + * the container.
> + * The qualities of a CPU are polarization, entitlement and type.
> + *
> + * The CPU TLE defines the position of the CPUs of identical qualities
> + * using a 64bits mask which first bit has its offset defined by
> + * the CPU address orgin field of the CPU TLE like in:
> + * CPU address = origin * 64 + bit position within the mask
> + *
> + */
> +/* Container type Topology List Entry */
> +typedef struct SYSIBContainerListEntry {
> +        uint8_t nl;
> +        uint8_t reserved[6];
> +        uint8_t id;
> +} SYSIBContainerListEntry;
> +QEMU_BUILD_BUG_ON(sizeof(SYSIBContainerListEntry) != 8);
> +
> +/* CPU type Topology List Entry */
> +typedef struct SysIBCPUListEntry {
> +        uint8_t nl;
> +        uint8_t reserved0[3];
> +#define SYSIB_TLE_POLARITY_MASK 0x03
> +#define SYSIB_TLE_DEDICATED     0x04
> +        uint8_t flags;
> +        uint8_t type;
> +        uint16_t origin;
> +        uint64_t mask;
> +} SysIBCPUListEntry;
> +QEMU_BUILD_BUG_ON(sizeof(SysIBCPUListEntry) != 16);
> +
> +void insert_stsi_15_1_x(S390CPU *cpu, int sel2, uint64_t addr, uint8_t ar, uintptr_t ra);
> +
>   /* MMU defines */
>   #define ASCE_ORIGIN           (~0xfffULL) /* segment table origin             */
>   #define ASCE_SUBSPACE         0x200       /* subspace group control           */
> diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
> index 06b60ebce4..5971804680 100644
> --- a/hw/s390x/cpu-topology.c
> +++ b/hw/s390x/cpu-topology.c
> @@ -28,10 +28,12 @@
>    * s390_topology is used to keep the topology information.
>    * .cores_per_socket: tracks information on the count of cores
>    *                    per socket.
> + * .polarization: tracks machine polarization.
>    */
>   S390Topology s390_topology = {
>       /* will be initialized after the CPU model is realized */
>       .cores_per_socket = NULL,
> +    .polarization = S390_CPU_POLARIZATION_HORIZONTAL,
>   };
>   
>   /**
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index 852fbd0df7..56b31b8aae 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -1911,9 +1911,12 @@ static int handle_stsi(S390CPU *cpu)
>           if (run->s390_stsi.sel1 != 2 || run->s390_stsi.sel2 != 2) {
>               return 0;
>           }
> -        /* Only sysib 3.2.2 needs post-handling for now. */
>           insert_stsi_3_2_2(cpu, run->s390_stsi.addr, run->s390_stsi.ar);
>           return 0;
> +    case 15:
> +        insert_stsi_15_1_x(cpu, run->s390_stsi.sel2, run->s390_stsi.addr,
> +                           run->s390_stsi.ar, RA_IGNORED);
> +        return 0;
>       default:
>           return 0;
>       }
> diff --git a/target/s390x/kvm/stsi-topology.c b/target/s390x/kvm/stsi-topology.c
> new file mode 100644
> index 0000000000..cb78040ea5
> --- /dev/null
> +++ b/target/s390x/kvm/stsi-topology.c
> @@ -0,0 +1,296 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * QEMU S390x CPU Topology
> + *
> + * Copyright IBM Corp. 2022, 2023
> + * Author(s): Pierre Morel <pmorel@linux.ibm.com>
> + *
> + */
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "hw/s390x/sclp.h"
> +#include "hw/s390x/cpu-topology.h"
> +
> +QEMU_BUILD_BUG_ON(S390_CPU_ENTITLEMENT_LOW != 1);
> +QEMU_BUILD_BUG_ON(S390_CPU_ENTITLEMENT_MEDIUM != 2);
> +QEMU_BUILD_BUG_ON(S390_CPU_ENTITLEMENT_HIGH != 3);
> +
> +/**
> + * fill_container:
> + * @p: The address of the container TLE to fill
> + * @level: The level of nesting for this container
> + * @id: The container receives a unique ID inside its own container
> + *
> + * Returns the next free TLE entry.
> + */
> +static char *fill_container(char *p, int level, int id)
> +{
> +    SYSIBContainerListEntry *tle = (SYSIBContainerListEntry *)p;
> +
> +    tle->nl = level;
> +    tle->id = id;
> +    return p + sizeof(*tle);
> +}
> +
> +/**
> + * fill_tle_cpu:
> + * @p: The address of the CPU TLE to fill
> + * @entry: a pointer to the S390TopologyEntry defining this
> + *         CPU container.
> + *
> + * Returns the next free TLE entry.
> + */
> +static char *fill_tle_cpu(char *p, S390TopologyEntry *entry)
> +{
> +    SysIBCPUListEntry *tle = (SysIBCPUListEntry *)p;
> +    s390_topology_id topology_id = entry->id;
> +
> +    tle->nl = 0;
> +    tle->flags = 3 - topology_id.inv_polarization;
> +    if (!topology_id.not_dedicated) {
> +        tle->flags |= SYSIB_TLE_DEDICATED;
> +    }
> +    tle->type = topology_id.type;
> +    tle->origin = cpu_to_be16(topology_id.origin * 64);
> +    tle->mask = cpu_to_be64(entry->mask);
> +    return p + sizeof(*tle);
> +}
> +
> +/*
> + * Macro to check that the size of data after increment
> + * will not get bigger than the size of the SysIB.
> + */
> +#define SYSIB_GUARD(data, x) do {       \
> +        data += x;                      \
> +        if (data > sizeof(SysIB)) {     \
> +            return 0;                   \
> +        }                               \
> +    } while (0)
> +
> +/**
> + * stsi_topology_fill_sysib:
> + * @p: A pointer to the position of the first TLE
> + * @level: The nested level wanted by the guest
> + *
> + * Fill the SYSIB with the topology information as described in
> + * the PoP, nesting containers as appropriate, with the maximum
> + * nesting limited by @level.
> + *
> + * Return value:
> + * On success: the size of the SysIB_15x after being filled with TLE.
> + * On error: 0 in the case we would overrun the end of the SysIB.
> + */
> +static int stsi_topology_fill_sysib(S390TopologyList *topology_list,
> +                                    char *p, int level)
> +{
> +    S390TopologyEntry *entry;
> +    int last_drawer = -1;
> +    int last_book = -1;
> +    int last_socket = -1;
> +    int drawer_id = 0;
> +    int book_id = 0;
> +    int socket_id = 0;
> +    int n = sizeof(SysIB_151x);
> +
> +    QTAILQ_FOREACH(entry, topology_list, next) {
> +        bool drawer_change = last_drawer != entry->id.drawer;
> +        bool book_change = drawer_change || last_book != entry->id.book;
> +        bool socket_change = book_change || last_socket != entry->id.socket;
> +
> +        if (level > 3 && drawer_change) {
> +            SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
> +            p = fill_container(p, 3, drawer_id++);
> +            book_id = 0;
> +        }
> +        if (level > 2 && book_change) {
> +            SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
> +            p = fill_container(p, 2, book_id++);
> +            socket_id = 0;
> +        }
> +        if (socket_change) {
> +            SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
> +            p = fill_container(p, 1, socket_id++);
> +        }
> +
> +        SYSIB_GUARD(n, sizeof(SysIBCPUListEntry));
> +        p = fill_tle_cpu(p, entry);
> +        last_drawer = entry->id.drawer;
> +        last_book = entry->id.book;
> +        last_socket = entry->id.socket;
> +    }
> +
> +    return n;
> +}
> +
> +/**
> + * setup_stsi:
> + * sysib: pointer to a SysIB to be filled with SysIB_151x data
> + * level: Nested level specified by the guest
> + *
> + * Setup the SYSIB for STSI 15.1, the header as well as the description
> + * of the topology.
> + */
> +static int setup_stsi(S390TopologyList *topology_list, SysIB_151x *sysib,
> +                      int level)
> +{
> +    sysib->mnest = level;
> +    switch (level) {
> +    case 4:
> +        sysib->mag[S390_TOPOLOGY_MAG4] = current_machine->smp.drawers;
> +        sysib->mag[S390_TOPOLOGY_MAG3] = current_machine->smp.books;
> +        sysib->mag[S390_TOPOLOGY_MAG2] = current_machine->smp.sockets;
> +        sysib->mag[S390_TOPOLOGY_MAG1] = current_machine->smp.cores;
> +        break;
> +    case 3:
> +        sysib->mag[S390_TOPOLOGY_MAG3] = current_machine->smp.drawers *
> +                                         current_machine->smp.books;
> +        sysib->mag[S390_TOPOLOGY_MAG2] = current_machine->smp.sockets;
> +        sysib->mag[S390_TOPOLOGY_MAG1] = current_machine->smp.cores;
> +        break;
> +    case 2:
> +        sysib->mag[S390_TOPOLOGY_MAG2] = current_machine->smp.drawers *
> +                                         current_machine->smp.books *
> +                                         current_machine->smp.sockets;
> +        sysib->mag[S390_TOPOLOGY_MAG1] = current_machine->smp.cores;
> +        break;
> +    }
> +
> +    return stsi_topology_fill_sysib(topology_list, sysib->tle, level);
> +}
> +
> +/**
> + * s390_topology_add_cpu_to_entry:
> + * @entry: Topology entry to setup
> + * @cpu: the S390CPU to add
> + *
> + * Set the core bit inside the topology mask.
> + */
> +static void s390_topology_add_cpu_to_entry(S390TopologyEntry *entry,
> +                                           S390CPU *cpu)
> +{
> +    set_bit(63 - (cpu->env.core_id % 64), &entry->mask);
> +}
> +
> +/**
> + * s390_topology_from_cpu:
> + * @cpu: S390CPU to calculate the topology id
> + *
> + * Initialize the topology id from the CPU environment.
> + */
> +static s390_topology_id s390_topology_from_cpu(S390CPU *cpu)
> +{
> +    s390_topology_id topology_id = {0};
> +
> +    topology_id.drawer = cpu->env.drawer_id;
> +    topology_id.book = cpu->env.book_id;
> +    topology_id.socket = cpu->env.socket_id;
> +    topology_id.type = S390_TOPOLOGY_CPU_IFL;
> +    topology_id.not_dedicated = !cpu->env.dedicated;
> +
> +    topology_id.inv_polarization = 3;
> +    if (s390_topology.polarization == S390_CPU_POLARIZATION_VERTICAL) {
> +        topology_id.inv_polarization -= cpu->env.entitlement;
> +    }
> +
> +    topology_id.origin = cpu->env.core_id / 64;
> +
> +    return topology_id;
> +}
> +
> +/**
> + * s390_topology_fill_list_sorted:
> + *
> + * Loop over all CPU and insert it at the right place
> + * inside the TLE entry list.
> + * Fill the S390Topology list with entries according to the order
> + * specified by the PoP.
> + */
> +static void s390_topology_fill_list_sorted(S390TopologyList *topology_list)
> +{
> +    CPUState *cs;
> +    S390TopologyEntry sentinel;
> +
> +    QTAILQ_INIT(topology_list);
> +
> +    sentinel.id.id = cpu_to_be64(UINT64_MAX);
> +    QTAILQ_INSERT_HEAD(topology_list, &sentinel, next);
> +
> +    CPU_FOREACH(cs) {
> +        s390_topology_id id = s390_topology_from_cpu(S390_CPU(cs));
> +        S390TopologyEntry *entry, *tmp;



Please add :

   S390TopologyEntry *entry = NULL, *tmp;

It fixes a compile breakage in :

   ../target/s390x/kvm/stsi-topology.c: In function ‘insert_stsi_15_1_x’:
   ../include/qemu/bitops.h:41:9: error: ‘entry’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
        *p  |= mask;
        ~~~~^~~~~~~
   ../target/s390x/kvm/stsi-topology.c:220:28: note: ‘entry’ was declared here
            S390TopologyEntry *entry, *tmp;
                               ^~~~~
   cc1: all warnings being treated as errors


Thanks,

C.

> +
> +        QTAILQ_FOREACH(tmp, topology_list, next) {
> +            if (id.id == tmp->id.id) {
> +                entry = tmp;
> +                break;
> +            } else if (be64_to_cpu(id.id) < be64_to_cpu(tmp->id.id)) {
> +                entry = g_malloc0(sizeof(*entry));
> +                entry->id.id = id.id;
> +                QTAILQ_INSERT_BEFORE(tmp, entry, next);
> +                break;
> +            }
> +        }
> +        s390_topology_add_cpu_to_entry(entry, S390_CPU(cs));
> +    }
> +
> +    QTAILQ_REMOVE(topology_list, &sentinel, next);
> +}
> +
> +/**
> + * s390_topology_empty_list:
> + *
> + * Clear all entries in the S390Topology list.
> + */
> +static void s390_topology_empty_list(S390TopologyList *topology_list)
> +{
> +    S390TopologyEntry *entry = NULL;
> +    S390TopologyEntry *tmp = NULL;
> +
> +    QTAILQ_FOREACH_SAFE(entry, topology_list, next, tmp) {
> +        QTAILQ_REMOVE(topology_list, entry, next);
> +        g_free(entry);
> +    }
> +}
> +
> +/**
> + * insert_stsi_15_1_x:
> + * cpu: the CPU doing the call for which we set CC
> + * sel2: the selector 2, containing the nested level
> + * addr: Guest logical address of the guest SysIB
> + * ar: the access register number
> + *
> + * Emulate STSI 15.1.x, that is, perform all necessary checks and
> + * fill the SYSIB.
> + * In case the topology description is too long to fit into the SYSIB,
> + * set CC=3 and abort without writing the SYSIB.
> + */
> +void insert_stsi_15_1_x(S390CPU *cpu, int sel2, uint64_t addr, uint8_t ar, uintptr_t ra)
> +{
> +    S390TopologyList topology_list;
> +    SysIB sysib = {0};
> +    int length;
> +
> +    if (!s390_has_topology() || sel2 < 2 || sel2 > SCLP_READ_SCP_INFO_MNEST) {
> +        setcc(cpu, 3);
> +        return;
> +    }
> +
> +    s390_topology_fill_list_sorted(&topology_list);
> +
> +    length = setup_stsi(&topology_list, &sysib.sysib_151x, sel2);
> +
> +    if (!length) {
> +        s390_topology_empty_list(&topology_list);
> +        setcc(cpu, 3);
> +        return;
> +    }
> +
> +    sysib.sysib_151x.length = cpu_to_be16(length);
> +    if (!s390_cpu_virt_mem_write(cpu, addr, ar, &sysib, length)) {
> +        setcc(cpu, 0);
> +    } else {
> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
> +    }
> +
> +    s390_topology_empty_list(&topology_list);
> +}
> diff --git a/target/s390x/kvm/meson.build b/target/s390x/kvm/meson.build
> index d6aca590ae..588a9aa737 100644
> --- a/target/s390x/kvm/meson.build
> +++ b/target/s390x/kvm/meson.build
> @@ -1,7 +1,8 @@
>   
>   s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
>     'pv.c',
> -  'kvm.c'
> +  'kvm.c',
> +  'stsi-topology.c'
>   ), if_false: files(
>     'stubs.c'
>   ))


