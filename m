Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F98A32D9E
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Feb 2025 18:39:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGho-00043b-Gx; Wed, 12 Feb 2025 12:39:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tiGhl-0003xA-9U
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:39:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tiGhj-0005kw-84
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739381958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zYvwojUuH4PFVssWZmEugcYjE7Nn7PjTZGCJgrfOgjY=;
 b=g8CY2nz6NpJjWQOKXO3dPZNmuEPt25ZFnfzqC4fqqiBtz+1UUr7KrkcThG+YOmxMTZt3Cb
 tZoOEI4A98ix+LqjkiirRufC7dnGkOcW8cI8zapV3QGqxDmlyI/tyml1BawYlbhR0yJ+Zt
 iqUu/yJ7Bum1GtcQs8enP6Sr+RMOITs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-2-NH37DSPqylyy7TKtHp_g-1; Wed,
 12 Feb 2025 12:39:09 -0500
X-MC-Unique: 2-NH37DSPqylyy7TKtHp_g-1
X-Mimecast-MFC-AGG-ID: 2-NH37DSPqylyy7TKtHp_g
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43ED11800374; Wed, 12 Feb 2025 17:39:08 +0000 (UTC)
Received: from localhost (unknown [10.2.16.66])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 69F7D18004A7; Wed, 12 Feb 2025 17:39:06 +0000 (UTC)
Date: Wed, 12 Feb 2025 12:39:05 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Song Gao <gaosong@loongson.cn>
Subject: Re: [PULL 0/6] loongarch-to-apply queue
Message-ID: <20250212173905.GA211940@fedora>
References: <20250212031633.3548108-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PTPTnVw/mR5YfeKG"
Content-Disposition: inline
In-Reply-To: <20250212031633.3548108-1-maobibo@loongson.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--PTPTnVw/mR5YfeKG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--PTPTnVw/mR5YfeKG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmes3LkACgkQnKSrs4Gr
c8j54QgAr9uRPwMoZodiMOL7tKAPli1O0Cv1kkN6rTDnHOwbksLMy0epimB0pn1c
STF7wksiphwGXNeqJ7cMby4e6Skk6aJdjPsNiDBXgK1VhjLdByhN3MKOxPyRXlDE
qjJfxpthcAZfYZwDldaCGWGyRxb6xHzRiQ6jiZOx+rZobV++e55bwxEb6XdHzrU4
BWTJ8RQtiDW35P4ri2fI740ACgOKhB7ACF/LrfMXsvnJagY3XiN/fPJy/1X0aD7+
nFqCqPD6e5tme5nQPBP8ruGrVL+ME4tlS3+sLeWs7VxMvwAIFO9CRLjijSiol2Wv
M7sqBuRezO4oOVGSo/wp0HEewMXjBA==
=BwKh
-----END PGP SIGNATURE-----

--PTPTnVw/mR5YfeKG--


