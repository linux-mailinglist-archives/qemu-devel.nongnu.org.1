Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1000573B0F8
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 08:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCahL-0005a3-Gc; Fri, 23 Jun 2023 02:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qCahA-0005ZO-6Q
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 02:55:01 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qCah8-00017S-6q
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 02:54:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F2EC4E545;
 Fri, 23 Jun 2023 09:54:54 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 631C5EF0A;
 Fri, 23 Jun 2023 09:54:54 +0300 (MSK)
Message-ID: <e2a2fb5c-906a-9c42-e120-93651d548efd@tls.msk.ru>
Date: Fri, 23 Jun 2023 09:54:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 09/20] target/tricore: Fix out-of-bounds index in imask
 instruction
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: qemu-devel@nongnu.org, Siqi Chen <coc.cyqh@gmail.com>
References: <20230621161422.1652151-1-kbastian@mail.uni-paderborn.de>
 <20230621161422.1652151-10-kbastian@mail.uni-paderborn.de>
 <c41c4ee2-29ae-78e8-612f-2d951f359540@tls.msk.ru>
 <yury4wdzf434fmo6ty2mjmtc7u5bzg7bwak62s6us2a755tui5@5kwkzemwb6xl>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <yury4wdzf434fmo6ty2mjmtc7u5bzg7bwak62s6us2a755tui5@5kwkzemwb6xl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
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

22.06.2023 17:51, Bastian Koppelmann wrote:
..
>> Is it a -stable material?
> 
> Yes. If you pick this up, make sure you also pick up https://lore.kernel.org/qemu-devel/20230621161422.1652151-1-kbastian@mail.uni-paderborn.de/T/#md18391dd165c4fc2e60ddefb886f3522e715f487
> which applies the same fix to other instructions.

Aha. "Add CHECK_REG_PAIR() for insn accessing 64 bit regs".
This subject suggests the patch's adding this macro, instead
of using it. If it were worded like "Use CHECK.. for.." instead, I'd
notice this one too.

Picked up both, thank you!

Is there anything else in this series worth picking up for stable, eg:

  Fix helper_ret() not correctly restoring PSW
  Fix RR_JLI clobbering reg A[11]

or maybe others?

Please, in the future, add Cc: qemu-stable@nongnu.org for patches
worth to have in -stable.

Thanks!

/mjt

