Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C5E7B31C5
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 13:55:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmC4m-000676-Qe; Fri, 29 Sep 2023 07:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qmC4g-000616-5f; Fri, 29 Sep 2023 07:54:26 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qmC4X-0005M2-76; Fri, 29 Sep 2023 07:54:25 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:201e:0:640:d29a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 37DC46624A;
 Fri, 29 Sep 2023 14:54:12 +0300 (MSK)
Received: from [IPV6:2a02:6b8:0:419:1736:c17d:4e3a:9b6f] (unknown
 [2a02:6b8:0:419:1736:c17d:4e3a:9b6f])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BsQsJB0OkOs0-D6Ks6bPX; Fri, 29 Sep 2023 14:54:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695988451;
 bh=2D94ckFmKfUF6GMuTpKAFo9YCOqfa/or9yfdH3ZpI0A=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=QiVPZ4jE81LeAqNGRU8dmOV5I411/bqq6S9HnlI0I+0r8aDmxmcnfrRoQrF3i2Xnc
 AJ/LXr9P2T6SYiAcxWQBUMTZgueSHc9R0JI1ypZtPhA7VxX5u+KU/ibnjRNcb86bke
 ZeYPc0gKbItmLz5zCWqg2bXaqIMPkuRvdgJ38uJI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e4793383-e09e-2407-d22e-c89d99d01db9@yandex-team.ru>
Date: Fri, 29 Sep 2023 14:54:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 11/12] nbd/server: Prepare for per-request filtering of
 BLOCK_STATUS
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20230925192229.3186470-14-eblake@redhat.com>
 <20230925192229.3186470-25-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230925192229.3186470-25-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.295,
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

On 25.09.23 22:22, Eric Blake wrote:
> The next commit will add support for the optional extension
> NBD_CMD_FLAG_PAYLOAD during NBD_CMD_BLOCK_STATUS, where the client can
> request that the server only return a subset of negotiated contexts,
> rather than all contexts.  To make that task easier, this patch
> populates the list of contexts to return on a per-command basis (for
> now, identical to the full set of negotiated contexts).
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


