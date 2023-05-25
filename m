Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 454197107BF
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 10:40:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q26Ui-0007pw-Vl; Thu, 25 May 2023 04:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q26Uh-0007oY-9g
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q26Ud-0001WK-7m
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685003921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rc2AmMoDowU24D19Dg5MK0ku9A0dB1FRGjb5ZzicPPk=;
 b=QHF7byqHIgf/NbWp98M8Mm0ov1g3xmId8kJH/kLoMMXqxdXa5atDEmzX+NIFu5A5x4Wp4l
 aGJoXaNN2a+EWta6ZpT9g9ZDxjE23nFejFXJ2sgT8IacDE/in2IVqQ591eAEwyx82KA7uK
 OIn7xkU3KnGFTtef/Mc+BzknZs0paII=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-w42JFpk0MrOSN9Jfkf1hsA-1; Thu, 25 May 2023 04:38:39 -0400
X-MC-Unique: w42JFpk0MrOSN9Jfkf1hsA-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6af7f790e8aso581172a34.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 01:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685003919; x=1687595919;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rc2AmMoDowU24D19Dg5MK0ku9A0dB1FRGjb5ZzicPPk=;
 b=lT4OQQanNNrtW8VrlV54H3Xyt7SxjnPpnI8zRuO7X3lKKJ3ulS12Zapn0LhHcntWXd
 O1SmMzHGW73LJW+LrvYMp5YhSUBNH7h+fmhZB6I/uc/gfsoGnT1mLLOnHvC2ANZ5N0zm
 VfAZ65ItoINltoeH26buCqeDeuXp8JEGyPyRe2VdZjJjueZegrjucpG5EQKHtiEyu29n
 Imv2AwLL7A05HAZyzg6znF5oB4fENxv7GhPJBoqz7pS0pL/zVmBN8vL3EWdiAv9loAXc
 W2W8lQVD4LXERBGK1uvQwyDN+rUFJUUDecN22xiP5myA3e56PPxdjSwTcOTRi8UNuLT4
 0edw==
X-Gm-Message-State: AC+VfDxIUyXkTwtTRCVei491eZ5Mo5dnqaQTuEgjqvHM7fELypg+mPc8
 TmEBLGl5nZJQqHNZ8QqpbTMnqXfmymFFiK9NtHVhEQGhcXcjZra3SBoy8ZsmXsAwDP5L9BBRFWs
 AHqPTP7ZHRa5+0gU=
X-Received: by 2002:a05:6830:13c5:b0:6af:6de9:1f7 with SMTP id
 e5-20020a05683013c500b006af6de901f7mr7330698otq.19.1685003919226; 
 Thu, 25 May 2023 01:38:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60EpkJue29WAb5h1DLQgO2NXRj81eCKQD2bJwASbFCxPlzReyUNU9YR3wgKbBdzkMse5fOPA==
X-Received: by 2002:a05:6830:13c5:b0:6af:6de9:1f7 with SMTP id
 e5-20020a05683013c500b006af6de901f7mr7330677otq.19.1685003918992; 
 Thu, 25 May 2023 01:38:38 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:7f0c:32e1:e970:713a:f05b?
 ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a0568301e8600b006af904d9c37sm411616otr.45.2023.05.25.01.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 01:38:38 -0700 (PDT)
Message-ID: <17c133c69e5207e81784c081dd82950a31b8d826.camel@redhat.com>
Subject: Re: [PATCH v2 16/16] migration/multifd: Compute transferred bytes
 correctly
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Greg Kurz <groug@kaod.org>, 
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, John Snow
 <jsnow@redhat.com>, qemu-ppc@nongnu.org, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-block@nongnu.org,  =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Date: Thu, 25 May 2023 05:38:32 -0300
In-Reply-To: <20230515195709.63843-17-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-17-quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leobras@redhat.com;
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

On Mon, 2023-05-15 at 21:57 +0200, Juan Quintela wrote:
> In the past, we had to put the in the main thread all the operations
> related with sizes due to qemu_file not beeing thread safe.  As now
> all counters are atomic, we can update the counters just after the
> do the write.  As an aditional bonus, we are able to use the right
> value for the compression methods.  Right now we were assuming that
> there were no compression at all.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/multifd.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/migration/multifd.c b/migration/multifd.c
> index aabf9b6d98..0bf5958a9c 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -175,6 +175,7 @@ void multifd_register_ops(int method, MultiFDMethods =
*ops)
>  static int multifd_send_initial_packet(MultiFDSendParams *p, Error **err=
p)
>  {
>      MultiFDInit_t msg =3D {};
> +    size_t size =3D sizeof(msg);
>      int ret;
> =20
>      msg.magic =3D cpu_to_be32(MULTIFD_MAGIC);
> @@ -182,10 +183,12 @@ static int multifd_send_initial_packet(MultiFDSendP=
arams *p, Error **errp)
>      msg.id =3D p->id;
>      memcpy(msg.uuid, &qemu_uuid.data, sizeof(msg.uuid));
> =20
> -    ret =3D qio_channel_write_all(p->c, (char *)&msg, sizeof(msg), errp)=
;
> +    ret =3D qio_channel_write_all(p->c, (char *)&msg, size, errp);
>      if (ret !=3D 0) {
>          return -1;
>      }
> +    stat64_add(&mig_stats.multifd_bytes, size);
> +    stat64_add(&mig_stats.transferred, size);
>      return 0;
>  }

Humm, those are atomic ops, right?

You think we could have 'multifd_bytes' and 'transferred' in the same cache=
line,
to avoid 2 cacheline bounces?

Well, it's unrelated to this patchset, so:

Reviewed-by: Leonardo Bras <leobras@redhat.com>

> =20
> @@ -395,7 +398,6 @@ static int multifd_send_pages(QEMUFile *f)
>      static int next_channel;
>      MultiFDSendParams *p =3D NULL; /* make happy gcc */
>      MultiFDPages_t *pages =3D multifd_send_state->pages;
> -    uint64_t transferred;
> =20
>      if (qatomic_read(&multifd_send_state->exiting)) {
>          return -1;
> @@ -430,10 +432,7 @@ static int multifd_send_pages(QEMUFile *f)
>      p->packet_num =3D multifd_send_state->packet_num++;
>      multifd_send_state->pages =3D p->pages;
>      p->pages =3D pages;
> -    transferred =3D ((uint64_t) pages->num) * p->page_size + p->packet_l=
en;
>      qemu_mutex_unlock(&p->mutex);
> -    stat64_add(&mig_stats.transferred, transferred);
> -    stat64_add(&mig_stats.multifd_bytes, transferred);
>      qemu_sem_post(&p->sem);
> =20
>      return 1;
> @@ -715,6 +714,8 @@ static void *multifd_send_thread(void *opaque)
>                  if (ret !=3D 0) {
>                      break;
>                  }
> +                stat64_add(&mig_stats.multifd_bytes, p->packet_len);
> +                stat64_add(&mig_stats.transferred, p->packet_len);
>              } else {
>                  /* Send header using the same writev call */
>                  p->iov[0].iov_len =3D p->packet_len;
> @@ -727,6 +728,8 @@ static void *multifd_send_thread(void *opaque)
>                  break;
>              }
> =20
> +            stat64_add(&mig_stats.multifd_bytes, p->next_packet_size);
> +            stat64_add(&mig_stats.transferred, p->next_packet_size);
>              qemu_mutex_lock(&p->mutex);
>              p->pending_job--;
>              qemu_mutex_unlock(&p->mutex);


