Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E6DAD5FCE
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Jun 2025 22:06:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPRhB-0008MH-N0; Wed, 11 Jun 2025 16:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uPRh8-0008JT-Of
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 16:05:10 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uPRh6-0005RG-28
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 16:05:10 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-747c2cc3419so277947b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 13:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749672299; x=1750277099; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B4RplqXDGw7UVU/g0L3/IqyN16KOAJHEiP0yaVW70ew=;
 b=zFBRg47ZUDMQd40xlOQdB9Y/tLDPQwKVI7VcSdpt0AGaqBliVpMfb0UTAB5NH6ho3j
 QHYxcoTwmZZth1Hob+oHYkpSDImgGQ2qns2aB1mjI7pgQyUiC1dltZDTfNnmNsGYOff0
 mtHmpx7hzGt0L4Jk7hlGj4jfFq/EcyDzL6I0OsHX6OTmIw8KB0WQsnr3BMqmH2fluNqW
 7UWTai72HiZa3tUTxaoD0E6ttvbk08Dr2Evk5YeCPLeGaOlNZU/8OLvJOEK8KA9fPo7X
 gIyxjSbx0Y3OBWDonTDfZruGa8ZjvL4pfPbt/DLz+Xb0xDpLeZtORebScp7isU5LSL7r
 Kx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749672299; x=1750277099;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B4RplqXDGw7UVU/g0L3/IqyN16KOAJHEiP0yaVW70ew=;
 b=Ty60R/aBpbg6xnlsBrBECkxzaQKKT34WmNojf1owpkbewIWW+su2kSH7jF8NY7w3Hv
 D6Wp/g9glg0IKSeO5Uyimg70vwrAsY+iXG2mNdaMY0mjFT7KDWuYIq5/dWHHS35cnOd9
 TqpNyYboiQAqeXMZVe/pknSJs0BW63iVABb5ElOdQUDD3WnLnWuaOwQEHJ7FWtBOAIuS
 Mmk/r6e999kA/LFOGmrxRI41l1q3/r57SG5Hj/CWViah6V2yVpYfS4FpYUVTKcgTYW3H
 T/9htqb4bnCPfANz4WN4hpbvbFvv1dcMig/3+2RxaspLi8FTxt7j1kK/x41M92gwdLUW
 gqBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE5caiWGvmgABZPgsJrm3cuinLsfg9bje2AKKwcHIfDZO9IFcY1s6ooTV0U/UXONhAoMQ6+as/sXHc@nongnu.org
X-Gm-Message-State: AOJu0YxNSDP3h9LRK0XHByztXOQ7DSIXlhlkmGMRtndiF+9W44Z97901
 rYp4bXKEK6u/gdnPMPNts5v4/BFRyFThy3R0O5Mr2yFHW/he1K+vZ76lg3Rux6Un8GU=
X-Gm-Gg: ASbGncsbvkw6KtEaa/xB6zsUezyGqrTTrODSaamgpb2/blUtRfWsCVTaI8vxR0Bvhuv
 bxDXOMrq1TK2LxkyB4dd7B4lrw0HbvHm2uUuwJpY5i3ms9geSz+943dlmUlEHtCI0hYsf8YFSKf
 zvfNEDr4dUz65ptKkGskwaKs7wYr1JoPBXmxKd9K6EMpBv+yhh0QuvQ5stIZ0JM+3zy16+Wb1CI
 B/V5c9pkmB1YbCeQJgeef9nROoaJtRtYe43ZDhPPVOov5iZPsvG3M00fXxYtX0Z1o1ftCTlLRqI
 gzh11gLcfS/y/FMcMyeBHBcAWL1RTc1NCQFonX8drnTvUU8vZ9v7wAFQwmR/1bYhnPThhx93tZ8
 =
X-Google-Smtp-Source: AGHT+IFcpHUrAyG6p0pcfX5eRdW+z4CcR+EmpOKkvX+yTY01L9ca8UpxikJ1RtR43pMMi0VUleNwcw==
X-Received: by 2002:a05:6a20:3ca5:b0:21f:53e4:1925 with SMTP id
 adf61e73a8af0-21f97789298mr1487003637.10.1749672299294; 
 Wed, 11 Jun 2025 13:04:59 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482af7afe5sm9951907b3a.60.2025.06.11.13.04.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 13:04:58 -0700 (PDT)
Message-ID: <2ae6884a-6a8a-4f46-9821-db99858a01c7@linaro.org>
Date: Wed, 11 Jun 2025 13:04:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 6/8] plugins: Add patcher plugin and test
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20250609193841.348076-1-rowanbhart@gmail.com>
 <20250609193841.348076-7-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250609193841.348076-7-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 6/9/25 12:38 PM, Rowan Hart wrote:
> From: novafacing <rowanbhart@gmail.com>
> 
> This patch adds a plugin that exercises the virtual and hardware memory
> read-write API functions added in a previous patch. The plugin takes a
> target and patch byte sequence, and will overwrite any instruction
> matching the target byte sequence with the patch.
> 
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   tests/tcg/Makefile.target                 |   1 +
>   tests/tcg/plugins/meson.build             |   2 +-
>   tests/tcg/plugins/patch.c                 | 297 ++++++++++++++++++++++
>   tests/tcg/x86_64/Makefile.softmmu-target  |  32 ++-
>   tests/tcg/x86_64/system/patch-target.c    |  27 ++
>   tests/tcg/x86_64/system/validate-patch.py |  39 +++
>   6 files changed, 392 insertions(+), 6 deletions(-)
>   create mode 100644 tests/tcg/plugins/patch.c
>   create mode 100644 tests/tcg/x86_64/system/patch-target.c
>   create mode 100755 tests/tcg/x86_64/system/validate-patch.py
> 
> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> index 95ff76ea44..4b709a9d18 100644
> --- a/tests/tcg/Makefile.target
> +++ b/tests/tcg/Makefile.target
> @@ -176,6 +176,7 @@ RUN_TESTS+=$(EXTRA_RUNS)
>   # Some plugins need additional arguments above the default to fully
>   # exercise things. We can define them on a per-test basis here.
>   run-plugin-%-with-libmem.so: PLUGIN_ARGS=$(COMMA)inline=true
> +run-plugin-%-with-libpatch.so: PLUGIN_ARGS=$(COMMA)target=ffffffff$(COMMA)patch=00000000
>   
>   ifeq ($(filter %-softmmu, $(TARGET)),)
>   run-%: %
> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
> index 41f02f2c7f..163042e601 100644
> --- a/tests/tcg/plugins/meson.build
> +++ b/tests/tcg/plugins/meson.build
> @@ -1,6 +1,6 @@
>   t = []
>   if get_option('plugins')
> -  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall']
> +  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
>       if host_os == 'windows'
>         t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
>                           include_directories: '../../../include/qemu',
> diff --git a/tests/tcg/plugins/patch.c b/tests/tcg/plugins/patch.c
> new file mode 100644
> index 0000000000..6e83418b85
> --- /dev/null
> +++ b/tests/tcg/plugins/patch.c
> @@ -0,0 +1,297 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This plugin patches instructions matching a pattern to a different
> + * instruction as they execute
> + *
> + */
> +
> +#include "glib.h"
> +#include "glibconfig.h"
> +
> +#include <qemu-plugin.h>
> +#include <string.h>
> +#include <stdio.h>
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> +
> +static bool use_hwaddr;
> +static bool debug_insns;
> +static GByteArray *target_data;
> +static GByteArray *patch_data;
> +
> +/**
> + * Parse a string of hexadecimal digits into a GByteArray. The string must be
> + * even length
> + */
> +static GByteArray *str_to_bytes(const char *str)
> +{
> +    GByteArray *bytes = g_byte_array_new();
> +    char byte[3] = {0};
> +    size_t len = strlen(str);
> +    guint8 value = 0;
> +
> +    if (len % 2 != 0) {
> +        g_byte_array_free(bytes, true);
> +        return NULL;
> +    }

You can check len before allocating "bytes" at start of function.

> +
> +    for (size_t i = 0; i < len; i += 2) {
> +        byte[0] = str[i];
> +        byte[1] = str[i + 1];
> +        value = (guint8)g_ascii_strtoull(byte, NULL, 16);
> +        g_byte_array_append(bytes, &value, 1);
> +    }
> +
> +    return bytes;
> +}
> +
> +static void patch_hwaddr(unsigned int vcpu_index, void *userdata)
> +{
> +    uint64_t addr = (uint64_t)userdata;
> +    GString *str = g_string_new(NULL);
> +    g_string_printf(str, "patching: @0x%"
> +                    PRIx64 "\n",
> +                    addr);
> +    qemu_plugin_outs(str->str);
> +    g_string_free(str, true);
> +

You can use g_autoptr(type) for various glib types, so it gets freed 
automatically when leaving the scope.

g_autoptr(GString)

> +    enum qemu_plugin_hwaddr_operation_result result =
> +        qemu_plugin_write_memory_hwaddr(addr, patch_data);
> +
> +
> +    if (result != QEMU_PLUGIN_HWADDR_OPERATION_OK) {
> +        GString *errmsg = g_string_new(NULL);
> +        g_string_printf(errmsg, "Failed to write memory: %d\n", result);
> +        qemu_plugin_outs(errmsg->str);
> +        g_string_free(errmsg, true);
> +        return;

g_autoptr(GString)

> +    }
> +
> +    GByteArray *read_data = g_byte_array_new();
> +

g_autoptr(GByteArray)

> +    result = qemu_plugin_read_memory_hwaddr(addr, read_data,
> +                                            patch_data->len);
> +
> +    qemu_plugin_outs("Reading memory...\n");
> +
> +    if (result != QEMU_PLUGIN_HWADDR_OPERATION_OK) {
> +        GString *errmsg = g_string_new(NULL);
> +        g_string_printf(errmsg, "Failed to read memory: %d\n", result);
> +        qemu_plugin_outs(errmsg->str);
> +        g_string_free(errmsg, true);
> +        return;
> +    }

g_autoptr(GString)

> +
> +    if (memcmp(patch_data->data, read_data->data, patch_data->len) != 0) {
> +        qemu_plugin_outs("Failed to read back written data\n");
> +    }
> +
> +    qemu_plugin_outs("Success!\n");
> +
> +    return;
> +}
> +
> +static void patch_vaddr(unsigned int vcpu_index, void *userdata)
> +{
> +    uint64_t addr = (uint64_t)userdata;
> +    uint64_t hwaddr = 0;
> +    if (!qemu_plugin_translate_vaddr(addr, &hwaddr)) {
> +        qemu_plugin_outs("Failed to translate vaddr\n");
> +        return;
> +    }
> +    GString *str = g_string_new(NULL);

g_autoptr(GString)

> +    g_string_printf(str, "patching: @0x%"
> +                    PRIx64 " hw: @0x%" PRIx64 "\n",
> +                    addr, hwaddr);
> +    qemu_plugin_outs(str->str);
> +    g_string_free(str, true);
> +
> +    qemu_plugin_outs("Writing memory (vaddr)...\n");
> +
> +    if (!qemu_plugin_write_memory_vaddr(addr, patch_data)) {
> +        qemu_plugin_outs("Failed to write memory\n");
> +        return;
> +    }
> +
> +    qemu_plugin_outs("Reading memory (vaddr)...\n");
> +
> +
> +    GByteArray *read_data = g_byte_array_new();
> +

g_autoptr(GByteArray)

> +    if (!qemu_plugin_read_memory_vaddr(addr, read_data, patch_data->len)) {
> +        qemu_plugin_outs("Failed to read memory\n");
> +        return;
> +    }
> +
> +    if (memcmp(patch_data->data, read_data->data, patch_data->len) != 0) {
> +        qemu_plugin_outs("Failed to read back written data\n");
> +    }
> +
> +    qemu_plugin_outs("Success!\n");
> +
> +    return;
> +}
> +
> +static void debug_disas(unsigned int vcpu_index, void *userdata)
> +{
> +    GString *debug_info = (GString *)userdata;
> +    qemu_plugin_outs(debug_info->str);
> +}
> +
> +static void debug_print_newline(unsigned int vcpu_index, void *userdata)
> +{
> +    qemu_plugin_outs("\n");
> +}
> +
> +/*
> + * Callback on translation of a translation block.
> + */
> +static void vcpu_tb_trans_cb(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> +{
> +    uint64_t addr = 0;
> +    GByteArray *insn_data = g_byte_array_new();
> +    for (size_t i = 0; i < qemu_plugin_tb_n_insns(tb); i++) {
> +        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
> +
> +        if (use_hwaddr) {
> +            uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
> +            if (!qemu_plugin_translate_vaddr(vaddr, &addr)) {
> +                qemu_plugin_outs("Failed to translate vaddr\n");
> +                continue;
> +            }
> +        } else {
> +            addr = qemu_plugin_insn_vaddr(insn);
> +        }
> +
> +        g_byte_array_set_size(insn_data, qemu_plugin_insn_size(insn));
> +        qemu_plugin_insn_data(insn, insn_data->data, insn_data->len);
> +
> +        if (insn_data->len >= target_data->len &&
> +            !memcmp(insn_data->data, target_data->data,
> +                    MIN(target_data->len, insn_data->len))) {
> +            if (use_hwaddr) {
> +                qemu_plugin_register_vcpu_tb_exec_cb(tb, patch_hwaddr,
> +                                                     QEMU_PLUGIN_CB_NO_REGS,
> +                                                     (void *)addr);
> +            } else {
> +                qemu_plugin_register_vcpu_tb_exec_cb(tb, patch_vaddr,
> +                                                     QEMU_PLUGIN_CB_NO_REGS,
> +                                                     (void *)addr);
> +            }
> +        }
> +    }
> +    for (size_t i = 0; i < qemu_plugin_tb_n_insns(tb); i++) {
> +        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
> +        uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
> +        uint64_t hwaddr = (uint64_t)qemu_plugin_insn_haddr(insn);
> +        uint64_t translated_hwaddr = 0;
> +        if (!qemu_plugin_translate_vaddr(vaddr, &translated_hwaddr)) {
> +            qemu_plugin_outs("Failed to translate vaddr\n");
> +            continue;
> +        }
> +        char *disas = qemu_plugin_insn_disas(insn);
> +        GString *str = g_string_new(NULL);
> +        g_string_printf(str,
> +                        "vaddr: 0x%" PRIx64 " hwaddr: 0x%" PRIx64
> +                        " translated: 0x%" PRIx64 " : %s\n",
> +                        vaddr, hwaddr, translated_hwaddr, disas);
> +        g_free(disas);
> +        if (debug_insns) {
> +            qemu_plugin_register_vcpu_insn_exec_cb(insn, debug_disas,
> +                                                   QEMU_PLUGIN_CB_NO_REGS,
> +                                                   str);
> +        }
> +
> +    }
> +
> +    if (debug_insns) {
> +        qemu_plugin_register_vcpu_tb_exec_cb(tb, debug_print_newline,
> +                                             QEMU_PLUGIN_CB_NO_REGS,
> +                                             NULL);
> +    }
> +

I think you can remove all the debug_insns and disas related code, as 
it's mostly equivalent to the existing execlog plugin output.

> +    g_byte_array_free(insn_data, true);
> +}
> +
> +static void usage(void)
> +{
> +    fprintf(stderr, "Usage: <lib>,target=<target>,patch=<patch>"

Usage can be changed to help understand the difference between target 
and patch:
target=<bytes>,patch=<new_bytes>

> +            "[,use_hwaddr=<use_hwaddr>]"

use_hwaddr=true|false

> +            "[,debug_insns=<debug_insns>]\n");
> +}
> +
> +/*
> + * Called when the plugin is installed
> + */
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> +                                           const qemu_info_t *info, int argc,
> +                                           char **argv)
> +{
> +
> +    use_hwaddr = true;
> +    debug_insns = false;
> +    target_data = NULL;
> +    patch_data = NULL;
> +
> +    if (argc > 4) {
> +        usage();
> +        return -1;
> +    }
> +
> +    for (size_t i = 0; i < argc; i++) {
> +        char *opt = argv[i];
> +        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
> +        if (g_strcmp0(tokens[0], "use_hwaddr") == 0) {
> +            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &use_hwaddr)) {
> +                fprintf(stderr,
> +                        "Failed to parse boolean argument use_hwaddr\n");
> +                return -1;
> +            }
> +        } else if (g_strcmp0(tokens[0], "debug_insns") == 0) {
> +            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &debug_insns)) {
> +                fprintf(stderr,
> +                        "Failed to parse boolean argument debug_insns\n");
> +                return -1;
> +            }
> +        } else if (g_strcmp0(tokens[0], "target") == 0) {
> +            target_data = str_to_bytes(tokens[1]);
> +            if (!target_data) {
> +                fprintf(stderr,
> +                         "Failed to parse target bytes.\n");
> +                return -1;
> +            }


> +        } else if (g_strcmp0(tokens[0], "patch") == 0) {
> +            patch_data = str_to_bytes(tokens[1]);
> +            if (!patch_data) {
> +                fprintf(stderr, "Failed to parse patch bytes.\n");
> +                return -1;
> +            }
> +        } else {
> +            fprintf(stderr, "Unknown argument: %s\n", tokens[0]);
> +            usage();
> +            return -1;
> +        }
> +    }
> +
> +    if (!target_data) {
> +        fprintf(stderr, "target argument is required\n");
> +        usage();
> +        return -1;
> +    }
> +
> +    if (!patch_data) {
> +        fprintf(stderr, "patch argument is required\n");
> +        usage();
> +        return -1;
> +    }
> +
> +    if (target_data->len != patch_data->len) {
> +        fprintf(stderr, "Target and patch data must be the same length\n");
> +        return -1;
> +    }
> +
> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans_cb);
> +
> +    return 0;
> +}
> diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
> index ef6bcb4dc7..8d3a067c33 100644
> --- a/tests/tcg/x86_64/Makefile.softmmu-target
> +++ b/tests/tcg/x86_64/Makefile.softmmu-target
> @@ -7,18 +7,27 @@
>   #
>   
>   I386_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/i386/system
> -X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
> +X86_64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
>   
>   # These objects provide the basic boot code and helper functions for all tests
>   CRT_OBJS=boot.o
>   
> -CRT_PATH=$(X64_SYSTEM_SRC)
> -LINK_SCRIPT=$(X64_SYSTEM_SRC)/kernel.ld
> +X86_64_TEST_C_SRCS=$(wildcard $(X86_64_SYSTEM_SRC)/*.c)
> +X86_64_TEST_S_SRCS=
> +
> +X86_64_C_TESTS = $(patsubst $(X86_64_SYSTEM_SRC)/%.c, %, $(X86_64_TEST_C_SRCS))
> +X86_64_S_TESTS = $(patsubst $(X86_64_SYSTEM_SRC)/%.S, %, $(X86_64_TEST_S_SRCS))
> +
> +X86_64_TESTS = $(X86_64_C_TESTS)
> +X86_64_TESTS += $(X86_64_S_TESTS)
> +
> +CRT_PATH=$(X86_64_SYSTEM_SRC)
> +LINK_SCRIPT=$(X86_64_SYSTEM_SRC)/kernel.ld
>   LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
>   CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
>   LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
>   
> -TESTS+=$(MULTIARCH_TESTS)
> +TESTS+=$(X86_64_TESTS) $(MULTIARCH_TESTS)
>   EXTRA_RUNS+=$(MULTIARCH_RUNS)
>   
>   # building head blobs
> @@ -27,11 +36,24 @@ EXTRA_RUNS+=$(MULTIARCH_RUNS)
>   %.o: $(CRT_PATH)/%.S
>   	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -Wa,--noexecstack -c $< -o $@
>   
> -# Build and link the tests
> +# Build and link the multiarch tests
>   %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
>   	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
>   
> +# Build and link the arch tests
> +%: $(X86_64_SYSTEM_SRC)/%.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
> +
>   memory: CFLAGS+=-DCHECK_UNALIGNED=1
> +patch-target: CFLAGS+=-O0
>   
>   # Running
>   QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
> +
> +# Add patch-target to ADDITIONAL_PLUGINS_TESTS
> +ADDITIONAL_PLUGINS_TESTS += patch-target
> +
> +run-plugin-patch-target-with-libpatch.so:		\
> +	PLUGIN_ARGS=$(COMMA)target=ffc0$(COMMA)patch=9090$(COMMA)use_hwaddr=true$(COMMA)debug_insns=false
> +run-plugin-patch-target-with-libpatch.so:		\
> +	CHECK_PLUGIN_OUTPUT_COMMAND=$(X86_64_SYSTEM_SRC)/validate-patch.py $@.out
> \ No newline at end of file
> diff --git a/tests/tcg/x86_64/system/patch-target.c b/tests/tcg/x86_64/system/patch-target.c
> new file mode 100644
> index 0000000000..8a7c0a0ae8
> --- /dev/null
> +++ b/tests/tcg/x86_64/system/patch-target.c
> @@ -0,0 +1,27 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This test target increments a value 100 times. The patcher converts the
> + * inc instruction to a nop, so it only increments the value once.
> + *
> + */
> +#include <minilib.h>
> +
> +int main(void)
> +{
> +    ml_printf("Running test...\n");
> +#if defined(__x86_64__)
> +    ml_printf("Testing insn memory read/write...\n");
> +    unsigned int x = 0;
> +    for (int i = 0; i < 100; i++) {
> +        asm volatile (
> +            "inc %[x]"
> +            : [x] "+a" (x)
> +        );
> +    }
> +    ml_printf("Value: %d\n", x);
> +#else
> +    #error "This test is only valid for x86_64 architecture."
> +#endif
> +    return 0;
> +}
> diff --git a/tests/tcg/x86_64/system/validate-patch.py b/tests/tcg/x86_64/system/validate-patch.py
> new file mode 100755
> index 0000000000..700950eae5
> --- /dev/null
> +++ b/tests/tcg/x86_64/system/validate-patch.py
> @@ -0,0 +1,39 @@
> +#!/usr/bin/env python3
> +#
> +# validate-patch.py: check the patch applies
> +#
> +# This program takes two inputs:
> +#   - the plugin output
> +#   - the binary output
> +#
> +# Copyright (C) 2024
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import sys
> +from argparse import ArgumentParser
> +
> +def main() -> None:
> +    """
> +    Process the arguments, injest the program and plugin out and
> +    verify they match up and report if they do not.
> +    """
> +    parser = ArgumentParser(description="Validate patch")
> +    parser.add_argument('test_output',
> +                        help="The output from the test itself")
> +    parser.add_argument('plugin_output',
> +                        help="The output from plugin")
> +    args = parser.parse_args()
> +
> +    with open(args.test_output, 'r') as f:
> +        test_data = f.read()
> +    with open(args.plugin_output, 'r') as f:
> +        plugin_data = f.read()
> +    if "Value: 1" in test_data:
> +        sys.exit(0)
> +    else:
> +        sys.exit(1)
> +
> +if __name__ == "__main__":
> +    main()
> +


