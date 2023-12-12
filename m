Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C829A80F0EA
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 16:30:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD4gV-0003PL-2W; Tue, 12 Dec 2023 10:28:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rD4gN-0003NO-2v; Tue, 12 Dec 2023 10:28:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rD4gK-0003yK-IX; Tue, 12 Dec 2023 10:28:26 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BCFRr4l013475; Tue, 12 Dec 2023 15:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=KP64VobsLdOAuv1AtbTCIgvFchtqQBURHEdfgmIFbms=;
 b=WHae3OjPfEaw90aOET0I/KdA3jeF7PZwTsFFnhSpHE+aNuzj0g9NyjJB8RlKZCTjW2r2
 VB2bEqS1rHV6nT18bIN701hdir9yX+xVxRI/yHZrvXJd2VbN2YpkCFav3haDni9DW+al
 y29NVWLGIqqzWIptCsRiX4lZevgVrWVRk5O7pNFzzlym4sE+8sRdN5RfpkzMHnX1qVQj
 2zWK/cV0qSMzi10JnIkNSvaa90iBZNBFetc3V0GOmrTjtGGQ+HLPRkrNERsHCPlcN3Sg
 TiqJnMIH2pAZjxrpJ1qY5SmPcA8mAzeL1MOS8Vmp+6k5lisO/r3JHFknPdD0pEZboaik xw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxt6480by-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Dec 2023 15:28:17 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BCFSHKu014760;
 Tue, 12 Dec 2023 15:28:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxt6480bk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Dec 2023 15:28:17 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BCCnNOo014819; Tue, 12 Dec 2023 15:28:15 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw42kcsk0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Dec 2023 15:28:15 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3BCFSEl212452360
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Dec 2023 15:28:15 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0BEB58064;
 Tue, 12 Dec 2023 15:28:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D921558062;
 Tue, 12 Dec 2023 15:28:13 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.80.253]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Dec 2023 15:28:13 +0000 (GMT)
Message-ID: <1b0414d48d1798146f9a07ed1e6afdfbdd39b076.camel@linux.ibm.com>
Subject: Re: [PATCH 3/4] hw/s390x/ipl: Remove unused 'exec/exec-all.h'
 included header
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>
Date: Tue, 12 Dec 2023 10:28:13 -0500
In-Reply-To: <a5560c21-658d-436c-a26f-87066b152d0a@linux.ibm.com>
References: <20231212113640.30287-1-philmd@linaro.org>
 <20231212113640.30287-4-philmd@linaro.org>
 <a5560c21-658d-436c-a26f-87066b152d0a@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2-5Ld7sRa9Fn5Wy47lvg7RKpL1NlSYWx
X-Proofpoint-GUID: iasvVdGlNNbQI9LCQxHzbkhXkmBfeOsP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_09,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 mlxlogscore=968 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120118
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 2023-12-12 at 14:08 +0100, Christian Borntraeger wrote:
>=20
>=20
> Am 12.12.23 um 12:36 schrieb Philippe Mathieu-Daud=C3=A9:
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> > =C2=A0 hw/s390x/ipl.c | 1 -
> > =C2=A0 1 file changed, 1 deletion(-)
> >=20
> > diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> > index 515dcf51b5..62182d81a0 100644
> > --- a/hw/s390x/ipl.c
> > +++ b/hw/s390x/ipl.c
> > @@ -35,7 +35,6 @@
> > =C2=A0 #include "qemu/cutils.h"
> > =C2=A0 #include "qemu/option.h"
> > =C2=A0 #include "standard-headers/linux/virtio_ids.h"
> > -#include "exec/exec-all.h"
>=20
> Philippe,
>=20
> This include came with
> commit a30fb811cbe940020a498d2cdac9326cac38b4d9
> Author:=C2=A0=C2=A0=C2=A0=C2=A0 David Hildenbrand <david@redhat.com>
> AuthorDate: Tue Apr 24 12:18:59 2018 +0200
> Commit:=C2=A0=C2=A0=C2=A0=C2=A0 Cornelia Huck <cohuck@redhat.com>
> CommitDate: Mon May 14 17:10:02 2018 +0200
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 s390x: refactor reset/reipl handling
>=20
> And I think one reason was
>=20
> cpu_loop_exit
>=20
> This is still part of ipl.c
>=20
> a30fb811cbe (David Hildenbrand=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2018-04-24 1=
2:18:59 +0200
> 664)=C2=A0=C2=A0=C2=A0=C2=A0 /* as this is triggered by a CPU, make sure =
to exit the loop
> */
> a30fb811cbe (David Hildenbrand=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2018-04-24 1=
2:18:59 +0200
> 665)=C2=A0=C2=A0=C2=A0=C2=A0 if (tcg_enabled()) {
> a30fb811cbe (David Hildenbrand=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2018-04-24 1=
2:18:59 +0200
> 666)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_loop_exit(cs);
> a30fb811cbe (David Hildenbrand=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2018-04-24 1=
2:18:59 +0200
> 667)=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> So why do you think exec-all.h is unused?
>=20
>=20

I think because that got moved out of exec-all.h a few months ago, via

commit 3549118b498873c84b442bc280a5edafbb61e0a4
Author: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Date:   Thu Sep 14 20:57:08 2023 +0200

    exec: Move cpu_loop_foo() target agnostic functions to 'cpu-
common.h'
   =20
    While these functions are not TCG specific, they are not target
    specific. Move them to "exec/cpu-common.h" so their callers don't
    have to be tainted as target specific.



