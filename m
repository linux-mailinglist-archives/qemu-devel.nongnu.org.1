Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AC97919B0
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:31:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAbM-0008Qr-0I; Mon, 04 Sep 2023 10:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qdAbI-0008QS-IL; Mon, 04 Sep 2023 10:30:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qdAbC-0008R8-Nr; Mon, 04 Sep 2023 10:30:46 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 384DjC9Y008170; Mon, 4 Sep 2023 14:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fyVZya4k1lxhEMSvnlNsbGmV5aGgTjqDVA4Grcc3/l8=;
 b=G6IsA9hCSWeXk59SkK+Afgm5Ip7uB/ePnIL3AaWywPYidsHBgEGl0TPzMiBPFrPdaO/j
 UnWuPBH5sbIyZ+SDv8eeCtDUg5D/F7uJp3ENPcgUAehXeNcEbU2v6wTdoHd7kFKc4gnD
 rjn7BCkvu6EHCjSXC04mp9doH4+uarINgKhkNPf/wBpurnz02wyYHtxL36OnRzhLo0cm
 +BTLxUGx8r+gd7FvJVHUmofSQajwelXA/FfbzReV0dN9bixapyWg80YySrkuo/cRXcgf
 zRn2s85LO1Dof9uIQKdg1FyBaEsMn2/H+8Vb23N8R15L3SxxFYA75evRsRu4VFQuDW1N kw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sw82bvrdx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Sep 2023 14:30:38 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 384E6rYZ014990;
 Mon, 4 Sep 2023 14:30:37 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sw82bvrdj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Sep 2023 14:30:37 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 384Du3C0011154; Mon, 4 Sep 2023 14:30:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svj31arr4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Sep 2023 14:30:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 384EUZGf16515754
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 Sep 2023 14:30:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E49120040;
 Mon,  4 Sep 2023 14:30:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEBBE2004E;
 Mon,  4 Sep 2023 14:30:34 +0000 (GMT)
Received: from [9.171.57.13] (unknown [9.171.57.13])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 Sep 2023 14:30:34 +0000 (GMT)
Message-ID: <d5e28e46b9fab10c0a505fd49f86c12481b9e185.camel@linux.ibm.com>
Subject: Re: [risu PATCH 0/4] Add support for s390x to RISU
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
Date: Mon, 04 Sep 2023 16:30:34 +0200
In-Reply-To: <20230904140040.33153-1-thuth@redhat.com>
References: <20230904140040.33153-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _yaC11pbCieQ4lD_2dbp3VPe6ogbdaOA
X-Proofpoint-ORIG-GUID: XpGxPd-2068u2wi52LJGL3fTGnYMRNFk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=742 impostorscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040126
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
> =C2=A0Hi Peter!
>=20
> Here are some patches that add basic support for s390x to RISU.
> It's still quite limited, e.g. no support for load/store memory
> operations yet, but the basics with simple 16-bit or 32-bit
> instructions work already fine.
>=20
> (In the long run, we'd need to support instructions with 48-bit
> length on s390x, too, since most newer "interesting" instructions
> like e.g. vector SIMD instructions are encoded with 48 bit. This
> will require modifications to the generic code, too, so I limited
> my initial implementation to 16-bit and 32-bit instruction length
> support to keep the code self-contained in the s390x architecture
> specific files)

What's also interesting about SIMD, is that floating-point instructions
clobber the upper parts of vector registers. I wonder if there is a way
to systematically solve this? In my scripts the solution isn't pretty:

            insn =3D gdb.execute("x/i $pc", to_string=3DTrue)
            print(insn)
            gdb.execute("stepi")
            if "%f" in insn:
               [ Skip comparison ]

I think there are also a few cases in non-SIMD areas, where PoP
basically says "if conditions X and Y hold, the output is
unpredictable".


One other thing - for not-so-near future - is it possible to integrate
this with coverage-based fuzzers? I.e., somehow generate the
instructions based on the coverage signal. Maybe even make sure that
the signal comes from JITed code too. I wanted to try AFLplusplus in
QEMU mode for this purpose (which would ultimately run QEMU in QEMU),
but never found the time.

[...]

