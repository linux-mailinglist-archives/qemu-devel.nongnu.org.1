Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 072217D09CD
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 09:54:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtkKA-0003WS-BL; Fri, 20 Oct 2023 03:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtkK8-0003UZ-MI
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:53:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtkK6-0006HJ-Jy
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697788413;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qX0AkHGXrOS+umv8xS0PSkShmM/1mG1novqwyXsrB9M=;
 b=d9P3EljiECUqfjPlyye0pj0CSC3GxuTGzzhhpDM8IWI+Ssck6Kpi7fX7qBNj4a6YtKnezU
 NKoRn+T/9956n91sOBmwfgxT/7w9DUBeG1WRV3dKzfVGWW4MOmkgxP/avxeQ1HgzGKX9sv
 GycYMtzrWhIGLw1KC9DPYR775Z+rj8c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-GdtZxGsXOSqY2IlnapvTFA-1; Fri, 20 Oct 2023 03:53:31 -0400
X-MC-Unique: GdtZxGsXOSqY2IlnapvTFA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4084d08235fso3288795e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 00:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697788410; x=1698393210;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qX0AkHGXrOS+umv8xS0PSkShmM/1mG1novqwyXsrB9M=;
 b=uFQsOahFdDBgTr3/rUSSOxTCU7a9rrne/lPFt8VKawV4C18F1IMguiD5RdRHURk21L
 kHCImbeUqcYDsa5GcqBTHBT/87gH1vlrnQU77ub252Ol3wW7W+5QuGvGftfnGz3TJXB3
 sMl9XwJmH26bQ2/1MdsfT84t2wZwMeiUzPp/wVujLjWd0YEzByFZmhYqvEsjNOI2m3pm
 Z366frUXE4O5xDPO//8rpBzsxMVA40a3k6QMyt7dYmbxTCAOk6XRdfBdA7moZovqOyCJ
 3yaE2Ue16pnVUMYORIsHVQTepaWcpUjTVNDwnf1bxErSwSCyo+xDsOO/oHIqfU0wYpFS
 k8Gg==
X-Gm-Message-State: AOJu0YxEf4m2uWJ+pcwzh8jTCSTIYW+1GMQf64vM9ALjTrAoHwjBJVFq
 GxraH2Y8lWfGkrF3/AJYQPzZKcZsvXTjbPK51Uz+heqPruv58ndbkufj0H1xWVnZb+bKtrJUpLC
 7MbS2B5111j46Yzg=
X-Received: by 2002:a05:600c:19d1:b0:406:8c7a:9520 with SMTP id
 u17-20020a05600c19d100b004068c7a9520mr769757wmq.36.1697788410336; 
 Fri, 20 Oct 2023 00:53:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcDSR4rJGBEtGT/FE5c6+WWGUV4kK4wioz4BQ44chZCw3IfoiZPYm1dpaWkiADV7kursvq9g==
X-Received: by 2002:a05:600c:19d1:b0:406:8c7a:9520 with SMTP id
 u17-20020a05600c19d100b004068c7a9520mr769746wmq.36.1697788409980; 
 Fri, 20 Oct 2023 00:53:29 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 t6-20020a05600c450600b0040535648639sm1508345wmo.36.2023.10.20.00.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 00:53:29 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,  Leonardo Bras
 <leobras@redhat.com>,  Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 1/6] migration/multifd: Remove channels_ready
 semaphore
In-Reply-To: <ZTF9vL8yyn6McuTx@x1n> (Peter Xu's message of "Thu, 19 Oct 2023
 15:04:28 -0400")
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-2-farosas@suse.de>
 <87sf676kxt.fsf@secure.mitica> <87r0lqy83p.fsf@suse.de>
 <87wmvi3akc.fsf@secure.mitica> <87lebyy5ac.fsf@suse.de>
 <87a5se3161.fsf@secure.mitica> <ZTF9vL8yyn6McuTx@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 20 Oct 2023 09:53:28 +0200
Message-ID: <87ttql20hz.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> On Thu, Oct 19, 2023 at 08:41:26PM +0200, Juan Quintela wrote:
>> We can changing pending_job to a bool if you preffer.  I think that we
>> have nailed all the off_by_one errors by now (famous last words).
>
> Would it work to make pending_job a bool, even with SYNC?  It seems to me
> multifd_send_sync_main() now can boost pending_job even if pending_job==1.

Then a int is ok, I think.

> That's also the place where I really think confusing too; where it looks
> like the migration thread can modify a pending job's flag as long as it is
> fast enough before the send thread put that onto the wire.

It never does.

    for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
        qemu_mutex_lock(&p->mutex);
        ...
        if (!p->pending_job) {
            p->pending_job++;
            next_channel = (i + 1) % migrate_multifd_channels();
            break;
        }
        qemu_mutex_unlock(&p->mutex);
    }

If pending_job == 0 -> owner of the channel is migration_thread and it
can use it.

If pending_job > 0 -> owner of the channel is the channel thread and
migration_thread can't use it.

I think that this is easy to understand.  You are right that it is not
_explained_.  And clearly, if you have to ask, it is not obvious O:-)

Yes, it was obvious to me, that is the reason why I wrote it on the 1st
place.  Notice also that it is a common idiom in multithreaded apps.
That allows it to do stuff without having to have a mutex locked, so
other threads can "look" into the state.

> Then it's
> unpredictable whether the SYNC flag will be sent with current packet (where
> due to pending_jobs==1 already, can contain valid pages), or will be only
> set for the next one (where there will have 0 real page).

I have to think about this one.
Decrease pending_jobs there if we are doing multiple jobs?
But we still have the issue of the semaphore.

> IMHO it'll be good to separate the sync task, then we can change
> pending_jobs to bool.  Something like:
>
>   bool pending_send_page;
>   bool pending_send_sync;

current code:

        qemu_mutex_lock(&p->mutex);
        qemu_mutex_lock(&p->mutex);

        if (p->pending_job) {
            uint64_t packet_num = p->packet_num;
            uint32_t flags;
            p->normal_num = 0;

            if (use_zero_copy_send) {
                p->iovs_num = 0;
            } else {
                p->iovs_num = 1;
            }

            for (int i = 0; i < p->pages->num; i++) {
                p->normal[p->normal_num] = p->pages->offset[i];
                p->normal_num++;
            }

            if (p->normal_num) {
                ret = multifd_send_state->ops->send_prepare(p, &local_err);
                if (ret != 0) {
                    qemu_mutex_unlock(&p->mutex);
                    break;
                }
            }
            multifd_send_fill_packet(p);
            flags = p->flags;
            p->flags = 0;
            p->num_packets++;
            p->total_normal_pages += p->normal_num;
            p->pages->num = 0;
            p->pages->block = NULL;
            qemu_mutex_unlock(&p->mutex);

            trace_multifd_send(p->id, packet_num, p->normal_num, flags,
                               p->next_packet_size);

            if (use_zero_copy_send) {
                /* Send header first, without zerocopy */
                ret = qio_channel_write_all(p->c, (void *)p->packet,
                                            p->packet_len, &local_err);
                if (ret != 0) {
                    break;
                }
            } else {
                /* Send header using the same writev call */
                p->iov[0].iov_len = p->packet_len;
                p->iov[0].iov_base = p->packet;
            }

            ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
                                              0, p->write_flags, &local_err);
            if (ret != 0) {
                break;
            }

            stat64_add(&mig_stats.multifd_bytes,
                       p->next_packet_size + p->packet_len);
            stat64_add(&mig_stats.transferred,
                       p->next_packet_size + p->packet_len);
            p->next_packet_size = 0;
            qemu_mutex_lock(&p->mutex);
            p->pending_job--;
            qemu_mutex_unlock(&p->mutex);

            if (flags & MULTIFD_FLAG_SYNC) {
                qemu_sem_post(&p->sem_sync);
            }
        } else {
            qemu_mutex_unlock(&p->mutex);
            /* sometimes there are spurious wakeups */
        }

Your suggested change:

       qemu_mutex_lock(&p->mutex);

       if (p->pending_job_page) {
            uint64_t packet_num = p->packet_num;
            uint32_t flags;
            p->normal_num = 0;

            if (use_zero_copy_send) {
                p->iovs_num = 0;
            } else {
                p->iovs_num = 1;
            }

            for (int i = 0; i < p->pages->num; i++) {
                p->normal[p->normal_num] = p->pages->offset[i];
                p->normal_num++;
            }

            if (p->normal_num) {
                ret = multifd_send_state->ops->send_prepare(p, &local_err);
                if (ret != 0) {
                    qemu_mutex_unlock(&p->mutex);
                    break;
                }
            }
            multifd_send_fill_packet(p);
            flags = p->flags;
            p->flags = 0;
            p->num_packets++;
            p->total_normal_pages += p->normal_num;
            p->pages->num = 0;
            p->pages->block = NULL;
            qemu_mutex_unlock(&p->mutex);

            trace_multifd_send(p->id, packet_num, p->normal_num, flags,
                               p->next_packet_size);

            if (use_zero_copy_send) {
                /* Send header first, without zerocopy */
                ret = qio_channel_write_all(p->c, (void *)p->packet,
                                            p->packet_len, &local_err);
                if (ret != 0) {
                    break;
                }
            } else {
                /* Send header using the same writev call */
                p->iov[0].iov_len = p->packet_len;
                p->iov[0].iov_base = p->packet;
            }

            ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
                                              0, p->write_flags, &local_err);
            if (ret != 0) {
                break;
            }

            stat64_add(&mig_stats.multifd_bytes,
                       p->next_packet_size + p->packet_len);
            stat64_add(&mig_stats.transferred,
                       p->next_packet_size + p->packet_len);
            p->next_packet_size = 0;
            qemu_mutex_lock(&p->mutex);
            p->pending_job_page = false;
            qemu_mutex_unlock(&p->mutex);

       else if (p->pending_job_sync)
            uint64_t packet_num = p->packet_num;
            uint32_t flags;
            p->normal_num = 0;

            if (use_zero_copy_send) {
                p->iovs_num = 0;
            } else {
                p->iovs_num = 1;
            }

            multifd_send_fill_packet(p);
            flags = p->flags;
            p->flags = 0;
            p->num_packets++;
            p->total_normal_pages += p->normal_num;
            p->pages->num = 0;
            p->pages->block = NULL;
            qemu_mutex_unlock(&p->mutex);

            trace_multifd_send(p->id, packet_num, p->normal_num, flags,
                               p->next_packet_size);

            if (use_zero_copy_send) {
                /* Send header first, without zerocopy */
                ret = qio_channel_write_all(p->c, (void *)p->packet,
                                            p->packet_len, &local_err);
                if (ret != 0) {
                    break;
                }
            } else {
                /* Send header using the same writev call */
                p->iov[0].iov_len = p->packet_len;
                p->iov[0].iov_base = p->packet;
            }

            ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
                                              0, p->write_flags, &local_err);
            if (ret != 0) {
                break;
            }

            stat64_add(&mig_stats.multifd_bytes,
                       p->next_packet_size + p->packet_len);
            stat64_add(&mig_stats.transferred,
                       p->next_packet_size + p->packet_len);
            p->next_packet_size = 0;
            qemu_mutex_lock(&p->mutex);
            p->pending_job_sync = false;
            qemu_mutex_unlock(&p->mutex);

            if (flags & MULTIFD_FLAG_SYNC) {
                qemu_sem_post(&p->sem_sync);
            }
        } else {
            qemu_mutex_unlock(&p->mutex);
            /* sometimes there are spurious wakeups */
        }

I.e. we duplicate much more code than the one that we remove.  I am not
convinced.


> Then multifd_send_thread() handles them separately, only attaching
> p->flags=SYNC when pending_send_sync is requested.  It guarantees a SYNC
> message will always be a separate packet, which will be crystal clear then.

This is not a requirement.
Code should handle the reception of SYNC with a page.  We just don't
sent them because it is more complex.


