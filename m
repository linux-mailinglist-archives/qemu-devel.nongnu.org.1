Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B15708429
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:45:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzerB-0002N8-KA; Thu, 18 May 2023 10:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1pzer5-0002Ml-F0
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:43:51 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1pzer2-0002gr-UL
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:43:47 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0d:3786:0:640:7c97:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 007395FE58;
 Thu, 18 May 2023 17:43:37 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7204::1:34] (unknown
 [2a02:6b8:b081:7204::1:34])
 by mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ZheUqa3MpmI0-b4ZPFrj8; Thu, 18 May 2023 17:43:36 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1684421016; bh=4/4AuHgAzPTm3TLt+h8FWKFKEq3c54TEGJcjL7aFU0k=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=fJX3rjxj75zJbg7Zqmfu3tsFkWeMFkM05InJ2Eiqxh3MILps7epnwJ+UZBQwpEVgH
 Ek/wRrHlbVvWh1+W42IYCd8QtNWcYq6KqyAIFjhnMQN660+WxVv2Qj6/UZ9jJ2BbTo
 yxwy4ERzxcwo1HfG64H12R92Tr6ted3QZNsjHUt4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <208b27c5-e81f-2185-39f0-70e16ade2448@yandex-team.ru>
Date: Thu, 18 May 2023 17:43:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/5] migration: never fail in global_state_store()
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, leobras@redhat.com,
 peterx@redhat.com, yc-core@yandex-team.ru
References: <20230517123752.21615-1-vsementsov@yandex-team.ru>
 <20230517123752.21615-3-vsementsov@yandex-team.ru>
 <87ilcpevlq.fsf@secure.mitica>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87ilcpevlq.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.544,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 18.05.23 14:18, Juan Quintela wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> wrote:
>> Actually global_state_store() can never fail. Let's get rid of extra
>> error paths.
>>
>> To make things clear, use new runstate_get() and use same approach for
>> global_state_store() and global_state_store_running().
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> I don't know.
> 
> On one hand, you have removed a lot of code that "can't" happen.
> 
> On the other:
> 
>> +static void global_state_do_store(RunState state)
>>   {
>> -    if (!runstate_store((char *)global_state.runstate,
>> -                        sizeof(global_state.runstate))) {
>> -        error_report("runstate name too big: %s", global_state.runstate);
>> -        trace_migrate_state_too_big();
>> -        return -EINVAL;
>> -    }
>> -    return 0;
>> +    const char *state_str = RunState_str(state);
>> +    assert(strlen(state_str) < sizeof(global_state.runstate));
> 
> First: g_assert() please.
> 
> Second: We try really hard not to fail during migration and get the
> whole qemu back.  One assert is bad.  Specially in a place like this
> one, where we know that nothing is broken, simpli that we can't migrate.
> 

On the other hand, having runstate longer than 100 characters means memory corruption, so aborting QEMU is best we can do

-- 
Best regards,
Vladimir


