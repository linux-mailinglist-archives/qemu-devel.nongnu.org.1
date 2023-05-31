Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6FD717833
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 09:28:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4GFm-0007jc-O0; Wed, 31 May 2023 03:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4GFj-0007jR-LM
 for qemu-devel@nongnu.org; Wed, 31 May 2023 03:28:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4GFh-0005dv-1l
 for qemu-devel@nongnu.org; Wed, 31 May 2023 03:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685518091;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=RVYL8Aw/ioJp+85Ho9zQNsZ4LvWDPA2uiRl3B4oLVKQ=;
 b=IopbMuavFz6kELVDD2rq+To/Jc+7TLVahQ0qYBADeesAyw0Ri8YaMFxanroYS8txcaQ3Kr
 iAJKSuUpEwxWTBm5zzDiucLdShWVMG3ER1EruL8yH4yjvAgC/8kiiWIdaPnTzznewqYD0h
 bw8F3267ik/g2846oqjSMWMgRMstIY4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-qrikhiJVOiCahaG2AlAR5g-1; Wed, 31 May 2023 03:28:10 -0400
X-MC-Unique: qrikhiJVOiCahaG2AlAR5g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f603fed174so33754495e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 00:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685518088; x=1688110088;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RVYL8Aw/ioJp+85Ho9zQNsZ4LvWDPA2uiRl3B4oLVKQ=;
 b=epPXRAhi0R+H+/XiutlgM0OYtVH9bsPl491Zm2uugh2jcAPmAI6gyS7qbOtQZTKY2+
 ganLmt2k7++C7J/br9yqf5jFR7RZtlseV0BlprPTFkyInuaAJ7P98zDKrWlGb9QGbJTj
 scQ4nXNvkJvNLzB6O475mWZFHJHVm1Sh+/mECVcnVAroA6iBUHhSUqiXffEK4RucLwIN
 HUwj80B2G6TmM2Bu2m/TbSEZgwgS0AViDJVhuAmUpl41kgz6wx0qTnLd2GgvRuyxRl/0
 tDvqyko2667OtDH1oIAkH0cnUsYuKbuA+ySiY+8+01E8+RLLiDiHruhDRrLkFOoiVYL5
 jj3A==
X-Gm-Message-State: AC+VfDw0UvOcALb9ZsB5A6PCSxt6sy7xiP3fMuIC/OLYsBswzYwM7kr8
 KQX4DR39INkez3ou7qrYylufWxM7v/jFmtwzPMU06dlQZY/FEyH4uTEalMkuU1Dht6BUlJnICC0
 qMw9VgMSBrDFXy7Q=
X-Received: by 2002:a05:600c:2304:b0:3f6:15f:e401 with SMTP id
 4-20020a05600c230400b003f6015fe401mr3562176wmo.37.1685518088578; 
 Wed, 31 May 2023 00:28:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ68JtZaq7EtZ21oWNf7y5adt7Rhe5lDhXiSb52zdTUrKdyK+OImdHh4RgLi7LG/bVv1Gv1faQ==
X-Received: by 2002:a05:600c:2304:b0:3f6:15f:e401 with SMTP id
 4-20020a05600c230400b003f6015fe401mr3562166wmo.37.1685518088232; 
 Wed, 31 May 2023 00:28:08 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 g18-20020a7bc4d2000000b003f427687ba7sm19572746wmk.41.2023.05.31.00.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 00:28:07 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Leonardo
 Bras <leobras@redhat.com>,  Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 00/21] Migration 20230530 patches
In-Reply-To: <cba70806-7186-fdb2-1ebd-2056871c6bc7@linaro.org> (Richard
 Henderson's message of "Tue, 30 May 2023 13:23:10 -0700")
References: <20230530182531.6371-1-quintela@redhat.com>
 <cba70806-7186-fdb2-1ebd-2056871c6bc7@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 31 May 2023 09:28:06 +0200
Message-ID: <87fs7dufi1.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Richard Henderson <richard.henderson@linaro.org> wrote:
> On 5/30/23 11:25, Juan Quintela wrote:
>> The following changes since commit aa9bbd865502ed517624ab6fe7d4b5d89ca95e43:
>>    Merge tag 'pull-ppc-20230528' of https://gitlab.com/danielhb/qemu
>> into staging (2023-05-29 14:31:52 -0700)
>> are available in the Git repository at:
>>    https://gitlab.com/juan.quintela/qemu.git
>> tags/migration-20230530-pull-request
>> for you to fetch changes up to
>> c63c544005e6b1375a9c038f0e0fb8dfb8b249f4:
>>    migration/rdma: Check sooner if we are in postcopy for
>> save_page() (2023-05-30 19:23:50 +0200)
>> ----------------------------------------------------------------
>> Migration 20230530 Pull request (take 2)
>> Hi
>> Resend last PULL request, this time it compiles when CONFIG_RDMA is
>> not configured in.
>> [take 1]
>> On this PULL request:
>> - Set vmstate migration failure right (vladimir)
>> - Migration QEMUFileHook removal (juan)
>> - Migration Atomic counters (juan)
>> Please apply.
>> ----------------------------------------------------------------
>> Juan Quintela (16):
>>    migration: Don't abuse qemu_file transferred for RDMA
>>    migration/RDMA: It is accounting for zero/normal pages in two places
>>    migration/rdma: Remove QEMUFile parameter when not used
>>    migration/rdma: Don't use imaginary transfers
>>    migration: Remove unused qemu_file_credit_transfer()
>>    migration/rdma: Simplify the function that saves a page
>>    migration: Create migrate_rdma()
>>    migration/rdma: Unfold ram_control_before_iterate()
>>    migration/rdma: Unfold ram_control_after_iterate()
>>    migration/rdma: Remove all uses of RAM_CONTROL_HOOK
>>    migration/rdma: Unfold hook_ram_load()
>>    migration/rdma: Create rdma_control_save_page()
>>    qemu-file: Remove QEMUFileHooks
>>    migration/rdma: Move rdma constants from qemu-file.h to rdma.h
>>    migration/rdma: Remove qemu_ prefix from exported functions
>>    migration/rdma: Check sooner if we are in postcopy for save_page()
>> Vladimir Sementsov-Ogievskiy (5):
>>    runstate: add runstate_get()
>>    migration: never fail in global_state_store()
>>    runstate: drop unused runstate_store()
>>    migration: switch from .vm_was_running to .vm_old_state
>>    migration: restore vmstate on migration failure

Self nack

> Appears to introduce multiple avocado failures:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/4378066518#L286
>
> Test summary:
> tests/avocado/migration.py:X86_64.test_migration_with_exec: ERROR

No clue what is going on here.
I haven't touched exec migration (famous last words)

> tests/avocado/migration.py:X86_64.test_migration_with_tcp_localhost:
> ERROR

This is tested by ./tests/migration-test

It passes for me with qemu-system-x86_64 (kvm), qemu-system-i386 (kvm)
and aarch64 (tcg).  What make check tests.

> tests/avocado/migration.py:X86_64.test_migration_with_unix: ERROR

Dunno again.

> make: *** [/builds/qemu-project/qemu/tests/Makefile.include:142: check-avocado] Error 1
>
> https://gitlab.com/qemu-project/qemu/-/jobs/4378066523#L387
>
> Test summary:
> tests/avocado/migration.py:X86_64.test_migration_with_tcp_localhost: ERROR
> tests/avocado/migration.py:X86_64.test_migration_with_unix: ERROR
> make: *** [/builds/qemu-project/qemu/tests/Makefile.include:142: check-avocado] Error 1
>
> Also fails QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/migration-test
>
> ../src/migration/rdma.c:408:QIO_CHANNEL_RDMA: Object 0xaaaaf7bba680 is

This is something that changed on the series, so I will check with this
avocado tests.  No clue why it passes with x86_64 and not with aarch64.

> not an instance of type qio-channel-rdma

Here there was an error creating the RDMA channel somehow.  Somehow is
the important word on the previous sentence.

> qemu-system-aarch64: Not a migration stream
> qemu-system-aarch64: load of migration failed: Invalid argument
> Broken pipe

Will isolate the non RDMA changes and try to pass the RDMA ones through
avocado.

I am sorry for the noise.

Later, Juan.


