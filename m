Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC9A773A38
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 14:43:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTM30-0004O6-9c; Tue, 08 Aug 2023 08:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qTM2x-0004NT-S7
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 08:42:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qTM2w-0005Jv-6X
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 08:42:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3B3FE19068;
 Tue,  8 Aug 2023 15:42:47 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D6AFF1C6D9;
 Tue,  8 Aug 2023 15:42:43 +0300 (MSK)
Message-ID: <4fa1edaa-97e6-a5c1-1c67-47411c02682b@tls.msk.ru>
Date: Tue, 8 Aug 2023 15:42:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 3/3] configure: unify case statements for CPU
 canonicalization
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, iii@linux.ibm.com, Joel Stanley
 <joel@jms.id.au>, Richard Henderson <richard.henderson@linaro.org>
References: <20230808120303.585509-1-pbonzini@redhat.com>
 <20230808120303.585509-4-pbonzini@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230808120303.585509-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -109
X-Spam_score: -11.0
X-Spam_bar: -----------
X-Spam_report: (-11.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.14,
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

08.08.2023 15:03, Paolo Bonzini wrote:
> The CPU model has to be canonicalized to what Meson wants in the cross
> file, to what Linux uses for its asm-$ARCH directories, and to what
> QEMU uses for its user-mode emulation host/$ARCH directories.  Do
> all three in a single case statement, and check that the Linux and
> QEMU directories actually exist.
> 
> At a small cost in repeated lines, this ensures that there are no hidden
> ordering requirements between the case statements.  In particular, commit
> 89e5b7935e9 ("configure: Fix linux-user host detection for riscv64",
> 2023-08-06) broke ppc64le because it assigned host_arch based on a
> non-canonicalized version of $cpu.
> 
> Reported-by: Joel Stanley <joel@jms.id.au>
> Fixes: 89e5b7935e9 ("configure: Fix linux-user host detection for riscv64", 2023-08-06)
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configure | 175 +++++++++++++++++++++++++++++++-----------------------
>   1 file changed, 102 insertions(+), 73 deletions(-)

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

A nice cleanup.

/mjt

