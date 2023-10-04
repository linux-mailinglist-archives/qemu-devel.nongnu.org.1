Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC3F7B7C80
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:43:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnyPK-0005DC-Qk; Wed, 04 Oct 2023 05:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qnyPG-00056J-OG; Wed, 04 Oct 2023 05:43:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qnyPE-00079n-Mr; Wed, 04 Oct 2023 05:43:02 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3949SuBM030949; Wed, 4 Oct 2023 09:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1mgzZqfqsgnNQK383EQTSSA62wm5Z2vWJW1eOBy1Hs4=;
 b=f+X17uM8gsTAsvAl5XSYRQx5Jg87kodIuldd1Y656+L67pdLAQN2tvn7S5xAatPKEUUr
 XzDdZ090WnDTkj6KYsCCrFv6RNWAtfgw8PrayBLXFJIhLPGzlfd3ks92nEa3b7xC/qgV
 o1n1A9PhyB54cRFKju+ccN2CaQ0ATBsLBaRzYGgWGm+1HnxLuLAOeNXGsh02wHAQa6bV
 22oEUGJKYtaeT0Jji8d2i6dOJP0xMiMTSrBeUnPzopNmHku6zggXVWsVUOyvltpPAZeh
 Yjv8uDOsDb8angu96ID6UgYruL9R+wXG+9zbSLnWub5UZFEN6+NJ8DQ5ALB2Rj1iywHN 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th5eurads-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 09:42:55 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3949fFEX032426;
 Wed, 4 Oct 2023 09:42:54 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th5euradc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 09:42:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39487o1D006672; Wed, 4 Oct 2023 09:42:53 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tf07k25n3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 09:42:53 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3949gqnV25559464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Oct 2023 09:42:52 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 824A558054;
 Wed,  4 Oct 2023 09:42:52 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F19F75805C;
 Wed,  4 Oct 2023 09:42:48 +0000 (GMT)
Received: from [9.43.72.102] (unknown [9.43.72.102])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Oct 2023 09:42:48 +0000 (GMT)
Message-ID: <b2097361-bae3-ee5a-a970-a872fd41dc97@linux.ibm.com>
Date: Wed, 4 Oct 2023 15:12:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND 10/15] ppc: spapr: Initialize the GSB Elements
 lookup table.
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-11-harshpb@linux.ibm.com>
 <CVCCMLRLPB9H.3T7JJ2S044E0I@wheely>
 <3fc620bf-c43e-248b-ad4a-9a69812ca235@linux.ibm.com>
In-Reply-To: <3fc620bf-c43e-248b-ad4a-9a69812ca235@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d8TcXlgYQxot-_xANOiFhI2saRpVMvIq
X-Proofpoint-ORIG-GUID: U5xRxNF4Tf2mbG_QWlhwv9qYfxZIPUPq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=859
 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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



On 10/4/23 14:57, Harsh Prateek Bora wrote:
>>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>>> index 9b1f225d4a..ca609cb5a4 100644
>>> --- a/hw/ppc/spapr_hcall.c
>>> +++ b/hw/ppc/spapr_hcall.c
>>> @@ -1580,6 +1580,7 @@ static void hypercall_register_types(void)
>>>       spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
>>>       spapr_register_nested();
>>> +    init_nested();
>>
>> This is for hcall registration, not general subsystem init I think.
>> Arguably not sure if it matters, it just looks odd for everything
>> else to be an hcall except this. I would just add a new init
>> function.
> 
> I have introduced a new spapr_nested_init routine in spapr_nested.c 
> which shall be called from spapr_instance_init. I think we can move GSB 
> init there.

I revisited the code and feel it is better to do it post hypercall 
registrations in cap apply for nested-papr only as this init is needed 
only for nested papr API.

