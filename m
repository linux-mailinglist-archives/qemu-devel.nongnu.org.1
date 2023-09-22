Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDA57AB03F
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 13:12:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qje55-00060L-W2; Fri, 22 Sep 2023 07:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qje50-0005z9-Qo; Fri, 22 Sep 2023 07:12:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qje4x-0001Sm-LJ; Fri, 22 Sep 2023 07:12:14 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38MB86Qq009973; Fri, 22 Sep 2023 11:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gR1yHR/92IyKlkrVXXrR9CRTeOhNjvnU5E5rWX3N7Ws=;
 b=Fyjhq3ydeNEAiDrD90pltiJvvVuoiz2iNKsfzV0aAIrye7v73ZUaqeybB6KnWYyLk3V5
 sL/DbLS6HBY9Sit7TVzY3kB/9K/YccvBlpzCR9TlyA9KjfGXGT8FgNiiwU8h7eU273Es
 n1RuGoIJIx7mmwKlNJCr9uo6x1FTr8uAGLzSfd/2TYTgCM4XVJxHu6yV9mcaEv4ROVHF
 4v0+KJ3JoLKDONebeYJ4UhBw4ByiVIKXALeh4WY8XFSAhOHrJHNHoBlOEPDada/ln/9J
 3Pp6wOvJuFxpmB7DPV8eTi/3SO1oIURmh5vpYRYWWSO9wamyt1G3QutayIwH/HGrAWT/ Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t957m76m3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Sep 2023 11:11:57 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38MB86n5009980;
 Fri, 22 Sep 2023 11:11:57 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t957m76kp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Sep 2023 11:11:57 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38MAcJ9a017442; Fri, 22 Sep 2023 11:11:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t8tsmga05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Sep 2023 11:11:56 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38MBBlAS26280204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 11:11:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CB8920067;
 Fri, 22 Sep 2023 11:11:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8F7020063;
 Fri, 22 Sep 2023 11:11:44 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.34.51]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 22 Sep 2023 11:11:44 +0000 (GMT)
Message-ID: <950415f4e4a742c959a03d18df9f6b83bde4004c.camel@linux.ibm.com>
Subject: Re: [PATCH v23 01/20] CPU topology: extend with s390 specifics
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>, Halil
 Pasic <pasic@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Thomas
 Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, "Daniel P."
 =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>, Wainer dos Santos
 Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>, Pierre
 Morel <pmorel@linux.ibm.com>
Date: Fri, 22 Sep 2023 13:11:44 +0200
In-Reply-To: <87jzsljdzc.fsf@pond.sub.org>
References: <20230914120650.1318932-1-nsg@linux.ibm.com>
 <20230914120650.1318932-2-nsg@linux.ibm.com> <87jzsljdzc.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _Wx_6iEdNHfSz2mAjXqJVaSUGIJ2z-YQ
X-Proofpoint-ORIG-GUID: qVjt8xG6z5qp_yGM8ox4ZdAtFNeyUvcD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_09,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 mlxlogscore=895
 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220093
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

On Wed, 2023-09-20 at 13:11 +0200, Markus Armbruster wrote:
> Nina Schoetterl-Glausch <nsg@linux.ibm.com> writes:
>=20
> > From: Pierre Morel <pmorel@linux.ibm.com>
> >=20
> > S390 adds two new SMP levels, drawers and books to the CPU
> > topology.
> > S390 CPUs have specific topology features like dedication and
> > entitlement. These indicate to the guest information on host
> > vCPU scheduling and help the guest make better scheduling decisions.
> >=20
> > Let us provide the SMP properties with books and drawers levels
> > and S390 CPU with dedication and entitlement,
> >=20
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > diff --git a/qapi/machine-common.json b/qapi/machine-common.json
> > new file mode 100644
> > index 0000000000..e40421bb37
> > --- /dev/null
> > +++ b/qapi/machine-common.json
> > @@ -0,0 +1,21 @@
> > +# -*- Mode: Python -*-
> > +# vim: filetype=3Dpython
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
> > +# See the COPYING file in the top-level directory.
> > +
> > +##
> > +# =3D Machines S390 data types
> > +##
> > +
> > +##
> > +# @CpuS390Entitlement:
> > +#
> > +# An enumeration of cpu entitlements that can be assumed by a virtual
> > +# S390 CPU
>=20
> CPU entitlements
>=20
> Would someone reasonably familiar with S390 understand this?  Because

Well, someone familiar with s390 topology would, otherwise probably not tbh=
.

> I'm not and I don't; I wonder what "a virtual CPU assuming an
> entitlement" means.

Basically, on s390x the OS is always running on some hypervisor.
Even without KVM or z/VM you can slice up the machine, namely into logical
partitions (LPARs). Therefore, there is a scheduling of virtual CPUs to the
actual physical ones. "Entitlement" is a statement about how that schedulin=
g
works for a virtual CPU. The same concepts can then also be applied to KVM.
>=20
> > +#
> > +# Since: 8.2
> > +##
> > +{ 'enum': 'CpuS390Entitlement',
> > +  'prefix': 'S390_CPU_ENTITLEMENT',
> > +  'data': [ 'auto', 'low', 'medium', 'high' ] }
>=20
> [...]
>=20


