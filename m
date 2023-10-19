Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA7E7CF489
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 11:59:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPnn-0001uQ-R0; Thu, 19 Oct 2023 05:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qtPnc-0001Z0-7q; Thu, 19 Oct 2023 05:58:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1qtPnZ-0007Bw-S1; Thu, 19 Oct 2023 05:58:39 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39J9vQPJ020424; Thu, 19 Oct 2023 09:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=7UCw8gqcX8rmfJGucnEkFUQcWfBlCd12cwD7PXxd7i0=;
 b=rBuYCd5tmd5xJ5+9Y7q0m+VaHHyjA4X2GV4I/vKkq/RSFDl9z5hIH2fB0gRC/I21XEfx
 YwmOvr6fq+AKNJoZCzPJ5nD3sQYmUzzE83WkFXd8RTCfG7TNppxqxTN1+Cf/vKx3iSjF
 qjc0YP+QgraUIvuWiZJbjCysZfe/DM/ap4VzfQ73R0U3Ik66LfuGXS3c4NKYBGPR+olg
 By1QmJJM1X6BSI4j2cu1JueZdvVhDLW4XWk7fD2MF2i4tboQ80+cpoBFfCfliPo0bDxg
 VoqfUE4D+tf4Mxrpd5wCACPrakMIjNB6q4L/iqCuvlVCjMBxBNMxaiUzxClxBH1xktnw XA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu29c0025-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 09:57:25 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39J9vPsK020307;
 Thu, 19 Oct 2023 09:57:25 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu29c001e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 09:57:24 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39J8RBxt020508; Thu, 19 Oct 2023 09:57:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6anfxxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 09:57:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39J9vKZ415073884
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 09:57:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45A1D2005A;
 Thu, 19 Oct 2023 09:57:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1ED8C20040;
 Thu, 19 Oct 2023 09:57:19 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.71.149]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Oct 2023 09:57:19 +0000 (GMT)
Message-ID: <f1620197264e60dec8f08933cc26ffb8901ddf41.camel@linux.ibm.com>
Subject: Re: [PATCH v26 01/21] qapi: machine.json: change docs regarding CPU
 topology
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>, Halil
 Pasic <pasic@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Eric Blake
 <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Cleber Rosa
 <crosa@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Date: Thu, 19 Oct 2023 11:57:18 +0200
In-Reply-To: <794c2523-b64c-4d16-b156-07a9e3aa94c2@redhat.com>
References: <20231016183925.2384704-1-nsg@linux.ibm.com>
 <20231016183925.2384704-2-nsg@linux.ibm.com> <878r81bn8b.fsf@pond.sub.org>
 <794c2523-b64c-4d16-b156-07a9e3aa94c2@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RZM46fOx3T-kYuHw04ANmSUuDeWUuvzU
X-Proofpoint-GUID: 7Yu66CNT_Usbu4FhN32hVd2cLIM2bZzs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_08,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 mlxlogscore=766 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190084
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

On Tue, 2023-10-17 at 13:10 +0200, Thomas Huth wrote:
> On 17/10/2023 11.40, Markus Armbruster wrote:
> > Nina Schoetterl-Glausch <nsg@linux.ibm.com> writes:
> >=20
> > > Clarify roles of different architectures.
> > > Also change things a bit in anticipation of additional members being
> > > added.
> > >=20
> > > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > > ---
> > >   qapi/machine.json | 58 +++++++++++++++++++++++++++++++-------------=
---
> > >   1 file changed, 38 insertions(+), 20 deletions(-)
> ...
> >=20
> > Address my nitpicks one way or the other, and you may add
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> >=20
>=20
> Thanks Markus!
>=20
> Nina, if you agree, I can fix the nitpicks while picking the patches up, =
so=20
> you don't have to respin again?

Thanks for going ahead with it! I was out sick the last couple of days.

>=20
>   Thomas
>=20


