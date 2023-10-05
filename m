Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BC97BAADB
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 21:57:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoURw-0000b1-IL; Thu, 05 Oct 2023 15:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoURt-0000Rd-Eo; Thu, 05 Oct 2023 15:55:53 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoURp-0001Ae-LS; Thu, 05 Oct 2023 15:55:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:d11:0:640:6943:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id B0A0160A6E;
 Thu,  5 Oct 2023 22:55:43 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b4bf::1:10] (unknown
 [2a02:6b8:b081:b4bf::1:10])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id gteJEM4OoW20-NyRFKf5F; Thu, 05 Oct 2023 22:55:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696535743;
 bh=CjY+n7enCKotsYZUabVuRYSRchhqOLkcK7wlJ8KqFfo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=qZ35cyz4HYHpycq2htXVzjxKk6Y94oGOba2Ntt9Os1T1W8o/D+IYVc8rpUR9WDALn
 c4Smz/enPfTpYvNcnmfUyDwnX/RY1sE+RMtmpXdteiojrsU73KsFSJmcNVjEgIbyN8
 oXOdbKguccep9ixW+410KRjK8C9SVbdEo6Y7b/S8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <969ae041-3c17-475c-919c-5b33cb6d21c5@yandex-team.ru>
Date: Thu, 5 Oct 2023 22:55:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/21] preallocate: Don't poll during permission updates
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org
References: <20230911094620.45040-1-kwolf@redhat.com>
 <20230911094620.45040-4-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230911094620.45040-4-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11.09.23 12:46, Kevin Wolf wrote:
> When the permission related BlockDriver callbacks are called, we are in
> the middle of an operation traversing the block graph. Polling in such a
> place is a very bad idea because the graph could change in unexpected
> ways. In the future, callers will also hold the graph lock, which is
> likely to turn polling into a deadlock.
> 
> So we need to get rid of calls to functions like bdrv_getlength() or
> bdrv_truncate() there as these functions poll internally. They are
> currently used so that when no parent has write/resize permissions on
> the image any more, the preallocate filter drops the extra preallocated
> area in the image file and gives up write/resize permissions itself.
> 
> In order to achieve this without polling in .bdrv_check_perm, don't
> immediately truncate the image, but only schedule a BH to do so. The
> filter keeps the write/resize permissions a bit longer now until the BH
> has executed.
> 
> There is one case in which delaying doesn't work: Reopening the image
> read-only. In this case, bs->file will likely be reopened read-only,
> too, so keeping write permissions a bit longer on it doesn't work. But
> we can already cover this case in preallocate_reopen_prepare() and not
> rely on the permission updates for it.

Hmm, now I found one more "future" case.

I now try to rebase my "[PATCH v7 0/7] blockdev-replace" https://patchew.org/QEMU/20230421114102.884457-1-vsementsov@yandex-team.ru/

And it breaks after this commit.

By accident, blockdev-replace series uses exactly "preallocate" filter to test insertion/removing of filters. And removing is broken now.

Removing is done as follows:

1. We have filter inserted: disk0 -file-> filter -file-> file0

2. blockdev-replace, replaces file child of disk0, so we should get the picture*: disk0 -file-> file0 <-file- filter

3. blockdev-del filter


But step [2] fails, as now preallocate filter doesn't drop permissions during the operation (postponing this for a while) and the picture* is impossible. Permission check fails.

Hmmm... Any idea how blockdev-replace and preallocate filter should work :) ? Maybe, doing truncation in .drain_begin() will help? Will try

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---


-- 
Best regards,
Vladimir


