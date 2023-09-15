Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F6C7A1AFC
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 11:44:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh5NE-0005OA-Gc; Fri, 15 Sep 2023 05:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qh5NB-0005NM-Ln
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:44:25 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qh5N9-0001lF-1J
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694771060; x=1695375860; i=deller@gmx.de;
 bh=qFPN+mXqrO+UHgrED4oOODl67pHnaiEewuDVsph5aK0=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=aZcDjkcXh92wfW2AeHLDLt52yrs6kza4BVtShyzgvmluOamdWHVjxNuzcFSZl7lWGlTsxVgHbk9
 vWY0lPJ4hq7MzFqxcDoX1aFY2wCHxn+cR/+3QOLOvoU/Smg7vS5capkIwY7PGGtQ2weDuUY/NGKFI
 MqND1jxdt9Koc4GAjuCYNmBR27Rv3YNUedHzUDS6BKATfANBvLKkyOpiIMVfgq+naPVP4tnsX9vRD
 06pAfKQECmHKuxOKyAbkNoFa47+33V6Y/2cb+bfbChfeGKqqzBPuGX8sixWIfyFRQLp4tTPNaq/6u
 NKl4sfyqLCe9y/DZ2oBIcnNWk+d9QeL/YYbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.157.117]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv2xU-1rY5Z61aDI-00r1jc; Fri, 15
 Sep 2023 11:44:20 +0200
Message-ID: <373d527a-6d34-442a-b225-3bc68ad586ee@gmx.de>
Date: Fri, 15 Sep 2023 11:44:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC v6 2/9] build: Implement libnative library and the build
 machinery for libnative
Content-Language: en-US
To: Yeqi Fu <fufuyqqqqqq@gmail.com>, qemu-devel@nongnu.org
References: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
 <20230912212842.658374-3-fufuyqqqqqq@gmail.com>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <20230912212842.658374-3-fufuyqqqqqq@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uggvYbWmNop6a6rJAdlCKgtsKMR8GasA6ba0syYwRa0fFrzW6a2
 DV+Re+GJVcLxOIDfbZU+qcnuD08hHR6cs6A7P8QtUMGMHhNzL4wd0H7a9qB/TK4+RMKrx3g
 RTs+ERyxyf1RT5T0ItVSbQLfsyrC0KvqIsSIaOP9UUSrbc2ms93KnkoiodNUYjzRhVbAzjP
 7n9wFJLDjKRt0z2mzxmWQ==
UI-OutboundReport: notjunk:1;M01:P0:ctfriBMFges=;m+cc1rQZDXmBfgtRNrWygVOADnE
 znIPrxF0YXf5KIm384y259VZiSFEByhB43dQBRWDdYzZ+hN+gqI7yem2puQNCS/5f/BWbsnxk
 Ky056RBFS4tLgzalHF/bnkY9HqcqxR1uWoXxb0FJQJ902kft30wabmy4RINI+WfbiOBrex/8x
 4n4Xbw5fGSt/L/umO1BVkgt5QYhuM7zi5ZFMzhU2zJouaGjzznplxAozB5S7P+F3G6IPBme8R
 HQrxEbtVUxkDoBcR9FqAhJ8WBnhX06b6LgLjI64lmTeNWlFzrhudvfOzZceTL2l8I0Q+hj/0w
 +fJn+41/EluKw/HgARjPdwzmikfpaLhmPEN4mE5dJ+uDmbW/xNNBTTYiO8/fAK+i/R3OaAhsx
 TtMeTMY36Kftkv7tc4I9bufsoQlKrgFPGIBEIPS5hqIrdatTxFeDF8cM/6UMmxLHPFvEvhjKl
 eQ86t3AR5EnsMBrgKsadUTlEBPPzHHzIw+V/Jfhu+34ITJ3/eZr+1hFrQcY7xfZX2yDalnTcb
 yZFAoH6mee4ltw7jDQVurqW0OYw+eP06MFh4l2zxPD2Qm2M+qg8cdvLZ6I3cHgP/X69TEHR9n
 bhN5unmyZxCGcJIxQvWHZU+3hVlk+wN3tPuMz2Smn+pGDIrb6n7unvwkmIqFnUU0jDrUre8+K
 x8KB/7zLPHA1Q6kSVQlEi00vrcA0Ls7/HWxKJZd/lFyUu+N3M9IwULZoyPeC9ZufUxCWPP5kx
 nUu0HTnzpltmeflYBJMLFtBfERO1vOUWTtFxsyzMSDtYuggEhVqhNiioNgmAcpft7ceribo42
 RROLN/+fvyuWJ9sZLbkQIEBKljHc+cJrYI2HOemgV1eaPGUPtBCY3SLYaqG2I2Z0CFB2TjlCh
 4o8dtb3VF7IReicikZBoutamerNWDOIvvBZGOA50t+Lgcq4WGmfUg2O7sr8oyO/iPaWZZlCzz
 1YJ0NA==
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/12/23 23:28, Yeqi Fu wrote:
> This commit implements a shared library, where native functions are
> rewritten as special instructions. At runtime, user programs load
> the shared library, and special instructions are executed when
> native functions are called.

Hello Yeqi,

I like the idea of speeding up linux-user with your approach.
Do you have a git tree which I can pull for testing (or please
mention the base commit your patches are based on)?

How does the emulation behaves if a guest has bugs and accesses
wrong memory locations, e.g.:
	memcpy(NULL, "Hello", 6)
Will it segfault the same way as if it would have run natively?
At least I think the signal IP addresses will be different.

Regarding you implemenation:

> diff --git a/common-user/native/libnative.S b/common-user/native/libnative.S
> new file mode 100644
> index 0000000000..bc51dabedf
> --- /dev/null
> +++ b/common-user/native/libnative.S
> @@ -0,0 +1,51 @@
> +.macro special_instr sym
> +#if defined(__i386__)

you use here #ifdefs,

> +         ud0     \sym-1f, %eax; 1:
> +#elif defined(__x86_64__)
> +         ud0     \sym(%rip), %eax
> +#elif defined(__arm__) || defined(__aarch64__)
> +         hlt     0xffff
> +1:      .word   \sym - 1b
> +#elif defined(__mips__)
> +         syscall 0xffff
> +1:      .word   \sym - 1b
> +#else
> +# error
> +#endif
> +.endm
> +
> +.macro ret_instr
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)

and here again,

> +         ret
> +#elif defined(__arm__)
> +         bx     lr
> +#elif defined(__mips__)
> +         jr     $ra
> +#else
> +# error
> +#endif
> +.endm
> +
> +/* Symbols of native functions */
> +
> +.macro define_function name
> +         .text
> +\name:
> +         special_instr 9f

and here the pointer to the string.

> +         ret_instr
> +         .globl \name
> +         .type \name, %function
> +         .size \name, . - \name
> +
> +         .section .rodata
> +9:      .asciz  "\name"
> +.endm

IMHO, I think it would be easier if you just do:

+/* wrapper for native functions */
+
+.macro define_function name
+         .text
+         .align 8  /* function is 8-byte aligned */
+\name:
+/* every arch has up to 8 bytes for trigger and return instruction */
+#if defined(__i386__)
+         ud0     0, %eax
+         ret
+#elif defined(__x86_64__)
+         ud0     0, %eax
+         ret
+#elif defined(__mips__)
+         syscall 0xffff
+         jr     $ra
+#<...more ifdef for arches...>
+#endif
+
+/* the native function name is stored 8 bytes behind \name symbol: */
+         .align 8
+         .asciz  "\name"
+
+         .globl \name
+         .type \name, %function
+         .size \name, . - \name
+.endm

with that you
- save some bytes, code & pointers
- don't need to load the pointer to the native function string (as it's
   always stored as ascii 8 bytes behind the function itself)
- don't need to adjust the IP
- simplifies the asm code and reduced the ifdefs
- ...

Helge

> +
> +define_function memcmp
> +define_function memcpy
> +define_function memset
> +define_function strcat
> +define_function strcmp
> +define_function strcpy
> +define_function strncmp
> +define_function strncpy

