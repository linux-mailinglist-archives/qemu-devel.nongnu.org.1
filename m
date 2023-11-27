Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AB77FA02F
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 14:00:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7bCJ-0001H7-Em; Mon, 27 Nov 2023 07:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1r7bCH-0001GN-09; Mon, 27 Nov 2023 07:58:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1r7bCF-00053c-40; Mon, 27 Nov 2023 07:58:44 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ARCBnBQ027791; Mon, 27 Nov 2023 12:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=4eFmemBqCVPrZSHyd7oOOmwoRj+DkP9UJQBIHGMapKE=;
 b=iaQWJ4tW3zbu9SlghPjC89xZF+hJVigJM2xroGaUHoM3rmr5EpcZjqrgreRjX+qin8W3
 8As9pcy09Z3q9MHKJINV+pA7B0QzfEVuSVH+1aEbUr/iJAoLhBzxIDqvnhMZ3gDi8oAx
 t78HHG95EtVoLzAiN3q2hRk+5ofFMI6EEm2GKLdEEVZtyz5WVw+iTMv7+2m3DHjqKl+Z
 j1Lch3xLc/zqAO7LT8k3LlD7mMLdsWWreeWPMTy6IjHvLSW3k7A4snb7xQCrpuHJcdq2
 6BH7kTYLhbv1P/Vhp67RVnwOB9xZh+VAUZNkrKaGwxfwCAuyulbhIXy+6mVjxFYrc7yd LA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umtke1ehf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 12:58:36 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARCniYn024684;
 Mon, 27 Nov 2023 12:58:35 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umtke1eh5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 12:58:35 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ARBYZe3011079; Mon, 27 Nov 2023 12:58:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy1g703-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 12:58:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ARCwXXa43713042
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Nov 2023 12:58:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 013D32004D;
 Mon, 27 Nov 2023 12:58:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93D4020040;
 Mon, 27 Nov 2023 12:58:32 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.79.46]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Nov 2023 12:58:32 +0000 (GMT)
Message-ID: <0c9271e79189edff10a85f99fe8a27ae287ad796.camel@linux.ibm.com>
Subject: Re: [RFC] docs/s390: Fix wrong command example in
 s390-cpu-topology.rst
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Date: Mon, 27 Nov 2023 13:58:32 +0100
In-Reply-To: <20231127093915.565710-1-zhao1.liu@linux.intel.com>
References: <20231127093915.565710-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ajVqouEncbr-a3kqo7HHJbWdGgdYovJo
X-Proofpoint-GUID: uszNPv0KZPeE9X7ZvoA_3-FCXY07-dYc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_10,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 clxscore=1011 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270088
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

On Mon, 2023-11-27 at 17:39 +0800, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
>=20
> From s390_possible_cpu_arch_ids() in hw/s390x/s390-virtio-ccw.c, the
> "core-id" is the index of pssible_cpus->cpus[], so it should only be

s/pssible_cpus/possible_cpus/

> less than possible_cpus->len, which is equal to ms->smp.max_cpus.
>=20
> Fix the wrong "core-id" 112 because it is greater than maxcpus (36) in

Maybe s/is greater/isn't less/ since the valid ids are 0-35 inclusive.

> -smp.
>=20
> Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Thanks!
> ---
> RFC: Not tested on S390 machine, just code reading.
> ---
>  docs/devel/s390-cpu-topology.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/docs/devel/s390-cpu-topology.rst b/docs/devel/s390-cpu-topol=
ogy.rst
> index 9eab28d5e5d8..48313b92d417 100644
> --- a/docs/devel/s390-cpu-topology.rst
> +++ b/docs/devel/s390-cpu-topology.rst
> @@ -15,7 +15,7 @@ have default values:
>      -smp 1,drawers=3D3,books=3D3,sockets=3D2,cores=3D2,maxcpus=3D36 \
>      -device z14-s390x-cpu,core-id=3D19,entitlement=3Dhigh \
>      -device z14-s390x-cpu,core-id=3D11,entitlement=3Dlow \
> -    -device z14-s390x-cpu,core-id=3D112,entitlement=3Dhigh \
> +    -device z14-s390x-cpu,core-id=3D12,entitlement=3Dhigh \
>     ...
> =20
>  Additions to query-cpus-fast
> @@ -78,7 +78,7 @@ modifiers for all configured vCPUs.
>        "dedicated": true,
>        "thread-id": 537005,
>        "props": {
> -        "core-id": 112,
> +        "core-id": 12,
>          "socket-id": 0,
>          "drawer-id": 3,
>          "book-id": 2
> @@ -86,7 +86,7 @@ modifiers for all configured vCPUs.
>        "cpu-state": "operating",
>        "entitlement": "high",
>        "qom-path": "/machine/peripheral-anon/device[2]",
> -      "cpu-index": 112,
> +      "cpu-index": 12,
>        "target": "s390x"
>      }
>    ]


