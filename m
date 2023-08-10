Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C31447782B7
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 23:32:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUDFo-0004xO-5l; Thu, 10 Aug 2023 17:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qUDFl-0004xG-58
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 17:31:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qUDFi-0000VG-Qx
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 17:31:32 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37ALQXec031375; Thu, 10 Aug 2023 21:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Fdh5tS9BpEgcPE7w6UQ9/EtyOTcorqfHSgvhcHDaYI4=;
 b=l2YDA3HCLgMWzMfAaaWpYUMhd10mYqh5eNhRegjBBx8rczTFDYo4mHgdLkPQirlKRYFb
 FntmIh0j19YZ7acRmePdbcOktUkRL+P3aFWg1QqLXe72f27WYov0O4Aa4oaJUmUlbw0H
 XRnBhk69C1cICSewFO6zfzIiuTyWGNaHfMOGn7Up3j3NmA82ZDrTktqTnIKgDaWxcoKa
 WQPV00rqAlatAWJfk1gjZXYqyaNnRV99kKeqP51OgxCQtfxTleig9DdS6APX7T2LJFFE
 bMPHyOXmZiMPxwKi3D7JFSRM6SoETJK8WvlVNzqRCu4bQ7WhyU/O2TDOUNjobgxSfu3p cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sd7thg2y9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Aug 2023 21:31:03 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37ALQsOf032057;
 Thu, 10 Aug 2023 21:31:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sd7thg2xu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Aug 2023 21:31:03 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37AJS3YO006421; Thu, 10 Aug 2023 21:31:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sd2evag88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Aug 2023 21:31:02 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37ALV0u520513530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Aug 2023 21:31:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0C9620043;
 Thu, 10 Aug 2023 21:31:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E66020040;
 Thu, 10 Aug 2023 21:31:00 +0000 (GMT)
Received: from [9.171.63.20] (unknown [9.171.63.20])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Aug 2023 21:31:00 +0000 (GMT)
Message-ID: <0b00937cb4643ef19029e48d1de2a90c3614c3b5.camel@linux.ibm.com>
Subject: Re: [PATCH for-8.1 v10 10/14] util/selfmap: Rewrite using
 qemu/interval-tree.h
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de
Date: Thu, 10 Aug 2023 23:31:00 +0200
In-Reply-To: <d2842004-ce3e-325f-69a7-3eec6e4cd1d5@linaro.org>
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-11-richard.henderson@linaro.org>
 <d2842004-ce3e-325f-69a7-3eec6e4cd1d5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VDJCw7_dwrJxYtddpFfCzFeBLcs3nyHY
X-Proofpoint-GUID: 7e5-MS-WRx18nUJntyTyZAtgawrxiiLf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=773 impostorscore=0
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100181
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Mon, 2023-08-07 at 11:17 -0700, Richard Henderson wrote:
> On 8/7/23 09:37, Richard Henderson wrote:
> > We will want to be able to search the set of mappings.
> > For this patch, the two users iterate the tree in order.
> >=20
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> > =C2=A0 include/qemu/selfmap.h |=C2=A0 20 ++++----
> > =C2=A0 linux-user/elfload.c=C2=A0=C2=A0 |=C2=A0 14 +++--
> > =C2=A0 linux-user/syscall.c=C2=A0=C2=A0 |=C2=A0 15 +++---
> > =C2=A0 util/selfmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 114 +++++++++++++++++++++++++-----------
> > -----
> > =C2=A0 4 files changed, 96 insertions(+), 67 deletions(-)
>=20
> I should note that, for 8.2, this will enable a rewrite of
> open_self_maps_1 so that it=20
> does not require page-by-page checking of page_get_flags.
>=20
> My idea is that open_self_maps_1 would use walk_memory_regions to see
> all guest memory=20
> regions.=C2=A0 The per-region callback would cross-check with the host-
> region interval tree to=20
> find the dev+inode+path.
>=20
> Cc Ilya and Helge, since there are two outstanding changes to
> open_self_maps.
>=20
>=20
> r~

My outstanding change should not be sensitive to this; it should be
possible to put it in both before or after the rewrite.



I really like this idea though, since I looked into ppc64le and there
printing maps is quite broken: it's not just that QEMU can't determine
the names of the mapped files, but also a number of regions are simply
missing. This also affects core dumps generated by GDB attached to
gdbstub.

For example, cat /proc/self/maps has the following internal page
layout:

start            end              size             prot
0000000010000000-000000001000d000 000000000000d000 r-x
000000001000d000-0000000010010000 0000000000003000 ---
0000000010010000-000000001001f000 000000000000f000 r--
000000001001f000-0000000010020000 0000000000001000 r--
0000000010020000-0000000010021000 0000000000001000 rw-
0000100000000000-0000100000010000 0000000000010000 ---
0000100000010000-0000100000810000 0000000000800000 rw-
0000100000810000-0000100000830000 0000000000020000 r-x
0000100000830000-000010000083d000 000000000000d000 r-x
000010000083d000-0000100000840000 0000000000003000 ---
0000100000840000-000010000084f000 000000000000f000 r--
000010000084f000-0000100000850000 0000000000001000 r--
0000100000850000-0000100000851000 0000000000001000 rw-
0000100000851000-0000100000852000 0000000000001000 rw-
0000100000860000-0000100000861000 0000000000001000 r-x
0000100000880000-0000100000a50000 00000000001d0000 r-x
0000100000a50000-0000100000a60000 0000000000010000 r--
0000100000a60000-0000100000a70000 0000000000010000 rw-
0000100000a70000-0000100000b70000 0000000000100000 rw-
0000100000b70000-000010000742d000 00000000068bd000 r--
00007fffb22b0000-00007fffb22e0000 0000000000030000 rw-

but prints only:

100000000000-100000010000 ---p 00000000 00:00 0                      =20
100000010000-100000810000 rw-p 00000000 00:00 0                      =20
[stack]
100000810000-100000830000 r-xp 00000000 fd:00 3049136                =20
/usr/lib64/ld-2.17.so
100000880000-100000a50000 r-xp 00000000 fd:00 3017372                =20
/usr/lib64/libc-2.17.so
100000a50000-100000a60000 r--p 001c0000 fd:00 3017372                =20
/usr/lib64/libc-2.17.so
100000a60000-100000a70000 rw-p 001d0000 fd:00 3017372                =20
/usr/lib64/libc-2.17.so
100000a70000-100000b70000 rw-p 00000000 00:00 0                      =20
7fffb22b0000-7fffb22e0000 rw-p 00000000 00:00 0                      =20

I don't see a good way to prevent page_check_range() from rejecting
most of the mappings with the current code structure, but I think that
after the proposed rewrite it should begin to just work.

