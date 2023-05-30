Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D45FF716B27
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 19:31:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43Bb-0003LJ-2r; Tue, 30 May 2023 13:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q43BY-0003Km-Q2; Tue, 30 May 2023 13:31:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q43BX-0004Ng-4E; Tue, 30 May 2023 13:31:04 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UGlXv9014383; Tue, 30 May 2023 17:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CVDXMS51QvHyr8mnDWodcSzkoGw1DV/HfYyx1qTq4Pg=;
 b=S9tNUcHX9Ka4THIdVTkC6ySfZzGyNWw0Z5fijrXEZ3eKzwgGL8zW9eqB2JH3dW8mK7g5
 qEPX6g/EDwbaH1lukJFVKiYVJPBYohraccuskzxFGVoFy2M7fJTLLY327X/gb+cuTVbw
 WaOEBYrT6/fLgkf9KmnXQVEAITUuni5+ZK32VI0xUrEFqIesxajyhSsX+wp9es2+0S+N
 Lja8T8EufQTlKZ8DncMf3VYe5U8QVLqDQpFZoAn/Jqbg/zThwmCz1n4tjtaBiYyrq1kI
 WmqRmZ+Yzv8DMn4mmmb2fZCniL9tkCHXN7VQ44qrnb5Dyakbf/mR+zWxgCKsF3bthrTl /g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwmf2224a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 17:30:53 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UHTf99028354;
 Tue, 30 May 2023 17:30:52 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwmf2223p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 17:30:52 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U3UTcQ029244;
 Tue, 30 May 2023 17:30:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qu9g51kmf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 17:30:50 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34UHUlnD14615154
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 17:30:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D96B320040;
 Tue, 30 May 2023 17:30:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E5C620043;
 Tue, 30 May 2023 17:30:47 +0000 (GMT)
Received: from [9.171.3.249] (unknown [9.171.3.249])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 May 2023 17:30:47 +0000 (GMT)
Message-ID: <38fdc4d6-ab1d-c305-c42f-0efab30c23a5@linux.ibm.com>
Date: Tue, 30 May 2023 19:30:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] pnv/xive2: Handle TIMA access through all ports
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230530161129.313258-1-fbarrat@linux.ibm.com>
 <20230530161129.313258-5-fbarrat@linux.ibm.com>
 <be9a5a3a-a46a-6317-dd2b-cd442f019158@kaod.org>
 <b731ee69-0e1f-6eef-4c44-e6711ea39c12@kaod.org>
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <b731ee69-0e1f-6eef-4c44-e6711ea39c12@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qg3hjRzLOObAlCAkRL3qhqA43YpIzjdU
X-Proofpoint-ORIG-GUID: 3vDikFwXOlB0DzX5V3FZP5snx0Kuvnbp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_12,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxlogscore=780
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300135
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



On 30/05/2023 18:49, Cédric Le Goater wrote:
> On 5/30/23 18:40, Cédric Le Goater wrote:
>> On 5/30/23 18:11, Frederic Barrat wrote:
>>> The Thread Interrupt Management Area (TIMA) can be accessed through 4
>>> ports/snoop buses, targeted by the address. The base address of a TIMA
>>> is using port 0 and the other ports are 0x80 apart. Using one port or
>>> another can be useful to balance the load on the snoop buses.
>>
>> and can we have some nice examples of how these ports are used ? only for
>> snooping or also for balancing operations ? which ones ?
>>
>>> The TIMA registers are in the 0x0 -> 0x3F range and there are 2
>>> indication bits for special operations (bits 10 and 11; everything
>>> fits on a 4k page). So the port address bits fall in between and are
>>> "don't care" for the hardware when processing the TIMA operation. So
>>> this patch filters out those port address bits so that a TIMA
>>> operation can be triggered using any port.
>>>
>>> It is also true for indirect access (through the IC BAR) and it's
>>> actually nothing new, it was already the case on P9. Which helps here,
>>> as the TIMA handling code is common between P9 (xive) and P10 (xive2).
>>>
>>> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
>>
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> 
> one extra comment, since we already have one mask for the tima offsets :
> 
>      /*
>       * First, check for special operations in the 2K region
>       */
>      if (offset & 0x800) {
> 
> I think it would be cleaner to add some defines in the reg definition file.


Yeah, you're right, I should respin it with some proper defines. And 
I'll add one for the special op bit(s).

   Fred


> 
> Can come later.
> 
> Thanks,
> 
> C.
> 

