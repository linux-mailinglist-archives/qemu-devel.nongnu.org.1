Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B02AD20E7
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Jun 2025 16:32:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOdWh-0000Of-CE; Mon, 09 Jun 2025 10:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uOdWV-0000NE-0b; Mon, 09 Jun 2025 10:30:55 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uOdWS-0004pD-5l; Mon, 09 Jun 2025 10:30:50 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:471f:0:640:3878:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E789A60B77;
 Mon,  9 Jun 2025 17:30:41 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a98::1:26] (unknown
 [2a02:6bf:8080:a98::1:26])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id fUiOGE8FfGk0-R7itS2JV; Mon, 09 Jun 2025 17:30:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1749479441;
 bh=a/BTirhYqd7bOq4ECVFJVG5c4kJmFsa1B/lVFv3GNrI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=aTx7XP3u4bBVkLpkC8y2JRTeaiBnNIg87znXLxp+AmgqhEe0rw8wP9wLZdyJKc7vk
 2A4uRNdMTPFliksN+v8Ij/B6l56BVexgflZfzZaiLIy0ybNktq40DvR7BxCW59P6uC
 ySfZb5DpLF+e2K0KXI3Gr9Y9kHKCZPhJbzfZTBS8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <249ea968-82fb-41d6-b724-1aada58ce460@yandex-team.ru>
Date: Mon, 9 Jun 2025 17:30:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] block/copy-before-write: inverse access bitmap
To: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, eblake@redhat.com
Cc: qemu-block@nongnu.org, jsnow@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, qemu-devel@nongnu.org, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
References: <20250528120732.2247150-1-andrey.zhadchenko@virtuozzo.com>
 <20250528120732.2247150-4-andrey.zhadchenko@virtuozzo.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250528120732.2247150-4-andrey.zhadchenko@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 28.05.25 15:07, Andrey Zhadchenko wrote:
> HBitmaps allow us to search set bits pretty fast. On the contrary,
> when searching zeroes, we may be forced to fully traverse the lower
> level.
> When we run blockdev-backup with mode=full on top of snapshot filter
> + cbw filter, the job fills copy bitmap by calling block_status()
> with range (X, virtual_size). The problem is that we check for zeroes
> in this whole range. We also hit the worst case here, as access
> bitmap is fully set and we need to scan the entire lowest level.
> After scanning the full bitmap we actually ask the block status of
> original image, which may return significantly lower amount of empty
> clusters.
> Beacuse of this, the backup job 'hangs' on block copy initializaiton
> for a long time with 100% CPU.
> 
> Example copy bitmap buildup time for image with clu_size=65536 and
> preallocated metadata
> size                 10T   11T
> blockdev-backup      52s   57s
> cbw + snap           325s  413s
> cbw + snap + patch   55s   61s
> 
> To fix it, inverse the access bitmap in cbw filter: rather set it
> when the user is not allowed to read the cluster.
> 
> Update qemu-iotest 257: now access bitmap have count 0 instead of
> the image size 67108864
> 
> Signed-off-by: Andrey Zhadchenko<andrey.zhadchenko@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


