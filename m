Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3478975423D
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 20:08:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKNC2-0000M0-P0; Fri, 14 Jul 2023 14:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKNC0-0000Lc-8A
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 14:07:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKNBy-0006K0-1l
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 14:07:00 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36EI6rqh003512; Fri, 14 Jul 2023 18:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uxKYaHE30CT2dDhE0rqCPtkxDpoGgtZ7NoDBlQWQ4YI=;
 b=djThbzw0nPzYWUQW8NRLTxSBKPXxKgPdxfprXgesOPU+DLk5d+URjRcmHLcT7W9fv0Qj
 0shAyQzR+aYKkmU0hjng2BULnG2A1TNEawvw0vx9f1lwNgIq0d3QurFnNGxatgLBeTx6
 ucE6XapZnDT51JJ8nWKnbp7xiBbqwQZCK3hp8NEFkAFC6tdkC8+l/BL45inopQXNAFo6
 VJugQh0Xdb8pSDErNmPTbRvzFnw5xhPWpmrqBTwmVua62ooPPfgymBnGQo0IvXXl71Os
 K5M6CMUqzR/1xCQXzM5sKmdSBDn3tp6q4qOwvKKXMM86eSRwPDCVB6NR6Zua2nt3QJZM pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rub56r6sy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 18:06:55 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36EI6sog003587;
 Fri, 14 Jul 2023 18:06:54 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rub56r6r0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 18:06:54 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36EGEphv008121;
 Fri, 14 Jul 2023 18:04:02 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
 by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3rtqkhvrra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 18:04:02 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36EI412k6750968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jul 2023 18:04:01 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0882758052;
 Fri, 14 Jul 2023 18:04:01 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9801158065;
 Fri, 14 Jul 2023 18:04:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jul 2023 18:04:00 +0000 (GMT)
Message-ID: <46a3c75d-66e1-fd96-efd1-a9e9bca1899f@linux.ibm.com>
Date: Fri, 14 Jul 2023 14:04:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL v1 1/1] hw/tpm: TIS on sysbus: Remove unsupport ppi command
 line option
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: peter.maydell@linaro.org, Eric Auger <eric.auger@redhat.com>,
 Joelle van Dyne <j@getutm.app>
References: <20230714154101.184057-1-stefanb@linux.ibm.com>
 <20230714154101.184057-2-stefanb@linux.ibm.com>
 <6697efa4-c76c-deaa-178f-1d7fccf08b04@linaro.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <6697efa4-c76c-deaa-178f-1d7fccf08b04@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 566tvFiEOmCAHAihaQoMa9iTmwgOJqcz
X-Proofpoint-GUID: 3JIvGNIi3-bcztBA_iqM91Lcklv2Vw2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 clxscore=1011 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140165
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
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



On 7/14/23 13:58, Philippe Mathieu-Daudé wrote:
> Hi Stefan,
> 
> On 14/7/23 17:41, Stefan Berger wrote:
>> The ppi command line option for the TIS device on sysbus never worked
>> and caused an immediate segfault. Remove support for it since it also
>> needs support in the firmware and needs testing inside the VM.
>>
>> Reproducer with the ppi=on option passed:
>>
>> qemu-system-aarch64 \
>>     -machine virt,gic-version=3 \
>>     -m 4G  \
>>     -nographic -no-acpi \
>>     -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
>>     -tpmdev emulator,id=tpm0,chardev=chrtpm \
>>     -device tpm-tis-device,tpmdev=tpm0,ppi=on
>> [...]
>> Segmentation fault (core dumped)
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Message-id: 20230713171955.149236-1-stefanb@linux.ibm.com
>> ---
>>   hw/tpm/tpm_tis_sysbus.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
>> index 45e63efd63..6724b3d4f6 100644
>> --- a/hw/tpm/tpm_tis_sysbus.c
>> +++ b/hw/tpm/tpm_tis_sysbus.c
>> @@ -93,7 +93,6 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
>>   static Property tpm_tis_sysbus_properties[] = {
>>       DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
>>       DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
>> -    DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, false),
> 
> Since properties are user-facing, shouldn't we deprecate their
> removal? I'm not sure so I ask :) Otherwise we could register
> the property with object_class_property_add_bool() and have
> the setter display a warning. Anyhow I suppose now setting
> "ppi" triggers some error, which is better than a abort.

ppi=on crashed it, now it doesn't crash it. On the next level, ppi=on may come with the expectation that ppi is working on aarch64 and I am not sure about this.

> 
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
> 

