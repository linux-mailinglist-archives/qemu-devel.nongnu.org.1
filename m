Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C51DA712D06
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 21:04:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2cjK-0003Xu-V7; Fri, 26 May 2023 15:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1q2cjG-0003Va-V0
 for qemu-devel@nongnu.org; Fri, 26 May 2023 15:03:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1q2cjD-0004Im-Dl
 for qemu-devel@nongnu.org; Fri, 26 May 2023 15:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685127834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JzcfTO8KIxsw1Zv4fm8zZCwEYEtrXUvyTk76utywgFM=;
 b=AVl0kecNmhioU9SE7pjTilEMHzdrHEs64mTD26z50tTAO2ubk4l8NwZw4VLPwHR1n06dC3
 OHob/wgZi9KHk9KmwWsurd70EiciQqwc+nJjqH2oxiPi/8MlQCx6Z1hZNXSF4X+DbcSpo9
 GGxep5N8K5P3+rkuGB0rI/nbvPm72P8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-CNIe4ShbM8eliKoYPnXI1A-1; Fri, 26 May 2023 15:03:53 -0400
X-MC-Unique: CNIe4ShbM8eliKoYPnXI1A-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-75b1ad467b7so81982285a.3
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 12:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685127833; x=1687719833;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JzcfTO8KIxsw1Zv4fm8zZCwEYEtrXUvyTk76utywgFM=;
 b=AJRQ3CRFX+C/vmGKHSnYIO3f4D+EXwaiEbd3PYZId5GSnjvdlxVQXRgpP1drQs4TQS
 CSPoTpphW/YNIVnYRMVzUU5jIZAQZr4WSLWgmWBpqAnl094pwTITaJYXNqtyPx8JJJ0U
 WznVlzHXutvCjfpWvhA3pYcSLt7zmGdjAoU6W5sq/vOOnsZOMxt47re4eBEbOj0kHA0a
 euZx6Mc2bXMq3mmsegeDxJ5wP4LPrV/lt8Q2gkev0jQeVt68NueNTiD568XrY5LdqyjF
 BZt5VqW8YmQzw3ELBAwZtuJvSOrhXvUGa4bSiYQXDuKBglZ3NEaEHiVT4tNUTF5bHFoL
 1dVg==
X-Gm-Message-State: AC+VfDw2MfcB+WmLQHzgTyUZu8HSe57XwVSZoCzpgxGI8G5PUmH2rAFS
 sR6TupH4i0lZ2xRNilU/PSTnGPLICEJ8k49BiU+InOiRKIjNCTm6rT7tcoRfCuNuasthdJquBBB
 JrR9iBQAFm2e6nEbVnCCeesUUApRABUc=
X-Received: by 2002:a05:622a:353:b0:3f5:33c:eacb with SMTP id
 r19-20020a05622a035300b003f5033ceacbmr3184319qtw.1.1685127832827; 
 Fri, 26 May 2023 12:03:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7UjsGRAaBtzCib6xX2SLLB6DKKVmVomDKLJb23x684ykJNyB8LNe3HyACmx7nqNtBrSVVF+ZBRm4OEUQzw8Hc=
X-Received: by 2002:a05:622a:353:b0:3f5:33c:eacb with SMTP id
 r19-20020a05622a035300b003f5033ceacbmr3184288qtw.1.1685127832503; Fri, 26 May
 2023 12:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-16-quintela@redhat.com>
 <b0d83669673a8335fb83992fbf6706091d4d1cb3.camel@redhat.com>
 <87o7m733l7.fsf@secure.mitica>
In-Reply-To: <87o7m733l7.fsf@secure.mitica>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Fri, 26 May 2023 16:03:41 -0300
Message-ID: <CAJ6HWG5FK0tQbFeT8tKOHsQQKCOtVVPd5ypN=Ep9sMm3X+pypg@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] migration/rdma: Simplify the function that saves
 a page
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lsoaresp@redhat.com;
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

On Fri, May 26, 2023 at 5:21=E2=80=AFAM Juan Quintela <quintela@redhat.com>=
 wrote:
>
> Leonardo Br=C3=A1s <leobras@redhat.com> wrote:
> > On Mon, 2023-05-15 at 21:57 +0200, Juan Quintela wrote:
> >> When we sent a page through QEMUFile hooks (RDMA) there are three
> >> posiblities:
> >> - We are not using RDMA. return RAM_SAVE_CONTROL_DELAYED and
> >>   control_save_page() returns false to let anything else to proceed.
> >> - There is one error but we are using RDMA.  Then we return a negative
> >>   value, control_save_page() needs to return true.
> >> - Everything goes well and RDMA start the sent of the page
> >>   asynchronously.  It returns RAM_SAVE_CONTROL_DELAYED and we need to
> >>   return 1 for ram_save_page_legacy.
> >>
> >> Clear?
> >>
> >> I know, I know, the interfaz is as bad as it gets.  I think that now
> >> it is a bit clearer, but this needs to be done some other way.
> >
> > interface?
>
> Yeap.  I used the Spanish spelling, that, you know, in English is wrong O=
:-)

Happens to me all the time :)

>
> Thanks.
> >> diff --git a/migration/rdma.c b/migration/rdma.c
> >> index 416dec00a2..12d3c23fdc 100644
> >> --- a/migration/rdma.c
> >> +++ b/migration/rdma.c
> >> @@ -3239,13 +3239,12 @@ qio_channel_rdma_shutdown(QIOChannel *ioc,
> >>   *
> >>   *    @size : Number of bytes to transfer
> >>   *
> >> - *    @bytes_sent : User-specificed pointer to indicate how many byte=
s were
> >> + *    @pages_sent : User-specificed pointer to indicate how many page=
s were
> >>   *                  sent. Usually, this will not be more than a few b=
ytes of
> >>   *                  the protocol because most transfers are sent asyn=
chronously.
> >>   */
> >
> > There is new doc to pages_sent but the parameter is not added to the si=
gnature
> > bellow. Am I missing something?
>
> Good catch.

:)

>
> I redid this patch several times.  And it appears that I forgot some left=
overs.
>
> >
> >> -static size_t qemu_rdma_save_page(QEMUFile *f,
> >> -                                  ram_addr_t block_offset, ram_addr_t=
 offset,
> >> -                                  size_t size, uint64_t *bytes_sent)
> >> +static int qemu_rdma_save_page(QEMUFile *f, ram_addr_t block_offset,
> >> +                               ram_addr_t offset, size_t size)
> >>  {
> >>      QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
> >>      RDMAContext *rdma;
> >> @@ -3277,18 +3276,6 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
> >>          goto err;
> >>      }
> >>
> >> -    /*
> >> -     * We always return 1 bytes because the RDMA
> >> -     * protocol is completely asynchronous. We do not yet know
> >> -     * whether an  identified chunk is zero or not because we're
> >> -     * waiting for other pages to potentially be merged with
> >> -     * the current chunk. So, we have to call qemu_update_position()
> >> -     * later on when the actual write occurs.
> >> -     */
> >> -    if (bytes_sent) {
> >> -        *bytes_sent =3D 1;
> >> -    }
> >> -
> >>      /*
> >>       * Drain the Completion Queue if possible, but do not block,
> >>       * just poll.
> >
> > Oh, so this one complements 13/16.
> > Since it doesn't do imaginary transfers anymore, there is no need to us=
e
> > bytes_sent pointer to keep track of them anymore.
> >
> > Other than the pages_sent above that I couldn't understand:
> > Reviewed-by: Leonardo Bras <leobras@redhat.com>
>
> Dropping that bit.
>
> Thanks.
>


