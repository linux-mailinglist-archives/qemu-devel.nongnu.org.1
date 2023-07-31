Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D69C5769A40
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 17:00:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQUMo-0005fj-MY; Mon, 31 Jul 2023 10:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qQUMl-0005ey-CY; Mon, 31 Jul 2023 10:59:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qQUMj-00088H-Mm; Mon, 31 Jul 2023 10:59:23 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36VEfVjL023871; Mon, 31 Jul 2023 14:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=bh1IA8tHa4hxqIuAw6fKmHi/IWvXbJSDHqvEkjF1TZ8=;
 b=i8cy80euoI6rR7jf2zI6KF+hdU95J3xnPSnVIIILJkABD8401Thn6osuYvqiNDRs7ozA
 P4IffQZMnm1Q1IMZunTkDgDPLP+9YG7BjtPm7njsV/dMnlXThKHuYrmQCq11CF/1ym8B
 rTtPv6AC3MlqhZeTtRaVPLf2ImOAPd97+87maNzwDWTexRBUU+kgum5ISSsPTHSRvmIa
 TEvjTGNIELFM1nEpusvQKFzv8ukBI/4dKrkHpN/PvncDf3g0z/H7ziZpEIb66V1vKO2J
 RVnUsaE5WMPsi+ydJUVagAf4SL7CBk2v9U72LukZIXPI/xT9obFbGzLXW4QQ/zWlnYVK LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s6eh1hphh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Jul 2023 14:59:18 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36VEfiHI024634;
 Mon, 31 Jul 2023 14:59:18 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s6eh1hpfm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Jul 2023 14:59:18 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36VEmiXd017132; Mon, 31 Jul 2023 14:59:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s5fajbggg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Jul 2023 14:59:15 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36VExDIP23790174
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Jul 2023 14:59:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C805720043;
 Mon, 31 Jul 2023 14:59:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99AB620040;
 Mon, 31 Jul 2023 14:59:13 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Jul 2023 14:59:13 +0000 (GMT)
Message-ID: <787d1fe5f42eed2561be7b9cbc4b20cebea836e7.camel@linux.ibm.com>
Subject: Re: [PATCH] target/s390x: Move trans_exc_code update to
 do_program_interrupt
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: david@redhat.com, qemu-s390x@nongnu.org, Claudio Fontana <cfontana@suse.de>
Date: Mon, 31 Jul 2023 16:59:13 +0200
In-Reply-To: <2a9d2f15-4f1b-19c7-7feb-e8597c1c71e3@linaro.org>
References: <20230728195538.488932-1-richard.henderson@linaro.org>
 <920b0af5-4acb-3eaa-755f-608359117cd2@linaro.org>
 <f054a26eee85be8dba7095b6c4c86fd79331fcd4.camel@linux.ibm.com>
 <2a9d2f15-4f1b-19c7-7feb-e8597c1c71e3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1UvuAWHLgp_W7fdRw4zYQ-wuUN748-Bz
X-Proofpoint-GUID: jsvHMhMq3n8Fg7OOBWMY2UZqf521uTi0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_07,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 mlxlogscore=783 impostorscore=0 spamscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310130
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 2023-07-31 at 07:55 -0700, Richard Henderson wrote:
> On 7/31/23 01:26, Ilya Leoshkevich wrote:
> > > > +=C2=A0=C2=A0=C2=A0 case PGM_PROTECTION:
> > > > +=C2=A0=C2=A0=C2=A0 case PGM_TRANS_SPEC:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(env->int_pgm_cod=
e =3D=3D env->tlb_fill_exc);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_trans_exc_code =3D =
true;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 advance =3D true;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > >=20
> > > These exceptions came from seeing an early kernel fault, grepping
> > > for
> > > the set of
> > > exceptions raised in mmu_helper.c, and eliminating PGM_ADDRESSING
> > > per
> > > the first hunk.
> >=20
> > Does POp specify that the CPU stores Translation-Exception
> > Identification on Translation-Specification Exceptions
> > (PGM_TRANS_SPEC)? I re-read the 0xA8 documentation a few times, but
> > could not find it.
>=20
> Neither could I.
>=20
> > It's also interesting what the kernel was attempting when it got
> > PGM_TRANS_SPEC and recovered from it. Maybe something else is
> > wrong?
>=20
> I think the kernel was testing PGM_PROTECTION, to see if LowCore
> protection worked.
>=20
> But since that one wasn't listed for 0xA8 either, I preserved
> previous behaviour in=20
> setting trans_exc_code for all mmu exceptions except for
> PGM_ADDRESSING.
>=20
>=20
> r~

Actually, PGM_PROTECTION is there. If you scroll a few pages down, you
will see: "Translation-Exception Identification for Protection
Exceptions". But nothing like this for PGM_TRANS_SPEC.

