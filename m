Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA17720203
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 14:24:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53ok-0008PB-Jp; Fri, 02 Jun 2023 08:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q53oi-0008Ln-8t; Fri, 02 Jun 2023 08:23:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q53od-0002Ov-6w; Fri, 02 Jun 2023 08:23:39 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 352CARds025190; Fri, 2 Jun 2023 12:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3TfLBNiCS/ZS1Korken/QnXU+htDLeeBMsr9CFZ92r4=;
 b=tEXj8ceuEi6kNfeAfzqimB9wcLe+xhNiSKzQJEC1/ShYliU2ZLTflVMiDg5Aqn7w6Hxb
 2YMoHf8ScgB3FQhsh0xxB09XfqNvw+E1Vgc1LEpUcNNJ3hpJieRV1EdotFY0AS91pwHV
 XgaffEIKbasx2Cs+OZPpuDp3uvo5yo9usAiaRF9yQrvEuM4GJ5fCGSRxPv8Eq67pGzqs
 APKq20EQTcyuXOg33cpSZDygjIO/bxA3888R3tj7HsQfGKYhDS7vw3ZVjHuqv58YD6vR
 XGryVTu/gY5tm13CZAjwa7wyPMYNO0HD3msIeXB/2sH2sZsU6F20MlLJ08EHSKAMQt7G Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qyfdc1una-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Jun 2023 12:23:25 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 352CEYIP009982;
 Fri, 2 Jun 2023 12:23:24 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qyfdc1umn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Jun 2023 12:23:24 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 352CFl7Z019725;
 Fri, 2 Jun 2023 12:23:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qu9g5323f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Jun 2023 12:23:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 352CNKBa7799424
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Jun 2023 12:23:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 968882004B;
 Fri,  2 Jun 2023 12:23:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 629DD20043;
 Fri,  2 Jun 2023 12:23:20 +0000 (GMT)
Received: from [9.155.209.184] (unknown [9.155.209.184])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Jun 2023 12:23:20 +0000 (GMT)
Message-ID: <752a33dd22b223656b4827eaf28419e3e8f629e9.camel@linux.ibm.com>
Subject: Re: [PATCH 4/4] linux-user: Emulate /proc/cpuinfo on s390x
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Tulio Magno Quites Machado
 Filho <tuliom@redhat.com>
Date: Fri, 02 Jun 2023 14:23:20 +0200
In-Reply-To: <20230601162541.689621-5-iii@linux.ibm.com>
References: <20230601162541.689621-1-iii@linux.ibm.com>
 <20230601162541.689621-5-iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kS45ZQHPl0tfHz_dwbFFHPhOocWNC1tl
X-Proofpoint-ORIG-GUID: hIWfjql-nJZf9S4c9d80r_j9DHJDBaH4
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020090
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
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

On Thu, 2023-06-01 at 18:25 +0200, Ilya Leoshkevich wrote:
> Some s390x userspace programs are confused when seeing a foreign
> /proc/cpuinfo [1]. Add the emulation for s390x; follow the respective
> kernel code structure where possible.
>=20
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D2211472
>=20
> Reported-by: Tulio Magno Quites Machado Filho <tuliom@redhat.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> =C2=A0linux-user/syscall.c | 106
> ++++++++++++++++++++++++++++++++++++++++++-
> =C2=A01 file changed, 105 insertions(+), 1 deletion(-)

> @@ -8364,7 +8467,8 @@ int do_guest_openat(CPUArchState *cpu_env, int
> dirfd, const char *pathname,
> =C2=A0#if HOST_BIG_ENDIAN !=3D TARGET_BIG_ENDIAN
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "/proc/net/route", ope=
n_net_route, is_proc },
> =C2=A0#endif
> -#if defined(TARGET_SPARC) || defined(TARGET_HPPA) ||
> defined(TARGET_RISCV)
> +#if defined(TARGET_SPARC) || defined(TARGET_HPPA) || \
> +=C2=A0=C2=A0=C2=A0 defined(TARGET_RISCV) || defined(TARGET_S390X)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "/proc/cpuinfo", open_=
cpuinfo, is_proc },
> =C2=A0#endif
> =C2=A0#if defined(TARGET_M68K)

I'll need to add #if defined(TARGET_S390X) for is_proc, otherwise
the build will fail on s390x hosts. I will include this in v2.

