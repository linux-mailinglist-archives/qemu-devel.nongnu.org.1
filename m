Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8335E773A5B
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 15:08:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTMQV-00068p-RU; Tue, 08 Aug 2023 09:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qTMQT-00068Q-1r
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 09:07:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qTMQQ-0004L2-Es
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 09:07:04 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 378D1NNA001947; Tue, 8 Aug 2023 13:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=lofQmZ8yx/DHM0IoK/wrLRYsgo7r1o8F919ghu+NoJ8=;
 b=nPSlI7nsPsuaAo6ed5s75SFIoT3HQ/IFjeKPzVZe3V/Ra4y1KsEOPEyrJnITCCs9Vb1x
 BWeQt80G1gSOCCXFksFceqXIXQQ62ZCwiGA5Gx5EYQFvAXlpLy7mL/1X/0TBjv+xwAvk
 g3iBKzWDSI/Tyb4ds/SF0t/V3GUrbzZcSNm+m3a50w4THdivwJNbxIOaq29nNuuu0I6C
 QjAn1hc0HmZbkURDUxhJqFD2qReJrTJ9idm3OAJD+EE4vbvb2MNaLYsVKcgHN9bs7ByM
 BOBqRHDLCGXbFQQkS2UAPzfea41gineChxf3p9YCyZtVQYvu+XIIdyk5/69uym33uXpx 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbp7fg79y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Aug 2023 13:06:56 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 378D2Uai007499;
 Tue, 8 Aug 2023 13:03:56 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbp7fg56g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Aug 2023 13:03:56 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 378BhbSn000382; Tue, 8 Aug 2023 12:29:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa28ke9nh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Aug 2023 12:29:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 378CTOEi44958394
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Aug 2023 12:29:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE3002004E;
 Tue,  8 Aug 2023 12:29:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92F702004B;
 Tue,  8 Aug 2023 12:29:24 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Aug 2023 12:29:24 +0000 (GMT)
Message-ID: <7d0202d9641569aa79e9e9a08c8d3c8257435469.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/3] linux-user, configure: fix CPU canonicalization
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Date: Tue, 08 Aug 2023 14:29:24 +0200
In-Reply-To: <20230808120303.585509-1-pbonzini@redhat.com>
References: <20230808120303.585509-1-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I9QFxRxuLLgR_nlRRCJTticY4o4TCRia
X-Proofpoint-ORIG-GUID: 6txsCRdmY36bvrJHjDgDg8ldrcWbSCaZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_10,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 mlxlogscore=562 mlxscore=0 clxscore=1015 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080116
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
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

On Tue, 2023-08-08 at 14:03 +0200, Paolo Bonzini wrote:
> The CPU model has to be canonicalized to what Meson wants in the
> cross
> file, to what Linux uses for its asm-$ARCH directories, and to what
> QEMU uses for its user-mode emulation host/$ARCH directories.=C2=A0 Do
> all three in a single case statement, and check that the Linux and
> QEMU directories actually exist.
>=20
> At a small cost in repeated lines, this ensures that there are no
> hidden
> ordering requirements between the case statements.=C2=A0 In particular,
> commit
> 89e5b7935e9 ("configure: Fix linux-user host detection for riscv64",
> 2023-08-06) broke ppc64le because it assigned host_arch based on a
> non-canonicalized version of $cpu.
>=20
> While doing this, I noticed that linux-user won't work on x32, alpha
> and 32-bit s390 these days, due to missing common-user/ fragments.
> The first two patches clean up the directories.
>=20
> v1->v2: fix s390x compilation; rearrange case terminators
>=20
>=20
> Paolo Bonzini (3):
> =C2=A0 configure: fix detection for x32 linux-user
> =C2=A0 linux-user: cleanup unused linux-user/include/host directories
> =C2=A0 configure: unify case statements for CPU canonicalization
>=20
> =C2=A0configure=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
173 ++++++++++++------
> --
> =C2=A0linux-user/include/host/alpha/host-signal.h |=C2=A0 55 -------
> =C2=A0linux-user/include/host/s390/host-signal.h=C2=A0 | 138 ------------=
----
> =C2=A0linux-user/include/host/s390x/host-signal.h | 139 +++++++++++++++-
> =C2=A0linux-user/include/host/x32/host-signal.h=C2=A0=C2=A0 |=C2=A0=C2=A0=
 1 -
> =C2=A05 files changed, 240 insertions(+), 266 deletions(-)
> =C2=A0delete mode 100644 linux-user/include/host/alpha/host-signal.h
> =C2=A0delete mode 100644 linux-user/include/host/s390/host-signal.h
> =C2=A0delete mode 100644 linux-user/include/host/x32/host-signal.h

Now it works, thanks!

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>

