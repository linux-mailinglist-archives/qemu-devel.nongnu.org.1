Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7638675B652
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 20:14:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMYAG-0003Q6-Rl; Thu, 20 Jul 2023 14:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMYAE-0003Pt-Hw
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:14:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMYAC-0002wd-PV
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 14:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689876847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GEvi5LKU0SCztgSpVz/YKRB1eub/V7VKVB0/m9H4g7c=;
 b=cJJJnNx7e6DdDPmuI2ZJfRSuCaDdMgsbFFgR+fpjeMiIeCE0Qy9zkrar0A8+Io75XBDAgt
 mpXbOYeTQpI4sR4BMN3HNlRqC2dNPSwNrL3duKeeKGpvLwRn7YSFeSTw5uaJPWdUXI8Txp
 nLDDbebPOsylaE8T16maMb8xaa7yGes=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-_fOrKQ6hNEilG9yCxjkDhw-1; Thu, 20 Jul 2023 14:14:05 -0400
X-MC-Unique: _fOrKQ6hNEilG9yCxjkDhw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF6D538025ED;
 Thu, 20 Jul 2023 18:14:04 +0000 (UTC)
Received: from localhost (unknown [10.39.194.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B507C57969;
 Thu, 20 Jul 2023 18:14:03 +0000 (UTC)
Date: Thu, 20 Jul 2023 14:14:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: qemu-devel@nongnu.org, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, john.levon@nutanix.com
Subject: Re: [PATCH 2/3] softmmu: Remove DMA unmap notification callback
Message-ID: <20230720181402.GB210977@fedora>
References: <20230704080628.852525-1-mnissler@rivosinc.com>
 <20230704080628.852525-3-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JPUoOL+XzAQtX/0V"
Content-Disposition: inline
In-Reply-To: <20230704080628.852525-3-mnissler@rivosinc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--JPUoOL+XzAQtX/0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 01:06:26AM -0700, Mattias Nissler wrote:
> According to old commit messages, this was introduced to retry a DMA
> operation at a later point in case the single bounce buffer is found to
> be busy. This was never used widely - only the dma-helpers code made use
> of it, but there are other device models that use multiple DMA mappings
> (concurrently) and just failed.
>=20
> After the improvement to support multiple concurrent bounce buffers,
> the condition the notification callback allowed to work around no
> longer exists, so we can just remove the logic and simplify the code.
>=20
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> ---
>  softmmu/dma-helpers.c | 28 -----------------
>  softmmu/physmem.c     | 71 -------------------------------------------
>  2 files changed, 99 deletions(-)

I'm not sure if it will be possible to remove this once a limit is
placed bounce buffer space.

>=20
> diff --git a/softmmu/dma-helpers.c b/softmmu/dma-helpers.c
> index 2463964805..d05d226f11 100644
> --- a/softmmu/dma-helpers.c
> +++ b/softmmu/dma-helpers.c
> @@ -68,23 +68,10 @@ typedef struct {
>      int sg_cur_index;
>      dma_addr_t sg_cur_byte;
>      QEMUIOVector iov;
> -    QEMUBH *bh;
>      DMAIOFunc *io_func;
>      void *io_func_opaque;
>  } DMAAIOCB;
> =20
> -static void dma_blk_cb(void *opaque, int ret);
> -
> -static void reschedule_dma(void *opaque)
> -{
> -    DMAAIOCB *dbs =3D (DMAAIOCB *)opaque;
> -
> -    assert(!dbs->acb && dbs->bh);
> -    qemu_bh_delete(dbs->bh);
> -    dbs->bh =3D NULL;
> -    dma_blk_cb(dbs, 0);
> -}
> -
>  static void dma_blk_unmap(DMAAIOCB *dbs)
>  {
>      int i;
> @@ -101,7 +88,6 @@ static void dma_complete(DMAAIOCB *dbs, int ret)
>  {
>      trace_dma_complete(dbs, ret, dbs->common.cb);
> =20
> -    assert(!dbs->acb && !dbs->bh);
>      dma_blk_unmap(dbs);
>      if (dbs->common.cb) {
>          dbs->common.cb(dbs->common.opaque, ret);
> @@ -164,13 +150,6 @@ static void dma_blk_cb(void *opaque, int ret)
>          }
>      }
> =20
> -    if (dbs->iov.size =3D=3D 0) {
> -        trace_dma_map_wait(dbs);
> -        dbs->bh =3D aio_bh_new(ctx, reschedule_dma, dbs);
> -        cpu_register_map_client(dbs->bh);
> -        goto out;
> -    }
> -
>      if (!QEMU_IS_ALIGNED(dbs->iov.size, dbs->align)) {
>          qemu_iovec_discard_back(&dbs->iov,
>                                  QEMU_ALIGN_DOWN(dbs->iov.size, dbs->alig=
n));
> @@ -189,18 +168,12 @@ static void dma_aio_cancel(BlockAIOCB *acb)
> =20
>      trace_dma_aio_cancel(dbs);
> =20
> -    assert(!(dbs->acb && dbs->bh));
>      if (dbs->acb) {
>          /* This will invoke dma_blk_cb.  */
>          blk_aio_cancel_async(dbs->acb);
>          return;
>      }
> =20
> -    if (dbs->bh) {
> -        cpu_unregister_map_client(dbs->bh);
> -        qemu_bh_delete(dbs->bh);
> -        dbs->bh =3D NULL;
> -    }
>      if (dbs->common.cb) {
>          dbs->common.cb(dbs->common.opaque, -ECANCELED);
>      }
> @@ -239,7 +212,6 @@ BlockAIOCB *dma_blk_io(AioContext *ctx,
>      dbs->dir =3D dir;
>      dbs->io_func =3D io_func;
>      dbs->io_func_opaque =3D io_func_opaque;
> -    dbs->bh =3D NULL;
>      qemu_iovec_init(&dbs->iov, sg->nsg);
>      dma_blk_cb(dbs, 0);
>      return &dbs->common;
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 56130b5a1d..2b4123c127 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -2908,49 +2908,6 @@ typedef struct {
>      uint8_t buffer[];
>  } BounceBuffer;
> =20
> -static size_t bounce_buffers_in_use;
> -
> -typedef struct MapClient {
> -    QEMUBH *bh;
> -    QLIST_ENTRY(MapClient) link;
> -} MapClient;
> -
> -QemuMutex map_client_list_lock;
> -static QLIST_HEAD(, MapClient) map_client_list
> -    =3D QLIST_HEAD_INITIALIZER(map_client_list);
> -
> -static void cpu_unregister_map_client_do(MapClient *client)
> -{
> -    QLIST_REMOVE(client, link);
> -    g_free(client);
> -}
> -
> -static void cpu_notify_map_clients_locked(void)
> -{
> -    MapClient *client;
> -
> -    while (!QLIST_EMPTY(&map_client_list)) {
> -        client =3D QLIST_FIRST(&map_client_list);
> -        qemu_bh_schedule(client->bh);
> -        cpu_unregister_map_client_do(client);
> -    }
> -}
> -
> -void cpu_register_map_client(QEMUBH *bh)
> -{
> -    MapClient *client =3D g_malloc(sizeof(*client));
> -
> -    qemu_mutex_lock(&map_client_list_lock);
> -    client->bh =3D bh;
> -    QLIST_INSERT_HEAD(&map_client_list, client, link);
> -    /* Write map_client_list before reading in_use.  */
> -    smp_mb();
> -    if (qatomic_read(&bounce_buffers_in_use)) {
> -        cpu_notify_map_clients_locked();
> -    }
> -    qemu_mutex_unlock(&map_client_list_lock);
> -}
> -
>  void cpu_exec_init_all(void)
>  {
>      qemu_mutex_init(&ram_list.mutex);
> @@ -2964,28 +2921,6 @@ void cpu_exec_init_all(void)
>      finalize_target_page_bits();
>      io_mem_init();
>      memory_map_init();
> -    qemu_mutex_init(&map_client_list_lock);
> -}
> -
> -void cpu_unregister_map_client(QEMUBH *bh)
> -{
> -    MapClient *client;
> -
> -    qemu_mutex_lock(&map_client_list_lock);
> -    QLIST_FOREACH(client, &map_client_list, link) {
> -        if (client->bh =3D=3D bh) {
> -            cpu_unregister_map_client_do(client);
> -            break;
> -        }
> -    }
> -    qemu_mutex_unlock(&map_client_list_lock);
> -}
> -
> -static void cpu_notify_map_clients(void)
> -{
> -    qemu_mutex_lock(&map_client_list_lock);
> -    cpu_notify_map_clients_locked();
> -    qemu_mutex_unlock(&map_client_list_lock);
>  }
> =20
>  static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
> @@ -3077,8 +3012,6 @@ void *address_space_map(AddressSpace *as,
>      memory_region_ref(mr);
> =20
>      if (!memory_access_is_direct(mr, is_write)) {
> -        qatomic_inc_fetch(&bounce_buffers_in_use);
> -
>          BounceBuffer *bounce =3D g_malloc(l + sizeof(BounceBuffer));
>          bounce->addr =3D addr;
>          bounce->mr =3D mr;
> @@ -3122,10 +3055,6 @@ void address_space_unmap(AddressSpace *as, void *b=
uffer, hwaddr len,
>          }
>          memory_region_unref(bounce->mr);
>          g_free(bounce);
> -
> -        if (qatomic_dec_fetch(&bounce_buffers_in_use) =3D=3D 1) {
> -            cpu_notify_map_clients();
> -        }
>          return;
>      }
> =20
> --=20
> 2.34.1
>=20

--JPUoOL+XzAQtX/0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS5eWoACgkQnKSrs4Gr
c8ic9wf+Lel0LrytqEUMc0u/6f/iVGSA08WePGAjyziDdvucICnrhmlQ9J0Wg5yx
VS8NQa3rK0O4rRHUcksJ2k1BBVDmrYlKTMAzNxml9Qa+zTnyxaZzfCLtP7Rw9vFq
O55kgXfYKmzRv0HJlioNAdRWbBYBh2AbnAp7/usjeLtdtEh5imYevAVoFnPjKQNl
cvVuSetQCNeqZHK+GHxeiyInKgpTimPdVok3jjGt2K4xQJzv6b/SD+sSJ2q+PHep
9yoi1c+DdXTFjQD2vP3tUtySGtqlxsfr1mceo5F7pJrtgtM5o89v1LKHqfI6fH+q
/r5MaO8MtXQh/9TwKfnFb7ugpfFsOQ==
=Hyj7
-----END PGP SIGNATURE-----

--JPUoOL+XzAQtX/0V--


