Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5493A7916DD
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:09:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8Kz-00023F-0l; Mon, 04 Sep 2023 08:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1qd8Kv-0001ur-Lm; Mon, 04 Sep 2023 08:05:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1qd8Kt-0003eK-37; Mon, 04 Sep 2023 08:05:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 48BAA1F38C;
 Mon,  4 Sep 2023 12:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693829140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGJUU8gdlJybZdYkpSEXd58MdQ8uDH1Q2xZeNXeFrGo=;
 b=W1jxotF1ycwULr6IPPx8xQfaa2/LCFY9dGRXxPPjGCkIuJ9Gjz6vx4pv0PFE//66SnZ8dh
 VZ8enF96RAfvbMEmpKgH7aPUyteZS8eN0yyFMEi08sLSIeV0pT2AAnwS9BMnVt8bGT90bh
 t1773TgL/L6rr9hdjAR/PhdbgNc2990=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693829140;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGJUU8gdlJybZdYkpSEXd58MdQ8uDH1Q2xZeNXeFrGo=;
 b=w9qH7ap3igwA8BgpKla8tS277AQ8hFQro2OtYZMHYM7SKYFIVJTMeBDA8Wb8hqrdimzd1p
 0a2LhsMWRCKtQWDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF88613425;
 Mon,  4 Sep 2023 12:05:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kbHGOBPI9WTqXAAAMHmgww
 (envelope-from <cfontana@suse.de>); Mon, 04 Sep 2023 12:05:39 +0000
Message-ID: <b05c5619-4f88-0aae-9162-ea90188d5b9c@suse.de>
Date: Mon, 4 Sep 2023 14:05:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] arm64: Restore trapless ptimer access
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Colton Lewis <coltonlewis@google.com>,
 Andrew Jones <andrew.jones@linux.dev>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 qemu-trivial@nongnu.org, Marc Zyngier <maz@kernel.org>
References: <20230831190052.129045-1-coltonlewis@google.com>
 <20230901-16232ff17690fc32a0feb5df@orel> <ZPI6KNqGGTxxHhCh@google.com>
 <cfee780b-27ab-8a49-9d42-72fd2a425a17@suse.de>
 <20230904-2587500eb2b77ed6c92143e2@orel>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20230904-2587500eb2b77ed6c92143e2@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=cfontana@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 9/4/23 13:07, Andrew Jones wrote:
> On Mon, Sep 04, 2023 at 10:18:05AM +0200, Claudio Fontana wrote:
>> Hi,
>>
>> I think this discussion from ~2015 could potentially be be historically relevant for context,
>> at the time we had the problem with CNTVOFF IIRC so KVM_REG_ARM_TIMER_CNT being read and rewritten causing time warps in the guest:
>>
>> https://patchwork.kernel.org/project/linux-arm-kernel/patch/1435157697-28579-1-git-send-email-marc.zyngier@arm.com/
>>
>> I could not remember or find if/where the problem was fixed in the end in QEMU,
> 
> It's most likely commit 4b7a6bf402bd ("target-arm: kvm: Differentiate
> registers based on write-back levels")

Indeed, thanks!

C

> Thanks,
> drew
> 
>>
>> Ciao,
>>
>> Claudio
>>
>> On 9/1/23 21:23, Colton Lewis wrote:
>>> On Fri, Sep 01, 2023 at 09:35:47AM +0200, Andrew Jones wrote:
>>>> On Thu, Aug 31, 2023 at 07:00:52PM +0000, Colton Lewis wrote:
>>>>> Due to recent KVM changes, QEMU is setting a ptimer offset resulting
>>>>> in unintended trap and emulate access and a consequent performance
>>>>> hit. Filter out the PTIMER_CNT register to restore trapless ptimer
>>>>> access.
>>>>>
>>>>> Quoting Andrew Jones:
>>>>>
>>>>> Simply reading the CNT register and writing back the same value is
>>>>> enough to set an offset, since the timer will have certainly moved
>>>>> past whatever value was read by the time it's written.  QEMU
>>>>> frequently saves and restores all registers in the get-reg-list array,
>>>>> unless they've been explicitly filtered out (with Linux commit
>>>>> 680232a94c12, KVM_REG_ARM_PTIMER_CNT is now in the array). So, to
>>>>> restore trapless ptimer accesses, we need a QEMU patch to filter out
>>>>> the register.
>>>>>
>>>>> See
>>>>> https://lore.kernel.org/kvmarm/gsntttsonus5.fsf@coltonlewis-kvm.c.googlers.com/T/#m0770023762a821db2a3f0dd0a7dc6aa54e0d0da9
>>>>
>>>> The link can be shorter with
>>>>
>>>> https://lore.kernel.org/all/20230823200408.1214332-1-coltonlewis@google.com/
>>>
>>> I will keep that in mind next time.
>>>
>>>>> for additional context.
>>>>>
>>>>> Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
>>>>
>>>> Thanks for the testing and posting, Colton. Please add your s-o-b and a
>>>> Tested-by tag as well.
>>>
>>> Assuming it is sufficient to add here instead of reposting the whole patch:
>>>
>>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>>> Tested-by: Colton Lewis <coltonlewis@google.com>
>>>
>>>>> ---
>>>>>  target/arm/kvm64.c | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
>>>>> index 4d904a1d11..2dd46e0a99 100644
>>>>> --- a/target/arm/kvm64.c
>>>>> +++ b/target/arm/kvm64.c
>>>>> @@ -672,6 +672,7 @@ typedef struct CPRegStateLevel {
>>>>>   */
>>>>>  static const CPRegStateLevel non_runtime_cpregs[] = {
>>>>>      { KVM_REG_ARM_TIMER_CNT, KVM_PUT_FULL_STATE },
>>>>> +    { KVM_REG_ARM_PTIMER_CNT, KVM_PUT_FULL_STATE },
>>>>>  };
>>>>>
>>>>>  int kvm_arm_cpreg_level(uint64_t regidx)
>>>>> --
>>>>> 2.42.0.283.g2d96d420d3-goog
>>>>>
>>>
>>


