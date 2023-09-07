Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C711797C28
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 20:42:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeJvp-0004j4-K9; Thu, 07 Sep 2023 14:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeJvl-0004iQ-KC
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 14:40:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeJvj-0007rM-3n
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 14:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694112037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92Gt3oyCAGq5XNaZddTZwFtuth/OowLhdaJS3qr+b+w=;
 b=T9BUBy5/HD3SFlDtfn3RTcQDMLpEQglcGcAhnP/25wFaTmR5chJsjjH53g1v5mVROnmZ78
 EJC//lz1dlEvc0XK1T0Nc0KymOkAjAHaVgpBktIABn5WpglNpKTG+dr/sd6PTisjSuc+tY
 /efYVV/j8wIdZ1WRphXS40QT1NyRexw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-ZaJypQI7M6aD2DVqy7asTg-1; Thu, 07 Sep 2023 14:40:33 -0400
X-MC-Unique: ZaJypQI7M6aD2DVqy7asTg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 178328164E0;
 Thu,  7 Sep 2023 18:40:33 +0000 (UTC)
Received: from localhost (unknown [10.39.193.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FB121460FE5;
 Thu,  7 Sep 2023 18:40:32 +0000 (UTC)
Date: Thu, 7 Sep 2023 14:40:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, quintela@redhat.com,
 peterx@redhat.com, leobras@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH 2/2] virtio: Drop out of coroutine context in virtio_load()
Message-ID: <20230907184031.GA1560640@fedora>
References: <20230905145002.46391-1-kwolf@redhat.com>
 <20230905145002.46391-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a6JzmCu74YzjTp2p"
Content-Disposition: inline
In-Reply-To: <20230905145002.46391-3-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--a6JzmCu74YzjTp2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 04:50:02PM +0200, Kevin Wolf wrote:
> virtio_load() as a whole should run in coroutine context because it
> reads from the migration stream and we don't want this to block.

Is that "should" a "must" or a "can"?

If it's a "must" then virtio_load() needs assert(qemu_in_coroutine()).

But the previous patch mentioned that loadvm for snapshots calls it
outside coroutine context. So maybe it's a "can"?

>=20
> However, it calls virtio_set_features_nocheck() and devices don't
> expect their .set_features callback to run in a coroutine and therefore
> call functions that may not be called in coroutine context. To fix this,
> drop out of coroutine context for calling virtio_set_features_nocheck().
>=20
> Without this fix, the following crash was reported:
>=20
>   #0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3D=
signo@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
>   #1  0x00007efc738c05d3 in __pthread_kill_internal (signo=3D6, threadid=
=3D<optimized out>) at pthread_kill.c:78
>   #2  0x00007efc73873d26 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdep=
s/posix/raise.c:26
>   #3  0x00007efc738477f3 in __GI_abort () at abort.c:79
>   #4  0x00007efc7384771b in __assert_fail_base (fmt=3D0x7efc739dbcb8 "", =
assertion=3Dassertion@entry=3D0x560aebfbf5cf "!qemu_in_coroutine()",
>      file=3Dfile@entry=3D0x560aebfcd2d4 "../block/graph-lock.c", line=3Dl=
ine@entry=3D275, function=3Dfunction@entry=3D0x560aebfcd34d "void bdrv_grap=
h_rdlock_main_loop(void)") at assert.c:92
>   #5  0x00007efc7386ccc6 in __assert_fail (assertion=3D0x560aebfbf5cf "!q=
emu_in_coroutine()", file=3D0x560aebfcd2d4 "../block/graph-lock.c", line=3D=
275,
>      function=3D0x560aebfcd34d "void bdrv_graph_rdlock_main_loop(void)") =
at assert.c:101
>   #6  0x0000560aebcd8dd6 in bdrv_register_buf ()
>   #7  0x0000560aeb97ed97 in ram_block_added.llvm ()
>   #8  0x0000560aebb8303f in ram_block_add.llvm ()
>   #9  0x0000560aebb834fa in qemu_ram_alloc_internal.llvm ()
>   #10 0x0000560aebb2ac98 in vfio_region_mmap ()
>   #11 0x0000560aebb3ea0f in vfio_bars_register ()
>   #12 0x0000560aebb3c628 in vfio_realize ()
>   #13 0x0000560aeb90f0c2 in pci_qdev_realize ()
>   #14 0x0000560aebc40305 in device_set_realized ()
>   #15 0x0000560aebc48e07 in property_set_bool.llvm ()
>   #16 0x0000560aebc46582 in object_property_set ()
>   #17 0x0000560aebc4cd58 in object_property_set_qobject ()
>   #18 0x0000560aebc46ba7 in object_property_set_bool ()
>   #19 0x0000560aeb98b3ca in qdev_device_add_from_qdict ()
>   #20 0x0000560aebb1fbaf in virtio_net_set_features ()
>   #21 0x0000560aebb46b51 in virtio_set_features_nocheck ()
>   #22 0x0000560aebb47107 in virtio_load ()
>   #23 0x0000560aeb9ae7ce in vmstate_load_state ()
>   #24 0x0000560aeb9d2ee9 in qemu_loadvm_state_main ()
>   #25 0x0000560aeb9d45e1 in qemu_loadvm_state ()
>   #26 0x0000560aeb9bc32c in process_incoming_migration_co.llvm ()
>   #27 0x0000560aebeace56 in coroutine_trampoline.llvm ()
>=20
> Cc: qemu-stable@nongnu.org
> Buglink: https://issues.redhat.com/browse/RHEL-832
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/virtio/virtio.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--a6JzmCu74YzjTp2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT6GR8ACgkQnKSrs4Gr
c8irWwf/TswHvBKkDG2gbo4TmgKqO/AGkkbMBUsetjCvDAz3SNGRxqj5l7I0Er6F
LLUtBMaikbiRxt2G90LnTQ4FHWM7+A/l9wOoDhcSdY0kgotqXuw30kVwWUvJRJZS
TUfUK/PtqJ7ids4TEN856IdvuWrC/wAWRzuAmnKHb2l5L8VuY1I1BALT8qUgHoOp
wD2R17uXYcjSyXpg33Z/TbCKZAnnWTszrd9Ux+BxFJpB4+aA7Z9RCuo6F20MQojq
rmuBhvSCQ+OCd+PfjTR139ZnGO24M725PUwNCVjcX73s8L6AGGAaDVhCgxJtOAKI
D5M2GTeqvIWW4JKz111qj6XpBGh98A==
=NqS6
-----END PGP SIGNATURE-----

--a6JzmCu74YzjTp2p--


