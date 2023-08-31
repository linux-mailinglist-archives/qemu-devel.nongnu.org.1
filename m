Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7872D78F102
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 18:16:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbkKa-00043E-EG; Thu, 31 Aug 2023 12:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbkKX-00040F-9A
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:15:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbkKT-0002Tx-Lm
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693498532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dpB2YODJnXHtqBsD+D+ov0/kc43vk1o/4gtUbgGcq1U=;
 b=Lixe9O4iSW5on7d7Nyc+t419GSHkeW2OzE17qWU5d2NPR79IPid90lfhtvSEazAoxGO0/E
 74M6za1cf5HYH1ZCD8b9rzQ2i/4XDPvZ0YfYjqFi0eJ9zxMNXNOi5rg0QedR4mMzPI37bZ
 AJnRUarSA8GMfm4qC7jXgH1QcLVYzDc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-682-VNtogZBzOIedg8b3gLr0Bw-1; Thu, 31 Aug 2023 12:15:26 -0400
X-MC-Unique: VNtogZBzOIedg8b3gLr0Bw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDE0A38035B0;
 Thu, 31 Aug 2023 16:15:25 +0000 (UTC)
Received: from localhost (unknown [10.39.192.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02875C15BB8;
 Thu, 31 Aug 2023 16:15:24 +0000 (UTC)
Date: Thu, 31 Aug 2023 12:15:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>
Subject: Re: [PULL 0/1] Quick fix patches
Message-ID: <20230831161523.GA541329@fedora>
References: <20230830154007.54297-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5v8kqDBGlp2jQ3RV"
Content-Disposition: inline
In-Reply-To: <20230830154007.54297-1-imp@bsdimp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--5v8kqDBGlp2jQ3RV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--5v8kqDBGlp2jQ3RV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTwvJsACgkQnKSrs4Gr
c8gxNAgAiaCihpgqAvDbmXxNxn/Slz+ozEGlG69yx7tPvmdKjygooRqHyj7ImryW
dPpLF7V8eiYM4rfAOfRt+zNZqAsvQul21nfLamSIl4+2cskFWUxQ9tVGtp5Khg/R
SmwGdcqx51jzndx0jJ7gqpYDf0ratXOE0YuZZO2zy+6XWJXOv0MF6I8s5fmdUHt4
4Nn/Va6qm3n+MSjodw2mWsR96z5sFQYH4u+AVas3cK3HOiJXkjiLMG6I6N6+45Ou
Pr9LwY/l7zhI6PfA1f3RWRFeCtRIvjwq7qU/KcWEp9XIlvBdofws8E13GGyLZp96
f1RInTi+uDe4dTrj53XAhMweprSLSQ==
=xUKv
-----END PGP SIGNATURE-----

--5v8kqDBGlp2jQ3RV--


