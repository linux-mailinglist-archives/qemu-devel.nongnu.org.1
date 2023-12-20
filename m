Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F216681A7AD
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 21:36:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG3Hp-0006fM-3h; Wed, 20 Dec 2023 15:35:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rG3Hm-0006ei-Fw
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 15:35:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rG3Hj-0000sO-W3
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 15:35:21 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BKIh61u020723; Wed, 20 Dec 2023 20:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=lBJlpVgNToI26OCunKq7frZYXv/k1icd9/gmlQduOvg=;
 b=mdaw14HJsYRo1mw2YbGQx62zfgEMZbsDws6ms2l54rmtt9JgG/RZsWcaDT+JOrXAOtQK
 7iRLJWlCBjT58/HjKnY0jQ/AylssCgvmFG41F/M7DzgUH78F+WtBSrAODlsv6XkdKe3m
 VYpvx/4oDQbNEH3eBGUPa2NiTuw1Yc6l7GzlpQ9V5IJ2Xq7ul9yvGIWtVuToeofW1WsC
 NMgPsSqFW/Z8S3oGW4yDG7fx0sB0D3Dlj+4JTOUFiEPQVzGzXXsxxE0FRxJA9Xt0OTd8
 nYnh73hdfurRH6cY8bMlxqVd/OvXO02z1TfWIVo1Ez6KF+DthtE+r+ujHcZrdbgC9AIX xw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v441rx58q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Dec 2023 20:35:15 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BKKL2BN012321;
 Wed, 20 Dec 2023 20:35:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v441rx583-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Dec 2023 20:35:14 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BKJOvSG010870; Wed, 20 Dec 2023 20:35:14 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1q7nrrxk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Dec 2023 20:35:14 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3BKKZErh55116094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Dec 2023 20:35:14 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE57358054;
 Wed, 20 Dec 2023 20:35:13 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0679C58045;
 Wed, 20 Dec 2023 20:35:13 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.50.137]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 Dec 2023 20:35:12 +0000 (GMT)
Message-ID: <e215169f5504649cd3b8ec5ce66c988a8b5ba439.camel@linux.ibm.com>
Subject: Re: [PATCH for-9.0 v2 00/10] vfio: Introduce a VFIOIOMMUClass
From: Eric Farman <farman@linux.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, Eric Auger
 <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>
Date: Wed, 20 Dec 2023 15:35:12 -0500
In-Reply-To: <20231219065825.613767-1-clg@redhat.com>
References: <20231219065825.613767-1-clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7DC4Wu5OdMqFl5ulFX7oDin5ZfCoPc9i
X-Proofpoint-ORIG-GUID: eTwR90l8oMFPI7n4NqZWYkxynhCIcEfM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_13,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=776 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312200145
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Tue, 2023-12-19 at 07:58 +0100, C=C3=A9dric Le Goater wrote:
> Hello,
>=20
> The VFIO object hierarchy has some constraints because each VFIO type
> has a dual nature: a VFIO nature for passthrough support and a bus
> nature (PCI, AP, CCW, Platform) for its initial presentation.

The above caught my attention, so I kicked the tires on this series a
little bit both with an iommufd-enabled host kernel and without, so I
don't lose track of it over the holidays.

Tested-by: Eric Farman <farman@linux.ibm.com>

