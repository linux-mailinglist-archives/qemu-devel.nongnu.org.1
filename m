Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF347AF1E2
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:43:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlC5g-0000Zn-Ap; Tue, 26 Sep 2023 13:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qlC5e-0000ZA-DZ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 13:43:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qlC5c-00087j-Ej
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 13:43:18 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QHSMrO001150
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 17:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=au4gpeEh745Zi5q8bSQCLG73udJIegtDnP2FWhu0++I=;
 b=WZjRaARKUKvhvayraWLNXnsDYUkIfhUbeAC1MNA4ClYdD0f4UbA2Ths+Hr3VUX85nnf6
 6dT36itYyGu/aJjELY3GGD4qlMnaO2ee5VLd84He5oVUrG2CyMZoQEkmJcb6VisNlEqk
 IL0TUut+OrHK90uKos+qlmacfA0iazUfU8tyQuIt+g5W5h3vgK3mS7aVsvtODzzqQBHT
 cmfYhwuGGJj5PRVJHhQf8r4rxCqHvp+udglTMp2Dw1lobS0Ed+JRZ2tVkOd0eaExhBEG
 AMlWogv7B9NIyd8bnVL19XJNgFhXp9X5C5yDzTpom7ysQ3sqPTyAwD/PsXaKgfFWvYq4 ew== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tc3ge8tut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 17:43:15 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QHa78M024957
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 17:43:14 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tc3ge8tuf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 17:43:14 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QGrkiB011003; Tue, 26 Sep 2023 17:43:14 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabukd2e4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 17:43:13 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38QHhDOA22086350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 17:43:13 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A9B05805A;
 Tue, 26 Sep 2023 17:43:13 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9EA658056;
 Tue, 26 Sep 2023 17:43:12 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 26 Sep 2023 17:43:12 +0000 (GMT)
Message-ID: <88565c38-17f7-4518-822f-462d90fd0a32@linux.ibm.com>
Date: Tue, 26 Sep 2023 13:43:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 1/2] tpm: convert tpmdev options processing to new
 visitor format
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
To: James Bottomley <jejb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20230109161532.6892-1-jejb@linux.ibm.com>
 <20230109161532.6892-2-jejb@linux.ibm.com>
 <135a0a1d-3219-c537-130f-8e73ff333703@linux.ibm.com>
In-Reply-To: <135a0a1d-3219-c537-130f-8e73ff333703@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZKwKbqx1HlrZJ1YgGFhHJUbRXvJg7UwR
X-Proofpoint-ORIG-GUID: 906vdXqhGMh6O-Ct1ty5V25nKgQoN7SB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260152
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 9/26/23 11:20, Stefan Berger wrote:
>
> On 1/9/23 11:15, James Bottomley wrote:
>> From: James Bottomley <James.Bottomley@HansenPartnership.com>
>>
>> Instead of processing the tpmdev options using the old qemu options,
>> convert to the new visitor format which also allows the passing of
>> json on the command line.
>>
>> Signed-off-by: James Bottomley <jejb@linux.ibm.com>
>
>> +    while (!QSIMPLEQ_EMPTY(&tco_queue)) {
>> +        TpmCreateOptionsQueueEntry *tcoqe = QSIMPLEQ_FIRST(&tco_queue);
>>   -    return 0;
>> +        QSIMPLEQ_REMOVE_HEAD(&tco_queue, entry);
>> +        tpm_init_tpmdev(tcoqe->tco);
>
> tcoqe->tco and the possible emulator or passthrough specific 
> allocations should probably be also free'ed here.


Use: qapi_free_TpmCreateOptions(tcoqe->tco);



