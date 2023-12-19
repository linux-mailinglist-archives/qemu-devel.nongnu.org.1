Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F097481912C
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 21:05:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFgKB-0001kD-Is; Tue, 19 Dec 2023 15:04:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rFgK8-0001k0-Be; Tue, 19 Dec 2023 15:04:16 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rFgK6-0002RG-JY; Tue, 19 Dec 2023 15:04:16 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-593f6fb21a5so382710eaf.2; 
 Tue, 19 Dec 2023 12:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703016253; x=1703621053; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DXg9cDW3JjUVqUpK7rz7cijjR5jU7WBvRbwK6otXN60=;
 b=JCOEkt64Q7K4irbMy0UdE/1BqcvMv4FyR9sE0V1Xbo67Wlhylb3o0qBOEPhgPflSvD
 qY2yUAhOs7hrqfD+3M+I+Uxg5q4tso5Ubt0metVr2GdDPAF5RY1OX9Ux1ZiYqMVEt9D+
 DaRh+DOkQ7A+99hmL3P2D1buatuJWaCCsPqHdZgRuC5t4pPSeswym/Bb8I6zWq6EbNtz
 BUSm7F5VldRYjHyKvuOT6bAaZHnD9Awl4BmnmVLsK8MgYVw6X+MR3KPXBIsKKlUVmVMl
 oF5FcpD+nKERQcV6TX9WTnhnLToqc+or4PgDTT9amC07bLBj156V8FB9s74brP+AOY1Y
 O78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703016253; x=1703621053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DXg9cDW3JjUVqUpK7rz7cijjR5jU7WBvRbwK6otXN60=;
 b=h8mdp/N5cY29VVYohsFZlig+NZtA8P7vp11EQiQh38J+urkVC3wS0CCT5aNfGdY3fQ
 SGvtRfo4nUbWhSBU/KpHuuCP4VlYhMNrXblhzeuwCak6Py3LJcbjSBRXFalG1m4tEGhf
 gcnFJIJQ4uqCTQCt3K0WkhcjhSLAv2yBLyXaYgYXihfbP8VO2KCtnH9316dSdV5GYnsj
 MAftW8ojiQyTOJF2lkZhEP233UgYQ3glQRvf0MD0Wf7WKAk1MShSeutArPnEvEyh1uBi
 /DJD6ZWb373rgsQ53xRKil+lOD3eJ42ylbofrzCmX34yMLjxqyvHOYofUwjg2Cf7nV1J
 /0ow==
X-Gm-Message-State: AOJu0YxZnp3Hf4SYygU1EHPa3s7YWKbKOWTtz5WZqET+hAIYqus+JLQ/
 fOwAsGKGQc13Kr8Y5NoxAmZRMLew23i0HXA0+HE=
X-Google-Smtp-Source: AGHT+IH0W7Lk4qYidn6qC1RIdBZwtv+70PgF1WA79AneRN/vlKbN6zwwagcHggVHwfD6j079x6f4wqmuhwuohs/5W6Q=
X-Received: by 2002:a05:6820:1c97:b0:58d:ca8b:7a83 with SMTP id
 ct23-20020a0568201c9700b0058dca8b7a83mr14112463oob.5.1703016252874; Tue, 19
 Dec 2023 12:04:12 -0800 (PST)
MIME-Version: 1.0
References: <20231205182011.1976568-1-stefanha@redhat.com>
 <20231205182011.1976568-7-stefanha@redhat.com>
 <ZYG9orsog3Pm675J@redhat.com>
In-Reply-To: <ZYG9orsog3Pm675J@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 19 Dec 2023 15:04:01 -0500
Message-ID: <CAJSP0QV1MD-U5f1NkgL13CEm6-rCcGGPNhRyE2jwTKz+22rrzA@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] block: remove AioContext locking
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Cleber Rosa <crosa@redhat.com>, 
 Xie Changlong <xiechanglong.d@gmail.com>, Paul Durrant <paul@xen.org>,
 Ari Sundholm <ari@tuxera.com>, 
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Wen Congyang <wencongyang2@huawei.com>, 
 Alberto Garcia <berto@igalia.com>, Anthony Perard <anthony.perard@citrix.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org, 
 Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, 
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Peter Xu <peterx@redhat.com>, 
 Emanuele Giuseppe Esposito <eesposit@redhat.com>, Fam Zheng <fam@euphon.net>,
 Leonardo Bras <leobras@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 19 Dec 2023 at 10:59, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 05.12.2023 um 19:20 hat Stefan Hajnoczi geschrieben:
> > This is the big patch that removes
> > aio_context_acquire()/aio_context_release() from the block layer and
> > affected block layer users.
> >
> > There isn't a clean way to split this patch and the reviewers are likely
> > the same group of people, so I decided to do it in one patch.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Paul Durrant <paul@xen.org>
>
> > diff --git a/migration/block.c b/migration/block.c
> > index a15f9bddcb..2bcfcbfdf6 100644
> > --- a/migration/block.c
> > +++ b/migration/block.c
> > @@ -313,22 +311,10 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
> >      block_mig_state.submitted++;
> >      blk_mig_unlock();
> >
> > -    /* We do not know if bs is under the main thread (and thus does
> > -     * not acquire the AioContext when doing AIO) or rather under
> > -     * dataplane.  Thus acquire both the iothread mutex and the
> > -     * AioContext.
> > -     *
> > -     * This is ugly and will disappear when we make bdrv_* thread-safe,
> > -     * without the need to acquire the AioContext.
> > -     */
> > -    qemu_mutex_lock_iothread();
> > -    aio_context_acquire(blk_get_aio_context(bmds->blk));
> >      bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, cur_sector * BDRV_SECTOR_SIZE,
> >                              nr_sectors * BDRV_SECTOR_SIZE);
> >      blk->aiocb = blk_aio_preadv(bb, cur_sector * BDRV_SECTOR_SIZE, &blk->qiov,
> >                                  0, blk_mig_read_cb, blk);
> > -    aio_context_release(blk_get_aio_context(bmds->blk));
> > -    qemu_mutex_unlock_iothread();
> >
> >      bmds->cur_sector = cur_sector + nr_sectors;
> >      return (bmds->cur_sector >= total_sectors);
>
> With this hunk applied, qemu-iotests 183 fails:
>
> (gdb) bt
> #0  0x000055aaa7d47c09 in bdrv_graph_co_rdlock () at ../block/graph-lock.c:176
> #1  0x000055aaa7d3de2e in graph_lockable_auto_lock (x=<optimized out>) at /home/kwolf/source/qemu/include/block/graph-lock.h:215
> #2  blk_co_do_preadv_part (blk=0x7f38a4000f30, offset=0, bytes=1048576, qiov=0x7f38a40250f0, qiov_offset=qiov_offset@entry=0, flags=0) at ../block/block-backend.c:1340
> #3  0x000055aaa7d3e006 in blk_aio_read_entry (opaque=0x7f38a4025140) at ../block/block-backend.c:1620
> #4  0x000055aaa7e7aa5b in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at ../util/coroutine-ucontext.c:177
> #5  0x00007f38d14dbe90 in __start_context () at /lib64/libc.so.6
> #6  0x00007f38b3dfa060 in  ()
> #7  0x0000000000000000 in  ()
>
> qemu_get_current_aio_context() returns NULL now. I don't completely
> understand why it depends on the BQL, but adding the BQL locking back
> fixes it.

Thanks for letting me know. I have reviewed migration/block.c and
agree that taking the BQL is correct.

I have inlined the fix below and will resend this patch.

Stefan
---
diff --git a/migration/block.c b/migration/block.c
index 2bcfcbfdf6..6ec6a1d6e6 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -311,10 +311,17 @@ static int mig_save_device_bulk(QEMUFile *f,
BlkMigDevState *bmds)
     block_mig_state.submitted++;
     blk_mig_unlock();

+    /*
+     * The migration thread does not have an AioContext. Lock the BQL so that
+     * I/O runs in the main loop AioContext (see
+     * qemu_get_current_aio_context()).
+     */
+    qemu_mutex_lock_iothread();
     bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, cur_sector * BDRV_SECTOR_SIZE,
                             nr_sectors * BDRV_SECTOR_SIZE);
     blk->aiocb = blk_aio_preadv(bb, cur_sector * BDRV_SECTOR_SIZE, &blk->qiov,
                                 0, blk_mig_read_cb, blk);
+    qemu_mutex_unlock_iothread();

     bmds->cur_sector = cur_sector + nr_sectors;
     return (bmds->cur_sector >= total_sectors);

