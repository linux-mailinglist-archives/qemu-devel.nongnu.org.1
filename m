Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B64379A7D5
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 14:06:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfff9-0001Ud-GJ; Mon, 11 Sep 2023 08:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qffez-0001R7-Pg
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 08:04:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qffet-0006Ne-Q0
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 08:04:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4B1C120C95;
 Mon, 11 Sep 2023 15:04:47 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 42CCB273DD;
 Mon, 11 Sep 2023 15:04:45 +0300 (MSK)
Message-ID: <4a3b1bee-52ed-d1e3-8ab4-7414c608329b@tls.msk.ru>
Date: Mon, 11 Sep 2023 15:04:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] target/i386: Re-introduce few KVM stubs for Clang debug
 builds
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm <kvm@vger.kernel.org>,
 Kevin Wolf <kwolf@redhat.com>
References: <20230911103832.23596-1-philmd@linaro.org>
 <CAJSP0QWDcNhso5nNBMNziLSXZczcrGp=6FgGNOXvYEQ6=Giiug@mail.gmail.com>
 <CAJSP0QVmxRPBVVq-JShUwiCvTK0WS2rM01c7=jDFquw3CRE+qw@mail.gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CAJSP0QVmxRPBVVq-JShUwiCvTK0WS2rM01c7=jDFquw3CRE+qw@mail.gmail.com>
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

11.09.2023 14:56, Stefan Hajnoczi:
> Or instead of using linker behavior, maybe just change the #ifdef so it only applies when KVM is disabled. I didn't look at the code to see if this is 
> possible, but it would be nice to avoid the very specific #ifdef condition in this patch.

Yeah, this is definitely preferrable to define it based on !kvm instead of !optimize.

I mean the same thing when replied in the pullreq which broke things, - to base
it on !kvm.  But use something very similar to what Philippe did with the functions
themselves (not with the condition).

/mjt

