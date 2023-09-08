Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB30C7988B3
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:30:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecUW-0008O2-TJ; Fri, 08 Sep 2023 10:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qecUS-0008NZ-Vx; Fri, 08 Sep 2023 10:29:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qecUM-0003yU-MI; Fri, 08 Sep 2023 10:29:44 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 388EPAps014122; Fri, 8 Sep 2023 14:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vF4JGZxE09lOtohMM17n1oLRJKNGStHeFtBKCe7bkvo=;
 b=trXfZgU0XiELVGiWVnGS/oflSKfJ8PKhj2WvDzfTvBv5EnapIJKh7BJCb7KyTCEF/tmd
 QeVb5x5KRuDf0LATvxULAdGwKlriR8SEpNxTcXoU6jMVtg3dDdTQXe/GO6XBzRAFGAPK
 gAz7DCcgMHFKIpLOJc1b5yQRqmfsd6xAAfLQLmHdnmNi6EUqyTdvn+U9W6TyhuoxE85n
 LBX+NDs6wqrwhFvfyy5AVH8m8e9XPqxuu9Gcmd6GNK9QZcdJ2lKTZCPnKhGAZDFLD9fs
 eb8CakYzdr+bXQMCURDdTS3UgmacKmyO4fO1H8YsZptANq9BvIdjlBqWT7jZRtbpX8X3 sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t05bpr2u3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 14:29:27 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 388EQB0C017024;
 Fri, 8 Sep 2023 14:29:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t05bpr2tk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 14:29:26 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 388Cp7r4021360; Fri, 8 Sep 2023 14:29:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svfs04eh0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 14:29:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 388ETMeT15336024
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Sep 2023 14:29:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EF8620040;
 Fri,  8 Sep 2023 14:29:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E5D320043;
 Fri,  8 Sep 2023 14:29:21 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.179.20.236]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Sep 2023 14:29:21 +0000 (GMT)
Message-ID: <8e23251e23d5800d5b2c243e56c2d6942f162052.camel@linux.ibm.com>
Subject: Re: [PATCH v22 14/20] tests/avocado: s390x cpu topology core
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Yanan
 Wang <wangyanan55@huawei.com>, "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Cleber Rosa
 <crosa@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 08 Sep 2023 16:27:35 +0200
In-Reply-To: <3a2b6b7c-82d1-8500-8f82-cc87b36f2152@redhat.com>
References: <20230901155812.2696560-1-nsg@linux.ibm.com>
 <20230901155812.2696560-15-nsg@linux.ibm.com>
 <3a2b6b7c-82d1-8500-8f82-cc87b36f2152@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1WXS-La82DbvbiABzLJ_2tt9aFHmBTuJ
X-Proofpoint-GUID: JX17Ne-rOR1YHLmcahoqY_5wZQW5BOvC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080130
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

On Thu, 2023-09-07 at 10:27 +0200, Thomas Huth wrote:
> On 01/09/2023 17.58, Nina Schoetterl-Glausch wrote:
> > From: Pierre Morel <pmorel@linux.ibm.com>
> >=20
> > Introduction of the s390x cpu topology core functions and
> > basic tests.
> >=20
> > We test the correlation between the command line and
> > the QMP results in query-cpus-fast for various CPU topology.
> >=20
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > ---
> >   MAINTAINERS                    |   1 +
> >   tests/avocado/s390_topology.py | 200 ++++++++++++++++++++++++++++++++=
+
> >   2 files changed, 201 insertions(+)
> >   create mode 100644 tests/avocado/s390_topology.py
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7f2937b0f2..d1b8676666 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1703,6 +1703,7 @@ F: hw/s390x/cpu-topology.c
> >   F: target/s390x/kvm/stsi-topology.c
> >   F: docs/devel/s390-cpu-topology.rst
> >   F: docs/system/s390x/cpu-topology.rst
> > +F: tests/avocado/s390_topology.py
> >  =20
> >   X86 Machines
> >   ------------
> > diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topolo=
gy.py
> > new file mode 100644
> > index 0000000000..3a54fe2e00
> > --- /dev/null
> > +++ b/tests/avocado/s390_topology.py
> > @@ -0,0 +1,200 @@

[...]

> > +    def test_default(self):
> > +        """
> > +        This test checks the implicit topology.
> > +
> > +        :avocado: tags=3Darch:s390x
> > +        :avocado: tags=3Dmachine:s390-ccw-virtio
> > +        """
> > +        self.kernel_init()
> > +        self.vm.add_args('-smp',
> > +                         '13,drawers=3D2,books=3D2,sockets=3D3,cores=
=3D2,maxcpus=3D24')
> > +        self.vm.launch()
> > +        self.wait_until_booted()
> > +        self.check_topology(0, 0, 0, 0, 'medium', False)
> > +        self.check_topology(1, 0, 0, 0, 'medium', False)
> > +        self.check_topology(2, 1, 0, 0, 'medium', False)
> > +        self.check_topology(3, 1, 0, 0, 'medium', False)
> > +        self.check_topology(4, 2, 0, 0, 'medium', False)
> > +        self.check_topology(5, 2, 0, 0, 'medium', False)
> > +        self.check_topology(6, 0, 1, 0, 'medium', False)
> > +        self.check_topology(7, 0, 1, 0, 'medium', False)
> > +        self.check_topology(8, 1, 1, 0, 'medium', False)
> > +        self.check_topology(9, 1, 1, 0, 'medium', False)
> > +        self.check_topology(10, 2, 1, 0, 'medium', False)
> > +        self.check_topology(11, 2, 1, 0, 'medium', False)
> > +        self.check_topology(12, 0, 0, 1, 'medium', False)
> > +
> > +    def test_move(self):
> > +        """
> > +        This test checks the topology modification by moving a CPU
> > +        to another socket: CPU 0 is moved from socket 0 to socket 2.
> > +
> > +        :avocado: tags=3Darch:s390x
> > +        :avocado: tags=3Dmachine:s390-ccw-virtio
> > +        """
> > +        self.kernel_init()
> > +        self.vm.add_args('-smp',
> > +                         '1,drawers=3D2,books=3D2,sockets=3D3,cores=3D=
2,maxcpus=3D24')
> > +        self.vm.launch()
> > +        self.wait_until_booted()
> > +
> > +        self.check_topology(0, 0, 0, 0, 'medium', False)
> > +        res =3D self.vm.qmp('set-cpu-topology',
> > +                          {'core-id': 0, 'socket-id': 2, 'entitlement'=
: 'low'})
> > +        self.assertEqual(res['return'], {})
> > +        self.check_topology(0, 2, 0, 0, 'low', False)
>=20
> Booting a Linux kernel in the guest always takes some precious seconds of=
=20
> testing time ... I wonder whether it maybe makes sense to merge the above=
=20
> two tests into one?

IMO it's cleaner to keep them separated.

> > +    def test_hotplug_full(self):
> > +        """
> > +        This test verifies that a hotplugged defined with '-device'
> > +        command line argument finds its right place inside the topolog=
y.
>=20
> "hotplug" is normally rather a "device_add" via HMP/QMP during run-time, =
so=20
> I'd rather avoid this term here. Maybe call it "test_device_option" or so=
?

I'll go with test_dash_device.

>=20
> > +        :avocado: tags=3Darch:s390x
> > +        :avocado: tags=3Dmachine:s390-ccw-virtio
> > +        """
> > +        self.kernel_init()
> > +        self.vm.add_args('-smp',
> > +                         '1,drawers=3D2,books=3D2,sockets=3D3,cores=3D=
2,maxcpus=3D24')
> > +        self.vm.add_args('-device', 'max-s390x-cpu,core-id=3D10')
> > +        self.vm.add_args('-device',
> > +                         'max-s390x-cpu,'
> > +                         'core-id=3D1,socket-id=3D0,book-id=3D1,drawer=
-id=3D1,entitlement=3Dlow')
> > +        self.vm.add_args('-device',
> > +                         'max-s390x-cpu,'
> > +                         'core-id=3D2,socket-id=3D0,book-id=3D1,drawer=
-id=3D1,entitlement=3Dmedium')
> > +        self.vm.add_args('-device',
> > +                         'max-s390x-cpu,'
> > +                         'core-id=3D3,socket-id=3D1,book-id=3D1,drawer=
-id=3D1,entitlement=3Dhigh')
> > +        self.vm.add_args('-device',
> > +                         'max-s390x-cpu,'
> > +                         'core-id=3D4,socket-id=3D1,book-id=3D1,drawer=
-id=3D1')
> > +        self.vm.add_args('-device',
> > +                         'max-s390x-cpu,'
> > +                         'core-id=3D5,socket-id=3D2,book-id=3D1,drawer=
-id=3D1,dedicated=3Dtrue')
> > +
> > +        self.vm.launch()
> > +        self.wait_until_booted()
> > +
> > +        self.check_topology(10, 2, 1, 0, 'medium', False)
> > +        self.check_topology(1, 0, 1, 1, 'low', False)
> > +        self.check_topology(2, 0, 1, 1, 'medium', False)
> > +        self.check_topology(3, 1, 1, 1, 'high', False)
> > +        self.check_topology(4, 1, 1, 1, 'medium', False)
> > +        self.check_topology(5, 2, 1, 1, 'high', True)
>=20
>   Thomas
>=20


