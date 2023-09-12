Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C63F679D992
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 21:30:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg94T-0006Po-Fp; Tue, 12 Sep 2023 15:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qg94Q-0006P3-GV; Tue, 12 Sep 2023 15:29:10 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qg94M-0003Ly-VN; Tue, 12 Sep 2023 15:29:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5dab:0:640:2989:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 795FA6222C;
 Tue, 12 Sep 2023 22:29:02 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8006::1:28] (unknown
 [2a02:6b8:b081:8006::1:28])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 1TkxpB0OnuQ0-HEyvy3kb; Tue, 12 Sep 2023 22:29:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1694546942;
 bh=/RJ0iAH6sGuY/bxkFXUxs3Y5Ck0jFAa2MmK7AN2Wxss=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=v9t0lMgl7ndfdC0+4maKSP7TXNNedMS5CHfK6Whjqv+XajP0ohoRQCK4Dn+8Fo9kO
 BFX7j/DtuzfnCq/8/nuNYLHoUn1pdioR/7lvG/magOiH1ZFp1Oab+fdGtDm0/pVbFK
 Wj2VXp/8P3gMLLVNHYDzfwFgBkEJgSxHI3zL9ShI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a8c81f0f-eb3e-0574-e6bb-4fed9005a7e6@yandex-team.ru>
Date: Tue, 12 Sep 2023 22:29:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] blockdev: qmp_transaction: harden transaction
 properties for bitmaps
Content-Language: en-US
To: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-devel@nongnu.org,
 den@virtuozzo.com
References: <20230904083116.568912-1-andrey.zhadchenko@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230904083116.568912-1-andrey.zhadchenko@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 04.09.23 11:31, Andrey Zhadchenko wrote:
> Unlike other transaction commands, bitmap operations do not drain target
> bds. If we have an IOThread, this may result in some inconsistencies, as
> bitmap content may change during transaction command.
> Add bdrv_drained_begin()/end() to bitmap operations.
> 
> Signed-off-by: Andrey Zhadchenko<andrey.zhadchenko@virtuozzo.com>

Hi!

First, please always include cover letter when more than 1 patch.

Next. Hmm. Good idea, but I'm afraid that's still not enough.

Assume you have two BSs A and B in two different iothreads. So, the sequence may be like this:

1. drain_begin A

2. do operation with bitmap in A

3. guest writes to B, B is modified and bitmap in B is modified as well

4. drain_begin B

5. do operation with bitmap in B

6. drain_end B

7. drain_end A

User may expect, that all the operations are done atomically in relation to any guest IO operations. And if operations are dependent, the intermediate write [3] make break the result.

So, we should drain all participant drives during the whole transactions. The simplest solution is bdrv_drain_all_begin() / bdrv_drain_all_end() pair in qmp_transaction(), could we start with it?

-- 
Best regards,
Vladimir


