Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC0FA6549D
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Mar 2025 15:58:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBuY-0005he-KF; Mon, 17 Mar 2025 10:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tuBuJ-0005Rs-1O
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tuBuG-0006km-Bs
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742223449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/nD93kytmUtclb8CtECsJyy15Tldpz7/R9y6QM7Tpdk=;
 b=JlCJgVPeFe1mfu39/QzAaw4UtexxIHCrYwJSZy0+T2dELc7rAGUd46N41DEFzxLTlfoHGc
 UHKCc2ovRpZ2ZqhcqAG7+aVXa9jZxvP2+tCTV8ye215CyT10ssvw8H4iQPhbvVygdFs7h9
 r9xrdA2J/ykoRIbx2Bb0KNed/enVKRU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-xcSaigh4PLCbz4hknYWMsQ-1; Mon,
 17 Mar 2025 10:57:26 -0400
X-MC-Unique: xcSaigh4PLCbz4hknYWMsQ-1
X-Mimecast-MFC-AGG-ID: xcSaigh4PLCbz4hknYWMsQ_1742223443
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 242291800875; Mon, 17 Mar 2025 14:57:22 +0000 (UTC)
Received: from localhost (unknown [10.2.16.82])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94E4A30001A2; Mon, 17 Mar 2025 14:57:19 +0000 (UTC)
Date: Mon, 17 Mar 2025 10:57:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: zoudongjie <zoudongjie@huawei.com>
Cc: fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, zhuyangyang14@huawei.com,
 luolongmin@huawei.com, suxiaodong1@huawei.com,
 wangyan122@huawei.com, yebiaoxiang@huawei.com,
 wangjian161@huawei.com, mujinsheng@huawei.com, alex.chen@huawei.com,
 eric.fangyi@huawei.com, chenjianfei3@huawei.com, renxuming@huawei.com
Subject: Re: [PATCH 1/2] io/block: Refactoring the bdrv_drained_begin()
 function and implement a timeout mechanism.
Message-ID: <20250317145718.GA1214048@fedora>
References: <20250313040945.GB1074020@fedora>
 <20250317121828.4069621-1-zoudongjie@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ThUvEGk/WdWkNDgA"
Content-Disposition: inline
In-Reply-To: <20250317121828.4069621-1-zoudongjie@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--ThUvEGk/WdWkNDgA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 08:18:28PM +0800, zoudongjie wrote:
> On Thu, 13 Mar, 2025 at 12:09:45 +0800, Stefan Hajnoczi wrote:
> > On Sat, Mar 08, 2025 at 06:16:17PM +0800, zoudongjie wrote:
> > > @@ -342,16 +350,25 @@ static void coroutine_fn bdrv_co_yield_to_drain=
(BlockDriverState *bs,
> > >      /* If we are resumed from some other event (such as an aio compl=
etion or a
> > >       * timer callback), it is a bug in the caller that should be fix=
ed. */
> > >      assert(data.done);
> > > +    return data.ret;
> > >  }
> > > =20
> > > -static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *p=
arent,
> > > -                                  bool poll)
> > > +static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
> > > +                                                bool begin,
> > > +                                                BdrvChild *parent,
> > > +                                                bool poll)
> > > +{
> > > +    bdrv_co_yield_to_drain_timeout(bs, begin, parent, poll, -1);
> >=20
> > Is this safe on 32-bit platforms?
>=20
> I'm sorry, can it be more specific here, I didn't get it.

I was thinking about -1 vs -1ull integer literals, but it's not a
problem for int64_t so everything is fine here.

Stefan

--ThUvEGk/WdWkNDgA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfYOE4ACgkQnKSrs4Gr
c8gnBwf+Lckp9wEyI9rRx2FaLlCKiwoxXy39NHWWYsIAVJ990vHDK7lAzjLp2jw4
iWjgzti2vlNwTpAaOhiQfrxPkTGiM8u2gW3RH8npS60Wvp2v20+LJdZ9xii6xuRn
+m3iTXlp0+QCVzibB3Rnp/oPrH9HMm3Cs/iGVo6JEaKjTyWgAhGnVht54LAYIAHf
3UcyWhHfetbDZ/8BQ3l7tuLWFyrXc0sy795WjGCpWisSOQ4m/Ocp4tFfo7n+TVZZ
SuvvGHc3tWxvwQ+A+NzLtsHS8gF1NhB/fxmslu1LbNcxhlFEwLFmPtKL2sQsus9R
qUJ8d1nMVrlKdyUcBVmAZg8Qu7gaqQ==
=JIjD
-----END PGP SIGNATURE-----

--ThUvEGk/WdWkNDgA--


