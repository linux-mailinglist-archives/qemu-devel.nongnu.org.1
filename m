Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BA9772A47
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:14:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2s0-0003Dy-6E; Mon, 07 Aug 2023 12:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qT2rx-0003DW-2Y; Mon, 07 Aug 2023 12:14:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qT2ru-00068G-Be; Mon, 07 Aug 2023 12:14:08 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 377GA3vP024397; Mon, 7 Aug 2023 16:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3mW3PlScjDrbYSUEmh9n1Baekz+IWF3Ql2fnpySZH1c=;
 b=ZHmG34e8QzkmQSwT3YFvsXsY3aedQWiTT/GuO/oOFzpJA2Zt8SysozPt2i+YVI0+K/IF
 ukGcRXDr8Vb/vUrdlLRBJPGzgUY0cUVzVI19HZFTfYEs5X1vvCaSWuWGOGrThbdvm/Ro
 jHQi68g1vEoteTSiv9SnHH4bApk8BF3Okut06Hl6KifGOXRPLCjdAayo8dUK6YaRL9A1
 lZ8wWCV3o/2Dw+RGsjKfgdtKyW/DHcRa6BRcSj+0/s1gkqIYpZ/i81yXtqYje9gjr2Ka
 0Mjd7nFDEusy4bwxLTXMWmCyZmfVRu512Vs9QVCuGjg11SkkwM6YgQxOOuBkWUI2HPLs sA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb3mv0b5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 16:14:00 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 377GCtcC002433;
 Mon, 7 Aug 2023 16:13:59 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb3mv0b4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 16:13:59 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 377FPC3w000363; Mon, 7 Aug 2023 16:13:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa28k6dgq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 16:13:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 377GDusI7275194
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Aug 2023 16:13:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A46C20043;
 Mon,  7 Aug 2023 16:13:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4FC52004B;
 Mon,  7 Aug 2023 16:13:55 +0000 (GMT)
Received: from [9.179.26.52] (unknown [9.179.26.52])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  7 Aug 2023 16:13:55 +0000 (GMT)
Message-ID: <983d4a7e033b5f1ee455468354d85dfa5f1306b6.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] target/s390x: Define TARGET_HAS_PRECISE_SMC
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Date: Mon, 07 Aug 2023 18:13:55 +0200
In-Reply-To: <6961d8e4-7b26-b205-1ffd-4d4b721fe2e2@redhat.com>
References: <20230807114921.438881-1-iii@linux.ibm.com>
 <6961d8e4-7b26-b205-1ffd-4d4b721fe2e2@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GY0PlqYKN62w2eaJ0k43tHEKEtTfaU1w
X-Proofpoint-ORIG-GUID: la4E_6rIm4jjoLqVPptDPgoMTwdF-lLJ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_17,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=735 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070149
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

On Mon, 2023-08-07 at 17:31 +0200, David Hildenbrand wrote:
> On 07.08.23 13:48, Ilya Leoshkevich wrote:
> > PoP (Sequence of Storage References -> Instruction Fetching) says:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 ... if a store that is conceptually earlier is
> > =C2=A0=C2=A0=C2=A0=C2=A0 made by the same CPU using the same effective
> > =C2=A0=C2=A0=C2=A0=C2=A0 address as that by which the instruction is su=
bse-
> > =C2=A0=C2=A0=C2=A0=C2=A0 quently fetched, the updated information is ob=
tained ...
> >=20
> > QEMU already has support for this in the common code; enable it for
> > s390x.
>=20
>=20
> Figuring out what TARGET_HAS_PRECISE_SMC is all about, I only learned
> from git history
>=20
> commit d720b93d0bcfe1beb729245b9ed1e5f071a24bd5
> Author: Fabrice Bellard <fabrice@bellard.org>
> Date:=C2=A0=C2=A0 Sun Apr 25 17:57:43 2004 +0000
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 precise self modifying code support
>=20
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 git-svn-id: svn://svn.savannah.nongnu.org/qemu/t=
runk@745=20
> c046a42c-6fe2-441c-8c8c-71466251a162
>=20
>=20
>=20
> AFAIU, precise SMC is stricter compared to what we have right now. So
> i=20
> suspect that this patch is actually fixing SMC behavior: for example,
> when a basic block ends up modifying itself.
>=20
> Were there any BUG reports? (does patch #2 test for that and can=20
> reproduce the original issue?)

There were no bug reports, I found this issue with fuzzing.

Patch #2 tests a TB modifying itself.
Reverting this commit makes the test fail.

[...]

