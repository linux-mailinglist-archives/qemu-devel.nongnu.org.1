Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D81BF5460
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Oct 2025 10:35:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7oz-0004IY-4l; Tue, 21 Oct 2025 04:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vB7ov-0004HV-0x; Tue, 21 Oct 2025 04:34:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vB7on-0007z7-NC; Tue, 21 Oct 2025 04:34:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KMmlhd015153;
 Tue, 21 Oct 2025 08:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=y1f+XH
 XFLaBwmTFwJbNAM8tdNEK3R/QofhGR0fPjJN0=; b=KH2LNSypDyDyet4uLvuJcE
 ye2iK8CkiwwHoFPlXQLPKtGScbNCeGwlNsw/gpWgZSF1tlLc0feVEfOTbyCKjoYN
 nL+l7yqW8EAlel1N1N9sM3yObtAMvn6LoLm28kkzFhp2anJeUnAB26NBXAhO7TX/
 Q/xt25ib03KJ6YvPxKv5whVznZwyi3oof33dxDPbnw/TQ5whnSC4XqvsSEeVWoh7
 YB43pjieV6EzYS8zFXC9aLXck2L0k7xiiFJDnb5V7+uFlkp/R0c/UFbaGlBbXa6s
 DY+2L93bDhfJxdG6rP9/JNUTmqyyXGZszrxzPiFWzm5lWuZYbaBzGnF/qbAQbr+w
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rwxdm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 08:34:07 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59L8SpLf029686;
 Tue, 21 Oct 2025 08:34:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rwxdg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 08:34:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L7rCDo032142;
 Tue, 21 Oct 2025 08:34:05 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7mssh7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 08:34:05 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59L8Y4eG63242568
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 08:34:05 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7DF758056;
 Tue, 21 Oct 2025 08:34:04 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BEE85805D;
 Tue, 21 Oct 2025 08:34:02 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Oct 2025 08:34:02 +0000 (GMT)
Message-ID: <6c1c6488-679b-4bb8-8fb2-569a9f705ba7@linux.ibm.com>
Date: Tue, 21 Oct 2025 14:04:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] hw/ppc/spapr: Remove deprecated pseries-3.0 ->
 pseries-4.2 machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 qemu-ppc@nongnu.org, kvm@vger.kernel.org,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20251020103815.78415-1-philmd@linaro.org>
 <fdb7e249-b801-4f57-943d-71e620df2fb3@linux.ibm.com>
 <8993a80c-6cb5-4c5b-a0ef-db9257c212be@redhat.com>
 <6dcf7f38-5d1d-47a0-b647-b63b9151b4b6@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <6dcf7f38-5d1d-47a0-b647-b63b9151b4b6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 10K1frV2wbgOTd-IUkUtYqy7Y71EM2nc
X-Proofpoint-GUID: dFVBtMpVflffMbYtxfCSPHpOWs16ZHP5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7wH5vPH8yRwJ
 F/hxg0kL7deEniW1GQw2O28m0WSzet4lOsyvdimbnmzXVzMXq1orAQmmzAjFg7rQIUg8riGDRLs
 kpn1MQF+tBvx/ppo1Kio9viidcK3WruI8NhXXjI/dC6rf4b7lj83EZcwlafGfB0ghI6wEbesQNy
 QUv38/lnYHGju7zhm3M3OZVHu879oT4ZqqpMvhUtc5aFatEtk9atsFl2QvlAAsReAEqYDyVI8Ij
 jaKV1c8Rrv+PCe+j5kTlOp/pWN6e/mBXAZXuMs15CWk08iBHTrL1ZX3o3Mp2IcmJ6Ad6DhdLaC4
 aGVmRsApZNpF7QpTEXdZT0Oy3Bs75FgaAbS+V6/nwmq6/GB2TW3BJgU3YhgFZHNys3Fs72padFP
 chYKUKJ/aoS4R4V6oxRS1Cn6rluTvQ==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f7457f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=QSvJpS1G6Mq8gHJVPkUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=oH34dK2VZjykjzsv8OSz:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10/21/25 13:16, Philippe Mathieu-Daudé wrote:
> On 21/10/25 08:31, Cédric Le Goater wrote:
>> Hi
>>
>> On 10/21/25 06:54, Harsh Prateek Bora wrote:
>>> +Cedric
>>>
>>> Hi Phillipe,
>>>
>>> It had been done and the patches were reviewed already here (you were 
>>> in CC too):
>>>
>>> https://lore.kernel.org/qemu-devel/20251009184057.19973-1- 
>>> harshpb@linux.ibm.com/
>>
>> I would take the already reviewed patches, as that work is done. This 
>> series
>> is fine, but it is extra effort for removing dead code, which isn't worth
>> the time.
> 
> My bad for missing a series reviewed 2 weeks ago (and not yet merged).
> 
> Please consider cherry-picking the patches doing these cleanups then,
> which were missed because "too many things changed in a single patch"
> IMHO:
> 
> -- >8 --

Thanks for highlighting the delta cleanups, we can take care.

regards,
Harsh

