Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5308798235
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:15:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUmF-0007cY-Ay; Fri, 08 Sep 2023 02:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qeUm7-0007VV-SJ
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:15:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qeUm5-000122-BL
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:15:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BDF281FF7A;
 Fri,  8 Sep 2023 09:16:11 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0ABEA267D6;
 Fri,  8 Sep 2023 09:15:23 +0300 (MSK)
Message-ID: <08cbf0a8-f94d-6b8a-851e-e92a46ffdd01@tls.msk.ru>
Date: Fri, 8 Sep 2023 09:15:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PULL 03/65] hw/char/riscv_htif: Fix the console syscall on big
 endian hosts
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng@tinylab.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
 <20230908060431.1903919-4-alistair.francis@wdc.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230908060431.1903919-4-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

08.09.2023 09:03, Alistair Francis wrote:
> From: Thomas Huth <thuth@redhat.com>

> @@ -209,11 +210,11 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
>               } else {
>                   uint64_t syscall[8];
>                   cpu_physical_memory_read(payload, syscall, sizeof(syscall));
> -                if (syscall[0] == PK_SYS_WRITE &&
> -                    syscall[1] == HTIF_DEV_CONSOLE &&
> -                    syscall[3] == HTIF_CONSOLE_CMD_PUTC) {
> +                if (tswap64(syscall[0]) == PK_SYS_WRITE &&
> +                    tswap64(syscall[1]) == HTIF_DEV_CONSOLE &&
> +                    tswap64(syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {

Maybe not in this very case as it does not seem to be speed-critical,
but I'd say we can change that to read backwards, like:

  +                if (syscall[0] == tswap64(PK_SYS_WRITE) ...

This way it's easier for the compiler to omit call to tswap64 entirely
and calculate the static value at compile time, so only comparison is
left for the runtime.

But this way it's less readable as well.

Just a side note.

/mjt

