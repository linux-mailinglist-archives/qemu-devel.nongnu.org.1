Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 324527BF229
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 07:23:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq5Cp-00031S-Uu; Tue, 10 Oct 2023 01:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq5Cb-0002ya-5Q
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 01:22:42 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq5CX-0005z3-Vl
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 01:22:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-406402933edso48813385e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 22:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696915355; x=1697520155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y57JulWJJyVBlYSNftJ5qGaczJiUrr1v6KJAZiF+dS4=;
 b=YeVBuf1X/LA8/aytFKtXGB/TwjVdc/E8SK7ORUZtSZboz6gF93lC4tQqm9KadvhdmY
 RTa/NzwuTc9GTAvIfvAY8gW/D38fyBflIHe1mrFnouhsQe529jkF2dHSKBlvrKmLRDwe
 AEO7qwUKzn6Spobs5+J6A2bAMFv37C1svNUmHoKZMjj9+a38sEUM22sZNbIKiDCLCI8r
 86b+++ROQm9PdAHBrzhkQReJaNhCI2qb3mfjU8XYkkjIZXa2LIYaZ9+VMxOn9Kwow2bk
 QHsyYipv0MtITg+IDKnZgPsrMxmpbxVHvfSdV7VdbZN7Xdzm5oYgxfbXJ8JH5I/gOWxA
 9+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696915355; x=1697520155;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y57JulWJJyVBlYSNftJ5qGaczJiUrr1v6KJAZiF+dS4=;
 b=oGvseopxy7VJR2niMoxwv0VAJoibUGljpKL+qmibddZhFSxQXN6MV8Cx1BcfbtcPvJ
 xVY0lUfv9xRzOtFK6djs5Hl3Me7DW5vv3yLqiLXyFv3IMrn0mecjI1rzsIu1PhfrpfyI
 sr9c1ATslQaO1HozhiWl7NuCMGJdLbhiy44IZRcg1VyRub7/AAPVFBCEtSxoZIwJCM4I
 dERh/YN26z785BLU3GKhDPk/oyFxRzIDrRNLz7hfOEET0/oJwwkvlIoYwzN4GV7BMR9e
 3lpqOyiv7Z6SjhsYY6vp7U3OtocTBIoaCKK0MzaNOm8MY4B9U+WSrmq/xrhmKlv3vH3R
 0liA==
X-Gm-Message-State: AOJu0YzGWRwF0mIalntlxa9gJ4kqgIu88E3iXM0BnjM06EYbK1egGJ6h
 wJTkp0zMEnXLXmfN+JorW6FW9Q==
X-Google-Smtp-Source: AGHT+IFyPDoTNJX+Qi5JRX4tRW+v+TG8jXp5DCpiAs/pRirrtG53OJSyPSlgLQW343n97AtnIP0kOQ==
X-Received: by 2002:a05:600c:3502:b0:406:44e6:c00d with SMTP id
 h2-20020a05600c350200b0040644e6c00dmr15659505wmq.2.1696915354751; 
 Mon, 09 Oct 2023 22:22:34 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 o13-20020a05600c378d00b004063cd8105csm15066909wmr.22.2023.10.09.22.22.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 22:22:34 -0700 (PDT)
Message-ID: <0aa445c4-d39d-e28a-6bb0-00f7b9f12bb0@linaro.org>
Date: Tue, 10 Oct 2023 07:22:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/3] target/hexagon: avoid shadowing globals
Content-Language: en-US
To: Brian Cain <bcain@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "anjo@rev.ng" <anjo@rev.ng>
Cc: "armbru@redhat.com" <armbru@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "ale@rev.ng" <ale@rev.ng>,
 "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20231005222206.2784853-1-bcain@quicinc.com>
 <20231005222206.2784853-4-bcain@quicinc.com>
 <48c5233c-c294-f50d-a438-f7f6a63c113b@linaro.org>
 <187100e7-a516-4024-1739-a08c630d76f3@linaro.org>
 <BN7PR02MB4194900078A1AA6E067FE20FB8CEA@BN7PR02MB4194.namprd02.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <BN7PR02MB4194900078A1AA6E067FE20FB8CEA@BN7PR02MB4194.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 9/10/23 22:53, Brian Cain wrote:
>> On 9/10/23 08:09, Philippe Mathieu-Daudé wrote:
>>> On 6/10/23 00:22, Brian Cain wrote:
>>>> The typedef `vaddr` is shadowed by `vaddr` identifiers, so we rename the
>>>> identifiers to avoid shadowing the type name.
>>>
>>> This one surprises me, since we have other occurences:
>>>
>>> include/exec/memory.h:751:bool memory_get_xlat_addr(IOMMUTLBEntry
>>> *iotlb, void **vaddr,
>>>       include/qemu/plugin.h:199:void qemu_plugin_vcpu_mem_cb(CPUState
>>> *cpu, uint64_t vaddr,
>>> target/arm/internals.h:643:G_NORETURN void
>>> arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
>>> target/i386/tcg/helper-tcg.h:70:G_NORETURN void
>>> handle_unaligned_access(CPUX86State *env, vaddr vaddr,
>>> ...
>>>
>>> $ git grep -w vaddr, | wc -l
>>>        207
>>>
>>> What is the error/warning like?
>>
>> OK I could reproduce, I suppose you are building with Clang which
>> doesn't support shadow-local so you get global warnings too (as
>> mentioned in this patch subject...):
> 
> No -- I generally build with gcc and only double-check the clang results to make sure I don't see any new failures there.
> 
> But I've not tested "-Wshadow" with clang yet.  I found these by adding "-Wshadow=global" to "-Wshadow=local".  I thought it might be useful to address these too while we're here.
> 
>> In file included from ../../gdbstub/trace.h:1,
>>                    from ../../gdbstub/softmmu.c:30:
>> trace/trace-gdbstub.h: In function '_nocheck__trace_gdbstub_hit_watchpoint':
>> trace/trace-gdbstub.h:903:106: error: declaration of 'vaddr' shadows a
>> global declaration [-Werror=shadow]
>>     903 | static inline void _nocheck__trace_gdbstub_hit_watchpoint(const
>> char * type, int cpu_gdb_index, uint64_t vaddr)
>>         |
>>                                   ~~~~~~~~~^~~~~
>> In file included from include/sysemu/accel-ops.h:13,
>>                    from include/sysemu/cpus.h:4,
>>                    from ../../gdbstub/softmmu.c:21:
>> include/exec/cpu-common.h:21:18: note: shadowed declaration is here
>>      21 | typedef uint64_t vaddr;
>>         |                  ^~~~~
>> trace/trace-gdbstub.h: In function 'trace_gdbstub_hit_watchpoint':
>> trace/trace-gdbstub.h:923:96: error: declaration of 'vaddr' shadows a
>> global declaration [-Werror=shadow]
>>     923 | static inline void trace_gdbstub_hit_watchpoint(const char *
>> type, int cpu_gdb_index, uint64_t vaddr)
>>         |
>>                         ~~~~~~~~~^~~~~
>> include/exec/cpu-common.h:21:18: note: shadowed declaration is here
>>      21 | typedef uint64_t vaddr;
>>         |                  ^~~~~

If we have to clean that for -Wshadow=global, I'm tempted to rename
the typedef as 'vaddr_t' and keep the 'vaddr' variable names.

Richard, Anton, what do you think?

>> Clang users got confused by this, IIUC Markus and Thomas idea is
>> to only enable these warnings for GCC, enforcing them for Clang
>> users via CI (until Clang get this option supported). Personally
>> I'd rather enable the warning once for all, waiting for Clang
>> support (or clean/enable global shadowing for GCC too).
> 
> Hopefully it's helpful or at least benign if we address the shadowed globals under target/hexagon/ for now, even if "-Wshadow=global" is not enabled.
> 
>> See this thread:
>> https://lore.kernel.org/qemu-devel/11abc551-188e-85c0-fe55-
>> b2b58d35105d@redhat.com/
>>
>> Regards,
>>
>> Phil.


