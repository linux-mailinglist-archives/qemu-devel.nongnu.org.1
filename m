Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1757B5D4C
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 00:47:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnRgM-00079I-6x; Mon, 02 Oct 2023 18:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qnRgJ-00078w-JY
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 18:46:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qnRgH-0001e4-Rf
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 18:46:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BAC6C26E1C;
 Tue,  3 Oct 2023 01:47:03 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id ECC1F2C457;
 Tue,  3 Oct 2023 01:46:19 +0300 (MSK)
Message-ID: <327359d1-f6c2-68fa-aaa4-c079caada15a@tls.msk.ru>
Date: Tue, 3 Oct 2023 01:46:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PULL 0/6] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230928194156.237351-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230928194156.237351-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -91
X-Spam_score: -9.2
X-Spam_bar: ---------
X-Spam_report: (-9.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.321,
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

28.09.2023 22:41, Richard Henderson wrote
> Mini PR, aimed at fixing the mips and ovmf regressions.
> r~
> ----------------------------------------------------------------
> accel/tcg: Always require can_do_io, for #1866
> 
> ----------------------------------------------------------------
> Richard Henderson (6):
>        accel/tcg: Avoid load of icount_decr if unused
>        accel/tcg: Hoist CF_MEMI_ONLY check outside translation loop
>        accel/tcg: Track current value of can_do_io in the TB
>        accel/tcg: Improve setting of can_do_io at start of TB
>        accel/tcg: Always set CF_LAST_IO with CF_NOIRQ
>        accel/tcg: Always require can_do_io

What's the set required for the regression fix for -stable ?
Is it the whole thing?
(yes, I tested the complete set in debian).

Thank you!

/mjt

