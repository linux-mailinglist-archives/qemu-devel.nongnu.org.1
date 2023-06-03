Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE147212B2
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 22:36:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5XyC-0004td-W2; Sat, 03 Jun 2023 16:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1q5Xy7-0004t2-OA
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 16:35:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1q5Xy5-00049m-9w
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 16:35:23 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 353KFnOU024151; Sat, 3 Jun 2023 20:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qOWkDq0oRHZHBm3XodN9yBIKn3oUNrdf7WZx7Of5uIg=;
 b=SE3ilSU8Nwho/NrhIQ0EfHUvpong34Rtid43CUX3PnIYzZN5Fr2Z7QJfv7822d1InVmY
 vdTk/5U4JKlpJ6XLnX/eYzN/sczVccC6pAq5rMKTsDXft/Nt6LD1LTaf/4wShfvVrZ43
 jQiTchUx6pRrClWFRWwjNW3W9cBskfEFqOgRqArX7+Fn/4H41qUxM1R48Z8VUSMGUVWK
 iyl2+10lca0EqBiqqLZbPs698SAe8ckV62Kyubpkf9G+6bJFpcb4DNgE4PrTf2+5JBIs
 56nqp4F4LPqLUM8RcxlzpDKAssskGPly5STWlC7q2k+n4OmahuajMnJxS2IYQ3jnrYMW Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r0cdc89gg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 03 Jun 2023 20:35:16 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 353KWPkI000950;
 Sat, 3 Jun 2023 20:35:16 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r0cdc89ft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 03 Jun 2023 20:35:16 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 353Hm5Jp026392;
 Sat, 3 Jun 2023 20:35:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qyxg2gage-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 03 Jun 2023 20:35:13 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 353KZBDL44892450
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 3 Jun 2023 20:35:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7D2520043;
 Sat,  3 Jun 2023 20:35:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41E9E20040;
 Sat,  3 Jun 2023 20:35:11 +0000 (GMT)
Received: from [9.171.7.84] (unknown [9.171.7.84])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  3 Jun 2023 20:35:11 +0000 (GMT)
Message-ID: <bac70c1d1e4c55c2603e5c33637703e19b1189e4.camel@linux.ibm.com>
Subject: Re: [PULL 3/5] tcg: add perfmap and jitdump
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Date: Sat, 03 Jun 2023 22:35:10 +0200
In-Reply-To: <CAFEAcA-pb53hugPBFxkhzAz-zDAt13xhA+yXL6D7iYZbk96NtA@mail.gmail.com>
References: <20230116223637.3512814-1-richard.henderson@linaro.org>
 <20230116223637.3512814-4-richard.henderson@linaro.org>
 <CAFEAcA-pb53hugPBFxkhzAz-zDAt13xhA+yXL6D7iYZbk96NtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NrdW-pt5HDtAyiR_67RsNJUQsgp0uBCh
X-Proofpoint-GUID: Vzw89syUsdpJFxPPbE1v93xxc8SCRl57
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 clxscore=1011 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306030189
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Fri, 2023-06-02 at 18:21 +0100, Peter Maydell wrote:
> On Mon, 16 Jan 2023 at 22:36, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >=20
> > From: Ilya Leoshkevich <iii@linux.ibm.com>
> >=20
> > Add ability to dump /tmp/perf-<pid>.map and jit-<pid>.dump.
> > The first one allows the perf tool to map samples to each
> > individual
> > translation block. The second one adds the ability to resolve
> > symbol
> > names, line numbers and inspect JITed code.
> >=20
> > Example of use:
> >=20
> > =C2=A0=C2=A0=C2=A0 perf record qemu-x86_64 -perfmap ./a.out
> > =C2=A0=C2=A0=C2=A0 perf report
> >=20
> > or
> >=20
> > =C2=A0=C2=A0=C2=A0 perf record -k 1 qemu-x86_64 -jitdump ./a.out
> > =C2=A0=C2=A0=C2=A0 DEBUGINFOD_URLS=3D perf inject -j -i perf.data -o
> > perf.data.jitted
> > =C2=A0=C2=A0=C2=A0 perf report -i perf.data.jitted
> >=20
> > Co-developed-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> > Co-developed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > Message-Id: <20230112152013.125680-4-iii@linux.ibm.com>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>=20
> Hi; Coverity thinks (CID 1507521) that there's a memory leak
> in this code:
>=20
> > +void perf_enable_jitdump(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0 struct jitheader header;
> > +=C2=A0=C2=A0=C2=A0 char jitdump_file[32];
> > +=C2=A0=C2=A0=C2=A0 void *perf_marker;
> > +
> > +=C2=A0=C2=A0=C2=A0 if (!use_rt_clock) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn_report("CLOCK_MONOTONI=
C is not available, proceeding
> > without jitdump");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 snprintf(jitdump_file, sizeof(jitdump_file), "jit-%=
d.dump",
> > getpid());
> > +=C2=A0=C2=A0=C2=A0 jitdump =3D safe_fopen_w(jitdump_file);
> > +=C2=A0=C2=A0=C2=A0 if (jitdump =3D=3D NULL) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn_report("Could not open=
 %s: %s, proceeding without
> > jitdump",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 jitdump_file, strerror(errno)=
);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * `perf inject` will see that the mapped file=
 name in the
> > corresponding
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * PERF_RECORD_MMAP or PERF_RECORD_MMAP2 event=
 is of the form
> > jit-%d.dump
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * and will process it as a jitdump file.
> > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0 perf_marker =3D mmap(NULL, qemu_real_host_page_size=
(), PROT_READ
> > | PROT_EXEC,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAP_PRIVATE=
, fileno(jitdump), 0);
>=20
> Here we mmap() something...
>=20
> > +=C2=A0=C2=A0=C2=A0 if (perf_marker =3D=3D MAP_FAILED) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn_report("Could not map =
%s: %s, proceeding without
> > jitdump",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 jitdump_file, strerror(errno)=
);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fclose(jitdump);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 jitdump =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 header.magic =3D JITHEADER_MAGIC;
> > +=C2=A0=C2=A0=C2=A0 header.version =3D JITHEADER_VERSION;
> > +=C2=A0=C2=A0=C2=A0 header.total_size =3D sizeof(header);
> > +=C2=A0=C2=A0=C2=A0 header.elf_mach =3D get_e_machine();
> > +=C2=A0=C2=A0=C2=A0 header.pad1 =3D 0;
> > +=C2=A0=C2=A0=C2=A0 header.pid =3D getpid();
> > +=C2=A0=C2=A0=C2=A0 header.timestamp =3D get_clock();
> > +=C2=A0=C2=A0=C2=A0 header.flags =3D 0;
> > +=C2=A0=C2=A0=C2=A0 fwrite(&header, sizeof(header), 1, jitdump);
>=20
> ...but we never do anything with that pointer, so the memory
> we just mmap()ed is never going to be freed.
>=20
> Is this doing something particularly magical, or should that
> pointer be kept track of somewhere ?
>=20
> thanks
> -- PMM

It's magic that points perf to the location of the jitdump file,
but it won't hurt munmap()ping it in perf_exit(). I'll send a patch.

