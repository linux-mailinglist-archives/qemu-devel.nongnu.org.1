Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE36716111
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:06:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3z30-0006oN-Oq; Tue, 30 May 2023 09:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q3z2b-0005Yq-VU; Tue, 30 May 2023 09:05:35 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q3z2W-0002PB-2P; Tue, 30 May 2023 09:05:33 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id EE525626A1;
 Tue, 30 May 2023 16:05:15 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a508::1:1d] (unknown
 [2a02:6b8:b081:a508::1:1d])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id E5MVJc5OdOs0-0XF0oxas; Tue, 30 May 2023 16:05:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1685451915; bh=zHje06az38PXQUX2daf5yeKrux8Lq2WqUjnfxGxDTJ8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=wggR4RkKSjL7dvG56xWTHT3UcGvYrY/bzKRtx6VwK6bEk+ISSxNkMn43Kn0YbfTf5
 kIdb66kdOGA+sh1x8DXKYDOdazRoJPs5vOGwhElIC4mTd53Wf67kevFr8hCmERl/Vx
 DvmDz5hSQ7YV2xem6Vrkde9QVpiYzWTawcQlrOXM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <15122ad7-bc5b-a54c-d412-ac82ce7215b0@yandex-team.ru>
Date: Tue, 30 May 2023 16:05:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 04/14] nbd: Prepare for 64-bit request effect lengths
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-5-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230515195343.1915857-5-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 15.05.23 22:53, Eric Blake wrote:
> Widen the length field of NBDRequest to 64-bits, although we can
> assert that all current uses are still under 32 bits.  Move the
> request magic number to nbd.h, to live alongside the reply magic
> number.  Convert 'bool structured_reply' into a tri-state enum that
> will eventually track whether the client successfully negotiated
> extended headers with the server, allowing the nbd driver to pass
> larger requests along where possible; although in this patch the enum
> never surpasses structured replies, for no semantic change yet.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>

Seems too much for one patch, could it could be split into
- Convert 'bool structured_reply'
- introduce third parameter for nbd_send_request()
- rework len to 64bit

otherwise, looks good to me

-- 
Best regards,
Vladimir


