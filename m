Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7B87CF578
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:37:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQNU-0002wb-7b; Thu, 19 Oct 2023 06:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQN5-0002od-3m
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQN3-00019Y-HQ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697711708;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=shTlHWkxMBplMQK1obrRDtCDFZj9i0BuozZ6eASrxoM=;
 b=RfXXdB1wbxTLXaNGlvNUES0UZfNl17p1qyNM5AXvsB1m32MA/HKfMyW7P2xcxBuswaaDZ4
 41zEnCTC51qr389Me9+hJVWAE4B/YfICJ9LXB3E02eFsbiKHhkO6Wn1WDmAkZwAceW7O3A
 9fo644JRmJKt7hPUM7auAQwiXhAdkZk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-MWbaZniVMvevmbAEVv830A-1; Thu, 19 Oct 2023 06:35:07 -0400
X-MC-Unique: MWbaZniVMvevmbAEVv830A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507a3ae32b2so5122373e87.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697711705; x=1698316505;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=shTlHWkxMBplMQK1obrRDtCDFZj9i0BuozZ6eASrxoM=;
 b=TbwTmEaLNlDRCHtW4PBvGOyTwXLGrACPv+UT/jPZSKppw0h5Rn0yhw7s64fMwxW2iU
 b2b4uH98MuL9YsikLzM2LYXocmh4ZOdKL+FPsb0ORtpQOYVGtl/435XyQTyXM1IbZpwi
 OordVLq9KDAl1xLB7MdQ1KLs90XbWzAqCMuEPtq9UDIIbTg3y/pR4iQAhuAsHHHHOaPv
 vt6Z/6fd03NqwX75KgThMuvv9XpBbu/TSwNwNNFWxs7/4XSbjR+TOTNTTvywEHPhqh0f
 zVmZZrQjpQjCziKam5HO6IoxR8xwxOJ4+6cH8YQNu8r8HLCAIv6/ctqEy7DIbjUpeSe8
 AB8w==
X-Gm-Message-State: AOJu0Yylfek6ROIldpYoLkxaBmHl2scjX+/cV5C6PpzKpSE7YhozuqGE
 zVOlwo1RVPesxRX5Bw8uobWxS4PTjMdUN/A8klAiyI/gAjEVbQDmieEPaFc/y0+vdDs4gzAGoKA
 v30SzQSwp2iCONqs+3P167Msx1Q==
X-Received: by 2002:ac2:592e:0:b0:500:b553:c09e with SMTP id
 v14-20020ac2592e000000b00500b553c09emr1044540lfi.32.1697711705266; 
 Thu, 19 Oct 2023 03:35:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfC9HHSpZBkBks6gH36efx8pyOWPVdcAdpfspnbRNX6h8yX0Enuk9Ztg3PenonbKUYEtF30A==
X-Received: by 2002:ac2:592e:0:b0:500:b553:c09e with SMTP id
 v14-20020ac2592e000000b00500b553c09emr1044525lfi.32.1697711704902; 
 Thu, 19 Oct 2023 03:35:04 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 o18-20020a05600c4fd200b0040472ad9a3dsm4134910wmq.14.2023.10.19.03.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:35:04 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 5/6] migration/multifd: Stop setting 'quit'
 outside of channels
In-Reply-To: <20231012140651.13122-6-farosas@suse.de> (Fabiano Rosas's message
 of "Thu, 12 Oct 2023 11:06:50 -0300")
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-6-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 12:35:03 +0200
Message-ID: <87bkcu7ve0.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> We shouldn't really be touching channel state from outside the
> channels except for the transfer of pages.
>
> Move the setting of p->quit into the channel. Keep posting the 'sem'
> from multifd_send_terminate_threads() so any channel waiting on the
> semaphore will unblock and see the 'exiting' flag and quit by itself.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/multifd.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 4ffa67339c..b7ba3fe0e6 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -497,13 +497,11 @@ static void multifd_send_terminate_threads(Error *err)
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> -        qemu_mutex_lock(&p->mutex);
> -        p->quit = true;
> +        /* kick the channel if it was waiting for work */
>          qemu_sem_post(&p->sem);
>          if (p->c) {
>              qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
>          }
> -        qemu_mutex_unlock(&p->mutex);

Can we do two qio_channel_* operations at the same time on different
threads?  mutex is also protecting that.  This is a question, I don't
know the answer.

>      }
>  }
>  
> @@ -690,6 +688,9 @@ static void *multifd_send_thread(void *opaque)
>          qemu_sem_wait(&p->sem);
>  
>          if (qatomic_read(&multifd_send_state->exiting)) {
> +            qemu_mutex_lock(&p->mutex);
> +            p->quit = true;
> +            qemu_mutex_unlock(&p->mutex);
>              break;
>          }
>          qemu_mutex_lock(&p->mutex);
> @@ -765,6 +766,11 @@ static void *multifd_send_thread(void *opaque)

If we are going this route, we can just put it here, just in one place.

>  out:
>      if (local_err) {
>          trace_multifd_send_error(p->id);
> +
> +        qemu_mutex_lock(&p->mutex);
> +        p->quit = true;
> +        qemu_mutex_unlock(&p->mutex);
> +
>          multifd_send_terminate_threads(local_err);
>          error_free(local_err);
>      }

But now ->quit has basically the same meaning that ->running, so we
could probably merge both.

Later, Juan.


