Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD692768EFF
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 09:37:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQNRY-0003mB-Bl; Mon, 31 Jul 2023 03:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qQNRW-0003lv-Ml
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qQNRT-0001mB-Ta
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690788947;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=aaQOZ1fhQe47H+x8WU8FfGD9jMNc3ay/IDB+pAdswJk=;
 b=BzeVh98GwXQIJOd1r1RbWzRjlhgbvwWPJ0U/AsvhGAaae3QtmiCkmgVTTBPmnTOH7u4qSo
 KMMn/f8KofRuCDusk9zfbakMJ1s+Hir/SoODE6Idh5emWiHltBnMR8lc3FONLvoP6FSK8B
 3r3sjxIgPDvRVwaX+1w03TjrlFKfwdU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-47LHXdu5Pb-uyf-UEh_kDQ-1; Mon, 31 Jul 2023 03:35:44 -0400
X-MC-Unique: 47LHXdu5Pb-uyf-UEh_kDQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fd2dec82a6so27139935e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 00:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690788943; x=1691393743;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aaQOZ1fhQe47H+x8WU8FfGD9jMNc3ay/IDB+pAdswJk=;
 b=WnjltApuwkklwXCvN9Z5tYgolgpa4Nlpd2Ez2ca5icV65+p8Jkc+i2UZKMjwi5w2Bt
 ruGj12c8QE10IpOfvK9nVa/sio6rhboGGthe61kjiXpNu0FiTd1nsd3wdpz5Akmtds8E
 +YumOX2nxmWtsUB/XzpW3ws5RVYuuxJj413C8Hq5yNokY0XoBaYK2GCHHRARiwHrowEs
 ROyvbAs1sS+Qn4Pgfld8dOrYG4huOTiRv7QOCYdr/qT2V5m+RrOrT4khGWKCHJVlgi5O
 jQ2xu3pR60WL39ULFJdjg9eTc39z7ps2l2mvYdVAWa9U+OqY297M4ofjPSEyebxtKjCc
 HZAQ==
X-Gm-Message-State: ABy/qLbaSTr8kkjsFvzzCA7Y1bXzY9rrVnBM6t3UPs0ZCA1lG1G1ytNv
 tpzM55nevTfm35CP1kCshM/kLUFejRqP5TGR2lSexoKSO8f20p6qT3obUpoTkRrg3yXDQSJYhSw
 RILM5+Zf8msQF7gI=
X-Received: by 2002:a05:600c:230a:b0:3fe:23c2:a8ee with SMTP id
 10-20020a05600c230a00b003fe23c2a8eemr507243wmo.6.1690788943689; 
 Mon, 31 Jul 2023 00:35:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHxkWzDFYvmvtaeDKVznwdTR9J3IvXfVudVzf1K3lARZWa9lY6UqkYlE9eQ46ROZc4OZhMEzw==
X-Received: by 2002:a05:600c:230a:b0:3fe:23c2:a8ee with SMTP id
 10-20020a05600c230a00b003fe23c2a8eemr507227wmo.6.1690788943340; 
 Mon, 31 Jul 2023 00:35:43 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 24-20020a05600c229800b003fbcdba1a52sm13317084wmf.3.2023.07.31.00.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 00:35:42 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  stefanha@redhat.com,  fam@euphon.net,
 eblake@redhat.com,  vsementsov@yandex-team.ru,  jsnow@redhat.com,
 peterx@redhat.com,  leobras@redhat.com,  qemu-block@nongnu.org
Subject: Re: [RFC] migration/block-dirty-bitmap: make loading bitmap for
 device with iothread future-proof
In-Reply-To: <20230728133928.256898-1-f.ebner@proxmox.com> (Fiona Ebner's
 message of "Fri, 28 Jul 2023 15:39:28 +0200")
References: <20230728133928.256898-1-f.ebner@proxmox.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Mon, 31 Jul 2023 09:35:42 +0200
Message-ID: <871qgocz3l.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fiona Ebner <f.ebner@proxmox.com> wrote:
> The bdrv_create_dirty_bitmap() function (which is also called by
> bdrv_dirty_bitmap_create_successor()) uses bdrv_getlength(bs). This is
> a wrapper around a coroutine, and when not called in coroutine context
> would use bdrv_poll_co(). Such a call would trigger an assert() if the
> correct AioContext hasn't been acquired before, because polling would
> try to release the AioContext.

The ingenous in me thinks:

If the problem is that bdrv_poll_co() release an AioContext that it
don't have acquired, perhaps we should fix bdrv_poll_co().

Ha!!!

$ find . -type f -exec grep --color=auto -nH --null -e bdrv_poll_co \{\} +
./scripts/block-coroutine-wrapper.py\0173:
bdrv_poll_co(&s.poll_state);
./scripts/block-coroutine-wrapper.py\0198:
bdrv_poll_co(&s.poll_state);
./block/block-gen.h\038:static inline void bdrv_poll_co(BdrvPollCo *s)
$

/me retreats

> The issue does not happen for migration, because the call happens
> from process_incoming_migration_co(), i.e. in coroutine context. So
> the bdrv_getlength() wrapper will just call bdrv_co_getlength()
> directly without polling.

The ingenous in me wonders why bdrv_getlength() needs to use coroutines
at all, but as I have been burned on the previous paragraph, I learn not
to even try.

Ok, I never learn, so I do a grep and I see two appearces of
bdrv_getlength in include files, but grep only shows uses of the
function, not a real definition.

I even see

co_wrapper_mixed_bdrv_rdlock

And decied to stop here.


> The issue would happen for snapshots, but won't in practice, because
> saving a snapshot with a block dirty bitmap is currently not possible.
> The reason is that dirty_bitmap_save_iterate() returns whether it has
> completed the bulk phase, which only happens in postcopy, so
> qemu_savevm_state_iterate() will always return 0, meaning the call
> to iterate will be repeated over and over again without ever reaching
> the completion phase.
>
> Still, this would make the code more robust for the future.

What I wonder is if we should annotate this calls somehow that they need
to be called from a coroutine context, because I would have never found
it.

And just thinking loud:

I still wonder if we should make incoming migration its own thread.
Because we got more and more problems because it is a coroutine, that in
non-multifd case can consume a whole CPU alone, so it makes no sense to
have a coroutine.

On the other hand, with multifd, it almost don't use any resources, so ....

> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>
> We ran into this issue downstream, because we have a custom snapshot
> mechanism which does support dirty bitmaps and does not run in
> coroutine context during load.
>
>  migration/block-dirty-bitmap.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 032fc5f405..e1ae3b7316 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -805,8 +805,11 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
>                       "destination", bdrv_dirty_bitmap_name(s->bitmap));
>          return -EINVAL;
>      } else {
> +        AioContext *ctx = bdrv_get_aio_context(s->bs);
> +        aio_context_acquire(ctx);
>          s->bitmap = bdrv_create_dirty_bitmap(s->bs, granularity,
>                                               s->bitmap_name, &local_err);
> +        aio_context_release(ctx);
>          if (!s->bitmap) {
>              error_report_err(local_err);
>              return -EINVAL;

I was going to suggest to put that code inside brdv_create_dirty_bitmap,
because migration come is already complex enough without knowing about
AioContext, but it appears that this pattern is already used in several
places.

> @@ -833,7 +836,10 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
>  
>      bdrv_disable_dirty_bitmap(s->bitmap);
>      if (flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED) {
> +        AioContext *ctx = bdrv_get_aio_context(s->bs);
> +        aio_context_acquire(ctx);
>          bdrv_dirty_bitmap_create_successor(s->bitmap, &local_err);
> +        aio_context_release(ctx);
>          if (local_err) {
>              error_report_err(local_err);
>              return -EINVAL;

for(i=1; i < 1000; i++)
         printf(""I will not grep what a successor of a dirty bitmap
         is\n");

Later, Juan.


