Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B8570E0DF
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:48:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UEd-0006DL-Lq; Tue, 23 May 2023 11:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1UEa-0006Cj-N6
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:47:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1UEZ-00062B-3H
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684856854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O3B1/QDqYYFNADsiJ/SScpfUTui+YFuZRwwUutZa9ls=;
 b=JC5iSqQqSfGDA3tCOnElJxCZwsSup3fw8N1jc+IPMwY4HZLt2vUXSJtwK6qFprxXa/Bz1K
 U/xtJW2LO7VbM+wLOKqcAnWdcqLB2iuOZ8Z86qXwgg1+k1HPjFzTaUuLA20pl51mv0kw9i
 RHMoxNGId7tzVU0N2ckA5E6se1fSrmc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-oNyRN5KSNaOub17gdHHNcw-1; Tue, 23 May 2023 11:47:30 -0400
X-MC-Unique: oNyRN5KSNaOub17gdHHNcw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11057858F1B;
 Tue, 23 May 2023 15:47:30 +0000 (UTC)
Received: from localhost (unknown [10.39.195.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84A3F492B0A;
 Tue, 23 May 2023 15:47:29 +0000 (UTC)
Date: Tue, 23 May 2023 11:47:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org,
 Julia Suvorova <jusual@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Anthony Perard <anthony.perard@citrix.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 2/6] block/nvme: convert to blk_io_plug_call() API
Message-ID: <20230523154727.GC96478@fedora>
References: <20230517221022.325091-1-stefanha@redhat.com>
 <20230517221022.325091-3-stefanha@redhat.com>
 <utuievutol5cux2axpym7x3t4tueresl4tbqadizc36f5yblpi@ndpva7u6croa>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SagQeXz/GIVguVBW"
Content-Disposition: inline
In-Reply-To: <utuievutol5cux2axpym7x3t4tueresl4tbqadizc36f5yblpi@ndpva7u6croa>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--SagQeXz/GIVguVBW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 10:46:25AM +0200, Stefano Garzarella wrote:
> On Wed, May 17, 2023 at 06:10:18PM -0400, Stefan Hajnoczi wrote:
> > Stop using the .bdrv_co_io_plug() API because it is not multi-queue
> > block layer friendly. Use the new blk_io_plug_call() API to batch I/O
> > submission instead.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > block/nvme.c | 44 ++++++++++++--------------------------------
> > 1 file changed, 12 insertions(+), 32 deletions(-)
> >=20
> > diff --git a/block/nvme.c b/block/nvme.c
> > index 5b744c2bda..100b38b592 100644
> > --- a/block/nvme.c
> > +++ b/block/nvme.c
> > @@ -25,6 +25,7 @@
> > #include "qemu/vfio-helpers.h"
> > #include "block/block-io.h"
> > #include "block/block_int.h"
> > +#include "sysemu/block-backend.h"
> > #include "sysemu/replay.h"
> > #include "trace.h"
> >=20
> > @@ -119,7 +120,6 @@ struct BDRVNVMeState {
> >     int blkshift;
> >=20
> >     uint64_t max_transfer;
> > -    bool plugged;
> >=20
> >     bool supports_write_zeroes;
> >     bool supports_discard;
> > @@ -282,7 +282,7 @@ static void nvme_kick(NVMeQueuePair *q)
> > {
> >     BDRVNVMeState *s =3D q->s;
> >=20
> > -    if (s->plugged || !q->need_kick) {
> > +    if (!q->need_kick) {
> >         return;
> >     }
> >     trace_nvme_kick(s, q->index);
> > @@ -387,10 +387,6 @@ static bool nvme_process_completion(NVMeQueuePair =
*q)
> >     NvmeCqe *c;
> >=20
> >     trace_nvme_process_completion(s, q->index, q->inflight);
> > -    if (s->plugged) {
> > -        trace_nvme_process_completion_queue_plugged(s, q->index);
>=20
> Should we remove "nvme_process_completion_queue_plugged(void *s,
> unsigned q_index) "s %p q #%u" from block/trace-events?

Will fix, thanks!

Stefan

--SagQeXz/GIVguVBW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRs4A8ACgkQnKSrs4Gr
c8jRLggAnHAGUNyvJQIwz9Dtrtu8UXLxyZdpgSQS/HH5rqZy6JfdddIMYu/fw4JF
3AGDfNBXW+1wq1ox5p45zwVw+Az+NX+m46LDuBjCuEj7dtS7K8ASVrS5UMV1hWQ7
Hb54eovBy/L+nSQBtSX4ILFdyhA+aOIaMC/OFyClMz1/yzNmnUWyupjr/B8jf3Xf
/vGlY2CP3WjoTrYvIDxhZ7JhIStLB3r4VfVIiIMhD3JKkSjxCOjqAiQwPJtFDMQ2
2JI2bZtYLzfxJpq6y1grntDAzDLg3wCYybtPUxMbb45vvR+udLDfN5fcMDkX5vLs
9pChlshANBJlHUF5rzPmx4ROD1Kccw==
=S5t/
-----END PGP SIGNATURE-----

--SagQeXz/GIVguVBW--


