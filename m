Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC73C712CE5
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 20:55:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2caU-0008AZ-AJ; Fri, 26 May 2023 14:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1q2caR-00089Y-7U
 for qemu-devel@nongnu.org; Fri, 26 May 2023 14:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1q2caP-00006d-0p
 for qemu-devel@nongnu.org; Fri, 26 May 2023 14:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685127287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IQNQU2i72QEIPgZZ4pRVRrz+a8NOF1r+i4gywlQR/u0=;
 b=Ho8HCWEROckXz/kNFchIXiXhLkaYvxPV4WpUq4VFluOcsu1obSDSm/WAIgGVlfPP+B8qwZ
 ZxTe1/D7OGOBcvAEaIPrLqXs6WUANxH6RmBeuMn/UPYVaRXjVkT0ogoXDHKd2l1y/lWlA6
 0GhBNkdpndaYBspW+m/9yap8fYsgFLo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596--6fEvqvSNtK-Ze4e5kaKlg-1; Fri, 26 May 2023 14:54:38 -0400
X-MC-Unique: -6fEvqvSNtK-Ze4e5kaKlg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-62386d1f3ecso8568346d6.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 11:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685127277; x=1687719277;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IQNQU2i72QEIPgZZ4pRVRrz+a8NOF1r+i4gywlQR/u0=;
 b=FR57R8QP47hQ9676u7kafdQF2OTBeH85nh5SwyW2R0KfzhodrZha1+QPZkOPgUI5Tl
 ynKBVDsRearS6Bue7gXEvf21m3FIznDfK1ZppsttpsiF0aZ0a1mibawfgzmqV0zl20tD
 zeAH65h8I+UwLyf3yzlGSa5pIno7rM9cQNdh1VexNvw9DeTLYs4UGgAt85cck73MZejR
 fTfNyDvgLZt0dUZL2OojAQdBMcoUzQr+IOSBr8zVcJpxINEqpuq0tmbfAs1Olu/69Umk
 vKRsJbU6m9rxfjTJWkEN1Uv9MOu6Pj9SFmmLVeLH4jCLhQ4gNqGESbuQWU+H0b9Fhz7H
 kEaA==
X-Gm-Message-State: AC+VfDxw5CBpGcvtQ6XApL/DHDf4iX8jtEjNbK5xsRjAiEVbrU/vifhu
 hY8JOA7Ors7/RBCiokmo7vF3WaW1glTUL5A3j6/4gg8z7MoVw20LL+Qm++6KMM1LkSolJyrR0pG
 ddOfVcgZ/QJP2rydQSkKBPQC0loy1s/M=
X-Received: by 2002:a05:6214:5193:b0:625:b752:6574 with SMTP id
 kl19-20020a056214519300b00625b7526574mr3104543qvb.55.1685127277194; 
 Fri, 26 May 2023 11:54:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4v4j1/mS9wLMzCMluRBvthbUc7RFgWYJUYE9Xr11lSXZrIDM9OcBk4aEEZChfTc6IFFYlfKDNkjxdlIbgjvL0=
X-Received: by 2002:a05:6214:5193:b0:625:b752:6574 with SMTP id
 kl19-20020a056214519300b00625b7526574mr3104534qvb.55.1685127276949; Fri, 26
 May 2023 11:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-5-quintela@redhat.com>
 <d964a469a3231e1d98b2b39a5348832eecf44bf9.camel@redhat.com>
 <871qj34iq9.fsf@secure.mitica>
In-Reply-To: <871qj34iq9.fsf@secure.mitica>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Fri, 26 May 2023 15:54:25 -0300
Message-ID: <CAJ6HWG680HSyPa+JeBtknGrh1D7NSD0Gm53EMnubVs2_HqZ8Sg@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] qemu-file: Account for rate_limit usage on
 qemu_fflush()
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

On Fri, May 26, 2023 at 5:09=E2=80=AFAM Juan Quintela <quintela@redhat.com>=
 wrote:
>
> Leonardo Br=C3=A1s <leobras@redhat.com> wrote:
> > On Mon, 2023-05-15 at 21:56 +0200, Juan Quintela wrote:
> >> That is the moment we know we have transferred something.
> >>
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> ---
> >>  migration/qemu-file.c | 7 +++----
> >>  1 file changed, 3 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> >> index 4bc875b452..956bd2a580 100644
> >> --- a/migration/qemu-file.c
> >> +++ b/migration/qemu-file.c
> >> @@ -302,7 +302,9 @@ void qemu_fflush(QEMUFile *f)
> >>                                     &local_error) < 0) {
> >>              qemu_file_set_error_obj(f, -EIO, local_error);
> >>          } else {
> >> -            f->total_transferred +=3D iov_size(f->iov, f->iovcnt);
> >> +            uint64_t size =3D iov_size(f->iov, f->iovcnt);
> >> +            qemu_file_acct_rate_limit(f, size);
> >> +            f->total_transferred +=3D size;
> >>          }
> >>
> >>          qemu_iovec_release_ram(f);
> >> @@ -519,7 +521,6 @@ void qemu_put_buffer_async(QEMUFile *f, const uint=
8_t *buf, size_t size,
> >>          return;
> >>      }
> >>
> >> -    f->rate_limit_used +=3D size;
> >>      add_to_iovec(f, buf, size, may_free);
> >>  }
> >>
> >> @@ -537,7 +538,6 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *b=
uf, size_t size)
> >>              l =3D size;
> >>          }
> >>          memcpy(f->buf + f->buf_index, buf, l);
> >> -        f->rate_limit_used +=3D l;
> >>          add_buf_to_iovec(f, l);
> >>          if (qemu_file_get_error(f)) {
> >>              break;
> >> @@ -554,7 +554,6 @@ void qemu_put_byte(QEMUFile *f, int v)
> >>      }
> >>
> >>      f->buf[f->buf_index] =3D v;
> >> -    f->rate_limit_used++;
> >>      add_buf_to_iovec(f, 1);
> >>  }
> >>
> >
> > If we are counting transferred data at fflush, it makes sense to increa=
se rate-
> > limit accounting at the same place. It may be less granular, but is mor=
e
> > efficient.
>
> Yeap, the whole point is that in my next series, rate_limit_used
> dissapear, we just use transferred for both things(*).
>
> Later, Juan.
>
> *: It is a bit more complicated than that, but we go from three counters
>  to a single counter.
>

Seems great to simplify stuff.
Thanks!
Leo


