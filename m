Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB007B8478
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:05:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4ME-0005D2-L8; Wed, 04 Oct 2023 12:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qo4M9-00053f-DM; Wed, 04 Oct 2023 12:04:15 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qo4M7-00055t-1B; Wed, 04 Oct 2023 12:04:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:4c13:0:640:3c7:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id A555A60264;
 Wed,  4 Oct 2023 19:04:05 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:2::1:1c] (unknown [2a02:6b8:b081:2::1:1c])
 by mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id 24aNuV2OmmI0-ALoByiBa; 
 Wed, 04 Oct 2023 19:04:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696435445;
 bh=h9WdnQrX/TJwJECYK2YDdxuprPB86mGS1StWTkf2vLE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=W+9FeC7VQUwDTuBeKRtjEvt679NTVUeSlQphCtpPxMOJ3VE9Agv5rObbcunX8Y9Ad
 RZGtA2pppKoIoEitrQ6fQgwKB9slo/8FWbjr7N6XI5TrPtUP33I7OaOYErkzOt/XUe
 VtBpCgZk3LsegzomBm5YWyWV23yiPZ4n0STnbjNE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <91c048b3-99f4-b057-5acb-36bbcb5f8e75@yandex-team.ru>
Date: Wed, 4 Oct 2023 19:04:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC] migration/block-dirty-bitmap: make loading bitmap for
 device with iothread future-proof
Content-Language: en-US
To: quintela@redhat.com, Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, fam@euphon.net,
 eblake@redhat.com, jsnow@redhat.com, peterx@redhat.com, leobras@redhat.com,
 qemu-block@nongnu.org
References: <20230728133928.256898-1-f.ebner@proxmox.com>
 <871qgocz3l.fsf@secure.mitica>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <871qgocz3l.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
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

On 31.07.23 10:35, Juan Quintela wrote:
> Fiona Ebner <f.ebner@proxmox.com> wrote:
>> The bdrv_create_dirty_bitmap() function (which is also called by
>> bdrv_dirty_bitmap_create_successor()) uses bdrv_getlength(bs). This is
>> a wrapper around a coroutine, and when not called in coroutine context
>> would use bdrv_poll_co(). Such a call would trigger an assert() if the
>> correct AioContext hasn't been acquired before, because polling would
>> try to release the AioContext.
> 
> The ingenous in me thinks:
> 
> If the problem is that bdrv_poll_co() release an AioContext that it
> don't have acquired, perhaps we should fix bdrv_poll_co().
> 
> Ha!!!
> 
> $ find . -type f -exec grep --color=auto -nH --null -e bdrv_poll_co \{\} +
> ./scripts/block-coroutine-wrapper.py\0173:
> bdrv_poll_co(&s.poll_state);
> ./scripts/block-coroutine-wrapper.py\0198:
> bdrv_poll_co(&s.poll_state);
> ./block/block-gen.h\038:static inline void bdrv_poll_co(BdrvPollCo *s)
> $
> 
> /me retreats

The function is used in generated code. There are a lot of calls in build/block/block-gen.c if grep after make.

> 
>> The issue does not happen for migration, because the call happens
>> from process_incoming_migration_co(), i.e. in coroutine context. So
>> the bdrv_getlength() wrapper will just call bdrv_co_getlength()
>> directly without polling.
> 
> The ingenous in me wonders why bdrv_getlength() needs to use coroutines
> at all, but as I have been burned on the previous paragraph, I learn not
> to even try.
> 
> Ok, I never learn, so I do a grep and I see two appearces of
> bdrv_getlength in include files, but grep only shows uses of the
> function, not a real definition.

the function is generated, and after building, it's definition is in build/block/block-gen.c

The information is in comment in include/block/block-common.h.

The link, which lead from function declaration to the comment is "co_wrapper", but that's not obvious when just grep the function name.


-- 
Best regards,
Vladimir


