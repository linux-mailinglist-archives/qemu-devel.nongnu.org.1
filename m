Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C3076D1A5
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 17:18:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRDc2-0007tm-M0; Wed, 02 Aug 2023 11:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qRDbz-0007pk-92
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:18:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qRDbx-0003cg-Es
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:18:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 34CDF177DF;
 Wed,  2 Aug 2023 18:18:18 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9F68D1AD3A;
 Wed,  2 Aug 2023 18:18:01 +0300 (MSK)
Message-ID: <0441c6bd-eb98-8013-5756-418775863aa1@tls.msk.ru>
Date: Wed, 2 Aug 2023 18:18:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PULL 0/5] Misc fixes, for thread-pool, xen, and xen-emulate
Content-Language: en-US
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org,
 Olaf Hering <olaf@aepfle.de>
References: <20230801094038.11026-1-anthony.perard@citrix.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230801094038.11026-1-anthony.perard@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.102,
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

01.08.2023 12:40, Anthony PERARD via wrote:
...
> Anthony PERARD (2):
>        xen-block: Avoid leaks on new error path
>        thread-pool: signal "request_cond" while locked
> 
> David Woodhouse (1):
>        hw/xen: Clarify (lack of) error handling in transaction_commit()
> 
> Olaf Hering (1):
>        xen-platform: do full PCI reset during unplug of IDE devices
> 
> Peter Maydell (1):
>        xen: Don't pass MemoryListener around by value

 From the descriptions, it looks like

         xen-block: Avoid leaks on new error path
         thread-pool: signal "request_cond" while locked
         xen-platform: do full PCI reset during unplug of IDE devices

should be applied to -stable.

More, it looks like all 3 should be applied to v7.2.x series too,
including the PCI reset one, which is a bit problematic for 7.2
because it lacks dfa6ba6baeebe "Replace use of qdev_reset_all()
with device_cold_reset()", but that change was mechanical.

Olaf, can you please take a look at
https://gitlab.com/mjt0k/qemu/-/commit/645d74c366c8c6334bf9a3403f780adefe4e410f
(from https://gitlab.com/mjt0k/qemu/-/commits/staging-7.2/ )
and check if it makes sense?

Or if whole thing makes no sense to backport to stable, please
let me know as well.

Thanks!

/mjt

