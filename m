Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A2C7385A4
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:48:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByCF-0000El-6U; Wed, 21 Jun 2023 09:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qByC8-0000Du-4O; Wed, 21 Jun 2023 09:48:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qByC5-000113-SE; Wed, 21 Jun 2023 09:48:23 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35LDlVQk019821; Wed, 21 Jun 2023 13:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ln7H/5Zpj6NItiL1LfzlYPQS6fCd6TMmMgD+hTxhBCo=;
 b=cXKn8g/OAmHpDey/Ckv1fM5Kiju6nkWhVC22E2817GRC02UIuw3GChsLkggifI7qOKqT
 qw3XoHQ3opt3UfTIEnj5Zn2QQNzi5H0Mt3C0P82Cpwyx28zbdJBKW2K9nBCia/kaNsKx
 Gi1hWDqxDAd9dd5BxoGb0rE1D4m/HZJ1xJxRzbimF1IdZK68ZabPrbvtYcJS9wADngsZ
 JHnnri6qElm3tEbn4eDKIxWWai01aDVwS8xh55f+r55t2prlTbgQfT7alCsbKvypQnK9
 hHkwevF9VSvczg7SjStRSW8qEWYK4Sfeb3yeY5IkmnqR5QnOxkfVrn1kFZSU99hrAp65 dw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc2d9g0db-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 13:48:16 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35LDlvf4020578;
 Wed, 21 Jun 2023 13:48:16 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc2d9g0cs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 13:48:16 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L4OSTp000823;
 Wed, 21 Jun 2023 13:48:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3r94f5a4c4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 13:48:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35LDmBsY38142436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 13:48:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C1C02004B;
 Wed, 21 Jun 2023 13:48:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B335020043;
 Wed, 21 Jun 2023 13:48:10 +0000 (GMT)
Received: from [9.155.209.184] (unknown [9.155.209.184])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Jun 2023 13:48:10 +0000 (GMT)
Message-ID: <4cf02e6ef71c6f2bff38f06b433e99526ee244d4.camel@linux.ibm.com>
Subject: Re: [PATCH v3 8/8] tests/tcg: Add a test for info proc mappings
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Date: Wed, 21 Jun 2023 15:48:10 +0200
In-Reply-To: <87legdglka.fsf@linaro.org>
References: <20230606132743.1386003-1-iii@linux.ibm.com>
 <20230606132743.1386003-9-iii@linux.ibm.com> <87legdglka.fsf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7oISqhuAXdlpeTS9_5z2JF6aVggxr5vP
X-Proofpoint-GUID: e4wWvDLTHE_LH2gZRlqu_NgeH46cjb-K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210114
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

On Wed, 2023-06-21 at 11:21 +0100, Alex Benn=C3=A9e wrote:
>=20
> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>=20
> > Add a small test to prevent regressions.
> > Since there are issues with how GDB interprets QEMU's target.xml,
> > enable the test only on aarch64 and s390x for now.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0tests/tcg/aarch64/Makefile.target=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +-
> > =C2=A0tests/tcg/multiarch/Makefile.target=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +++
> > =C2=A0.../multiarch/gdbstub/test-proc-mappings.py=C2=A0=C2=A0 | 55
> > +++++++++++++++++++
> > =C2=A0tests/tcg/s390x/Makefile.target=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A04 files changed, 65 insertions(+), 2 deletions(-)
> > =C2=A0create mode 100644 tests/tcg/multiarch/gdbstub/test-proc-
> > mappings.py
> >=20
> > diff --git a/tests/tcg/aarch64/Makefile.target
> > b/tests/tcg/aarch64/Makefile.target
> > index 03157954871..38402b0ba1f 100644
> > --- a/tests/tcg/aarch64/Makefile.target
> > +++ b/tests/tcg/aarch64/Makefile.target
> > @@ -97,7 +97,8 @@ run-gdbstub-sve-ioctls: sve-ioctls
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve-
> > ioctl.py, \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0basic gdbstub SVE ZLEN =
support)
> > =C2=A0
> > -EXTRA_RUNS +=3D run-gdbstub-sysregs run-gdbstub-sve-ioctls
> > +EXTRA_RUNS +=3D run-gdbstub-sysregs run-gdbstub-sve-ioctls \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 run-gdbstub-proc-mappings
> > =C2=A0endif
> > =C2=A0endif
> > =C2=A0
> > diff --git a/tests/tcg/multiarch/Makefile.target
> > b/tests/tcg/multiarch/Makefile.target
> > index 373db696481..cbc0b75787a 100644
> > --- a/tests/tcg/multiarch/Makefile.target
> > +++ b/tests/tcg/multiarch/Makefile.target
> > @@ -81,6 +81,13 @@ run-gdbstub-qxfer-auxv-read: sha1
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-
> > qxfer-auxv-read.py, \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0basic gdbstub qXfer:aux=
v:read support)
> > =C2=A0
> > +run-gdbstub-proc-mappings: sha1
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(call run-test, $@, $(GDB_S=
CRIPT) \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0--gdb $(HAVE_GDB_BIN) \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0--bin $< --test $(MULTIARCH_SRC)/gdbstub/test-proc-
> > mappings.py, \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0proc mappings support)
> > +
>=20
> I wondered if it makes more sense to keep the extra test
> configuration
> logic in multiarch:
>=20
> =C2=A0 run-gdbstub-proc-mappings: sha1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(call run-test, $=
@, $(GDB_SCRIPT) \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --gdb $(HAVE_GDB_BIN) \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --bin $< --test $(MULTIARCH_SRC)/gdbstub/tes=
t-proc-
> mappings.py, \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 proc mappings supp=
ort)
>=20
> =C2=A0 # only enable for s390x and aarch64 for now
> =C2=A0 ifneq (,$(findstring aarch64,$(TARGET_NAME)))
> =C2=A0 EXTRA_RUNS +=3D run-gdbstub-proc-mappings
> =C2=A0 else ifneq (,$(findstring s390x,$(TARGET_NAME)))
> =C2=A0 EXTRA_RUNS +=3D run-gdbstub-proc-mappings
> =C2=A0 endif
>=20
> but it still ends up pretty ugly. Is the gdb handling fixed for other
> arches in other versions. Maybe we could probe gdb for support and
> wrap
> the whole stanza in something like:
>=20
> =C2=A0 ifeq ($(HOST_GDB_SUPPORTS_PROC_MAPPING),y)
> =C2=A0 ...
> =C2=A0 endif
>=20
> ?

I think I better add the check to the test itself, because otherwise we
have to probe GDB against QEMU binary we just built, which sounds
unnecessarily complicated.

The error message on all arches without this series is:

    warning: unable to open /proc file '/proc/1/maps'

The error message on x86_64 (expected) with this series is:

   Not supported on this target.

So we can simply exit(0) from the test if we see this.

