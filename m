Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C64E7A6A3B
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 19:53:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qietI-00037s-8h; Tue, 19 Sep 2023 13:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qietG-00037e-Co; Tue, 19 Sep 2023 13:52:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qietB-0008NL-Hh; Tue, 19 Sep 2023 13:52:02 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38JHbnC1008441; Tue, 19 Sep 2023 17:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=FRM0fzJYZmOm2DrTYMMnazgtkFkcQU1q/9VoqtkHNYA=;
 b=mNaND8KgrxfABFs6c6V7jyyBVTmLLeevKCPtk9GrBIl9nQnaK0MEcHVbF1v+4GC0r/EG
 ohp/Z5Wew2gZ23MNVa9pImpMsm3cXwsr/B2ZuNADcFQZWS72kIKph858Bh+x9hv7YhH5
 RpGyqsvXlDKM7URl2pj+RrTVybCz+oOmhuCYTeGtpz7bkfRnBhfXXyqs/ZAyhnfroqN+
 qNjTV4WJojicjIcKMRMDaf3BkDdvZlX3RA6uB6Iq9at26hREUcEQ7tnjYCzLwC090fGe
 rjQvgfDxMoe3EX4EBgHz52glYJIceMpnn5vjz2RC/CnWJdfCPvMGOb38cxVefTIKsmkz tg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7du5c8su-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 17:51:41 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38JHc0PR009913;
 Tue, 19 Sep 2023 17:51:40 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7du5c8s6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 17:51:40 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38JHbuwL016463; Tue, 19 Sep 2023 17:51:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5sd1x3aq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 17:51:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38JHpamV35521014
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 17:51:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87B8320043;
 Tue, 19 Sep 2023 17:51:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19FA920040;
 Tue, 19 Sep 2023 17:51:36 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.152.224.238])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Sep 2023 17:51:36 +0000 (GMT)
Message-ID: <e6ab27f4ef55d88f9585101434f900bd066145d6.camel@linux.ibm.com>
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
Date: Tue, 19 Sep 2023 19:51:34 +0200
In-Reply-To: <87ediuwcrt.fsf@pond.sub.org>
References: <20230914120650.1318932-1-nsg@linux.ibm.com>
 <20230914120650.1318932-2-nsg@linux.ibm.com> <87ediuwcrt.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XkLfYnb9gXykk6cpwvCuCfzp2nWDh1Wd
X-Proofpoint-GUID: 6FgvPXjVzlhOtDR1SkJB0K3N3_YvUjwU
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_09,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190152
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

On Tue, 2023-09-19 at 14:47 +0200, Markus Armbruster wrote:
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
> > ---
> >  qapi/machine-common.json            | 21 +++++++++++++
> >  qapi/machine.json                   | 19 ++++++++++--
> >  include/hw/boards.h                 | 10 +++++-
> >  include/hw/qdev-properties-system.h |  4 +++
> >  target/s390x/cpu.h                  |  6 ++++
> >  hw/core/machine-smp.c               | 48 ++++++++++++++++++++++++-----
> >  hw/core/machine.c                   |  4 +++
> >  hw/core/qdev-properties-system.c    | 13 ++++++++
> >  hw/s390x/s390-virtio-ccw.c          |  4 +++
> >  softmmu/vl.c                        |  6 ++++
> >  target/s390x/cpu.c                  |  7 +++++
> >  qapi/meson.build                    |  1 +
> >  qemu-options.hx                     |  7 +++--
> >  13 files changed, 137 insertions(+), 13 deletions(-)
> >  create mode 100644 qapi/machine-common.json
> >=20
> > diff --git a/qapi/machine-common.json b/qapi/machine-common.json
> > new file mode 100644
> > index 0000000000..e40421bb37
> > --- /dev/null
> > +++ b/qapi/machine-common.json
>=20
> Why do you need a separate QAPI sub-module?

See here https://lore.kernel.org/qemu-devel/d8da6f7d1e3addcb63614f548ed77ac=
1b8895e63.camel@linux.ibm.com/
>=20
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
> > +#
> > +# Since: 8.2
> > +##
> > +{ 'enum': 'CpuS390Entitlement',
> > +  'prefix': 'S390_CPU_ENTITLEMENT',
> > +  'data': [ 'auto', 'low', 'medium', 'high' ] }
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index a08b6576ca..a63cb951d2 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -9,6 +9,7 @@
>    ##
>    # =3D Machines
> >  ##
> >=20=20
> >  { 'include': 'common.json' }
> > +{ 'include': 'machine-common.json' }
>=20
> Section structure is borked :)
>=20
> Existing section "Machine" now ends at the new "Machines S390 data
> types" you pull in here.  The contents of below moves from "Machines" to
> "Machines S390 data types".
>=20
> Before I explain how to avoid this, I'd like to understand why we need a
> new sub-module.
>=20
> >=20=20
> >  ##
> >  # @SysEmuTarget:
> > @@ -71,7 +72,7 @@
>    ##
>    # @CpuInfoFast:
>    #
>    # Information about a virtual CPU
>    #
>    # @cpu-index: index of the virtual CPU
>    #
>    # @qom-path: path to the CPU object in the QOM tree
> >  #
> >  # @thread-id: ID of the underlying host thread
> >  #
> > -# @props: properties describing to which node/socket/core/thread
> > +# @props: properties describing to which node/drawer/book/socket/core/=
thread
> >  #     virtual CPU belongs to, provided if supported by board
>=20
> Is this description accurate?

Kinda, although the wording might not be the best.
All the CpuInstanceProperties fields are optional, it's like a superset of =
possible
properties across architectures.
Only a subset might be returned by query-cpus-fast.
Also die and cluster are missing.
>=20
> @props is of type CpuInstanceProperties, shown below.  Its documentation
> describes it as "properties to be used for hotplugging a CPU instance,
> it should be passed by management with device_add command when a CPU is
> being hotplugged."  Hmm.
>=20
> I figure details ("node/drawer/book/socket/core/thread") are better left
> to CpuInstanceProperties.
>=20
> The "provided if supported by board" part makes no sense to me.  If
> @props is there, it lists the properties we need to provide with
> device_add.  What if it's not there?  Same as empty list, i.e. we don't
> need to provide properties with device_add?

There are default values/default logic.
For s390x, socket, book, drawer are calculated from the core id
if not provided with device_add.
Partial specifications are rejected.

>=20
> Not your patch's fault, but let's get this in shape if we can.
>=20
> >  #
> >  # @target: the QEMU system emulation target, which determines which
> > @@ -901,7 +902,11 @@
> >  #
> >  # @node-id: NUMA node ID the CPU belongs to
> >  #
> > -# @socket-id: socket number within node/board the CPU belongs to
> > +# @drawer-id: drawer number within node/board the CPU belongs to (sinc=
e 8.2)
> > +#
> > +# @book-id: book number within drawer/node/board the CPU belongs to (s=
ince 8.2)
>=20
> Long lines, please wrap:
>=20
>    # @drawer-id: drawer number within node/board the CPU belongs to
>    #     (since 8.2)
>    #
>    # @book-id: book number within drawer/node/board the CPU belongs to
>    #     (since 8.2)

Ok.
>=20
> > +#
> > +# @socket-id: socket number within book/node/board the CPU belongs to
> >  #
> >  # @die-id: die number within socket the CPU belongs to (since 4.1)
> >  #
> > @@ -912,7 +917,7 @@
>    ##
>    # @CpuInstanceProperties:
>    #
>    # List of properties to be used for hotplugging a CPU instance, it
>    # should be passed by management with device_add command when a CPU is
>    # being hotplugged.
>    #
>    # @node-id: NUMA node ID the CPU belongs to
>    #
>    # @socket-id: socket number within node/board the CPU belongs to
>    #
>    # @die-id: die number within socket the CPU belongs to (since 4.1)
>    #
>    # @cluster-id: cluster number within die the CPU belongs to (since
>    #     7.1)
>    #
>    # @core-id: core number within cluster the CPU belongs to
> >  #
> >  # @thread-id: thread number within core the CPU belongs to
> >  #
> > -# Note: currently there are 6 properties that could be present but
> > +# Note: currently there are 8 properties that could be present but
> >  #     management should be prepared to pass through other properties
> >  #     with device_add command to allow for future interface extension.
> >  #     This also requires the filed names to be kept in sync with the
>    #     properties passed to -device/device_add.
>=20
> The last sentence is for developers, not for users, which means it
> doesn't belong here.  Suggest to move it to a non-doc comment, and
> rephrase the note like
>=20
>    # Note: management should be prepared to pass through additional
>    # properties with device_add.
>=20
> > @@ -922,6 +927,8 @@
> >  ##
> >  { 'struct': 'CpuInstanceProperties',
>=20
> Non-doc comment could go here:
>=20
>      # Keep these in sync with the properties device_add accepts
>=20
> Again, not your patch's fault, but your help improving this stuff would
> be appreciated.
>=20
> >    'data': { '*node-id': 'int',
> > +            '*drawer-id': 'int',
> > +            '*book-id': 'int',
> >              '*socket-id': 'int',
> >              '*die-id': 'int',
> >              '*cluster-id': 'int',
>                '*core-id': 'int',
>                '*thread-id': 'int'
>      }
>    }
>=20

[...]

