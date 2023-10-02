Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C00A47B5CAD
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 23:58:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnQvL-0001Wf-9t; Mon, 02 Oct 2023 17:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qnQv9-00019e-Vm
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 17:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qnQuu-0000wY-MY
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 17:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696283846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VxdgqERa3l3cqzA5Gu1x9Sse7TqxHH9Qp8y95CcJ8qQ=;
 b=VRCK94BrYdMlXhJDPtca77HrWIxQRI61u6fiew5dSgxZZbA4gwGbSm5Mr+tSGUTPKhWDqo
 2UbO6Et+GrB6oOUnoDj1kTYQ4L14Fwz/Y10Md7sUA6c05XspDL9+HDpT0o543i+oQ0GmYo
 gU2XfX2eYH3Nyebwdv3SI67M0Ay6yB8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-pLsuheXPO_aRSZ2jafsCBA-1; Mon, 02 Oct 2023 17:57:08 -0400
X-MC-Unique: pLsuheXPO_aRSZ2jafsCBA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE398811E7D
 for <qemu-devel@nongnu.org>; Mon,  2 Oct 2023 21:57:08 +0000 (UTC)
Received: from localhost (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22B40C15BB8;
 Mon,  2 Oct 2023 21:57:07 +0000 (UTC)
Date: Mon, 2 Oct 2023 17:57:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 00/56] -Wshadow=local patches patches for 2023-09-29
Message-ID: <20231002215706.GA1077619@fedora>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HqdoKpUrSrNvsOwc"
Content-Disposition: inline
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


--HqdoKpUrSrNvsOwc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--HqdoKpUrSrNvsOwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUbPLIACgkQnKSrs4Gr
c8gZQQf8D9PP89p7QO9cmF3VYpnO+mxFXoXzUnSwLL+iNjdTp3WPe7+A5mnR5JVw
D7sRq5LaxqPJ7780/JkvvvrY+pDJ1GhTl/0ItCYX+dww2SRPu+FqKmMhSlODFZBF
IUwHnMSSUJHPp6/Dklj8VvgVUCycaJYFpSG2CjuLPAGpxOXMrNSKdSRyvKVIVZSa
3rbDDOk6g8FAkr44lbXMtxLJkfzBk9oeHnlB9H3esfWfa0nCieyLIS3O1cz1BoSm
FEsVLIVhue/fMl22YeqNkW+a+rEWV3pdAhd3Z6P4mx/U/9N1E9mgnJax1uCLt5HT
3PZekF8Wdtc/C76i7LQCojLbRzL8ZA==
=tyq5
-----END PGP SIGNATURE-----

--HqdoKpUrSrNvsOwc--


