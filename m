Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA387105D3
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 08:51:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q24oz-0005m0-BQ; Thu, 25 May 2023 02:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q24oY-0005VH-1b
 for qemu-devel@nongnu.org; Thu, 25 May 2023 02:51:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q24oU-00016V-DC
 for qemu-devel@nongnu.org; Thu, 25 May 2023 02:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684997465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BhU47AMmMEheZVTVwLkvmR/4DEVNiJF3Wlu674zIUM0=;
 b=LIycI4xl17gAZsrVO3FGq+iQxd0IPniPy0ty11w5H6LSYAmrxZzyBWWmJxRQaDz/eYqx8e
 JHEwlPnwclUnMf9PeZLjb7nmJ6gEJu5ttUH76o+M5teiUamwJ76xD9C4oKyEBP9iCiMjkp
 oOocCt/cHCgs3ev9KdLkUqIqvpivOXA=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-fNGakYFlPMCgIRreai4sKw-1; Thu, 25 May 2023 02:51:03 -0400
X-MC-Unique: fNGakYFlPMCgIRreai4sKw-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-555355303eeso289216eaf.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 23:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684997462; x=1687589462;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BhU47AMmMEheZVTVwLkvmR/4DEVNiJF3Wlu674zIUM0=;
 b=A5gNM2PFpzR7K+ilHJSdzKUqhE3tGcHn6p9JonWBdn9mKfJ1IgPPYDHHW6uF4r45Up
 zXm1yzTQMjm/dmqIijB/N0/jI6Zad9u+E7BTPItzYZyQQYb1ZHzvUHaSIG1f1IGidDBJ
 eNbf1mFYc540cuIJD7ILF8sQ4JstaqfKltIzWUUdlsSRpQqDw7+AOn6nYUUdM/QkfKWz
 KunETjNGaEP3MEcnr9SITd0Kil456w8Yb1KuhUm0IGxYElWNDDF/wMNK/nblKb3frH01
 sdaDIe1K38MHpl43LD5z280TotD2o3dgK1Y6Ip4pkk0bil9lxj9GSIEThPf8pmr7pVYg
 RWIQ==
X-Gm-Message-State: AC+VfDw5gHd0GkRMO1wpZRByCTr9D95PYsgJuUaajzkGU98VJONlX5c4
 c95+cUfSGDzrTiUShMOEnhQJu+cz9+/VSp3PHkuQvHV1oEFqvbD75DpVnbbmDeCRiEjBJeaet5L
 oxvgGRQ3yTMc6usg=
X-Received: by 2002:aca:d9d6:0:b0:394:45fa:ca4b with SMTP id
 q205-20020acad9d6000000b0039445faca4bmr964722oig.29.1684997462553; 
 Wed, 24 May 2023 23:51:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5qu5NnbXEOp1XBWY8bRDC5xRJQO+We6hclVvwT6GBXHPC+fhew54u35RgtooH53YZdpRHZMA==
X-Received: by 2002:aca:d9d6:0:b0:394:45fa:ca4b with SMTP id
 q205-20020acad9d6000000b0039445faca4bmr964697oig.29.1684997462300; 
 Wed, 24 May 2023 23:51:02 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:7f0c:32e1:e970:713a:f05b?
 ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
 by smtp.gmail.com with ESMTPSA id
 e185-20020acab5c2000000b003924c15cf58sm226135oif.20.2023.05.24.23.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 23:51:01 -0700 (PDT)
Message-ID: <59d1842c50010122dd5d18bff65d280d0b2d6b47.camel@redhat.com>
Subject: Re: [PATCH v2 09/16] migration: We don't need the field
 rate_limit_used anymore
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
Date: Thu, 25 May 2023 03:50:55 -0300
In-Reply-To: <20230515195709.63843-10-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-10-quintela@redhat.com>
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

On Mon, 2023-05-15 at 21:57 +0200, Juan Quintela wrote:
> Since previous commit, we calculate how much data we have send with
> migration_transferred_bytes() so no need to maintain this counter and
> remember to always update it.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  migration/migration-stats.h | 14 --------------
>  migration/migration-stats.c |  6 ------
>  migration/multifd.c         |  1 -
>  migration/qemu-file.c       |  4 ----
>  4 files changed, 25 deletions(-)
>=20
> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> index f1465c2ebe..9568b5b473 100644
> --- a/migration/migration-stats.h
> +++ b/migration/migration-stats.h
> @@ -89,10 +89,6 @@ typedef struct {
>       * Maximum amount of data we can send in a cycle.
>       */
>      Stat64 rate_limit_max;
> -    /*
> -     * Amount of data we have sent in the current cycle.
> -     */
> -    Stat64 rate_limit_used;
>      /*
>       * How long has the setup stage took.
>       */
> @@ -119,16 +115,6 @@ extern MigrationAtomicStats mig_stats;
>   */
>  void migration_time_since(MigrationAtomicStats *stats, int64_t since);
> =20
> -/**
> - * migration_rate_account: Increase the number of bytes transferred.
> - *
> - * Report on a number of bytes the have been transferred that need to
> - * be applied to the rate limiting calcuations.
> - *
> - * @len: amount of bytes transferred
> - */
> -void migration_rate_account(uint64_t len);
> -
>  /**
>   * migration_rate_get: Get the maximum amount that can be transferred.
>   *
> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
> index da2bb69a15..abf2d38b18 100644
> --- a/migration/migration-stats.c
> +++ b/migration/migration-stats.c
> @@ -62,15 +62,9 @@ void migration_rate_set(uint64_t limit)
> =20
>  void migration_rate_reset(QEMUFile *f)
>  {
> -    stat64_set(&mig_stats.rate_limit_used, 0);
>      stat64_set(&mig_stats.rate_limit_start, migration_transferred_bytes(=
f));
>  }
> =20
> -void migration_rate_account(uint64_t len)
> -{
> -    stat64_add(&mig_stats.rate_limit_used, len);
> -}
> -
>  uint64_t migration_transferred_bytes(QEMUFile *f)
>  {
>      uint64_t multifd =3D stat64_get(&mig_stats.multifd_bytes);
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 5052091ce2..aabf9b6d98 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -431,7 +431,6 @@ static int multifd_send_pages(QEMUFile *f)
>      multifd_send_state->pages =3D p->pages;
>      p->pages =3D pages;
>      transferred =3D ((uint64_t) pages->num) * p->page_size + p->packet_l=
en;
> -    migration_rate_account(transferred);
>      qemu_mutex_unlock(&p->mutex);
>      stat64_add(&mig_stats.transferred, transferred);
>      stat64_add(&mig_stats.multifd_bytes, transferred);
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 9c67b52fe0..acc282654a 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -292,7 +292,6 @@ void qemu_fflush(QEMUFile *f)
>              qemu_file_set_error_obj(f, -EIO, local_error);
>          } else {
>              uint64_t size =3D iov_size(f->iov, f->iovcnt);
> -            migration_rate_account(size);
>              f->total_transferred +=3D size;
>          }
> =20
> @@ -344,9 +343,6 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t =
block_offset,
>      if (f->hooks && f->hooks->save_page) {
>          int ret =3D f->hooks->save_page(f, block_offset,
>                                        offset, size, bytes_sent);
> -        if (ret !=3D RAM_SAVE_CONTROL_NOT_SUPP) {
> -            migration_rate_account(size);
> -        }
> =20
>          if (ret !=3D RAM_SAVE_CONTROL_DELAYED &&
>              ret !=3D RAM_SAVE_CONTROL_NOT_SUPP) {

I reviewed this one together with 8/16.
It makes sense for me to squash them together, but anyway:

Reviewed-by: Leonardo Bras <leobras@redhat.com>


