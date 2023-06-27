Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A606173FA6B
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 12:46:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE6Bl-0006Ie-GB; Tue, 27 Jun 2023 06:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qE6Be-0006IK-Jw; Tue, 27 Jun 2023 06:44:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qE6Bb-0005pT-Uc; Tue, 27 Jun 2023 06:44:42 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35RAgEQQ005702; Tue, 27 Jun 2023 10:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1wanP/TzcUkgkdeZoX1md4u65vGodaLm5nCGObUXLcE=;
 b=Lfb3XF7vUX9C0jeg7vJN5DhvQMdXf5q/qmYjB6BKNRMNalUKWRpk8A976ePVk+uzdqJU
 YWu2XUIOQZ1de6azGsxTQFGZNllz0jHzsX+VMg6Aq5zHoqMLM9TtgRHscetliNDZz07s
 c1UlfJBexQYloz5tP8Ef6HDmu/4nBBh9xIcqbfsf6i2yED6VDEleFOd222yBTgBJa4pB
 kNd6HSv2LeeLijuc9qi4EykTjSGXY3yrF64kOOp6BzzgzCappUZ6iXmarUoD0WTgd1Dw
 Zm0chgKL0QzMbck0sSxJUgEFd9RNRQ1Ic+J/ZDjfDiM+cRkyzYvKIWTmuOTfMduMS3NK Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfwvrgc7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 10:44:37 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35RAh2Yl007804;
 Tue, 27 Jun 2023 10:44:36 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfwvrgc7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 10:44:36 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35R8V5tU008272;
 Tue, 27 Jun 2023 10:44:36 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
 by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3rdr460vvq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 10:44:36 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35RAiYsw59900168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 10:44:34 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C60C5803F;
 Tue, 27 Jun 2023 10:44:34 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3982C5804E;
 Tue, 27 Jun 2023 10:44:33 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.34.238]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jun 2023 10:44:33 +0000 (GMT)
Message-ID: <29d58ab7ad21e359ca0e499b8c109530d8c1395d.camel@linux.ibm.com>
Subject: Re: [PATCH v2 4/4] pc-bios/s390-ccw: Don't use __bss_start with the
 "larl" instruction
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 mrezanin@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clegoate@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, "Jason J .
 Herne" <jjherne@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Date: Tue, 27 Jun 2023 06:44:32 -0400
In-Reply-To: <20230627074703.99608-5-thuth@redhat.com>
References: <20230627074703.99608-1-thuth@redhat.com>
 <20230627074703.99608-5-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NUmDjkB07CNg-D-jdK0GtxTXteLFt700
X-Proofpoint-GUID: ujSXCGEjwC-uGoV5P6K5awhHIuwuHF9i
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=890
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306270096
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

On Tue, 2023-06-27 at 09:47 +0200, Thomas Huth wrote:
> start.S currently cannot be compiled with Clang 16 and binutils 2.40:
>=20
> =C2=A0ld: start.o(.text+0x8): misaligned symbol `__bss_start' (0xc1e5) for
> =C2=A0=C2=A0=C2=A0=C2=A0 relocation R_390_PC32DBL
>=20
> According to the built-in linker script of ld, the symbol __bss_start
> can actually point *before* the .bss section and does not need to
> have
> any alignment, so in certain situations (like when using the internal
> assembler of Clang), the __bss_start symbol can indeed be unaligned
> and thus it is not suitable for being used with the "larl"
> instruction
> that needs an address that is at least aligned to halfwords.
> The problem went unnoticed so far since binutils <=3D 2.39 did not
> check the alignment, but starting with binutils 2.40, such unaligned
> addresses are now refused.
>=20
> Fix it by using the real start address of the .bss section instead.
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D2216662
> Reported-by: Miroslav Rezanina <mrezanin@redhat.com>
> Suggested-by: Nick Clifton <nickc@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
> =C2=A0pc-bios/s390-ccw/start.S | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

