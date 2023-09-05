Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8BF7923EC
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 17:26:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdXvt-000278-TD; Tue, 05 Sep 2023 11:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qdXvs-00025F-58; Tue, 05 Sep 2023 11:25:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qdXvp-00035m-1Y; Tue, 05 Sep 2023 11:25:35 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 385F7aDW000870; Tue, 5 Sep 2023 15:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=q1I6re0ZoI0w/E6oLDaLafILzbZJW30hYYLNAi0AdYA=;
 b=ZgWfbe6WQ5aTDt60siTlYXew3c0sUyy015A+DmUWU+EBdnox+XIM5mAJnev3KoX/k6gU
 n2gl/l1pdjlhfRNYTwnj7MF6HySX7wTZdqN4+baomNXdzdPjrIwerSKm5hv9IpIS7sXH
 R7KJSi2OMM5IOJBUV5hxaYqCs7Br1kekq9OWVUc+4sd3aUXLvWS320xUen+8ceU5QNla
 FDKpk16ef/bNh/b8wFmrOipgk0wjH+ietYkkk7JqxKKpCVMtVuQBn/ssFmaZ11ekhWfK
 5vzRRYRp6lfvJTfXpSBgRspp0KxxlclKmsQhVpxOhrD0kN2a9qy++wP0SXiLFPn3EA9m 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx6gy0tvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Sep 2023 15:25:16 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385F7oVa002619;
 Tue, 5 Sep 2023 15:25:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx6gy0tux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Sep 2023 15:25:15 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 385Emju6026750; Tue, 5 Sep 2023 15:25:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgcnbkgn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Sep 2023 15:25:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 385FPAlu8520436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Sep 2023 15:25:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E90B20040;
 Tue,  5 Sep 2023 15:25:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A94720043;
 Tue,  5 Sep 2023 15:25:09 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.179.19.122]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 Sep 2023 15:25:09 +0000 (GMT)
Message-ID: <4df5a37496ed0a0912926f19406efcce114beaf1.camel@linux.ibm.com>
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
Date: Tue, 05 Sep 2023 17:25:08 +0200
In-Reply-To: <f97e26f0-8a43-eef7-b228-5fa5f3f0bffc@redhat.com>
References: <20230901155812.2696560-1-nsg@linux.ibm.com>
 <20230901155812.2696560-4-nsg@linux.ibm.com>
 <f97e26f0-8a43-eef7-b228-5fa5f3f0bffc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aPmQFK19cXEjIlEiMe1LrNIClQzYIDcI
X-Proofpoint-GUID: 2bgfTBUYEafRCL7Oy6giEOFJzz10jHll
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050131
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

On Tue, 2023-09-05 at 15:26 +0200, Thomas Huth wrote:
> On 01/09/2023 17.57, Nina Schoetterl-Glausch wrote:
> > From: Pierre Morel <pmorel@linux.ibm.com>
> >=20
> > On interception of STSI(15.1.x) the System Information Block
> > (SYSIB) is built from the list of pre-ordered topology entries.
> >=20
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > ---
> >   MAINTAINERS                      |   1 +
> >   qapi/machine-target.json         |  14 ++
> >   include/hw/s390x/cpu-topology.h  |  25 +++
> >   include/hw/s390x/sclp.h          |   1 +
> >   target/s390x/cpu.h               |  76 ++++++++
> >   hw/s390x/cpu-topology.c          |   2 +
> >   target/s390x/kvm/kvm.c           |   5 +-
> >   target/s390x/kvm/stsi-topology.c | 296 ++++++++++++++++++++++++++++++=
+
> >   target/s390x/kvm/meson.build     |   3 +-
> >   9 files changed, 421 insertions(+), 2 deletions(-)
> >   create mode 100644 target/s390x/kvm/stsi-topology.c

[...]

> > diff --git a/include/hw/s390x/cpu-topology.h b/include/hw/s390x/cpu-top=
ology.h
> > index 97b0af2795..fc15acf297 100644
> > --- a/include/hw/s390x/cpu-topology.h
> > +++ b/include/hw/s390x/cpu-topology.h
> > @@ -15,10 +15,35 @@
> >   #include "hw/boards.h"
> >   #include "qapi/qapi-types-machine-target.h"
> >  =20
> > +#define S390_TOPOLOGY_CPU_IFL   0x03
> > +
> > +typedef union s390_topology_id {
> > +    uint64_t id;
> > +    struct {
> > +        uint8_t _reserved0;
> > +        uint8_t drawer;
> > +        uint8_t book;
> > +        uint8_t socket;
> > +        uint8_t type;
> > +        uint8_t inv_polarization;
>=20
> What sense does it make to store the polarization in an inverted way? ...=
 I=20
> don't get that ... could you please at least add a comment somewhere for =
the=20
> rationale?
>=20

It inverts the ordering with regards to polarization, as required by
the  PoP. The dedication is inverted for the same reason, dedicated
CPUs show up before non dedicated ones, so the id must have a lower
value.
I will add a comment.

> > +        uint8_t not_dedicated;
> > +        uint8_t origin;
> > +    };
> > +} s390_topology_id;

[...]

> > + * fill_tle_cpu:
> > + * @p: The address of the CPU TLE to fill
> > + * @entry: a pointer to the S390TopologyEntry defining this
> > + *         CPU container.
> > + *
> > + * Returns the next free TLE entry.
> > + */
> > +static char *fill_tle_cpu(char *p, S390TopologyEntry *entry)
> > +{
> > +    SysIBCPUListEntry *tle =3D (SysIBCPUListEntry *)p;
> > +    s390_topology_id topology_id =3D entry->id;
> > +
> > +    tle->nl =3D 0;
> > +    tle->flags =3D 3 - topology_id.inv_polarization;
>=20
> Can you avoid the magic number 3 here?

Hmm, any number larger than 2 will do.
I could also use a int8_t and just negate, but relying on the
reinterpretation of two's complement is also magical.
I guess S390_CPU_ENTITLEMENT_HIGH makes the most sense.

[...]

> > +/**
> > + * s390_topology_fill_list_sorted:
> > + *
> > + * Loop over all CPU and insert it at the right place
> > + * inside the TLE entry list.
> > + * Fill the S390Topology list with entries according to the order
> > + * specified by the PoP.
> > + */
> > +static void s390_topology_fill_list_sorted(S390TopologyList *topology_=
list)
> > +{
> > +    CPUState *cs;
> > +    S390TopologyEntry sentinel;
> > +
> > +    QTAILQ_INIT(topology_list);
> > +
> > +    sentinel.id.id =3D cpu_to_be64(UINT64_MAX);
> > +    QTAILQ_INSERT_HEAD(topology_list, &sentinel, next);
> > +
> > +    CPU_FOREACH(cs) {
> > +        s390_topology_id id =3D s390_topology_from_cpu(S390_CPU(cs));
> > +        S390TopologyEntry *entry, *tmp;
> > +
> > +        QTAILQ_FOREACH(tmp, topology_list, next) {
> > +            if (id.id =3D=3D tmp->id.id) {
> > +                entry =3D tmp;
> > +                break;

I think I'll add a comment here.

/*
 * Earlier bytes have higher order -> big endian.
 * E.g. an entry with higher drawer number should be later in the list,
 * no matter the later fields (book, socket, etc)
 */


> > +            } else if (be64_to_cpu(id.id) < be64_to_cpu(tmp->id.id)) {
> > +                entry =3D g_malloc0(sizeof(*entry));
>=20
> Maybe nicer to use g_new0 here instead?

I don't think it makes much of a difference.

>=20
> > +                entry->id.id =3D id.id;
>=20
> Should this get a cpu_to_be64() ?

No, there is no interpretation of the value here, just a copy.
>=20
> > +                QTAILQ_INSERT_BEFORE(tmp, entry, next);
> > +                break;
> > +            }
> > +        }
> > +        s390_topology_add_cpu_to_entry(entry, S390_CPU(cs));
> > +    }
> > +
> > +    QTAILQ_REMOVE(topology_list, &sentinel, next);
> > +}
>=20
>   Thomas
>=20
>=20


