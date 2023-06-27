Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0AC73F9DF
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 12:15:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE5iS-0003yh-Iw; Tue, 27 Jun 2023 06:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qE5iI-0003yN-Ja; Tue, 27 Jun 2023 06:14:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qE5iG-0007VA-1t; Tue, 27 Jun 2023 06:14:21 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35RA1m10017935; Tue, 27 Jun 2023 10:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=CI0C2b0bVLWGk66KvQg6OBcX3b+zBKJaEYUQa7Et4k0=;
 b=qpHv8TKsu8pi/M6qorhyoP7yghyd887XwHhx2b1aejyCO7h+QTzO/N0jbw0wJ/SQQ84R
 ixYx4uGcY4C9D+tjL1+SEVRtUx8PuKaXdaqnBDAYBejPsa6KjO3wh6gdyTv7rvGke6bU
 ohb3EryW6wbbot2tS0Z/K1tBV81STbrnd5+a556oQoHKv+zwfh/rhNDnRnW6ybEwYu/3
 ITBo6kHB+ewKBSdGP1INumCIxOHrPP3oR+J5N4rVeEr+NkSLiVHp9ocFnx2DMY3le/LQ
 8GmO/WfEE/hEv3fIDNWWWMs171uYxwjGCfAE+LhzuCD4dbHkNMUzPO8astv6wjrrSWDN +g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfwnj8bsm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 10:14:16 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35RABB3x029650;
 Tue, 27 Jun 2023 10:14:16 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfwnj8bs3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 10:14:16 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35R6mbh4013276;
 Tue, 27 Jun 2023 10:14:15 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
 by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3rdr45g09d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 10:14:15 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35RAEDdq56033638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 10:14:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D850158055;
 Tue, 27 Jun 2023 10:14:13 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6E035803F;
 Tue, 27 Jun 2023 10:14:12 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.34.238]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jun 2023 10:14:12 +0000 (GMT)
Message-ID: <73106978c5a4bfbba7129dfca1ccaef41bda529d.camel@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] pc-bios/s390-ccw: Move the stack array into start.S
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 mrezanin@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clegoate@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, "Jason J .
 Herne" <jjherne@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Date: Tue, 27 Jun 2023 06:14:12 -0400
In-Reply-To: <20230627074703.99608-4-thuth@redhat.com>
References: <20230627074703.99608-1-thuth@redhat.com>
 <20230627074703.99608-4-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xtfgw4ZHH9e3Yl9YRg9GCG9mY995a4gY
X-Proofpoint-ORIG-GUID: 9Tzy-K8cthntAOAa0J5EkoOpNMOwnZX9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_06,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=941 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270094
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

On Tue, 2023-06-27 at 09:47 +0200, Thomas Huth wrote:
> The stack array is only referenced from the start-up code (which is
> shared between the s390-ccw.img and the s390-netboot.img), but it is
> currently declared twice, once in main.c and once in netmain.c.
> It makes more sense to declare this in start.S instead - which will
> also be helpful in the next patch, since we need to mention the .bss
> section in start.S in that patch.
>=20
> While we're at it, let's also drop the huge alignment of the stack,
> since there is no technical requirement for aligning it to page
> boundaries.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
> =C2=A0pc-bios/s390-ccw/s390-ccw.h | 1 -
> =C2=A0pc-bios/s390-ccw/main.c=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
> =C2=A0pc-bios/s390-ccw/netmain.c=C2=A0 | 1 -
> =C2=A0pc-bios/s390-ccw/start.S=C2=A0=C2=A0=C2=A0 | 6 ++++++
> =C2=A04 files changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

