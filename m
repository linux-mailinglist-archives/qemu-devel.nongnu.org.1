Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A4C85EA34
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 22:25:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcu5C-0006Xs-CH; Wed, 21 Feb 2024 16:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcu4z-0006L3-HV
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:24:37 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcu4x-0002iC-AF
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:24:37 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A1C9522007;
 Wed, 21 Feb 2024 21:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708550672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lrorlbSpBm+dq3CWaxvi57HwC9Ggxdw+2DsdUV6rSFA=;
 b=szDkeZqGNxgt9VcYfyS5oq64X83A+sE4BqhLzplT/tVKY9/GpPApqHejun4g4/qihEQhuy
 1hY1DeV/ZjtwZMEQQ3Q+0VGr6/YGHyLxEKY2+QGuLteDAZa6k8NMhlyL9YIisdsugrKK3/
 Bxsfbcb7jgI8VYAsDxFWAcVud3VoMEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708550672;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lrorlbSpBm+dq3CWaxvi57HwC9Ggxdw+2DsdUV6rSFA=;
 b=WgX365LXlV9qe8poamrOjcBTXF8izNWhzkSTAz2xTzG6I91N9xYRvFVDWLKRPL6Y4b/BoE
 BSWiZAkFqo+DI2CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708550672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lrorlbSpBm+dq3CWaxvi57HwC9Ggxdw+2DsdUV6rSFA=;
 b=szDkeZqGNxgt9VcYfyS5oq64X83A+sE4BqhLzplT/tVKY9/GpPApqHejun4g4/qihEQhuy
 1hY1DeV/ZjtwZMEQQ3Q+0VGr6/YGHyLxEKY2+QGuLteDAZa6k8NMhlyL9YIisdsugrKK3/
 Bxsfbcb7jgI8VYAsDxFWAcVud3VoMEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708550672;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lrorlbSpBm+dq3CWaxvi57HwC9Ggxdw+2DsdUV6rSFA=;
 b=WgX365LXlV9qe8poamrOjcBTXF8izNWhzkSTAz2xTzG6I91N9xYRvFVDWLKRPL6Y4b/BoE
 BSWiZAkFqo+DI2CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2962D139D0;
 Wed, 21 Feb 2024 21:24:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a+DqOA9q1mUEYgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 21 Feb 2024 21:24:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>, Peter Xu
 <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 5/5] tests: Add migration test for loongarch64
In-Reply-To: <20240220124126.1164081-6-maobibo@loongson.cn>
References: <20240220124126.1164081-1-maobibo@loongson.cn>
 <20240220124126.1164081-6-maobibo@loongson.cn>
Date: Wed, 21 Feb 2024 18:24:29 -0300
Message-ID: <87zfvta4tu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=szDkeZqG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WgX365LX
X-Spamd-Result: default: False [-3.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-3.00)[100.00%]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A1C9522007
X-Spam-Score: -3.31
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Bibo Mao <maobibo@loongson.cn> writes:

> This patch adds migration test support for loongarch64. The test code
> comes from aarch64 mostly, only that it it booted as bios in qemu since
> kernel requires elf format and bios uses binary format.
>
> In addition to providing the binary, this patch also includes the source
> code and the build script in tests/migration/loongarch64. So users can
> change the source and/or re-compile the binary as they wish.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>

Just a nit below.

Reviewed-by: Fabiano Rosas <farosas@suse.de>

> ---
>  tests/migration/Makefile                 |  2 +-
>  tests/migration/loongarch64/Makefile     | 18 ++++++++++
>  tests/migration/loongarch64/a-b-kernel.S | 46 ++++++++++++++++++++++++
>  tests/migration/loongarch64/a-b-kernel.h | 13 +++++++
>  tests/migration/migration-test.h         |  3 ++
>  tests/qtest/meson.build                  |  4 +++
>  tests/qtest/migration-test.c             | 10 ++++++
>  7 files changed, 95 insertions(+), 1 deletion(-)
>  create mode 100644 tests/migration/loongarch64/Makefile
>  create mode 100644 tests/migration/loongarch64/a-b-kernel.S
>  create mode 100644 tests/migration/loongarch64/a-b-kernel.h
>
> diff --git a/tests/migration/Makefile b/tests/migration/Makefile
> index 13e99b1692..cfebfe23f8 100644
> --- a/tests/migration/Makefile
> +++ b/tests/migration/Makefile
> @@ -5,7 +5,7 @@
>  # See the COPYING file in the top-level directory.
>  #
>  
> -TARGET_LIST = i386 aarch64 s390x
> +TARGET_LIST = i386 aarch64 s390x loongarch64
>  
>  SRC_PATH = ../..
>  
> diff --git a/tests/migration/loongarch64/Makefile b/tests/migration/loongarch64/Makefile
> new file mode 100644
> index 0000000000..5d8719205f
> --- /dev/null
> +++ b/tests/migration/loongarch64/Makefile
> @@ -0,0 +1,18 @@
> +# To specify cross compiler prefix, use CROSS_PREFIX=
> +#   $ make CROSS_PREFIX=loongarch64-linux-gnu-
> +
> +.PHONY: all clean
> +all: a-b-kernel.h
> +
> +a-b-kernel.h: loongarch64.kernel
> +	echo "$$__note" > $@
> +	xxd -i $< | sed -e 's/.*int.*//' >> $@
> +
> +loongarch64.kernel: loongarch64.elf
> +	$(CROSS_PREFIX)objcopy -j .text -O binary $< $@
> +
> +loongarch64.elf: a-b-kernel.S
> +	$(CROSS_PREFIX)gcc -o $@ -nostdlib -Wl,--build-id=none $<
> +
> +clean:
> +	$(RM) *.kernel *.elf
> diff --git a/tests/migration/loongarch64/a-b-kernel.S b/tests/migration/loongarch64/a-b-kernel.S
> new file mode 100644
> index 0000000000..078f91b306
> --- /dev/null
> +++ b/tests/migration/loongarch64/a-b-kernel.S
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2024 Loongson Technology Corporation Limited
> + */
> +#include "../migration-test.h"
> +
> +#define LOONGARCH_CSR_CRMD          0
> +#define LOONGARCH_VIRT_UART         0x1FE001E0
> +.section .text
> +
> +        .globl  _start
> +_start:
> +        /* output char 'A' to UART16550 */
> +        li.d    $t0, LOONGARCH_VIRT_UART
> +        li.w    $t1, 'A'
> +        st.b    $t1, $t0, 0
> +
> +        /* traverse test memory region */
> +	li.d    $t0, LOONGARCH_TEST_MEM_START

Stray tab here.

> +        li.d    $t1, LOONGARCH_TEST_MEM_END
> +        li.d    $t2, TEST_MEM_PAGE_SIZE
> +
> +clean:
> +        st.b    $zero, $t0, 0
> +        add.d   $t0,   $t0, $t2
> +        bne     $t0,   $t1, clean
> +
> +mainloop:
> +        li.d    $t0, LOONGARCH_TEST_MEM_START
> +        li.d    $t1, LOONGARCH_TEST_MEM_END
> +        li.d    $t2, TEST_MEM_PAGE_SIZE
> +
> +        li.d    $t4, LOONGARCH_VIRT_UART
> +        li.w    $t5, 'B'
> +
> +innerloop:
> +        ld.bu   $t3, $t0, 0
> +        addi.w  $t3, $t3, 1
> +        ext.w.b $t3, $t3
> +        st.b    $t3, $t0, 0
> +        add.d   $t0, $t0, $t2
> +        bne     $t0, $t1, innerloop
> +
> +        st.b    $t5, $t4, 0
> +        b       mainloop
> +        nop
> diff --git a/tests/migration/loongarch64/a-b-kernel.h b/tests/migration/loongarch64/a-b-kernel.h
> new file mode 100644
> index 0000000000..6019450229
> --- /dev/null
> +++ b/tests/migration/loongarch64/a-b-kernel.h
> @@ -0,0 +1,13 @@
> +
> +unsigned char loongarch64_kernel[] = {
> +  0x0c, 0xc0, 0x3f, 0x14, 0x8c, 0x81, 0x87, 0x03, 0x0d, 0x04, 0x81, 0x03,
> +  0x8d, 0x01, 0x00, 0x29, 0x0c, 0x00, 0x01, 0x14, 0x0d, 0x80, 0x0c, 0x14,
> +  0x2e, 0x00, 0x00, 0x14, 0x80, 0x01, 0x00, 0x29, 0x8c, 0xb9, 0x10, 0x00,
> +  0x8d, 0xf9, 0xff, 0x5f, 0x0c, 0x00, 0x01, 0x14, 0x0d, 0x80, 0x0c, 0x14,
> +  0x2e, 0x00, 0x00, 0x14, 0x10, 0xc0, 0x3f, 0x14, 0x10, 0x82, 0x87, 0x03,
> +  0x11, 0x08, 0x81, 0x03, 0x8f, 0x01, 0x00, 0x2a, 0xef, 0x05, 0x80, 0x02,
> +  0xef, 0x5d, 0x00, 0x00, 0x8f, 0x01, 0x00, 0x29, 0x8c, 0xb9, 0x10, 0x00,
> +  0x8d, 0xed, 0xff, 0x5f, 0x11, 0x02, 0x00, 0x29, 0xff, 0xcf, 0xff, 0x53,
> +  0x00, 0x00, 0x40, 0x03
> +};
> +
> diff --git a/tests/migration/migration-test.h b/tests/migration/migration-test.h
> index 68512c0b1b..b6e9914f9c 100644
> --- a/tests/migration/migration-test.h
> +++ b/tests/migration/migration-test.h
> @@ -32,4 +32,7 @@
>   */
>  #define ARM_TEST_MAX_KERNEL_SIZE (512 * 1024)
>  
> +/* LoongArch64 */
> +#define LOONGARCH_TEST_MEM_START (8 * 1024 * 1024)
> +#define LOONGARCH_TEST_MEM_END   (100 * 1024 * 1024)
>  #endif /* MIGRATION_TEST_H */
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 2b89e8634b..b634587b0a 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -249,6 +249,10 @@ qtests_s390x = \
>  qtests_riscv32 = \
>    (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
>  
> +qtests_loongarch64 = \
> +  qtests_filter + \
> +  ['migration-test']
> +
>  qos_test_ss = ss.source_set()
>  qos_test_ss.add(
>    'ac97-test.c',
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 8a5bb1752e..8a25edfa77 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -132,6 +132,7 @@ static char *bootpath;
>  #include "tests/migration/i386/a-b-bootblock.h"
>  #include "tests/migration/aarch64/a-b-kernel.h"
>  #include "tests/migration/s390x/a-b-bios.h"
> +#include "tests/migration/loongarch64/a-b-kernel.h"
>  
>  static void bootfile_create(char *dir, bool suspend_me)
>  {
> @@ -158,6 +159,9 @@ static void bootfile_create(char *dir, bool suspend_me)
>          content = aarch64_kernel;
>          len = sizeof(aarch64_kernel);
>          g_assert(sizeof(aarch64_kernel) <= ARM_TEST_MAX_KERNEL_SIZE);
> +    } else if (strcmp(arch, "loongarch64") == 0) {
> +        content = loongarch64_kernel;
> +        len = sizeof(loongarch64_kernel);
>      } else {
>          g_assert_not_reached();
>      }
> @@ -823,6 +827,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
>          start_address = ARM_TEST_MEM_START;
>          end_address = ARM_TEST_MEM_END;
> +    } else if (strcmp(arch, "loongarch64") == 0) {
> +        memory_size = "256M";
> +        machine_alias = "virt";
> +        arch_opts = g_strdup_printf("-cpu max -bios %s", bootpath);
> +        start_address = LOONGARCH_TEST_MEM_START;
> +        end_address = LOONGARCH_TEST_MEM_END;
>      } else {
>          g_assert_not_reached();
>      }

