Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 722827D66AF
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:23:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qva71-00024T-33; Wed, 25 Oct 2023 05:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qva6s-000205-FI
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:23:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qva6q-0000eL-Ed
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698225807;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=a3+Zs8MPib5PI3yOQRaHqAMWdUFbGgWHftPTH8mMLuY=;
 b=AVcXol2V+SsLh0mdEZd6/Yh/1cwawpmcWwOfV62akBddTprLVvFDktLoW/8/U9X7QgsLUK
 +CwR9JyjYuiNZjOtT+SQ7JPB/VfHziI/1f9PRUSwtawuwuk/m/1iD+kat5FWAv0N1pk4yC
 OvvEtFjLEXYtN6xkW11S/fUOLjd8ry8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-z_6iYE8CPH6jBPWexsMCxA-1; Wed, 25 Oct 2023 05:23:18 -0400
X-MC-Unique: z_6iYE8CPH6jBPWexsMCxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EC65881B6D;
 Wed, 25 Oct 2023 09:23:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41E4C2026D4C;
 Wed, 25 Oct 2023 09:23:17 +0000 (UTC)
Date: Wed, 25 Oct 2023 10:23:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2 25/29] migration/multifd: Support outgoing fixed-ram
 stream format
Message-ID: <ZTjegrKXycbsbImz@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-26-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023203608.26370-26-farosas@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Oct 23, 2023 at 05:36:04PM -0300, Fabiano Rosas wrote:
> The new fixed-ram stream format uses a file transport and puts ram
> pages in the migration file at their respective offsets and can be
> done in parallel by using the pwritev system call which takes iovecs
> and an offset.
> 
> Add support to enabling the new format along with multifd to make use
> of the threading and page handling already in place.
> 
> This requires multifd to stop sending headers and leaving the stream
> format to the fixed-ram code. When it comes time to write the data, we
> need to call a version of qio_channel_write that can take an offset.
> 
> Usage on HMP is:
> 
> (qemu) stop
> (qemu) migrate_set_capability multifd on
> (qemu) migrate_set_capability fixed-ram on
> (qemu) migrate_set_parameter max-bandwidth 0
> (qemu) migrate_set_parameter multifd-channels 8
> (qemu) migrate file:migfile
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  include/qemu/bitops.h | 13 ++++++++++
>  migration/multifd.c   | 55 +++++++++++++++++++++++++++++++++++++++++--
>  migration/options.c   |  6 -----
>  migration/ram.c       |  2 +-
>  4 files changed, 67 insertions(+), 9 deletions(-)
> 
> diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
> index cb3526d1f4..2c0a2fe751 100644
> --- a/include/qemu/bitops.h
> +++ b/include/qemu/bitops.h
> @@ -67,6 +67,19 @@ static inline void clear_bit(long nr, unsigned long *addr)
>      *p &= ~mask;
>  }
>  
> +/**
> + * clear_bit_atomic - Clears a bit in memory atomically
> + * @nr: Bit to clear
> + * @addr: Address to start counting from
> + */
> +static inline void clear_bit_atomic(long nr, unsigned long *addr)
> +{
> +    unsigned long mask = BIT_MASK(nr);
> +    unsigned long *p = addr + BIT_WORD(nr);
> +
> +    return qatomic_and(p, ~mask);
> +}
> +
>  /**
>   * change_bit - Toggle a bit in memory
>   * @nr: Bit to change
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 20e8635740..3f95a41ee9 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -260,6 +260,19 @@ static void multifd_pages_clear(MultiFDPages_t *pages)
>      g_free(pages);
>  }
>  
> +static void multifd_set_file_bitmap(MultiFDSendParams *p)
> +{
> +    MultiFDPages_t *pages = p->pages;
> +
> +    if (!pages->block) {
> +        return;
> +    }
> +
> +    for (int i = 0; i < p->normal_num; i++) {
> +        ramblock_set_shadow_bmap_atomic(pages->block, pages->offset[i]);
> +    }
> +}
> +
>  static void multifd_send_fill_packet(MultiFDSendParams *p)
>  {
>      MultiFDPacket_t *packet = p->packet;
> @@ -606,6 +619,29 @@ int multifd_send_sync_main(QEMUFile *f)
>          }
>      }
>  
> +    if (!migrate_multifd_packets()) {
> +        /*
> +         * There's no sync packet to send. Just make sure the sending
> +         * above has finished.
> +         */
> +        for (i = 0; i < migrate_multifd_channels(); i++) {
> +            qemu_sem_wait(&multifd_send_state->channels_ready);
> +        }
> +
> +        /* sanity check and release the channels */
> +        for (i = 0; i < migrate_multifd_channels(); i++) {
> +            MultiFDSendParams *p = &multifd_send_state->params[i];
> +
> +            qemu_mutex_lock(&p->mutex);
> +            assert(!p->pending_job || p->quit);
> +            qemu_mutex_unlock(&p->mutex);
> +
> +            qemu_sem_post(&p->sem);
> +        }
> +
> +        return 0;
> +    }
> +
>      /*
>       * When using zero-copy, it's necessary to flush the pages before any of
>       * the pages can be sent again, so we'll make sure the new version of the
> @@ -689,6 +725,8 @@ static void *multifd_send_thread(void *opaque)
>  
>          if (p->pending_job) {
>              uint32_t flags;
> +            uint64_t write_base;
> +
>              p->normal_num = 0;
>  
>              if (!use_packets || use_zero_copy_send) {
> @@ -713,6 +751,16 @@ static void *multifd_send_thread(void *opaque)
>              if (use_packets) {
>                  multifd_send_fill_packet(p);
>                  p->num_packets++;
> +                write_base = 0;
> +            } else {
> +                multifd_set_file_bitmap(p);
> +
> +                /*
> +                 * If we subtract the host page now, we don't need to
> +                 * pass it into qio_channel_write_full_all() below.
> +                 */
> +                write_base = p->pages->block->pages_offset -
> +                    (uint64_t)p->pages->block->host;
>              }
>  
>              flags = p->flags;
> @@ -738,8 +786,9 @@ static void *multifd_send_thread(void *opaque)
>                  p->iov[0].iov_base = p->packet;
>              }
>  
> -            ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
> -                                              0, p->write_flags, &local_err);
> +            ret = qio_channel_write_full_all(p->c, p->iov, p->iovs_num,
> +                                             write_base, NULL, 0,
> +                                             p->write_flags, &local_err);
>              if (ret != 0) {
>                  break;
>              }
> @@ -969,6 +1018,8 @@ int multifd_save_setup(Error **errp)
>  
>          if (migrate_zero_copy_send()) {
>              p->write_flags = QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
> +        } else if (!use_packets) {
> +            p->write_flags |= QIO_CHANNEL_WRITE_FLAG_WITH_OFFSET;
>          } else {
>              p->write_flags = 0;
>          }

Ah, so this is why you had the wierd overloaded design for
qio_channel_write_full_all in patch 22 that I queried. I'd
still prefer the simpler design at the QIO level, and just
calling the appropriate function above. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


