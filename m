Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7DD830086
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 08:30:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ0NR-0008F6-8F; Wed, 17 Jan 2024 02:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rQ0N8-0008A2-Oy
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:30:03 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rQ0N6-00068L-6I
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:30:02 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso7643019a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 23:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1705476599; x=1706081399;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0qGlZHZxQIATNU7Sk4X3qYO4Gfi0nxDrj7suaX3rzdE=;
 b=he3R7jOHtLd/6Olj/CyAbiNOqOM4SAsWsyg/kk5L+aAapbDDjli4Y6AqYYqsDwz2Xc
 VYFLWOxZ+HxjfUsvNho6pwQ0INJ0ZdJgeo4n2mup556+Hz2N8qMj47b2aP7HogMPMuIy
 teDsj5Qjh5YYrCNUYutHn7dHFvjqsaFeOH6X5KJmdW00TK6rSdwQCeKRQpINyZTBic0S
 7fFXtmQND5YDeIm3RE2hzNH9zDv08Z2NNpSO3F45G/sj/DmQ1tpywI0CVcAuvTeuxx0A
 GeBIx4wOX9BDa65M5og2uCOAQ6rfn6gUqXoUNO4fDO/I6g/fXddPIA5Bj/Fg0vW6FBbz
 3vqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705476599; x=1706081399;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0qGlZHZxQIATNU7Sk4X3qYO4Gfi0nxDrj7suaX3rzdE=;
 b=T42Zlu5AWSieqIYprgCjuuCIseauIP6h9BhWoRjc4nODxFJyxmyI+78JpT+XTFZWhu
 TqOaUx/2SQ1nxg6j0J7H95zVQAWlTG6xxKF2uwpjw1eVXDTc0B5IuDfgrAAfvV44od6Q
 Bitm/EO4OkHlATl9i+9W/5ThIxH0Khq6zW2+V/7AvwPF723+AA8QqIHSN5BdK/FYt3kx
 fNlySQikaTBTLfJypLpFRrwnmfHRFEs8QZu8HfdKf1Muzt1Kxeqjq5HDZQfTYtCp4ZFL
 cGAumZx9VBzMn0OgYJmZbnV7c0xruvvU4IXs0NXdffXWk9DlVDk/pdDpRJeaigoWM/ug
 dq/Q==
X-Gm-Message-State: AOJu0Yyp045JAyo8H1dC38rzeeKhvcrcr49OHEnMDaeHTVKB4CJL5HSe
 +Q9Q54tydceRGK6Na74izZ2+iZ5mT1PIJQ==
X-Google-Smtp-Source: AGHT+IGYfqIxrJVhmdvRTUZs9nS4380rwTjOydxDj8zc7YkEf+sNU7Dy1VYObIJfojoe9D8Kqt/aAw==
X-Received: by 2002:a05:6a20:e68a:b0:19a:eaff:bf73 with SMTP id
 mz10-20020a056a20e68a00b0019aeaffbf73mr5125188pzb.45.1705476598939; 
 Tue, 16 Jan 2024 23:29:58 -0800 (PST)
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a170902684400b001d4f119de21sm10626473pln.112.2024.01.16.23.29.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 23:29:58 -0800 (PST)
Message-ID: <19b4a49a-6bb9-4158-935a-f40f1de6f392@daynix.com>
Date: Wed, 17 Jan 2024 16:29:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coroutine-ucontext: Save fake stack for pooled coroutine
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Lingfeng Yang <lfy@google.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
References: <20240112-asan-v1-1-e330f0d0032c@daynix.com>
 <20240115184739.GB1143584@fedora>
 <CAJ+F1C+E+xXKe7eC6+KbDBZ7HHkdmuQ9sZPjk=meZLVk4Ekxbw@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAJ+F1C+E+xXKe7eC6+KbDBZ7HHkdmuQ9sZPjk=meZLVk4Ekxbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/01/16 17:42, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Jan 15, 2024 at 10:49 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>
>> On Fri, Jan 12, 2024 at 07:36:19PM +0900, Akihiko Odaki wrote:
>>> Coroutine may be pooled even after COROUTINE_TERMINATE if
>>> CONFIG_COROUTINE_POOL is enabled and fake stack should be saved in
>>> such a case to keep AddressSanitizerUseAfterReturn working. Even worse,
>>> I'm seeing stack corruption without fake stack being saved.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Thanks Akihiko, this is solving a crash when enabling ASAN!
> 
>>> ---
>>>   util/coroutine-ucontext.c | 21 +++++++++++++++++++--
>>>   1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> Adding Marc-André Lureau and Lingfeng Yang, who authored the code in
>> question.
> 
> Side note:
> I am surprised that commit 0aebab04b9  "configure: add --enable-tsan
> flag + fiber annotations" changed code like this:
>   {
>   #ifdef CONFIG_ASAN
> -    __sanitizer_start_switch_fiber(fake_stack_save, bottom, size);
> +    __sanitizer_start_switch_fiber(
> +            action == COROUTINE_TERMINATE ? NULL : fake_stack_save,
> +            bottom, size);
> +#endif
> +#ifdef CONFIG_TSAN
> +    void *curr_fiber =
> +        __tsan_get_current_fiber();
> +    __tsan_acquire(curr_fiber);
> +
> +    *fake_stack_save = curr_fiber;
> +    __tsan_switch_to_fiber(new_fiber, 0);  /* 0=synchronize */
>   #endif
> 
> *fake_stack_save = curr_fiber:
> Is TSAN compatible with ASAN ? I guess not.

meson.build has the following:
if get_option('tsan')
   if get_option('sanitizers')
     error('TSAN is not supported with other sanitizers')
   endif

> 
> It would probably help to have more explicit comments & errors if such
> a case happens.

Added G_STATIC_ASSERT(!IS_ENABLED(CONFIG_TSAN)) in v2.

> 
>>
>> Stefan
>>
>>>
>>> diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
>>> index 7b304c79d942..e62ced5d6779 100644
>>> --- a/util/coroutine-ucontext.c
>>> +++ b/util/coroutine-ucontext.c
>>> @@ -124,8 +124,9 @@ void start_switch_fiber_asan(CoroutineAction action, void **fake_stack_save,
>>>   {
>>>   #ifdef CONFIG_ASAN
>>>       __sanitizer_start_switch_fiber(
>>> -            action == COROUTINE_TERMINATE ? NULL : fake_stack_save,
>>> -            bottom, size);
>>> +        !IS_ENABLED(CONFIG_COROUTINE_POOL) && action == COROUTINE_TERMINATE ?
>>> +            NULL : fake_stack_save,
>>> +        bottom, size);
> 
> 
> Ok, changing back the commit from Lingfeng when coroutine pools are enabled.
> 
>>>   #endif
>>>   }
>>>
>>> @@ -269,10 +270,26 @@ static inline void valgrind_stack_deregister(CoroutineUContext *co)
>>>   #endif
>>>   #endif
>>>
>>> +#if defined(CONFIG_ASAN) && defined(CONFIG_COROUTINE_POOL)
>>> +static void coroutine_fn terminate(void *opaque)
>>> +{
>>> +    CoroutineUContext *to = DO_UPCAST(CoroutineUContext, base, opaque);
>>> +
>>> +    __sanitizer_start_switch_fiber(NULL, to->stack, to->stack_size);
>>> +    siglongjmp(to->env, COROUTINE_ENTER);
>>> +}
> 
> looking at https://github.com/llvm/llvm-project/blob/main/compiler-rt/test/asan/TestCases/Linux/swapcontext_annotation.cpp,
> that seems correct to me to destroy the fake_stack.
> 
> However, not switching back with qemu_coroutine_switch() may create
> issues: set_current() (and tsan) not being called appropriately.

Thanks for catching this. Added missing set_current() call and 
G_STATIC_ASSERT(!IS_ENABLED(CONFIG_TSAN)) in v2 as I described earlier.

> 
> Should we introduce another action like COROUTINE_DELETE?

I don't think so. CoroutineAction is part of the common interface for 
coroutine backends. The need to switch back to the destroyed coroutine 
is a peculiarity unique to ucontext and better to be contained in 
coroutine-ucontext.c.

Alternatively we can add a bool parameter to qemu_coroutine_switch() to 
tell to destroy the fake stack, but probably it's not that worth to 
share qemu_coroutine_switch() code; while coroutine-ucontext.c already 
have a few places that call start_switch_fiber_asan() or siglongjmp() 
and they are somewhat similar, they are still too diverged to unify.

