Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4C8753A8C
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 14:17:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKHir-0002mk-53; Fri, 14 Jul 2023 08:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qKHio-0002mN-AF; Fri, 14 Jul 2023 08:16:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qKHim-0007An-QI; Fri, 14 Jul 2023 08:16:30 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36EBpcFc002834; Fri, 14 Jul 2023 12:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=LXdNkA3YDApjh7D4eHkWtEBuJWwINSrtl3RDece7jWo=;
 b=prJ8qxmvvsEcIMX9Xhouc0I71HPnuSFc4YJuH1EaDKu8H3nl5Hkg35yMBf6r3MamPRVT
 iGTOWbAO+HVQogZbZyMUHciyy1pFNhBUb3YjLBo+3pFcnpSRUc5JDn7dZljuHFe374MJ
 NhshW49ug0W1jqgqOE/ERl9aWBHJXmHbCCOaTqMRM6jj7JOqPA2jt/GCos334AizP5Uq
 IjbHQs+AgYOTsF3eh9FfrRcznDn+ZmAbIHcXYQU1C2JC/7ewx6t+aQ8SOik9W37YAYgw
 rZkx0xwSw/dcyZBkfXmc1N0H1mCSI4HHDO/bKglObmmj2mrCtS61SC9vhfBYWSKbOHcX aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru5dy10ka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 12:16:25 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36EC8AWM031485;
 Fri, 14 Jul 2023 12:16:24 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru5dy10k1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 12:16:24 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36E4eUNd007411; Fri, 14 Jul 2023 12:16:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rtpvs1mny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 12:16:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36ECGM2a37421694
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jul 2023 12:16:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55EE320043;
 Fri, 14 Jul 2023 12:16:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29DF920040;
 Fri, 14 Jul 2023 12:16:22 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jul 2023 12:16:22 +0000 (GMT)
Message-ID: <a55d41f884e6ff50872d389fa1a7c3dcf61afcc1.camel@linux.ibm.com>
Subject: [PATCH][PING] linux-user/elfload: Fix /proc/cpuinfo features: on s390x
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>, David Hildenbrand <david@redhat.com>, Thomas Huth
 <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Date: Fri, 14 Jul 2023 14:16:22 +0200
In-Reply-To: <f359dae7-e0a3-42cf-c2cd-fff7f9c3a607@linaro.org>
References: <20230627151356.273259-1-iii@linux.ibm.com>
 <f359dae7-e0a3-42cf-c2cd-fff7f9c3a607@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LVBFIeGYnQqLPHx1EbU5c56sLmOvaTzh
X-Proofpoint-GUID: 6ugdmt62I46JMHBTVtDokA6jYQc7wSIc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140109
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

On Wed, 2023-06-28 at 09:49 +0200, Richard Henderson wrote:
> On 6/27/23 17:13, Ilya Leoshkevich wrote:
> > elf_hwcap_str() takes a bit number, but compares it for equality
> > with
> > the HWCAP_S390_* masks. This causes /proc/cpuinfo to display
> > incorrect
> > hwcaps.
> >=20
> > Fix by introducing the HWCAP_S390_NR_* constants and using them in
> > elf_hwcap_str() instead of the HWCAP_S390_*. While at it, add the
> > missing nnpa, pcimio and sie hwcaps from the latest kernel.
> >=20
> > Output before:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0features=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: esan3 zarch stfle msa
> >=20
> > Output after:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0features=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: esan3 zarch stfle msa ldisp eimm etf3eh
> > highgprs vx vxe
> >=20
> > Fixes: e19807bee357 ("linux-user/elfload: Introduce elf_hwcap_str()
> > on s390x")
> > Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> > ---
> > =C2=A0 include/elf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 66 +++=
++++++++++++++++++++++++++++--------
> > -----
> > =C2=A0 linux-user/elfload.c | 41 ++++++++++++++-------------
> > =C2=A0 2 files changed, 69 insertions(+), 38 deletions(-)
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20
> r~

Hi,

I noticed that while the other s390x fixes were picked up and are in
master, this one wasn't. Is there anything I need to improve here?

Best regards,
Ilya

