Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F391482E026
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 19:41:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPRs6-0003rN-Br; Mon, 15 Jan 2024 13:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rPRs2-0003r1-SM
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 13:39:38 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rPRrz-00010g-GK
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 13:39:38 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 44E6E221C0;
 Mon, 15 Jan 2024 18:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705343973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JbjK2+3sHrp1ClpWjl6QLo5TiOCZyiRrxpfGEjnCSyU=;
 b=ufj+22XpTElwR3i8K4Ml+2BvoxOwY6itfLcWSW3vd2Wa9IIUGyGwAXUd0tUcOs/XnklJjc
 k14r/I6LjcVHK7cwJfpAo8KIFJTXosTQgPObfGLrIcHUU4YeQr9RHOheTjKcip6wHxDvvY
 vqnWuNyd4dA+qPlXT/DgRfTEFPycFYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705343973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JbjK2+3sHrp1ClpWjl6QLo5TiOCZyiRrxpfGEjnCSyU=;
 b=k7ZOr/3kHjBu8H2SLpuqZDe+NVaKwpUWNNWV6fKO1Zp+6+c87nW+1SZsj5+TwBetC9lJEj
 PnJ096Tl7E7HjuDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705343972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JbjK2+3sHrp1ClpWjl6QLo5TiOCZyiRrxpfGEjnCSyU=;
 b=tixtALVQViRkeTogbrqpQivNEovnwZk2qJ6AUyca4Aa+ot0bYU9Esn61pkhTw0FiwPf94Y
 w8Zp55rst6UpsAFutUhqixvKCGc4mfuU0gbug92qVWUzQc856AqijfVkuWiM0TfwmdFDDJ
 CROFEQ+fTyiTaNy7KH3H1bE/gCoPcjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705343972;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JbjK2+3sHrp1ClpWjl6QLo5TiOCZyiRrxpfGEjnCSyU=;
 b=dtXv4B317xT8far43aZxCYKlJq428eec5O8OD7YmrXXqbSDPeeWjoQHcn+AA33QESu1VB4
 EZNiIiJgIgiANDDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C047A132FA;
 Mon, 15 Jan 2024 18:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lAJBIeN7pWWAPgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Jan 2024 18:39:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Juan
 Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 11/30] migration/multifd: Allow multifd without
 packets
In-Reply-To: <ZaUcKy41AsAdqT0G@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-12-farosas@suse.de> <ZaUcKy41AsAdqT0G@x1n>
Date: Mon, 15 Jan 2024 15:39:29 -0300
Message-ID: <8734uy5tlq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Nov 27, 2023 at 05:25:53PM -0300, Fabiano Rosas wrote:
>> For the upcoming support to the new 'fixed-ram' migration stream
>> format, we cannot use multifd packets because each write into the
>> ramblock section in the migration file is expected to contain only the
>> guest pages. They are written at their respective offsets relative to
>> the ramblock section header.
>> 
>> There is no space for the packet information and the expected gains
>> from the new approach come partly from being able to write the pages
>> sequentially without extraneous data in between.
>> 
>> The new format also doesn't need the packets and all necessary
>> information can be taken from the standard migration headers with some
>> (future) changes to multifd code.
>> 
>> Use the presence of the fixed-ram capability to decide whether to send
>> packets. For now this has no effect as fixed-ram cannot yet be enabled
>> with multifd.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>> - moved more of the packet code under use_packets
>> ---
>>  migration/multifd.c | 138 +++++++++++++++++++++++++++-----------------
>>  migration/options.c |   5 ++
>>  migration/options.h |   1 +
>>  3 files changed, 91 insertions(+), 53 deletions(-)
>> 
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index ec58c58082..9625640d61 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -654,18 +654,22 @@ static void *multifd_send_thread(void *opaque)
>>      Error *local_err = NULL;
>>      int ret = 0;
>>      bool use_zero_copy_send = migrate_zero_copy_send();
>> +    bool use_packets = migrate_multifd_packets();
>>  
>>      thread = migration_threads_add(p->name, qemu_get_thread_id());
>>  
>>      trace_multifd_send_thread_start(p->id);
>>      rcu_register_thread();
>>  
>> -    if (multifd_send_initial_packet(p, &local_err) < 0) {
>> -        ret = -1;
>> -        goto out;
>> +    if (use_packets) {
>> +        if (multifd_send_initial_packet(p, &local_err) < 0) {
>> +            ret = -1;
>> +            goto out;
>> +        }
>> +
>> +        /* initial packet */
>> +        p->num_packets = 1;
>>      }
>> -    /* initial packet */
>> -    p->num_packets = 1;
>>  
>>      while (true) {
>>          qemu_sem_post(&multifd_send_state->channels_ready);
>> @@ -677,11 +681,10 @@ static void *multifd_send_thread(void *opaque)
>>          qemu_mutex_lock(&p->mutex);
>>  
>>          if (p->pending_job) {
>> -            uint64_t packet_num = p->packet_num;
>>              uint32_t flags;
>>              p->normal_num = 0;
>>  
>> -            if (use_zero_copy_send) {
>> +            if (!use_packets || use_zero_copy_send) {
>>                  p->iovs_num = 0;
>>              } else {
>>                  p->iovs_num = 1;
>> @@ -699,16 +702,20 @@ static void *multifd_send_thread(void *opaque)
>>                      break;
>>                  }
>>              }
>> -            multifd_send_fill_packet(p);
>> +
>> +            if (use_packets) {
>> +                multifd_send_fill_packet(p);
>> +                p->num_packets++;
>> +            }
>> +
>>              flags = p->flags;
>>              p->flags = 0;
>> -            p->num_packets++;
>>              p->total_normal_pages += p->normal_num;
>>              p->pages->num = 0;
>>              p->pages->block = NULL;
>>              qemu_mutex_unlock(&p->mutex);
>>  
>> -            trace_multifd_send(p->id, packet_num, p->normal_num, flags,
>> +            trace_multifd_send(p->id, p->packet_num, p->normal_num, flags,
>>                                 p->next_packet_size);
>>  
>>              if (use_zero_copy_send) {
>> @@ -718,7 +725,7 @@ static void *multifd_send_thread(void *opaque)
>>                  if (ret != 0) {
>>                      break;
>>                  }
>> -            } else {
>> +            } else if (use_packets) {
>>                  /* Send header using the same writev call */
>>                  p->iov[0].iov_len = p->packet_len;
>>                  p->iov[0].iov_base = p->packet;
>> @@ -904,6 +911,7 @@ int multifd_save_setup(Error **errp)
>>  {
>>      int thread_count;
>>      uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
>> +    bool use_packets = migrate_multifd_packets();
>>      uint8_t i;
>>  
>>      if (!migrate_multifd()) {
>> @@ -928,14 +936,20 @@ int multifd_save_setup(Error **errp)
>>          p->pending_job = 0;
>>          p->id = i;
>>          p->pages = multifd_pages_init(page_count);
>> -        p->packet_len = sizeof(MultiFDPacket_t)
>> -                      + sizeof(uint64_t) * page_count;
>> -        p->packet = g_malloc0(p->packet_len);
>> -        p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
>> -        p->packet->version = cpu_to_be32(MULTIFD_VERSION);
>> +
>> +        if (use_packets) {
>> +            p->packet_len = sizeof(MultiFDPacket_t)
>> +                          + sizeof(uint64_t) * page_count;
>> +            p->packet = g_malloc0(p->packet_len);
>> +            p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
>> +            p->packet->version = cpu_to_be32(MULTIFD_VERSION);
>> +
>> +            /* We need one extra place for the packet header */
>> +            p->iov = g_new0(struct iovec, page_count + 1);
>> +        } else {
>> +            p->iov = g_new0(struct iovec, page_count);
>> +        }
>>          p->name = g_strdup_printf("multifdsend_%d", i);
>> -        /* We need one extra place for the packet header */
>> -        p->iov = g_new0(struct iovec, page_count + 1);
>>          p->normal = g_new0(ram_addr_t, page_count);
>>          p->page_size = qemu_target_page_size();
>>          p->page_count = page_count;
>> @@ -1067,7 +1081,7 @@ void multifd_recv_sync_main(void)
>>  {
>>      int i;
>>  
>> -    if (!migrate_multifd()) {
>> +    if (!migrate_multifd() || !migrate_multifd_packets()) {
>>          return;
>>      }
>>      for (i = 0; i < migrate_multifd_channels(); i++) {
>
> This noops the recv sync when use_packets=1, makes sense.
>
> How about multifd_send_sync_main()?  Should we do the same?
>

It seems it got lost during rebase.

>> @@ -1094,38 +1108,44 @@ static void *multifd_recv_thread(void *opaque)
>>  {
>>      MultiFDRecvParams *p = opaque;
>>      Error *local_err = NULL;
>> +    bool use_packets = migrate_multifd_packets();
>>      int ret;
>>  
>>      trace_multifd_recv_thread_start(p->id);
>>      rcu_register_thread();
>>  
>>      while (true) {
>> -        uint32_t flags;
>> +        uint32_t flags = 0;
>> +        p->normal_num = 0;
>>  
>>          if (p->quit) {
>>              break;
>>          }
>>  
>> -        ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
>> -                                       p->packet_len, &local_err);
>> -        if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
>> -            break;
>> -        }
>> +        if (use_packets) {
>> +            ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
>> +                                           p->packet_len, &local_err);
>> +            if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
>> +                break;
>> +            }
>> +
>> +            qemu_mutex_lock(&p->mutex);
>> +            ret = multifd_recv_unfill_packet(p, &local_err);
>> +            if (ret) {
>> +                qemu_mutex_unlock(&p->mutex);
>> +                break;
>> +            }
>> +            p->num_packets++;
>> +
>> +            flags = p->flags;
>> +            /* recv methods don't know how to handle the SYNC flag */
>> +            p->flags &= ~MULTIFD_FLAG_SYNC;
>> +            trace_multifd_recv(p->id, p->packet_num, p->normal_num, flags,
>> +                               p->next_packet_size);
>>  
>> -        qemu_mutex_lock(&p->mutex);
>> -        ret = multifd_recv_unfill_packet(p, &local_err);
>> -        if (ret) {
>> -            qemu_mutex_unlock(&p->mutex);
>> -            break;
>> +            p->total_normal_pages += p->normal_num;
>>          }
>>  
>> -        flags = p->flags;
>> -        /* recv methods don't know how to handle the SYNC flag */
>> -        p->flags &= ~MULTIFD_FLAG_SYNC;
>> -        trace_multifd_recv(p->id, p->packet_num, p->normal_num, flags,
>> -                           p->next_packet_size);
>> -        p->num_packets++;
>> -        p->total_normal_pages += p->normal_num;
>>          qemu_mutex_unlock(&p->mutex);
>>  
>>          if (p->normal_num) {
>> @@ -1135,7 +1155,7 @@ static void *multifd_recv_thread(void *opaque)
>>              }
>>          }
>>  
>> -        if (flags & MULTIFD_FLAG_SYNC) {
>> +        if (use_packets && (flags & MULTIFD_FLAG_SYNC)) {
>>              qemu_sem_post(&multifd_recv_state->sem_sync);
>>              qemu_sem_wait(&p->sem_sync);
>>          }
>> @@ -1159,6 +1179,7 @@ int multifd_load_setup(Error **errp)
>>  {
>>      int thread_count;
>>      uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
>> +    bool use_packets = migrate_multifd_packets();
>>      uint8_t i;
>>  
>>      /*
>> @@ -1183,9 +1204,12 @@ int multifd_load_setup(Error **errp)
>>          qemu_sem_init(&p->sem_sync, 0);
>>          p->quit = false;
>>          p->id = i;
>> -        p->packet_len = sizeof(MultiFDPacket_t)
>> -                      + sizeof(uint64_t) * page_count;
>> -        p->packet = g_malloc0(p->packet_len);
>> +
>> +        if (use_packets) {
>> +            p->packet_len = sizeof(MultiFDPacket_t)
>> +                + sizeof(uint64_t) * page_count;
>> +            p->packet = g_malloc0(p->packet_len);
>> +        }
>>          p->name = g_strdup_printf("multifdrecv_%d", i);
>>          p->iov = g_new0(struct iovec, page_count);
>>          p->normal = g_new0(ram_addr_t, page_count);
>> @@ -1231,18 +1255,27 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>>  {
>>      MultiFDRecvParams *p;
>>      Error *local_err = NULL;
>> -    int id;
>> +    bool use_packets = migrate_multifd_packets();
>> +    int id, num_packets = 0;
>>  
>> -    id = multifd_recv_initial_packet(ioc, &local_err);
>> -    if (id < 0) {
>> -        multifd_recv_terminate_threads(local_err);
>> -        error_propagate_prepend(errp, local_err,
>> -                                "failed to receive packet"
>> -                                " via multifd channel %d: ",
>> -                                qatomic_read(&multifd_recv_state->count));
>> -        return;
>> +    if (use_packets) {
>> +        id = multifd_recv_initial_packet(ioc, &local_err);
>> +        if (id < 0) {
>> +            multifd_recv_terminate_threads(local_err);
>> +            error_propagate_prepend(errp, local_err,
>> +                                    "failed to receive packet"
>> +                                    " via multifd channel %d: ",
>> +                                    qatomic_read(&multifd_recv_state->count));
>> +            return;
>> +        }
>> +        trace_multifd_recv_new_channel(id);
>> +
>> +        /* initial packet */
>> +        num_packets = 1;
>> +    } else {
>> +        /* next patch gives this a meaningful value */
>> +        id = 0;
>>      }
>> -    trace_multifd_recv_new_channel(id);
>>  
>>      p = &multifd_recv_state->params[id];
>>      if (p->c != NULL) {
>> @@ -1253,9 +1286,8 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>>          return;
>>      }
>>      p->c = ioc;
>> +    p->num_packets = num_packets;
>>      object_ref(OBJECT(ioc));
>> -    /* initial packet */
>> -    p->num_packets = 1;
>>  
>>      p->running = true;
>>      qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
>> diff --git a/migration/options.c b/migration/options.c
>> index 775428a8a5..10730b13ba 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -385,6 +385,11 @@ bool migrate_multifd_flush_after_each_section(void)
>>      return s->multifd_flush_after_each_section;
>>  }
>>  
>> +bool migrate_multifd_packets(void)
>
> Maybe multifd_use_packets()?  Dropping the migrate_ prefix as this is not a
> global API but multifd-only.  Then if multifd_packets() reads too weird and
> unclear, "add" makes it clear.
>

We removed all the instances of migrate_use_* from the migration code
recently. Not sure we should introduce them back, it seems like a step
back.

We're setting 'use_packets = migrate_multifd_packets()' in most places,
so I guess 'use_packets = multifd_packets()' wouldn't be too bad.

>> +{
>> +    return !migrate_fixed_ram();
>> +}
>> +
>>  bool migrate_postcopy(void)
>>  {
>>      return migrate_postcopy_ram() || migrate_dirty_bitmaps();
>> diff --git a/migration/options.h b/migration/options.h
>> index 8680a10b79..8a19d6939c 100644
>> --- a/migration/options.h
>> +++ b/migration/options.h
>> @@ -56,6 +56,7 @@ bool migrate_zero_copy_send(void);
>>   */
>>  
>>  bool migrate_multifd_flush_after_each_section(void);
>> +bool migrate_multifd_packets(void);
>>  bool migrate_postcopy(void);
>>  bool migrate_rdma(void);
>>  bool migrate_tls(void);
>> -- 
>> 2.35.3
>> 

