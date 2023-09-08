Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF0079847E
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:01:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeXLT-0001dq-JH; Fri, 08 Sep 2023 05:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeXLK-0001cV-J9
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:59:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeXLH-0005zQ-MR
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694163594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RifBq61NLv9aYy4YU7BYrt9MZc6S6d2bw4J3E/bZFT4=;
 b=TCb5+MP7OAxF24x1rl923N5CoW6Y2yKOgmOTB92dd096+Nrb4uVLOFNnFdqpVoE9GpRF6w
 yCTy2nZl4cvMlCPhh5sf6+TMZf9VFi34o+IiM7VP3JaM7eYkKo4u7nJCDWPl7w7F6AR57U
 ZzA7YvnvGvRJd9cRPb3LQ/+zV5NEVXo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-zZI0UYTsNoWH14s9hE1NeQ-1; Fri, 08 Sep 2023 04:59:51 -0400
X-MC-Unique: zZI0UYTsNoWH14s9hE1NeQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAD8F1830780;
 Fri,  8 Sep 2023 08:59:50 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F2A9493110;
 Fri,  8 Sep 2023 08:59:49 +0000 (UTC)
Date: Fri, 8 Sep 2023 10:59:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, quintela@redhat.com,
 peterx@redhat.com, leobras@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH 2/2] virtio: Drop out of coroutine context in virtio_load()
Message-ID: <ZPrihIbmMJMRlP2W@redhat.com>
References: <20230905145002.46391-1-kwolf@redhat.com>
 <20230905145002.46391-3-kwolf@redhat.com>
 <20230907184031.GA1560640@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SpUOthRhaeylArR2"
Content-Disposition: inline
In-Reply-To: <20230907184031.GA1560640@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--SpUOthRhaeylArR2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 07.09.2023 um 20:40 hat Stefan Hajnoczi geschrieben:
> On Tue, Sep 05, 2023 at 04:50:02PM +0200, Kevin Wolf wrote:
> > virtio_load() as a whole should run in coroutine context because it
> > reads from the migration stream and we don't want this to block.
>=20
> Is that "should" a "must" or a "can"?
>=20
> If it's a "must" then virtio_load() needs assert(qemu_in_coroutine()).
>=20
> But the previous patch mentioned that loadvm for snapshots calls it
> outside coroutine context. So maybe it's a "can"?

Where this makes a difference is when the function indirectly calls into
QIOChannel. When called from a coroutine, it yields while waiting for
I/O, and outside of a coroutine it blocks. Yielding is always
preferable, but in cases like HMP savevm/loadvm we also don't really
care because it's synchronous anyway.

Whether that makes it a MAY or a SHOULD in the RFC sense, you decide.
If you wanted to make it a MUST, you'd need to check all callers first
and change some of them.

Kevin

--SpUOthRhaeylArR2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmT64oQACgkQfwmycsiP
L9ZEehAAnaFlFThMCHzd+4A3gAdEutm0k//AIUB7UUGJko4QgSQenKo75lmqRLD9
tN7SPFt71ErfxBrSHi6U0NV4X1qhN9ptvo33rmiGpWbuc0Nk2fgtZFUXbNwDqxqq
1pzIlWD853zYO8hAbAaZtiS1WfeLePysrP8S0X1+5T8QPopjpJ1IdeoeKFU5T2Pu
FNLpWbBrm2a0RDFwVKZLf3KlvzkF9CN3f5TOSm6cT6r/DKk9yiS50loootpcfzCF
/VkUXhgYRDvJ9NWQJjtzHj+o0IkpSdJGcxBhweqWtsaqwVilk5Afnd6daidEgD/d
X2h8CnfduVpOs87XFXpXzNQWMxQyPtz2ElFi22lGvhd38wK8WCycLfLm52pmeDXl
jaKcyAUBd7/thDclhIuOxwhlIx76dS9WzMT8WKmUMhkbya7pgAGTxwcIF/FmwViJ
Wevw453JBxyrqHjftdQb5i4gau671PtLZw7JxR5t9KIMzb+/2FaymXG/w7P28pYu
1idZsKWdVZ+U5Pdi9Q7Kp2zB7/q8yLasPzuK0ks+znV/U9wVX7GVsHOEKyU6H05d
Dq2nflcn2pKgbbti7cKo4LJKRDC362R4Z05WowoAzFMnYr69ad0MPOqHZCc92Ssq
NS5pqWTEsfntZEdodPU3efGdJbhmHM5QO6h61hg6FtYquYoW8QY=
=c+Pl
-----END PGP SIGNATURE-----

--SpUOthRhaeylArR2--


