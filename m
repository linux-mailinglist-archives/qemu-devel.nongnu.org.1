Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E794779AB1F
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 21:55:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfmzk-0005Hn-OT; Mon, 11 Sep 2023 15:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qfmza-0005HL-QO
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 15:54:44 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qfmzX-0006nw-Dh
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 15:54:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 42B8F20E41;
 Mon, 11 Sep 2023 22:54:37 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 89D922754A;
 Mon, 11 Sep 2023 22:54:34 +0300 (MSK)
Message-ID: <e44b65ab-ae5a-c5be-c27e-f961a1d878cc@tls.msk.ru>
Date: Mon, 11 Sep 2023 22:54:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PULL v2 38/45] hw/riscv/virt.c: fix non-KVM --enable-debug build
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
 <20230911064320.939791-39-alistair.francis@wdc.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230911064320.939791-39-alistair.francis@wdc.com>
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

11.09.2023 09:43, Alistair Francis:
> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> 
> A build with --enable-debug and without KVM will fail as follows:
> 
> /usr/bin/ld: libqemu-riscv64-softmmu.fa.p/hw_riscv_virt.c.o: in function `virt_machine_init':
> ./qemu/build/../hw/riscv/virt.c:1465: undefined reference to `kvm_riscv_aia_create'
> 
> This happens because the code block with "if virt_use_kvm_aia(s)" isn't
> being ignored by the debug build, resulting in an undefined reference to
> a KVM only function.
> 
> Add a 'kvm_enabled()' conditional together with virt_use_kvm_aia() will
> make the compiler crop the kvm_riscv_aia_create() call entirely from a
> non-KVM build. Note that adding the 'kvm_enabled()' conditional inside
> virt_use_kvm_aia() won't fix the build because this function would need
> to be inlined multiple times to make the compiler zero out the entire
> block.
> 
> While we're at it, use kvm_enabled() in all instances where
> virt_use_kvm_aia() is checked to allow the compiler to elide these other
> kvm-only instances as well.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Fixes: dbdb99948e ("target/riscv: select KVM AIA in riscv virt machine")

This is probably commit 48c2c33c52, not dbdb99948e.

..
>       /* KVM AIA only has one APLIC instance */
> -    if (virt_use_kvm_aia(s)) {
> +    if (kvm_enabled() && virt_use_kvm_aia(s)) {
>           create_fdt_socket_aplic(s, memmap, 0,
...

As has been discovered earlier (see "target/i386: Restrict system-specific
features from user emulation" threads), this is not enough, - compiler does
not always eliminate if (0 && foo) { bar; } construct, it's too fragile and
does not actually work.  Either some #ifdef'fery is needed here or some other,
more explicit, way to eliminate such code, like introducing stub functions.

I know it's too late and this change is already in, but unfortunately that's
when I noticed this.  While the "Fixes:" tag can't be changed anymore, a more
proper fix for the actual problem (with the proper Fixes tag now) can still
be applied on top of this fix.

/mjt

