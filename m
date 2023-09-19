Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ED27A661E
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 16:04:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qibJY-0001FQ-PD; Tue, 19 Sep 2023 10:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qibJO-0001D7-Nb; Tue, 19 Sep 2023 10:02:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qibJH-0005Vu-1U; Tue, 19 Sep 2023 10:02:40 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38JDdBhQ025489; Tue, 19 Sep 2023 14:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Wo2K35n9b9Q3lKdDTiJYhrSie2Q45fnrsJkuESj5AII=;
 b=PE0OladCzi5qPk3Cir+W22ECmYbSgr7yXcK+pERRKmK1eKcRbVOXw2WaGlNnP6XG6s6R
 381isHpYhxLhAACWh+27t5cwDHsAKuHSPnxa6dNjmKfsiQd3ptxTewV+cmwZYc9j7ime
 Ph1gaKwawbrSIr9qEg8/fjQatvdUwm0XPjtQpLi0yCjn8ZfEtyF9X/58woAU34l9+jCs
 pTtfQMbG7vUOJ38dyQFB3gQTG9Kd3PYAYUFyr9ADCoZsdI9C1M8DreBygwBI6iaGM9fy
 eNf2/pr/GQxQNFKfUEaCvEYhv7Dy5oO0IjrngO1Mm/A0nRTDmDCnNVVOfnACm1LI7vtQ Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7c26a4p8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 14:01:25 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38JDfMO5001083;
 Tue, 19 Sep 2023 14:01:24 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7c26a4m8-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 14:01:24 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38JBn2fa016451; Tue, 19 Sep 2023 13:37:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5sd1v56h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 13:37:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38JDbDpZ59900164
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 13:37:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 588EA20040;
 Tue, 19 Sep 2023 13:37:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D768720043;
 Tue, 19 Sep 2023 13:37:12 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.152.224.238])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Sep 2023 13:37:12 +0000 (GMT)
Message-ID: <74aa61ac496f9d078aa81c692822d2f27da4ddcf.camel@linux.ibm.com>
Subject: Re: [PATCH v23 03/20] target/s390x/cpu topology: handle STSI(15)
 and build the SYSIB
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>, Halil
 Pasic <pasic@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Thomas
 Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Yanan
 Wang <wangyanan55@huawei.com>, "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Cleber Rosa
 <crosa@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 19 Sep 2023 15:37:11 +0200
In-Reply-To: <20230914120650.1318932-4-nsg@linux.ibm.com>
References: <20230914120650.1318932-1-nsg@linux.ibm.com>
 <20230914120650.1318932-4-nsg@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ziqgiWxmVlHlEbr32Seppr1wPtpAc4tQ
X-Proofpoint-GUID: dqJVfPWjyusR-5TK-KHDs5y7Ze2DHoPs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_06,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190116
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

On Thu, 2023-09-14 at 14:06 +0200, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
>=20
> On interception of STSI(15.1.x) the System Information Block
> (SYSIB) is built from the list of pre-ordered topology entries.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>  MAINTAINERS                      |   1 +
>  qapi/machine-target.json         |  14 ++
>  include/hw/s390x/cpu-topology.h  |  23 +++
>  include/hw/s390x/sclp.h          |   1 +
>  target/s390x/cpu.h               |  75 +++++++
>  hw/s390x/cpu-topology.c          |   2 +
>  target/s390x/kvm/kvm.c           |   5 +-
>  target/s390x/kvm/stsi-topology.c | 338 +++++++++++++++++++++++++++++++
>  target/s390x/kvm/meson.build     |   3 +-
>  9 files changed, 460 insertions(+), 2 deletions(-)
>  create mode 100644 target/s390x/kvm/stsi-topology.c

[...]

> diff --git a/target/s390x/kvm/stsi-topology.c b/target/s390x/kvm/stsi-top=
ology.c
> new file mode 100644
> index 0000000000..22bac2b834
> --- /dev/null
> +++ b/target/s390x/kvm/stsi-topology.c

[...]

> +/**
> + * s390_topology_id_cmp:
> + * @l: first s390_topology_id
> + * @r: second s390_topology_id
> + *
> + * Compare two topology ids according to the sorting order specified by =
the PoP.
> + *
> + * Returns a negative number if the first id is less than, 0 if it is eq=
ual to
> + *     and positive if it is larger than the second id.
> + */
> +static int s390_topology_id_cmp(const s390_topology_id *l,
> +                                const s390_topology_id *r)
> +{
> +    /*
> +     * lexical order, compare less significant values only if more signi=
ficant
> +     * ones are equal
> +     */
> +    return l->sentinel - r->sentinel ?:
> +           l->drawer - r->drawer ?:
> +           l->book - r->book ?:
> +           l->socket - r->socket ?:
> +           l->type - r->type ?:
> +           -1 * (l->vertical - r->vertical) ?:
> +           -1 * (l->entitlement - r->entitlement) ?:
> +           -1 * (l->dedicated - r->dedicated) ?:

I'll switch around those expressions manually, since gcc complains:

error: =E2=80=98*=E2=80=99 in boolean context, suggest =E2=80=98&&=E2=80=99=
 instead [-Werror=3Dint-in-bool-context]
  222 |            -1 * (l->vertical - r->vertical) ?:
      |            ~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I'll add a comment also, since the inverted logic is not as obvious as befo=
re.

> +           l->origin - r->origin;
> +}

[...]

