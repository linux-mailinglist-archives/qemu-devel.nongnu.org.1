Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AAF752A56
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 20:32:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK16z-0001Qo-Ft; Thu, 13 Jul 2023 14:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qK16w-0001Qc-F9
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 14:32:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qK16u-0000Zv-So
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 14:32:18 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DIPU7v026874; Thu, 13 Jul 2023 18:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=u6Z1Vtme+ItLyiWEOO0IItV8rQOokKiF2TlpcAftRBQ=;
 b=k6Alzmh5SgVrr+n3Ka83a/idh7u4eHufbKXjwLrSFhjgPHBuLy4vRTxgSrajBYOQb5Ye
 l0iqRi85G0Bj/SGS5dhHKBL01hdZR21g/BFyHPJnQjXzZwzybn9RxTPsAJOPw9D+GojA
 NpB8Cy3l4kSGje3mzbE33xwWHqTGlses0DVGQXBX27uwSAA8vK6ewWe4zGRr5kl0Mq7Z
 Qj6DYjxtbL2wYjsMP+a+b4Yt7G1zLAghMQAzWEJ18gM5ahDia8rOBc1ZDRFB4NQdwglg
 wuFE6FrKqdBIT1qii19lYD1k+x057Ho+GMOO5toi90p08tND78eRu3n649vhOg+f+CLn VA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtpdg0cs4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 18:32:09 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36DHQA1A016652;
 Thu, 13 Jul 2023 18:31:51 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
 by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3rpye6r34u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 18:31:51 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36DIVnt635324454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jul 2023 18:31:50 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A75F35804B;
 Thu, 13 Jul 2023 18:31:49 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54AE758063;
 Thu, 13 Jul 2023 18:31:49 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jul 2023 18:31:49 +0000 (GMT)
Message-ID: <c5e0fa79-83fc-8afd-9cc4-8f0e1094e689@linux.ibm.com>
Date: Thu, 13 Jul 2023 14:31:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 09/11] tpm_tis_sysbus: fix crash when PPI is enabled
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-10-j@getutm.app>
 <78bd19ff-709e-d152-ffe0-5d50ecb693c5@linux.ibm.com>
 <CA+E+eSC0M2CnOyX_EpF=FZX5yeKBsj=vh6+9T_sNV-NtGLs20A@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CA+E+eSC0M2CnOyX_EpF=FZX5yeKBsj=vh6+9T_sNV-NtGLs20A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jRBWQsyFlHAejYrkA9Fbp9NEWq6GhMQ1
X-Proofpoint-GUID: jRBWQsyFlHAejYrkA9Fbp9NEWq6GhMQ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_07,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307130165
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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



On 7/13/23 14:15, Joelle van Dyne wrote:
> On Thu, Jul 13, 2023 at 9:49 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>> The tpm-tis-device doesn't work for x86_64 but for aarch64.
>>
>>
>> We have this here in this file:
>>
>>       DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, false),
>>
>> I don't know whether ppi would work on aarch64. It needs firmware support like in edk2.
>> I think the best solution is to remove this DEFINE_PROP_BOOL() and if someone wants
>> to enable it they would have to add firmware support and test it before re-enabling it.
>>
>>      Stefan
>>
>>>    static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
> 
> Yeah, I'm not sure if PPI works with AARCH64 since I didn't bother to
> change it to not use hard coded addresses. However, isn't that "ppi"
> overridable from the command line? If so, should we add a check in
> "realize" to error if PPI=true? Otherwise, it will just crash.

Once the option is removed via my patch (cc'ed you), then you get this once you pass ppi=on on the command line:

qemu-system-aarch64: -device tpm-tis-device,tpmdev=tpm0,ppi=on: Property 'tpm-tis-device.ppi' not found

This disables it for good.

    Stefan

