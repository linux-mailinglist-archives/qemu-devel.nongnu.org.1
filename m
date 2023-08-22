Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB19E784A81
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:34:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYX83-0003sA-AK; Tue, 22 Aug 2023 15:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qYX80-0003rr-VP; Tue, 22 Aug 2023 15:33:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qYX7y-0004i4-Lf; Tue, 22 Aug 2023 15:33:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 411C41C29C;
 Tue, 22 Aug 2023 22:33:28 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E929521180;
 Tue, 22 Aug 2023 22:33:09 +0300 (MSK)
Message-ID: <f78e864b-6166-f4ea-5700-053df6764400@tls.msk.ru>
Date: Tue, 22 Aug 2023 22:33:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 0/9] Replace remaining target_ulong in system-mode accel
Content-Language: en-US
To: timothee.cocault@gmail.com, richard.henderson@linaro.org, anjo@rev.ng
Cc: qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
References: <00e9e08eae1004ef67fe8dca3aaf5043e6863faa.camel@gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <00e9e08eae1004ef67fe8dca3aaf5043e6863faa.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -86
X-Spam_score: -8.7
X-Spam_bar: --------
X-Spam_report: (-8.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.767,
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

22.08.2023 22:02, timothee.cocault@gmail.com wrote:
> Hi,
> 
> Maybe its too late for the 8.1 window, but I noticed that this patchset
> fixes a segfault in qemu-system-ppc (and other 32 bits archs ?) introduced by
> commit fb2c53c.
> Therefore maybe it would be relevant to get merge it before 8.2.

It's definitely too later for 8.1.0 (which has been tagged earlier today,
and it has been too later at -rc4 already).  But it's not too late for
8.1.1 stable series, so a fix can be applied to stable-8.1 (Cc'ing
qemu-stable@).

It seems I can reproduce the crash.

Thanks,

/mjt


