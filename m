Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A36E81C025
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:30:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQcW-0003Pq-C5; Thu, 21 Dec 2023 16:30:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rGQcQ-0003Pc-22; Thu, 21 Dec 2023 16:30:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rGQcN-0001hX-Qj; Thu, 21 Dec 2023 16:30:13 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BLK2wFr011290; Thu, 21 Dec 2023 21:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+2MsgGCi5Zy4PXYmSAukD/wQUK9flxYnUNLKxfbzI3E=;
 b=AW4s3z+a67couv5YcarMjZsKAhVs6GLsvXNti/baHe9aA/XiYLWEp/0Mf42skIRGs4CV
 /iSY/I78+8ZODKCy7w6ral0HtvN8hBuloBydEpGRC75xVngmcJvsNP1OEoz+ytIPcXdn
 U4hWpzmFuaPdvRIIdRHLaIJLiEiI2n2Nh+F12WU40JOLnnaczvVsdNBIbhqowsiRuuOP
 hDGxe173KJY+cT6jMK/jUxN+kUlu7fxDdCh1xBa0JSgHYb+6ya5UGepcfUUrBUaETjAD
 lBYcRoThLR8NykfUyBs6xL2k5BJxyUxnSN7pwmJ5sMKW4l0ND/CpBQNs7QlO084QwLng 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v4qe9h4bm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Dec 2023 21:29:36 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BLLQVvT019328;
 Thu, 21 Dec 2023 21:29:35 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v4qe9h4ba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Dec 2023 21:29:35 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BLJZoYl027822; Thu, 21 Dec 2023 21:29:34 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v1rekf85e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Dec 2023 21:29:34 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3BLLTX9v26739156
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Dec 2023 21:29:34 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA0EC58055;
 Thu, 21 Dec 2023 21:29:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3ED6C5804B;
 Thu, 21 Dec 2023 21:29:32 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.129.84]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 Dec 2023 21:29:32 +0000 (GMT)
Message-ID: <8dbcecb47de387fa95ea4e8381bcd7e135cd9912.camel@linux.ibm.com>
Subject: Re: [PATCH 0/2] hw/s390x/ccw: Cleanup basename() and dirname()
From: Eric Farman <farman@linux.ibm.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, David Hildenbrand
 <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Date: Thu, 21 Dec 2023 16:29:31 -0500
In-Reply-To: <20231221171921.57784-1-zhao1.liu@linux.intel.com>
References: <20231221171921.57784-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m2dI6Lrg_WJwcXqVdGtIO3675tIA7j27
X-Proofpoint-ORIG-GUID: fjuERhrcJHvNWv6XjuRoPukLAiz9dohm
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_10,2023-12-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312210164
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

On Fri, 2023-12-22 at 01:19 +0800, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
>=20
> As commit 3e015d815b3f ("use g_path_get_basename instead of
> basename")
> said, g_path_get_basename() and g_path_get_dirname() should be
> preferred
> over basename() and dirname(), since g_path_get_basename() and
> g_path_get_dirname() are portable utility functions that have the
> advantage of not modifing the string argument.
>=20
> But commit 3e015d815b3f missed a use of dirname() and basename() in
> hw/s390x/ccw.
>=20
> And basename() (in vfio/container) caused compile breakage with the
> Musl
> C library [1].
>=20
> To avoid similar breakage and improve portability, replace basename()
> and dirname() with g_path_get_basename() and g_path_get_dirname().
>=20
> [1]:
> https://lore.kernel.org/all/20231212010228.2701544-1-raj.khem@gmail.com/
>=20
> ---
> Zhao Liu (2):
> =C2=A0 hw/s390x/ccw: Replace basename() with g_path_get_basename()
> =C2=A0 hw/s390x/ccw: Replace dirname() with g_path_get_dirname()
>=20
> =C2=A0hw/s390x/s390-ccw.c | 7 +++++--
> =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Farman <farman@linux.ibm.com>

