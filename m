Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC861748DEF
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 21:34:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH8F8-0000Oq-N7; Wed, 05 Jul 2023 15:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1qH8F5-0000OY-5K; Wed, 05 Jul 2023 15:32:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1qH8F3-0008OF-5K; Wed, 05 Jul 2023 15:32:46 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 365JIgI4011624; Wed, 5 Jul 2023 19:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=nNqtbnYcvkZwWUcosY/3BQt2vowJQIvbWZPFzQc6YFA=;
 b=lkfGYC7i/A1QNPKUl/Er2oXAi+AQ+19PBgNMgwSLLuETzP24NnR+1FM1yCf5h0KRIFK8
 dBx/Bl2n1DVtW7CBBi2ygRh0MoGnGgQ3Jv5v1/DVo9nUyJIyzHn5VsMjIivydA62F+Xk
 Zira0AcTaEoniiYdNEZwjKJOj5EIYS4obi/clprLTmpOiq/SnEgaTX03UgrQGLiBwOeM
 P88b9vwGYvQt2dO9aK6WxUiT93q08e26nDxchAel2wQ9VIVAvIl6pnFCQ72jJBQfFgUd
 hE+Q9VPZkGZYsqiuqtfw9QFZYNn628vQhtskHFTq6q/5hgRrRTnhlYzwK21VkogAf6me oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnejhgb1j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 19:32:42 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 365JKhrb017758;
 Wed, 5 Jul 2023 19:32:42 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnejhgb16-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 19:32:42 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 365IKFvc016306;
 Wed, 5 Jul 2023 19:32:41 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
 by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3rjbs6gx0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 19:32:41 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 365JWdPo64880916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Jul 2023 19:32:39 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9366C58059;
 Wed,  5 Jul 2023 19:32:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5BF058055;
 Wed,  5 Jul 2023 19:32:38 +0000 (GMT)
Received: from [9.61.162.136] (unknown [9.61.162.136])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Jul 2023 19:32:38 +0000 (GMT)
Message-ID: <2f042bde-bb57-a148-7a18-16991735a427@linux.ibm.com>
Date: Wed, 5 Jul 2023 15:32:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] kconfig: Add PCIe devices to s390x machines
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20230705152301.2850086-1-clg@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230705152301.2850086-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a9EM5mPRiwpBjOff4k20M_h19FX22abQ
X-Proofpoint-GUID: yHK-7vcxxaWbP9ceuj4TNXdL6pWnpjGD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_10,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=986 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050173
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/5/23 11:23 AM, Cédric Le Goater wrote:
> It is useful to extend the number of available PCI devices to KVM guests
> for passthrough scenarios and also to expose these models to a different
> (big endian) architecture. Include models for Intel Ethernet adapters
> and one USB controller, which all support MSI-X. Devices only supporting
> INTx won't work on s390x.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Acked-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
> 
>  v3: PCI -> PCI_EXPRESS
>  v2: select -> imply
>   
>  hw/s390x/Kconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
> index 5e7d8a2bae8b..ab62c9120545 100644
> --- a/hw/s390x/Kconfig
> +++ b/hw/s390x/Kconfig
> @@ -5,8 +5,11 @@ config S390_CCW_VIRTIO
>      imply VFIO_AP
>      imply VFIO_CCW
>      imply WDT_DIAG288
> -    select PCI
> +    select PCI_EXPRESS
>      select S390_FLIC
>      select SCLPCONSOLE
>      select VIRTIO_CCW
>      select MSI_NONBROKEN
> +    imply E1000E_PCI_EXPRESS
> +    imply IGB_PCI_EXPRESS
> +    imply USB_XHCI_PCI


