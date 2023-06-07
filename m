Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC377259BF
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 11:12:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6pD0-0007SB-CU; Wed, 07 Jun 2023 05:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1q6pCy-0007Rv-2d
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:12:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1q6pCt-0001Q1-Ik
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:11:59 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35797ImL026345; Wed, 7 Jun 2023 09:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=sc8JV7CF+SZXLvcWEu/HnqpsmgshkI+cI3olaYehTBk=;
 b=flZ30fHFQnoPR77JEeTEs5SxUEXOoSOZh2pIR1aFPQKTBf1jGjW3Yv6BC5IeJnhi05Lo
 4x+AEOrv4TX0LkUPZfHAN1CHlw7jAVamd6pfOBDv2rNoKsdYOM9YbiEg129ikvH9msfR
 Bm3L0Fumgg2VxrakXaSU+PMwpDrPvq/ZgObhEEmMtNNgXauIpyltBAUWmTHxONdfr9vl
 LK0wqlWLTTmvPgfTF//9bkJVMKB9Hyc3hAPlvhSDBr2/VLvvlgVmQH10bdyahB+Ee89G
 a3lMYCX+5YmrZGXCTqKrq9juOgUJ8yZq3meQ0hUDimTyXnepzgdLbzG48ponjkdM0Gx5 ng== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r2pbr8yd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jun 2023 09:11:52 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35797M6G026570;
 Wed, 7 Jun 2023 09:11:52 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r2pbr8ybd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jun 2023 09:11:52 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3578riG8008454;
 Wed, 7 Jun 2023 09:11:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3r2a768ahk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jun 2023 09:11:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3579Blmv53150096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Jun 2023 09:11:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 780D720040;
 Wed,  7 Jun 2023 09:11:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 100312004D;
 Wed,  7 Jun 2023 09:11:47 +0000 (GMT)
Received: from [9.171.17.169] (unknown [9.171.17.169])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  7 Jun 2023 09:11:46 +0000 (GMT)
Message-ID: <9f42964d50a610aa816917a0c1536d860e728ff5.camel@linux.ibm.com>
Subject: Re: [PULL 15/18] s390x/tcg: Fix CPU address returned by STIDP
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@redhat.com>
Date: Wed, 07 Jun 2023 11:11:46 +0200
In-Reply-To: <ea74b6cf-b247-4ddf-b350-4fca68798818@tls.msk.ru>
References: <20230606055621.523175-1-thuth@redhat.com>
 <20230606055621.523175-16-thuth@redhat.com>
 <ea74b6cf-b247-4ddf-b350-4fca68798818@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hmLkkCY1I_ekwBEha8Tu0xpYwyOQxc-U
X-Proofpoint-ORIG-GUID: Qg5N_0vEnmeoq71xYBK1y0o0Ypc3Muct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=823 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306070074
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

On Wed, 2023-06-07 at 12:05 +0300, Michael Tokarev wrote:
> 06.06.2023 08:56, Thomas Huth wrote:
> > From: Ilya Leoshkevich <iii@linux.ibm.com>
> >=20
> > In qemu-user-s390x, /proc/cpuinfo contains:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0processor 0: version =
=3D 00,=C2=A0 identification =3D 000000,=C2=A0
> > machine =3D 8561
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0processor 1: version =
=3D 00,=C2=A0 identification =3D 400000,=C2=A0
> > machine =3D 8561
> >=20
> > The highest nibble is supposed to contain the CPU address, but it's
> > off
> > by 2 bits. Fix the shift value and provide a symbolic constant for
> > it.
> >=20
> > With the fix we get:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0processor 0: version =
=3D 00,=C2=A0 identification =3D 000000,=C2=A0
> > machine =3D 8561
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0processor 1: version =
=3D 00,=C2=A0 identification =3D 100000,=C2=A0
> > machine =3D 8561
> >=20
> > Fixes: 076d4d39b65f ("s390x/cpumodel: wire up cpu type + id for
> > TCG")
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > Message-Id: <20230605113950.1169228-2-iii@linux.ibm.com>
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> > =C2=A0 target/s390x/cpu_models.h | 10 +++++++++-
> > =C2=A0 target/s390x/cpu_models.c |=C2=A0 4 ++--
> > =C2=A0 2 files changed, 11 insertions(+), 3 deletions(-)
>=20
> Is it a -stable material too?
> (applies cleanly to 7.2 and 8.0)
>=20
> Thanks,
>=20
> /mjt

Yes, from my perspective, it would be good to put this into stable.
I forgot to tag it, because the rest of the series was a new feature.
Thanks for noticing!

