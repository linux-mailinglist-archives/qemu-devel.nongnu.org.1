Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F177C8644
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 14:59:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHl1-0000Il-2q; Fri, 13 Oct 2023 08:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qrHkv-0000Fk-DC; Fri, 13 Oct 2023 08:59:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qrHks-00033U-Rh; Fri, 13 Oct 2023 08:59:05 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39DCstot013220; Fri, 13 Oct 2023 12:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=SXKA377UbO2rfbitWAb6fKOzcxwmIEO5ttzSaX759k4=;
 b=pP9VlEME2WoaRgziwgXAYhA+i5g4EG8dabgyHbz+WrzCz30U5Awm2KMWWXbEAHHy78oz
 WHfjk/fACWYXfodYEd7QuoVdtiNPMp2vXbMSDC/HHXF4gbitUUfC5z+18we9HwMoNRr9
 vCZXN6S4s6cfV0sBqDg4rtWILjpA/l+n8/be68iu8h8WEsup27FT3+imxd25GNg+9S9j
 7yWmUW2F/mrbRe8mgFv8FP08O1o8PTg9RB66U5Y8surM8po9oum627PTX7WOUOQDgmdv
 xwBTgbV+o88MvG82pNFHe0OwnffjV+sBOTNPzkPmBQdbp++mI9EWGlo1AxAw8uyJ+LH/ 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq6ajg5nh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Oct 2023 12:58:47 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39DCt4wP013870;
 Fri, 13 Oct 2023 12:58:47 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq6ajg5ma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Oct 2023 12:58:47 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39DBPaMI029771; Fri, 13 Oct 2023 12:58:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tpt5bkywp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Oct 2023 12:58:46 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39DCwheh14156496
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 12:58:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2664020049;
 Fri, 13 Oct 2023 12:58:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1424F2004B;
 Fri, 13 Oct 2023 12:58:42 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.74.130]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Oct 2023 12:58:41 +0000 (GMT)
Message-ID: <fc5f73d3084259a23af3c35cbc54fb6b6780fb7b.camel@linux.ibm.com>
Subject: Re: [PATCH v25 02/21] CPU topology: extend with s390 specifics
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
Date: Fri, 13 Oct 2023 14:58:41 +0200
In-Reply-To: <87cyxkxfwz.fsf@pond.sub.org>
References: <20231005160155.1945588-1-nsg@linux.ibm.com>
 <20231005160155.1945588-3-nsg@linux.ibm.com> <87cyxkxfwz.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WWRHOGoGp1juwFbnZNyXZ481pPemGmzG
X-Proofpoint-ORIG-GUID: 2Oa5GLodg-cTxujy0nfyFNEI8Ahw6u5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130107
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

On Thu, 2023-10-12 at 13:02 +0200, Markus Armbruster wrote:
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
>=20
> This is vague.  Peeking at the patch, I can see it adds properties
> "socket-id", "book-id", "drawer-id", "dedicated", and "entitlement" to
> "s390x-cpu" objects.  Suggest to spell that out here.
>=20
> > Add machine-common.json so we can later include it in
> > machine-target.json also.
> >=20
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > ---
> >  MAINTAINERS                         |  1 +
> >  qapi/machine-common.json            | 21 +++++++++++++
> >  qapi/machine.json                   | 17 +++++++++-
> >  qapi/qapi-schema.json               |  1 +
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
> >  15 files changed, 139 insertions(+), 11 deletions(-)
> >  create mode 100644 qapi/machine-common.json
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 81625f036b..3f6888aa86 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1775,6 +1775,7 @@ F: hw/core/null-machine.c
> >  F: hw/core/numa.c
> >  F: hw/cpu/cluster.c
> >  F: qapi/machine.json
> > +F: qapi/machine-common.json
> >  F: qapi/machine-target.json
> >  F: include/hw/boards.h
> >  F: include/hw/core/cpu.h
> > diff --git a/qapi/machine-common.json b/qapi/machine-common.json
> > new file mode 100644
> > index 0000000000..fa6bd71d12

[...]=20

> >  ##
> >  # @SysEmuTarget:
> > @@ -904,7 +905,13 @@
> >  #
> >  # @node-id: NUMA node ID the CPU belongs to
> >  #
> > -# @socket-id: socket number within node/board the CPU belongs to
> > +# @drawer-id: drawer number within node/board the CPU belongs to
> > +#     (since 8.2)
> > +#
> > +# @book-id: book number within drawer/node/board the CPU belongs to
> > +#     (since 8.2)
> > +#
> > +# @socket-id: socket number within book/node/board the CPU belongs to
> >  #
> >  # @die-id: die number within socket the CPU belongs to (since 4.1)
> >  #
>    # @cluster-id: cluster number within die the CPU belongs to (since
>    #     7.1)
>    #
>    # @core-id: core number within cluster the CPU belongs to
>    #
>    # @thread-id: thread number within core the CPU belongs to
>=20
> So...
>=20
> * A thread can only be within a core
>=20
> * A core can only be within a cluster
>=20
> * A cluster can only be within a die
>=20
> * A die can only be within a socket
>=20
> * A socket can be within a book, node, or board
>=20
> * A book can be within a drawer, node, or board
>=20
> * A drawer can be within a node, or board
>=20
> * A node is a NUMA node
>=20
> * A board is what exactly?  can we have more than one?  is node always
>   within a/the board?

Yeah, the description is confusing.
>=20
> Asked differently: what are the possible hierarchies of things?

The way I understand things is:
* Different architectures have different hierarchies, say
  1. (thread, core, cluster, die, socket)
  2. (thread, core, socket, book, drawer)

We define a qemu artificial ordered super set
(thread, core, cluster, die, socket, book, drawer)
where architectures can choose a subset of, specifying that they
support a certain level or not.

Now if for example x86 wanted to support a book level between
thread and core, we'd need to change a bunch of code and make
things more complicated.

The NUMA node-id maps a hierarchy tuple to a node, I don't think
it's part of hierarchy itself.

Now the question is how to document this.
On s390x there is no cluster, so what does

@core-id: core number within cluster the CPU belongs to

mean?

We could say, that within the qemu super set there is a virtual
cluster of which there is one per die (and one die per socket).

Or we rewrite the documentation to say

@x-id: x number within the upper hierarchy container

to account for the fact that the upper container is different
on different architectures.


>=20
> > @@ -923,6 +930,8 @@
> >  { 'struct': 'CpuInstanceProperties',
> >    # Keep these in sync with the properties device_add accepts
> >    'data': { '*node-id': 'int',
> > +            '*drawer-id': 'int',
> > +            '*book-id': 'int',
> >              '*socket-id': 'int',
> >              '*die-id': 'int',
> >              '*cluster-id': 'int',
> > @@ -1481,6 +1490,10 @@
> >  #
> >  # @cpus: number of virtual CPUs in the virtual machine
> >  #
> > +# @drawers: number of drawers in the CPU topology (since 8.2)
> > +#
> > +# @books: number of books in the CPU topology (since 8.2)
> > +#
> >  # @sockets: number of sockets in the CPU topology
>=20
> Total numer of sockets?  Or number of sockets per whatever thing
> contains sockets?

The latter. I'll change this
>=20
> Same question for @books, @drawers, and @cpus.

Same for the first two, total for @cpus.
>=20
> The documentation is less than clear before your patch; your patch
> merely makes me look at it.  We may decide that addressing the lack of
> clarity is not your patch's job, and leave it for later.

Yeah, same problem here around different architectures using different sub =
sets.
>=20
> >  #
> >  # @dies: number of dies per socket in the CPU topology
> > @@ -1499,6 +1512,8 @@
> >  ##
> >  { 'struct': 'SMPConfiguration', 'data': {
> >       '*cpus': 'int',
> > +     '*drawers': 'int',
> > +     '*books': 'int',
> >       '*sockets': 'int',
> >       '*dies': 'int',
> >       '*clusters': 'int',

[...]

