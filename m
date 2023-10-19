Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF0C7D0110
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 19:59:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXHW-0000dy-6l; Thu, 19 Oct 2023 13:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qtXHT-0000da-Fq; Thu, 19 Oct 2023 13:57:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qtXHR-0001Pp-Av; Thu, 19 Oct 2023 13:57:59 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JHtYla006435; Thu, 19 Oct 2023 17:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=E/DIS1uampXHFe66MjXnmkpMkRQERnxg1SM+gciCpeM=;
 b=GPHNkzFnyt5U35HUeq13nWCtuKvSNuFZLkmKoptldGPl1wQEVPvGTCcRzeRI5fdMLcQj
 5qbu0ABiJcPPP3G6BcnC5F/aWWl29+W93HLLNjSf4ECfo8WYsyf70bytuQYjZQRcgUH0
 KTrKkVWwuwAkitv6wJ8hQJtdpWN9KruROyFN6jx2v8CUwuRWYflFJMYtCtPWL0WoSKdb
 LGcBfYBviDYQ/hgCdD9fiHCrZZT9z+uK3jt0lLEgrnk6bpFGH4AhUvV4s9ttfWHVRBPk
 UR1nmYS2qYEEe+3I5aCL22b0fDSbjVLUUsEb4VMb13pahq+rvdXnSwspICHFy2ZKZtB7 YA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu95qgb0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 17:57:54 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JHuhV5017730;
 Thu, 19 Oct 2023 17:57:54 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu95qgays-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 17:57:54 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JFxaCw026875; Thu, 19 Oct 2023 17:57:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr5astu3a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 17:57:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39JHvpBh55837038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 17:57:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6FD720043;
 Thu, 19 Oct 2023 17:57:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7167320040;
 Thu, 19 Oct 2023 17:57:51 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.84.173]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Oct 2023 17:57:51 +0000 (GMT)
Message-ID: <05b66fe93ec995d48b8c8fbfbd5f9c6098199851.camel@linux.ibm.com>
Subject: Re: [PULL 03/25] s390x/cpu topology: add topology entries on CPU
 hotplug
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org
Date: Thu, 19 Oct 2023 19:57:51 +0200
In-Reply-To: <20231018130716.286638-4-thuth@redhat.com>
References: <20231018130716.286638-1-thuth@redhat.com>
 <20231018130716.286638-4-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SfgIz4mfhw8r6PiJtuCqktRnwvXcXiM6
X-Proofpoint-ORIG-GUID: hGzhrjaqhv57rh8f4Nuri-parExlHlN7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_17,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190152
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Wed, 2023-10-18 at 15:06 +0200, Thomas Huth wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
>=20
> The topology information are attributes of the CPU and are
> specified during the CPU device creation.
>=20
> On hot plug we:
> - calculate the default values for the topology for drawers,
>   books and sockets in the case they are not specified.
> - verify the CPU attributes
> - check that we have still room on the desired socket
>=20
> The possibility to insert a CPU in a mask is dependent on the
> number of cores allowed in a socket, a book or a drawer, the
> checking is done during the hot plug of the CPU to have an
> immediate answer.
>=20
> If the complete topology is not specified, the core is added
> in the physical topology based on its core ID and it gets
> defaults values for the modifier attributes.
>=20
> This way, starting QEMU without specifying the topology can
> still get some advantage of the CPU topology.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Message-ID: <20231016183925.2384704-4-nsg@linux.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                     |   6 +
>  include/hw/s390x/cpu-topology.h |  54 +++++++
>  hw/s390x/cpu-topology.c         | 259 ++++++++++++++++++++++++++++++++
>  hw/s390x/s390-virtio-ccw.c      |  22 ++-
>  hw/s390x/meson.build            |   1 +
>  5 files changed, 340 insertions(+), 2 deletions(-)
>  create mode 100644 include/hw/s390x/cpu-topology.h
>  create mode 100644 hw/s390x/cpu-topology.c

[...]

> --- /dev/null
> +++ b/include/hw/s390x/cpu-topology.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * CPU Topology
> + *
> + * Copyright IBM Corp. 2022, 2023
> + * Author(s): Pierre Morel <pmorel@linux.ibm.com>
> + *
> + */
> +#ifndef HW_S390X_CPU_TOPOLOGY_H
> +#define HW_S390X_CPU_TOPOLOGY_H
> +
> +#ifndef CONFIG_USER_ONLY
> +
> +#include "qemu/queue.h"
> +#include "hw/boards.h"
> +#include "qapi/qapi-types-machine-target.h"
> +
> +typedef struct S390Topology {
> +    uint8_t *cores_per_socket;
> +} S390Topology;
> +
> +#ifdef CONFIG_KVM
> +bool s390_has_topology(void);
> +void s390_topology_setup_cpu(MachineState *ms, S390CPU *cpu, Error **err=
p);
> +#else
> +static inline bool s390_has_topology(void)
> +{
> +       return false;

Just noticed that the indent is off here :(

> +}

[...]

