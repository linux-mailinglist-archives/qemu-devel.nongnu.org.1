Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C007ECA71
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 19:21:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3KVC-0002HI-QN; Wed, 15 Nov 2023 13:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r3KV7-0002H7-WB
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 13:20:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r3KV6-0005dp-JA
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 13:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700072431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lI/c++FH1o4O+fUu2y2fY9wqVWqKoN1uQU4QPSqdffU=;
 b=ZNhtkITDBMXeCJdIrijJSF/sgoOrrWb+FMr4jwmdMud+9ELJRhIj2x/XjLHRNeiLp4tA89
 db5jTYbgfnVUVvGHOdG1lFx0VrBu6u6QBvDf8YCj18qyOgsX90XmIKJfXJGQjo83CZrfmJ
 Plihrje2NqX9CuzrXb4T5D361hsoQd4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-90k__8L2Ou2xBD0OqQKSWg-1; Wed, 15 Nov 2023 13:20:26 -0500
X-MC-Unique: 90k__8L2Ou2xBD0OqQKSWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8E65101A54C;
 Wed, 15 Nov 2023 18:20:25 +0000 (UTC)
Received: from localhost (unknown [10.39.192.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08B912166B27;
 Wed, 15 Nov 2023 18:20:24 +0000 (UTC)
Date: Wed, 15 Nov 2023 13:20:23 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Cain <bcain@quicinc.com>
Cc: "alxndr@bu.edu" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "megele@bu.edu" <megele@bu.edu>,
 Elia Geretto <egeretto@qti.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: QEMU snapshotting
Message-ID: <20231115182023.GA313373@fedora>
References: <SN6PR02MB4205853A81107ACEDB0A3847B8B1A@SN6PR02MB4205.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6kL46thCROvmchDS"
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4205853A81107ACEDB0A3847B8B1A@SN6PR02MB4205.namprd02.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--6kL46thCROvmchDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 03:22:02PM +0000, Brian Cain wrote:
> Alexander, Bandan, Paolo, Stefan, Manuel,
>=20
> Hi, I'm Brian and I maintain the Hexagon arch for QEMU.  Elia, a security=
 researcher at Qualcomm is exploring ways to fuzz some hexagon OS kernel wi=
th QEMU and in particular leveraging snapshotting, inspired by your researc=
h and more.  I'm not an expert on the details, but I'd like to make an intr=
oduction and see if there's an opportunity for us to learn from one another=
=2E  Maybe we can have a call to kick things off?

Hi Brian and Elia,
Alexander investigated ways to reset state between fuzzing runs and has
experience in this area. I suggest talking to him about it.

Stefan

--6kL46thCROvmchDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVVC+cACgkQnKSrs4Gr
c8iyJwf+OggFDxQeg/fbV2jxfk1NFPpbcfBqLtn7gGj1T54afQmqXzTsDxdzDWWf
XV4Uvjk+41708S329Z+d+3yNqXYUcFGMOZFb417UnWrfno65IAIQ/Z9OaZymc2D+
aCF0K4c6W2hcG/9XKFAAsur+wd+qxxnN5KAJtwRPN3BXqL2kO5PFSwXpbJQ4EH+h
5Cl2O34Q9eP/1eU8iQAMECpXqtCcoYV+nG0xQV/IN5XgJCknUBQ8IA5Hxdt8kdyK
E3GfAd/8n17ngaNNGIiA0wktM2Vkw+gKgsMrwrLKKLWNUCNY5maHRjvVGIpMoLS6
VFfieZsyz8ABNcDeSpzl6U7ktY6EqA==
=TwCL
-----END PGP SIGNATURE-----

--6kL46thCROvmchDS--


