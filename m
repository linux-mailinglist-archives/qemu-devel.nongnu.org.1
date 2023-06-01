Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C45719B1C
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:47:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4glv-0001iD-DQ; Thu, 01 Jun 2023 07:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4glr-0001gE-VV
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4glo-0007jW-JZ
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620024;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mkj5gGcRN8UBnIm5rKyUkKtXkqW3H7T8NJReb1lnlMk=;
 b=WmC0S5wL1U/wProSqIL+L45Em+s4pyGj+R73k/NnE8j9x6TX1qqGemb7NlMdo1CO7j9ZvG
 elmQYdIGydNuymCcIW7kKJ7iXzWyX+V5jHZN+6ChJfUyluYYH+aFCuSxsT654EwjtVk1zl
 KfKs9K5STIeoO3FrGVjb7Ns+rYTRorQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-YCk40EiUOrG9_eTJbwFJMA-1; Thu, 01 Jun 2023 07:47:03 -0400
X-MC-Unique: YCk40EiUOrG9_eTJbwFJMA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30c2e9541b9so452491f8f.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620022; x=1688212022;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mkj5gGcRN8UBnIm5rKyUkKtXkqW3H7T8NJReb1lnlMk=;
 b=IGBLb0MfTPYZJhmlWRzisgwoz+dlLkOJi4kM3y4oO8KpppoDqSXyyHa59E4EOim660
 aHL1awN1/MhnCVk28XgaG6H36vs0F/L1n2Xb3MyLmAEjAlJaIUIM59sZiM0TumzqQfyo
 L9SvlI3craaCvv2sdU5Jezv7tVD0NZshvJA/UXMRYb33VecxdqEpSPH6akHrCHZlvozg
 grAycObjARkX2ljUDEIW53nF44vELxv8jkVTON3GUk+yhfCuJUwhvmsoixxQPROlG180
 A0hU0YjTHEl43SDhbjLhe0fcHwQLVuyLrK0oFCOdI604DxnzycuVRyKFm+o+z3fs4Jwi
 m/rg==
X-Gm-Message-State: AC+VfDwELSEyQf/REerpDwWmsnu16NoamB7iPr0FIoFT54G855bqJKDE
 Cj3i/nUjfs/woPYRIMHzFbHS/wr5ruNJEgOnV07ahYxZBpHkAKcVflnVWaMBo/iW2SH4SN9odQe
 3QnrbyQ5UXAS/DPY=
X-Received: by 2002:a05:6000:1191:b0:300:cb8c:fd8f with SMTP id
 g17-20020a056000119100b00300cb8cfd8fmr1427614wrx.54.1685620021849; 
 Thu, 01 Jun 2023 04:47:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7p6XtkpY4US1Q+sZdTo7gZ+G18EkfNyjpSteXvLF+xy9ynM8DdFsB/AhCmGBF//B6bZg+NZQ==
X-Received: by 2002:a05:6000:1191:b0:300:cb8c:fd8f with SMTP id
 g17-20020a056000119100b00300cb8cfd8fmr1427595wrx.54.1685620021501; 
 Thu, 01 Jun 2023 04:47:01 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 h4-20020adfe984000000b002fe96f0b3acsm10191932wrm.63.2023.06.01.04.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:47:00 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Markus Armbruster
 <armbru@redhat.com>,  qemu-devel@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Peter Xu
 <peterx@redhat.com>
Subject: Re: [PULL 00/21] Migration 20230530 patches
In-Reply-To: <ZHhfYMuk69mA+FqM@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 1 Jun 2023 10:05:36 +0100")
References: <20230530182531.6371-1-quintela@redhat.com>
 <cba70806-7186-fdb2-1ebd-2056871c6bc7@linaro.org>
 <87mt1ktdr8.fsf@secure.mitica> <ZHhWXSU3vvobddP2@redhat.com>
 <ZHhfYMuk69mA+FqM@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 01 Jun 2023 13:46:59 +0200
Message-ID: <87edmvtnf0.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Thu, Jun 01, 2023 at 09:27:09AM +0100, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, May 31, 2023 at 11:03:23PM +0200, Juan Quintela wrote:
>> > Richard Henderson <richard.henderson@linaro.org> wrote:
>> > > On 5/30/23 11:25, Juan Quintela wrote:
>> > >> The following changes since commit aa9bbd865502ed517624ab6fe7d4b5d8=
9ca95e43:
>> > >>    Merge tag 'pull-ppc-20230528' of https://gitlab.com/danielhb/qemu
>> > >> into staging (2023-05-29 14:31:52 -0700)
>> > >> are available in the Git repository at:
>> > >>    https://gitlab.com/juan.quintela/qemu.git
>> > >> tags/migration-20230530-pull-request
>> > >> for you to fetch changes up to
>> > >> c63c544005e6b1375a9c038f0e0fb8dfb8b249f4:
>> > >>    migration/rdma: Check sooner if we are in postcopy for
>> > >> save_page() (2023-05-30 19:23:50 +0200)
>> > >> ----------------------------------------------------------------
>> >=20
>> > Added Markus and Daniel.
>> >=20
>> > >> Migration 20230530 Pull request (take 2)
>> > >> Hi
>> > >> Resend last PULL request, this time it compiles when CONFIG_RDMA is
>> > >> not configured in.
>> > >> [take 1]
>> > >> On this PULL request:
>> > >> - Set vmstate migration failure right (vladimir)
>> > >> - Migration QEMUFileHook removal (juan)
>> > >> - Migration Atomic counters (juan)
>> > >> Please apply.
>> > >> ----------------------------------------------------------------
>> > >> Juan Quintela (16):
>> > >>    migration: Don't abuse qemu_file transferred for RDMA
>> > >>    migration/RDMA: It is accounting for zero/normal pages in two pl=
aces
>> > >>    migration/rdma: Remove QEMUFile parameter when not used
>> > >>    migration/rdma: Don't use imaginary transfers
>> > >>    migration: Remove unused qemu_file_credit_transfer()
>> > >>    migration/rdma: Simplify the function that saves a page
>> > >>    migration: Create migrate_rdma()
>> > >>    migration/rdma: Unfold ram_control_before_iterate()
>> > >>    migration/rdma: Unfold ram_control_after_iterate()
>> > >>    migration/rdma: Remove all uses of RAM_CONTROL_HOOK
>> > >>    migration/rdma: Unfold hook_ram_load()
>> > >>    migration/rdma: Create rdma_control_save_page()
>> > >>    qemu-file: Remove QEMUFileHooks
>> > >>    migration/rdma: Move rdma constants from qemu-file.h to rdma.h
>> > >>    migration/rdma: Remove qemu_ prefix from exported functions
>> > >>    migration/rdma: Check sooner if we are in postcopy for save_page=
()
>> > >> Vladimir Sementsov-Ogievskiy (5):
>> > >>    runstate: add runstate_get()
>> > >>    migration: never fail in global_state_store()
>> > >>    runstate: drop unused runstate_store()
>> > >>    migration: switch from .vm_was_running to .vm_old_state
>> > >>    migration: restore vmstate on migration failure
>> > >
>> > > Appears to introduce multiple avocado failures:
>> > >
>> > > https://gitlab.com/qemu-project/qemu/-/jobs/4378066518#L286
>> > >
>> > > Test summary:
>> > > tests/avocado/migration.py:X86_64.test_migration_with_exec: ERROR
>> > > tests/avocado/migration.py:X86_64.test_migration_with_tcp_localhost:=
 ERROR
>> > > tests/avocado/migration.py:X86_64.test_migration_with_unix: ERROR
>> > > make: *** [/builds/qemu-project/qemu/tests/Makefile.include:142: che=
ck-avocado] Error 1
>> > >
>> > > https://gitlab.com/qemu-project/qemu/-/jobs/4378066523#L387
>> > >
>> > > Test summary:
>> > > tests/avocado/migration.py:X86_64.test_migration_with_tcp_localhost:=
 ERROR
>> > > tests/avocado/migration.py:X86_64.test_migration_with_unix: ERROR
>> > > make: *** [/builds/qemu-project/qemu/tests/Makefile.include:142: che=
ck-avocado] Error 1
>> > >
>> > > Also fails QTEST_QEMU_BINARY=3D./qemu-system-aarch64 ./tests/qtest/m=
igration-test
>> > >
>> > > ../src/migration/rdma.c:408:QIO_CHANNEL_RDMA: Object 0xaaaaf7bba680 =
is
>> > > not an instance of type qio-channel-rdma
>> >=20
>> > I am looking at the other errors, but this one is weird.  It is failing
>> > here:
>> >=20
>> > #define TYPE_QIO_CHANNEL_RDMA "qio-channel-rdma"
>> > OBJECT_DECLARE_SIMPLE_TYPE(QIOChannelRDMA, QIO_CHANNEL_RDMA)
>> >=20
>> > In the OBJECT line.
>> >=20
>> > I have no clue what problem are we having here with the object system =
to
>> > decide at declaration time that a variable is not of the type that we
>> > are declaring.
>> >=20
>> > I am missing something obvious here?
>>=20
>> I expect somewhere in the code has either corrupted memory, or is
>> using free'd memory. Either way you'll need to get a stack trace
>> to debug this kind of thing
>
> I've replied to the patches pointing out 4 places where the code
> casts to QIOChannelRDMA, without first checking that this is an
> RDMA migration, which look likely to be the cause of this.

Good catch.

I can only say: Ouch.

And why it don't failed for me.  It passes for me:
- make check (compiled every target/device/... that can be compiled on
  Fedora38)

- I tested hundreds of times migration-test during development, never
  failed like that

- I am switching to test aarch64 tcg as main target, because it appears
  it finds way more bugs on migration-tests.

Thanks again.

Later, Juan.


