Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1066679E18B
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 10:07:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKt3-0002NY-Ap; Wed, 13 Sep 2023 04:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgKsz-00025H-Ec; Wed, 13 Sep 2023 04:06:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgKsv-0005PX-4p; Wed, 13 Sep 2023 04:06:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 769312154C;
 Wed, 13 Sep 2023 11:06:07 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E0A0A27ABD;
 Wed, 13 Sep 2023 11:06:01 +0300 (MSK)
Message-ID: <b065fa54-28fc-d64e-c8dd-16104128326d@tls.msk.ru>
Date: Wed, 13 Sep 2023 11:06:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: qemu-riscv32 usermode still broken?
Content-Language: en-US
To: LIU Zhiwei <baxiantai@gmail.com>,
 "Andreas K. Huettel" <dilfridge@gentoo.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
References: <10817413.NyiUUSuA9g@pinacolada>
 <15820654-5d7f-fd66-3d34-da1a55d2a53e@gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <15820654-5d7f-fd66-3d34-da1a55d2a53e@gmail.com>
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

13.09.2023 04:41, LIU Zhiwei wrote:
> 
> On 2023/9/13 6:31, Andreas K. Huettel wrote:
..
>> * Something seems wrong in the signal handling (?):
> 
> If it is wrong for signal handling and for 32-bit, I guess it may be fixed by this patch
> 
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg981238.html
> 
> And this patch has been merged into master branch yesterday.

I picked this one up for stable yesterday, scheduled to be released
on Sep-21.

Thanks,

/mjt


