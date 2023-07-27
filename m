Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A645F765AD2
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 19:55:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP4qs-0002Rc-Qj; Thu, 27 Jul 2023 13:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qP4qq-0002R6-JV; Thu, 27 Jul 2023 13:32:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qP4qo-0001Y2-Ad; Thu, 27 Jul 2023 13:32:36 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36RH9LTN018402; Thu, 27 Jul 2023 17:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=g3a2bhNqgnlAVrlDmF+421W4rV27G9n1h1IOHywgeUE=;
 b=NC+mPVPyc6RJLA8Jt1PXvjEjqHh7QkZ+44qeEGYXV4vU3dlZDdZX/ARiW8yYsFylz+wY
 lUSwkdF8I+hQ9nEWuq/01kGaz6fh1zT8WqvzgOKZMzsloy63Q5KaUkUVeycEzWEiO8aM
 oobyT0ROnMBUx804cVLrAC6bknTygvdrQZ49whbN4hbDnJQuWEqHi25pR53DUicBOgQx
 LzHpZNjvDEiYE/W7xFlxiSiiwCeFm1cX9tGQttO9MKv5Cf0UGgproydfWkC1ay99SIAI
 lqGBbfdLayCefz+zcsq7jHpB4TaHJ5050epxPJjYGIeagqZKGLF26MqqUXDl4TG4BRPr NA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3vqpgmjn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 17:31:29 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36RHUgfK029981;
 Thu, 27 Jul 2023 17:31:28 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3vqpgmjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 17:31:28 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36RGqbAR026189; Thu, 27 Jul 2023 17:31:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0sesfu7p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 17:31:27 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36RHVN8Q19464806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Jul 2023 17:31:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D834B20049;
 Thu, 27 Jul 2023 17:31:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DFF120040;
 Thu, 27 Jul 2023 17:31:23 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.152.224.238])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Jul 2023 17:31:23 +0000 (GMT)
Message-ID: <c77a22b26120b29899c327dd8b95ad2fc2145b62.camel@linux.ibm.com>
Subject: Re: [PATCH v21 03/20] target/s390x/cpu topology: handle STSI(15)
 and build the SYSIB
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, thuth@redhat.com,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 kvm@vger.kernel.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com,
 eblake@redhat.com, armbru@redhat.com, seiden@linux.ibm.com,
 nrb@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
Date: Thu, 27 Jul 2023 19:31:23 +0200
In-Reply-To: <20230630091752.67190-4-pmorel@linux.ibm.com>
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-4-pmorel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QL6wqWdzYRLWpw9JH2I31XfVr9BeNWcS
X-Proofpoint-GUID: WhT_qCi530ioRHnrottdIQzSKjmBtENL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270154
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 2023-06-30 at 11:17 +0200, Pierre Morel wrote:
> On interception of STSI(15.1.x) the System Information Block
> (SYSIB) is built from the list of pre-ordered topology entries.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  MAINTAINERS                      |   1 +
>  qapi/machine-target.json         |  14 ++
>  include/hw/s390x/cpu-topology.h  |  25 +++
>  include/hw/s390x/sclp.h          |   1 +
>  target/s390x/cpu.h               |  76 ++++++++
>  hw/s390x/cpu-topology.c          |   4 +-
>  target/s390x/kvm/kvm.c           |   5 +-
>  target/s390x/kvm/stsi-topology.c | 310 +++++++++++++++++++++++++++++++
>  target/s390x/kvm/meson.build     |   3 +-
>  9 files changed, 436 insertions(+), 3 deletions(-)
>  create mode 100644 target/s390x/kvm/stsi-topology.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0b03ac5a9b..b8d3e8815c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1702,6 +1702,7 @@ M: Pierre Morel <pmorel@linux.ibm.com>
>  S: Supported
>  F: include/hw/s390x/cpu-topology.h
>  F: hw/s390x/cpu-topology.c
> +F: target/s390x/kvm/stsi-topology.c
> =20
>  X86 Machines
>  ------------
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 3362f8dc3f..8ea4834e63 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -361,3 +361,17 @@
>                     'TARGET_MIPS',
>                     'TARGET_LOONGARCH64',
>                     'TARGET_RISCV' ] } }
> +
> +##
> +# @CpuS390Polarization:
> +#
> +# An enumeration of cpu polarization that can be assumed by a virtual
> +# S390 CPU
> +#
> +# Since: 8.1
> +##
> +{ 'enum': 'CpuS390Polarization',
> +  'prefix': 'S390_CPU_POLARIZATION',
> +  'data': [ 'horizontal', 'vertical' ],
> +    'if': { 'all': [ 'TARGET_S390X' , 'CONFIG_KVM' ] }
> +}
> diff --git a/include/hw/s390x/cpu-topology.h b/include/hw/s390x/cpu-topol=
ogy.h
> index 9164ac00a7..193b33a2fc 100644
> --- a/include/hw/s390x/cpu-topology.h
> +++ b/include/hw/s390x/cpu-topology.h
> @@ -15,10 +15,35 @@
>  #include "hw/boards.h"
>  #include "qapi/qapi-types-machine-target.h"
> =20
> +#define S390_TOPOLOGY_CPU_IFL   0x03
> +
> +typedef union s390_topology_id {
> +    uint64_t id;
> +    struct {
> +        uint8_t sentinel;
> +        uint8_t drawer;
> +        uint8_t book;
> +        uint8_t socket;
> +        uint8_t dedicated;
> +        uint8_t entitlement;
> +        uint8_t type;
> +        uint8_t origin;

The order here is not quite right according to the PoP. Type should be
higher, after socket, such that all cpus of the same type in a socket
are stored as a block.
Also entitlement and dedication need to be inverted, e.g such that
dedicated cpus are shown before non dedicated ones.

> +    };
> +} s390_topology_id;
> +

[...]

> +/**
> + * s390_topology_empty_list:
> + *
> + * Clear all entries in the S390Topology list except the sentinel.

The comment is out of date.

> + */
> +static void s390_topology_empty_list(S390TopologyList *topology_list)
> +{
> +    S390TopologyEntry *entry =3D NULL;
> +    S390TopologyEntry *tmp =3D NULL;
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
> + * Create a list head for the Topology entries and initialize it.
> + * Insert the first entry as a sentinelle.
> + *
> + * Emulate STSI 15.1.x, that is, perform all necessary checks and
> + * fill the SYSIB.
> + * In case the topology description is too long to fit into the SYSIB,
> + * set CC=3D3 and abort without writing the SYSIB.
> + */
> +void insert_stsi_15_1_x(S390CPU *cpu, int sel2, uint64_t addr, uint8_t a=
r)
> +{
> +    S390TopologyList topology_list;
> +    S390TopologyEntry *entry;
> +    SysIB sysib =3D {0};
> +    int length;
> +
> +    if (!s390_has_topology() || sel2 < 2 || sel2 > SCLP_READ_SCP_INFO_MN=
EST) {
> +        setcc(cpu, 3);
> +        return;
> +    }
> +
> +    QTAILQ_INIT(&topology_list);
> +    entry =3D g_malloc0(sizeof(S390TopologyEntry));
> +    entry->id.sentinel =3D 0xff;
> +    QTAILQ_INSERT_HEAD(&topology_list, entry, next);
> +
> +    s390_topology_fill_list_sorted(&topology_list);
> +
> +    length =3D setup_stsi(&topology_list, &sysib.sysib_151x, sel2);
> +
> +    if (!length) {
> +        setcc(cpu, 3);
> +        return;
> +    }
> +
> +    sysib.sysib_151x.length =3D cpu_to_be16(length);
> +    s390_cpu_virt_mem_write(cpu, addr, ar, &sysib, length);
> +    setcc(cpu, 0);
> +
> +    s390_topology_empty_list(&topology_list);
> +}
> diff --git a/target/s390x/kvm/meson.build b/target/s390x/kvm/meson.build
> index 37253f75bf..bcf014ba87 100644
> --- a/target/s390x/kvm/meson.build
> +++ b/target/s390x/kvm/meson.build
> @@ -1,6 +1,7 @@
> =20
>  s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
> -  'kvm.c'
> +  'kvm.c',
> +  'stsi-topology.c'
>  ), if_false: files(
>    'stubs.c'
>  ))


