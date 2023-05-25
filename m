Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DD9711370
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:16:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FVE-0007mu-In; Thu, 25 May 2023 14:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2FVC-0007lT-1c
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:15:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2FVA-0007QZ-K1
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685038551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hutoyO5sd+W5YyennJ0MMe61YV4uJEOnksCli5+jx+M=;
 b=hyRKhPgAvxEgZvI0XNINdv5Fbx1MbHdJpS+C6wjY8sW8Lcn1o5kD9wmLjTuWCZmbPy1PPl
 1+3mOPqQTHRQj17qIHHBtBG3XhgeviOtCvHJXENJ9BZ4CgKnNbMAZ1ZrMTmzGtc5hjZDLE
 VHReArewdBRuZ+uXWd60soQVMrc+NJQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-MfaufnROOk6lLmL5Q1oRhA-1; Thu, 25 May 2023 14:15:49 -0400
X-MC-Unique: MfaufnROOk6lLmL5Q1oRhA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F36BF85A5AA;
 Thu, 25 May 2023 18:15:48 +0000 (UTC)
Received: from localhost (unknown [10.39.192.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5ADE2C154D1;
 Thu, 25 May 2023 18:15:48 +0000 (UTC)
Date: Thu, 25 May 2023 13:59:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Jagannathan Raman <jag.raman@oracle.com>, qemu-devel@nongnu.org,
 elena.ufimtseva@oracle.com
Subject: Re: [PATCH v1 1/2] vfio-user: update comments
Message-ID: <20230525175907.GA132697@fedora>
References: <cover.1684338236.git.jag.raman@oracle.com>
 <7340a298bcda0268b3decdd772ebce84bfcedcd5.1684338236.git.jag.raman@oracle.com>
 <87fs7ko3o4.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cvDcho2HtA0NMQa9"
Content-Disposition: inline
In-Reply-To: <87fs7ko3o4.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--cvDcho2HtA0NMQa9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 05:02:03PM +0200, Markus Armbruster wrote:
> Jagannathan Raman <jag.raman@oracle.com> writes:
>=20
> > Clarify the behavior of TYPE_VFU_OBJECT when TYPE_REMOTE_MACHINE enables
> > the auto-shutdown property. Also, add notes to VFU_OBJECT_ERROR.
> >
> > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > ---
> >  hw/remote/vfio-user-obj.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> > index 88ffafc73e..8b10c32a3c 100644
> > --- a/hw/remote/vfio-user-obj.c
> > +++ b/hw/remote/vfio-user-obj.c
> > @@ -30,6 +30,11 @@
> >   *
> >   * notes - x-vfio-user-server could block IO and monitor during the
> >   *         initialization phase.
> > + *
> > + *         When x-remote machine has the auto-shutdown property
> > + *         enabled (default), x-vfio-user-server terminates after the =
last
> > + *         client disconnects. Otherwise, it will continue running unt=
il
> > + *         explicitly killed.
> >   */
> > =20
> >  #include "qemu/osdep.h"
> > @@ -61,9 +66,12 @@
> >  OBJECT_DECLARE_TYPE(VfuObject, VfuObjectClass, VFU_OBJECT)
> > =20
> >  /**
> > - * VFU_OBJECT_ERROR - reports an error message. If auto_shutdown
> > - * is set, it aborts the machine on error. Otherwise, it logs an
> > - * error message without aborting.
> > + * VFU_OBJECT_ERROR - reports an error message.
> > + *
> > + * If auto_shutdown is set, it aborts the machine on error. Otherwise,
> > + * it logs an error message without aborting. auto_shutdown is disabled
> > + * when the server serves clients from multiple VMs; as such, an error
> > + * from one VM shouldn't be able to disrupt other VM's services.
> >   */
> >  #define VFU_OBJECT_ERROR(o, fmt, ...)                                 =
    \
> >      {                                                                 =
    \
>=20
> I still very much doubt an error can be severe enough to justify abort()
> in one configuration, yet harmless enough to permit carrying on in
> another configuration.  But this patch merely documents what the code
> does, so

In both cases this vfio-user device is broken after the error occurs.
The difference in behavior is that in a multi-device server the other
devices should not be disrupted when one of them breaks.

Stefan

--cvDcho2HtA0NMQa9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRvoesACgkQnKSrs4Gr
c8gc1AgAoddwxLuvVv3K4JSn88qtcg02zITs9uRitujy9L/p0dCEgblUG4jG5OUr
pFQkRjdS//YQEQDzbZvwn2zSdNPFCtkjpRCUbEjASbZxl4dIugkDwJXTxHVwKgJg
np9pZ/UnJxKn/GnC81CCCEziHoiuUHDegJkBdnKaa++gBCEjJMOsA1e9idp3zYiP
T5jqkziWU6qIbeKavGKjT9DpHlD8/KQdPaZwNzxoj5HnIwDmEpl2AsfaqZLKWFI2
BpClCe6poU6t94iLSD8HUNpBIVRyv75tWesbcfPoMY7CwA58kazKonI/q758novj
RMWgUo+xPfAmx9P0qW/8TdtrdWy37A==
=7UFJ
-----END PGP SIGNATURE-----

--cvDcho2HtA0NMQa9--


