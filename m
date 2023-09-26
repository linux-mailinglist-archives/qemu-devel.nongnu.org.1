Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F047AF400
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 21:17:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlDYI-00063U-Ni; Tue, 26 Sep 2023 15:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlDY8-00061U-RI
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:16:50 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlDY3-00081j-0O
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:16:47 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5429:0:640:6285:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id C745E60357;
 Tue, 26 Sep 2023 22:16:36 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b41d::1:39] (unknown
 [2a02:6b8:b081:b41d::1:39])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ZGV2Uq0OiKo0-cAQVgZP4; Tue, 26 Sep 2023 22:16:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695755796;
 bh=8NxUciVZJDMa9AOWA6249riph1WEwM0QhFSK1mlI76s=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=yOh9M8DiLiIU2Dsw27DUs+9ZCcSMvCBYdUboTq6WBZk8NP+5rRF8vwunXn2xFpny1
 gpjebCnrchT3QOF9b1oRuyEjMJkm/MTKtOVHT1yRNbgpHOLomPOtWgA4wF14R7/3Vx
 q37gLevQkVwUEKXeaEuDzAf40S844KgOfD0WOPCQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ea2f78d0-09b5-4eeb-8ca2-1e02fff2b6ce@yandex-team.ru>
Date: Tue, 26 Sep 2023 22:16:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/12] hw/i386/intel_iommu: vtd_slpte_nonzero_rsvd():
 reduce magic numbers
Content-Language: en-US
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
 <CAFEAcA_5cBU_LNeqnXhztiZrgGm-8=0x7pz-12ny5=J_sgBWxA@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFEAcA_5cBU_LNeqnXhztiZrgGm-8=0x7pz-12ny5=J_sgBWxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 26.09.23 21:59, Peter Maydell wrote:
> On Tue, 26 Sept 2023 at 19:36, Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> On 26.09.23 13:37, Peter Maydell wrote:
>>> On Mon, 25 Sept 2023 at 20:41, Vladimir Sementsov-Ogievskiy
>>> <vsementsov@yandex-team.ru> wrote:
>>>>
>>>> Add a constant and clear assertion. The assertion also tells Coverity
>>>> that we are not going to overflow the array.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> ---
>>>>    hw/i386/intel_iommu.c | 11 ++++++++---
>>>>    1 file changed, 8 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>>> index c0ce896668..2233dbe13a 100644
>>>> --- a/hw/i386/intel_iommu.c
>>>> +++ b/hw/i386/intel_iommu.c
>>>> @@ -1028,12 +1028,17 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
>>>>     *     vtd_spte_rsvd 4k pages
>>>>     *     vtd_spte_rsvd_large large pages
>>>>     */
>>>> -static uint64_t vtd_spte_rsvd[5];
>>>> -static uint64_t vtd_spte_rsvd_large[5];
>>>> +#define VTD_SPTE_RSVD_LEN 5
>>>> +static uint64_t vtd_spte_rsvd[VTD_SPTE_RSVD_LEN];
>>>> +static uint64_t vtd_spte_rsvd_large[VTD_SPTE_RSVD_LEN];
>>>>
>>>>    static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, uint32_t level)
>>>>    {
>>>> -    uint64_t rsvd_mask = vtd_spte_rsvd[level];
>>>> +    uint64_t rsvd_mask;
>>>> +
>>>> +    assert(level < VTD_SPTE_RSVD_LEN);
>>>> +
>>>> +    rsvd_mask = vtd_spte_rsvd[level];
>>>
>>>
>>> Looking at the code it is not clear to me why this assertion is
>>> valid. It looks like we are picking up fields from guest-set
>>> configuration (probably in-memory data structures). So we can't
>>> assert() here -- we need to do whatever the real hardware does
>>> if these fields are set to an incorrect value, or at least something
>>> sensible that doesn't crash QEMU.
>>>
>>
>> Finally, seems that assertion is valid. We do check the guest-set configuration:
>>
>> 1. in vtd_decide_config(), we check that s->aw_bits is exactly one of VTD_HOST_AW_39BIT or VTD_HOST_AW_48BIT.
>>
>> 2. in vtd_init(), in s->cap we set VTD_CAP_SAGAW_39bit (bit 1) and may be VTD_CAP_SAGAW_48bit (bit 2),  but never bit 3 (which would allow 5-level page-table) or any other bit (i.e. bits 0 and 4 which are reserved).
>>
>> 3. then, as I could follow, both context entry and pasid entry should go through vtd_is_level_supported(), which checks that level is allowed in s->cap.
>>
>> So in the code we should work only with levels 3 and 4.
> 
> Thanks for working through that. I'm not completely sure if we always
> do the level validity check (eg in vtd_dev_to_context_entry() we skip
> it if s->root_scalable is true),

when root_scalable is true, level comes from pasid entry, see vtd_get_iova_level():

   static uint32_t vtd_get_iova_level(IntelIOMMUState *s,
                                      VTDContextEntry *ce,
                                      uint32_t pasid)
   {
       VTDPASIDEntry pe;
                                                                                    
       if (s->root_scalable) {
           vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
           return VTD_PE_GET_LEVEL(&pe);
       }
                                                                                    
       return vtd_ce_get_level(ce);
   }


and in case of root_scalable=true, in vtd_dev_to_context_entry(), we do check it by vtd_ce_rid2pasid_check() -> .... -> vtd_get_pe_in_pasid_leaf_table() -> vtd_is_level_supported()


[but yes, I'm not sure that we correctly check it on _all_ the paths]


> but clearly the intention of the code
> is to validate the level early. So asserting in this function is fine,
> and if the assert ever fires we know we got the validity check wrong
> earlier.
> 
> A comment something like
> 
>    /*
>     * We should have caught a guest-mis-programmed level earlier,
>     * via vtd_is_level_supported
>     */
> 
> might help somebody in future if the assert ever does fire.
> 
> Could you also add "CID: 1487158, 1487186" to the commit message?
> I've just noticed this issue is in our online coverity scan db too
> as unresolved.

OK, thanks for checking this.

> 
> With those changes,
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 

Thanks!

-- 
Best regards,
Vladimir


