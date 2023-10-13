Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 234C27C84DA
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 13:48:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrGdD-0005SI-Qg; Fri, 13 Oct 2023 07:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qrGd9-0005RM-OE; Fri, 13 Oct 2023 07:46:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qrGd7-0005O9-8i; Fri, 13 Oct 2023 07:46:59 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39DBipvm032330; Fri, 13 Oct 2023 11:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=T7IAfEu01DJgQZXIYVQde7TwS0ylyDApBCeiA5Vrze4=;
 b=C64KhpF25tvkcnrS1yAU2MKaOu/s3kBobgQZmWcMPfWvSdIqxiPUTUDOi1WkXcuxYHyY
 UgEyhrrhraeszd8QnGRDtyFVjFcq6mKBBjS/r0ckgIhOLJDytCIg8RVPFjGJLuUXLUoe
 8tOu+v9PAHBTWkvYSTc6bcznq4Z5MSCyUehiyrKyWk7zOiMWnkxfa5hssL1ucpMyZB5I
 2Oe6vIp2j4AE6jmEdrRlXY3EyIVWcBlMEJPgxgSHZkOfvSpYtKse1Q8zuMUUULCgEn2q
 Fxx/rX0YNgpc5P9JghARMLo159ios4BhwDNx0ppWTOEVVTakE5vcULZfvJE3+cGkt0y9 gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq59t0187-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Oct 2023 11:46:45 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39DBj2UH000315;
 Fri, 13 Oct 2023 11:46:45 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq59t017w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Oct 2023 11:46:45 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39DBFIlj016372; Fri, 13 Oct 2023 11:46:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tpt583mtq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Oct 2023 11:46:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39DBkfx325100898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 11:46:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C03620043;
 Fri, 13 Oct 2023 11:46:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 641D420040;
 Fri, 13 Oct 2023 11:46:40 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.74.130]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Oct 2023 11:46:40 +0000 (GMT)
Message-ID: <eb68f75307c6ae359d93bc9b8e342a9214485e51.camel@linux.ibm.com>
Subject: Re: [PATCH v24 01/21] qapi: machine.json: change docs regarding
 CpuInstanceProperties
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
 Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>
Date: Fri, 13 Oct 2023 13:46:40 +0200
In-Reply-To: <87fs2gnzxn.fsf@pond.sub.org>
References: <20230926121534.406035-1-nsg@linux.ibm.com>
 <20230926121534.406035-2-nsg@linux.ibm.com> <87fs2gnzxn.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dSTYjqYN0YBeCHsRymxw86-aIlqFP6sQ
X-Proofpoint-ORIG-GUID: TYib23Zk7Q-6zOpIFuZooODQQ_rdea2Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130096
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

On Thu, 2023-10-12 at 07:59 +0200, Markus Armbruster wrote:
> Nina Schoetterl-Glausch <nsg@linux.ibm.com> writes:
>=20
> > Clarify roles of different architectures.
> > Also change things a bit in anticipation of additional members being
> > added.
> >=20
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > ---
> >=20
> >=20
> > Reference to s390x docs added in patch 14
> >=20
> >=20
> >  qapi/machine.json | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index a08b6576ca..3c074c9902 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -70,9 +70,9 @@
> >  # @qom-path: path to the CPU object in the QOM tree
> >  #
> >  # @thread-id: ID of the underlying host thread
> > -#
> > -# @props: properties describing to which node/socket/core/thread
> > -#     virtual CPU belongs to, provided if supported by board
> > +
>=20
> Keep the '#', please.
>=20
> > +# @props: properties of type CpuInstanceProperties associated with a
> > +#     virtual CPU, e.g. the socket id
> >  #
> >  # @target: the QEMU system emulation target, which determines which
> >  #     additional fields will be listed (since 3.0)
> > @@ -899,6 +899,9 @@
> >  # should be passed by management with device_add command when a CPU is
> >  # being hotplugged.
> >  #
> > +# Which members are optional and which mandatory depends on the archit=
ecture
> > +# and board.
>=20
> Long line.  Wrap like this:
>=20
>    # Which members are optional and which mandatory depends on the
>    # architecture and board.
>=20
> Would "depends on the machine type" be more precise?

Depends on the definition of "machine type" I guess.
"architecture and board" seems more descriptive to me.

>=20
> > +#
> >  # @node-id: NUMA node ID the CPU belongs to
> >  #
> >  # @socket-id: socket number within node/board the CPU belongs to
> > @@ -912,15 +915,13 @@
> >  #
> >  # @thread-id: thread number within core the CPU belongs to
> >  #
> > -# Note: currently there are 6 properties that could be present but
> > -#     management should be prepared to pass through other properties
> > -#     with device_add command to allow for future interface extension.
> > -#     This also requires the filed names to be kept in sync with the
> > -#     properties passed to -device/device_add.
> > +# Note: management should be prepared to pass through additional
> > +# properties with device_add.
>=20
> Indent the second line for consistency with other Note: sections:
>=20
>    # Note: management should be prepared to pass through additional
>    #     properties with device_add.
>=20
> >  #
> >  # Since: 2.7
> >  ##
> >  { 'struct': 'CpuInstanceProperties',
> > +  # Keep these in sync with the properties device_add accepts
> >    'data': { '*node-id': 'int',
> >              '*socket-id': 'int',
> >              '*die-id': 'int',
>=20


