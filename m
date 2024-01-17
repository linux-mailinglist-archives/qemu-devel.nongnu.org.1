Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAD282FEB0
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 03:02:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPvFR-0007X6-Ic; Tue, 16 Jan 2024 21:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rPvFO-0007Wt-Nu; Tue, 16 Jan 2024 21:01:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rPvFN-0004db-6h; Tue, 16 Jan 2024 21:01:42 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40H03m47017025; Wed, 17 Jan 2024 02:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=bHn1aWEwWbsVO388SUJL860c42gikuUfsg/DZn0q3Qc=;
 b=XXVk+uRMwRnsn5JPMky++veaa+LPYLy7kStDQYhUTllrnnOSa953HGGAAD6O0FAUEEIC
 bljKyx7E9b556TJZT3IXqzd01QRCu9PaLUo+Oemg5BTkg90IlsRqKBP+O6Jmef84d58J
 mMMiIUNbH+yXdMuTgRdehfs1HrcbfGofOoNZMG9lDRCOsNaCZhZYvljdTNUmQBaVVDvU
 U8vl95uvC4VOcy7NmaUA1Lo2r4NFD6UmGw6eihqE9aoFyhzHfEMWsYFTI1vOJMh7aHQO
 rHxI3a87GOEdeaCro6MWmgiN+KMldeawQMtEy/MQh3DEzVCX0IVxY4lnoBnLUXn2ENks yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp3us2sun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 02:01:31 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40H1kqaf001591;
 Wed, 17 Jan 2024 02:01:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp3us2stu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 02:01:31 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40H1J3j1023511; Wed, 17 Jan 2024 02:01:30 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm6bkjbch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 02:01:30 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40H21TT049676778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jan 2024 02:01:29 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 393E85803F;
 Wed, 17 Jan 2024 02:01:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C95C158054;
 Wed, 17 Jan 2024 02:01:27 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.107.253]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jan 2024 02:01:27 +0000 (GMT)
Message-ID: <4782f4432c524234f599b18a50017855ed8b7a49.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] s390x/pci: refresh fh before disabling aif
From: Eric Farman <farman@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: thuth@redhat.com, clg@redhat.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
Date: Tue, 16 Jan 2024 21:01:27 -0500
In-Reply-To: <20240116223157.73752-3-mjrosato@linux.ibm.com>
References: <20240116223157.73752-1-mjrosato@linux.ibm.com>
 <20240116223157.73752-3-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AN3hGoO9kbw5p_xpt-9eVkQqjV60kvNJ
X-Proofpoint-ORIG-GUID: NmLQCm05Ey84oXV6A4pAuYtu7kLXy2Q8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=767 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170011
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

On Tue, 2024-01-16 at 17:31 -0500, Matthew Rosato wrote:
> Typically we refresh the host fh during CLP enable, however it's
> possible
> that the device goes through multiple reset events before the guest
> performs another CLP enable.=C2=A0 Let's handle this for now by refreshin=
g
> the
> host handle from vfio before disabling aif.
>=20
> Fixes: 03451953c7 ("s390x/pci: reset ISM passthrough devices on
> shutdown and system reset")
> Reported-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
> =C2=A0hw/s390x/s390-pci-kvm.c | 11 ++++++++++-
> =C2=A01 file changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

