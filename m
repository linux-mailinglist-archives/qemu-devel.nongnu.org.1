Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E74A82014
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Apr 2025 10:33:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2QqX-0006Vo-Cd; Wed, 09 Apr 2025 04:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2QqT-0006VG-PN
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 04:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2QqQ-0003ve-Ot
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 04:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744187497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PgtL/D6untLxPl/Kyv54XmEkbj0oDEaanDqyObaxMv8=;
 b=TTpxoPgHfgQDnYAiBBIBd9nov413zepO22f0qVDXL9jXSYf4LlbtFFbeNlkV6DvDg1LJvX
 2HsCnzukC0lm0k2HzQGlZhpQ6mHATulJwwVn0LZbVITxaTMpN0IXqLv7emktgWMPYxdYL9
 6vesIV9eLxSqn/CPmNZ5sLTQnKXmx7U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-CVZ11Sj9M5WTo6TRCqB2Dg-1; Wed,
 09 Apr 2025 04:31:34 -0400
X-MC-Unique: CVZ11Sj9M5WTo6TRCqB2Dg-1
X-Mimecast-MFC-AGG-ID: CVZ11Sj9M5WTo6TRCqB2Dg_1744187493
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C0AB19560BB; Wed,  9 Apr 2025 08:31:33 +0000 (UTC)
Received: from localhost (unknown [10.2.16.136])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 02F2A19560AD; Wed,  9 Apr 2025 08:31:32 +0000 (UTC)
Date: Wed, 9 Apr 2025 04:31:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PULL 0/4] Block layer patches
Message-ID: <20250409083132.GA24116@fedora>
References: <20250408130048.283364-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3urHauK4u/HFYhtB"
Content-Disposition: inline
In-Reply-To: <20250408130048.283364-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--3urHauK4u/HFYhtB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--3urHauK4u/HFYhtB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmf2MGQACgkQnKSrs4Gr
c8j+JAf9Ek82azTzjd/RzK5ALh/wcZX02HIi22unkFVf2xlRsIvG7EdHonvV5OMV
U9d51Ra/j0Axq0ZEQXEW4LCBCRL7r4gR9tv4KuAiufMNa2i33iNRI3Uu8jhaJrOL
wdpHDN44arsTf3er+5HVFjmw85idANtrElXXuhQlfgi5kQO1xSQWUSwDBJJ7VMWR
vK5lac+r4ZMZUkO6c+kuFhli7JKJBD6qBCWXAiDDRGMWwl9CLR98TEsTXA7uWiQv
133nEa7nWNPGUGoxOyQ636DqsJ14TKVjhybfUu4x18pPFwyOblhr7InFKJWArHRy
qsHp3sRTLcRm0P0sEA7cw8pqklGgeg==
=cn/C
-----END PGP SIGNATURE-----

--3urHauK4u/HFYhtB--


