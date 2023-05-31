Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 523BD718B16
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:24:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SLa-0004zr-DZ; Wed, 31 May 2023 16:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4SLW-0004t1-Ga
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4SLU-0000md-2W
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685564576;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4BsbcG3QUQ8mkzRuA8UK7xyiA8gvrFXQzGEzCp9Q54k=;
 b=UNeRGewjQT8vq7WBKmcs6DsD69Wh4PT6TVa7DPljByZ9FD2AfVHgf+u4hRJQC6BygZFAmL
 b8p1VoWkT7+vYugcKc5u3r0rM7v1x5BUqoYi30EjC4RMOI5UquV/6u/7vrEOi19qctEJPi
 qes6dl2vQWv92+kRGBtV7zHTnHnjP+4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-o-VMlh5ZN0ipimueo_YOVg-1; Wed, 31 May 2023 16:22:55 -0400
X-MC-Unique: o-VMlh5ZN0ipimueo_YOVg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f5fffb828eso6320305e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685564573; x=1688156573;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4BsbcG3QUQ8mkzRuA8UK7xyiA8gvrFXQzGEzCp9Q54k=;
 b=AYIrirYWYe63CyNL9F2quI80qtlOGzhmqIEWXxmRynZ1z8O+g6pbCHnBSh+AEShnXd
 dTkJ8lK4JiBefbzRn/QRji1Q2/h3xWFD16m+0Yarx1K6bZ0yKsEfwtFTWYDpgFSfST7m
 bcSkiW2nDJvaeyk0QlHJ521wO987rbrYYbYpBx9QtlpQO/Pb+atU903Rkmsb8Kc3rnU1
 s6hNqUG+yPblTwYE7BRxHfxQ3qebX2pgOSSpceDK2ry9nkJJCk2sTI4pFUT3ifVGBK3T
 6D6UZdrGh3MgKjxUIsYDma+qUDjpBqkkpBYcS/5eBEssfYi5Tv//89ScTSvmt/ZnIpF+
 zLfg==
X-Gm-Message-State: AC+VfDwlD9rBPn5/DyvrAxfDkQKxSvUB35fQkszV8SEHgglSXsksZ/PS
 gKcM8jGh7aUewS8r8TpYQPcaQ1bXC1odAPGGztqX83MdDkkUdc1vKaHNfrGOHYcY1PnfhD7oZ/J
 ySmjRvipRWeJ7bek=
X-Received: by 2002:a05:600c:511f:b0:3f6:829:71f0 with SMTP id
 o31-20020a05600c511f00b003f6082971f0mr285883wms.14.1685564573449; 
 Wed, 31 May 2023 13:22:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ47P75r/R/bkgVzdBu5nkms8JCixqoigXumh2OjMjYedBQIOlKgZ8Qvp79mFkPBXrbLM1JURA==
X-Received: by 2002:a05:600c:511f:b0:3f6:829:71f0 with SMTP id
 o31-20020a05600c511f00b003f6082971f0mr285879wms.14.1685564573096; 
 Wed, 31 May 2023 13:22:53 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 o7-20020a05600c378700b003f4ddde398csm22034684wmr.21.2023.05.31.13.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 13:22:52 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Leonardo
 Bras <leobras@redhat.com>,  Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 00/21] Migration 20230530 patches
In-Reply-To: <874jnsvpb0.fsf@secure.mitica> (Juan Quintela's message of "Wed, 
 31 May 2023 11:10:59 +0200")
References: <20230530182531.6371-1-quintela@redhat.com>
 <cba70806-7186-fdb2-1ebd-2056871c6bc7@linaro.org>
 <874jnsvpb0.fsf@secure.mitica>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 31 May 2023 22:22:51 +0200
Message-ID: <87r0qwtfms.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

Juan Quintela <quintela@redhat.com> wrote:
> Richard Henderson <richard.henderson@linaro.org> wrote:
>> On 5/30/23 11:25, Juan Quintela wrote:
>>> The following changes since commit aa9bbd865502ed517624ab6fe7d4b5d89ca95e43:
>>>    Merge tag 'pull-ppc-20230528' of https://gitlab.com/danielhb/qemu
>>> into staging (2023-05-29 14:31:52 -0700)
>>> are available in the Git repository at:
>>>    https://gitlab.com/juan.quintela/qemu.git
>>> tags/migration-20230530-pull-request
>>> for you to fetch changes up to
>>> c63c544005e6b1375a9c038f0e0fb8dfb8b249f4:
>>>    migration/rdma: Check sooner if we are in postcopy for
>>> save_page() (2023-05-30 19:23:50 +0200)
>>> ----------------------------------------------------------------
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
>>>    migration: Don't abuse qemu_file transferred for RDMA
>>>    migration/RDMA: It is accounting for zero/normal pages in two places
>>>    migration/rdma: Remove QEMUFile parameter when not used
>>>    migration/rdma: Don't use imaginary transfers
>>>    migration: Remove unused qemu_file_credit_transfer()
>>>    migration/rdma: Simplify the function that saves a page
>>>    migration: Create migrate_rdma()
>>>    migration/rdma: Unfold ram_control_before_iterate()
>>>    migration/rdma: Unfold ram_control_after_iterate()
>>>    migration/rdma: Remove all uses of RAM_CONTROL_HOOK
>>>    migration/rdma: Unfold hook_ram_load()
>>>    migration/rdma: Create rdma_control_save_page()
>>>    qemu-file: Remove QEMUFileHooks
>>>    migration/rdma: Move rdma constants from qemu-file.h to rdma.h
>>>    migration/rdma: Remove qemu_ prefix from exported functions
>>>    migration/rdma: Check sooner if we are in postcopy for save_page()
>>> Vladimir Sementsov-Ogievskiy (5):
>>>    runstate: add runstate_get()
>>>    migration: never fail in global_state_store()
>>>    runstate: drop unused runstate_store()
>>>    migration: switch from .vm_was_running to .vm_old_state
>>>    migration: restore vmstate on migration failure
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
>> qemu-system-aarch64: Not a migration stream
>> qemu-system-aarch64: load of migration failed: Invalid argument

And now I am stuck here.  Neither migration-test or avocado test
migration-rdma, so clearly I broke something that don't show on
migration-test but shows on avocado.

Still trying to get avocado to behave on my local test machine.

Later, Juan.


>> Broken pipe
>
> And as it couldn't be anyother way, on my machine (with upstream qemu,
> i.e. none of my changes in):
>
> $ make check-avocado (check-acceptance fails in the same test)
>
> ...
>
> STARTED
>  (063/243) tests/avocado/kvm_xen_guest.py:KVMXenGuest.test_kvm_xen_guest_nomsi: ERROR: ConnectError: Failed to establish session: EOFError\n	Exit code: 1\n	Command: ./qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,fd=9 -mon chardev=mon,mode=control -machine q35 -chardev socket,id=console,path=/var/tmp/qemu_yv2aqehm/7f8b6cf5... (2.52 s)
> Interrupting job (failfast).
> RESULTS    : PASS 42 | ERROR 1 | FAIL 0 | SKIP 199 | WARN 0 | INTERRUPT 0 | CANCEL 1
> JOB TIME   : 71.66 s
>
> Test summary:
> tests/avocado/kvm_xen_guest.py:KVMXenGuest.test_kvm_xen_guest_nomsi: ERROR
> make: *** [/mnt/code/qemu/full/tests/Makefile.include:142: check-avocado] Error 9
>
>
> the good news:  Some tests passed.  sixty something.
> the bad news: it is failing on kvm xen guest and I have no clue
>               why/where.
>
> Is there some documentation that can help me here?
>
> Thanks, Juan.


