Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AD67AF33F
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 20:47:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlD5R-0004f8-Lv; Tue, 26 Sep 2023 14:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlD5P-0004ej-7V
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 14:47:07 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlD5L-0008VZ-Qs
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 14:47:06 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 12D7960B4D;
 Tue, 26 Sep 2023 21:47:00 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b41d::1:39] (unknown
 [2a02:6b8:b081:b41d::1:39])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id xkUFwq0Oj8c0-2Y1V8lsA; Tue, 26 Sep 2023 21:46:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695754019;
 bh=AlOoxvJpF0ZKULRYjHmq7mrMq41vyi/rHEHYCadLcmY=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=JpLS3m1dlBFCcpWbktEAK4sVV8Ia6CTok8mxOJ8+ESGunwAWZRrCVs3eP08sQcyMU
 iV0fjTbvGHrfr+MxujH8mAARNqo93+POyng+wEGq0oRKwDeT8Z2bthU0l4sci1peGv
 pWzpvbzT8S9Ocv7BC1HWDpHf9UJh/5usponwcrAE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3e5db346-2407-0379-0969-a099c3c4bc42@yandex-team.ru>
Date: Tue, 26 Sep 2023 21:46:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/12] hw/i386/intel_iommu: vtd_slpte_nonzero_rsvd():
 reduce magic numbers
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-3-vsementsov@yandex-team.ru>
 <CAFEAcA_jgL_CLQxT1R2Zu5xDd3RZZpySpjhd1EyBgFM8Ttps6w@mail.gmail.com>
 <a39b4d16-3055-8718-0f84-ebbdd1078758@yandex-team.ru>
In-Reply-To: <a39b4d16-3055-8718-0f84-ebbdd1078758@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 26.09.23 21:36, Vladimir Sementsov-Ogievskiy wrote:
> On 26.09.23 13:37, Peter Maydell wrote:
>> On Mon, 25 Sept 2023 at 20:41, Vladimir Sementsov-Ogievskiy
>> <vsementsov@yandex-team.ru> wrote:
>>>
>>> Add a constant and clear assertion. The assertion also tells Coverity
>>> that we are not going to overflow the array.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> ---
>>>   hw/i386/intel_iommu.c | 11 ++++++++---
>>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index c0ce896668..2233dbe13a 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -1028,12 +1028,17 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
>>>    *     vtd_spte_rsvd 4k pages
>>>    *     vtd_spte_rsvd_large large pages
>>>    */
>>> -static uint64_t vtd_spte_rsvd[5];
>>> -static uint64_t vtd_spte_rsvd_large[5];
>>> +#define VTD_SPTE_RSVD_LEN 5
>>> +static uint64_t vtd_spte_rsvd[VTD_SPTE_RSVD_LEN];
>>> +static uint64_t vtd_spte_rsvd_large[VTD_SPTE_RSVD_LEN];
>>>
>>>   static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, uint32_t level)
>>>   {
>>> -    uint64_t rsvd_mask = vtd_spte_rsvd[level];
>>> +    uint64_t rsvd_mask;
>>> +
>>> +    assert(level < VTD_SPTE_RSVD_LEN);
>>> +
>>> +    rsvd_mask = vtd_spte_rsvd[level];
>>
>>
>> Looking at the code it is not clear to me why this assertion is
>> valid. It looks like we are picking up fields from guest-set
>> configuration (probably in-memory data structures). So we can't
>> assert() here -- we need to do whatever the real hardware does
>> if these fields are set to an incorrect value, or at least something
>> sensible that doesn't crash QEMU.
>>
> 
> Finally, seems that assertion is valid. We do check the guest-set configuration:
> 
> 1. in vtd_decide_config(), we check that s->aw_bits is exactly one of VTD_HOST_AW_39BIT or VTD_HOST_AW_48BIT.
> 
> 2. in vtd_init(), in s->cap we set VTD_CAP_SAGAW_39bit (bit 1) and may be VTD_CAP_SAGAW_48bit (bit 2),  but never bit 3 (which would allow 5-level page-table) or any other bit (i.e. bits 0 and 4 which are reserved).
> 
> 3. then, as I could follow, both context entry and pasid entry should go through vtd_is_level_supported(), which checks that level is allowed in s->cap.
> 
> So in the code we should work only with levels 3 and 4.
> 

(i.e. maximum levels, of course we have page-tables of levels 1..3 and 1..4 correspondingly)


-- 
Best regards,
Vladimir


