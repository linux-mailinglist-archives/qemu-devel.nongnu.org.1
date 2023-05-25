Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9787106EE
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 10:11:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2646-0007rH-T9; Thu, 25 May 2023 04:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q2641-0007hx-6q
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q263w-0001v8-GO
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685002265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=++f7TuJLKgZI3MvyhDoGan2HPEhzngQuq7CZwdiYMDs=;
 b=aQJ2Ma/N6fn8JeMtZKvKhUm2L2LeyHhqK2o8VW7xCGhidI+pGWMVwl2eqexuas7Jn5WGNg
 xi/9EvWKYVskyeOUheZcsP6bOzYBShYVm0q/eNSYmqru46zmj6yT9AwP+4qcphpQirKijo
 vr5Fd5s+jiHO4tPZzfFvMvrupjepqZs=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-pI7rbSiOP9GH6g7pVn6CpQ-1; Thu, 25 May 2023 04:11:04 -0400
X-MC-Unique: pI7rbSiOP9GH6g7pVn6CpQ-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6af6e80d24aso1204146a34.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 01:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685002263; x=1687594263;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=++f7TuJLKgZI3MvyhDoGan2HPEhzngQuq7CZwdiYMDs=;
 b=jOVnUl6xDCJs/PMpTHDYgxPLA1MPfKQwsGXa8f3OHEgRoAqSzHAXHJ25UwFcZCxcBg
 9K9fvaQPoc2Moav1jLc6RjwdI6C8ltAB4GSyWyWL7d8RaEb1bDaA7wTRU8q4CriHtstg
 k1C/NxaI9tKv0VjN3+qBcVrGIz2vW2SOdGhcXLaH+vw/ut0EBF8F+z5Yy9QXDWTC51rE
 cVwwdJQloOjpWxgVhq1PVtCywnpWB4slgZLp1zBJsBssifXZ8N4BV77KQIaiZCwxe3ah
 4pwAqm1s7cEgE0uoTSrPtZK0O6ttcVcTiyBvcuACOF+9Jsb3oBha+wRSjUl2sJ+egz7U
 wYQQ==
X-Gm-Message-State: AC+VfDy5qdQAm40sHhPbBZuE7Z3YhMYDNecXyw418fOZShkeESeFaqZQ
 s9ykxz0/uw1mgW7BRWXIzjJsAiuad0ATXwAVVNPlOSJ6lzmWIb9K8AhYsacsj5FToRPJ4pqZwps
 aHKbOZu6Rz1ntpkE=
X-Received: by 2002:a9d:740c:0:b0:6af:a078:e61 with SMTP id
 n12-20020a9d740c000000b006afa0780e61mr2007647otk.23.1685002263319; 
 Thu, 25 May 2023 01:11:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ44/s1WGR9gMBi6o8xd0anATsgx22hDRsX8pmb4/4iKRciMekVsHOv98tJzjxu4y6EL1UKxkg==
X-Received: by 2002:a9d:740c:0:b0:6af:a078:e61 with SMTP id
 n12-20020a9d740c000000b006afa0780e61mr2007627otk.23.1685002263057; 
 Thu, 25 May 2023 01:11:03 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:7f0c:32e1:e970:713a:f05b?
 ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a9d65ca000000b006aca3e710desm404655oth.2.2023.05.25.01.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 01:11:02 -0700 (PDT)
Message-ID: <b0d83669673a8335fb83992fbf6706091d4d1cb3.camel@redhat.com>
Subject: Re: [PATCH v2 15/16] migration/rdma: Simplify the function that
 saves a page
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
Date: Thu, 25 May 2023 05:10:56 -0300
In-Reply-To: <20230515195709.63843-16-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-16-quintela@redhat.com>
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

On Mon, 2023-05-15 at 21:57 +0200, Juan Quintela wrote:
> When we sent a page through QEMUFile hooks (RDMA) there are three
> posiblities:
> - We are not using RDMA. return RAM_SAVE_CONTROL_DELAYED and
>   control_save_page() returns false to let anything else to proceed.
> - There is one error but we are using RDMA.  Then we return a negative
>   value, control_save_page() needs to return true.
> - Everything goes well and RDMA start the sent of the page
>   asynchronously.  It returns RAM_SAVE_CONTROL_DELAYED and we need to
>   return 1 for ram_save_page_legacy.
>=20
> Clear?
>=20
> I know, I know, the interfaz is as bad as it gets.  I think that now
> it is a bit clearer, but this needs to be done some other way.

interface?

>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/qemu-file.h | 14 ++++++--------
>  migration/qemu-file.c | 12 ++++++------
>  migration/ram.c       | 10 +++-------
>  migration/rdma.c      | 19 +++----------------
>  4 files changed, 18 insertions(+), 37 deletions(-)
>=20
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index 37f42315c7..ed77996201 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -49,11 +49,10 @@ typedef int (QEMURamHookFunc)(QEMUFile *f, uint64_t f=
lags, void *data);
>   * This function allows override of where the RAM page
>   * is saved (such as RDMA, for example.)
>   */
> -typedef size_t (QEMURamSaveFunc)(QEMUFile *f,
> -                                 ram_addr_t block_offset,
> -                                 ram_addr_t offset,
> -                                 size_t size,
> -                                 uint64_t *bytes_sent);
> +typedef int (QEMURamSaveFunc)(QEMUFile *f,
> +                              ram_addr_t block_offset,
> +                              ram_addr_t offset,
> +                              size_t size);
> =20
>  typedef struct QEMUFileHooks {
>      QEMURamHookFunc *before_ram_iterate;
> @@ -146,9 +145,8 @@ void ram_control_load_hook(QEMUFile *f, uint64_t flag=
s, void *data);
>  #define RAM_SAVE_CONTROL_NOT_SUPP -1000
>  #define RAM_SAVE_CONTROL_DELAYED  -2000
> =20
> -size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
> -                             ram_addr_t offset, size_t size,
> -                             uint64_t *bytes_sent);
> +int ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
> +                          ram_addr_t offset, size_t size);
>  QIOChannel *qemu_file_get_ioc(QEMUFile *file);
> =20
>  #endif
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 72e130631d..32ef5e9651 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -336,14 +336,14 @@ void ram_control_load_hook(QEMUFile *f, uint64_t fl=
ags, void *data)
>      }
>  }
> =20
> -size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
> -                             ram_addr_t offset, size_t size,
> -                             uint64_t *bytes_sent)
> +int ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
> +                          ram_addr_t offset, size_t size)
>  {
>      if (f->hooks && f->hooks->save_page) {
> -        int ret =3D f->hooks->save_page(f, block_offset,
> -                                      offset, size, bytes_sent);
> -
> +        int ret =3D f->hooks->save_page(f, block_offset, offset, size);
> +        /*
> +         * RAM_SAVE_CONTROL_* are negative values
> +         */
>          if (ret !=3D RAM_SAVE_CONTROL_DELAYED &&
>              ret !=3D RAM_SAVE_CONTROL_NOT_SUPP) {
>              if (ret < 0) {
> diff --git a/migration/ram.c b/migration/ram.c
> index 2d3927a15f..f9fcbb3bb8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1173,23 +1173,19 @@ static int save_zero_page(PageSearchStatus *pss, =
QEMUFile *f, RAMBlock *block,
>  static bool control_save_page(PageSearchStatus *pss, RAMBlock *block,
>                                ram_addr_t offset, int *pages)
>  {
> -    uint64_t bytes_xmit =3D 0;
>      int ret;
> =20
> -    *pages =3D -1;
>      ret =3D ram_control_save_page(pss->pss_channel, block->offset, offse=
t,
> -                                TARGET_PAGE_SIZE, &bytes_xmit);
> +                                TARGET_PAGE_SIZE);
>      if (ret =3D=3D RAM_SAVE_CONTROL_NOT_SUPP) {
>          return false;
>      }
> =20
> -    if (bytes_xmit) {
> -        *pages =3D 1;
> -    }
> -
>      if (ret =3D=3D RAM_SAVE_CONTROL_DELAYED) {
> +        *pages =3D 1;
>          return true;
>      }
> +    *pages =3D ret;
>      return true;
>  }
> =20
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 416dec00a2..12d3c23fdc 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3239,13 +3239,12 @@ qio_channel_rdma_shutdown(QIOChannel *ioc,
>   *
>   *    @size : Number of bytes to transfer
>   *
> - *    @bytes_sent : User-specificed pointer to indicate how many bytes w=
ere
> + *    @pages_sent : User-specificed pointer to indicate how many pages w=
ere
>   *                  sent. Usually, this will not be more than a few byte=
s of
>   *                  the protocol because most transfers are sent asynchr=
onously.
>   */

There is new doc to pages_sent but the parameter is not added to the signat=
ure
bellow. Am I missing something?

> -static size_t qemu_rdma_save_page(QEMUFile *f,
> -                                  ram_addr_t block_offset, ram_addr_t of=
fset,
> -                                  size_t size, uint64_t *bytes_sent)
> +static int qemu_rdma_save_page(QEMUFile *f, ram_addr_t block_offset,
> +                               ram_addr_t offset, size_t size)
>  {
>      QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
>      RDMAContext *rdma;
> @@ -3277,18 +3276,6 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
>          goto err;
>      }
> =20
> -    /*
> -     * We always return 1 bytes because the RDMA
> -     * protocol is completely asynchronous. We do not yet know
> -     * whether an  identified chunk is zero or not because we're
> -     * waiting for other pages to potentially be merged with
> -     * the current chunk. So, we have to call qemu_update_position()
> -     * later on when the actual write occurs.
> -     */
> -    if (bytes_sent) {
> -        *bytes_sent =3D 1;
> -    }
> -
>      /*
>       * Drain the Completion Queue if possible, but do not block,
>       * just poll.

Oh, so this one complements 13/16.=20
Since it doesn't do imaginary transfers anymore, there is no need to use
bytes_sent pointer to keep track of them anymore.

Other than the pages_sent above that I couldn't understand:
Reviewed-by: Leonardo Bras <leobras@redhat.com>

 =20


