Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 321B57B84B8
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:15:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4Vi-0005gi-Ca; Wed, 04 Oct 2023 12:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qo4VY-0005dp-Hu; Wed, 04 Oct 2023 12:13:56 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qo4VT-0001ad-He; Wed, 04 Oct 2023 12:13:54 -0400
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:b9a4:0:640:eb37:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 1013D635CE;
 Wed,  4 Oct 2023 19:13:46 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:2::1:1c] (unknown [2a02:6b8:b081:2::1:1c])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id iDaOPt2OrmI0-WfxCdJiu; 
 Wed, 04 Oct 2023 19:13:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696436025;
 bh=VW4ZHHiriMqO9ycMOqBhVBRfU0w9RDBjhfDZ7O7HtcA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=YNhW2SOq0CaDlOdk8B1ikEJQkyyIR+NJW6bmkFBN/H9na5iS2R+va+dZkakKvNXrs
 Li0mD0PEs1mtxbWA1IXfiMt0vwCi4SmL1vxsjv4TwTAGHBcn5VeLkDTB1VNEq/G/vU
 ibLLbN9p+cG1pFY7xyz8stdTRgRmAu6R7CC8rwSA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2bd867e1-1556-63f4-0ed8-6474278bad33@yandex-team.ru>
Date: Wed, 4 Oct 2023 19:13:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC] migration/block-dirty-bitmap: make loading bitmap for
 device with iothread future-proof
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, fam@euphon.net, eblake@redhat.com, jsnow@redhat.com, 
 quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>
References: <20230728133928.256898-1-f.ebner@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230728133928.256898-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

add Kevin, Paolo, Emanuele, pls take a look

On 28.07.23 16:39, Fiona Ebner wrote:
> The bdrv_create_dirty_bitmap() function (which is also called by
> bdrv_dirty_bitmap_create_successor()) uses bdrv_getlength(bs). This is
> a wrapper around a coroutine, and when not called in coroutine context
> would use bdrv_poll_co(). Such a call would trigger an assert() if the
> correct AioContext hasn't been acquired before, because polling would
> try to release the AioContext.
> 
> The issue does not happen for migration, because the call happens
> from process_incoming_migration_co(), i.e. in coroutine context. So
> the bdrv_getlength() wrapper will just call bdrv_co_getlength()
> directly without polling.
> 
> The issue would happen for snapshots, but won't in practice, because
> saving a snapshot with a block dirty bitmap is currently not possible.
> The reason is that dirty_bitmap_save_iterate() returns whether it has
> completed the bulk phase, which only happens in postcopy, so
> qemu_savevm_state_iterate() will always return 0, meaning the call
> to iterate will be repeated over and over again without ever reaching
> the completion phase.
> 
> Still, this would make the code more robust for the future.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> We ran into this issue downstream, because we have a custom snapshot
> mechanism which does support dirty bitmaps and does not run in
> coroutine context during load.
> 
>   migration/block-dirty-bitmap.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 032fc5f405..e1ae3b7316 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -805,8 +805,11 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
>                        "destination", bdrv_dirty_bitmap_name(s->bitmap));
>           return -EINVAL;
>       } else {
> +        AioContext *ctx = bdrv_get_aio_context(s->bs);
> +        aio_context_acquire(ctx);
>           s->bitmap = bdrv_create_dirty_bitmap(s->bs, granularity,
>                                                s->bitmap_name, &local_err);
> +        aio_context_release(ctx);
>           if (!s->bitmap) {
>               error_report_err(local_err);
>               return -EINVAL;
> @@ -833,7 +836,10 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
>   
>       bdrv_disable_dirty_bitmap(s->bitmap);
>       if (flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED) {
> +        AioContext *ctx = bdrv_get_aio_context(s->bs);
> +        aio_context_acquire(ctx);
>           bdrv_dirty_bitmap_create_successor(s->bitmap, &local_err);
> +        aio_context_release(ctx);

Would not this deadlock in current code? When we have the only one aio context and therefore we are already in it?

If as Juan said, we rework incoming migration coroutine to be a separate thread, this patch becomes more correct, I think..

If keep coroutine, I think, we should check are we already in that aio context, and if so we should not acquire it.

>           if (local_err) {
>               error_report_err(local_err);
>               return -EINVAL;

-- 
Best regards,
Vladimir


