Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 149C879A850
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 15:37:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfh64-0005WX-Bx; Mon, 11 Sep 2023 09:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qfh61-0005TA-Kp
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:36:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qfh5z-0007If-35
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:36:57 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6410320D21;
 Mon, 11 Sep 2023 16:36:54 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4431627462;
 Mon, 11 Sep 2023 16:36:52 +0300 (MSK)
Message-ID: <36a09211-1137-c7fc-4291-89ced56e0d8a@tls.msk.ru>
Date: Mon, 11 Sep 2023 16:36:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] target/i386: Re-introduce few KVM stubs for Clang debug
 builds
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org
References: <20230911103832.23596-1-philmd@linaro.org>
 <CAJSP0QWDcNhso5nNBMNziLSXZczcrGp=6FgGNOXvYEQ6=Giiug@mail.gmail.com>
 <ZP8I9B3O4CTwTTie@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <ZP8I9B3O4CTwTTie@redhat.com>
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

11.09.2023 15:32, Kevin Wolf wrote:
..
> 
> The approach with static inline functions defined only for a very
> specific configuration looks a lot more fragile to me. In fact, I'm
> surprised that it works because I think it requires that the header
> isn't used in any files that are shared between user space and system
> emulation - and naively cpu.c sounded like something that could be
> shared. Looks like this patch only works because the linux-user target
> uses a separate build of the same CPU emulation source file.

That's why both I and Stephan disliked the #ifdef condition, not the
approach.  If it were me, I'd change the condition to be !KVM and keep
the inline functions (or #defines for that matter), instead of re-
introducing stubs in a separate .c file.

/mjt

