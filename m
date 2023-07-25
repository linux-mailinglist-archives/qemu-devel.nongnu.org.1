Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9E9760D72
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 10:44:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qODeX-0001Pu-Eo; Tue, 25 Jul 2023 04:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qODeQ-0001N2-N6; Tue, 25 Jul 2023 04:44:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qODeN-0004eo-Qk; Tue, 25 Jul 2023 04:44:14 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36P8dSU0030332; Tue, 25 Jul 2023 08:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=PGbURPgMuvCVhdPbMoPPe7B4Gb9eYScTDdx4mdDndco=;
 b=Df7PJAdfb+0QCpz39P6Pdf5SrgRQ3yejuGFUS/TQmMyd8F/Q0znx6Pmsf7F5okuotluj
 W/wul/jSKJ/gbbELC5nAQ/f2FDNjuEblV/xOIprRU0TLkipdI2VFdoGaoa7Nau+1+Fn3
 EuzQ2loGfbOpQM0N+1S9UiinsqtGd0UWsKz7wQdTINe29nBlmWeVZXZ2ZPmX5fwf5YKI
 2OXq/bi31iizPu2Nbn6xJ72CrtdTbcdyNvj12XORfxSoSh1eT5SzDX0nIu/XzN7pGOte
 0boDG8w0vbSuSH2Ft+2fXARMz9ily7o6xYzaAx+/jCbilPTr3HG6DJi4iO98K06F3AJW 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s252kf2sr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Jul 2023 08:43:59 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36P8eHDg000643;
 Tue, 25 Jul 2023 08:43:58 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s252kf2sk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Jul 2023 08:43:58 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36P7ev3W014384; Tue, 25 Jul 2023 08:43:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0stxtss4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Jul 2023 08:43:57 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36P8hrTM18678406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Jul 2023 08:43:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B555420043;
 Tue, 25 Jul 2023 08:43:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33C2520040;
 Tue, 25 Jul 2023 08:43:52 +0000 (GMT)
Received: from [9.179.30.40] (unknown [9.179.30.40])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 25 Jul 2023 08:43:52 +0000 (GMT)
Message-ID: <5c768763-82c9-5d31-696f-ce6c3bbc608f@linux.ibm.com>
Date: Tue, 25 Jul 2023 10:43:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v21 01/20] s390x/cpu topology: add s390 specifics to CPU
 topology
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, thuth@redhat.com,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 kvm@vger.kernel.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com,
 eblake@redhat.com, armbru@redhat.com, seiden@linux.ibm.com,
 nrb@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-2-pmorel@linux.ibm.com>
 <9c8847ad9d8e07c2e41f9c20716ba3ed6dd6b3dc.camel@linux.ibm.com>
 <29268e39-49ba-588a-022d-30b0882fea37@linux.ibm.com>
 <29c6965c8f2c9ec03074656c60966387d213234f.camel@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <29c6965c8f2c9ec03074656c60966387d213234f.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zk4MhkYdbmKgnb3gpEfKc0jVrtSMgbQ2
X-Proofpoint-GUID: qxhtscYprEyVUp8dM4dzttAWfsmL0yoV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_04,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=954
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250075
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pmorel@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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


On 7/24/23 12:15, Nina Schoetterl-Glausch wrote:
> On Fri, 2023-07-21 at 13:24 +0200, Pierre Morel wrote:
>> On 7/18/23 18:31, Nina Schoetterl-Glausch wrote:
>>> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>>>
>>> Some notes below.
>>>
>>> The s390x/ prefix in the title might suggest that this patch
>>> is s390 specific, but it touches common files.
>>
>> Right.
>>
>> What do you suggest?
>>
>> I can cut it in two or squash it with patch number 2.
>>
>> The first idea was to separate the patch to ease the review but the
>> functionality introduced in patch 1 do only make sense with patch 2.
>>
>> So I would be for squashing the first two patches.
>>
>> ?
> Oh, I'd just change the title.
>
> CPU topology: extend with s390 specifics
>
> or similar, it was just a nit not to create the impression that the
> patch only touches s390 stuff.


OK thanks

Pierre




