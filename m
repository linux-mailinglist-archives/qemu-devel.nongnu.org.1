Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFDF74765B
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 18:21:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGim0-0004fh-Ip; Tue, 04 Jul 2023 12:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGily-0004f1-1m; Tue, 04 Jul 2023 12:21:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGilv-0006SC-Ij; Tue, 04 Jul 2023 12:21:01 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 364GAQB0010551; Tue, 4 Jul 2023 16:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wNYBMRwmcFO2kcTh3RgskaMryK2kGKo4hrmQ6i5oe4c=;
 b=SQ+4lSa+tHty48tbFX2LUmrnXqwDm4fkuJo/MHc2XsNCcj6aQnnNTFuidhPZRYo6A5rt
 32NG9B3u7CP9XxSQIcb/E3P+r20SnJcRjN63wfvgI2oDyFLZM/vitYg1AeNrG2TO5DMu
 6qW3xcRT5OTNBm4NXBDiu2heFMe2D/lBURvIGJ6wQ2AAzDSmIg1alkDklhMEIfE/+As2
 kK/9VNf7zXxjGF2eS6J5hU3J2URLaM1p8YgVwP7y6SW8hrePL7oe/fHEQ1NxJ5on1wk/
 339v4cpKzNJyr9iSLGoAFj82aQf8pAZTOUFpeZkES4XI92m8DUe20HEa4uitD1dSM0O+ Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmpch8g24-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 16:20:54 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 364GBACM013184;
 Tue, 4 Jul 2023 16:20:54 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmpch8g10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 16:20:53 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 364DHjRP025333;
 Tue, 4 Jul 2023 16:20:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4t45e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 16:20:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 364GKnAK18875030
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Jul 2023 16:20:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B2F62005A;
 Tue,  4 Jul 2023 16:20:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F2C820043;
 Tue,  4 Jul 2023 16:20:49 +0000 (GMT)
Received: from [9.171.14.192] (unknown [9.171.14.192])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Jul 2023 16:20:49 +0000 (GMT)
Message-ID: <25be9d1c-08bb-94ff-50e2-8e5e317ef997@linux.ibm.com>
Date: Tue, 4 Jul 2023 18:20:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 0/4] ppc: Improve multisocket support
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
References: <20230704134921.2626692-1-clg@kaod.org>
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20230704134921.2626692-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BCWqrWZAdrqSXfziVXICBVVLwdlgYEFM
X-Proofpoint-ORIG-GUID: HM98-nZRieXg1bSiIlKWu_prKxoBiY55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_10,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=551
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307040139
Received-SPF: pass client-ip=148.163.156.1; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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



On 04/07/2023 15:49, Cédric Le Goater wrote:
> Hello,
> 
> Here are changes improving multisocket support of the XIVE models
> (POWER9 only). When a source has an END target on another chip, the
> XIVE IC will use an MMIO store to forward the notification to the
> remote chip. The long term plan is to get rid of pnv_xive_get_remote()
> whic is a modeling shortcut. I have had them for while, they compile,
> they seem to still work but this is not for merge yet. If someone
> could take over, that would be nice.
> 
> The best way to test is to start a 2 sockets * 1 cpu system with devices
> attached to the PCI buses of chip 0 and to offline CPU 0. All sources
> should be configured to be served by CPU 1 on socket 1 and trigger
> notifications on chip 0 should be forwarded to chip 1.
> 
> Last patch adds support for degenerative interrupts. This is used by
> the lowest level FW of POWER systems. Difficult to test.
> 


Thanks for the series! My crystal ball tells me the PC MMIO patch will 
come handy soon (to be adapted for P10 and groups). And the remote 
routing looks pretty interesting too.
The last patch (LSI) may rot a bit longer though :)

   Fred


> Thanks,
> 
> C.
> 
> Cédric Le Goater (4):
>    ppc/xive: introduce a new XiveRouter end_notify() handler
>    ppc/pnv: handle END triggers between chips with MMIOs
>    ppc/pnv: add support for the PC MMIOs
>    ppc/pnv: Add support for degenerative interrupts (POWER LSI)
> 
>   hw/intc/pnv_xive_regs.h   |   1 +
>   include/hw/ppc/pnv_xive.h |  15 +++
>   include/hw/ppc/xive.h     |   3 +
>   hw/intc/pnv_xive.c        | 262 +++++++++++++++++++++++++++++++-------
>   hw/intc/xive.c            |  50 ++++++--
>   5 files changed, 278 insertions(+), 53 deletions(-)
> 

