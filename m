Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4160C7334A0
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 17:21:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qABFS-0002b7-Li; Fri, 16 Jun 2023 11:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>) id 1qABFQ-0002ae-0w
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 11:20:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>) id 1qABFO-0006Tc-6T
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 11:20:23 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35GFHYb7032523
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 15:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PCLVPtoeF0ox3a0wVXYoFORBAE4dXbtdaAd7iKNbfvw=;
 b=B3eT8X6+Q3or3B9X5mg6wzwZ4kQ1hAsja6APdO85lbreuhKgK7Y3gd3SgCheRi+6IZGx
 /DHso6tjGnDxtQSOkmedCEwuDopsWjs4Ij6uMh4nLpl6RBo1aQeLForvonz5sJryT64v
 IUNXptx+m4GM1uvoCPRTjKq4VN8mXUL76u+Ro8uveABdZo4/cdVFi+FtQGgpj032Satg
 JoCsmRmae/9mwfI5f8hRqezGcceTHfKIOV6q6IW8yd5JxaLiJB4M1g9N36hESF/emIpU
 WMm6i1rh2/goy0EAChCCmJkOhetzOrU7PU+d9bYlzWXDgPwRzxVHzHhsnA20Y5PoVemc 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r8t8dr4v9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 15:20:19 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35GFIAu4001960
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 15:20:19 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r8t8dr4t7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Jun 2023 15:20:19 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35G6MahB009776;
 Fri, 16 Jun 2023 15:20:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3r4gt54e77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Jun 2023 15:20:16 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35GFKEk521824056
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Jun 2023 15:20:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E4432004B;
 Fri, 16 Jun 2023 15:20:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1CCE620043;
 Fri, 16 Jun 2023 15:20:14 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown
 [9.171.84.241]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 16 Jun 2023 15:20:14 +0000 (GMT)
Message-ID: <bcd7bd4829ba2046b7cc8196e8e83fba338f2f94.camel@linux.ibm.com>
Subject: Re: [PATCH 07/10] pc-bios/s390-ccw: always build network bootloader
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, berrange@redhat.com
Date: Fri, 16 Jun 2023 17:20:13 +0200
In-Reply-To: <20230605095223.107653-8-pbonzini@redhat.com>
References: <20230605095223.107653-1-pbonzini@redhat.com>
 <20230605095223.107653-8-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UlIAeFHlYtjUbkDKSnXg74AAuc2q_9GN
X-Proofpoint-GUID: jXuYozRAGOFA3IM5IyvbuQsLdP7-ivrY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_10,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160136
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
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

On Mon, 2023-06-05 at 11:52 +0200, Paolo Bonzini wrote:
> In the beginning, the network bootloader was considered experimental and
> thus optional, but it is well established nowadays and configure always
> checks for roms/SLOF before compiling pc-bios/s390-ccw.

Only if run in a git repository, not in a tree generated with archive-sourc=
e.sh
which doesn't package roms/SLOF.
So without the check below the build fails.
This is not inteded, is it?

>=20
> Therefore, it makes sense to always build it together with the other
> part of the s390-ccw bios.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  pc-bios/s390-ccw/Makefile | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 9c5276f8ade..2e8cc015aa0 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -67,12 +67,7 @@ s390-ccw.img: s390-ccw.elf
> =20
>  $(OBJECTS): Makefile
> =20
> -ifneq ($(wildcard $(SRC_PATH)/../../roms/SLOF/lib/libnet),)
>  include $(SRC_PATH)/netboot.mak
> -else
> -s390-netboot.img:
> -	@echo "s390-netboot.img not built since roms/SLOF/ is not available."
> -endif
> =20
>  ALL_OBJS =3D $(sort $(OBJECTS) $(NETOBJS) $(LIBCOBJS) $(LIBNETOBJS))
>  -include $(ALL_OBJS:%.o=3D%.d)


