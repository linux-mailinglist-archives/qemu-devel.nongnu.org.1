Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC57F831FB3
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 20:26:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQY1F-00050v-L1; Thu, 18 Jan 2024 14:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rQY1B-00050h-Ve; Thu, 18 Jan 2024 14:25:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rQY19-0007sw-Od; Thu, 18 Jan 2024 14:25:37 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40IIpGGN001249; Thu, 18 Jan 2024 19:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Tp3na67vCgUb3exfR07Ku84IwfiDn2HkpZ8JsiujMcM=;
 b=UnO90oIVa6jdjPdSI/KrgZN0s80qYPHfRkrYV0+5SjMZsTIX58rcsQJxmtC1WjUu93uQ
 74I/Dt0Yl0ql0Bo08O9f1jyY6H82Q8MvW8lQCZiYVXqCN4tUbDDqLfdt2qNY06ia8o1c
 +KV2W/PV1SRtjxIYYN5iP5aY0Ohvrja5ETwCEOtiXkNgoVb0Wy4lra2ZwIkF8idPJ12S
 wT6UEWME2Br7qosTTeJRYgpOboAWqZsKJskiQuM8ffJkUgrjwCcLwdBAPo/OooeqEyeD
 0iuGH1ORxVXVG/Zk2SQeK3lh3ESsy56u6GLxwWqXmkttWkZlPsRwwuEymwAeu48kgzxu /w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vq90c1v81-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 19:25:31 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40IJBICd017773;
 Thu, 18 Jan 2024 19:25:30 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vq90c1v7s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 19:25:30 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40IH1ANo000441; Thu, 18 Jan 2024 19:25:30 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm4ut5fhq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 19:25:30 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40IJPTZe47513954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jan 2024 19:25:29 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E4A65805C;
 Thu, 18 Jan 2024 19:25:29 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95FDA58051;
 Thu, 18 Jan 2024 19:25:28 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.107.253]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jan 2024 19:25:28 +0000 (GMT)
Message-ID: <120531a4bb642bb9e7f9509d0e0027ed6a1a0d2e.camel@linux.ibm.com>
Subject: Re: [PATCH v2 3/3] s390x/pci: drive ISM reset from subsystem reset
From: Eric Farman <farman@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: thuth@redhat.com, clg@redhat.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Date: Thu, 18 Jan 2024 14:25:28 -0500
In-Reply-To: <20240118185151.265329-4-mjrosato@linux.ibm.com>
References: <20240118185151.265329-1-mjrosato@linux.ibm.com>
 <20240118185151.265329-4-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DMCRVm8ddOyQ6iYU1limBG3D2v0iB6Eo
X-Proofpoint-ORIG-GUID: RAOJgsmqNFbC_jW5ak8B4MtUZS8NdEnS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 clxscore=1011 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401180140
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

On Thu, 2024-01-18 at 13:51 -0500, Matthew Rosato wrote:
> ISM devices are sensitive to manipulation of the IOMMU, so the ISM
> device
> needs to be reset before the vfio-pci device is reset (triggering a
> full
> UNMAP).=C2=A0 In order to ensure this occurs, trigger ISM device resets
> from
> subsystem_reset before triggering the PCI bus reset (which will also
> trigger vfio-pci reset).=C2=A0 This only needs to be done for ISM devices
> which were enabled for use by the guest.
> Further, ensure that AIF is disabled as part of the reset event.
>=20
> Fixes: ef1535901a ("s390x: do a subsystem reset before the unprotect
> on reboot")
> Fixes: 03451953c7 ("s390x/pci: reset ISM passthrough devices on
> shutdown and system reset")
> Reported-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
> =C2=A0hw/s390x/s390-pci-bus.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 26 +++++++++++++++++---------
> =C2=A0hw/s390x/s390-virtio-ccw.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 =
++++++++
> =C2=A0include/hw/s390x/s390-pci-bus.h |=C2=A0 1 +
> =C2=A03 files changed, 26 insertions(+), 9 deletions(-)

Thanks for the reminder on ISM/interpretation in v1.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

