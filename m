Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C622182B04B
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:07:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvho-0005ul-90; Thu, 11 Jan 2024 09:06:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rNvhk-0005u8-22
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:06:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rNvhh-0000wD-Hc
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704982000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u9bLRmooHLl4RSqkDRvc4W+yK9t+LZA/vABkoYtkJWA=;
 b=Hq+V+snGw8pYPAiW65zvpt49Z9N6wZnNj8Q+eGdVnwufAKXUg+/GLTEO0Qsc2sbLmiiGUy
 WPYuNDssnLoGWPM0X9JRbkbXZh2Vbz7LxCkv7JyV4Jo9kutUWsN4joN/gGklmCTdWj8VgP
 cG0obKYqPjQHU3cj9uky7x8Y3L4aVF8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-gy0FsaDmM_CIxKxgoYK18g-1; Thu, 11 Jan 2024 09:06:38 -0500
X-MC-Unique: gy0FsaDmM_CIxKxgoYK18g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CB6385A588;
 Thu, 11 Jan 2024 14:06:38 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EA43492BF0;
 Thu, 11 Jan 2024 14:06:37 +0000 (UTC)
Date: Thu, 11 Jan 2024 15:06:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Ari Sundholm <ari@tuxera.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH] block/blklogwrites: Protect mutable driver state with a
 mutex.
Message-ID: <ZZ_17BiyiQcS2kV5@redhat.com>
References: <f1960d8d-352e-4e1b-4d28-7a110e272356@tuxera.com>
 <20240110195005.1263619-1-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110195005.1263619-1-ari@tuxera.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 10.01.2024 um 20:50 hat Ari Sundholm geschrieben:
> During the review of a fix for a concurrency issue in blklogwrites,
> it was found that the driver needs an additional fix when enabling
> multiqueue, which is a new feature introduced in QEMU 9.0, as the
> driver state may be read and written by multiple threads at the same
> time, which was not the case when the driver was originally written.
> 
> Fix the multi-threaded scenario by introducing a mutex to protect the
> mutable fields in the driver state, and always having the mutex locked
> by the current thread when accessing them.
> 
> Additionally, add the const qualifier to a few BDRVBlkLogWritesState
> pointer targets in contexts where the driver state is not written to.
> 
> Signed-off-by: Ari Sundholm <ari@tuxera.com>
> ---
>  block/blklogwrites.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blklogwrites.c b/block/blklogwrites.c
> index ba717dab4d..50f68df2a6 100644
> --- a/block/blklogwrites.c
> +++ b/block/blklogwrites.c
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (c) 2017 Tuomas Tynkkynen <tuomas@tuxera.com>
>   * Copyright (c) 2018 Aapo Vienamo <aapo@tuxera.com>
> - * Copyright (c) 2018 Ari Sundholm <ari@tuxera.com>
> + * Copyright (c) 2018-2024 Ari Sundholm <ari@tuxera.com>
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or later.
>   * See the COPYING file in the top-level directory.
> @@ -55,9 +55,18 @@ typedef struct {
>      BdrvChild *log_file;
>      uint32_t sectorsize;
>      uint32_t sectorbits;
> +    uint64_t update_interval;
> +
> +    /*
> +     * The mutable state of the driver, consisting of the current log sector
> +     * and the number of log entries.
> +     *
> +     * May be read and/or written from multiple threads, and the mutex must be
> +     * held when accessing these fields.
> +     */
>      uint64_t cur_log_sector;
>      uint64_t nr_entries;
> -    uint64_t update_interval;
> +    QemuMutex mutex;
>  } BDRVBlkLogWritesState;
>  
>  static QemuOptsList runtime_opts = {
> @@ -149,6 +158,7 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
>      uint64_t log_sector_size;
>      bool log_append;
>  
> +    qemu_mutex_init(&s->mutex);
>      opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
>      if (!qemu_opts_absorb_qdict(opts, options, errp)) {
>          ret = -EINVAL;
> @@ -255,6 +265,7 @@ fail_log:
>          bdrv_unref_child(bs, s->log_file);
>          bdrv_graph_wrunlock();
>          s->log_file = NULL;
> +        qemu_mutex_destroy(&s->mutex);
>      }
>  fail:
>      qemu_opts_del(opts);
> @@ -269,6 +280,7 @@ static void blk_log_writes_close(BlockDriverState *bs)
>      bdrv_unref_child(bs, s->log_file);
>      s->log_file = NULL;
>      bdrv_graph_wrunlock();
> +    qemu_mutex_destroy(&s->mutex);
>  }
>  
>  static int64_t coroutine_fn GRAPH_RDLOCK
> @@ -295,7 +307,7 @@ static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c,
>  
>  static void blk_log_writes_refresh_limits(BlockDriverState *bs, Error **errp)
>  {
> -    BDRVBlkLogWritesState *s = bs->opaque;
> +    const BDRVBlkLogWritesState *s = bs->opaque;
>      bs->bl.request_alignment = s->sectorsize;
>  }
>  
> @@ -338,15 +350,18 @@ blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
>       * driver may be modified by other driver operations while waiting for the
>       * I/O to complete.
>       */
> +    qemu_mutex_lock(&s->mutex);
>      const uint64_t entry_start_sector = s->cur_log_sector;
>      const uint64_t entry_offset = entry_start_sector << s->sectorbits;
>      const uint64_t qiov_aligned_size = ROUND_UP(lr->qiov->size, s->sectorsize);
>      const uint64_t entry_aligned_size = qiov_aligned_size +
>          ROUND_UP(lr->zero_size, s->sectorsize);
>      const uint64_t entry_nr_sectors = entry_aligned_size >> s->sectorbits;
> +    const uint64_t entry_seq = s->nr_entries + 1;
>  
> -    s->nr_entries++;
> +    s->nr_entries = entry_seq;
>      s->cur_log_sector += entry_nr_sectors;
> +    qemu_mutex_unlock(&s->mutex);
>  
>      /*
>       * Write the log entry. Note that if this is a "write zeroes" operation,
> @@ -366,14 +381,16 @@ blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
>  
>      /* Update super block on flush or every update interval */
>      if (lr->log_ret == 0 && ((lr->entry.flags & LOG_FLUSH_FLAG)
> -        || (s->nr_entries % s->update_interval == 0)))
> +        || (entry_seq % s->update_interval == 0)))
>      {
> +        qemu_mutex_lock(&s->mutex);
>          struct log_write_super super = {
>              .magic      = cpu_to_le64(WRITE_LOG_MAGIC),
>              .version    = cpu_to_le64(WRITE_LOG_VERSION),
>              .nr_entries = cpu_to_le64(s->nr_entries),
>              .sectorsize = cpu_to_le32(s->sectorsize),
>          };
> +        qemu_mutex_unlock(&s->mutex);

This hunk looks odd. Is the only thing the lock does here that
s->nr_entries is accessed atomically?

Looking a bit closer, if s->nr_entries has been changed (increased)
meanwhile by another request, I assume that we indeed want the newer
value to be stored in the superblock rather than using the value that
was current when we did the calculations. So superficially, this part
looks good.

But the other thing I notice is that a few lines down you can get
concurrent write requests to the superblock, and there is no guaranteed
order, so an older update could overwrite a newer one. Don't we need to
serialise writes to the superblock? (I would actually expect this to be
a problem already without multithreading.)

Kevin


