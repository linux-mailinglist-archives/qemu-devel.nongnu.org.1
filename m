Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A63710263
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 03:35:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1zra-0007Pc-8T; Wed, 24 May 2023 21:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q1zrU-0007Of-6X
 for qemu-devel@nongnu.org; Wed, 24 May 2023 21:33:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q1zrR-00075D-LM
 for qemu-devel@nongnu.org; Wed, 24 May 2023 21:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684978428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zpLm59aI2QPa3GW6pZF2C1X3n9KU1NFjdc9EXhWfPpQ=;
 b=au0nYsOfAqibV6e0uq+KEXn5moJLvp11p2u6WstOg6OJmeZwVOjWyy6hwrLYdVw46J7ZU3
 Ps6RekWZnlTGPFibz8Zvgi5BVXaFyX+VicbqGe0HDp6FB/iKhglYE9+WH9Vlzsb+l0VjOv
 lbmAePCKp+VGSyqiBsGv5Auk4QDEoOs=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-slxNcq76OPqbqP3-9JIp_A-1; Wed, 24 May 2023 21:33:47 -0400
X-MC-Unique: slxNcq76OPqbqP3-9JIp_A-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3981eed0385so806779b6e.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 18:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684978426; x=1687570426;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zpLm59aI2QPa3GW6pZF2C1X3n9KU1NFjdc9EXhWfPpQ=;
 b=e2lWwQjDn1xJm3x/sVkV6sKpzF2GD0EQmcoL+OaAzITbM+KZ6Lh6a0p73Ml/4zzEX1
 xzho1FCiqHA2V8vD1y7gNu1oBlR4lL1JaoCUfzONHmjganHRs+VpiGdSb1o+BQZtk84Z
 ZqGoybL7b/7hgCBLakL3sbGZ4qrasnoFtvmi7WnF3rzm1DjcX3Phsv06sBC37e6UBrja
 8Efkz32eJD9aTAN59aWfXOq3aq+KuridJA/4J9E0PUEIOgZXqtzlK1HEgxnWMlt+u8UM
 g6kucsEpIkWzDiwjxGeN/Y8VNW3a/55/vltGdv/1VixGZKekOMlkPerh4e7+ZikF8giY
 V6hA==
X-Gm-Message-State: AC+VfDzm1ykIE9xacWyEfUMZh6cZh1qwLMdFdZB28swekJP0fDy2zwS+
 9cxf5tXYscXYNlelXQ63EMUN6/lf7NnaX6uFYAfz40ICPcsS5WV+eBBp1kVnecr7dEukEcqk3Bi
 whlHA0GTj5XItv2s=
X-Received: by 2002:aca:1016:0:b0:397:98dd:b8fc with SMTP id
 22-20020aca1016000000b0039798ddb8fcmr9814243oiq.38.1684978426717; 
 Wed, 24 May 2023 18:33:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4R3gDFc4PAgVRmk1Rkgnnh2F24hy6TyiIv+pVnXV2jazqtelFqh/IWmG3yxIRRVaB3aWtOMQ==
X-Received: by 2002:aca:1016:0:b0:397:98dd:b8fc with SMTP id
 22-20020aca1016000000b0039798ddb8fcmr9814223oiq.38.1684978426496; 
 Wed, 24 May 2023 18:33:46 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:7f0c:32e1:e970:713a:f05b?
 ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
 by smtp.gmail.com with ESMTPSA id
 e185-20020acab5c2000000b003924c15cf58sm10673oif.20.2023.05.24.18.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 18:33:45 -0700 (PDT)
Message-ID: <d964a469a3231e1d98b2b39a5348832eecf44bf9.camel@redhat.com>
Subject: Re: [PATCH v2 04/16] qemu-file: Account for rate_limit usage on
 qemu_fflush()
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
Date: Wed, 24 May 2023 22:33:39 -0300
In-Reply-To: <20230515195709.63843-5-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-5-quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leobras@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On Mon, 2023-05-15 at 21:56 +0200, Juan Quintela wrote:
> That is the moment we know we have transferred something.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  migration/qemu-file.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 4bc875b452..956bd2a580 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -302,7 +302,9 @@ void qemu_fflush(QEMUFile *f)
>                                     &local_error) < 0) {
>              qemu_file_set_error_obj(f, -EIO, local_error);
>          } else {
> -            f->total_transferred +=3D iov_size(f->iov, f->iovcnt);
> +            uint64_t size =3D iov_size(f->iov, f->iovcnt);
> +            qemu_file_acct_rate_limit(f, size);
> +            f->total_transferred +=3D size;
>          }
> =20
>          qemu_iovec_release_ram(f);
> @@ -519,7 +521,6 @@ void qemu_put_buffer_async(QEMUFile *f, const uint8_t=
 *buf, size_t size,
>          return;
>      }
> =20
> -    f->rate_limit_used +=3D size;
>      add_to_iovec(f, buf, size, may_free);
>  }
> =20
> @@ -537,7 +538,6 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf,=
 size_t size)
>              l =3D size;
>          }
>          memcpy(f->buf + f->buf_index, buf, l);
> -        f->rate_limit_used +=3D l;
>          add_buf_to_iovec(f, l);
>          if (qemu_file_get_error(f)) {
>              break;
> @@ -554,7 +554,6 @@ void qemu_put_byte(QEMUFile *f, int v)
>      }
> =20
>      f->buf[f->buf_index] =3D v;
> -    f->rate_limit_used++;
>      add_buf_to_iovec(f, 1);
>  }
> =20

If we are counting transferred data at fflush, it makes sense to increase r=
ate-
limit accounting at the same place. It may be less granular, but is more
efficient.

FWIW:
Reviewed-by: Leonardo Bras <leobras@redhat.com>


