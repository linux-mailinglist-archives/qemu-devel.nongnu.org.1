Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1998793C69
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 14:13:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdrOW-0004Du-Rc; Wed, 06 Sep 2023 08:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qdrOT-0004DY-U5; Wed, 06 Sep 2023 08:12:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qdrOQ-0000Hl-V2; Wed, 06 Sep 2023 08:12:25 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 386C89OP018640; Wed, 6 Sep 2023 12:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gxn3dWGZK2qBmNQAEy1hyBTOJSK+PwT6Mre7C5saOpA=;
 b=FswG2NVo4u21BZt/z5MSAIGYRq3PnFfbGAv0BkTd6tZipM/VTX090WBHuEPKXN6p6mEX
 Sm8M9qxPgHSGioKnH8TsqGz6AVytcuMzbnK00cItrinInDMIaYpd79ftzTXV0jVqj7lN
 wLCIZpD9J7K04ythlfcLL6pnyiswH0VqHUPpWViu/HKdR2oU44ooCJEXBKbC/S/0wdEW
 mEqmG35eAU9I8X2qp/+OXVhwmEQLwe80GUL4uJVneC0vL+fXMWggHnUHCNCU2oGPheSX
 TE6IedYebV/dK5ADmNli62i+Lmbxzqx6sehuoKUPuJzbsIWMOSQz2JKpKa4797kx0oXm 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxryv8kdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 12:12:09 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 386C0N2g011324;
 Wed, 6 Sep 2023 12:12:09 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxryv8kcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 12:12:08 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 386C9ebE012275; Wed, 6 Sep 2023 12:12:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkk2ac4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 12:12:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 386CC4VS12517960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Sep 2023 12:12:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D08A120043;
 Wed,  6 Sep 2023 12:12:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1EE3720040;
 Wed,  6 Sep 2023 12:12:04 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.152.224.238])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 Sep 2023 12:12:04 +0000 (GMT)
Message-ID: <f2c78c58b5eb7ce4f4e93534d09b9ef1f1889da5.camel@linux.ibm.com>
Subject: Re: [PATCH v22 03/20] target/s390x/cpu topology: handle STSI(15)
 and build the SYSIB
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
Date: Wed, 06 Sep 2023 14:12:03 +0200
In-Reply-To: <eb7a0ed0-250e-c4cd-f862-5f5dd3c7fc13@redhat.com>
References: <20230901155812.2696560-1-nsg@linux.ibm.com>
 <20230901155812.2696560-4-nsg@linux.ibm.com>
 <f97e26f0-8a43-eef7-b228-5fa5f3f0bffc@redhat.com>
 <4df5a37496ed0a0912926f19406efcce114beaf1.camel@linux.ibm.com>
 <eb7a0ed0-250e-c4cd-f862-5f5dd3c7fc13@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tDN69hcVVfFeledqQFkiyRBRbj6S9gOD
X-Proofpoint-ORIG-GUID: xT08qfSH8SPo9UGpy5mMwURYt9ajmmsv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_05,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060103
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

On Wed, 2023-09-06 at 10:21 +0200, Thomas Huth wrote:
> On 05/09/2023 17.25, Nina Schoetterl-Glausch wrote:
> > On Tue, 2023-09-05 at 15:26 +0200, Thomas Huth wrote:
> > > On 01/09/2023 17.57, Nina Schoetterl-Glausch wrote:
> > > > From: Pierre Morel <pmorel@linux.ibm.com>
> > > >=20
> > > > On interception of STSI(15.1.x) the System Information Block
> > > > (SYSIB) is built from the list of pre-ordered topology entries.
> > > >=20
> > > > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > > > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > > > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > > > ---
> ...
> > > > +/**
> > > > + * s390_topology_fill_list_sorted:
> > > > + *
> > > > + * Loop over all CPU and insert it at the right place
> > > > + * inside the TLE entry list.
> > > > + * Fill the S390Topology list with entries according to the order
> > > > + * specified by the PoP.
> > > > + */
> > > > +static void s390_topology_fill_list_sorted(S390TopologyList *topol=
ogy_list)
> > > > +{
> > > > +    CPUState *cs;
> > > > +    S390TopologyEntry sentinel;
> > > > +
> > > > +    QTAILQ_INIT(topology_list);
> > > > +
> > > > +    sentinel.id.id =3D cpu_to_be64(UINT64_MAX);
>=20
> Since you don't do swapping for entry->id.id below, why do you do it here=
?

Because an integer in cpu endianess is converted to the big endian
storage format. So then there is a cpu -> big -> cpu round trip with
the comparison below and the value is the max.
Of course this is entirely cosmetic, since UINT64_MAX is all ones.

> > > > +    QTAILQ_INSERT_HEAD(topology_list, &sentinel, next);
> > > > +
> > > > +    CPU_FOREACH(cs) {
> > > > +        s390_topology_id id =3D s390_topology_from_cpu(S390_CPU(cs=
));
> > > > +        S390TopologyEntry *entry, *tmp;
> > > > +
> > > > +        QTAILQ_FOREACH(tmp, topology_list, next) {
> > > > +            if (id.id =3D=3D tmp->id.id) {
> > > > +                entry =3D tmp;
> > > > +                break;
> >=20
> > I think I'll add a comment here.
> >=20
> > /*
> >   * Earlier bytes have higher order -> big endian.
> >   * E.g. an entry with higher drawer number should be later in the list=
,
> >   * no matter the later fields (book, socket, etc)
> >   */
>=20
> Ugh, so this swapping is not due to real endianness issues, but just due =
to

Yeah.

> ordering? ... that's very ugly! I'd prefer to be more verbose and compare=
=20

I kinda didn't like the verbosity of it, since I then need to copy
paste the whole thing because I also need an equality check.
I considered implementing <=3D, then a =3D=3D b as a <=3D b && b <=3D a, wh=
ich
seems fine on second thought, so I'll do that.=20
And maybe help the compiler by putting __attribute__((pure)) on there.

> book by book, drawer by drawer, etc. instread. Or is this function that=
=20
> performance critical that we must save every possible CPU cycle here?

No.

>=20
>   Thomas
>=20
>=20
> >=20
> > > > +            } else if (be64_to_cpu(id.id) < be64_to_cpu(tmp->id.id=
)) {
> > > > +                entry =3D g_malloc0(sizeof(*entry));
> > >=20
> > > Maybe nicer to use g_new0 here instead?
> >=20
> > I don't think it makes much of a difference.
> >=20
> > >=20
> > > > +                entry->id.id =3D id.id;
> > >=20
> > > Should this get a cpu_to_be64() ?
> >=20
> > No, there is no interpretation of the value here, just a copy.
> > >=20
> > > > +                QTAILQ_INSERT_BEFORE(tmp, entry, next);
> > > > +                break;
> > > > +            }
> > > > +        }
> > > > +        s390_topology_add_cpu_to_entry(entry, S390_CPU(cs));
> > > > +    }
> > > > +
> > > > +    QTAILQ_REMOVE(topology_list, &sentinel, next);
> > > > +}
> > >=20
> > >    Thomas
> > >=20
> > >=20
> >=20
>=20


