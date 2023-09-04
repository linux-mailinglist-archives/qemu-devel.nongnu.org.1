Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97331791DD6
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 21:53:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdFbx-0004pM-PR; Mon, 04 Sep 2023 15:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qdFbv-0004ox-Fx; Mon, 04 Sep 2023 15:51:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qdFbt-0001Ny-2B; Mon, 04 Sep 2023 15:51:47 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 384Jdcuq022542; Mon, 4 Sep 2023 19:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=YhGnCGXzKC2yQssmxp9RbMHVteL/4y+ieTkV1QIXPCk=;
 b=HJWVlQVeILsmX6tct+gbfRsmgmWy9HXJMNBE7D1UmLh7i3C+yf3SuSfgYn1jxPQ1yCjW
 3NUFOuzqIQI0lxdYpe54cA8N0cIB/ISsnwFYlNL8/pbp9Gn8pgF4agOUVTt/DsbObcKG
 5YH8EV1ykqUFP3krm6doJGxyRDHUVXGIn+Ut6PmtuyNmA3uVqGe3BIPqf+UHnFqe2nYH
 3HSuips1VPQoRbtZv7fJSaCNlX9g/3isFmT7FAh5GlhP+WENy0XcjC8SdeulD+K6KDKG
 G7Oktaa5Afi9BmsoTQ4W1kYZ2nFiASyygPBbG/J1c7O4g/66172AF6lQqxbyUcuY7MRF pA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3swmmqhcgf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Sep 2023 19:51:31 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 384JeZrA027233;
 Mon, 4 Sep 2023 19:51:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3swmmqhcg8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Sep 2023 19:51:31 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 384HnesE006603; Mon, 4 Sep 2023 19:51:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgvk4x60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Sep 2023 19:51:30 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 384JpR3L10093166
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 Sep 2023 19:51:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32D3E20049;
 Mon,  4 Sep 2023 19:51:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E522F20040;
 Mon,  4 Sep 2023 19:51:25 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.179.18.181]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 Sep 2023 19:51:25 +0000 (GMT)
Message-ID: <e5d4cfe160c195e0f258e409af80d02d504cdfb3.camel@linux.ibm.com>
Subject: Re: [PATCH v22 16/20] tests/avocado: s390x cpu topology entitlement
 tests
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
Date: Mon, 04 Sep 2023 21:51:25 +0200
In-Reply-To: <20230901155812.2696560-17-nsg@linux.ibm.com>
References: <20230901155812.2696560-1-nsg@linux.ibm.com>
 <20230901155812.2696560-17-nsg@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eYBvH1h0A_K0j0A5RiB4PFzxnQ1UtmvY
X-Proofpoint-ORIG-GUID: wqWVkn4AYcHMjUy8jhkTjQN6KX0Gv8ZR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_13,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040176
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

On Fri, 2023-09-01 at 17:58 +0200, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
>=20
> Test changes in the entitlement from both a guest and a host point of
> view, depending on the polarization.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

> ---
>  tests/avocado/s390_topology.py | 55 ++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>=20
> diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology=
.py
> index d7ee36cb89..733093723a 100644
> --- a/tests/avocado/s390_topology.py
> +++ b/tests/avocado/s390_topology.py
> @@ -243,3 +243,58 @@ def test_polarization(self):
>          res =3D self.vm.qmp('query-s390x-cpu-polarization')
>          self.assertEqual(res['return']['polarization'], 'horizontal')
>          self.check_topology(0, 0, 0, 0, 'medium', False)
> +
> +
> +    def check_polarization(self, polarization):
> +        """
> +        We need the polarization change to get stabilized in kernel
> +        before we check it through the sysfs.
> +        """

IMO this should be a comment, not a function doc.
#We need to wait for the change to have been propagated to the kernel

> +        exec_command_and_wait_for_pattern(self,
> +                """ sleep 1 ;
> +                    /bin/cat /sys/devices/system/cpu/cpu0/polarization "=
"",
> +                polarization)

[...]

