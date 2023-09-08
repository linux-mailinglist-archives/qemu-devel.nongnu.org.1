Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2B9798E46
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 20:34:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qegHV-0003lH-8d; Fri, 08 Sep 2023 14:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qegHQ-0003jH-B0; Fri, 08 Sep 2023 14:32:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qegHN-00083d-Ln; Fri, 08 Sep 2023 14:32:32 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 388IIYHw030085; Fri, 8 Sep 2023 18:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=lLyuNFo2E4tyt0lCT3/85dxCf3i67gAL73B+AyuRmFo=;
 b=KfvYGOPMmns9Hxy4E1KJNVJoXTv4OTLzhfe5fm/G5x3m2PIOMXM0wMcp0jGM9ECkSAIx
 zQViPfxM5tYctnVFuPK1Itv9WYlWuD9Rn+2OpSKGhMNbduJm5lQHqt8P3zFc29XYi8lJ
 hI0hDdiSszynFN4MnxLT3Uwl2vI7V6dzE8C0h/1Z0oLYJ2r1Rso2Nb7I9lW7M+DwKTBs
 TwXsISufouUnIgJTNZaZc0cJMsGmpSxncXlaIx8zT/CC7RZIdMuUb4MWQSJkrpQjQOxV
 oUF9LHMfyQiOxtNgz2KPBuct5oDkhWflFROws0EiNpccy78omq2LatLzCjYdDlIFcL3b IA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t08s6g9n1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 18:32:21 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 388ISJtJ003974;
 Fri, 8 Sep 2023 18:32:20 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t08s6g9mh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 18:32:20 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 388Guna8012212; Fri, 8 Sep 2023 18:32:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkknjdh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Sep 2023 18:32:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 388IWF4660031302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Sep 2023 18:32:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A2B420049;
 Fri,  8 Sep 2023 18:32:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A47F120040;
 Fri,  8 Sep 2023 18:32:14 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.179.20.236]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Sep 2023 18:32:14 +0000 (GMT)
Message-ID: <8b6e8b215ea7467ae47acb6e968074121523ab68.camel@linux.ibm.com>
Subject: Re: [PATCH v22 16/20] tests/avocado: s390x cpu topology entitlement
 tests
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
Date: Fri, 08 Sep 2023 20:30:29 +0200
In-Reply-To: <ea0464ed-fd1d-001b-09f2-e71220d862be@redhat.com>
References: <20230901155812.2696560-1-nsg@linux.ibm.com>
 <20230901155812.2696560-17-nsg@linux.ibm.com>
 <ea0464ed-fd1d-001b-09f2-e71220d862be@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nlmFOCo0ETql0rBY-iKPqzd1fbg0w7tI
X-Proofpoint-GUID: Orq-4NiPl2ZUXLpIUVYKK5Kvy4fUB9-u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_14,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080165
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

On Thu, 2023-09-07 at 11:05 +0200, Thomas Huth wrote:
> On 01/09/2023 17.58, Nina Schoetterl-Glausch wrote:
> > From: Pierre Morel <pmorel@linux.ibm.com>
> >=20
> > Test changes in the entitlement from both a guest and a host point of
> > view, depending on the polarization.
> >=20
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > ---
> >   tests/avocado/s390_topology.py | 55 +++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 55 insertions(+)
> >=20
> > diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topolo=
gy.py
> > index d7ee36cb89..733093723a 100644
> > --- a/tests/avocado/s390_topology.py
> > +++ b/tests/avocado/s390_topology.py
> > @@ -243,3 +243,58 @@ def test_polarization(self):
> >           res =3D self.vm.qmp('query-s390x-cpu-polarization')
> >           self.assertEqual(res['return']['polarization'], 'horizontal')
> >           self.check_topology(0, 0, 0, 0, 'medium', False)
> > +
> > +
> > +    def check_polarization(self, polarization):
> > +        """
> > +        We need the polarization change to get stabilized in kernel
> > +        before we check it through the sysfs.
> > +        """
> > +        exec_command_and_wait_for_pattern(self,
> > +                """ sleep 1 ;
> > +                    /bin/cat /sys/devices/system/cpu/cpu0/polarization=
 """,
> > +                polarization)
>=20
> Using "sleep" in a function that is called multiple times will blow up th=
e=20
> testing time quite a bit ... could this be done in a different way instea=
d,=20
> e.g. by polling the sysfs file for the right value, or maybe there is=20
> something in the "dmesg" output that could be used as a reference?

Nothing in dmesg.
This works:

def check_polarization(self, polarization):
    #We need to wait for the change to have been propagated to the kernel
    exec_command_and_wait_for_pattern(self,
        "\n".join([
            "timeout 1 sh -c 'while true",
            'do',
            '    syspath=3D"/sys/devices/system/cpu/cpu0/polarization"',
            '    polarization=3D"$(cat "$syspath")" || exit',
           f'    if [ "$polarization" =3D "{polarization}" ]; then',
            '        exit 0',
            '    fi',
            '    sleep 0.01',
            #searched for strings mustn't show up in command, '' to obfusca=
te
            "done' && echo succ''ess || echo fail''ure",
        ]),
        "success", "failure")

>=20
>   Thomas
>=20
>=20


