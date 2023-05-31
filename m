Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F0E718BCC
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 23:29:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4TMs-0005m9-Sc; Wed, 31 May 2023 17:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4TMq-0005iK-GX
 for qemu-devel@nongnu.org; Wed, 31 May 2023 17:28:28 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4TMo-0004cU-KV
 for qemu-devel@nongnu.org; Wed, 31 May 2023 17:28:28 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d2467d640so248713b3a.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 14:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685568505; x=1688160505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q8/lS2og5Ny6Mg1oXtcZpgqrgB/85AnoDeq3/QT1Pvo=;
 b=NgAkQA4n6n8mFZSs1YRmXskOe8Btqf8kHfz87jlishV2lBoAVdQnIDz+CoVTsL9Cwb
 UkbmxuR1+teFGuqxLPlROvQr7RaGLgMYptzBWVysvIvbI5dyy1lz+0P/PheKmnrua/b/
 Awh06GZMZiMoFGNPTRueu8tt83hzIIcOf0I+n279vu8v2WdE2Locp8N/uWK7hz4dlqLk
 ZLg07Oh+Wxawmh8InpvDoXQ3fMKd6ELDKgh82N8qVW6NT9Kj2mt5lWWua4otvaCSoeAI
 3KrQNlBJu9FvG5lZj+LyurljgzyoeZLoD0ovq2roTdrIz5/KO4YDumrnbqfZArs1iAUM
 e7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685568505; x=1688160505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8/lS2og5Ny6Mg1oXtcZpgqrgB/85AnoDeq3/QT1Pvo=;
 b=DfippC6W38O834a+9ddjUpP46IIlCt+byVF3P0m6qxv0t7VRs4rqzs3P59vbbdSxgo
 /EbRnIzVw3owS971lcB2KF1+WhcesZu4UCgHUeqjKkE3ZB1EzjhKBzNXeYfgpNcIl9cR
 YQ47QOgjRsA0V0mPUnfdSuA4cdTPAS4QHWA5ZbR6Dv+FXJI2v5USZzgvFLCSijoayrUI
 cpGp3++0gRRFlRmp45dA6KQzUviCRNjrKAN8d5kgej4l73LpW2bZzL4ZBqD5u3C+dQCo
 rYGFQJS5bS9RM01b8Ir4LEEjfR+H/qEbRc7UIpKr0jAtdiGrl/PaTCrMAoz3FEIG2RyY
 zkQA==
X-Gm-Message-State: AC+VfDy3PXXKTomHHnOzL1JF2Zt70T39oqv1Wr+CMjURWYQXP5wZPXHX
 e02PZWJrHDDvfKHY116JYEzspg==
X-Google-Smtp-Source: ACHHUZ7WIJM3kyMCuT/sXnByY3V35KAAMH0V4MeFTLFOIqfgE/HqMeqJAzPHX59iB+ixD6flp0thZQ==
X-Received: by 2002:a05:6a00:1745:b0:643:59cd:6cad with SMTP id
 j5-20020a056a00174500b0064359cd6cadmr8895307pfc.24.1685568504959; 
 Wed, 31 May 2023 14:28:24 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a62e904000000b0063d24fcc2b7sm3757200pfh.1.2023.05.31.14.28.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 14:28:24 -0700 (PDT)
Message-ID: <55e7265e-26c8-8220-01af-65aa36cef854@linaro.org>
Date: Wed, 31 May 2023 14:28:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/21] Migration 20230530 patches
Content-Language: en-US
To: quintela@redhat.com, Daniel Berrange <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20230530182531.6371-1-quintela@redhat.com>
 <cba70806-7186-fdb2-1ebd-2056871c6bc7@linaro.org>
 <87mt1ktdr8.fsf@secure.mitica>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87mt1ktdr8.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 5/31/23 14:03, Juan Quintela wrote:
> Richard Henderson <richard.henderson@linaro.org> wrote:
>> On 5/30/23 11:25, Juan Quintela wrote:
>>> The following changes since commit aa9bbd865502ed517624ab6fe7d4b5d89ca95e43:
>>>     Merge tag 'pull-ppc-20230528' of https://gitlab.com/danielhb/qemu
>>> into staging (2023-05-29 14:31:52 -0700)
>>> are available in the Git repository at:
>>>     https://gitlab.com/juan.quintela/qemu.git
>>> tags/migration-20230530-pull-request
>>> for you to fetch changes up to
>>> c63c544005e6b1375a9c038f0e0fb8dfb8b249f4:
>>>     migration/rdma: Check sooner if we are in postcopy for
>>> save_page() (2023-05-30 19:23:50 +0200)
>>> ----------------------------------------------------------------
> 
> Added Markus and Daniel.
> 
>>> Migration 20230530 Pull request (take 2)
>>> Hi
>>> Resend last PULL request, this time it compiles when CONFIG_RDMA is
>>> not configured in.
>>> [take 1]
>>> On this PULL request:
>>> - Set vmstate migration failure right (vladimir)
>>> - Migration QEMUFileHook removal (juan)
>>> - Migration Atomic counters (juan)
>>> Please apply.
>>> ----------------------------------------------------------------
>>> Juan Quintela (16):
>>>     migration: Don't abuse qemu_file transferred for RDMA
>>>     migration/RDMA: It is accounting for zero/normal pages in two places
>>>     migration/rdma: Remove QEMUFile parameter when not used
>>>     migration/rdma: Don't use imaginary transfers
>>>     migration: Remove unused qemu_file_credit_transfer()
>>>     migration/rdma: Simplify the function that saves a page
>>>     migration: Create migrate_rdma()
>>>     migration/rdma: Unfold ram_control_before_iterate()
>>>     migration/rdma: Unfold ram_control_after_iterate()
>>>     migration/rdma: Remove all uses of RAM_CONTROL_HOOK
>>>     migration/rdma: Unfold hook_ram_load()
>>>     migration/rdma: Create rdma_control_save_page()
>>>     qemu-file: Remove QEMUFileHooks
>>>     migration/rdma: Move rdma constants from qemu-file.h to rdma.h
>>>     migration/rdma: Remove qemu_ prefix from exported functions
>>>     migration/rdma: Check sooner if we are in postcopy for save_page()
>>> Vladimir Sementsov-Ogievskiy (5):
>>>     runstate: add runstate_get()
>>>     migration: never fail in global_state_store()
>>>     runstate: drop unused runstate_store()
>>>     migration: switch from .vm_was_running to .vm_old_state
>>>     migration: restore vmstate on migration failure
>>
>> Appears to introduce multiple avocado failures:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/4378066518#L286
>>
>> Test summary:
>> tests/avocado/migration.py:X86_64.test_migration_with_exec: ERROR
>> tests/avocado/migration.py:X86_64.test_migration_with_tcp_localhost: ERROR
>> tests/avocado/migration.py:X86_64.test_migration_with_unix: ERROR
>> make: *** [/builds/qemu-project/qemu/tests/Makefile.include:142: check-avocado] Error 1
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/4378066523#L387
>>
>> Test summary:
>> tests/avocado/migration.py:X86_64.test_migration_with_tcp_localhost: ERROR
>> tests/avocado/migration.py:X86_64.test_migration_with_unix: ERROR
>> make: *** [/builds/qemu-project/qemu/tests/Makefile.include:142: check-avocado] Error 1
>>
>> Also fails QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/migration-test
>>
>> ../src/migration/rdma.c:408:QIO_CHANNEL_RDMA: Object 0xaaaaf7bba680 is
>> not an instance of type qio-channel-rdma
> 
> I am looking at the other errors, but this one is weird.  It is failing
> here:
> 
> #define TYPE_QIO_CHANNEL_RDMA "qio-channel-rdma"
> OBJECT_DECLARE_SIMPLE_TYPE(QIOChannelRDMA, QIO_CHANNEL_RDMA)
> 
> In the OBJECT line.
> 
> I have no clue what problem are we having here with the object system to
> decide at declaration time that a variable is not of the type that we
> are declaring.
> 
> I am missing something obvious here?

This is where the inline function is declared, but you need to look at the backtrace, 
where you have applied QIO_CHANNEL_RDMA to an object that is *not* of that type.


r~

