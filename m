Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC657E6C39
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:12:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15k3-0000bF-T5; Thu, 09 Nov 2023 09:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15jk-0000RZ-J7; Thu, 09 Nov 2023 09:10:25 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15jg-00014c-Nr; Thu, 09 Nov 2023 09:10:23 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 27BC831C69;
 Thu,  9 Nov 2023 17:10:24 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2D5FF34545;
 Thu,  9 Nov 2023 17:10:16 +0300 (MSK)
Message-ID: <509167b1-6914-4455-b1a5-7ff4653378c0@tls.msk.ru>
Date: Thu, 9 Nov 2023 17:10:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Stable-8.1.3 55/55] hw/ide/ahci: trigger either error IRQ or
 regular IRQ, not both
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Niklas Cassel <niklas.cassel@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
 <20231109134300.1461632-55-mjt@tls.msk.ru>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20231109134300.1461632-55-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

09.11.2023 16:42, Michael Tokarev:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> According to AHCI 1.3.1, 5.3.8.1 RegFIS:Entry, if ERR_STAT is set,
> we jump to state ERR:FatalTaskfile, which will raise a TFES IRQ
> unconditionally, regardless if the I bit is set in the FIS or not.
> 
> Thus, we should never raise a normal IRQ after having sent an error
> IRQ.
> 
> NOTE: for QEMU platforms that use SeaBIOS, this patch depends on QEMU
> commit 784155cdcb02 ("seabios: update submodule to git snapshot"), and
> QEMU commit 14f5a7bae4cb ("seabios: update binaries to git snapshot"),
> which update SeaBIOS to a version that contains SeaBIOS commit 1281e340
> ("ahci: handle TFES irq correctly").

And as carefully stated in the commit message, this change should not
come alone without seabios fix.  I'll drop it from both stable series
for now.

/mjt

