Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A28E97D44FF
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 03:30:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv6EM-0002zg-Gx; Mon, 23 Oct 2023 21:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qv6EJ-0002yj-E7
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 21:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qv6EG-0006oJ-8I
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 21:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698110947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sO2NiYaSfOy1NI2NpDS4E0Ryekw8MwJecM3jWtjFsBM=;
 b=GyTynDHTi9FH+4MdlS2DFhMq1TV5C9smGlFsW+QVupG7FjQwc6WKJQtS00kAd1af4yZojJ
 xq7zQ0t4wDhF1uW3kW9nveL5WMJqUS1OTySzP94le0n0DPrKGCxn9MSV+ttinMoh/kliX3
 N1XOdXWV3j0MUrafgsQq1zpM1TRaSOM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-RSAalm_HN5uwceBywr6KFQ-1; Mon,
 23 Oct 2023 21:29:05 -0400
X-MC-Unique: RSAalm_HN5uwceBywr6KFQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D0D01C05AB2;
 Tue, 24 Oct 2023 01:29:04 +0000 (UTC)
Received: from localhost (unknown [10.39.192.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6425325C0;
 Tue, 24 Oct 2023 01:29:03 +0000 (UTC)
Date: Tue, 24 Oct 2023 09:15:34 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v3 00/62] virtio,pc,pci: features, cleanups
Message-ID: <20231024011534.GA499252@fedora>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="StafpExnW4SZRk9n"
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--StafpExnW4SZRk9n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--StafpExnW4SZRk9n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmU3GrYACgkQnKSrs4Gr
c8hgAQf/fAHz6RwbgC8udnEnyV0jwsREt6ME87MsXPVF3PqezlVhvfinacdy0Qhn
Y4jBJzvQ4AMt/is3nfKxOBiF7z2KYawMz/N7M+6NI0fq6kkpmnCepNuZDRe9pRpl
bWpLsQ/MCd/GKZm2J4qHWFzm8PSWdYyp+/qk3biianLEsostwKzIZg5Nff5KohIJ
ZuHDao2hElSvkE0nbctALIdjaD53QK/GNM/3htAl/fX41rciGfh+1AtRhzRbV3xU
w6mWXRFlxGTgh72qZhG4+n23a8yUizHx3D3GRWg9H76/3ogtxVAPCJroQWMyz7JX
EHetcHgzBTZIbETxkwmIb1JbtWAm4w==
=33OM
-----END PGP SIGNATURE-----

--StafpExnW4SZRk9n--


