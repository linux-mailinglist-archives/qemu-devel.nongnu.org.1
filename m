Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCAF7ECC52
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 20:28:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3LY2-00024K-Fs; Wed, 15 Nov 2023 14:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1r3LY0-00023G-Hm; Wed, 15 Nov 2023 14:27:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1r3LXy-0005JJ-TK; Wed, 15 Nov 2023 14:27:36 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AFJLlaK013367; Wed, 15 Nov 2023 19:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+m4yKwLXjBRYZTAO1X6G4XC9d8x0mG6yfs6wRR2O+P0=;
 b=pdDEPAOztghgAaY+WgFHOCfVCxCOSD614PNT7qbV4sSeYhg5xMEbRFcuMfMWA7clVsEf
 mAC2Bpk6yMMnM5LmDnEsvH6y0XkHnMKiBBm6pWi0lIj4KDm5Nts1iSe/rqbVhelZqoBx
 loHX5fhpP1h6LDS/t6/F7EESDPXLxzL2b9gIjfAEaw4MmpM8DzfVtUKc8sjn3UO8+lfQ
 SIQYeMP6sYTJ4kJGJ6nCxKDNauB6IHecFx+7Avfz0IQ7WkkNvBiXK1zochM0N/8gMDw/
 f+jb7uSHG+fAVEqPS7CRPHjmjiXGJnaFaRznvw6o2QCoFQFz76QaA8fEoAHfxF6Hrswu sA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ud26euc0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Nov 2023 19:27:31 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFJM2j6016672;
 Wed, 15 Nov 2023 19:27:31 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ud26euc0e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Nov 2023 19:27:31 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AFIEVXp020493; Wed, 15 Nov 2023 19:27:29 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamxnhm20-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Nov 2023 19:27:29 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AFJRSY535062510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Nov 2023 19:27:29 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C9595805D;
 Wed, 15 Nov 2023 19:27:28 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FAE758057;
 Wed, 15 Nov 2023 19:27:27 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.49.33]) by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Nov 2023 19:27:27 +0000 (GMT)
Message-ID: <7507770e3aae40f6cd7811deece0306a65e5d02a.camel@linux.ibm.com>
Subject: Re: [PATCH 3/4] vfio/ap: Move VFIODevice initializations in
 vfio_ap_instance_init
From: Eric Farman <farman@linux.ibm.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com, Tony
 Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Jason
 Herne <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, "open
 list:vfio-ap" <qemu-s390x@nongnu.org>
Date: Wed, 15 Nov 2023 14:27:26 -0500
In-Reply-To: <20231115083218.1973627-4-zhenzhong.duan@intel.com>
References: <20231115083218.1973627-1-zhenzhong.duan@intel.com>
 <20231115083218.1973627-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D7-UVyRCob8nM7q30FckCc-d2rftP5oO
X-Proofpoint-GUID: w6sH25m-eCnDQhAYbaPf_8e_az7s_xxE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_19,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150154
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

On Wed, 2023-11-15 at 16:32 +0800, Zhenzhong Duan wrote:
> Some of the VFIODevice initializations is in vfio_ap_realize,
> move all of them in vfio_ap_instance_init.
>=20
> No functional change intended.
>=20
> Suggested-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> =C2=A0hw/vfio/ap.c | 26 +++++++++++++-------------
> =C2=A01 file changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

