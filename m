Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68260791CC0
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 20:25:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdEEV-0001rU-HH; Mon, 04 Sep 2023 14:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qdEES-0001r3-VF; Mon, 04 Sep 2023 14:23:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qdEEP-0000wI-St; Mon, 04 Sep 2023 14:23:28 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 384I8gEr013463; Mon, 4 Sep 2023 18:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Ok0gLZYYqujhlC4aqM7jJS2czGjHNNoTLRWmiCd681Y=;
 b=LvMCZUQ76nVGGzv46wfG0f7E2jShz3P139Y3mrSS3KuSazRZUtAq/WSq11EVl2m7EAgO
 TvjCdkoyjTG5TijlsmeKS+28D97yzu+ouLUcwbHSgT5FEs2jtTBslXs2tr836CNo2+eG
 8j4CREi3b/r2AEURomNAvWJAesV19Q3i9x68XwAQOUVmlhas6A3zK1X5GpE2f3uZiFpx
 //zBrHqUBHrrCd6OrQHzlaFGBhW5PiNdZG+OP9ult4d+F+AKzEV4Dzg5qmGv7woZTwHF
 PzU80E7YPFm8WixnFdnoPK/7bB+wW4KXhFZlsbYQAbFtalYN3eix8d5N+z6tCyaWBJ6k bw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sw6p91sr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Sep 2023 18:23:10 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 384IHA4K015816;
 Mon, 4 Sep 2023 18:23:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sw6p91sqw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Sep 2023 18:23:09 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 384HjJjA006611; Mon, 4 Sep 2023 18:23:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgvk4exn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Sep 2023 18:23:08 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 384IN5XW43450704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 Sep 2023 18:23:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8522E20043;
 Mon,  4 Sep 2023 18:23:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4092D20040;
 Mon,  4 Sep 2023 18:23:04 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.179.18.181]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 Sep 2023 18:23:04 +0000 (GMT)
Message-ID: <1458dfbaf715087a4a79c7e8c10452096c628797.camel@linux.ibm.com>
Subject: Re: [PATCH v22 03/20] target/s390x/cpu topology: handle STSI(15)
 and build the SYSIB
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>, Eric
 Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael
 Roth <michael.roth@amd.com>
Cc: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Yanan
 Wang <wangyanan55@huawei.com>, "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Cleber Rosa
 <crosa@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 04 Sep 2023 20:23:03 +0200
In-Reply-To: <20230901155812.2696560-4-nsg@linux.ibm.com>
References: <20230901155812.2696560-1-nsg@linux.ibm.com>
 <20230901155812.2696560-4-nsg@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C1Loc5WUjkbX3eHQ_seTHlanZUYXvFal
X-Proofpoint-ORIG-GUID: hWb8RVSOKYj6c6F2WaY32Uki4yCorcaA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_11,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0 mlxlogscore=966
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040162
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 2023-09-01 at 17:57 +0200, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
>=20
> On interception of STSI(15.1.x) the System Information Block
> (SYSIB) is built from the list of pre-ordered topology entries.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

> ---
>  MAINTAINERS                      |   1 +
>  qapi/machine-target.json         |  14 ++
>  include/hw/s390x/cpu-topology.h  |  25 +++
>  include/hw/s390x/sclp.h          |   1 +
>  target/s390x/cpu.h               |  76 ++++++++
>  hw/s390x/cpu-topology.c          |   2 +
>  target/s390x/kvm/kvm.c           |   5 +-
>  target/s390x/kvm/stsi-topology.c | 296 +++++++++++++++++++++++++++++++
>  target/s390x/kvm/meson.build     |   3 +-
>  9 files changed, 421 insertions(+), 2 deletions(-)
>  create mode 100644 target/s390x/kvm/stsi-topology.c

[...]

> +/*
> + * CPU Topology List provided by STSI with fc=3D15 provides a list
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

s/orgin/origin/

> + * CPU address =3D origin * 64 + bit position within the mask
> + *
> + */

[...]

> diff --git a/target/s390x/kvm/stsi-topology.c b/target/s390x/kvm/stsi-top=
ology.c
> new file mode 100644
> index 0000000000..cb78040ea5
> --- /dev/null
> +++ b/target/s390x/kvm/stsi-topology.c

[...]

> +/**
> + * setup_stsi:
> + * sysib: pointer to a SysIB to be filled with SysIB_151x data
> + * level: Nested level specified by the guest

No @ in front of the arguments here.

> + *
> + * Setup the SYSIB for STSI 15.1, the header as well as the description
> + * of the topology.
> + */
> +static int setup_stsi(S390TopologyList *topology_list, SysIB_151x *sysib=
,
> +                      int level)

[...]


