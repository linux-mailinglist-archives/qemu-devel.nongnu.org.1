Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A3E7A9C22
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 21:09:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjP2y-0006C8-F7; Thu, 21 Sep 2023 15:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qjP2u-0006Bt-SE; Thu, 21 Sep 2023 15:09:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qjP2p-0000Hb-8f; Thu, 21 Sep 2023 15:09:03 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38LJ6i83029903; Thu, 21 Sep 2023 19:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=9fZ4fwSHIeDPVJRLZo5bkHJu4t5rh533Nd+JtXkdqlM=;
 b=YZG/2kozBAZJvH/DRjBXaqYCBSa2imRVY1frYt/qi3tgpKXsxhslWIwVq5bklBfRD4Fb
 u37Dfp0chXMAFbLnvm3yAJanEjnXvIYYP8WuShVPF9p7sPypErqRYYSXdDk8AKu24j4S
 xd0KZIIrmjmq5lgRkwwSY4GeJ/d9RB1M5d7T3aoEFlGxiG4M0UkcpByQCsIC2ChQkLa5
 38oMSUnoj4JIpW3AMM0lsAYS12PgMY9PjmwOgXiRE/l2CRZICN2l3UymZG+VBOBoCEZp
 2Q+xpFpsLZV1FZMccmpB91jsKjSeTBZP+B9SnxrkhjGR3Y+LcX6jf345KXealeFa5VNx Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t8tsnhm1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Sep 2023 19:08:44 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38LJ79Bn000778;
 Thu, 21 Sep 2023 19:08:16 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t8tsnhfyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Sep 2023 19:08:16 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38LI48R7015447; Thu, 21 Sep 2023 19:02:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t8tsp0rcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Sep 2023 19:02:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38LJ232321365286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Sep 2023 19:02:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AFCA20040;
 Thu, 21 Sep 2023 19:02:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3318620043;
 Thu, 21 Sep 2023 19:02:03 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.152.224.238])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 Sep 2023 19:02:03 +0000 (GMT)
Message-ID: <4bcf0aa2c2846f300a2ffcf4257a38f1d39647ef.camel@linux.ibm.com>
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
Date: Thu, 21 Sep 2023 21:02:02 +0200
In-Reply-To: <875y45kt8i.fsf@pond.sub.org>
References: <20230914120650.1318932-1-nsg@linux.ibm.com>
 <20230914120650.1318932-2-nsg@linux.ibm.com> <87ediuwcrt.fsf@pond.sub.org>
 <e6ab27f4ef55d88f9585101434f900bd066145d6.camel@linux.ibm.com>
 <875y45kt8i.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hDbbOdEvy4P1Ks13jInEw-CnfU6bxMRz
X-Proofpoint-GUID: wokNSYuPwH2LbMOUmCEPDWfFxbNO3Uu3
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_16,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309210163
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

On Wed, 2023-09-20 at 12:57 +0200, Markus Armbruster wrote:
> Nina Schoetterl-Glausch <nsg@linux.ibm.com> writes:
>=20
> > On Tue, 2023-09-19 at 14:47 +0200, Markus Armbruster wrote:
> > > Nina Schoetterl-Glausch <nsg@linux.ibm.com> writes:
> > >=20
> > > > From: Pierre Morel <pmorel@linux.ibm.com>
> > > >=20
> > > > S390 adds two new SMP levels, drawers and books to the CPU
> > > > topology.
> > > > S390 CPUs have specific topology features like dedication and
> > > > entitlement. These indicate to the guest information on host
> > > > vCPU scheduling and help the guest make better scheduling decisions.
> > > >=20
> > > > Let us provide the SMP properties with books and drawers levels
> > > > and S390 CPU with dedication and entitlement,
> > > >=20
> > > > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > > > Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > > > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > > > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > > > ---
> > > >  qapi/machine-common.json            | 21 +++++++++++++
> > > >  qapi/machine.json                   | 19 ++++++++++--
> > > >  include/hw/boards.h                 | 10 +++++-
> > > >  include/hw/qdev-properties-system.h |  4 +++
> > > >  target/s390x/cpu.h                  |  6 ++++
> > > >  hw/core/machine-smp.c               | 48 ++++++++++++++++++++++++-=
----
> > > >  hw/core/machine.c                   |  4 +++
> > > >  hw/core/qdev-properties-system.c    | 13 ++++++++
> > > >  hw/s390x/s390-virtio-ccw.c          |  4 +++
> > > >  softmmu/vl.c                        |  6 ++++
> > > >  target/s390x/cpu.c                  |  7 +++++
> > > >  qapi/meson.build                    |  1 +
> > > >  qemu-options.hx                     |  7 +++--
> > > >  13 files changed, 137 insertions(+), 13 deletions(-)
> > > >  create mode 100644 qapi/machine-common.json
> > > >=20
> > > > diff --git a/qapi/machine-common.json b/qapi/machine-common.json
> > > > new file mode 100644
> > > > index 0000000000..e40421bb37
> > > > --- /dev/null
> > > > +++ b/qapi/machine-common.json
> > >=20
> > > Why do you need a separate QAPI sub-module?
> >=20
> > See here https://lore.kernel.org/qemu-devel/d8da6f7d1e3addcb63614f548ed=
77ac1b8895e63.camel@linux.ibm.com/
>=20
> Quote:
>=20
>     CpuS390Entitlement would be useful in both machine.json and machine-t=
arget.json
>=20
> This is not obvious from this patch.  I figure this patch could add it
> to machine.json just fine.  The use in machine-target.json in appears
> only in PATCH 08.

Want me to add the rational to the commit message?

>=20
>     because query-cpu-fast is defined in machine.json and set-cpu-topolog=
y is defined
>     in machine-target.json.
>=20
>     So then the question is where best to define CpuS390Entitlement.
>     In machine.json and include machine.json in machine-target.json?
>     Or define it in another file and include it from both?
>=20
> You do the latter in this patch.
>=20
> I figure the former would be tolerable, too.
>=20
> That said, having target-specific stuff in machine.json feels... odd.
> Before this series, we have CpuInfoS390 and CpuS390State there, for
> query-cpus-fast.  That command returns a list of objects where common
> members are target-independent, and the variant members are
> target-dependent.  qmp_query_cpus_fast() uses a CPU method to populate
> the target-dependent members.
>=20
> I'm not sure splitting query-cpus-fast into a target-dependent and a
> target-independent part is worth the bother.
>=20
> In this patch, you work with the structure you found.  Can't fault you
> for that :)
>=20
> > > > @@ -0,0 +1,21 @@
> > > > +# -*- Mode: Python -*-
> > > > +# vim: filetype=3Dpython
> > > > +#
> > > > +# This work is licensed under the terms of the GNU GPL, version 2 =
or later.
> > > > +# See the COPYING file in the top-level directory.
> > > > +
> > > > +##
> > > > +# =3D Machines S390 data types
> > > > +##
> > > > +
> > > > +##
> > > > +# @CpuS390Entitlement:
> > > > +#
> > > > +# An enumeration of cpu entitlements that can be assumed by a virt=
ual
> > > > +# S390 CPU
> > > > +#
> > > > +# Since: 8.2
> > > > +##
> > > > +{ 'enum': 'CpuS390Entitlement',
> > > > +  'prefix': 'S390_CPU_ENTITLEMENT',
> > > > +  'data': [ 'auto', 'low', 'medium', 'high' ] }
> > > > diff --git a/qapi/machine.json b/qapi/machine.json
> > > > index a08b6576ca..a63cb951d2 100644
> > > > --- a/qapi/machine.json
> > > > +++ b/qapi/machine.json
> > > > @@ -9,6 +9,7 @@
> > >    ##
> > >    # =3D Machines
> > > >  ##
> > > >=20=20
> > > >  { 'include': 'common.json' }
> > > > +{ 'include': 'machine-common.json' }
> > >=20
> > > Section structure is borked :)
> > >=20
> > > Existing section "Machine" now ends at the new "Machines S390 data
> > > types" you pull in here.  The contents of below moves from "Machines"=
 to
> > > "Machines S390 data types".
> > >=20
> > > Before I explain how to avoid this, I'd like to understand why we nee=
d a
> > > new sub-module.
> > >=20
> > > >=20=20
> > > >  ##
> > > >  # @SysEmuTarget:
> > > > @@ -71,7 +72,7 @@
> > >    ##
> > >    # @CpuInfoFast:
> > >    #
> > >    # Information about a virtual CPU
> > >    #
> > >    # @cpu-index: index of the virtual CPU
> > >    #
> > >    # @qom-path: path to the CPU object in the QOM tree
> > > >  #
> > > >  # @thread-id: ID of the underlying host thread
> > > >  #
> > > > -# @props: properties describing to which node/socket/core/thread
> > > > +# @props: properties describing to which node/drawer/book/socket/c=
ore/thread
> > > >  #     virtual CPU belongs to, provided if supported by board
> > >=20
> > > Is this description accurate?
> >=20
> > Kinda, although the wording might not be the best.
> > All the CpuInstanceProperties fields are optional, it's like a superset=
 of possible
> > properties across architectures.
> > Only a subset might be returned by query-cpus-fast.
>=20
> Let's see whether I got this right...
>=20
> The members of CpuInstanceProperties are properties you can pass to
> device_add for some targets.

Yes.

>=20
> The members present in a response from query-cpus-fast are properties
> you must pass to device_add in this VM.  Or is that a "may pass"?

On x86 must pass, s390x may pass, I haven't checked other architectures.
s390x shows the defaults calculated.

>=20
> On what exactly does the set of present members depend?  Just the
> target?  The machine type?  The CPU?  Anything else?

The target and the machine I'd say.
On x86 if you have one die per socket you don't need to provide a die_id on=
 device_add.
>=20
> > Also die and cluster are missing.
>=20
> Does this need fixing?

Only if we keep the list of properties here.

> > > @props is of type CpuInstanceProperties, shown below.  Its documentat=
ion
> > > describes it as "properties to be used for hotplugging a CPU instance,
> > > it should be passed by management with device_add command when a CPU =
is
> > > being hotplugged."  Hmm.
> > >=20
> > > I figure details ("node/drawer/book/socket/core/thread") are better l=
eft
> > > to CpuInstanceProperties.
> > >=20
> > > The "provided if supported by board" part makes no sense to me.  If
> > > @props is there, it lists the properties we need to provide with
> > > device_add.  What if it's not there?  Same as empty list, i.e. we don=
't
> > > need to provide properties with device_add?
> >=20
> > There are default values/default logic.
> > For s390x, socket, book, drawer are calculated from the core id
> > if not provided with device_add.
> > Partial specifications are rejected.
>=20
> Undocumented magic?

Patch 13 documents it:

Default topology usage
----------------------

[...]

When a CPU is defined by the ``-device`` command argument, the
tree topology attributes must all be defined or all not defined.

.. code-block:: bash

    -device gen16b-s390x-cpu,drawer-id=3D1,book-id=3D1,socket-id=3D2,core-i=
d=3D1

or

.. code-block:: bash

    -device gen16b-s390x-cpu,core-id=3D1,dedicated=3Dtrue

If none of the tree attributes (drawer, book, sockets), are specified
for the ``-device`` argument, like for all CPUs defined with the ``-smp``
command argument the topology tree attributes will be set by simply
adding the CPUs to the topology based on the core-id.

QEMU will not try to resolve collisions and will report an error if the
CPU topology defined explicitly or implicitly on a ``-device``
argument collides with the definition of a CPU implicitly defined
on the ``-smp`` argument.

When the topology modifier attributes are not defined for the
``-device`` command argument they takes following default values:

- dedicated: ``false``
- entitlement: ``medium``


Hot plug
++++++++

New CPUs can be plugged using the device_add hmp command as in:

.. code-block:: bash

  (qemu) device_add gen16b-s390x-cpu,core-id=3D9

The placement of the CPU is derived from the core-id as described above.

The topology can of course also be fully defined:

.. code-block:: bash

    (qemu) device_add gen16b-s390x-cpu,drawer-id=3D1,book-id=3D1,socket-id=
=3D2,core-id=3D1
>=20
> > > Not your patch's fault, but let's get this in shape if we can.
>=20
> [...]
>=20


