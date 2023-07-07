Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5079074AD43
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 10:43:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHh3l-00072Z-0F; Fri, 07 Jul 2023 04:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1qHh3i-00070M-5z; Fri, 07 Jul 2023 04:43:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1qHh3g-0001Kb-Bh; Fri, 07 Jul 2023 04:43:21 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3678dMOj020310; Fri, 7 Jul 2023 08:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : reply-to :
 in-reply-to : content-type : content-transfer-encoding; s=pp1;
 bh=F+nMelXtWH0QuLZZqfIic7T5LDe1tQRdK5LmBmr8xe0=;
 b=XXb8ScKb/tJUnCw3dDUNCwMe8XpUwa6nDJV1a9LrkB5nIBi7LvYWBFiNTRD0ANk3/A3P
 tq+BNIxV0rD32fS5G1d1isFPOoKgKNdlFl0C0ggM4QCtuT4FI2AHFRqfK6Q128fAt4yg
 WEoktWaSqbhuemV6TwmoL8gHYhjiFkKfzLRjTkzk+UqnrpgjufjnZyqnL5g3KIpZP14g
 ET6mOY+bC0WLNxI07pw9fa+7meus+EvTBCST3PTgTd/v/J2mINizMMJuhFnmAO3FLOqG
 4qu0v0HdBcT5vKOzHpLp00xLnM083YJ6gRKNPGYXSkorqV7TzZzqiIpsLYPUNdiCrDpf hg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpf2a8ee2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Jul 2023 08:43:03 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3678f5nd025883;
 Fri, 7 Jul 2023 08:43:03 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpf2a8eck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Jul 2023 08:43:03 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3677w31h024382;
 Fri, 7 Jul 2023 08:43:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3rjbddtuv2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Jul 2023 08:43:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3678gwB827263440
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Jul 2023 08:42:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C63520043;
 Fri,  7 Jul 2023 08:42:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8E1F2004B;
 Fri,  7 Jul 2023 08:42:55 +0000 (GMT)
Received: from [9.43.6.151] (unknown [9.43.6.151])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Jul 2023 08:42:55 +0000 (GMT)
Message-ID: <f9e124ca-809c-11b6-ba57-e4879d29c4b3@linux.ibm.com>
Date: Fri, 7 Jul 2023 14:12:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 3/3] ppc: Enable 2nd DAWR support on p10
Content-Language: en-US
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, mikey@neuling.org, kvm@vger.kernel.org,
 mst@redhat.com, mpe@ellerman.id.au, cohuck@redhat.com,
 qemu-devel@nongnu.org, groug@kaod.org, paulus@samba.org, clg@kaod.org,
 pbonzini@redhat.com, ravi.bangoria@amd.com
References: <20210412114433.129702-1-ravi.bangoria@linux.ibm.com>
 <20210412114433.129702-4-ravi.bangoria@linux.ibm.com>
 <YH0M1YdINJqbdqP+@yekko.fritz.box>
 <ca21d852-4b54-01d3-baab-cc8d0d50e505@linux.ibm.com> <YJIyCnVYohsdKLvf@yekko>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <YJIyCnVYohsdKLvf@yekko>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GH0cxobMMVQVYaXnGAqgR_Uu3zFDWWzt
X-Proofpoint-ORIG-GUID: qKGIMe0_oXr0HA773PwGY1RG_epAtZTm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_05,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 mlxlogscore=699 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070078
Received-SPF: pass client-ip=148.163.156.1; envelope-from=sbhat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HK_RANDOM_REPLYTO=0.999,
 NICE_REPLY_A=-0.091, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: YJIyCnVYohsdKLvf@yekko.fra02v.mail.ibm.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi David, All,

I am revisiting/reviving this patch.

On 5/5/21 11:20, David Gibson wrote:
> On Wed, Apr 21, 2021 at 11:50:40AM +0530, Ravi Bangoria wrote:
>> Hi David,
>>
>> On 4/19/21 10:23 AM, David Gibson wrote:
>>> On Mon, Apr 12, 2021 at 05:14:33PM +0530, Ravi Bangoria wrote:
>>>
<snip>
> Since we have released versions with POWER10 support, but no DAWR1, in
> theory we need a capability so new qemu with old machine types don't
> gain guest visible features that the same machine types on older qemus
> had.
>
> Except.. there's a loophole we might use to sidestep that.  The
> current POWER10 CPU modelled in qemu is a DD1 - which I strongly
> suspect will never appear outside of IBM.  I'm pretty sure we want to
> replace that with a DD2.
>
> While the modelled CPU is DD1, I think it's pretty reasonable to say
> our POWER10 support hasn't yet stabilized, and it would therefore be
> ok to simply add DAWR1 on POWER10 unconditionally, as long as we do it
> before we switch over to DD2.

As POWER10 DD2 switch over has already happened, the need for

new/separate capability for dawr1 still holds. So, I am keeping it as is.


Posting the next version after rebase.


Thanks,

Shivaprasad

>>> I'm wondering if we're actually just better off setting the pa feature
>>> just based on the guest CPU model.  TCG will be broken if you try to
>>> use it, but then, it already is.  AFAIK there's no inherent reason we
>>> couldn't implement DAWR support in TCG, it's just never been worth the
>>> trouble.
>> Correct. Probably there is no practical usecase for DAWR in TCG mode.
>>
>> Thanks,
>> Ravi
>>

