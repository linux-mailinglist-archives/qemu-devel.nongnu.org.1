Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6E579C670
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 08:07:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfwXK-0007zo-TH; Tue, 12 Sep 2023 02:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qfwX1-0007zg-Vj
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:05:52 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qfwWx-0006E5-AS
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:05:50 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AAA5A20F68;
 Tue, 12 Sep 2023 09:05:44 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 33A1D2760F;
 Tue, 12 Sep 2023 09:05:41 +0300 (MSK)
Message-ID: <48e7e9bb-1fb5-5233-bdef-c958498b90c4@tls.msk.ru>
Date: Tue, 12 Sep 2023 09:05:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PULL v2 38/45] hw/riscv/virt.c: fix non-KVM --enable-debug build
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
 <20230911064320.939791-39-alistair.francis@wdc.com>
 <e44b65ab-ae5a-c5be-c27e-f961a1d878cc@tls.msk.ru>
 <aad03dca-e1d9-b5c5-22a9-6711841a3516@ventanamicro.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <aad03dca-e1d9-b5c5-22a9-6711841a3516@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

12.09.2023 00:43, Daniel Henrique Barboza:
> On 9/11/23 16:54, Michael Tokarev wrote:
...
>>>       /* KVM AIA only has one APLIC instance */
>>> -    if (virt_use_kvm_aia(s)) {
>>> +    if (kvm_enabled() && virt_use_kvm_aia(s)) {
>>>           create_fdt_socket_aplic(s, memmap, 0,
>> ...
>>
>> As has been discovered earlier (see "target/i386: Restrict system-specific
>> features from user emulation" threads), this is not enough, - compiler does
>> not always eliminate if (0 && foo) { bar; } construct, it's too fragile and
>> does not actually work.  Either some #ifdef'fery is needed here or some other,
>> more explicit, way to eliminate such code, like introducing stub functions.
>>
>> I know it's too late and this change is already in, but unfortunately that's
>> when I noticed this.  While the "Fixes:" tag can't be changed anymore, a more
>> proper fix for the actual problem (with the proper Fixes tag now) can still
>> be applied on top of this fix.
> 
> This works fine on current master on my machine:
> 
> $ ../configure --cc=clang --target-list=riscv64-softmmu,riscv64-linux-user,riscv32-softmmu,riscv32-linux-user --enable-debug
> $ make -j
> 
> So I'm not sure what do you mean by 'actual problem'. If you refer to the non-existence
> of stub functions, earlier today we had a review by Phil in this patch here where I was
> adding stubs for all KVM functions:
> 
> https://lore.kernel.org/qemu-riscv/f30d8589-8b59-2fd7-c38c-3f79508a4ac6@linaro.org/
> 
> Phil mentioned that we don't need a function stub if the KVM only function is protected by
> "kvm_enabled()". And this is fine, but then, from what you're saying, we can't rely on
> (kvm_enabled() && foo) working all the time, so we're one conditional away from breaking
> things it seems.

Please see:

https://lore.kernel.org/qemu-devel/20230911211317.28773-1-philmd@linaro.org/T/#t  (fix v4)
https://lore.kernel.org/qemu-devel/ZP9Cmqgy2H3ypDf3@redhat.com/T/#t (fix v3)
https://lore.kernel.org/qemu-devel/28c832bc-2fbf-8caa-e141-51288fc0d544@linaro.org/T/#t (fix v2)
https://lore.kernel.org/qemu-devel/ZP74b%2FByEaVW5bZO@redhat.com/T/#t (fix v1)

and the original issue at
https://lore.kernel.org/qemu-devel/8ee6684b-cdc3-78cb-9b76-e5875743bdcf@tls.msk.ru/T/#m65801e9edf31688a45722271a97e628ec98a0c23
(this is an i386 pullreq which removed stub functions in presence of (!kvm_enabled() && foo)).

It is exactly the same issue as this one, with exactly the same fix, which resulted in
breakage.  I dunno why your build succeeded, but the whole thing is.. not easy.

/mjt

