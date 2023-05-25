Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA02710637
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 09:23:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q25Ih-0006oP-M0; Thu, 25 May 2023 03:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q25Ia-0006oH-5E
 for qemu-devel@nongnu.org; Thu, 25 May 2023 03:22:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q25IX-0007Nu-NI
 for qemu-devel@nongnu.org; Thu, 25 May 2023 03:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684999328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81Al3yDHIhj5fScrpyoeN4C3gJ57YPWwoTLgzy+qLY4=;
 b=Ymz5m5TrnR5awUQl+HbqseF2ZZ9QyEfiR62l8Bx7fassHkGA03gwBHnjJlUPtQ4fQQwm9S
 hLtcAkEgoNp40HRhVXvsXsQk7dO+jDt7QvHGwKCSkYCwYKjVu2heS/hr3LbBaPsTo/PRXm
 3uI3Mohwh1WzGvlc1674Bo5JaA9YL+w=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-R70P2SV3MHG6Tth97MRDcg-1; Thu, 25 May 2023 03:22:07 -0400
X-MC-Unique: R70P2SV3MHG6Tth97MRDcg-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-397f99331a2so1319026b6e.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 00:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684999326; x=1687591326;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=81Al3yDHIhj5fScrpyoeN4C3gJ57YPWwoTLgzy+qLY4=;
 b=RMi/SLdHZ4/t2tfGsCN5Kl4Lzp79ubankAVe6sk1OEPFBmvdv2GgXKcR8/kndTDLVk
 ZVXv/7dekQTts265o+6jX06tcXQXeTdaX2IkxMfKYDzkGbZcrO3QB6lKcv51p3gBrJBC
 7RxYIJoe8WfkUs0kDzWdFt4yMXJju06mPy4KhFi2oUsJe4bpM3vb+g0JYhbFu47fjLFi
 HSdqFTV0zy0rz0qK7lcIQmzrhjV6hwVUaNmn5eDwiwrsGfwllD9N2aY5NUTrfUgfV8Y1
 dYXrXrop7THnRvi7WhTVI4cSYQk/TWsUAMj6/oi8UKpbUcY4eAjvKxtCnqc1gLSaSr8v
 BIiQ==
X-Gm-Message-State: AC+VfDwOeJ9C4Z0NmIV3a0mBIeFDtdSJFiGNA6Vfw48fOZMcjr7+RVgx
 Wc0WY7kRvLoyPUnCTal27+q17wRPmqivqsMhQx+92W9RkpfGR6lATA90EGlA+UqTxbtZmxoYXnd
 U1evZdj7hnmsFZ4w=
X-Received: by 2002:a05:6808:9b8:b0:398:27d3:1fc3 with SMTP id
 e24-20020a05680809b800b0039827d31fc3mr4644337oig.42.1684999326263; 
 Thu, 25 May 2023 00:22:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5qss/MFS8a1RvlFSqw6tak16yAPhyC852LLhp8iGUApmwbLwPYhaAIibFbjBEctNqLfGLy/A==
X-Received: by 2002:a05:6808:9b8:b0:398:27d3:1fc3 with SMTP id
 e24-20020a05680809b800b0039827d31fc3mr4644310oig.42.1684999325961; 
 Thu, 25 May 2023 00:22:05 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:7f0c:32e1:e970:713a:f05b?
 ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
 by smtp.gmail.com with ESMTPSA id
 s124-20020acac282000000b00383d9700294sm234727oif.40.2023.05.25.00.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 00:22:05 -0700 (PDT)
Message-ID: <70c0b11c522630ec6a7fb7c1e6efdce32667db49.camel@redhat.com>
Subject: Re: [PATCH v2 12/16] migration/rdma: Remove QEMUFile parameter when
 not used
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
Date: Thu, 25 May 2023 04:21:59 -0300
In-Reply-To: <20230515195709.63843-13-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-13-quintela@redhat.com>
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/rdma.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>=20
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 074456f9df..416dec00a2 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2027,7 +2027,7 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdm=
a, RDMAControlHeader *head,
>   * If we're using dynamic registration on the dest-side, we have to
>   * send a registration command first.
>   */
> -static int qemu_rdma_write_one(QEMUFile *f, RDMAContext *rdma,
> +static int qemu_rdma_write_one(RDMAContext *rdma,
>                                 int current_index, uint64_t current_addr,
>                                 uint64_t length)
>  {
> @@ -2263,7 +2263,7 @@ retry:
>   * We support sending out multiple chunks at the same time.
>   * Not all of them need to get signaled in the completion queue.
>   */
> -static int qemu_rdma_write_flush(QEMUFile *f, RDMAContext *rdma)
> +static int qemu_rdma_write_flush(RDMAContext *rdma)
>  {
>      int ret;
> =20
> @@ -2271,7 +2271,7 @@ static int qemu_rdma_write_flush(QEMUFile *f, RDMAC=
ontext *rdma)
>          return 0;
>      }
> =20
> -    ret =3D qemu_rdma_write_one(f, rdma,
> +    ret =3D qemu_rdma_write_one(rdma,
>              rdma->current_index, rdma->current_addr, rdma->current_lengt=
h);
> =20
>      if (ret < 0) {
> @@ -2344,7 +2344,7 @@ static inline int qemu_rdma_buffer_mergable(RDMACon=
text *rdma,
>   *    and only require that a batch gets acknowledged in the completion
>   *    queue instead of each individual chunk.
>   */
> -static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
> +static int qemu_rdma_write(RDMAContext *rdma,
>                             uint64_t block_offset, uint64_t offset,
>                             uint64_t len)
>  {
> @@ -2355,7 +2355,7 @@ static int qemu_rdma_write(QEMUFile *f, RDMAContext=
 *rdma,
> =20
>      /* If we cannot merge it, we flush the current buffer first. */
>      if (!qemu_rdma_buffer_mergable(rdma, current_addr, len)) {
> -        ret =3D qemu_rdma_write_flush(f, rdma);
> +        ret =3D qemu_rdma_write_flush(rdma);
>          if (ret) {
>              return ret;
>          }
> @@ -2377,7 +2377,7 @@ static int qemu_rdma_write(QEMUFile *f, RDMAContext=
 *rdma,
> =20
>      /* flush it if buffer is too large */
>      if (rdma->current_length >=3D RDMA_MERGE_MAX) {
> -        return qemu_rdma_write_flush(f, rdma);
> +        return qemu_rdma_write_flush(rdma);
>      }
> =20
>      return 0;
> @@ -2798,7 +2798,6 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *=
ioc,
>                                         Error **errp)
>  {
>      QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
> -    QEMUFile *f =3D rioc->file;
>      RDMAContext *rdma;
>      int ret;
>      ssize_t done =3D 0;
> @@ -2819,7 +2818,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *=
ioc,
>       * Push out any writes that
>       * we're queued up for VM's ram.
>       */
> -    ret =3D qemu_rdma_write_flush(f, rdma);
> +    ret =3D qemu_rdma_write_flush(rdma);
>      if (ret < 0) {
>          rdma->error_state =3D ret;
>          error_setg(errp, "qemu_rdma_write_flush returned %d", ret);
> @@ -2958,11 +2957,11 @@ static ssize_t qio_channel_rdma_readv(QIOChannel =
*ioc,
>  /*
>   * Block until all the outstanding chunks have been delivered by the har=
dware.
>   */
> -static int qemu_rdma_drain_cq(QEMUFile *f, RDMAContext *rdma)
> +static int qemu_rdma_drain_cq(RDMAContext *rdma)
>  {
>      int ret;
> =20
> -    if (qemu_rdma_write_flush(f, rdma) < 0) {
> +    if (qemu_rdma_write_flush(rdma) < 0) {
>          return -EIO;
>      }
> =20
> @@ -3272,7 +3271,7 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
>       * is full, or the page doesn't belong to the current chunk,
>       * an actual RDMA write will occur and a new chunk will be formed.
>       */
> -    ret =3D qemu_rdma_write(f, rdma, block_offset, offset, size);
> +    ret =3D qemu_rdma_write(rdma, block_offset, offset, size);
>      if (ret < 0) {
>          error_report("rdma migration: write error! %d", ret);
>          goto err;
> @@ -3927,7 +3926,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
>      CHECK_ERROR_STATE();
> =20
>      qemu_fflush(f);
> -    ret =3D qemu_rdma_drain_cq(f, rdma);
> +    ret =3D qemu_rdma_drain_cq(rdma);
> =20
>      if (ret < 0) {
>          goto err;

Reviewed-by: Leonardo Bras <leobras@redhat.com>


