Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3AB798629
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 12:50:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeZ3Y-00037G-An; Fri, 08 Sep 2023 06:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeZ3V-00036r-GK
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:49:41 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeZ3T-00054E-7O
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:49:41 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-401c90ed2ecso20591445e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 03:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694170177; x=1694774977; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sDGeb7DcFaPd5Ya4qKVpbJwf5cF5Ch2M+/T7tQySBzk=;
 b=e/nL3wL4P/1dbF7hVuVcws+CmeGiMBxGzGQGxrFdCqqsXwIZJnTgCC97fPI/sQPh7t
 tU9pf8QGAqU/VBMREASC3nOixLk2hSDKC8S/Fb/BFQwiersfcgAV5nJ+QySTXAMzPTCJ
 nq5xH9E0JZlurbe7PsvAkjvJqBS6FxIswJzF3LYodZYD6xFPqLQWmZrWhucjX2HScvyw
 kka+g0+h0WdtNWWuvKrNEe4niYd1rKLzPuHpOPG4aSTe/KOVOA+CgHuI/p+bLggYpaf8
 UU2xPXHTJniUTCdNIrvoPAUNSp+VUW0r4bQl2oWGgKFuzrCDksuro+QSvft5AiinrGke
 1smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694170177; x=1694774977;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sDGeb7DcFaPd5Ya4qKVpbJwf5cF5Ch2M+/T7tQySBzk=;
 b=nIS2S7DMfdFTgy1fwQ4ZTirqRFOSqOWLufohuMaJcyrQUC05Iff8rHg5CiX1y2ccez
 0qATDQR3DGgFPYqVLm3c/49EFJilcKL6cQYzQna0ygGOvhhFyQIwdAIMSZyBj4cP+KUq
 L2KUcjDLBiyy91bcnbVS3NtiqoAhorqSWSKwncXd4T3CYbWRjQtsPCIKX4MKm86BJg4g
 79wGkKN5kfVxW50p70BB0D+st7le6+0qfnZHseE25kv9pqVUj4GBuGrr3yPR0eKVGCtl
 io5w9Ru+Px8pJsVajos7ul+CMgzUvchVtri/R4HRd02FO8cNKWDeokpfirI13i11LTMX
 uP3w==
X-Gm-Message-State: AOJu0Ywb/kJ+ZtEZ1X81aif/LlI5fW0VYhHyEpyVbpMPUrIsS4G84/6V
 3gFIS84ZbU/b6PsS+vCZwZAQVA==
X-Google-Smtp-Source: AGHT+IH5inqBan+Rxpwax3/nF2F7CfZUlqz1eciKr1ab3baflVBr4aeT1uJPwHbtnOPSwKs56x8m/w==
X-Received: by 2002:a05:600c:b58:b0:401:b2c7:349d with SMTP id
 k24-20020a05600c0b5800b00401b2c7349dmr1862114wmr.29.1694170177065; 
 Fri, 08 Sep 2023 03:49:37 -0700 (PDT)
Received: from [192.168.69.115]
 (lfb24-h01-176-173-167-175.dsl.sta.abo.bbox.fr. [176.173.167.175])
 by smtp.gmail.com with ESMTPSA id
 f11-20020a7bcd0b000000b003fee53feab5sm1668477wmj.10.2023.09.08.03.49.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 03:49:36 -0700 (PDT)
Message-ID: <6b242540-3ae5-7d61-0112-8327d40a39d3@linaro.org>
Date: Fri, 8 Sep 2023 12:49:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH] softmmu: Fix async_run_on_cpu() use in
 tcg_commit_cpu()
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: WANG Xuerui <git@xen0n.name>, David Hildenbrand <david@redhat.com>,
 Sergey Fedorov <serge.fdrv@gmail.com>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Emilio G . Cota" <cota@braap.org>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org
References: <20230907161415.6102-1-philmd@linaro.org>
 <1d405e13-c98c-d288-2644-ee79bc8c4234@linaro.org>
 <22f2d4bd-2037-5fc5-8c7c-2a9247b1064e@linaro.org>
In-Reply-To: <22f2d4bd-2037-5fc5-8c7c-2a9247b1064e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/9/23 21:36, Philippe Mathieu-Daudé wrote:
> On 7/9/23 18:28, Richard Henderson wrote:
>> On 9/7/23 09:14, Philippe Mathieu-Daudé wrote:
>>> CPUState::halt_cond is an accelerator specific pointer, used
>>> in particular by TCG (which tcg_commit() is about).
>>> The pointer is set by the AccelOpsClass::create_vcpu_thread()
>>> handler.
>>> AccelOpsClass::create_vcpu_thread() is called by the generic
>>> qemu_init_vcpu(), which expect the accelerator handler to
>>> eventually call cpu_thread_signal_created() which is protected
>>> with a QemuCond. It is safer to check the vCPU is created with
>>> this field rather than the 'halt_cond' pointer set in
>>> create_vcpu_thread() before the vCPU thread is initialized.
>>>
>>> This avoids calling tcg_commit() until all CPUs are realized.
>>>
>>> Here we can see for a machine with N CPUs, tcg_commit()
>>> is called N times before the 'machine_creation_done' event:
>>>
>>>    (lldb) settings set -- target.run-args  "-M" "virt" "-smp" "512" 
>>> "-display" "none"
>>>    (lldb) breakpoint set --name qemu_machine_creation_done --one-shot 
>>> true
>>>    (lldb) breakpoint set --name tcg_commit_cpu --auto-continue true
>>>    (lldb) run
>>>    Process 84089 launched: 'qemu-system-aarch64' (arm64)
>>>    Process 84089 stopped
>>>    * thread #1, queue = 'com.apple.main-thread', stop reason = 
>>> one-shot breakpoint 2
>>>    (lldb) breakpoint list --brief
>>>    Current breakpoints:
>>>    2: name = 'tcg_commit_cpu', locations = 2, resolved = 2, hit count 
>>> = 512 Options: enabled auto-continue
>>>               ^^^^^^^^^^^^^^ ^^^^^^^^^^^^^^^
>>>
>>
>> Of course the function is called 512 times: you asked for 512 cpus, 
>> and each has its own address space which needs initializing.

My commit description is too confusing. I'll split in tiny simple
changes and try to better describe each.

> The AS are still initialized at the same time, but we defer the listener
> callback until the vCPU is ready (what was expected first IIUC).
> 
>> If you skip the call before cpu->created, when exactly are you going 
>> to do it?
> 
> With this patch tcg_commit_cpu() is only called by vCPU threads, in
> their processing loop. i.e: comparing backtraces, now the first hit
> is:
> (lldb) bt
> * thread #514, stop reason = breakpoint 4.2
>    * frame #0: 0x1005d9d48 
> qemu-system-aarch64`tcg_commit_cpu(cpu=0x173358000, data=...) at 
> physmem.c:2493:63
>      frame #1: 0x10000d684 
> qemu-system-aarch64`process_queued_cpu_work(cpu=0x173358000) at 
> cpus-common.c:360:13
>      frame #2: 0x100297390 qemu-system-aarch64`qemu_wait_io_event 
> [inlined] qemu_wait_io_event_common(cpu=<unavailable>) at cpus.c:412:5 
> [artificial]
>      frame #3: 0x100623b98 
> qemu-system-aarch64`mttcg_cpu_thread_fn(arg=0x173358000) at 
> tcg-accel-ops-mttcg.c:123:9
>      frame #4: 0x10079f15c 
> qemu-system-aarch64`qemu_thread_start(args=<unavailable>) at 
> qemu-thread-posix.c:541:9
>      frame #5: 0x18880ffa8 libsystem_pthread.dylib`_pthread_start + 148
> 


