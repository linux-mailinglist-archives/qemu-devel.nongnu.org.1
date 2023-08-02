Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA2D76C4FE
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 07:42:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR4c3-0002Vf-Jr; Wed, 02 Aug 2023 01:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qR4by-0002VK-Es
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 01:41:30 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qR4bv-0006qr-5p
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 01:41:28 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-313e742a787so297120f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 22:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690954885; x=1691559685;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YfDh8EBX7oAELvuZxerNwDB+DbNhFpB/vy3F2LM6KTc=;
 b=U2V8vNoyZ+gwpgpK+0OZAowoys1SJFrD0fXU+JaVJiZ1stFlzc0wpu9YT93kyffC3C
 to41it5Y61yoQsfSeXcqvBpgPqwKqtjXOSostvOAQ822OE/7KhpQR+I43u6gqrocTJlu
 DQ1fdSCbvv8+u3aSCXZoXlxSYbhUG3jc6Zi3shv0OKIgqx87P1jDPSFA4nchzHoqfRDq
 WDDrCarUEUseV5fnmMp7bgg9kPn483QO0Ar34aDBFzd/4oiMeXGehtmip7j3Otpc+ed/
 3CRQbLFrYAFRz7CQ4lKLOl9O92bMd5UWx3Bd9TirDPS/GpFhF1F7v5fKZdn1jrN3aGma
 W97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690954885; x=1691559685;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YfDh8EBX7oAELvuZxerNwDB+DbNhFpB/vy3F2LM6KTc=;
 b=J+mAISXQuEHWKiBSA3j/6X65IzVfOaHpNABWrdvNKmeO4soBXJQL3z6t6cmweDE3Rd
 cJlgdP77IwzgssdCAY/sWVkfwC4fYfBNyqJCNgi2mHV6Re1ZLgrQ5UrJZ0MUAIITPuUi
 /A9kaHig4otgE0EldNzg+r9MFPEYYobg9LLwUN/xUW6P6Orj8cQC3Wg6BAmho8l1Abhu
 O0bg7ViSqyNAqnn3APVEe1K08jP8zJh+ccvlPnK51YnLnlSx5S4zin6XjXIqKuVZsl9G
 oy33adRTsPHCUwUy1lH3mDOw28g8pUY5lZD+332IT5hoAvbWWGWUXWo3S19dD3B/jOPo
 +vMg==
X-Gm-Message-State: ABy/qLaCVzrTw11TQ9ePvRhhqknG6uTQp/eLu4YQ62O9PP4mUZ/DPG7Q
 7A1/0A/fKu6Qs8zIrJO0hgPZ1Q==
X-Google-Smtp-Source: APBJJlGr9/0RP9yH0hA5F+wc2c+fP9igM1FHWMnG4VRandm6YrTh8q0ZvEDGUCm1M3fuBjGoqrKcPQ==
X-Received: by 2002:a05:6000:1a47:b0:317:5efa:c46a with SMTP id
 t7-20020a0560001a4700b003175efac46amr4012942wry.27.1690954884939; 
 Tue, 01 Aug 2023 22:41:24 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a056000104300b003141e629cb6sm17662495wrx.101.2023.08.01.22.41.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 22:41:24 -0700 (PDT)
Message-ID: <c9812263-f0fe-aff4-b594-616601a5d2f1@linaro.org>
Date: Wed, 2 Aug 2023 07:41:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v6 6/8] linux-user: Show heap address in /proc/pid/maps
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230801232745.4125-1-deller@gmx.de>
 <20230801232745.4125-7-deller@gmx.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230801232745.4125-7-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

Hi Helge,

On 2/8/23 01:27, Helge Deller wrote:
> Show the memory location of the heap in the /proc/pid/maps file inside
> the guest. Store the heap address in ts->heap_base, which requires to
> make that variable accessible for all guest architectures, not just
> architectures for semihosted binaries (arm, m68k, riscv).
> 
> Note that /proc/pid/maps in the guest needs to show target-aligned
> addresses. This is fixed in this patch, so now the heap and stack
> address for architectures like sparc64 and alpha now show up in that
> output as well.
> 
> Show 32- and 64-bit pointers with 8 digits and leading zeros (%08x/%08lx).
> For 64-bit we could use %16lx, but we mimic the Linux kernel, which shows
> even 64-bit addresses with %08lx.

You are describing 3 changes, do you mind splitting in 3 patches?
Otherwise LGTM.

> Example:
> 
> user@machine:/# uname -a
> Linux paq 5.15.88+ #47 SMP Sun Jan 15 12:53:11 CET 2023 aarch64 GNU/Linux
> 
> user@machine:/# cat /proc/self/maps
> Linux p100 6.4.4-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19 16:32:49 UTC 2023 aarch64 GNU/Linux
> 5500000000-5500009000 r-xp 00000000 fd:00 570430                         /usr/bin/cat
> 5500009000-550001f000 ---p 00000000 00:00 0
> 550001f000-5500020000 r--p 0000f000 fd:00 570430                         /usr/bin/cat
> 5500020000-5500021000 rw-p 00010000 fd:00 570430                         /usr/bin/cat
> 5500021000-5500042000 rw-p 00000000 00:00 0                              [heap]
> 7000000000-7000001000 ---p 00000000 00:00 0
> 7000001000-7000801000 rw-p 00000000 00:00 0                              [stack]
> 7000801000-7000827000 r-xp 00000000 fd:00 571555                         /usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
> 7000827000-700083f000 ---p 00000000 00:00 0
> 700083f000-7000841000 r--p 0002e000 fd:00 571555                         /usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
> 7000841000-7000843000 rw-p 00030000 fd:00 571555                         /usr/lib/aarch64-linux-gnu/ld-linux-aarch64.so.1
> 7000843000-7000844000 r-xp 00000000 00:00 0
> 7000844000-7000846000 rw-p 00000000 00:00 0
> 7000850000-70009d7000 r-xp 00000000 fd:00 571558                         /usr/lib/aarch64-linux-gnu/libc.so.6
> 70009d7000-70009ed000 ---p 00187000 fd:00 571558                         /usr/lib/aarch64-linux-gnu/libc.so.6
> 70009ed000-70009f0000 r--p 0018d000 fd:00 571558                         /usr/lib/aarch64-linux-gnu/libc.so.6
> 70009f0000-70009f2000 rw-p 00190000 fd:00 571558                         /usr/lib/aarch64-linux-gnu/libc.so.6
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   include/exec/cpu_ldst.h |  4 ++--
>   linux-user/main.c       |  2 ++
>   linux-user/qemu.h       |  4 ++--
>   linux-user/syscall.c    | 13 +++++++++----
>   4 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 645476f0e5..f1e6f31e88 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -72,10 +72,10 @@
>    */
>   #if TARGET_VIRT_ADDR_SPACE_BITS <= 32
>   typedef uint32_t abi_ptr;
> -#define TARGET_ABI_FMT_ptr "%x"
> +#define TARGET_ABI_FMT_ptr "%08x"
>   #else
>   typedef uint64_t abi_ptr;
> -#define TARGET_ABI_FMT_ptr "%"PRIx64
> +#define TARGET_ABI_FMT_ptr "%08"PRIx64
>   #endif

This is patch #1,

> 
>   #ifndef TARGET_TAGGED_ADDRESSES
> diff --git a/linux-user/main.c b/linux-user/main.c
> index dba67ffa36..fa6e47510f 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -946,6 +946,7 @@ int main(int argc, char **argv, char **envp)
>           }
>       }
> 
> +    info->brk = TARGET_PAGE_ALIGN(info->brk);

Patch #3,

>       target_set_brk(info->brk);
>       syscall_init();
>       signal_init();
> @@ -955,6 +956,7 @@ int main(int argc, char **argv, char **envp)
>          the real value of GUEST_BASE into account.  */
>       tcg_prologue_init(tcg_ctx);
> 
> +    ts->heap_base = info->brk;

Patch #3,

>       target_cpu_copy_regs(env, regs);
> 
>       if (gdbstub) {
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 802794db63..7a6adac637 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -121,11 +121,11 @@ typedef struct TaskState {
>   #ifdef TARGET_M68K
>       abi_ulong tp_value;
>   #endif
> -#if defined(TARGET_ARM) || defined(TARGET_M68K) || defined(TARGET_RISCV)
> +

Patch #3,

>       /* Extra fields for semihosted binaries.  */
>       abi_ulong heap_base;
>       abi_ulong heap_limit;
> -#endif
> +
>       abi_ulong stack_base;
>       int used; /* non zero if used */
>       struct image_info *info;
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 475260b7ce..dc8266c073 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8078,8 +8078,9 @@ static int open_self_maps_1(CPUArchState *cpu_env, int fd, bool smaps)
>           MapInfo *e = (MapInfo *) s->data;
> 
>           if (h2g_valid(e->start)) {
> -            unsigned long min = e->start;
> -            unsigned long max = e->end;
> +            /* show page granularity of guest in /proc/pid/maps */
> +            unsigned long min = TARGET_PAGE_ALIGN(e->start);
> +            unsigned long max = TARGET_PAGE_ALIGN(e->end);

Patch #2,

>               int flags = page_get_flags(h2g(min));
>               const char *path;
> 
> @@ -8090,14 +8091,18 @@ static int open_self_maps_1(CPUArchState *cpu_env, int fd, bool smaps)
>                   continue;
>               }
> 
> +            path = e->path;
> +
> +            if (ts->heap_base && h2g(min) == ts->heap_base) {
> +                path = "[heap]";
> +            }

Patch #3 but see below,

>   #ifdef TARGET_HPPA
>               if (h2g(max) == ts->info->stack_limit) {
>   #else
>               if (h2g(min) == ts->info->stack_limit) {
>   #endif
>                   path = "[stack]";

                } else if (ts->heap_base && h2g(min) == ts->heap_base) {
                     path = "[heap]";

> -            } else {
> -                path = e->path;
>               }
> 
>               count = dprintf(fd, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_ptr
> --
> 2.41.0
> 
> 


