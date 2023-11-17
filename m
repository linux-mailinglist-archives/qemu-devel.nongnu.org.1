Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B99B07EF7B5
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 20:10:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r44Cs-0001t5-DH; Fri, 17 Nov 2023 14:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r44Cq-0001sb-Ef; Fri, 17 Nov 2023 14:08:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1r44Cg-0002R8-Kc; Fri, 17 Nov 2023 14:08:44 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AHJ76OV029865; Fri, 17 Nov 2023 19:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=52Cs8gTnPAcoBXRivwrPvYKmX162ZImN8tdxLyjMvxU=;
 b=jIgBZyhKk2AkDZ8l8D1x0Vej+asql/zw5qk5+HnPezMO7NULBbAR5YNc8amXo/yBPFWA
 qJJjIx1E9tv59Oceo+A9b5r1/UVMMd7/lX5WsX7Dd8NbKPOy5UpbwCJv/75WXh0Cg8FF
 4IFoRpfLh947SE6NQOy+HAZRSTsguGPQSseRCCCnx7oMVc1RfS/WcSbyoDAtGjM84PDO
 fqHS/sE6mngjC2ZHf0VNLBBD3LNo9fAx/b1dwruUw5q5rPLeqNdXfxsOUH5TQKm/Zb50
 V0RLAtbS7ZNhGATRwANwv44W/UWbTtmmGGbpysrizkJtW/96di5Qf+yr0vu9riIIn0oF fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uee20g2g7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Nov 2023 19:08:23 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AHJ7vCV003054;
 Fri, 17 Nov 2023 19:08:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uee20g2f6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Nov 2023 19:08:22 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AHIR70X009036; Fri, 17 Nov 2023 19:08:21 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uanem827s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Nov 2023 19:08:21 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AHJ8KHL33358424
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Nov 2023 19:08:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD2BD58059;
 Fri, 17 Nov 2023 19:08:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A367558055;
 Fri, 17 Nov 2023 19:08:20 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Nov 2023 19:08:20 +0000 (GMT)
Message-ID: <bcafd2e50df3758f5be551b36f8dbfb6f9d3197c.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/8] ppc/pnv: Add pca9552 to powernv10 for PCIe
 hotplug power control
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, =?ISO-8859-1?Q?Fr=E9d=E9ric?=
 Barrat <fbarrat@linux.ibm.com>
Date: Fri, 17 Nov 2023 13:08:20 -0600
In-Reply-To: <401c3b41-8344-4043-9f7d-26844fcb03cd@kaod.org>
References: <20231114195659.1219821-1-milesg@linux.vnet.ibm.com>
 <20231114195659.1219821-2-milesg@linux.vnet.ibm.com>
 <54fad54f-a52e-41c6-90ba-7bc0b637cd59@kaod.org>
 <d5c90e92aa4cf313925de81872e95d0b62c36cce.camel@linux.vnet.ibm.com>
 <bd0875a1-4258-457d-8a9b-cfa12f0d84ef@kaod.org>
 <07f8b838e5a6696f81b6fc056105cf8dddbcaab4.camel@linux.vnet.ibm.com>
 <401c3b41-8344-4043-9f7d-26844fcb03cd@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qiYzNo_64wnWFDfvXA3o0ed_yA5326_B
X-Proofpoint-GUID: x9QiV9BIHzlnjJ6ig9WVmku6_P9sQwOZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_18,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170145
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Fri, 2023-11-17 at 17:04 +0100, Cédric Le Goater wrote:
> > Well, I was hoping to sweep the pca9554 model under the PowerNV
> > maintainership (like pca9552 is under the BMC aspeed
> > maintainership).
> > I did update the PowerNV list to include it, but perhaps that was
> > presumptuous of me. :-)
> 
> Well, you are the person who has the most knowledge on both and
> you have access to HW to check changes !
> 
> > I would be ok with being added as a reviewer under the PowerNV
> > list,
> > but I wonder if I shouldn't have more opensource experience before
> > becoming a maintainer? TBH, I have no idea what that would entail.
> 
> For these devices, mostly acking the changes. I don't think anyone
> will ask you to send PRs. This can be handled through some other
> tree, PPC or Aspeed.
> 
Ok, that doesn't sound too bad.  Sign me up!

>   
> > As for patches 3 and 4, it sounds like I should split those changes
> > out
> > from the current patch series so that they can make it into QEMU
> > 8.2.
> > Correct?
> 
> I don't think this is needed. They can be picked in the series and
> merged in the ppc tree independently.
> 
> Thanks,
> 
> C.
> 
Ok, sounds good.

Thanks,

Glenn


