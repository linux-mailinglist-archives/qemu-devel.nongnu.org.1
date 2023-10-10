Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D3D7BF04A
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 03:30:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq1YQ-0006mf-GT; Mon, 09 Oct 2023 21:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qq1YO-0006mA-Bt
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 21:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qq1YM-0001fN-G1
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 21:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696901332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7qOxDdvO/3tbROa9RU4OI6xADIDzYW/JagzHGmXSftY=;
 b=Y5Sb6fZOmBGZ9kN3eMCpe2sXHBsbyVc6hVOhav7SaUNK5Dg8iPAVN4rr6H9ZWKw4I9GZ3r
 8S9644fpoxrmD2NWVELNv3BjijnuPBcIj9AVlZQgMCFKkh3uHsU+Fu/ulpSFhPyJj7kJg3
 yTA7vHEiRAkf6gY43YPUl1INLpJQRyo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-694-U0IKwEtUMgysR3EMHSDujw-1; Mon, 09 Oct 2023 21:28:45 -0400
X-MC-Unique: U0IKwEtUMgysR3EMHSDujw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 626FD185A79B
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 01:28:45 +0000 (UTC)
Received: from localhost (unknown [10.39.192.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED3F340C6EA8;
 Tue, 10 Oct 2023 01:28:44 +0000 (UTC)
Date: Mon, 9 Oct 2023 21:28:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/15] NBD patches through 2023-10-05
Message-ID: <20231010012843.GA1674481@fedora>
References: <20231005184447.682556-17-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vPFAcxyQ6m/2eZKG"
Content-Disposition: inline
In-Reply-To: <20231005184447.682556-17-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--vPFAcxyQ6m/2eZKG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--vPFAcxyQ6m/2eZKG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUkqMsACgkQnKSrs4Gr
c8hFJwf9FIH7khzE+0vXHjyeMEVbskdrzN2Bzu5lH2d8zprkUDGHAHXK3YzRAVP2
oJLuHVN34LWgWpZkjcEjgkl9UsVtPFfj50wDusv/w8la5nHyswuoc7i9VgCV4J69
xDVtQ8Us0+Nxk1vKYvdmUAeZ0AoBlQyPZTFZ9yXUqPi1OKybtI7ypu1ysX14B56F
L9UlTFQ1JJIYYkDFYOosH7cl4k1ri+zfmvHghj7mK9pw3I//0iJpsrAXHekV33QC
+kx1DU6KiGQZbnEdx5kkXqnexhKPZy8sIagw8Gou8DWcvbwYjtQc3O4mUtwCpfRN
4c5jCoSFBvWo2Ub2jEhEQLmykjgWmQ==
=0ngR
-----END PGP SIGNATURE-----

--vPFAcxyQ6m/2eZKG--


