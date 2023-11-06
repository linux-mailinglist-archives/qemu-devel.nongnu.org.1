Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1597E1D20
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 10:22:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzvnG-0006XV-IK; Mon, 06 Nov 2023 04:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qzvn9-0006Wq-Ez; Mon, 06 Nov 2023 04:21:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qzvn5-0002Ka-95; Mon, 06 Nov 2023 04:21:06 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A68jk3l003667; Mon, 6 Nov 2023 09:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3pjuuy4c/LH3jt5TQIZdIlqfzkpBK/omyWXw9vPvoRg=;
 b=RfZyRuE8Q+fUvgTgFNlqqqqwsTDV3FbH6i8evp7PKhthwUNiijdCzCU6p8sGUSO8ykeD
 cv+pYmoDzZv/qPSPGbUdBMpD/N2MUTsXYtHrQxtNNKxE+U5KzLAiPMjkQO6RRF/0JFvl
 Dgaxl021EmomaSNwucJb9SC+E7Q46ddol5NACgKs7DZJzD5RhBnA35ipZuMNkg5bEIom
 BqXDnAkuDUX7rN8nNbzpm7N5Fq58n48ZUvXnK+6xeMxSJOMIUGCS2UoKdJDfQPYeoPpX
 ubM+Qcn26la7WCI1q0DyQzl88e1nv8X9LSIJy73wNVhaJ/RaDN72R2ilc90C8+28grVK DA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6vws0w8u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Nov 2023 09:20:58 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A692d7r024076;
 Mon, 6 Nov 2023 09:20:57 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6vws0w8f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Nov 2023 09:20:57 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A68ltmR008078; Mon, 6 Nov 2023 09:20:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u61sk82q5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Nov 2023 09:20:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A69KsO323397004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Nov 2023 09:20:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D591A2004D;
 Mon,  6 Nov 2023 09:20:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7400C20043;
 Mon,  6 Nov 2023 09:20:54 +0000 (GMT)
Received: from [9.171.47.192] (unknown [9.171.47.192])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Nov 2023 09:20:54 +0000 (GMT)
Message-ID: <150d34e65cff88b2605e5811f8c583b3adb3275a.camel@linux.ibm.com>
Subject: Re: [PATCH 2/4] tests/tcg/s390x: Test CLC with inaccessible second
 operand
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand
 <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 06 Nov 2023 10:20:54 +0100
In-Reply-To: <9963393c-f641-402a-94a1-86e6ef740adf@linaro.org>
References: <20231031053718.347100-1-iii@linux.ibm.com>
 <20231031053718.347100-3-iii@linux.ibm.com>
 <9963393c-f641-402a-94a1-86e6ef740adf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d18qD1h_hYOwu0wiPQeUsI8rcHGlT3Tl
X-Proofpoint-GUID: yjene3byd8Kq0ix2GWDCQofG16IARUl2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_07,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=604 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060080
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Tue, 2023-10-31 at 15:53 -0700, Richard Henderson wrote:
> On 10/30/23 22:32, Ilya Leoshkevich wrote:
> > +int main(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0 register unsigned long r0 asm("r0");
> > +=C2=A0=C2=A0=C2=A0 unsigned long mem =3D 42, rhs =3D 500;
> > +=C2=A0=C2=A0=C2=A0 struct sigaction act;
> > +=C2=A0=C2=A0=C2=A0 int err;
> > +
> > +=C2=A0=C2=A0=C2=A0 memset(&act, 0, sizeof(act));
> > +=C2=A0=C2=A0=C2=A0 act.sa_sigaction =3D handle_sigsegv;
> > +=C2=A0=C2=A0=C2=A0 act.sa_flags =3D SA_SIGINFO;
> > +=C2=A0=C2=A0=C2=A0 err =3D sigaction(SIGSEGV, &act, NULL);
> > +=C2=A0=C2=A0=C2=A0 assert(err =3D=3D 0);
> > +
> > +=C2=A0=C2=A0=C2=A0 r0 =3D 100;
> > +=C2=A0=C2=A0=C2=A0 asm("algr %[r0],%[rhs]\n"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "clc 0(8,%[mem]),0(0)\n"=C2=
=A0 /* The 2nd operand will cause a
> > SEGV. */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : [r0] "+r" (r0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : [mem] "r" (&mem)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 , [rhs] "r" (rhs)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : "cc", "memory");
> > +
>=20
> You could just as easily set cc based on CHI or something to avoid
> hard-coding r0, or even=20
> clobbering an output register at all.

The point of hardcoding r0 is rather to be able to check its value in
handle_sigsegv(). While this was not buggy, I still wanted to make sure
that the updated value is "committed" despite SEGV.

>=20
> But I guess there's little point bike shedding this too much...
>=20
> r~


