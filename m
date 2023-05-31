Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCAE717B76
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 11:12:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4HrO-0000Qd-T4; Wed, 31 May 2023 05:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4HrM-0000QE-R6
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:11:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4HrF-0003DN-QL
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685524264;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4JS+XGy37kTHM0W2ImD54IK1exxgPatIH5tDmLjcBTU=;
 b=gBC1SClcp816RO3byr0JZ69cqkzNMyrT2R5Zvlbyc8Eete77cKHl7uBfrkaPsXNmRbyxdI
 SwedGDHhE9qewDworLdfd+ERTgDOG2TgX/LdXUpBkKK0RxBcGOzjB0ayXA9zdR+4YGb8JO
 54r98dixEYpaXsS4FaOynpNxzSqiDh0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-c3sj7jfpN0ihSPLWjbs6Hw-1; Wed, 31 May 2023 05:11:03 -0400
X-MC-Unique: c3sj7jfpN0ihSPLWjbs6Hw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4ef455ba61cso3349774e87.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 02:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685524261; x=1688116261;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4JS+XGy37kTHM0W2ImD54IK1exxgPatIH5tDmLjcBTU=;
 b=OiMBISoCHU1DR3xnm3X/lks8vwra2ClUFjONd/g8rCkBQdydpqSP2h2H7Ea9eMS2mo
 MfqMmVE+qma7iCvyKFUP+fWhzlc63Xe0Oy5+3AmqgIEzt2ApBm6QqjWooFKJsa9nCEUZ
 JVwsD6/eVL1wP6BlcAnvGxMJtjx8Q+pojrdmNw/CNIDPnFlm9sljsOvVhAEmQ6sq2fXh
 S+SyKB+TXo7EFTvjmYAwxH4HNl0zDcjPtNXM6g+0xlB4AcfoTlgHpev6vv1JdIbgL5fW
 /6eW9h3y3TPGwqFCyDwib44x2/feVEdYiM8DfGgDZ3jt7jH0GE9NQlegu2zucz/6Yslo
 AaEQ==
X-Gm-Message-State: AC+VfDyznlDZohoR80+ZgvnvrORx+R0M4rzG2cQiDEIY9GJpSLLs2DbB
 YMqSgyOtQGjIaeXvp9x5VJpAOnGVeLJ1sCly0h5ySS0Ko2RHfWQeJD/bPF1PhAB6KUiWVf2I3gk
 rZtyx2RaVEUYbEM0=
X-Received: by 2002:ac2:5a4e:0:b0:4f5:1418:e230 with SMTP id
 r14-20020ac25a4e000000b004f51418e230mr2170701lfn.52.1685524261299; 
 Wed, 31 May 2023 02:11:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4HguT8fcog2212A8z/FLY78RenQvPsknIVcaorwXw1fUwo/MElAYKnaFHzooMG734KGnfuvw==
X-Received: by 2002:ac2:5a4e:0:b0:4f5:1418:e230 with SMTP id
 r14-20020ac25a4e000000b004f51418e230mr2170684lfn.52.1685524260882; 
 Wed, 31 May 2023 02:11:00 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 i7-20020a5d4387000000b0030ae54e575csm5969605wrq.59.2023.05.31.02.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 02:11:00 -0700 (PDT)
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
Date: Wed, 31 May 2023 11:10:59 +0200
Message-ID: <874jnsvpb0.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
>
> Appears to introduce multiple avocado failures:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/4378066518#L286
>
> Test summary:
> tests/avocado/migration.py:X86_64.test_migration_with_exec: ERROR
> tests/avocado/migration.py:X86_64.test_migration_with_tcp_localhost: ERROR
> tests/avocado/migration.py:X86_64.test_migration_with_unix: ERROR
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
> not an instance of type qio-channel-rdma
> qemu-system-aarch64: Not a migration stream
> qemu-system-aarch64: load of migration failed: Invalid argument
> Broken pipe

And as it couldn't be anyother way, on my machine (with upstream qemu,
i.e. none of my changes in):

$ make check-avocado (check-acceptance fails in the same test)

...

STARTED
 (063/243) tests/avocado/kvm_xen_guest.py:KVMXenGuest.test_kvm_xen_guest_nomsi: ERROR: ConnectError: Failed to establish session: EOFError\n	Exit code: 1\n	Command: ./qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,fd=9 -mon chardev=mon,mode=control -machine q35 -chardev socket,id=console,path=/var/tmp/qemu_yv2aqehm/7f8b6cf5... (2.52 s)
Interrupting job (failfast).
RESULTS    : PASS 42 | ERROR 1 | FAIL 0 | SKIP 199 | WARN 0 | INTERRUPT 0 | CANCEL 1
JOB TIME   : 71.66 s

Test summary:
tests/avocado/kvm_xen_guest.py:KVMXenGuest.test_kvm_xen_guest_nomsi: ERROR
make: *** [/mnt/code/qemu/full/tests/Makefile.include:142: check-avocado] Error 9


the good news:  Some tests passed.  sixty something.
the bad news: it is failing on kvm xen guest and I have no clue
              why/where.

Is there some documentation that can help me here?

Thanks, Juan.


