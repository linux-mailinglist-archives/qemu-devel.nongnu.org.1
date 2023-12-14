Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BEA813B18
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 20:54:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDrmV-0004Iz-AV; Thu, 14 Dec 2023 14:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDrmT-0004ID-1I
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 14:54:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDrmQ-0006Wo-GP
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 14:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702583637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PS8/i37/ocK9JcFFcb/PoZPZoz3ZusTkkUb9rbjQNOI=;
 b=aB7Do6qFfGCFurj/pI782ikPyaekAJVM3dnXK0BcrfxBLJkel7rM/oZpqQazGIIFRtM16P
 KyQ0/HXMkskUCavJnZsdK7VoDgSBMiX+/uleb4jTkDePqvPFzCj/YIzcO7PhrNWc8ry4ol
 XHFpHHgFNIcxRSWB1wujD7DkhxIuWPY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-HKv8LUnNMpCAfc_TV2K8Nw-1; Thu, 14 Dec 2023 14:53:54 -0500
X-MC-Unique: HKv8LUnNMpCAfc_TV2K8Nw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 852C1881F48;
 Thu, 14 Dec 2023 19:53:54 +0000 (UTC)
Received: from localhost (unknown [10.39.195.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03C9D492BF0;
 Thu, 14 Dec 2023 19:53:53 +0000 (UTC)
Date: Thu, 14 Dec 2023 14:53:52 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, pbonzini@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
Message-ID: <20231214195352.GB1645604@fedora>
References: <20231213211544.1601971-1-stefanha@redhat.com>
 <ba257408-5fb2-41d3-8b43-297ebcd312ea@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A+iZ5YIxYQEJFThB"
Content-Disposition: inline
In-Reply-To: <ba257408-5fb2-41d3-8b43-297ebcd312ea@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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


--A+iZ5YIxYQEJFThB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 02:38:47PM +0100, Fiona Ebner wrote:
> Am 13.12.23 um 22:15 schrieb Stefan Hajnoczi:
> > But there you have it. Please let me know what you think and try your
> > reproducers to see if this fixes the missing io_poll_end() issue. Thank=
s!
> >=20
>=20
> Thanks to you! I applied the RFC (and the series it depends on) on top
> of 8.2.0-rc4 and this fixes my reproducer which drains VirtIO SCSI or
> VirtIO block devices in a loop. Also didn't encounter any other issues
> while playing around a bit with backup and mirror jobs.
>=20
> The changes look fine to me, but this issue is also the first time I
> came in close contact with this code, so that unfortunately does not say
> much.

Great.

I will still try the other approach that Hanna and Paolo have suggested.
It seems more palatable. I will send a v2.

Stefan

--A+iZ5YIxYQEJFThB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmV7XVAACgkQnKSrs4Gr
c8iT+wgAsbK/2G/lePCREqH06BQnmiDRniQTZeZuGesEHUXDCpGl8e69iGSQYWL/
0YdU92Zf7WJr7hMEYd55hFldfNTAmLDmrlTEeXKTG3MavNci9169miiD6aOuoTdK
wQmtiM3wmABLh4S1hFVWS8ldRGHuNzaylZqWT9dVPJkKuxYkyTPYQeHlqywETtU7
I9KJOEfYq9G79CvttQk7wEuUEN/q4spOvTEEjQ+tFwValO7KqLAY2XTWifXlizT8
9tdY07fIbM7cgbThR8CAREEPbXg4mxxNPkeUNC5OrlgfYysetQ0vPiXbLCt7o2CE
+eMZSCbuWZQoMkq5760Ojlz/jR6+4g==
=+3dl
-----END PGP SIGNATURE-----

--A+iZ5YIxYQEJFThB--


