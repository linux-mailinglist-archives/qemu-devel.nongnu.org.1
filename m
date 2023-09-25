Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EFD7ADC99
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 18:03:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qko2Q-0002VJ-6s; Mon, 25 Sep 2023 12:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qko2O-0002SU-1S; Mon, 25 Sep 2023 12:02:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qko2K-0006TF-QV; Mon, 25 Sep 2023 12:02:19 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38PFxVOE021929; Mon, 25 Sep 2023 16:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ldSq3mPmZXzCkOjIaIAHTDDxwYJgNolnyqCI8r3EgyE=;
 b=f7XjOV2f4uWbnIv5SKk7XUEd+8/tdIwzbdC8Cb4a/I64KNLXsgXwGQ47R3h/TcAgT1uv
 XWt4OOjgHiQThC24JhvXLgPxJ1dq+Y9LIbLg6VqcQuZ+YjBnhqea4CebAWH4QxBy0cJl
 SBHslSxG6lvPI6puE5x/p4FlpsahwhEQnjlzLisfQ/W/o6IoXivzahP/ahIYo6wpPtok
 28oSFSZlShRZnshOZe1qWTtKjwV/Bg7kGLk1yc2xo5XGaXajCthLpYDrVBh1cpzVzgwm
 8AwFPDb7/K0d3dLYAw2MpCkFnCvBCkauK9lZwUaETGFmXPtipUaa5DzSGq/vbkZHyV3M 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbcths28t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Sep 2023 16:01:02 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38PFqXmY032492;
 Mon, 25 Sep 2023 16:01:00 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbcths26y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Sep 2023 16:00:59 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38PEaKv3030736; Mon, 25 Sep 2023 16:00:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjjk3ma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Sep 2023 16:00:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38PG0tuE11469446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Sep 2023 16:00:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C55A2004D;
 Mon, 25 Sep 2023 16:00:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 129CD20043;
 Mon, 25 Sep 2023 16:00:54 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.62.152]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Sep 2023 16:00:53 +0000 (GMT)
Message-ID: <9dd553299e7397aa6cbd2b533712c098c4ea7b3e.camel@linux.ibm.com>
Subject: Re: [PATCH v23 08/20] qapi/s390x/cpu topology: set-cpu-topology qmp
 command
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
Date: Mon, 25 Sep 2023 18:00:53 +0200
In-Reply-To: <87y1h1hyaa.fsf@pond.sub.org>
References: <20230914120650.1318932-1-nsg@linux.ibm.com>
 <20230914120650.1318932-9-nsg@linux.ibm.com> <87y1h1hyaa.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vDe4D04Y8SS1or3fWgkNw902vhczXPyt
X-Proofpoint-GUID: CmWSZKPTesnv00G2dh1tFsemp6HvLI8E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_12,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250119
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

On Wed, 2023-09-20 at 13:36 +0200, Markus Armbruster wrote:
> Nina Schoetterl-Glausch <nsg@linux.ibm.com> writes:
>=20
> > From: Pierre Morel <pmorel@linux.ibm.com>
> >=20
> > The modification of the CPU attributes are done through a monitor
> > command.
> >=20
> > It allows to move the core inside the topology tree to optimize
> > the cache usage in the case the host's hypervisor previously
> > moved the CPU.
> >=20
> > The same command allows to modify the CPU attributes modifiers
> > like polarization entitlement and the dedicated attribute to notify
> > the guest if the host admin modified scheduling or dedication of a vCPU=
.
> >=20
> > With this knowledge the guest has the possibility to optimize the
> > usage of the vCPUs.
> >=20
> > The command has a feature unstable for the moment.
> >=20
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > ---
> >  qapi/machine-target.json |  37 +++++++++++
> >  hw/s390x/cpu-topology.c  | 132 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 169 insertions(+)
> >=20
> > diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> > index 0d45a590ce..e47a252bd9 100644
> > --- a/qapi/machine-target.json
> > +++ b/qapi/machine-target.json

[...]

> > +# Modifies the topology by moving the CPU inside the topology
> > +# tree or by changing a modifier attribute of a CPU.
> > +# Default value for optional parameter is the current value
> > +# used by the CPU.
>=20
> So, anything absent will not be changed.  Maybe that's a clearer way to
> put it.  What do you think?

Yes.

>=20
> > +#
> > +# Returns: Nothing on success, the reason on failure.
> > +#
> > +# Since: 8.2
> > +##
> > +{ 'command': 'set-cpu-topology',
> > +  'data': {
> > +      'core-id': 'uint16',
> > +      '*socket-id': 'uint16',
> > +      '*book-id': 'uint16',
> > +      '*drawer-id': 'uint16',
>=20
> CpuInstanceProperties uses 'int' for these.  Any particular reason for
> the difference?

unsigned -> no need to check if >0
16bit is also the width the hardware uses for these values on s390.

> > +      '*entitlement': 'CpuS390Entitlement',
> > +      '*dedicated': 'bool'
> > +  },
> > +  'features': [ 'unstable' ],
> > +  'if': { 'all': [ 'TARGET_S390X' , 'CONFIG_KVM' ] }
> > +}
>=20
> [...]
>=20


