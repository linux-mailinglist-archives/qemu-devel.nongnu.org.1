Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8620A7EA59B
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 22:51:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2eoT-0004cc-GP; Mon, 13 Nov 2023 16:49:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1r2eoR-0004cF-3T; Mon, 13 Nov 2023 16:49:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1r2eoO-0002zn-Si; Mon, 13 Nov 2023 16:49:42 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADLkCkT002029; Mon, 13 Nov 2023 21:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9Xi4D4IbhtezJLCRslE9R7da3TPZ6N3jvkJhQB00Uj0=;
 b=cVyg+poexcVaZz5iVW8TS/YgN0fJWL1XJjwOlIj6DhwSex8lUXT3YpveNR3k7tAg3ovN
 fCqSl3Yh+fJmM0woNs2AeV2Nol+5wHEMWpBuEOxtqJDrYIuenoU9SE2Q4NMPW24UTN9s
 z1zwkqEHeqx7SopBm/pSwlfUNIz84gQaISiDJZi0q6nex8QMBU0W24iErXr7lRwl9sMc
 F/cI0itYtRnvaehf5Cn1OhFuiFiZRjYLvgL/t8JO3XcKIT0UwZi2qB9db680z0y5JGVE
 /qfrEFuSF58nHGUrW5rXzs8PIYfopXA+n5dXPU4W06Y7naAbiB9Z8y70UXwVoFpW4BW7 Vw== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ubv0jr1qr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Nov 2023 21:49:37 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADJYGIQ014693; Mon, 13 Nov 2023 21:49:37 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamay3svb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Nov 2023 21:49:37 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ADLnaMG30736772
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 21:49:36 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5A355803F;
 Mon, 13 Nov 2023 21:49:35 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F2475804E;
 Mon, 13 Nov 2023 21:49:35 +0000 (GMT)
Received: from [9.61.0.196] (unknown [9.61.0.196])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Nov 2023 21:49:35 +0000 (GMT)
Message-ID: <fa2bacd4-2d7d-06fa-e588-685697e03840@linux.ibm.com>
Date: Mon, 13 Nov 2023 16:49:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] s390x/pci: only limit DMA aperture if vfio DMA
 limit reported
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20231110175108.465851-1-mjrosato@linux.ibm.com>
 <20231110175108.465851-3-mjrosato@linux.ibm.com>
 <6222c257-2732-490c-8f84-3582f501d548@tls.msk.ru>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <6222c257-2732-490c-8f84-3582f501d548@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IlRKApGOmdZgNjHG-4eB0BgQKOR14H-7
X-Proofpoint-GUID: IlRKApGOmdZgNjHG-4eB0BgQKOR14H-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_12,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 mlxlogscore=788 spamscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311130169
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.971,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 11/13/23 4:24 PM, Michael Tokarev wrote:
> 10.11.2023 20:51, Matthew Rosato wrote:
>> If the host kernel lacks vfio DMA limit reporting, do not attempt
>> to shrink the guest DMA aperture.
>>
>> Fixes: df202e3ff3 ("s390x/pci: shrink DMA aperture to be bound by vfio DMA limit")
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> Is this stable-8.1 material?
> 
> Thanks,
> 
> /mjt
> 

Yes, I believe it is (sorry, should have added CC stable)

If you have a host kernel that doesn't report the vfio DMA limit the resulting PCI device will be rendered unusable in the s390x guest due this bug.

Thanks,
Matt

