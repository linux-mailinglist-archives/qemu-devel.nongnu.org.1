Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 712C373E2C9
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:06:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDnmK-0003Jw-A7; Mon, 26 Jun 2023 11:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qDnmI-0003I0-2l
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:05:18 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qDnmG-0004FL-5N
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:Reply-To:MIME-Version:Date:Message-ID:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ioN8bPOZdbS8oYst2XqiZcCud6wwWAqUaRrNNSb/6nw=; b=VyTOBAhB0d0M5YFgwafH9/pd7f
 DSLaybd/68GU3HICGquwIOP15RR9gdf0e3DOUpGogbzOc2aeTmVlbhUABWR5mQqeQW6+e7wadlWBv
 MGDPP2Zyja0fa9s7VUXRa2JH7YC/W+ODUULc8irSk/m1frlDr1YxRAApoOOPxTRSDGUw=;
Message-ID: <031ec8fa-4c1d-f3a0-45d5-77d3cbc126c5@rev.ng>
Date: Mon, 26 Jun 2023 17:04:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 11/12] accel/tcg: Replace target_ulong with vaddr in
 page_*()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, eduardo@habkost.net, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com
References: <20230621135633.1649-1-anjo@rev.ng>
 <20230621135633.1649-12-anjo@rev.ng>
 <98f4a7b1-bd4b-7975-cf39-8c5a10df5150@linaro.org>
Content-Language: en-US
Organization: rev.ng
In-Reply-To: <98f4a7b1-bd4b-7975-cf39-8c5a10df5150@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 6/26/23 15:59, Richard Henderson wrote:
> On 6/21/23 15:56, Anton Johansson via wrote:
>> Use vaddr for guest virtual addresses for functions dealing with page
>> flags.
>>
>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   accel/tcg/user-exec.c        | 44 +++++++++++++++++-------------------
>>   include/exec/cpu-all.h       | 10 ++++----
>>   include/exec/translate-all.h |  2 +-
>>   3 files changed, 27 insertions(+), 29 deletions(-)
>
> This causes other failures, such as
>
> https://gitlab.com/rth7680/qemu/-/jobs/4540151776#L4468
>
> qemu-hppa: ../accel/tcg/user-exec.c:490: page_set_flags: Assertion 
> `last <= GUEST_ADDR_MAX' failed.
>
> which is caused by
>
> #8  0x00005555556e5b77 in do_shmat (cpu_env=cpu_env@entry=0x555556274378,
>     shmid=54, shmaddr=<optimized out>, shmflg=0)
>     at ../src/linux-user/syscall.c:4598
>
> 4598        page_set_flags(raddr, raddr + shm_info.shm_segsz - 1,
> 4599                       PAGE_VALID | PAGE_RESET | PAGE_READ |
> 4600                       (shmflg & SHM_RDONLY ? 0 : PAGE_WRITE));
>
> The host shm_info.shm_segsz is uint64_t, which means that the whole 
> expression gets converted to uint64_t.  With this patch, it is not 
> properly truncated to a guest address.
>
> In this particular case, raddr is signed (abi_long), which is a 
> mistake.  Fixing that avoids this particular error.
>
> But since user-only is outside of the scope of this work, I'm going to 
> drop this patch for now.
>
>
> r~
My bad! I saw the CI failure post-rebase but didn't look closely enough, 
I saw a build-user failure in the branch I was based on
and assumed they were related.

Thanks for the explanation, makes sense!:)

-- 
Anton Johansson,
rev.ng Labs Srl.


