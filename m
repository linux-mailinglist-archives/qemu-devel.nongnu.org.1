Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7872720233
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 14:37:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q541l-0000xh-QZ; Fri, 02 Jun 2023 08:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q541i-0000wl-T9; Fri, 02 Jun 2023 08:37:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q541g-0000Sf-4e; Fri, 02 Jun 2023 08:37:06 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 352CaP2k019666; Fri, 2 Jun 2023 12:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vo/kGav1tdrySmVoKgWWzNHtBnVqz0/wy1/6ZmQY86U=;
 b=F+B6tvM/re5194MlaUip1sUhH5BQo6FxBGiSf7W/jmC8ScrK4ST0GD3femRmAgU1nCuu
 E8nRJKVCXZO+5BKFY5arPWXlieA0rWwMf2hP86Fz4ffU3UkiSaWiRFNmiESKptjKiSbC
 IGAECNMXQlBH7Z09yVFrcayAPAFd6pVSey8yXWntDqKIZN/3ufTwBnG4xjjIzhRjm5jg
 rpmn+G4T+wzKaj+PnK6SlKcfBJOshfcLvy3fQv0ULLKIpJjg4RCDnz8Jbs5wVKZwkQdB
 pNxZA4GfY+eYC+ZwkTX/LHst2OZjmY1kiUwDjRtN0ZOzMZOWiiqFs80b4Gvb2fJuy5Mr vA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qygk1r0yv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Jun 2023 12:37:01 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 352Cb1XR022990;
 Fri, 2 Jun 2023 12:37:01 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qygk1r0x3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Jun 2023 12:37:01 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3526dPvf006319;
 Fri, 2 Jun 2023 12:36:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3qu9g52hgw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Jun 2023 12:36:59 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 352Caub812649136
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Jun 2023 12:36:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1E1E2004D;
 Fri,  2 Jun 2023 12:36:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90A602004B;
 Fri,  2 Jun 2023 12:36:56 +0000 (GMT)
Received: from [9.155.209.184] (unknown [9.155.209.184])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Jun 2023 12:36:56 +0000 (GMT)
Message-ID: <49e98edb606e290008e13ab08ed293b476847d8a.camel@linux.ibm.com>
Subject: Re: [PATCH 4/4] linux-user: Emulate /proc/cpuinfo on s390x
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Thomas Huth <thuth@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Tulio Magno Quites Machado
 Filho <tuliom@redhat.com>
Date: Fri, 02 Jun 2023 14:36:56 +0200
In-Reply-To: <4f524884-034a-785d-a1e8-0ebc10f2232f@redhat.com>
References: <20230601162541.689621-1-iii@linux.ibm.com>
 <20230601162541.689621-5-iii@linux.ibm.com>
 <4f524884-034a-785d-a1e8-0ebc10f2232f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tlBj7z3z_FD_ulLz0OY20zTS098JuewR
X-Proofpoint-ORIG-GUID: Rq6qRvyrKHAWg9bkNlOB0a9QtSVQ3jKC
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020094
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

On Fri, 2023-06-02 at 14:34 +0200, David Hildenbrand wrote:
> On 01.06.23 18:25, Ilya Leoshkevich wrote:
> > Some s390x userspace programs are confused when seeing a foreign
> > /proc/cpuinfo [1]. Add the emulation for s390x; follow the
> > respective
> > kernel code structure where possible.
> >=20
> > [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D2211472
> >=20
>=20
> Would be nice to have an example output here.
>=20
> > Reported-by: Tulio Magno Quites Machado Filho <tuliom@redhat.com>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0 linux-user/syscall.c | 106
> > ++++++++++++++++++++++++++++++++++++++++++-
> > =C2=A0 1 file changed, 105 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 3e6ed51ce62..d142e09dc70 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -8339,6 +8339,109 @@ static int open_cpuinfo(CPUArchState
> > *cpu_env, int fd)
> > =C2=A0 }
> > =C2=A0 #endif
> > =C2=A0=20
>=20
> [...]
>=20
> > +
> > +static void show_cpuinfo(CPUArchState *cpu_env, int fd, unsigned
> > long n)
> > +{
> > +=C2=A0=C2=A0=C2=A0 if (n =3D=3D 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 show_cpu_summary(cpu_env, f=
d);
> > +=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 dprintf(fd, "\ncpu number=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 : %ld\n", n);
> > +=C2=A0=C2=A0=C2=A0 show_cpu_ids(cpu_env, fd, n);
> > +}
>=20
> Considering the n=3D=3D0 special case, it might be cleaner to just place=
=20
> that code directly into open_cpuinfo and get rid of show_cpuinfo().

Will do.

This was copied from the kernel, where a similar check actually made
sense, but in the QEMU context we don't really need it.

> > +
> > +static int open_cpuinfo(CPUArchState *cpu_env, int fd)
> > +{
> > +=C2=A0=C2=A0=C2=A0 int num_cpus =3D sysconf(_SC_NPROCESSORS_ONLN);
> > +=C2=A0=C2=A0=C2=A0 int i;
> > +
> > +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < num_cpus; i++) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 show_cpuinfo(cpu_env, fd, i=
);
> > +=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 return 0;
> > +}
> > +#endif
> > +
> > =C2=A0 #if defined(TARGET_M68K)
> > =C2=A0 static int open_hardware(CPUArchState *cpu_env, int fd)
> > =C2=A0 {
> > @@ -8364,7 +8467,8 @@ int do_guest_openat(CPUArchState *cpu_env,
> > int dirfd, const char *pathname,
> > =C2=A0 #if HOST_BIG_ENDIAN !=3D TARGET_BIG_ENDIAN
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "/proc/net/rou=
te", open_net_route, is_proc },
> > =C2=A0 #endif
> > -#if defined(TARGET_SPARC) || defined(TARGET_HPPA) ||
> > defined(TARGET_RISCV)
> > +#if defined(TARGET_SPARC) || defined(TARGET_HPPA) || \
> > +=C2=A0=C2=A0=C2=A0 defined(TARGET_RISCV) || defined(TARGET_S390X)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "/proc/cpuinfo=
", open_cpuinfo, is_proc },
> > =C2=A0 #endif
> > =C2=A0 #if defined(TARGET_M68K)
>=20
> In general, looks very good to me, thanks! With the fixup:
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
>=20


