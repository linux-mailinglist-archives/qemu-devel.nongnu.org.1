Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 195A37E402E
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:41:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MK2-0005Y8-Oc; Tue, 07 Nov 2023 08:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0MJs-0005T0-Nl
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:40:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0MJq-0005Ha-Cm
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699364436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fjsWCSH0qssdVMAAvtlv7ybygDFd7VwlmU4YlGgiE7Y=;
 b=P9wOWj/Zm3QlD3SL40evJyp4cZZcFOUUyQCNp6d2OeawU3I0GO4dtuFYXRxoXW9XSF7WIG
 C7DB1ZrEHOwSUC8aPmWRY7/twy+KPfk+wyTXPICtM0H+BnX3LYOXU6rpx85Vyvbt1BTI66
 FOoqIes5BBxdLQwyRqMJ74zGvGxCrCk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-1b9BB8TMO0yaXq9GTuNfhA-1; Tue, 07 Nov 2023 08:40:22 -0500
X-MC-Unique: 1b9BB8TMO0yaXq9GTuNfhA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4BF4089C82A;
 Tue,  7 Nov 2023 13:40:18 +0000 (UTC)
Received: from localhost (unknown [10.39.194.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88C6625C1;
 Tue,  7 Nov 2023 13:40:17 +0000 (UTC)
Date: Tue, 7 Nov 2023 21:40:15 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/63] virtio,pc,pci: features, fixes
Message-ID: <20231107134015.GA1010664@fedora>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bu/1WYw0gfqbZVhB"
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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


--bu/1WYw0gfqbZVhB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--bu/1WYw0gfqbZVhB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVKPj8ACgkQnKSrs4Gr
c8ihTgf+Of1yK/5eGCe+OtJpLgTFkbjW6Af+Tj+dzRgoTEgMgYR+XCMH1NSSmMUQ
3219l0i8wKlwFlSaqr6uI+sOJkeABtOsYb9Oo7BCztUSlSJa7ZfKvW5J7M6cTKc/
2udi/4jg5APWdx7p3g8aNSNb6ieMoHOAdWUEV43KNIpqg9ExUdIAOwAi65JzT1BF
KHZoAAxmpH+0ZpoNFDuKJssbEYoPdgc63qCLlL+LSdyg4A7ZWiPzvwyzWlsaxVhA
1OMKoQcvBFJUoMbSYhHoptq+DlnYe56i0hFmWIL7T0j2BPTX1eNpmPeV0lDB8Q7Y
KOMFddAh3alQT3U6RGF5boA53igWwg==
=ScFL
-----END PGP SIGNATURE-----

--bu/1WYw0gfqbZVhB--


