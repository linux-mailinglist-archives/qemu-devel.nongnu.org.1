Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1692F75503C
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 20:14:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qL6FL-0001pf-72; Sun, 16 Jul 2023 14:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qL6FI-0001pH-9e
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 14:13:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qL6FG-00038m-9S
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 14:13:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 12EC9142F3;
 Sun, 16 Jul 2023 21:13:17 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C60961501A;
 Sun, 16 Jul 2023 21:13:16 +0300 (MSK)
Message-ID: <e9c0cbcc-854f-0ebc-8dcd-37abc21d53b6@tls.msk.ru>
Date: Sun, 16 Jul 2023 21:13:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 45/47] linux-user/arm: Do not allocate a commpage at all
 for M-profile CPUs
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Christophe Lyon <christophe.lyon@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
 <20230715135317.7219-46-richard.henderson@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230715135317.7219-46-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

15.07.2023 16:53, Richard Henderson wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Since commit fbd3c4cff6 ("linux-user/arm: Mark the commpage
> executable") executing bare-metal (linked with rdimon.specs)
> cortex-M code fails as:
> 
>    $ qemu-arm -cpu cortex-m3 ~/hello.exe.m3
>    qemu-arm: ../../accel/tcg/user-exec.c:492: page_set_flags: Assertion `last <= GUEST_ADDR_MAX' failed.
>    Aborted (core dumped)
> 
> Commit 4f5c67f8df ("linux-user/arm: Take more care allocating
> commpage") already took care of not allocating a commpage for
> M-profile CPUs, however it had to be reverted as commit 6cda41daa2.
> 
> Re-introduce the M-profile fix from commit 4f5c67f8df.
> 
> Fixes: fbd3c4cff6 ("linux-user/arm: Mark the commpage executable")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1755

This smells like a 8.0-stable material.  Please let me know if it is no.
Thanks,

/mjt

