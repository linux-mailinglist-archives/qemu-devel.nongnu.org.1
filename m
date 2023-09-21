Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BECF7A99CA
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 20:23:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjOJO-0007E6-V7; Thu, 21 Sep 2023 14:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjOJM-0007Dt-L2; Thu, 21 Sep 2023 14:22:00 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjOJI-0000PE-Nt; Thu, 21 Sep 2023 14:21:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6344724087;
 Thu, 21 Sep 2023 21:22:13 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 70AD529D92;
 Thu, 21 Sep 2023 21:21:50 +0300 (MSK)
Message-ID: <dc216d15-1649-e2a4-b77a-e194e8a25456@tls.msk.ru>
Date: Thu, 21 Sep 2023 21:21:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/5] file-posix: Clean up and fix zoned checks
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Sam Li <faithilikerun@gmail.com>
References: <20230824155345.109765-1-hreitz@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230824155345.109765-1-hreitz@redhat.com>
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

24.08.2023 18:53, Hanna Czenczek wrote:
> Hi,
> 
> As presented in [1] there is a bug in the zone code in raw_co_prw(),
> specifically we don’t check whether there actually is zone information
> before running code that assumes there is (and thus we run into a
> division by zero).  This has now also been reported in [2].
> 
> I believe the solution [1] is incomplete, though, which is why I’m
> sending this separate series: I don’t think checking bs->wps and/or
> bs->bl.zone_size to determine whether there is zone information is
> right; for example, we do not have raw_refresh_zoned_limits() clear
> those values if on a refresh, zone information were to disappear.
> 
> It is also weird that we separate checking bs->wps and bs->bl.zone_size
> at all; raw_refresh_zoned_limits() seems to intend to ensure that either
> we have information with non-NULL bs->wps and non-zero bs->bl.zone_size,
> or we don’t.
> 
> I think we should have a single flag that tells whether we have valid
> information or not, and it looks to me like bs->bl.zoned != BLK_Z_NONE
> is the condition that fits best.
> 
> Patch 1 ensures that raw_refresh_zoned_limits() will set bs->bl.zoned to
> BLK_Z_NONE on error, so that we can actually be sure that this condition
> tells us whether we have valid information or not.
> 
> Patch 2 unifies all conditional checks for zone information to use
> bs->bl.zoned != BLK_Z_NONE.
> 
> Patch 3 is the I/O error path fix, which is not really different from
> [1].
> 
> Patch 4 does a bit of clean-up.
> 
> Patch 5 adds a regression test.
> 
> 
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg01742.html
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=2234374

Is this stable-worthy (at least 1-3)?  From the bug description it smells
like it should be in 8.1.x, or maybe whole series.

Thanks,

/mjt

