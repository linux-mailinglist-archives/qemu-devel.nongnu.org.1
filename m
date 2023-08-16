Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 716B977E311
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 15:53:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWGxN-00062j-GW; Wed, 16 Aug 2023 09:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qWGxE-0005aA-4F; Wed, 16 Aug 2023 09:52:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qWGx9-0004a9-Mt; Wed, 16 Aug 2023 09:52:55 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37GDgCdA032398; Wed, 16 Aug 2023 13:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xRRU3RFSZsbdvilORURzGUYmelh6TkAb5D63J+up9Hc=;
 b=lUYlyyF2HCmOmi2D8bk3928bKcx5hKFDYWD1emlWCx/rz/eIlUeq5DcXjgaBKtOo7bZj
 MX+klAZr0Oq2KRXc0gXqnZ9dpEpd6r4tFDi4FRMAWCUEX8nTo3+8lytfYS8GISFj1nu8
 PLM17gmjhri4gypkNz85vLOmKb2vWshBshV7G8a//OgV5Cst39YAg1SF7KBuV7M2vNWa
 X/tmyitrSU/fpbZe314oTEDeeXY0SbZ8HpLLk0TCaYe29/7q+xngwOAcUHIX+ys6YZMD
 4i/4ZmkkeIss0Duf9GQmHArypqsLGP4jV9AKEKbDfqs0Vnu2m4I86j7Qt3mS6b63Y8th nA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sgyjrg9u6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Aug 2023 13:52:27 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37GDhiSh005124;
 Wed, 16 Aug 2023 13:52:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sgyjrg9tc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Aug 2023 13:52:27 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37GBgctF002421; Wed, 16 Aug 2023 13:52:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sendncmk0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Aug 2023 13:52:18 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37GDqGnK12583654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Aug 2023 13:52:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24A5520074;
 Wed, 16 Aug 2023 13:52:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C5142004B;
 Wed, 16 Aug 2023 13:52:15 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Aug 2023 13:52:15 +0000 (GMT)
Message-ID: <16b706dc49021acca0b3f490eb23b379b4e999d7.camel@linux.ibm.com>
Subject: Re: [PATCH 4/9] tests: remove test-gdbstub.py
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Wainer dos Santos Moschetta
 <wainersm@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Akihiko
 Odaki <akihiko.odaki@daynix.com>, Thomas Huth <thuth@redhat.com>, David
 Hildenbrand <david@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-arm@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Richard Henderson
 <richard.henderson@linaro.org>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Nicholas
 Piggin <npiggin@gmail.com>
Date: Wed, 16 Aug 2023 15:52:15 +0200
In-Reply-To: <87zg2rnoyv.fsf@linaro.org>
References: <20230815145126.3444183-1-alex.bennee@linaro.org>
 <20230815145126.3444183-5-alex.bennee@linaro.org>
 <130aa9ee49dffd9ecc1006b17b9e82734837d7d9.camel@linux.ibm.com>
 <87zg2rnoyv.fsf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yftG0zrRJWNDMVrXyGzINXIVVFVh82O2
X-Proofpoint-ORIG-GUID: xuVwqsxBOWEj0EvLViU1shn3ZqW6yxKH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_13,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=906 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160116
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

On Wed, 2023-08-16 at 13:33 +0100, Alex Benn=C3=A9e wrote:
>=20
> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>=20
> > On Tue, 2023-08-15 at 15:51 +0100, Alex Benn=C3=A9e wrote:
> > > This isn't directly called by our CI and because it doesn't run
> > > via
> > > our run-test.py script does things slightly differently. Lets
> > > remove
> > > it as we have plenty of working in-tree tests now for various
> > > aspects
> > > of gdbstub.
> > >=20
> > > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > > ---
> > > =C2=A0tests/guest-debug/test-gdbstub.py | 177 -----------------------=
-
> > > ----
> > > --
> > > =C2=A01 file changed, 177 deletions(-)
> > > =C2=A0delete mode 100644 tests/guest-debug/test-gdbstub.py
> >=20
> > There doesn't seem to be a hbreak test elsewhere, but according to
> > a
> > comment in tcg/multiarch/gdbstub/memory.py it would be mapped to a
> > normal break anyway.
>=20
> It is for TCG but for other accelerators there will be different
> handling (although I'm fairly sure only x86 and aarch64 are currently
> plumbed to use the CPUs hbreak bits on KVM).
>=20
> However this particular script was a very early addition when I was
> testing stuff manually with images I'd built on my system. If we want
> to
> exercise the gdbstub for accelerators it might be better porting the
> test to avocado?

That would be good, yes.

I was always wondering if the TCG sotfmmu tests could be used to test
the other accelerators? At least for s390x there is nothing
TCG-specific there (besides that they try to trigger TCG-specific
problems), and I sometimes run them manually with KVM as a sanity
check.

>=20
> >=20
> > Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
>=20
>=20


