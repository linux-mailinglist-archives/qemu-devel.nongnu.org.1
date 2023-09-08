Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 326CE79893B
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:50:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeco7-0003ei-CY; Fri, 08 Sep 2023 10:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qecnx-0003dq-Sm; Fri, 08 Sep 2023 10:49:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qecnq-0001Mr-Pr; Fri, 08 Sep 2023 10:49:51 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 388Eivn9032225; Fri, 8 Sep 2023 14:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=X5QeRkAIGDrChz6o5iWgsMflCNIOm2lqJ39LzFh42fg=;
 b=atU77gRvnH/NLnuuyNts8u1KT3WXS5gk238zzPyZUFN7wmnK5gXlO+CGscEDP8n0wpDg
 UZBZ//cX1ZSn763NfmUz1sUycTM8AeVgW22lIwi2+tuh/fPHQ31zpO4pdq5i+OemaDvy
 PJfgaj+R4RrId3Lpl7LtemAxlog3iL0c5uLEpU0kFv/4ntkJm7rM+D30ME6gk6Vz/mIZ
 0QXGy13oMfJPln4/gM25No6JUPvxFwkX1Bo1aA7fWg8w9+7eTOpuS1uPZT0QeZKmwaui
 bOaZUBD4Pf42b2NFBmNhjAvC07vR8AYi1N8nSEDwt2fbUgy/jA37YauSrDw/cfLLZTVJ ig== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t05n685ab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 14:49:33 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 388Ek2d1006175;
 Fri, 8 Sep 2023 14:49:33 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t05n6859r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 14:49:33 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 388CgDv4021478; Fri, 8 Sep 2023 14:49:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svfs04je6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 14:49:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 388EnSkn24642048
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Sep 2023 14:49:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F48E20063;
 Fri,  8 Sep 2023 14:49:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD59D2004E;
 Fri,  8 Sep 2023 14:49:26 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.179.20.236]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Sep 2023 14:49:26 +0000 (GMT)
Message-ID: <da5bf95b465a6f1f0d7769a286be1787a49c6989.camel@linux.ibm.com>
Subject: Re: [PATCH v22 15/20] tests/avocado: s390x cpu topology polarization
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
Date: Fri, 08 Sep 2023 16:47:41 +0200
In-Reply-To: <529821b9-71f1-a137-172a-e697feaf6abd@redhat.com>
References: <20230901155812.2696560-1-nsg@linux.ibm.com>
 <20230901155812.2696560-16-nsg@linux.ibm.com>
 <529821b9-71f1-a137-172a-e697feaf6abd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -WF1tbKUopNhfmSIzl1h1UR7ayvCi3g4
X-Proofpoint-ORIG-GUID: 1FgWeGzsITxV-gmTlfJ4kIxX1PDk_wl3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309080135
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

On Thu, 2023-09-07 at 11:02 +0200, Thomas Huth wrote:
> On 01/09/2023 17.58, Nina Schoetterl-Glausch wrote:
> > From: Pierre Morel <pmorel@linux.ibm.com>
> >=20
> > Polarization is changed on a request from the guest.
> > Let's verify the polarization is accordingly set by QEMU.
> >=20
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > ---
> >   tests/avocado/s390_topology.py | 45 +++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 45 insertions(+)
> >=20
> > diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topolo=
gy.py
> > index 3a54fe2e00..d7ee36cb89 100644
> > --- a/tests/avocado/s390_topology.py
> > +++ b/tests/avocado/s390_topology.py
> > @@ -41,6 +41,7 @@ class S390CPUTopology(QemuSystemTest):
> >       The polarization is changed on a request from the guest.
> >       """
> >       timeout =3D 90
> > +    event_timeout =3D 10
> >  =20
> >       KERNEL_COMMON_COMMAND_LINE =3D ('printk.time=3D0 '
> >                                     'root=3D/dev/ram '
> > @@ -103,6 +104,14 @@ def kernel_init(self):
> >                            '-initrd', initrd_path,
> >                            '-append', kernel_command_line)
> >  =20
> > +    def system_init(self):
> > +        self.log.info("System init")
> > +        exec_command_and_wait_for_pattern(self,
> > +                """ mount proc -t proc /proc;
> > +                    mount sys -t sysfs /sys;
> > +                    /bin/cat /sys/devices/system/cpu/dispatching """,
>=20
> Is the /bin/ prefix really required here?

No, /bin is a symlink to /usr/bin and that's in PATH.
Not sure why Pierre did it this way, might be a remnant of some other
vm image/initrd.
I'll remove it.

>=20
> > +                    '0')
> > +
> >       def test_single(self):
> >           """
> >           This test checks the simplest topology with a single CPU.
> > @@ -198,3 +207,39 @@ def test_hotplug_full(self):
> >           self.check_topology(3, 1, 1, 1, 'high', False)
> >           self.check_topology(4, 1, 1, 1, 'medium', False)
> >           self.check_topology(5, 2, 1, 1, 'high', True)
> > +
> > +
> > +    def guest_set_dispatching(self, dispatching):
> > +        exec_command(self,
> > +                f'echo {dispatching} > /sys/devices/system/cpu/dispatc=
hing')
> > +        self.vm.event_wait('CPU_POLARIZATION_CHANGE', self.event_timeo=
ut)
> > +        exec_command_and_wait_for_pattern(self,
> > +                '/bin/cat /sys/devices/system/cpu/dispatching', dispat=
ching)
>=20
> dito?
>=20
> > +
> > +    def test_polarization(self):
> > +        """
> > +        This test verifies that QEMU modifies the entitlement change a=
fter
> > +        several guest polarization change requests.
> > +
> > +        :avocado: tags=3Darch:s390x
> > +        :avocado: tags=3Dmachine:s390-ccw-virtio
> > +        """
> > +        self.kernel_init()
> > +        self.vm.launch()
> > +        self.wait_until_booted()
> > +
> > +        self.system_init()
> > +        res =3D self.vm.qmp('query-s390x-cpu-polarization')
> > +        self.assertEqual(res['return']['polarization'], 'horizontal')
> > +        self.check_topology(0, 0, 0, 0, 'medium', False)
> > +
> > +        self.guest_set_dispatching('1');
> > +        res =3D self.vm.qmp('query-s390x-cpu-polarization')
> > +        self.assertEqual(res['return']['polarization'], 'vertical')
> > +        self.check_topology(0, 0, 0, 0, 'medium', False)
> > +
> > +        self.guest_set_dispatching('0');
> > +        res =3D self.vm.qmp('query-s390x-cpu-polarization')
> > +        self.assertEqual(res['return']['polarization'], 'horizontal')
> > +        self.check_topology(0, 0, 0, 0, 'medium', False)
>=20
> Anyway:
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!


