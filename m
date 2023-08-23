Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A97F7853EC
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 11:29:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYkA5-0003S8-85; Wed, 23 Aug 2023 05:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qYkA2-0003Rq-98
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:28:23 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qYk9z-0006Up-Qt
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:28:21 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1c4c6717e61so3946842fac.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 02:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692782898; x=1693387698; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvu9A/A2NjGyJyii7eWAhAkB7X/TTBQG+o8MzYu9Bes=;
 b=GK54xKhm1CWuK7CYCGnPTKDbw8OZbOS3p2RDSldc8d/r+0WIsSXNNIF9GplbhbbCcm
 8WJqcadQXG9Mo2h6nR2Q+2U3eFiwuPnd/hZ2oLxEZ+BNDGX0sl5e9RVLjlebQxgZWYNc
 x6vofdYigN4QswbLFzSliCdJTrKHgakbuPvRdCvxDB2IDZA/oLbcvpJ4bniHpPcTGUPA
 o+kbEhv0N6MzuNFpTSvwa0GXOYlAzfr7RGX+0d3gcFdSXlWXOoYUkGHkluWWj+OkuTHm
 RSOBuaX+Dtyvog4tJ1Cx1Fm9EHkAhI06ts8w9CsDEAAk1FMj1xKcGDNGnaC0wTLIvtuj
 VVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692782898; x=1693387698;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pvu9A/A2NjGyJyii7eWAhAkB7X/TTBQG+o8MzYu9Bes=;
 b=IZ7abfqc+UFPBibsJ9wMcJBKHFGfyqFrtKpY7vIeDuVc0WRIxQi5By9wlS3wTBeHX/
 oumqFeksKcD/JGPy4AxrSHsrKwO37BVtqPML5ANtmU1NQq5sWe1NwxfWRy+54FTofnnr
 E1ZYIFJxFm32saBNcSUH+/AAw4LasuBvtGWU/l5F+d3/PIINjZAmYm9EEmKsy52G6C4+
 8xxHptE4dfPKZUfapWIFW8IjQp6dD5cwsPGajKgSRntQpapQ2SfHgsnl5yqtTEpCPsH/
 TMjrw9wKllnDuEFlWgQdUeDf8O7xJUiqNzikSKrk8T9l8n2saW6A/QyuTXcseD+4G6KX
 6lSg==
X-Gm-Message-State: AOJu0Yy9kDFBrXR7kUzKjybEMjdFz4rhaCCfCostFzJLYH01LYF9Valq
 Mdd7OfRid5MAyjkQ8WKs2b7HtCp17swvfb2l7t4PyQ==
X-Google-Smtp-Source: AGHT+IFjtpvo41rk3pVYw5/wVF9UbsLy9jpiXQRvNyAIyoRKNUs4XBt8JSC2/Z4eMgB6kFUzHHfZ9A6h2DH5epkfvdE=
X-Received: by 2002:a05:6870:4692:b0:1bb:933b:e6da with SMTP id
 a18-20020a056870469200b001bb933be6damr17067004oap.27.1692782898011; Wed, 23
 Aug 2023 02:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230704080628.852525-1-mnissler@rivosinc.com>
 <20230704080628.852525-3-mnissler@rivosinc.com>
 <20230720181402.GB210977@fedora>
In-Reply-To: <20230720181402.GB210977@fedora>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Wed, 23 Aug 2023 11:28:07 +0200
Message-ID: <CAGNS4TZMmyV1rpFCjp1YVBD7_KrEYUQcGwgVeyi-HmJusOMzxQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] softmmu: Remove DMA unmap notification callback
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, john.levon@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=mnissler@rivosinc.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 20, 2023 at 8:14=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Tue, Jul 04, 2023 at 01:06:26AM -0700, Mattias Nissler wrote:
> > According to old commit messages, this was introduced to retry a DMA
> > operation at a later point in case the single bounce buffer is found to
> > be busy. This was never used widely - only the dma-helpers code made us=
e
> > of it, but there are other device models that use multiple DMA mappings
> > (concurrently) and just failed.
> >
> > After the improvement to support multiple concurrent bounce buffers,
> > the condition the notification callback allowed to work around no
> > longer exists, so we can just remove the logic and simplify the code.
> >
> > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > ---
> >  softmmu/dma-helpers.c | 28 -----------------
> >  softmmu/physmem.c     | 71 -------------------------------------------
> >  2 files changed, 99 deletions(-)
>
> I'm not sure if it will be possible to remove this once a limit is
> placed bounce buffer space.

I investigated this in detail and concluded that you're right
unfortunately. In particular, after I found that Linux likes to use
megabyte-sided DMA buffers with xhci-attached USB storage, I don't
think it's realistic to set a reasonable fixed limit that accommodates
most workloads in practice.






>
> >
> > diff --git a/softmmu/dma-helpers.c b/softmmu/dma-helpers.c
> > index 2463964805..d05d226f11 100644
> > --- a/softmmu/dma-helpers.c
> > +++ b/softmmu/dma-helpers.c
> > @@ -68,23 +68,10 @@ typedef struct {
> >      int sg_cur_index;
> >      dma_addr_t sg_cur_byte;
> >      QEMUIOVector iov;
> > -    QEMUBH *bh;
> >      DMAIOFunc *io_func;
> >      void *io_func_opaque;
> >  } DMAAIOCB;
> >
> > -static void dma_blk_cb(void *opaque, int ret);
> > -
> > -static void reschedule_dma(void *opaque)
> > -{
> > -    DMAAIOCB *dbs =3D (DMAAIOCB *)opaque;
> > -
> > -    assert(!dbs->acb && dbs->bh);
> > -    qemu_bh_delete(dbs->bh);
> > -    dbs->bh =3D NULL;
> > -    dma_blk_cb(dbs, 0);
> > -}
> > -
> >  static void dma_blk_unmap(DMAAIOCB *dbs)
> >  {
> >      int i;
> > @@ -101,7 +88,6 @@ static void dma_complete(DMAAIOCB *dbs, int ret)
> >  {
> >      trace_dma_complete(dbs, ret, dbs->common.cb);
> >
> > -    assert(!dbs->acb && !dbs->bh);
> >      dma_blk_unmap(dbs);
> >      if (dbs->common.cb) {
> >          dbs->common.cb(dbs->common.opaque, ret);
> > @@ -164,13 +150,6 @@ static void dma_blk_cb(void *opaque, int ret)
> >          }
> >      }
> >
> > -    if (dbs->iov.size =3D=3D 0) {
> > -        trace_dma_map_wait(dbs);
> > -        dbs->bh =3D aio_bh_new(ctx, reschedule_dma, dbs);
> > -        cpu_register_map_client(dbs->bh);
> > -        goto out;
> > -    }
> > -
> >      if (!QEMU_IS_ALIGNED(dbs->iov.size, dbs->align)) {
> >          qemu_iovec_discard_back(&dbs->iov,
> >                                  QEMU_ALIGN_DOWN(dbs->iov.size, dbs->al=
ign));
> > @@ -189,18 +168,12 @@ static void dma_aio_cancel(BlockAIOCB *acb)
> >
> >      trace_dma_aio_cancel(dbs);
> >
> > -    assert(!(dbs->acb && dbs->bh));
> >      if (dbs->acb) {
> >          /* This will invoke dma_blk_cb.  */
> >          blk_aio_cancel_async(dbs->acb);
> >          return;
> >      }
> >
> > -    if (dbs->bh) {
> > -        cpu_unregister_map_client(dbs->bh);
> > -        qemu_bh_delete(dbs->bh);
> > -        dbs->bh =3D NULL;
> > -    }
> >      if (dbs->common.cb) {
> >          dbs->common.cb(dbs->common.opaque, -ECANCELED);
> >      }
> > @@ -239,7 +212,6 @@ BlockAIOCB *dma_blk_io(AioContext *ctx,
> >      dbs->dir =3D dir;
> >      dbs->io_func =3D io_func;
> >      dbs->io_func_opaque =3D io_func_opaque;
> > -    dbs->bh =3D NULL;
> >      qemu_iovec_init(&dbs->iov, sg->nsg);
> >      dma_blk_cb(dbs, 0);
> >      return &dbs->common;
> > diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> > index 56130b5a1d..2b4123c127 100644
> > --- a/softmmu/physmem.c
> > +++ b/softmmu/physmem.c
> > @@ -2908,49 +2908,6 @@ typedef struct {
> >      uint8_t buffer[];
> >  } BounceBuffer;
> >
> > -static size_t bounce_buffers_in_use;
> > -
> > -typedef struct MapClient {
> > -    QEMUBH *bh;
> > -    QLIST_ENTRY(MapClient) link;
> > -} MapClient;
> > -
> > -QemuMutex map_client_list_lock;
> > -static QLIST_HEAD(, MapClient) map_client_list
> > -    =3D QLIST_HEAD_INITIALIZER(map_client_list);
> > -
> > -static void cpu_unregister_map_client_do(MapClient *client)
> > -{
> > -    QLIST_REMOVE(client, link);
> > -    g_free(client);
> > -}
> > -
> > -static void cpu_notify_map_clients_locked(void)
> > -{
> > -    MapClient *client;
> > -
> > -    while (!QLIST_EMPTY(&map_client_list)) {
> > -        client =3D QLIST_FIRST(&map_client_list);
> > -        qemu_bh_schedule(client->bh);
> > -        cpu_unregister_map_client_do(client);
> > -    }
> > -}
> > -
> > -void cpu_register_map_client(QEMUBH *bh)
> > -{
> > -    MapClient *client =3D g_malloc(sizeof(*client));
> > -
> > -    qemu_mutex_lock(&map_client_list_lock);
> > -    client->bh =3D bh;
> > -    QLIST_INSERT_HEAD(&map_client_list, client, link);
> > -    /* Write map_client_list before reading in_use.  */
> > -    smp_mb();
> > -    if (qatomic_read(&bounce_buffers_in_use)) {
> > -        cpu_notify_map_clients_locked();
> > -    }
> > -    qemu_mutex_unlock(&map_client_list_lock);
> > -}
> > -
> >  void cpu_exec_init_all(void)
> >  {
> >      qemu_mutex_init(&ram_list.mutex);
> > @@ -2964,28 +2921,6 @@ void cpu_exec_init_all(void)
> >      finalize_target_page_bits();
> >      io_mem_init();
> >      memory_map_init();
> > -    qemu_mutex_init(&map_client_list_lock);
> > -}
> > -
> > -void cpu_unregister_map_client(QEMUBH *bh)
> > -{
> > -    MapClient *client;
> > -
> > -    qemu_mutex_lock(&map_client_list_lock);
> > -    QLIST_FOREACH(client, &map_client_list, link) {
> > -        if (client->bh =3D=3D bh) {
> > -            cpu_unregister_map_client_do(client);
> > -            break;
> > -        }
> > -    }
> > -    qemu_mutex_unlock(&map_client_list_lock);
> > -}
> > -
> > -static void cpu_notify_map_clients(void)
> > -{
> > -    qemu_mutex_lock(&map_client_list_lock);
> > -    cpu_notify_map_clients_locked();
> > -    qemu_mutex_unlock(&map_client_list_lock);
> >  }
> >
> >  static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr le=
n,
> > @@ -3077,8 +3012,6 @@ void *address_space_map(AddressSpace *as,
> >      memory_region_ref(mr);
> >
> >      if (!memory_access_is_direct(mr, is_write)) {
> > -        qatomic_inc_fetch(&bounce_buffers_in_use);
> > -
> >          BounceBuffer *bounce =3D g_malloc(l + sizeof(BounceBuffer));
> >          bounce->addr =3D addr;
> >          bounce->mr =3D mr;
> > @@ -3122,10 +3055,6 @@ void address_space_unmap(AddressSpace *as, void =
*buffer, hwaddr len,
> >          }
> >          memory_region_unref(bounce->mr);
> >          g_free(bounce);
> > -
> > -        if (qatomic_dec_fetch(&bounce_buffers_in_use) =3D=3D 1) {
> > -            cpu_notify_map_clients();
> > -        }
> >          return;
> >      }
> >
> > --
> > 2.34.1
> >

