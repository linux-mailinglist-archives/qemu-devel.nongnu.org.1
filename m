Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EC6719388
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 08:48:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4c6X-0007KZ-3N; Thu, 01 Jun 2023 02:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4c6T-0007BJ-1X
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 02:48:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4c6P-0007O7-60
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 02:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685602083;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4mX5BSvjnhNdT6QruSiKGvQWOIneQgpb1KEfixalPdA=;
 b=RA+jgIhhapF0iH6IdJBMQAT1RJCRqhdmk/0qzO8p6h/5JBd5FVB0p3EwiFHW3+uujgZP0U
 aVbygsSRttwIiNJQHKrSMD+rNvYb2ZnID/N38yir7c1gAxjLiXhQXA8Vd8Rtsw/jXcwnMU
 UEQVtB42YUV6Sts1AkNoIL9VM0tbk+M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-IdCSfhNWNV2nN6lcvDvFsQ-1; Thu, 01 Jun 2023 02:48:02 -0400
X-MC-Unique: IdCSfhNWNV2nN6lcvDvFsQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5fc8581a9so3243165e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 23:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685602080; x=1688194080;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4mX5BSvjnhNdT6QruSiKGvQWOIneQgpb1KEfixalPdA=;
 b=Dw6NrNocuqnNlUHoxm+ynCYRa0LSZERMO1zwtHhzXjuRoI+a9cqrPH+33B9Vr9WHi9
 gUkZbvpjUJVbfwsxwHCoCd2fx263brqoIj/GkGphlhYbbeFM8I5sqcXUq5fyRYswSA4q
 sj9HfLiPr5KJZa8UR2X+6iUL+JGwj3Qz31YZ1N/y8FctuVhHjQeTCbYYxqeU+oUF7yaL
 kH26zkYydxKhCJaTTgbRF8frhZVs01SLvv2fz88cnyqJuxhC8iPl1Qhj8efTnYDT4TUz
 Rl457V/IL86UPrP4iH1DpWq6jlwQtLsKwAo8Xgp0X3coUvC+Y+Gf547aCX47yD4C8jE2
 TI0w==
X-Gm-Message-State: AC+VfDy3RMZPcLH1okz5GMj9P5rlz0M9r+pGGwDOPh+wn1KF5btCl9/1
 dKkPXv5Rj51/c1tcxKcYWDqcQPBNIXzrtTLJwPv2Hnf+4z3Ol1o2vf9uX29tpQUffKCjuznr+EN
 iv+5Kf86YLAjtHCA=
X-Received: by 2002:a05:600c:2142:b0:3f4:fffc:add with SMTP id
 v2-20020a05600c214200b003f4fffc0addmr1254995wml.27.1685602080741; 
 Wed, 31 May 2023 23:48:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4d9U3zdy29B6ujcAoW0bPluUxjpIRq0PrFgdAFY6fkGOeTrN0GbIavSr/MRqywvFE2nMZk+A==
X-Received: by 2002:a05:600c:2142:b0:3f4:fffc:add with SMTP id
 v2-20020a05600c214200b003f4fffc0addmr1254987wml.27.1685602080388; 
 Wed, 31 May 2023 23:48:00 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 f9-20020a1cc909000000b003f42461ac75sm1138923wmb.12.2023.05.31.23.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 23:47:59 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Daniel Berrange <berrange@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  qemu-devel@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Peter Xu
 <peterx@redhat.com>
Subject: Re: [PULL 00/21] Migration 20230530 patches
In-Reply-To: <55e7265e-26c8-8220-01af-65aa36cef854@linaro.org> (Richard
 Henderson's message of "Wed, 31 May 2023 14:28:22 -0700")
References: <20230530182531.6371-1-quintela@redhat.com>
 <cba70806-7186-fdb2-1ebd-2056871c6bc7@linaro.org>
 <87mt1ktdr8.fsf@secure.mitica>
 <55e7265e-26c8-8220-01af-65aa36cef854@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 01 Jun 2023 08:47:58 +0200
Message-ID: <87ilc7u19d.fsf@secure.mitica>
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

Richard Henderson <richard.henderson@linaro.org> wrote:
> On 5/31/23 14:03, Juan Quintela wrote:
>> Richard Henderson <richard.henderson@linaro.org> wrote:
>>> On 5/30/23 11:25, Juan Quintela wrote:
>>>> The following changes since commit aa9bbd865502ed517624ab6fe7d4b5d89ca95e43:
>>>>     Merge tag 'pull-ppc-20230528' of https://gitlab.com/danielhb/qemu
>>>> into staging (2023-05-29 14:31:52 -0700)
>>>> are available in the Git repository at:
>>>>     https://gitlab.com/juan.quintela/qemu.git
>>>> tags/migration-20230530-pull-request
>>>> for you to fetch changes up to
>>>> c63c544005e6b1375a9c038f0e0fb8dfb8b249f4:
>>>>     migration/rdma: Check sooner if we are in postcopy for
>>>> save_page() (2023-05-30 19:23:50 +0200)
>>>> ----------------------------------------------------------------
>> Added Markus and Daniel.
>> 
>>>> Migration 20230530 Pull request (take 2)
>>>> Hi
>>>> Resend last PULL request, this time it compiles when CONFIG_RDMA is
>>>> not configured in.
>>>> [take 1]
>>>> On this PULL request:
>>>> - Set vmstate migration failure right (vladimir)
>>>> - Migration QEMUFileHook removal (juan)
>>>> - Migration Atomic counters (juan)
>>>> Please apply.
>>>> ----------------------------------------------------------------
>>>> Juan Quintela (16):
>>>>     migration: Don't abuse qemu_file transferred for RDMA
>>>>     migration/RDMA: It is accounting for zero/normal pages in two places
>>>>     migration/rdma: Remove QEMUFile parameter when not used
>>>>     migration/rdma: Don't use imaginary transfers
>>>>     migration: Remove unused qemu_file_credit_transfer()
>>>>     migration/rdma: Simplify the function that saves a page
>>>>     migration: Create migrate_rdma()
>>>>     migration/rdma: Unfold ram_control_before_iterate()
>>>>     migration/rdma: Unfold ram_control_after_iterate()
>>>>     migration/rdma: Remove all uses of RAM_CONTROL_HOOK
>>>>     migration/rdma: Unfold hook_ram_load()
>>>>     migration/rdma: Create rdma_control_save_page()
>>>>     qemu-file: Remove QEMUFileHooks
>>>>     migration/rdma: Move rdma constants from qemu-file.h to rdma.h
>>>>     migration/rdma: Remove qemu_ prefix from exported functions
>>>>     migration/rdma: Check sooner if we are in postcopy for save_page()
>>>> Vladimir Sementsov-Ogievskiy (5):
>>>>     runstate: add runstate_get()
>>>>     migration: never fail in global_state_store()
>>>>     runstate: drop unused runstate_store()
>>>>     migration: switch from .vm_was_running to .vm_old_state
>>>>     migration: restore vmstate on migration failure
>>>
>>> Appears to introduce multiple avocado failures:
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/4378066518#L286
>>>
>>> Test summary:
>>> tests/avocado/migration.py:X86_64.test_migration_with_exec: ERROR
>>> tests/avocado/migration.py:X86_64.test_migration_with_tcp_localhost: ERROR
>>> tests/avocado/migration.py:X86_64.test_migration_with_unix: ERROR
>>> make: *** [/builds/qemu-project/qemu/tests/Makefile.include:142:
>>> check-avocado] Error 1
>>> https://gitlab.com/qemu-project/qemu/-/jobs/4378066523#L387
>>>
>>> Test summary:
>>> tests/avocado/migration.py:X86_64.test_migration_with_tcp_localhost: ERROR
>>> tests/avocado/migration.py:X86_64.test_migration_with_unix: ERROR
>>> make: *** [/builds/qemu-project/qemu/tests/Makefile.include:142: check-avocado] Error 1
>>>
>>> Also fails QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/migration-test
>>>
>>> ../src/migration/rdma.c:408:QIO_CHANNEL_RDMA: Object 0xaaaaf7bba680 is
>>> not an instance of type qio-channel-rdma
>> I am looking at the other errors, but this one is weird.  It is
>> failing
>> here:
>> #define TYPE_QIO_CHANNEL_RDMA "qio-channel-rdma"
>> OBJECT_DECLARE_SIMPLE_TYPE(QIOChannelRDMA, QIO_CHANNEL_RDMA)
>> In the OBJECT line.
>> I have no clue what problem are we having here with the object
>> system to
>> decide at declaration time that a variable is not of the type that we
>> are declaring.
>> I am missing something obvious here?
>
> This is where the inline function is declared, but you need to look at
> the backtrace, where you have applied QIO_CHANNEL_RDMA to an object
> that is *not* of that type.

Where is the stack trace?

Are you running aarch64 natively?  Here running qemu-system-aarch64 on
x86_64 works for me.  Neither avocado test nor migration-test fails with
my changes.

Cleber found the reason why I was having trouble running avocado
locally.  It appears that some change happened and there are several
tests that can't be run in parallel.  (Temporary) solution is to run it
as:

make -j1 check-avocado

Until they sort which tests are/aren't able to run in parallel.

Later, Juan.



