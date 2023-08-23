Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA48785D43
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 18:29:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYqiS-00069w-PO; Wed, 23 Aug 2023 12:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYqhq-0005t8-Nb
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 12:27:42 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYqho-0001bT-Un
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 12:27:42 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3a76d882052so4122893b6e.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 09:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692808059; x=1693412859;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LoP8KSE0qfOqKDqt1vymjZj6csZ/6Kob92W38ohPloY=;
 b=DW+VimbM/7ewZLljqfMTtUrVmBd8JnhWrbNZujnt2gqTJTm3zvVq1CtkcROZ40s2Og
 4GLnTQq7+9J3WzsdMJMkH0Fdusgty87OyG4RioXV0CljAVQceQZuUxMQ+5lI1d4BF/bS
 PqXk8veLMDyE6OEDdiP8nn5HC/lto3zDA4O3LFJPpzZ/Dstaf9PUtKNNa/kskt4iJfgX
 lHQHEypUAECWzHpPO2UJDfif9d4P1iZUgVr+kVkWlG463FYbig4ocmcqgjihCzBfq3hQ
 Y31cgnLBkQIutLAiBrx1gNHtttC8B97U0O0mqoKbjFirq3ry9Sj+oBNNj4EzZOmks0e7
 VpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692808059; x=1693412859;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LoP8KSE0qfOqKDqt1vymjZj6csZ/6Kob92W38ohPloY=;
 b=LfxIYq6bPQyaXwtp9vh4K83wiX/+/EQPlH0jPiKrwnM5Rw0z3OM+z7X8hJmXvcJlTG
 OqlGYeFN/jyoH8JRse5EsAquNq+GTB9Aq9totAK/isqMaTlZ5Vh5WpzE3a+mft6o+mvY
 3lLs2sNSYrBYm5UI0f03qvtbnQbswJFYxoaIKv/Wnrz649xt0/n/qZHYa/xOoL9ZeRbF
 Z9E/c6xeprEvfqZLGUjCsVgqMFGPfKeZtyQz5DO73FpdWEJMlQ+YFPyXL/ikEhc8APKN
 Dg9JI0oGxsKIPvESPBToQzh3T+0rnfq6us1omjv0C6EhVBRprKoZXd5zs8WWuAGJNf6k
 axqQ==
X-Gm-Message-State: AOJu0YyLijYpU0dRgrWy/CXEWr69l/l5kICYTe5pJb5qIldwnv9dTsfc
 9AyjYaYwsLBb9bvOckG6KSZDkQ==
X-Google-Smtp-Source: AGHT+IG4SlRMqCLOqDDWbJyRiwbhyLlcpxl1WN0uSIfrCnNpn0U742p9Bl8bm6m+hXvhNco2s46L6w==
X-Received: by 2002:a05:6808:de6:b0:3a7:3792:5b8a with SMTP id
 g38-20020a0568080de600b003a737925b8amr13622016oic.18.1692808059350; 
 Wed, 23 Aug 2023 09:27:39 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:72f0:1ea7:85d2:141e?
 ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 w29-20020a63935d000000b00563df2ba23bsm9875038pgm.50.2023.08.23.09.27.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 09:27:38 -0700 (PDT)
Message-ID: <59a970fb-ad7b-d30b-1290-7b167bec0226@linaro.org>
Date: Wed, 23 Aug 2023 09:27:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Failing avocado tests in CI (was: Re: [PULL 00/24] tcg +
 linux-user queue for 8.1-rc3)
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
 <772eb951-8a43-902b-3737-e52b44f7dcdb@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <772eb951-8a43-902b-3737-e52b44f7dcdb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.684,
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

On 8/23/23 06:04, Thomas Huth wrote:
> On 06/08/2023 05.36, Richard Henderson wrote:
>> The following changes since commit 6db03ccc7f4ca33c99debaac290066f4500a2dfb:
>>
>>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-08-04 
>> 14:47:00 -0700)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230805
>>
>> for you to fetch changes up to 843246699425adfb6b81f927c16c9c6249b51e1d:
>>
>>    linux-user/elfload: Set V in ELF_HWCAP for RISC-V (2023-08-05 18:17:20 +0000)
>>
>> ----------------------------------------------------------------
>> accel/tcg: Do not issue misaligned i/o
>> accel/tcg: Call save_iotlb_data from io_readx
>> gdbstub: use 0 ("any process") on packets with no PID
>> linux-user: Fixes for MAP_FIXED_NOREPLACE
>> linux-user: Fixes for brk
>> linux-user: Adjust task_unmapped_base for reserved_va
>> linux-user: Use ELF_ET_DYN_BASE for ET_DYN with interpreter
>> linux-user: Remove host != guest page size workarounds in brk and image load
>> linux-user: Set V in ELF_HWCAP for RISC-V
>> *-user: Remove last_brk as unused
> 
>   Hi Richard,
> 
> I noticed that we currently have two failing Avocado jobs in our CI, avocado-system-centos 
> and avocado-system-opensuse, where the boot_linux.py:BootLinuxX8664.test_pc_i440fx_tcg and 
> the boot_linux.py:BootLinuxX8664.test_pc_q35_tcg are now apparently crashing. If I've got 
> the history right, it started with your pull request here, in the preceeding one from 
> Paolo, everything is still green:
> 
>   https://gitlab.com/qemu-project/qemu/-/pipelines/956543770
> 
> But here the jobs started failing:
> 
>   https://gitlab.com/qemu-project/qemu/-/pipelines/957458385
> 
> Could you please have a look?

It's some sort of timing issue, which sometimes goes away when re-run.  I was re-running 
tests *a lot* in order to get them to go green while running the 8.1 release.

For instance, with very little added except for your s390x pull, the same 
BootLinuxX8664.test_pc_i440fx_tcg test passes:

https://gitlab.com/qemu-project/qemu/-/jobs/4931341744#L136

In the failing i44fx_tcg test, you can even see it's a timing issue:

https://qemu-project.gitlab.io/-/qemu/-/jobs/4813804725/artifacts/build/tests/results/latest/test-results/02-tests_avocado_boot_linux.py_BootLinuxX8664.test_pc_i440fx_tcg/debug.log

23:42:30 DEBUG| [   61.003328] Sending NMI from CPU 0 to CPUs 1:
23:42:30 DEBUG| [   61.007829] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long 
to run: 2.622 msecs
23:42:30 DEBUG| [   61.003328] NMI backtrace for cpu 1 skipped: idling at 
native_safe_halt+0xe/0x10
23:42:30 DEBUG| [   61.003328] rcu: rcu_sched kthread starved for 60002 jiffies! g-963 
f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
23:42:30 DEBUG| [   61.003328] rcu: RCU grace-period kthread stack dump:
23:42:30 DEBUG| [   61.003328] rcu_sched       I    0    10      2 0x80004000
23:42:30 DEBUG| [   61.003328] Call Trace:
23:42:30 DEBUG| [   61.003328]  ? __schedule+0x29f/0x680
...


r~

