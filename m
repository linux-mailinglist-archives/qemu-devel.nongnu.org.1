Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF22AA1B43
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Apr 2025 21:17:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9qQp-0001Pk-28; Tue, 29 Apr 2025 15:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9qQj-0001Kf-V8
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 15:15:46 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9qQh-0004PF-67
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 15:15:45 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso6168184b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 12:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745954141; x=1746558941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O4cRnsPeh5gIFGr2KVzjgJ2/bBJtdQUBi9Lvy5gmqYU=;
 b=ch6YKqPrR0wsi0oXLNLtx3bks6fjdXae1kHVxb9i1pkk277cc+NDUwY0LUBmVMJs8v
 H97pG7AX/IySUo0mGhxy5HFe1lMF5vfljs4J+tykLdOhPI22iSJCJU8gfJGz7jQ/y+XA
 fGIitXxzNlbQ1lFa4sKqJ8FgI6KAjskNN8RLXKF1oCDOTTFhF406+jdzezDOAPwfK/2c
 PU13BZmaoA+obQ/0kpCwRBpPptUnvYpyrTWVesvvAV3rhmefalegIINrR3oHaoTQxoL6
 1u+UsB1dctYqz2zeU4/KI4n9xRfP6CCu9c9kvLM3EPpUsv0btiyLJ80EB3FeXskaTdlq
 y91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745954141; x=1746558941;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O4cRnsPeh5gIFGr2KVzjgJ2/bBJtdQUBi9Lvy5gmqYU=;
 b=Onb4P61BlCIUSCNR9EFuQYyrz9ao6Tl+N+6lSqTXPd0VN4ysQ/tcNOyeEVcwplOVlo
 0lzjA3ECFJOLkL6dKZEqdMP3zaRI1989HQHIYuQUvcqX2xUIDTV+i45K0maGfOmDjHTh
 wkO9qyKyv3rdyem2AHN3YDPmiZCoZ9CRuSD6Vyb1IFnrIfT2Q5KfqNRtAxaNJ6lBZEjA
 s3NzJ9BlTU4ZDZzGZ8FY8n7aVlME/FzhK+a9ecagT/cCzjKp0Gf70C2EjFkALoTFc0BV
 CISjrW5vVvFyl2qpqh+5OkWWImPSNnPcMhS5EkFmUl/s3xnERhCtto8U3/VNDpNJIJHf
 /pgQ==
X-Gm-Message-State: AOJu0YxeESmJzRG/vrtKmLAsEwqAZfvv4H/680kNE6oxUoJLpMyJFgDq
 2c5uCIkvkf/z6S6XTkR1uDXxlcB+ok/WZ1/ocgBML9woilYvxaB4F1OSZU2VfIs=
X-Gm-Gg: ASbGncu/M0a4PR71sSyiKubljDyOB2OFtZHrJbgRC6tKSl0VyYHdkGiuif3Uh2c8gxP
 3TgkfW5j2SuL6uItSq5+i3hGn1qNqjET1esGM4FQlNvAf5/72RLraw5la0RvQ0NFvmVMjRWuBPc
 x97g278yGQNaQrPhVdMWhiukBdYYyTG3r5X6CdtFTjJlglMw4kqbh4q8kLJCg17j9TtX9opDjhs
 nCn3hOiodQSxqT3Jg6oIn9bTZtcl2EzgMG/6DgQgwV0fsyHA+YyuzoWSmjSsw8+Uw9eMNFDweCL
 krVd9iMlFprqYu5GGgOa0jCRdUW8kpu4nhrFYHEXvBmHEXZaaiBCrg==
X-Google-Smtp-Source: AGHT+IHYjloxPDBrYyUV8gVZj348Kuw/nUDLkU/T4KeCH+ONwxzo36r4NkA/3M4hNt5ReP9oqPQJAw==
X-Received: by 2002:a05:6a00:3917:b0:736:755b:8317 with SMTP id
 d2e1a72fcca58-74038ab95a2mr567936b3a.21.1745954140850; 
 Tue, 29 Apr 2025 12:15:40 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740399203b3sm35652b3a.56.2025.04.29.12.15.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 12:15:40 -0700 (PDT)
Message-ID: <f2972cb4-4266-4835-9548-706983dc611f@linaro.org>
Date: Tue, 29 Apr 2025 12:15:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, stefanha@redhat.com, 
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, philmd@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, devel@lists.libvirt.org,
 Victor Toso <victortoso@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org>
 <5b21965d-2428-454c-9dd7-266987495abd@linaro.org>
 <87a583789z.fsf@pond.sub.org>
 <25bb4527-f145-4d9c-8f91-a962bfa14a6f@linaro.org>
 <8734drpg4j.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <8734drpg4j.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 4/29/25 12:43 AM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 4/25/25 11:21 PM, Markus Armbruster wrote:
>>> Trouble is some uses of the second kind are in QAPI conditionals.  I can
>>> see three options:
>>>
>>> (1) Drop these conditionals.
>>>
>>> (2) Replace them by run-time checks.
>>>
>>> (3) Have target-specific QAPI-generated code for multiple targets
>>>       coexist in the single binary.
>>>
>>> As far as I can tell, your RFC series is an incomplete attempt at (2).
>>>
>>> I gather you considered (3), but you dislike it for its bloat and
>>> possibly other reasons.  I sympathize; the QAPI-generated code is plenty
>>> bloated as it is, in good part to early design decisions (not mine).
>>>
>>> Your "no noticeable differences" goal precludes (1).
>>>
>>> Back to (2).  In C, replacing compile-time conditionals by run-time
>>> checks means replacing #if FOO by if (foo).  Such a transformation isn't
>>> possible in the QAPI schema.  To make it possible, we need to evolve the
>>> QAPI schema language.
>>>
>>> docs/devel/qapi-code-gen.rst describes what we have:
>>>
>>>           COND = STRING
>>>                | { 'all: [ COND, ... ] }
>>>                | { 'any: [ COND, ... ] }
>>>                | { 'not': COND }
>>>
>>>       [....]
>>>
>>>       The C code generated for the definition will then be guarded by an #if
>>>       preprocessing directive with an operand generated from that condition:
>>>
>>>        * STRING will generate defined(STRING)
>>>        * { 'all': [COND, ...] } will generate (COND && ...)
>>>        * { 'any': [COND, ...] } will generate (COND || ...)
>>>        * { 'not': COND } will generate !COND
>>>
>>> So, conditions are expression trees where the leaves are preprocessor
>>> symbols and the inner nodes are operators.
>>>
>>> It's not quite obvious to me how to best evolve this to support run-time
>>> checks.
>>>
>>
>> After looking at the introspection code, I don't see any major blocker.
>> We need to keep some of existing "if", as they are based on config-host,
>> and should apply.
>> We can introduce a new "available_if" (or any other name), which
>> generates a runtime check when building the schema, or when serializing
>> a struct.
>>
>> This way, by modifying the .json with:
>> - if: 'TARGET_I386'
>> + available_if: 'target_i386()'
>>
>> This way, we keep the possibility to have ifdef, and we can expose at
>> runtime based on available_if. So we can keep the exact same schema we
>> have today per target.
> 
> The name is ugly.  Naming is hard.  No need to worry about it right now.
>

Sure, when I'll work on a v2, I'll use "whatever_if". Meanwhile, pick a 
name you like to describe a runtime vs compile time check, and I'll do 
the sed.

> Semantics of having both 'if' and 'available_if'?  To work out an
> answer, let's consider how to convert conditionals:
> 
> * 'if': STRING
> 
>    If STRING is a target-specific macro, replace by 'available_if': PRED,
>    where PRED is the equivalent run-time predicate.
> 
>    Else, no change.
> 
> * 'if': { 'all': [COND, ...] }
> 
>    If COND contains only target-specific macros, replace by
>    'available_if': { 'all': [PRED, ...] }, where the PRED are the
>    equivalent run-time predicates.
> 
>    If COND contains no target-specific macros, no change.
> 
>    What if it contains both?
> 
>    - If each COND contains either only target-specific macros, or no
>      target-specific macros, we could split the target-specific ones off
>      into an additional 'available_if'.  This requires defining the
>      semantics of having both 'if' and 'available_if' as "both conditions
>      must be satisfied".
> 
>    - What if this isn't the case?
> 
> * 'if' { 'any': [COND, ...] }
> 
>    Similar, but to be able to split the COND we need "either condition
>    must be satisfied".
>

I don't see any reason to block having both. You may want to condition 
it by a define derived from config-host.h, and add a runtime check as 
well. Both "checks" won't apply in the same locations.

We can add any restriction on having both at the same time, works for me 
also. No strong opinion here.

> Even if we can make this work somehow, it would likely be a royal mess
> to explain in qapi-code-gen.rst.
> 
> We currently don't have "mixed" conditionals.  So we could sidestep the
> problem: you can have either 'if' or 'available_if', but not both.
> Feels like a cop out to me.
> 
> What if we move the "is dynamic" bit from the root of the conditional to
> its leaves?  So far, the leaves are macro names.  What if we
> additionally permit a function name?
> 
> Function name, not C expression, to not complicate generating code in
> languages other than C too much.
>

I don't think we should think too much ahead for languages other than C, 
for one, two, and even three reasons :)
- First, it's already broken because we rely on ifdef that won't be 
there in Rust or Go.
- Second, it's code, we can just change it later if needed.
- Third, those json are consumed only by QEMU (right?), so we are free 
to write/modify them as we want.

The only thing that must stay the same is what we expose to the consumer 
in the schema, and which commands we expose in qemu.

> Ignore the question of syntax for now, i.e. how to decide whether a leaf
> is a macro or a function name.
> 
>>> Whatever we choose should support generating Rust and Go as well.  Why?
>>> Rust usage in QEMU is growing, and we'll likely need to generate some
>>> Rust from the QAPI schema.  Victor Toso has been working on Go bindings
>>> for use in Go QMP client software.
>>>
>>
>> I don't see any blocker with that. If you mention generating Rust and Go
>> from qapi json definitions, it's already dependent on C preprocessor
>> because of ifdef constant. So it will have to be adapted anyway.
>> Having the same function (target_i386()) name through different
>> languages is not something hard to achieve.
> 
> I can't see concrete blockers at this time.  I just wanted to make you
> aware of the emerging need to support other languages.
> 
> [...]
> 
>>> QAPI was designed to be compile-time static.  Revising such fundamental
>>> design assumptions is always fraught.  I can't give you a confident
>>> assessment now.  All I can offer you is my willingness to explore
>>> solutions.  See "really fancy" below.
>>>
>>> Fun fact: we used to generate the value of query-qmp-schema as a single
>>> string.  We switched to the current, more bloated representation to
>>> support conditionals (commit 7d0f982bfbb).
>>>
>>
>> It's nice to have this, and this is what would allow us to
>> conditionnally include or not various definitions/commands/fields. I was
>> a bit worried we would have a "static string", but was glad to find a
>> static list instead.
> 
> I'm mildly unhappy about the bloat, but not enough to fix it.
> 
> [...]
> 
>>> The only path to true "no observable differences" I can see is to fix
>>> the target before the management application interacts with QEMU in any
>>> way.  This would make QMP commands (query-cpu-definitions,
>>> query-qmp-schema, ...) impossible to send before the target is fixed.
>>>
>>
>> The current target will be set at the entry of main() in QEMU, so before
>> the monitor is created. Thus, it will be unambiguous.
> 
> I reiterate my dislike for having behavior depend on argv[0].  We'll
> figure out something.
>

I'll answer on the dedicated subthread.

> [...]
> 


