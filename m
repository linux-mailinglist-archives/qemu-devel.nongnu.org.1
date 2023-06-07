Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4CC725A53
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 11:27:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6pRf-00048u-BY; Wed, 07 Jun 2023 05:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q6pRZ-00047r-Us; Wed, 07 Jun 2023 05:27:06 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q6pRK-0003l1-7X; Wed, 07 Jun 2023 05:27:05 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C2B8FB445;
 Wed,  7 Jun 2023 12:26:47 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2CD1CA2AF;
 Wed,  7 Jun 2023 12:26:47 +0300 (MSK)
Message-ID: <66f4d0ef-9f1c-7199-9c83-5109e7b888e2@tls.msk.ru>
Date: Wed, 7 Jun 2023 12:26:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/2] target/ppc: Fix decrementer time underflow and
 infinite timer loop
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, sdicaro@DDCI.com
References: <20230530131214.373524-1-npiggin@gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230530131214.373524-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

30.05.2023 16:12, Nicholas Piggin wrote:
> It is possible to store a very large value to the decrementer that it
> does not raise the decrementer exception so the timer is scheduled, but
> the next time value wraps and is treated as in the past.
> 
> This can occur if (u64)-1 is stored on a zero-triggered exception, or
> (u64)-1 is stored twice on an underflow-triggered exception, for
> example.
> 
> If such a value is set in DECAR, it gets stored to the decrementer by
> the timer function, which then immediately causes another timer, which
> hangs QEMU.
> 
> Clamp the decrementer to the implemented width, and use that as the
> value for the timer calculation, effectively preventing this overflow.
> 
> Reported-by: sdicaro@DDCI.com
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> sdicaro@DDCI.com debugged and reported this, I just changed their fix
> to extract variable bits so it works with large decrementer. So most
> of the credit goes to them.
> 
> Thanks,
> Nick
> 
>   hw/ppc/ppc.c | 2 ++
>   1 file changed, 2 insertions(+)

Is it a -stable material?  From the description it smells like it is.

Thanks,

/mjt

