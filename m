Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 449AB71EEFB
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:29:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kKM-0000T4-Bz; Thu, 01 Jun 2023 11:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q4kKK-0000So-Ir; Thu, 01 Jun 2023 11:35:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q4kKI-0005YB-Ec; Thu, 01 Jun 2023 11:35:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 351Diejn030577; Thu, 1 Jun 2023 15:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dP2yCYfZTWKvm1u+7cKL+GUxKE9xgpUfPlYUweLFwWw=;
 b=j4R3lAz/8ACBOuO2OCjMHAT4em3v93cGXG2FTz2n0xln9GZD3I0uxXEn6MdbsvC3atDZ
 yaoL8Mr+IM3aGB5VefQ0KmefGA6q8sI36mV+V7ckX93Pudy/jdTDvF8LGcvhhjTb24CS
 ok7b6HX+g5uVlyry2zti3MaQvkzu10of4oDjFKeGYKQb46/6QpPP8vcchmB25aYXkIlq
 f690tnxI2kcXWTCBc2KUZCguTZNUFBx4UGVbXzYhtHFrLfWltTIgNaNubGTEYC6w/+oM
 a9MAmKu6LYCUKyRX6iOn4sObvlC8E7yaHl8jjzIzpOcKeKOPLoVQhojE1vI53xqfkSgQ NA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxpt71av6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 15:34:48 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351FYl26016068
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 1 Jun 2023 15:34:47 GMT
Received: from [10.111.129.99] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 08:34:45 -0700
Message-ID: <11f8fb60-abe7-d99d-c3bb-aaa405425668@quicinc.com>
Date: Thu, 1 Jun 2023 17:34:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] hvf: Handle EC_INSNABORT
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu
 <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>, Mark Burton
 <quic_mburton@quicinc.com>, Alexander Graf <agraf@csgraf.de>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20230601143312.69691-1-quic_acaggian@quicinc.com>
 <CAFEAcA-92-zExcOFMwaNYvP5pXLTUETsYi3mpuvTp2txfVEp9Q@mail.gmail.com>
From: Antonio Caggiano <quic_acaggian@quicinc.com>
In-Reply-To: <CAFEAcA-92-zExcOFMwaNYvP5pXLTUETsYi3mpuvTp2txfVEp9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: lGE5gVR9B_GkNg0eQDKN1mFfKGypIrFt
X-Proofpoint-GUID: lGE5gVR9B_GkNg0eQDKN1mFfKGypIrFt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 mlxlogscore=735 priorityscore=1501 phishscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010136
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Peter,

On 01/06/2023 16:58, Peter Maydell wrote:
> On Thu, 1 Jun 2023 at 15:33, Antonio Caggiano <quic_acaggian@quicinc.com> wrote:
>>
>> Instead of aborting immediately, try reading the physical address where
>> the instruction should be fetched by calling address_space_read. This
>> would give any memory regions ops callback a chance to allocate and/or
>> register an RAM/Alias memory region needed for resolving that physical
>> address. Then, if the memory transaction is OK, retry HVF execution at
>> the same PC.
> 
> What are the circumstances where this happens?
> Do we try to support this on KVM ?

We use qemu as a library and manage memory regions externally, 
allocating them on demand when there is a read or a write (through 
memory region ops callbacks).

When enabling HVF, we hit an instruction abort on the very first 
instruction as there is no memory region alias for it yet in system memory.

> 
>> Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
>> Co-authored-by: Mark Burton <quic_mburton@quicinc.com>
>> ---
>>   target/arm/hvf/hvf.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index ad65603445..6e527254b1 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -1446,6 +1446,18 @@ int hvf_vcpu_exec(CPUState *cpu)
>>               hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
>>           }
>>           break;
>> +    case EC_INSNABORT: {
>> +        uint32_t sas = (syndrome >> 22) & 3;
>> +        uint32_t len = 1 << sas;
>> +        uint64_t val = 0;
>> +
>> +        MemTxResult res = address_space_read(
>> +            &address_space_memory, hvf_exit->exception.physical_address,
>> +            MEMTXATTRS_UNSPECIFIED, &val, len);
>> +        assert(res == MEMTX_OK);
> 
> You can't assert() this, it might not be true, especially if
> we're here because hvf couldn't read from this address.

The idea is to try reading so that memory region ops can create the 
Alias MR required, in which case it would return MEMTX_OK. In case of 
error, maybe we can just exit and report the error like the default case.

> 
>> +        flush_cpu_state(cpu);
>> +        break;
>> +    }
>>       default:
>>           cpu_synchronize_state(cpu);
>>           trace_hvf_exit(syndrome, ec, env->pc);
> 
> thanks
> -- PMM

Cheers,
Antonio

