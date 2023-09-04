Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 560FE79198D
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:20:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAQK-0001gH-Su; Mon, 04 Sep 2023 10:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qdAQH-0001eG-MW; Mon, 04 Sep 2023 10:19:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qdAQE-0004B7-Na; Mon, 04 Sep 2023 10:19:25 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 384E8XkN008260; Mon, 4 Sep 2023 14:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gh0PTmOcigPfzoPYKZ8ZJ0iOyWi6hQ71NqtqvwR5aVo=;
 b=oIMRrRRKA9FJydx5Hif0hP/C4lAbsXb5/7wZ3QlQhHi0oBMS3arZKUTWP81Jzq+0uMXI
 eMwfVho3vNkgTC5asafi6qERzAfY5QyGLZXX4GXo07BZLd62Lc/Ake7QYeO3UVZzu9et
 GwMSFsZcvvtTKgnRjrzFzPOR8R/Fm1jC/nwfvW8uVdhNyx7IY/nRC65ltcRSNLF634YA
 VXIz++EHEbtOPGGXcKXqQlSi8Rz2fwGHinNw0piQl6BJBCuqO+5QqgpoglzkPwOfTpul
 DSeMUTuQEDu4qRE6QCeIEKoomARfSHLX0pJp6Ljbl8YvQV54MyNmdy2PkaAYLel3v8vU gg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sw7sqex4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Sep 2023 14:19:15 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 384E9n2v012422;
 Mon, 4 Sep 2023 14:19:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sw7sqex3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Sep 2023 14:19:15 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 384EAaA1021478; Mon, 4 Sep 2023 14:19:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svfry3est-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Sep 2023 14:19:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 384EJCH515336178
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 Sep 2023 14:19:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE47320043;
 Mon,  4 Sep 2023 14:19:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 708C020040;
 Mon,  4 Sep 2023 14:19:11 +0000 (GMT)
Received: from [9.171.57.13] (unknown [9.171.57.13])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 Sep 2023 14:19:11 +0000 (GMT)
Message-ID: <cb8382fe4209c8ebe15f4d2b189ca77e20586ee8.camel@linux.ibm.com>
Subject: Re: [risu PATCH 1/4] s390x: Add basic s390x support to the C code
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
Date: Mon, 04 Sep 2023 16:19:11 +0200
In-Reply-To: <20230904140040.33153-2-thuth@redhat.com>
References: <20230904140040.33153-1-thuth@redhat.com>
 <20230904140040.33153-2-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0a2qcryFw5a-qMeaT0P-CzsSZddUt8VT
X-Proofpoint-ORIG-GUID: a_eDemsebxRyupeI37WKfRAoY6SVD8pU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=884 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309040126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
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

On Mon, 2023-09-04 at 16:00 +0200, Thomas Huth wrote:
> With these changes, it is now possible to compile the "risu" binary
> for s390x hosts.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
> =C2=A0risu_reginfo_s390x.c | 142
> +++++++++++++++++++++++++++++++++++++++++++
> =C2=A0risu_reginfo_s390x.h |=C2=A0 23 +++++++
> =C2=A0risu_s390x.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 48 +++++++++++++++
> =C2=A0test_s390x.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 32 ++++++++++
> =C2=A04 files changed, 245 insertions(+)
> =C2=A0create mode 100644 risu_reginfo_s390x.c
> =C2=A0create mode 100644 risu_reginfo_s390x.h
> =C2=A0create mode 100644 risu_s390x.c
> =C2=A0create mode 100644 test_s390x.S

Looks really interesting! I was doing similar qemu-system-s390x testing
with a bunch of ad-hoc scripts, and there are quite a few unresolved
problems still, especially in the error handling area.

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

I have one small question (see below).

[...]

> +/* reginfo_is_eq: compare the reginfo structs, returns nonzero if
> equal */
> +int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
> +{
> +=C2=A0=C2=A0=C2=A0 int i;
> +
> +=C2=A0=C2=A0=C2=A0 if (m->psw_mask !=3D a->psw_mask || m->psw_addr !=3D =
a->psw_addr) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /* Skip return address register and stack register fo=
r
> comparison */

Is this because of ASLR? In this case, would it be possible to build a
non-PIE binary and switch to a private stack at the beginning? This
could be useful for the other architectures as well.

[...]


