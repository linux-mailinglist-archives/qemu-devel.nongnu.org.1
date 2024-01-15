Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ECC82D894
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 12:52:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPLV2-000579-3z; Mon, 15 Jan 2024 06:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPLUz-00056T-Ar
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 06:51:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPLUx-0002hq-8R
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 06:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705319481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jxUN6ATX3NUY3SInjREFCNjG6WHEIDrOtqUsIVazFOw=;
 b=QQ3+ND+4Aujbeo1YX5/xcnUODDlRz4nsPkC5GvwZFBSGTYkmL79+K1Kl06Bd/V0XKdPKDL
 sfn8rTWUMoGbQdNaMpY2k1+877WrZpYLpesl1udioZAdKvq7JLvKoI2xWtPIF6fp5Pecow
 TIyV1JUuDsbO8Z8S6nhJAS+VwhfXv+g=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-QHC_2LWFNaaywDQuCwaJHQ-1; Mon, 15 Jan 2024 06:51:19 -0500
X-MC-Unique: QHC_2LWFNaaywDQuCwaJHQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28db680c0f7so1315821a91.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 03:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705319478; x=1705924278;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jxUN6ATX3NUY3SInjREFCNjG6WHEIDrOtqUsIVazFOw=;
 b=EBeQaBUx0nlqrmlypM77upUWOnzmmTUCAsNQvY14IrP44RUciujCFl9yG0YZ/1lUGj
 niYeDqXPT11Lm9isAcSuLlpLU7xaQkw5Lt3ZX+lDASd3Q0IB2D9dEhWYcjA+nA4Xhszk
 CmShXSwH4sZtYvytfHKLHJsG8efKBQEx3ckwm7MAZkZTZrABLNRSLP5piTsVvpJU6ZLC
 8Tc0joJ+WbZ3VwL0zVBENB0qCpk7nIobs26Hj+tLnuqjFzI2FxOhrEtZSVyZ7wwEn5EJ
 nLuTboPG/b88DSy4zAtxZmuP78iA5/N/cKj4cVWjg3j4fcwB+pAV6k5efpfYCj66J1TT
 QN0w==
X-Gm-Message-State: AOJu0Yw9tWNwYL6smSntokhQjEi+f1FJo35hn30BDg4GC/mlxxwrhhmt
 mjLokdKxur/OAPZ+b5cINJOWl03iyCsXMl2re22gCuKEvqJEmFgj4Oj8R+ReG0gWrjSkZuBNrjn
 S7Jhw4cC211fKw3yRG9L1Bag=
X-Received: by 2002:aa7:9dc6:0:b0:6d9:383b:d91a with SMTP id
 g6-20020aa79dc6000000b006d9383bd91amr12744585pfq.1.1705319478338; 
 Mon, 15 Jan 2024 03:51:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuDbUiY5K3W0joYTeSv2T2fOZKcRscbILQtS+t+iihXhBo7PBIhwvGdm2HTRp3FK0TVH97oA==
X-Received: by 2002:aa7:9dc6:0:b0:6d9:383b:d91a with SMTP id
 g6-20020aa79dc6000000b006d9383bd91amr12744569pfq.1.1705319477932; 
 Mon, 15 Jan 2024 03:51:17 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 c1-20020a630d01000000b005cd64ff9a42sm7748072pgl.64.2024.01.15.03.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 03:51:17 -0800 (PST)
Date: Mon, 15 Jan 2024 19:51:07 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 11/30] migration/multifd: Allow multifd without
 packets
Message-ID: <ZaUcKy41AsAdqT0G@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-12-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127202612.23012-12-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Mon, Nov 27, 2023 at 05:25:53PM -0300, Fabiano Rosas wrote:
> For the upcoming support to the new 'fixed-ram' migration stream
> format, we cannot use multifd packets because each write into the
> ramblock section in the migration file is expected to contain only the
> guest pages. They are written at their respective offsets relative to
> the ramblock section header.
> 
> There is no space for the packet information and the expected gains
> from the new approach come partly from being able to write the pages
> sequentially without extraneous data in between.
> 
> The new format also doesn't need the packets and all necessary
> information can be taken from the standard migration headers with some
> (future) changes to multifd code.
> 
> Use the presence of the fixed-ram capability to decide whether to send
> packets. For now this has no effect as fixed-ram cannot yet be enabled
> with multifd.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> - moved more of the packet code under use_packets
> ---
>  migration/multifd.c | 138 +++++++++++++++++++++++++++-----------------
>  migration/options.c |   5 ++
>  migration/options.h |   1 +
>  3 files changed, 91 insertions(+), 53 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index ec58c58082..9625640d61 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -654,18 +654,22 @@ static void *multifd_send_thread(void *opaque)
>      Error *local_err = NULL;
>      int ret = 0;
>      bool use_zero_copy_send = migrate_zero_copy_send();
> +    bool use_packets = migrate_multifd_packets();
>  
>      thread = migration_threads_add(p->name, qemu_get_thread_id());
>  
>      trace_multifd_send_thread_start(p->id);
>      rcu_register_thread();
>  
> -    if (multifd_send_initial_packet(p, &local_err) < 0) {
> -        ret = -1;
> -        goto out;
> +    if (use_packets) {
> +        if (multifd_send_initial_packet(p, &local_err) < 0) {
> +            ret = -1;
> +            goto out;
> +        }
> +
> +        /* initial packet */
> +        p->num_packets = 1;
>      }
> -    /* initial packet */
> -    p->num_packets = 1;
>  
>      while (true) {
>          qemu_sem_post(&multifd_send_state->channels_ready);
> @@ -677,11 +681,10 @@ static void *multifd_send_thread(void *opaque)
>          qemu_mutex_lock(&p->mutex);
>  
>          if (p->pending_job) {
> -            uint64_t packet_num = p->packet_num;
>              uint32_t flags;
>              p->normal_num = 0;
>  
> -            if (use_zero_copy_send) {
> +            if (!use_packets || use_zero_copy_send) {
>                  p->iovs_num = 0;
>              } else {
>                  p->iovs_num = 1;
> @@ -699,16 +702,20 @@ static void *multifd_send_thread(void *opaque)
>                      break;
>                  }
>              }
> -            multifd_send_fill_packet(p);
> +
> +            if (use_packets) {
> +                multifd_send_fill_packet(p);
> +                p->num_packets++;
> +            }
> +
>              flags = p->flags;
>              p->flags = 0;
> -            p->num_packets++;
>              p->total_normal_pages += p->normal_num;
>              p->pages->num = 0;
>              p->pages->block = NULL;
>              qemu_mutex_unlock(&p->mutex);
>  
> -            trace_multifd_send(p->id, packet_num, p->normal_num, flags,
> +            trace_multifd_send(p->id, p->packet_num, p->normal_num, flags,
>                                 p->next_packet_size);
>  
>              if (use_zero_copy_send) {
> @@ -718,7 +725,7 @@ static void *multifd_send_thread(void *opaque)
>                  if (ret != 0) {
>                      break;
>                  }
> -            } else {
> +            } else if (use_packets) {
>                  /* Send header using the same writev call */
>                  p->iov[0].iov_len = p->packet_len;
>                  p->iov[0].iov_base = p->packet;
> @@ -904,6 +911,7 @@ int multifd_save_setup(Error **errp)
>  {
>      int thread_count;
>      uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> +    bool use_packets = migrate_multifd_packets();
>      uint8_t i;
>  
>      if (!migrate_multifd()) {
> @@ -928,14 +936,20 @@ int multifd_save_setup(Error **errp)
>          p->pending_job = 0;
>          p->id = i;
>          p->pages = multifd_pages_init(page_count);
> -        p->packet_len = sizeof(MultiFDPacket_t)
> -                      + sizeof(uint64_t) * page_count;
> -        p->packet = g_malloc0(p->packet_len);
> -        p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
> -        p->packet->version = cpu_to_be32(MULTIFD_VERSION);
> +
> +        if (use_packets) {
> +            p->packet_len = sizeof(MultiFDPacket_t)
> +                          + sizeof(uint64_t) * page_count;
> +            p->packet = g_malloc0(p->packet_len);
> +            p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
> +            p->packet->version = cpu_to_be32(MULTIFD_VERSION);
> +
> +            /* We need one extra place for the packet header */
> +            p->iov = g_new0(struct iovec, page_count + 1);
> +        } else {
> +            p->iov = g_new0(struct iovec, page_count);
> +        }
>          p->name = g_strdup_printf("multifdsend_%d", i);
> -        /* We need one extra place for the packet header */
> -        p->iov = g_new0(struct iovec, page_count + 1);
>          p->normal = g_new0(ram_addr_t, page_count);
>          p->page_size = qemu_target_page_size();
>          p->page_count = page_count;
> @@ -1067,7 +1081,7 @@ void multifd_recv_sync_main(void)
>  {
>      int i;
>  
> -    if (!migrate_multifd()) {
> +    if (!migrate_multifd() || !migrate_multifd_packets()) {
>          return;
>      }
>      for (i = 0; i < migrate_multifd_channels(); i++) {

This noops the recv sync when use_packets=1, makes sense.

How about multifd_send_sync_main()?  Should we do the same?

> @@ -1094,38 +1108,44 @@ static void *multifd_recv_thread(void *opaque)
>  {
>      MultiFDRecvParams *p = opaque;
>      Error *local_err = NULL;
> +    bool use_packets = migrate_multifd_packets();
>      int ret;
>  
>      trace_multifd_recv_thread_start(p->id);
>      rcu_register_thread();
>  
>      while (true) {
> -        uint32_t flags;
> +        uint32_t flags = 0;
> +        p->normal_num = 0;
>  
>          if (p->quit) {
>              break;
>          }
>  
> -        ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
> -                                       p->packet_len, &local_err);
> -        if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
> -            break;
> -        }
> +        if (use_packets) {
> +            ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
> +                                           p->packet_len, &local_err);
> +            if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
> +                break;
> +            }
> +
> +            qemu_mutex_lock(&p->mutex);
> +            ret = multifd_recv_unfill_packet(p, &local_err);
> +            if (ret) {
> +                qemu_mutex_unlock(&p->mutex);
> +                break;
> +            }
> +            p->num_packets++;
> +
> +            flags = p->flags;
> +            /* recv methods don't know how to handle the SYNC flag */
> +            p->flags &= ~MULTIFD_FLAG_SYNC;
> +            trace_multifd_recv(p->id, p->packet_num, p->normal_num, flags,
> +                               p->next_packet_size);
>  
> -        qemu_mutex_lock(&p->mutex);
> -        ret = multifd_recv_unfill_packet(p, &local_err);
> -        if (ret) {
> -            qemu_mutex_unlock(&p->mutex);
> -            break;
> +            p->total_normal_pages += p->normal_num;
>          }
>  
> -        flags = p->flags;
> -        /* recv methods don't know how to handle the SYNC flag */
> -        p->flags &= ~MULTIFD_FLAG_SYNC;
> -        trace_multifd_recv(p->id, p->packet_num, p->normal_num, flags,
> -                           p->next_packet_size);
> -        p->num_packets++;
> -        p->total_normal_pages += p->normal_num;
>          qemu_mutex_unlock(&p->mutex);
>  
>          if (p->normal_num) {
> @@ -1135,7 +1155,7 @@ static void *multifd_recv_thread(void *opaque)
>              }
>          }
>  
> -        if (flags & MULTIFD_FLAG_SYNC) {
> +        if (use_packets && (flags & MULTIFD_FLAG_SYNC)) {
>              qemu_sem_post(&multifd_recv_state->sem_sync);
>              qemu_sem_wait(&p->sem_sync);
>          }
> @@ -1159,6 +1179,7 @@ int multifd_load_setup(Error **errp)
>  {
>      int thread_count;
>      uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> +    bool use_packets = migrate_multifd_packets();
>      uint8_t i;
>  
>      /*
> @@ -1183,9 +1204,12 @@ int multifd_load_setup(Error **errp)
>          qemu_sem_init(&p->sem_sync, 0);
>          p->quit = false;
>          p->id = i;
> -        p->packet_len = sizeof(MultiFDPacket_t)
> -                      + sizeof(uint64_t) * page_count;
> -        p->packet = g_malloc0(p->packet_len);
> +
> +        if (use_packets) {
> +            p->packet_len = sizeof(MultiFDPacket_t)
> +                + sizeof(uint64_t) * page_count;
> +            p->packet = g_malloc0(p->packet_len);
> +        }
>          p->name = g_strdup_printf("multifdrecv_%d", i);
>          p->iov = g_new0(struct iovec, page_count);
>          p->normal = g_new0(ram_addr_t, page_count);
> @@ -1231,18 +1255,27 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>  {
>      MultiFDRecvParams *p;
>      Error *local_err = NULL;
> -    int id;
> +    bool use_packets = migrate_multifd_packets();
> +    int id, num_packets = 0;
>  
> -    id = multifd_recv_initial_packet(ioc, &local_err);
> -    if (id < 0) {
> -        multifd_recv_terminate_threads(local_err);
> -        error_propagate_prepend(errp, local_err,
> -                                "failed to receive packet"
> -                                " via multifd channel %d: ",
> -                                qatomic_read(&multifd_recv_state->count));
> -        return;
> +    if (use_packets) {
> +        id = multifd_recv_initial_packet(ioc, &local_err);
> +        if (id < 0) {
> +            multifd_recv_terminate_threads(local_err);
> +            error_propagate_prepend(errp, local_err,
> +                                    "failed to receive packet"
> +                                    " via multifd channel %d: ",
> +                                    qatomic_read(&multifd_recv_state->count));
> +            return;
> +        }
> +        trace_multifd_recv_new_channel(id);
> +
> +        /* initial packet */
> +        num_packets = 1;
> +    } else {
> +        /* next patch gives this a meaningful value */
> +        id = 0;
>      }
> -    trace_multifd_recv_new_channel(id);
>  
>      p = &multifd_recv_state->params[id];
>      if (p->c != NULL) {
> @@ -1253,9 +1286,8 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>          return;
>      }
>      p->c = ioc;
> +    p->num_packets = num_packets;
>      object_ref(OBJECT(ioc));
> -    /* initial packet */
> -    p->num_packets = 1;
>  
>      p->running = true;
>      qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
> diff --git a/migration/options.c b/migration/options.c
> index 775428a8a5..10730b13ba 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -385,6 +385,11 @@ bool migrate_multifd_flush_after_each_section(void)
>      return s->multifd_flush_after_each_section;
>  }
>  
> +bool migrate_multifd_packets(void)

Maybe multifd_use_packets()?  Dropping the migrate_ prefix as this is not a
global API but multifd-only.  Then if multifd_packets() reads too weird and
unclear, "add" makes it clear.

> +{
> +    return !migrate_fixed_ram();
> +}
> +
>  bool migrate_postcopy(void)
>  {
>      return migrate_postcopy_ram() || migrate_dirty_bitmaps();
> diff --git a/migration/options.h b/migration/options.h
> index 8680a10b79..8a19d6939c 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -56,6 +56,7 @@ bool migrate_zero_copy_send(void);
>   */
>  
>  bool migrate_multifd_flush_after_each_section(void);
> +bool migrate_multifd_packets(void);
>  bool migrate_postcopy(void);
>  bool migrate_rdma(void);
>  bool migrate_tls(void);
> -- 
> 2.35.3
> 

-- 
Peter Xu


