Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1943ACCD5D
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Jun 2025 20:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMWgu-0002Fa-Tf; Tue, 03 Jun 2025 14:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uMWgs-0002F9-4B
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 14:48:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uMWgq-0006k5-BD
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 14:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748976524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mQy7SqjhZzya8G05S3ij7YzxZkFPXtqCKzMudZhOP2E=;
 b=PY6qTIt6ob5zMX+z7KffSk/dTETzwu+YbZ25+p0uuvSP/EojpEjaKYG2JxnMhG+Kt1b3hc
 K9ICTBfaGeN5OU4VjXgSc32zE2eja9FbnuE9+jgOoSUd1f3UgRbtTVJsdsi0+H4ZcbgQ+F
 PvOkMCwolGlmgR6Bk1KFxk9WT8oPdoo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327--s8Au_ZNMdib8Qc2n2kGdQ-1; Tue,
 03 Jun 2025 14:48:40 -0400
X-MC-Unique: -s8Au_ZNMdib8Qc2n2kGdQ-1
X-Mimecast-MFC-AGG-ID: -s8Au_ZNMdib8Qc2n2kGdQ_1748976518
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D443195608E
 for <qemu-devel@nongnu.org>; Tue,  3 Jun 2025 18:48:38 +0000 (UTC)
Received: from localhost (unknown [10.2.16.58])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C41E19560A3; Tue,  3 Jun 2025 18:48:37 +0000 (UTC)
Date: Tue, 3 Jun 2025 11:52:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 00/13] QAPI patches patches for 2025-06-03
Message-ID: <20250603155202.GA354395@fedora>
References: <20250603063644.3953528-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d3ChyS3Rq04U1dxU"
Content-Disposition: inline
In-Reply-To: <20250603063644.3953528-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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


--d3ChyS3Rq04U1dxU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--d3ChyS3Rq04U1dxU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmg/GiEACgkQnKSrs4Gr
c8iCCggAxc1zimTDe/rq369oAKqENpNXKHaQxZ1HZJzTVyDZEUh6QtU/1QwWKsJm
eAOyB/p0C1YYpT0qCvf6LVPRRfMPcRjmr+/z3zDtQ53Gf+bJOZvSTqb32tjdakkK
IwDWq80A3GEhkc+8Z2TLqUDe1sPtJq6HwPTmvxPn1U5vWzQGBAhc0Jc+WhqgQ0w6
wRqG8/GVpCJdNQnb+oJP/5I0/xtUDgkpuEnre3Z7qBwccYAhDEhyk0DXc2pY8/zH
eneP2xHVYkxU/N8ya6hQdzB7Zf5p/tGYupmup7Q6r9wfk/+t4YWTCJZcwsayq7Oz
bQe1yTGrod+jFgDo6BJJO2xbKbmb8A==
=s/er
-----END PGP SIGNATURE-----

--d3ChyS3Rq04U1dxU--


