Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B2E7977A9
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 18:30:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHsO-0002gu-3a; Thu, 07 Sep 2023 12:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qeHsJ-0002gQ-9o
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:28:59 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qeHsF-0005d2-0K
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:28:57 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c0bae4da38so8137315ad.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694104132; x=1694708932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lxfSyfHWucAHEG75IWj6iA2J+d/8RLWPib5wMtKkFOA=;
 b=nYEizC7pF9jOQYYWRIYXjwg9hD9Cbrse2kXVvFfASkQwZX6KzwV8YjniTwz6zZ4Ntv
 YbE98Fh0C0RspZuczq7Ei97GMJI47Idk7fHJU/XhNeQiwLytVF6KVNCJbQ/mf6P8T5OJ
 nVNv9vjaekTklS8cta2m6+tE0EZTIVuq1nGJEO3bnfTco692iWq0X2ucwIrnbSPt9GVK
 vT0S/R0zDJny6RmurLwrZS3WcAgYVgyZD4Ti2IE62/q0nXGIzJBSKnsa+tUX71R89hRg
 IiPxTp/3qeBL7tefrboEqopbyUVwHeZY//3txkzD07RGxOJNPmajBEZR1BRChZY/bGw9
 1Msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694104132; x=1694708932;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lxfSyfHWucAHEG75IWj6iA2J+d/8RLWPib5wMtKkFOA=;
 b=SV5jx477QXT2cinihPfcz/8zjuubjOjFWB5Erv0I3cFUiK17Z201NQhDsHOYoSG3Ex
 O7ukIq7iEqzj2T5KkMzivepz4m4/uUaXFgxEOqvOy2JuCT1bBSpJqKcDV7QXFY77f60v
 9E2zZRmOrC78MD6mIKUz5avEq+x17E7xRb8uPlWGOdQmg13FwVklsn2Yndz/Bt/Lpsgw
 y1Wzeh0FmRrj8y++3udLX+wwwsvDys7dO2RxgM9gRwbaeoKCYZmrOVvng1mVQ5dDMLDo
 6EYti0UZKqR8mTBIee88Dt7nllanC0ySySfQ5uuo1nEeO6g/wP1eFiCAxjarecn0zIT7
 w0Bw==
X-Gm-Message-State: AOJu0YwsSKiEwgtcVMuXgMGWJ42kXbFeCR0fcW8DQY0dB1hOhfCebVfN
 pnkWZ0RU4e6ldhbx73UCl2JrlQ==
X-Google-Smtp-Source: AGHT+IHvGUc0O9Sj19abXxYxcvc/+ZFNgd1cuAGtDctWueT9SUWLnTL9u1WjI+vTLKr/ZxdCAqc5Ww==
X-Received: by 2002:a17:902:d2c8:b0:1bb:d586:d29a with SMTP id
 n8-20020a170902d2c800b001bbd586d29amr3966460plc.34.1694104132196; 
 Thu, 07 Sep 2023 09:28:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 19-20020a170902ee5300b001bb99ea5d02sm13041062plo.4.2023.09.07.09.28.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 09:28:51 -0700 (PDT)
Message-ID: <1d405e13-c98c-d288-2644-ee79bc8c4234@linaro.org>
Date: Thu, 7 Sep 2023 09:28:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH] softmmu: Fix async_run_on_cpu() use in
 tcg_commit_cpu()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: WANG Xuerui <git@xen0n.name>, David Hildenbrand <david@redhat.com>,
 Sergey Fedorov <serge.fdrv@gmail.com>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Emilio G . Cota" <cota@braap.org>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org
References: <20230907161415.6102-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907161415.6102-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 9/7/23 09:14, Philippe Mathieu-Daudé wrote:
> CPUState::halt_cond is an accelerator specific pointer, used
> in particular by TCG (which tcg_commit() is about).
> The pointer is set by the AccelOpsClass::create_vcpu_thread()
> handler.
> AccelOpsClass::create_vcpu_thread() is called by the generic
> qemu_init_vcpu(), which expect the accelerator handler to
> eventually call cpu_thread_signal_created() which is protected
> with a QemuCond. It is safer to check the vCPU is created with
> this field rather than the 'halt_cond' pointer set in
> create_vcpu_thread() before the vCPU thread is initialized.
> 
> This avoids calling tcg_commit() until all CPUs are realized.
> 
> Here we can see for a machine with N CPUs, tcg_commit()
> is called N times before the 'machine_creation_done' event:
> 
>    (lldb) settings set -- target.run-args  "-M" "virt" "-smp" "512" "-display" "none"
>    (lldb) breakpoint set --name qemu_machine_creation_done --one-shot true
>    (lldb) breakpoint set --name tcg_commit_cpu --auto-continue true
>    (lldb) run
>    Process 84089 launched: 'qemu-system-aarch64' (arm64)
>    Process 84089 stopped
>    * thread #1, queue = 'com.apple.main-thread', stop reason = one-shot breakpoint 2
>    (lldb) breakpoint list --brief
>    Current breakpoints:
>    2: name = 'tcg_commit_cpu', locations = 2, resolved = 2, hit count = 512 Options: enabled auto-continue
>               ^^^^^^^^^^^^^^                                ^^^^^^^^^^^^^^^
> 

Of course the function is called 512 times: you asked for 512 cpus, and each has its own 
address space which needs initializing.

If you skip the call before cpu->created, when exactly are you going to do it?


r~

