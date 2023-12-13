Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 844FB810C3D
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 09:19:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDKRz-0007dS-1k; Wed, 13 Dec 2023 03:18:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1rDKRx-0007ZB-2T; Wed, 13 Dec 2023 03:18:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1rDKRu-00015o-Mr; Wed, 13 Dec 2023 03:18:36 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BD7ViE6012748; Wed, 13 Dec 2023 08:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9dxGxDkRI2n88nSZnJ6xjea9gHwx+oU1HrZZkNgtm4M=;
 b=D7lXDHqw1ema7grnERdhr3Ri7r6PKV6vqpwp5f8I0rU+9qr2ruJjt6Pj0YYRoWCZbDX2
 msVfiXrbquQblxWdx/jNsFL6rOW1J4NCCiaO5Ekff0cCmn5ivjWV4zdMWt2nrvO6iPRU
 b9xyDENba536kqy6cKSTo8Yf2/mhGHP4I1z8f9tVt7og8jGb5fWY8/ocfCamW/kkvr8+
 nizUgOAWY6HaVgHt5dxBBN9xjd+BtWESeoOo39QLJcVCzPSR1TZF7cyQdRe9o+b7gcDn
 EME12/riciIWhmUdv8dYBYapgboawO/WiCX2F//U0k29KeCGijZdGIyCQUteukAh1m7d Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uy5kqeq3u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Dec 2023 08:18:30 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BD7Vr5n013455;
 Wed, 13 Dec 2023 08:18:30 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uy5kqeq3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Dec 2023 08:18:30 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BD6RaSQ012616; Wed, 13 Dec 2023 08:18:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw3jnycn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Dec 2023 08:18:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3BD8IQwb44761756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Dec 2023 08:18:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4773B20040;
 Wed, 13 Dec 2023 08:18:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B51402004B;
 Wed, 13 Dec 2023 08:18:25 +0000 (GMT)
Received: from [9.179.21.241] (unknown [9.179.21.241])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 13 Dec 2023 08:18:25 +0000 (GMT)
Message-ID: <e6411bed-dcd4-46fb-80eb-cf8ff89e90d0@linux.ibm.com>
Date: Wed, 13 Dec 2023 09:18:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/s390x/ipl: Remove unused 'exec/exec-all.h'
 included header
To: Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>
References: <20231212113640.30287-1-philmd@linaro.org>
 <20231212113640.30287-4-philmd@linaro.org>
 <a5560c21-658d-436c-a26f-87066b152d0a@linux.ibm.com>
 <1b0414d48d1798146f9a07ed1e6afdfbdd39b076.camel@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <1b0414d48d1798146f9a07ed1e6afdfbdd39b076.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f8cjELj-vqUSeyoMYjaEWii4iDoVVhxp
X-Proofpoint-ORIG-GUID: W9g8tYq3TRjIsptC5oSC8tWOpk9GU_Pz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_14,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=734 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130059
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Am 12.12.23 um 16:28 schrieb Eric Farman:
>> So why do you think exec-all.h is unused?
>>
>>
> 
> I think because that got moved out of exec-all.h a few months ago, via
> 
> commit 3549118b498873c84b442bc280a5edafbb61e0a4
> Author: Philippe Mathieu-Daudé <philmd@linaro.org>
> Date:   Thu Sep 14 20:57:08 2023 +0200
> 
>      exec: Move cpu_loop_foo() target agnostic functions to 'cpu-
> common.h'
>      
>      While these functions are not TCG specific, they are not target
>      specific. Move them to "exec/cpu-common.h" so their callers don't
>      have to be tainted as target specific.
> 

Ah right, I was looking at an old QEMU version....

