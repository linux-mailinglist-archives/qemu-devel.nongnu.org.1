Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D00EE73FBA1
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:03:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7Ph-0007Qe-63; Tue, 27 Jun 2023 08:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qE7Pd-0007P3-4c; Tue, 27 Jun 2023 08:03:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qE7Pa-0007as-Sx; Tue, 27 Jun 2023 08:03:12 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35RBlhcC021846; Tue, 27 Jun 2023 12:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=aJReNsBJEEGQAsTab4bdyL5gcvsPvB8HZmW6KswA7nk=;
 b=jc+xBX6/gVFu3p5rFgB+GRv+I8iQ6jD9mjE0rtNkCHPyRTOMJoU8EG6FGwc8Z6FiH0Un
 gCA3I3WyccBdoeu23iUNeQTGeISF9lHPSAUgs2E7c6nt7hpTCUw/cdZEStESvSVv0Ivj
 aH7tEKzx3eKLqk4heh9GQGBJHhJ8FGyLnnE72/jw8clDu6geKCGkNfkDTJxGADNW+gVu
 5i2X1SjJFxqCb4jVlZI9EvRVNbf6FiGhWTzTsCFa24STkxzzmDCndBbUlRsd3z4yG3hj
 QFzz3D7iKaf97j5HEaALcA62Ky/dahMWt+V3Imb6aX9Z938ViBIZFGNDGsNsFV0AF8jW Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfy6y0cfx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 12:03:08 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35RBog1V028679;
 Tue, 27 Jun 2023 12:03:08 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfy6y0cf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 12:03:08 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35RAs6ac027909;
 Tue, 27 Jun 2023 12:03:07 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
 by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3rdr45gd1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 12:03:06 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35RC35nj61342206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 12:03:05 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D3DF5805D;
 Tue, 27 Jun 2023 12:03:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F59258056;
 Tue, 27 Jun 2023 12:03:04 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.34.238]) by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jun 2023 12:03:04 +0000 (GMT)
Message-ID: <3c7d925e0d0f4750a678aa1d7f3270a9ba58abab.camel@linux.ibm.com>
Subject: Re: [PATCH] pc-bios/s390-ccw: Get rid of the the __u* types
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, cohuck@redhat.com,
 Juan Quintela <quintela@redhat.com>
Date: Tue, 27 Jun 2023 08:03:04 -0400
In-Reply-To: <20230627114101.122231-1-thuth@redhat.com>
References: <20230627114101.122231-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wb1WdPz6F6KTFQS7QY21QkTWccm4RaEb
X-Proofpoint-GUID: zzUuvis1JAvKDpMujtaQcIhCqh2xmEF1
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_07,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0
 mlxlogscore=755 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270106
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

On Tue, 2023-06-27 at 13:41 +0200, Thomas Huth wrote:
> Using types starting with double underscores should be avoided since
> these
> names are marked as reserved by the C standard. The corresponding
> Linux
> kernel header file has also been changed accordingly a long time ago:
>=20
> =C2=A0
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/dif
> f/drivers/s390/cio/cio.h?id=3Dcd6b4f27b9bb2a
>=20
> So we should get rid of the __u* in the s390-ccw bios now finally,
> too.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
> =C2=A0Based-on: <20230510143925.4094-4-quintela@redhat.com>
>=20
> =C2=A0pc-bios/s390-ccw/cio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 232 ++++++++=
++++++++++----------------
> --
> =C2=A0pc-bios/s390-ccw/s390-ccw.h |=C2=A0=C2=A0 4 -
> =C2=A02 files changed, 116 insertions(+), 120 deletions(-)

Thanks for the based-on hint.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

