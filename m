Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42536797B77
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 20:18:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeJYq-0002oL-3v; Thu, 07 Sep 2023 14:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeJYk-0002mY-Ja; Thu, 07 Sep 2023 14:16:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeJYf-0005rp-J5; Thu, 07 Sep 2023 14:16:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3E8E61FDE6;
 Thu,  7 Sep 2023 21:17:32 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7A318266CC;
 Thu,  7 Sep 2023 21:16:44 +0300 (MSK)
Message-ID: <d5ff2d54-70bb-00e0-d25a-56d1096bed73@tls.msk.ru>
Date: Thu, 7 Sep 2023 21:16:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PULL for-6.2 0/7] Ide patches
Content-Language: en-US
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230907034228.4054839-1-jsnow@redhat.com>
 <7ef011cd-09e7-c5f9-dc9d-173ff8f431c8@tls.msk.ru>
 <CAFn=p-aueHBXMFHgw=Y8XYyeaFZKFRc8vJHQ6PQ8gNSqPcii8Q@mail.gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CAFn=p-aueHBXMFHgw=Y8XYyeaFZKFRc8vJHQ6PQ8gNSqPcii8Q@mail.gmail.com>
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

07.09.2023 19:54, John Snow wrote:
..
>      > ----------------------------------------------------------------
>      >
>      > Niklas Cassel (7):
>      >    hw/ide/core: set ERR_STAT in unsupported command completion
>      >    hw/ide/ahci: write D2H FIS when processing NCQ command
>      >    hw/ide/ahci: simplify and document PxCI handling
>      >    hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is cleared
>      >    hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set
>      >    hw/ide/ahci: fix ahci_write_fis_sdb()
>      >    hw/ide/ahci: fix broken SError handling
> 
>     Is anything here stable-worthy?
> 
> Yes, assuming it doesn't break anything.

Hmm. I was thinking maybe one or two of the above.
Are you suggesting the *whole* lot?

> I can't give IDE the testing it deserves anymore, but I trust Niklas. I don't have good test suites for *inside* linux/windows guests so I am 
> admittedly relying on qtests and for people to bark if something regressed.
> 
> I'd say to tentatively add them to your list and if we find regressions during this window, we can exclude them from a stable release.

Yeah, sure, that's okay.

Thank you!

/mjt


