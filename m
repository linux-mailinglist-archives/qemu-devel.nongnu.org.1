Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2557C665A
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 09:25:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqq3x-0003Vk-8q; Thu, 12 Oct 2023 03:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qqq3q-0003Ti-7P; Thu, 12 Oct 2023 03:24:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qqq3o-0002ZR-AX; Thu, 12 Oct 2023 03:24:45 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 085B129AE0;
 Thu, 12 Oct 2023 10:24:47 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CE6662E9BE;
 Thu, 12 Oct 2023 10:24:39 +0300 (MSK)
Message-ID: <afe95ff5-9e32-42c9-a7d6-e20df8f71ad7@tls.msk.ru>
Date: Thu, 12 Oct 2023 10:24:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Stable-8.1.2 00/61] Patch Round-up for stable 8.1.2, freeze on
 2023-10-14
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <qemu-stable-8.1.2-20231012101342@cover.tls.msk.ru>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <qemu-stable-8.1.2-20231012101342@cover.tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

12.10.2023 10:16, Michael Tokarev:
..
> I was quite busy the last few days, - so I had to move the initially planned
> release by 2 days, - freeze from Oct-10 to Oct-12 (today), release from
> Oct-12 to Oct-14.  Please excuse me for this delay.

Sigh.  That's a fiasco, bro :)) Being busy does not help doing things well :)

Sure thing the initial plans are in order, planned for Oct-14 and release date
for Oct-16.

/mjt

