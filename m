Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFA979E845
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 14:46:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPFr-00055H-Lt; Wed, 13 Sep 2023 08:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qgPFg-00052a-NO
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:45:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qgPFd-00010S-Rn
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:45:52 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38DCcWRQ002350; Wed, 13 Sep 2023 12:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+hHbwNhwC7Gy4ZwMdCoI6A20H/xxlSqCKA5HSgnvWrE=;
 b=TQYv3IyD9XVbcn1N1DFEI6bcSZDfGbagpGf8liULRlo6LUs3tvkNB+PXPd7hVzPMfybh
 XS8L48ZjO3YZ0Bt7nPb+3GC1spPVDVI05dQc6sckX1sHhUDGWb4xVjmAk6pscGnM4kkN
 VX5TEAMtye4DNDAHaGIq2Gg+rlNkbA3S8LMZjVn5SwBWq/2B+iVF20JG1krI8vIn4wxL
 cOL26FuTtHV9vdnEJ+H3Vgxm1gn+E2xcDwlK6TBtJMYpD7V75M/vQcRIVvJIwXhyOQJt
 /B9LgWf84ogLaXOmHaUSQb3VFOcFp3/98yJVBKaNPBuHLl5I4xkxj+xkKv2fbtuH23Z0 XQ== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t3d3p8mma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Sep 2023 12:45:43 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38DBtUDS011953; Wed, 13 Sep 2023 12:40:42 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r22h6e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Sep 2023 12:40:42 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38DCeg0m54395196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Sep 2023 12:40:42 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C13958060;
 Wed, 13 Sep 2023 12:40:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12FD85803F;
 Wed, 13 Sep 2023 12:40:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 13 Sep 2023 12:40:41 +0000 (GMT)
Message-ID: <f2888220-96b2-3280-a169-b3cda202cb9a@linux.ibm.com>
Date: Wed, 13 Sep 2023 08:40:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL v2 0/1] Merge tpm 2023/09/12 v2
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20230913115449.502183-1-stefanb@linux.ibm.com>
 <da9342e8-f38b-9276-60bc-62594651a4a9@linaro.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <da9342e8-f38b-9276-60bc-62594651a4a9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pPrPA17MKxlVwEhliebOm1Qe_mq87aWE
X-Proofpoint-ORIG-GUID: pPrPA17MKxlVwEhliebOm1Qe_mq87aWE
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_06,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=941 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130101
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 9/13/23 08:27, Philippe Mathieu-Daudé wrote:
> Hi Stefan,
>
> On 13/9/23 13:54, Stefan Berger wrote:
>> Hello!
>>
>>    This PR contains a fix for the case where the TPM file descriptor 
>> is >= 1024
>> and the select() call cannot be used. It also avoids unnecessary 
>> errors due to
>> EINTR being returned from the syscall.
>>
>> Regards,
>>     Stefan
>>
>> The following changes since commit 
>> 9ef497755afc252fb8e060c9ea6b0987abfd20b6:
>>
>>    Merge tag 'pull-vfio-20230911' of https://github.com/legoater/qemu 
>> into staging (2023-09-11 09:13:08 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/stefanberger/qemu-tpm.git 
>> tags/pull-tpm-2023-09-12-2
>>
>> for you to fetch changes up to 07160c57e47ce38bd256af3eae0481543fb52626:
>>
>>    tpm: fix crash when FD >= 1024 and unnecessary errors due to EINTR 
>> (2023-09-13 07:46:59 -0400)
>>
>> ----------------------------------------------------------------
>>
>> Marc-Andr޸ Lureau (1):
>>    tpm: fix crash when FD >= 1024 and unnecessary errors due to EINTR
>
> I recommend you the b4 tool, see:
> https://pypi.org/project/b4/
> https://people.kernel.org/monsieuricon/introducing-b4-and-patch-attestation 
>

I had tried to use 'patches' but it doesn't seem to work anymore on the 
python level. So I ended up saving the email via Thunderbird and applied 
it. Maybe that's the mistake? Otherwise I know the b4 tool and typically 
am using it for Linux patches but I see now that there's lore.kernel.org 
for qemu-devel as well. Alright, v3 coming up soon.

    Stefan



