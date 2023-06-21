Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A93738BE1
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:45:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC0xK-0004bd-Pn; Wed, 21 Jun 2023 12:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qC0xI-0004Qc-2p
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qC0xF-0005iy-SD
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687365913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xepbEds4CEaVbgoqGo/9K/EbGxO+wvJQL3akdBZF0o0=;
 b=iw6jcabGdytMWGHdAiw5YnGiUE0jJd2M4e5Rc3YmRYlOGc34ssnSx6+44i6VzmTQbzxz9q
 9coJqkGvFjNZBQg8Z3n036xp5f4KLVrysJsaedaT7s422zrs934ad3jh2W/uCghqblW39G
 LmJ76D04UvUkg5DdE1aPF/ltj/yc1w0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-hL3aIzIzMQWRLQYKCbPTjw-1; Wed, 21 Jun 2023 12:45:12 -0400
X-MC-Unique: hL3aIzIzMQWRLQYKCbPTjw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7639e09a3a8so69004285a.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 09:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687365911; x=1689957911;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xepbEds4CEaVbgoqGo/9K/EbGxO+wvJQL3akdBZF0o0=;
 b=bVZ0xSXvbZNtWD2tUd2RC9sfayFvYKo3DkAHQlxFnGd+0k7vG726FNml5BVn6U3fFf
 +G645zl/16JhknFj4AG2CiFN5DWw6G3nUt4N3US3qS69x1VDx4QD485lHSo9QrxFDxyy
 VQg75bU4FcbxhvTbwO/ukswDyvW0eTmfluzZsyry2AtWX5J9gWrW0Uz7kIvY+UJMPKUN
 Ki829da+Tkxm+VscWX3/5DlaIquNB4YbPj5Mqf8oOFJGdKriHkt15LTKvbm19P5blIpZ
 4c7COAxsWr+DQ3CEnUXQwpChENBbqL4p4qP8ooHLFiD+IE9KdxQ7zY6LurGumRM9TU1H
 XQkg==
X-Gm-Message-State: AC+VfDw+u1we3yYRn4Ocstf3m4dJqRTlcbwmHElI+p0VMJNasRQ46W/w
 EggzeW2aaA3c5ZmWfs6mcSPrVEdCTouC9pUMwNmLf/vGA53wLyVodsIB1Oxe6frlcRKBq01j9FJ
 KDa+ILv/BDCumkvk=
X-Received: by 2002:a05:620a:2786:b0:762:7e50:ac06 with SMTP id
 g6-20020a05620a278600b007627e50ac06mr11676961qkp.4.1687365911407; 
 Wed, 21 Jun 2023 09:45:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6oQTEN0NmCCCPknNQ5kTT+XJLwCXNnGk5gs0QCvpRfxkq/bjbDmxHcj7NYr6yxYeOyhTxNmQ==
X-Received: by 2002:a05:620a:2786:b0:762:7e50:ac06 with SMTP id
 g6-20020a05620a278600b007627e50ac06mr11676953qkp.4.1687365911006; 
 Wed, 21 Jun 2023 09:45:11 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 f19-20020a05620a069300b00763a96b37absm2425809qkh.43.2023.06.21.09.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 09:45:10 -0700 (PDT)
Date: Wed, 21 Jun 2023 12:45:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V1 3/3] tests/qtest: live migration suspended state
Message-ID: <ZJMpFfetFkZ/QjfT@x1n>
References: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
 <1686860800-34667-4-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1686860800-34667-4-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 15, 2023 at 01:26:40PM -0700, Steve Sistare wrote:
> Add a test case to verify that the suspended state is handled correctly in
> live migration.  The test suspends the src, migrates, then wakes the dest.
> 
> Add an option to suspend the src in a-b-bootblock.S, which puts the guest
> in S3 state after one round of writing to memory.  The option is enabled by
> poking a 1 into the suspend_me word in the boot block prior to starting the
> src vm.  Generate symbol offsets in a-b-bootblock.h so that the suspend_me
> offset is known.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Thanks for the test case, mostly good to me, a few trivial comments /
questions below.

> ---
>  tests/migration/i386/Makefile        |  5 ++--
>  tests/migration/i386/a-b-bootblock.S | 49 +++++++++++++++++++++++++++++++++---
>  tests/migration/i386/a-b-bootblock.h | 22 ++++++++++------
>  tests/qtest/migration-helpers.c      |  2 +-
>  tests/qtest/migration-test.c         | 31 +++++++++++++++++++++--
>  5 files changed, 92 insertions(+), 17 deletions(-)
> 
> diff --git a/tests/migration/i386/Makefile b/tests/migration/i386/Makefile
> index 5c03241..37a72ae 100644
> --- a/tests/migration/i386/Makefile
> +++ b/tests/migration/i386/Makefile
> @@ -4,9 +4,10 @@
>  .PHONY: all clean
>  all: a-b-bootblock.h
>  
> -a-b-bootblock.h: x86.bootsect
> +a-b-bootblock.h: x86.bootsect x86.o
>  	echo "$$__note" > header.tmp
>  	xxd -i $< | sed -e 's/.*int.*//' >> header.tmp
> +	nm x86.o | awk '{print "#define SYM_"$$3" 0x"$$1}' >> header.tmp
>  	mv header.tmp $@
>  
>  x86.bootsect: x86.boot
> @@ -16,7 +17,7 @@ x86.boot: x86.o
>  	$(CROSS_PREFIX)objcopy -O binary $< $@
>  
>  x86.o: a-b-bootblock.S
> -	$(CROSS_PREFIX)gcc -m32 -march=i486 -c $< -o $@
> +	$(CROSS_PREFIX)gcc -I.. -m32 -march=i486 -c $< -o $@
>  
>  clean:
>  	@rm -rf *.boot *.o *.bootsect
> diff --git a/tests/migration/i386/a-b-bootblock.S b/tests/migration/i386/a-b-bootblock.S
> index 3d464c7..63d446f 100644
> --- a/tests/migration/i386/a-b-bootblock.S
> +++ b/tests/migration/i386/a-b-bootblock.S
> @@ -9,6 +9,21 @@
>  #
>  # Author: dgilbert@redhat.com
>  
> +#include "migration-test.h"
> +
> +#define ACPI_ENABLE         0xf1
> +#define ACPI_PORT_SMI_CMD   0xb2
> +#define ACPI_PM_BASE        0x600
> +#define PM1A_CNT_OFFSET     4
> +
> +#define ACPI_SCI_ENABLE     0x0001
> +#define ACPI_SLEEP_TYPE     0x0400
> +#define ACPI_SLEEP_ENABLE   0x2000
> +#define SLEEP (ACPI_SCI_ENABLE + ACPI_SLEEP_TYPE + ACPI_SLEEP_ENABLE)
> +
> +#define LOW_ADDR            X86_TEST_MEM_START
> +#define HIGH_ADDR           X86_TEST_MEM_END
> +#define suspended           HIGH_ADDR
>  
>  .code16
>  .org 0x7c00
> @@ -41,12 +56,11 @@ start:             # at 0x7c00 ?
>          # bl keeps a counter so we limit the output speed
>          mov $0, %bl
>  mainloop:
> -        # Start from 1MB
> -        mov $(1024*1024),%eax
> +        mov $LOW_ADDR,%eax
>  innerloop:
>          incb (%eax)
>          add $4096,%eax
> -        cmp $(100*1024*1024),%eax
> +        cmp $HIGH_ADDR,%eax
>          jl innerloop
>  
>          inc %bl
> @@ -57,7 +71,30 @@ innerloop:
>          mov $0x3f8,%dx
>          outb %al,%dx
>  
> -        jmp mainloop
> +        # should this test suspend?
> +        mov (suspend_me),%eax
> +        cmp $0,%eax
> +        je mainloop
> +
> +        # are we waking after suspend?  do not suspend again.
> +        mov $suspended,%eax

So IIUC then it'll use 4 bytes over 100MB range which means we need at
least 100MB+4bytes.. not obvious for a HIGH_ADDR definition to me..

Could we just define a variable inside the section like suspend_me?

> +        mov (%eax),%eax
> +        cmp $1,%eax
> +        je mainloop
> +
> +        # enable acpi
> +        mov $ACPI_ENABLE,%al
> +        outb %al,$ACPI_PORT_SMI_CMD
> +
> +        # suspend to ram
> +        mov $suspended,%eax
> +        movl $1,(%eax)
> +        mov $SLEEP,%ax
> +        mov $(ACPI_PM_BASE + PM1A_CNT_OFFSET),%dx
> +        outw %ax,%dx
> +        # not reached.  The wakeup causes reset and restart at 0x7c00, and we
> +        # do not save and restore registers as a real kernel would do.
> +
>  
>          # GDT magic from old (GPLv2)  Grub startup.S
>          .p2align        2       /* force 4-byte alignment */
> @@ -83,6 +120,10 @@ gdtdesc:
>          .word   0x27                    /* limit */
>          .long   gdt                     /* addr */
>  
> +        /* test launcher can poke a 1 here to exercise suspend */
> +suspend_me:
> +        .int  0
> +
>  /* I'm a bootable disk */
>  .org 0x7dfe
>          .byte 0x55
> diff --git a/tests/migration/i386/a-b-bootblock.h b/tests/migration/i386/a-b-bootblock.h
> index b7b0fce..b39773f 100644
> --- a/tests/migration/i386/a-b-bootblock.h
> +++ b/tests/migration/i386/a-b-bootblock.h
> @@ -4,20 +4,20 @@
>   * the header and the assembler differences in your patch submission.
>   */
>  unsigned char x86_bootsect[] = {
> -  0xfa, 0x0f, 0x01, 0x16, 0x78, 0x7c, 0x66, 0xb8, 0x01, 0x00, 0x00, 0x00,
> +  0xfa, 0x0f, 0x01, 0x16, 0xa4, 0x7c, 0x66, 0xb8, 0x01, 0x00, 0x00, 0x00,
>    0x0f, 0x22, 0xc0, 0x66, 0xea, 0x20, 0x7c, 0x00, 0x00, 0x08, 0x00, 0x00,
>    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xe4, 0x92, 0x0c, 0x02,
>    0xe6, 0x92, 0xb8, 0x10, 0x00, 0x00, 0x00, 0x8e, 0xd8, 0x66, 0xb8, 0x41,
>    0x00, 0x66, 0xba, 0xf8, 0x03, 0xee, 0xb3, 0x00, 0xb8, 0x00, 0x00, 0x10,
>    0x00, 0xfe, 0x00, 0x05, 0x00, 0x10, 0x00, 0x00, 0x3d, 0x00, 0x00, 0x40,
>    0x06, 0x7c, 0xf2, 0xfe, 0xc3, 0x80, 0xe3, 0x3f, 0x75, 0xe6, 0x66, 0xb8,
> -  0x42, 0x00, 0x66, 0xba, 0xf8, 0x03, 0xee, 0xeb, 0xdb, 0x8d, 0x76, 0x00,
> -  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00,
> -  0x00, 0x9a, 0xcf, 0x00, 0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00,
> -  0x27, 0x00, 0x60, 0x7c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x42, 0x00, 0x66, 0xba, 0xf8, 0x03, 0xee, 0xa1, 0xaa, 0x7c, 0x00, 0x00,
> +  0x83, 0xf8, 0x00, 0x74, 0xd3, 0xb8, 0x00, 0x00, 0x40, 0x06, 0x8b, 0x00,
> +  0x83, 0xf8, 0x01, 0x74, 0xc7, 0xb0, 0xf1, 0xe6, 0xb2, 0xb8, 0x00, 0x00,
> +  0x40, 0x06, 0xc7, 0x00, 0x01, 0x00, 0x00, 0x00, 0x66, 0xb8, 0x01, 0x24,
> +  0x66, 0xba, 0x04, 0x06, 0x66, 0xef, 0x66, 0x90, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xcf, 0x00,
> +  0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00, 0x27, 0x00, 0x8c, 0x7c,
>    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> @@ -49,3 +49,9 @@ unsigned char x86_bootsect[] = {
>    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xaa
>  };
>  
> +#define SYM_gdt 0x00007c8c
> +#define SYM_gdtdesc 0x00007ca4
> +#define SYM_innerloop 0x00007c3d
> +#define SYM_mainloop 0x00007c38
> +#define SYM_start 0x00007c00
> +#define SYM_suspend_me 0x00007caa
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index be00c52..433d678 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -28,7 +28,7 @@ bool migrate_watch_for_stop(QTestState *who, const char *name,
>  {
>      bool *seen = opaque;
>  
> -    if (g_str_equal(name, "STOP")) {
> +    if (g_str_equal(name, "STOP") || g_str_equal(name, "SUSPEND")) {
>          *seen = true;

This is also a bit hachish.. "*seen" points to got_src_stop, so when
SUSPEND it'll set got_src_stop.  It's not clear what stage we're in even if
that's set, irrelevant of the confusing naming after being able to SUSPEND.

Shall we just add one got_src_suspended here and explicitly check that when
suspend=true in test?

>          return true;
>      }
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index b0c355b..73b07b3 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -121,7 +121,7 @@ static void init_bootfile(const char *bootpath, void *content, size_t len)
>  /*
>   * Wait for some output in the serial output file,
>   * we get an 'A' followed by an endless string of 'B's
> - * but on the destination we won't have the A.
> + * but on the destination we won't have the A (unless we enabled suspend/resume)
>   */
>  static void wait_for_serial(const char *side)
>  {
> @@ -507,6 +507,8 @@ typedef struct {
>      bool use_dirty_ring;
>      const char *opts_source;
>      const char *opts_target;
> +    /* suspend the src before migrating to dest. */
> +    bool suspend;
>  } MigrateStart;
>  
>  /*
> @@ -617,6 +619,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          }
>      }
>  
> +    x86_bootsect[SYM_suspend_me - SYM_start] = args->suspend;
> +
>      got_src_stop = false;
>      got_dst_resume = false;
>      bootpath = g_strdup_printf("%s/bootsect", tmpfs);
> @@ -1475,7 +1479,13 @@ static void test_precopy_common(MigrateCommon *args)
>               */
>              wait_for_migration_complete(to);
>  
> -            qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
> +            if (!args->start.suspend) {
> +                qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
> +            }

This is live==false path, if this test needs live=true then afaict this
path won't ever trigger.

Even if it triggers, "qmp_cont" skips for SUSPEND already, so I assume
we're fine.

> +        }
> +
> +        if (args->start.suspend) {
> +            qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");

Okay I did look up qmp_system_wakeup and I think it implicitly checks the
SUSPEND status, which is reasonable but not obvious.  Not sure whether
that's intended.

Shall we just check it explicitly with a query-status, even if so?

If keeping relying on qmp_system_wakeup not failing, I suggest we add a
comment explaining that this explicitly checks machine state so we're sure
the SUSPEND state is migrated properly.

>          }
>  
>          if (!got_dst_resume) {
> @@ -1508,6 +1518,18 @@ static void test_precopy_unix_plain(void)
>      test_precopy_common(&args);
>  }
>  
> +static void test_precopy_unix_suspend(void)
> +{
> +    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> +    MigrateCommon args = {
> +        .listen_uri = uri,
> +        .connect_uri = uri,
> +        .live = true,

We need explicit comment for all .live=true cases to state why.  Please
refer to:

    /*
     * Optional: whether the guest CPUs should be running during a precopy
     * migration test.  We used to always run with live but it took much
     * longer so we reduced live tests to only the ones that have solid
     * reason to be tested live-only.  For each of the new test cases for
     * precopy please provide justifications to use live explicitly (please
     * refer to existing ones with live=true), or use live=off by default.
     */
    bool live;

Thanks,

> +        .start.suspend = true,
> +    };
> +
> +    test_precopy_common(&args);
> +}
>  
>  static void test_precopy_unix_dirty_ring(void)
>  {
> @@ -2682,6 +2704,11 @@ int main(int argc, char **argv)
>  
>      module_call_init(MODULE_INIT_QOM);
>  
> +    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> +        qtest_add_func("/migration/precopy/unix/suspend",
> +                       test_precopy_unix_suspend);
> +    }
> +
>      if (has_uffd) {
>          qtest_add_func("/migration/postcopy/plain", test_postcopy);
>          qtest_add_func("/migration/postcopy/recovery/plain",
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


