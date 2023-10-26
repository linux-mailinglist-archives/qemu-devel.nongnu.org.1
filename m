Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B39277D849D
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 16:25:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw1HK-00038x-Fl; Thu, 26 Oct 2023 10:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qw1HD-00038L-55; Thu, 26 Oct 2023 10:23:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qw1HA-0000YZ-W6; Thu, 26 Oct 2023 10:23:58 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QEK2Kt007904; Thu, 26 Oct 2023 14:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=GAGBLtgAJXpzXPMY0wHrOOWsUamAQ+ArzxT0hd4C0rk=;
 b=JXmlRLXSsvjw3+NNoflnSBfQUFIq953yhEdj3YBdwT4E2Fve+B8PDZEtY4s2JtYPzBn2
 F91M2keCnY/O/7DOoKqhMnvNf95HWxMtll0+TozHFzFuZf9yRVudpqWBoYvIq8jaiyun
 MRJbN2t80PMtLW39MjzYVgWmiZnqJuxBWV7jYsCOipvPTYoo5yojgimoUWCFOWyW5Viu
 IzT6/HLu9XaBFstCe6X2FZU1O0IN6a7As2jtsa6l3bj3Zkqs3C5boAP2LASt6QhSbEFX
 J0Av+fL2XwHQkT4okE9jbjyMh+0PyAZMgc0R9f4/W7VRonCm/PGc6d/c32JedHBgviBe 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tysse82xk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 14:23:36 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39QEKncv010188;
 Thu, 26 Oct 2023 14:23:28 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tysse82ur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 14:23:28 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QDvnl5023782; Thu, 26 Oct 2023 14:23:21 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvrytewa0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Oct 2023 14:23:21 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39QENJGh48824814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 14:23:20 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFA2E5804B;
 Thu, 26 Oct 2023 14:23:19 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C44F58055;
 Thu, 26 Oct 2023 14:23:17 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.13.38]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Oct 2023 14:23:17 +0000 (GMT)
Message-ID: <504f3e06f85c864a5019a01f9f4bb61cea092de1.camel@linux.ibm.com>
Subject: Re: [PATCH v3 01/37] vfio/container: Move IBM EEH related functions
 into spapr_pci_vfio.c
From: Eric Farman <farman@linux.ibm.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com, Nicholas
 Piggin <npiggin@gmail.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Harsh Prateek
 Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, "open
 list:sPAPR (pseries)" <qemu-ppc@nongnu.org>, "open list:S390 general
 arch..." <qemu-s390x@nongnu.org>
Date: Thu, 26 Oct 2023 10:23:16 -0400
In-Reply-To: <20231026103104.1686921-2-zhenzhong.duan@intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0LjR_zeF-CxoKZrT04G2TSMf_MeQZMx3
X-Proofpoint-GUID: M6doxcjptmOcuGttTWffzlLEFxmPKBs_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_12,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

On Thu, 2023-10-26 at 18:30 +0800, Zhenzhong Duan wrote:
> With vfio_eeh_as_ok/vfio_eeh_as_op moved and made static,
> vfio.h becomes empty and is deleted.
>=20
> No functional changes intended.
>=20
> Suggested-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> =C2=A0include/hw/vfio/vfio.h=C2=A0 |=C2=A0=C2=A0 7 ---
> =C2=A0hw/ppc/spapr_pci_vfio.c | 100
> +++++++++++++++++++++++++++++++++++++++-
> =C2=A0hw/vfio/ap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0hw/vfio/ccw.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0hw/vfio/common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 -
> =C2=A0hw/vfio/container.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 98 ------------=
--------------------------
> -
> =C2=A0hw/vfio/helpers.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 1 -
> =C2=A07 files changed, 99 insertions(+), 110 deletions(-)
> =C2=A0delete mode 100644 include/hw/vfio/vfio.h

Can't speak to the code movement, but removing the header file from
those places where it's not used is fine.

Acked-by: Eric Farman <farman@linux.ibm.com>

