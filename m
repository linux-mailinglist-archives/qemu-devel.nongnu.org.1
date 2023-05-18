Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 495B5708618
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 18:33:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzgY7-0008AJ-6q; Thu, 18 May 2023 12:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzgY5-000880-HY
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:32:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzgY2-00007B-BF
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684427533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yrycU8NWg0tOdz/F+YEeKb7WKw+5NqbdR0cKz/jakX8=;
 b=G/o5U+P1jAmU846Srks7f1FfBzb7X/ylTfKSZZ+J+4mKoU1gVZ7dKw+iQcp6SPoLxSayvD
 b4c7+tky2lEAp3Yeh8sjm+p0ZSHD3sWbUCfFGysr/6ZSGCeYNdsyix9psN/xQZ6Tq4WhKf
 ymKvtzpaWnBWazWd2RdRwI5ab/Od+4c=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-pBDqV4ARMmqWYE_xUdQM5w-1; Thu, 18 May 2023 12:32:11 -0400
X-MC-Unique: pBDqV4ARMmqWYE_xUdQM5w-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-61b636b5f90so4199796d6.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 09:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684427531; x=1687019531;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yrycU8NWg0tOdz/F+YEeKb7WKw+5NqbdR0cKz/jakX8=;
 b=AmEaUJTqXPDXj2PdAQ7YtAu4if/cNmYK/k19ITDRxL13jRW4Nu9GbjlYZLEmLL+yc1
 WisHEIYngj8erYevUPabJYIJbYopaeyhhl5IgBaPQRsX1gp8h0cQN626D80PF56Wdr5Q
 OQo/gvCfyXMNCYfVICNcOfu43xr1A5NMyT9T6BhjIsn4+ie+Rjl87uDuwrsdhJEU6m9I
 qttqcSnYdyQVf0XiXYYyT6wQzUF7ABsKHyG+PJIxsA6OFvLeib7ASN1moJpMUHd1JQ9W
 66Ae0YjhtXBOMp0ZyBCIF0puoLLUirFrHPuVhJdoTJZxyrzhh2fPKEtjKaQFO9ORyWF/
 NoJQ==
X-Gm-Message-State: AC+VfDx7FY3SeLlSBbbeMf5MTedoCvqNvkBPgITyWQ8Pj11ljwgYFw5Y
 7b9He4BH4sW1wUgENSu0uwHGcTJ9A5qqNd5MgbfFCqV6EOr8jkmtXTgjsL5JFyZEf1hFnwYO7GI
 NaD6jfk1zcYSdQ4Y=
X-Received: by 2002:ad4:5be3:0:b0:5f1:31eb:1f0e with SMTP id
 k3-20020ad45be3000000b005f131eb1f0emr12435535qvc.4.1684427531285; 
 Thu, 18 May 2023 09:32:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Bp/tMI4MrADFgIvmNdTwhmppnLm6iL6nhMtW2W5W8wlSSUth5xJ5Yqg78SVTtbvLl16yUZg==
X-Received: by 2002:ad4:5be3:0:b0:5f1:31eb:1f0e with SMTP id
 k3-20020ad45be3000000b005f131eb1f0emr12435489qvc.4.1684427530855; 
 Thu, 18 May 2023 09:32:10 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 mz19-20020a0562142d1300b006211a5495adsm630920qvb.75.2023.05.18.09.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 09:32:09 -0700 (PDT)
Date: Thu, 18 May 2023 12:32:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Greg Kurz <groug@kaod.org>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Leonardo Bras <leobras@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH 21/21] migration/multifd: Compute transferred bytes
 correctly
Message-ID: <ZGZTCAHV5M/+w3VS@x1n>
References: <20230508130909.65420-1-quintela@redhat.com>
 <20230508130909.65420-22-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230508130909.65420-22-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, May 08, 2023 at 03:09:09PM +0200, Juan Quintela wrote:
> In the past, we had to put the in the main thread all the operations
> related with sizes due to qemu_file not beeing thread safe.  As now
> all counters are atomic, we can update the counters just after the
> do the write.  As an aditional bonus, we are able to use the right
> value for the compression methods.  Right now we were assuming that
> there were no compression at all.

Maybe worth mention that initial packet is also accounted after this.

> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Two more trivial nits:

> ---
>  migration/multifd.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 9d2ade7abc..3a19d8e304 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -175,6 +175,7 @@ void multifd_register_ops(int method, MultiFDMethods *ops)
>  static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
>  {
>      MultiFDInit_t msg = {};
> +    size_t size = sizeof(msg);
>      int ret;
>  
>      msg.magic = cpu_to_be32(MULTIFD_MAGIC);
> @@ -182,10 +183,12 @@ static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
>      msg.id = p->id;
>      memcpy(msg.uuid, &qemu_uuid.data, sizeof(msg.uuid));
>  
> -    ret = qio_channel_write_all(p->c, (char *)&msg, sizeof(msg), errp);
> +    ret = qio_channel_write_all(p->c, (char *)&msg, size, errp);
>      if (ret != 0) {
>          return -1;
>      }
> +    stat64_add(&mig_stats.multifd_bytes, size);
> +    stat64_add(&mig_stats.transferred, size);
>      return 0;
>  }
>  
> @@ -396,7 +399,6 @@ static int multifd_send_pages(QEMUFile *f)
>      static int next_channel;
>      MultiFDSendParams *p = NULL; /* make happy gcc */
>      MultiFDPages_t *pages = multifd_send_state->pages;
> -    uint64_t transferred;
>  
>      if (qatomic_read(&multifd_send_state->exiting)) {
>          return -1;
> @@ -431,10 +433,7 @@ static int multifd_send_pages(QEMUFile *f)
>      p->packet_num = multifd_send_state->packet_num++;
>      multifd_send_state->pages = p->pages;
>      p->pages = pages;
> -    transferred = ((uint64_t) pages->num) * p->page_size + p->packet_len;
>      qemu_mutex_unlock(&p->mutex);
> -    stat64_add(&mig_stats.transferred, transferred);
> -    stat64_add(&mig_stats.multifd_bytes, transferred);
>      qemu_sem_post(&p->sem);
>  
>      return 1;
> @@ -716,6 +715,8 @@ static void *multifd_send_thread(void *opaque)
>                  if (ret != 0) {
>                      break;
>                  }
> +                stat64_add(&mig_stats.multifd_bytes, p->packet_len);
> +                stat64_add(&mig_stats.transferred, p->packet_len);
>              } else {
>                  /* Send header using the same writev call */
>                  p->iov[0].iov_len = p->packet_len;
> @@ -728,6 +729,8 @@ static void *multifd_send_thread(void *opaque)
>                  break;
>              }
>  
> +            stat64_add(&mig_stats.multifd_bytes, p->next_packet_size);
> +            stat64_add(&mig_stats.transferred, p->next_packet_size);

Two nits:

Maybe merge the two so half atomic operations?

Also maybe also worth having a inline helper for adding both multifd_bytes
and transferred?

With/without that, all look good:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

>              qemu_mutex_lock(&p->mutex);
>              p->pending_job--;
>              qemu_mutex_unlock(&p->mutex);
> -- 
> 2.40.0
> 

-- 
Peter Xu


