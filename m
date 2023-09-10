Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9724C79A009
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 23:08:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfRez-0006P6-Ep; Sun, 10 Sep 2023 17:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfRev-00068a-24; Sun, 10 Sep 2023 17:07:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfRes-0008Pe-OW; Sun, 10 Sep 2023 17:07:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5D93420955;
 Mon, 11 Sep 2023 00:07:53 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 95B32270CC;
 Mon, 11 Sep 2023 00:07:52 +0300 (MSK)
Message-ID: <64504e99-6668-bcf1-6f97-d7f3f41636d0@tls.msk.ru>
Date: Mon, 11 Sep 2023 00:07:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [Stable-7.2.6 29/37] hw/ide/ahci: PxCI should not get cleared
 when ERR_STAT is set
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Niklas Cassel <niklas.cassel@wdc.com>,
 John Snow <jsnow@redhat.com>
References: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
 <20230909130511.354171-29-mjt@tls.msk.ru>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230909130511.354171-29-mjt@tls.msk.ru>
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

09.09.2023 16:04, Michael Tokarev wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> For NCQ, PxCI is cleared on command queued successfully.
> For non-NCQ, PxCI is cleared on command completed successfully.
> Successfully means ERR_STAT, BUSY and DRQ are all cleared.
> 
> A command that has ERR_STAT set, does not get to clear PxCI.
> See AHCI 1.3.1, section 5.3.8, states RegFIS:Entry and RegFIS:ClearCI,
> and 5.3.16.5 ERR:FatalTaskfile.
> 
> In the case of non-NCQ commands, not clearing PxCI is needed in order
> for host software to be able to see which command slot that failed.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Message-id: 20230609140844.202795-7-nks@flawful.org
> Signed-off-by: John Snow <jsnow@redhat.com>
> (cherry picked from commit 1a16ce64fda11bdf50f0c4ab5d9fdde72c1383a2)
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> Mjt: fix context in hw/ide/ahci.c for f63192b0544af5 (qemu_bh_new_guarded)

This one's interesting.  I looked at f63192b0544af5 and remember there's
this series to prevent dma/mmio reentrancy issues.  And gave it a try
on top of this 7.2 series (I already had the reentrancy fixes backported
to 7.2 in a separate branch, now added 3 more fixes in that area).  And
with these reentrancy fixes there's no need to context fixing here, it
applies cleanly right into the spot.  So I re-applied this change from
the original commit, unedited.

Dunno what to do with 8.0 version of it, - will most likely keep it with
context tweak, - although I prepared reentrancy fixes for 8.0 too.

/mjt

