Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D370E7D4FCC
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 14:32:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvGZk-0001v4-Au; Tue, 24 Oct 2023 08:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1qvGZf-0001sh-3Z
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 08:31:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1qvGZY-0007ha-5j
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 08:31:54 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OCLZDW030457; Tue, 24 Oct 2023 12:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fu0mJiFi7VOz0IwZtbmJ6mJdJvFY7KEw0OBg1L2K70M=;
 b=RsCS9tsXKpwzZl2BsCVDpw/MHWzAaWSerK/B0ZzFyx/PVTnXVlrhDm4x/+yEbQRGUmCS
 8wOnXkOemLfINnnUNCAew+q4ofL/B//RKciQWNN2qY1sdS0B6ABXpoh/c+skMNPr+dvx
 ZtnHzRN9b+BuuU9X/43tFAfDl+u//tazNHOKoLiTT4p/LL9YVjBPZWgPz8Mscxo7NclX
 sUX4HJqRpWWgjqXkyp9AJpvJWvdBiSggGZ1AH2GFpBGGqemwYa8v9FD5WCkuZ5wv9s+k
 kd308AR9jLCoBxveBnsxMVokQosJZcvhLlWH2X0KwEhhmbBG793zRIne5wrzhI8aOGYv 8w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3twx9u9p4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 12:31:45 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39OCVi4P027496
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Oct 2023 12:31:44 GMT
Received: from [10.251.42.180] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 24 Oct
 2023 05:31:43 -0700
Message-ID: <e2c97f1f-6dca-fe27-debc-19a3f6dcac8a@quicinc.com>
Date: Tue, 24 Oct 2023 14:31:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mem: Fix mem region size when is UINT64_MAX
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231024094351.50464-1-quic_acaggian@quicinc.com>
 <CAFEAcA86trVBDe4zJr2Zv-EgWReY2M+yvU83Kc_8nGrjP4_tJg@mail.gmail.com>
 <aaafba0f-d6dc-a280-263c-afcc6b8f7e2b@quicinc.com>
 <CAFEAcA-gi3Up=7N-Y5-RyA0bi+4UHcE=MOryhWZ2rWQk67CrjQ@mail.gmail.com>
From: Antonio Caggiano <quic_acaggian@quicinc.com>
In-Reply-To: <CAFEAcA-gi3Up=7N-Y5-RyA0bi+4UHcE=MOryhWZ2rWQk67CrjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: ZiMKlx_p5cZqjBufrPlF0cpEP_9-tHXH
X-Proofpoint-ORIG-GUID: ZiMKlx_p5cZqjBufrPlF0cpEP_9-tHXH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_11,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240106
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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



On 24/10/2023 14:00, Peter Maydell wrote:
> On Tue, 24 Oct 2023 at 11:49, Antonio Caggiano
> <quic_acaggian@quicinc.com> wrote:
>>
>> Hi Peter,
>>
>> Thanks for the quick response.
>>
>> On 24/10/2023 12:28, Peter Maydell wrote:
>>> On Tue, 24 Oct 2023 at 10:45, Antonio Caggiano
>>> <quic_acaggian@quicinc.com> wrote:
>>>>
>>>> This looks like a bug. When the size is `UINT64_MAX`, it is reset to
>>>> (Int128)`1 << 64` which actually is `UINT64_MAX + 1`.
>>>>
>>>> Then, an assert is triggered when the size is converted back to uin64_t
>>>> by using the int128_get64() function, as the new value happens to be
>>>> different than the previous one.
>>>>
>>>> Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
>>>> ---
>>>>    system/memory.c | 3 ---
>>>>    1 file changed, 3 deletions(-)
>>>>
>>>> diff --git a/system/memory.c b/system/memory.c
>>>> index a800fbc9e5..d41fc6af88 100644
>>>> --- a/system/memory.c
>>>> +++ b/system/memory.c
>>>> @@ -1193,9 +1193,6 @@ static void memory_region_do_init(MemoryRegion *mr,
>>>>                                      uint64_t size)
>>>>    {
>>>>        mr->size = int128_make64(size);
>>>> -    if (size == UINT64_MAX) {
>>>> -        mr->size = int128_2_64();
>>>> -    }
>>>
>>> No, this is intentional. In these memory region creation APIs
>>> that take a uint64_t size parameter, size == UINT64_MAX is a
>>> special case that means "actually the full 64 bit address space"
>>> (and there is no way to ask for an MR to have a size that is
>>> truly UINT64_MAX bytes). When we create the MR, the size is
>>> stored in the MemoryRegion struct as its true size, because
>>> we have an Int128 field there.
>>>
>>> What assertion (with backtrace) is being hit? The issue is
>>> probably at that point, not here.
>>
>> Here you can. I'm basically creating a system_memory of size UINT64_MAX,
>> and the assert is being hit when the memory is registered to KVM.
> 
> (I've cc'd Paolo to check my understanding of how KVM works.)
> 
>> #5  0x0000fffff6fc4040 in __GI___assert_fail (assertion=0xffffe111d9c8
>> "r == a", file=0xffffe111d960 "qemu/include/qemu/int128.h", line=34,
>> function=0xffffe111f348 <__PRETTY_FUNCTION__.46> "int128_get64") at
>> ./assert/assert.c:101
>> #6  0x0000ffffe0c8cf6c in int128_get64 (a=18446744073709551616) at
>> qemu/include/qemu/int128.h:34
>> #7  0x0000ffffe0c92cec in kvm_region_commit (listener=0xffffd83e92e0) at
>> qemu/accel/kvm/kvm-all.c:1503
>> #8  0x0000ffffe0bd495c in memory_region_transaction_commit () at
>> qemu/softmmu/memory.c:1109
>> #9  0x0000ffffe0bd8a90 in memory_region_update_container_subregions
>> (subregion=0xaaaaabb6abf0) at qemu/softmmu/memory.c:2606
>> #10 0x0000ffffe0bd8b3c in memory_region_add_subregion_common
>> (mr=0xaaaaabb6ae10, offset=0, subregion=0xaaaaabb6abf0) at
>> qemu/softmmu/memory.c:2621
>> #11 0x0000ffffe0bd8b74 in memory_region_add_subregion
>> (mr=0xaaaaabb6ae10, offset=0, subregion=0xaaaaabb6abf0) at
>> qemu/softmmu/memory.c:2629
>> #12 0x0000ffffe05d5508 in gpex_host_realize (dev=0xaaaaabb69910,
>> errp=0xffffdd4ce1f0) at qemu/hw/pci-host/gpex.c:132
> 
> Thanks. It looks like KVM basically doesn't expect to be working
> with a memory region that large -- the KVM kernel APIs for
> registering memslots etc take a uint64_t size, so there's no way
> to say "all of the 64 bit address space". Probably the best
> available improvement would be if we added an assert at the point
> when the memory region initially gets set up with KVM to say
> "this is too big".
> 
> Given that we don't run into this upstream, this leaves me
> suspecting that the underlying problem is that a memory
> region this big shouldn't be being registered to KVM in the
> first place. Certainly the gpex PCI controller works fine
> on the arm64 virt board under KVM, so maybe your board code
> is doing something odd when it wires it up?
> 

I think so, we use a MMIO system_memory, effectively using 
memory_region_init_io() instead of memory_region_init(). This is for 
registering our callbacks with a MemoryRegionOps.

So, for a MMIO memory type, UINT64_MAX means "real" size rather than 
"all of the 64 bit address space"?

> thanks
> -- PMM

Cheers,
Antonio

