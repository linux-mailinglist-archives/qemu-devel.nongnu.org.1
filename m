Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A143712D0F
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 21:05:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2cka-0004yz-57; Fri, 26 May 2023 15:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1q2ckW-0004xT-OM
 for qemu-devel@nongnu.org; Fri, 26 May 2023 15:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1q2ckS-0005Bt-O7
 for qemu-devel@nongnu.org; Fri, 26 May 2023 15:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685127911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yXwcW6I17DRDQ0j4u0iTSN2M+LQKDC+nIM60ARlnGtQ=;
 b=WGEu3Qw1DTC8Jl+rDEEKBZGlwYA0Xo72bSOeQOnZYh9pIB+NwRA+RXKQ4QQ8jFezEx4l+D
 dMXGA6XCfsq1aaW8O+oN9pMu1jS64CQ9018M2oOVcL0jkB96imLZKspYFRPaGnHKaTi7cb
 WfaiPLqA7oCKi26NXHUKK0h3BgFdGq8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-RTPip3XfODuDg2YZmOyCQQ-1; Fri, 26 May 2023 15:05:10 -0400
X-MC-Unique: RTPip3XfODuDg2YZmOyCQQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3f52eb10869so16153211cf.3
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 12:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685127909; x=1687719909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yXwcW6I17DRDQ0j4u0iTSN2M+LQKDC+nIM60ARlnGtQ=;
 b=LRwY+8UuistXy5kiD0/FnAetLKAnZzCqTyL3iZfSpPvEeKaVmrtUMjVRjaO0t6/V1y
 HH0/vlo+3NLkKpBHvhns43yy09snJGuwQOGd4Tx01hLW0dDs/ECgt1YJ/HZ4hWtsl70e
 DFy29IPNqsDaroPLVyOOSWuonDndsYB/kJFwhIcIFjHkdRz2tN5VbSHynWSZ4JitfH9Z
 TQmVF0y5LoYr1MuvLKmpJixEsqAjbKpCiy2ek7u4TrJFXNFaRgvPYgOLH9PLDeNAlqtL
 s57jsZoLp5DkDv2dx7IGEGJS2iNnD6DX3qY/h0KNoYXc5mc7HqkxmTE5BLjKTWVAYSAC
 cWkQ==
X-Gm-Message-State: AC+VfDw9dFn1Wh8plPoGCR4tMnXXMiUiuf7EK9xIZfvoofHqyeJGOgQB
 rVX1G8WbsnQnXcghQSJCBSKm4WQNZDhkuSlalFkXQe+OxyCS1W50I6kfIhLauH16qHmlf/snmLY
 op3O5YKsAhaJMQ0BW8sXHRj0UnO1IWDB0jtg0oogdwA==
X-Received: by 2002:a05:622a:178c:b0:3d9:45a4:e7b9 with SMTP id
 s12-20020a05622a178c00b003d945a4e7b9mr2555411qtk.45.1685127909734; 
 Fri, 26 May 2023 12:05:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4vtXH9wif/7ZT4/+K6iAodhZH2j2Fi/69VsiZ9v5JpcyFG9VbltgUA8CVNyZy1N4Xq91nxiz+5teTJsUnHSho=
X-Received: by 2002:a05:622a:178c:b0:3d9:45a4:e7b9 with SMTP id
 s12-20020a05622a178c00b003d945a4e7b9mr2555378qtk.45.1685127909546; Fri, 26
 May 2023 12:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-17-quintela@redhat.com>
 <17c133c69e5207e81784c081dd82950a31b8d826.camel@redhat.com>
 <87jzwv33he.fsf@secure.mitica>
In-Reply-To: <87jzwv33he.fsf@secure.mitica>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Fri, 26 May 2023 16:04:58 -0300
Message-ID: <CAJ6HWG4s+qtpz+=c9HguAdqaopnhsOhBcgmyRueK0h=GNwdgoA@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] migration/multifd: Compute transferred bytes
 correctly
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Greg Kurz <groug@kaod.org>, 
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, 
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, 
 David Hildenbrand <david@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Eric Farman <farman@linux.ibm.com>, qemu-block@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lsoaresp@redhat.com;
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

On Fri, May 26, 2023 at 5:24=E2=80=AFAM Juan Quintela <quintela@redhat.com>=
 wrote:
>
> Leonardo Br=C3=A1s <leobras@redhat.com> wrote:
> > On Mon, 2023-05-15 at 21:57 +0200, Juan Quintela wrote:
> >> In the past, we had to put the in the main thread all the operations
> >> related with sizes due to qemu_file not beeing thread safe.  As now
> >> all counters are atomic, we can update the counters just after the
> >> do the write.  As an aditional bonus, we are able to use the right
> >> value for the compression methods.  Right now we were assuming that
> >> there were no compression at all.
> >>
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> ---
> >>  migration/multifd.c | 13 ++++++++-----
> >>  1 file changed, 8 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/migration/multifd.c b/migration/multifd.c
> >> index aabf9b6d98..0bf5958a9c 100644
> >> --- a/migration/multifd.c
> >> +++ b/migration/multifd.c
> >> @@ -175,6 +175,7 @@ void multifd_register_ops(int method, MultiFDMetho=
ds *ops)
> >>  static int multifd_send_initial_packet(MultiFDSendParams *p, Error **=
errp)
> >>  {
> >>      MultiFDInit_t msg =3D {};
> >> +    size_t size =3D sizeof(msg);
> >>      int ret;
> >>
> >>      msg.magic =3D cpu_to_be32(MULTIFD_MAGIC);
> >> @@ -182,10 +183,12 @@ static int multifd_send_initial_packet(MultiFDSe=
ndParams *p, Error **errp)
> >>      msg.id =3D p->id;
> >>      memcpy(msg.uuid, &qemu_uuid.data, sizeof(msg.uuid));
> >>
> >> -    ret =3D qio_channel_write_all(p->c, (char *)&msg, sizeof(msg), er=
rp);
> >> +    ret =3D qio_channel_write_all(p->c, (char *)&msg, size, errp);
> >>      if (ret !=3D 0) {
> >>          return -1;
> >>      }
> >> +    stat64_add(&mig_stats.multifd_bytes, size);
> >> +    stat64_add(&mig_stats.transferred, size);
> >>      return 0;
> >>  }
> >
> > Humm, those are atomic ops, right?
> >
> > You think we could have 'multifd_bytes' and 'transferred' in the same c=
acheline,
> > to avoid 2 cacheline bounces?
>
> Don't matter on next series.
>
> mig_stats.transferred is dropped.
>
> And transferred becomes:
>
> qemu_file_transferred + multifd_bytes + rdma_bytes.
>
> So everytime that we do a write, we only update one counter.

That's even better :)

Thanks!

>
> > Well, it's unrelated to this patchset, so:
> >
> > Reviewed-by: Leonardo Bras <leobras@redhat.com>
>


