Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6FE787430
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:29:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCFl-0006Ud-3V; Thu, 24 Aug 2023 11:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZCFk-0006UV-0x
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZCFh-0002h5-Ql
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692890884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+kzCiJ5q8/DF/ItAcfPe/CvmGah75un/uC5xJsQn0Hw=;
 b=cwyblBt6XEmWAg0CDSWxH5oHsNNXruc3E+9qAr3tbpd7+u62heUD3m4rijSM80pLAkwn+e
 0PWtFa1I9ucO68eOEjgmwisNVA1VP2/kbbD7qVt8XFQGKFzaMqvZ/oXNYSLzNNtY0ZtXrc
 7K1cd2HjLXyQdHiWHOVD4bPplvalQsI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-DX90QmpRMg-iACDG1vOAWw-1; Thu, 24 Aug 2023 11:28:01 -0400
X-MC-Unique: DX90QmpRMg-iACDG1vOAWw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19D063C0F684;
 Thu, 24 Aug 2023 15:28:01 +0000 (UTC)
Received: from localhost (unknown [10.39.194.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6C4B140E917;
 Thu, 24 Aug 2023 15:28:00 +0000 (UTC)
Date: Thu, 24 Aug 2023 11:27:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/35] target-arm queue
Message-ID: <20230824152759.GA1608004@fedora>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KCWqB4WMJqH89fb2"
Content-Disposition: inline
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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


--KCWqB4WMJqH89fb2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--KCWqB4WMJqH89fb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTndv8ACgkQnKSrs4Gr
c8jaaAf5Af4FgMUrrdv+6vYcZGZly2opbOoHsWTIFedPfoPaZcwUH3SwlbhSBmz+
o8hBzskj7FfYfwNyYnyhB7QGRnvpL/CdajqGGW88i6rZAbO5C8t4iFgqNQAHCSaU
TcajrtEZC3wwsoX7ioGnTPKAuQkAbBDyrMQgfXVkycsEd4Dveloi6ZaXvfHrlXwW
O8uUJBJ34tp63+YlpQpClVVeijtmUrVp6FuSBaeGAP8BZjmH5aBIVYekxHtlUguo
IxZHompBqE6W4wrHUiFWszvcUC/9HpTcxN3DQ9OLcAIHgyClQT1Fmw0VEkJIed1P
U3TeQ42gToua4VB0Z+LKmxvvm4VwHw==
=0Lzx
-----END PGP SIGNATURE-----

--KCWqB4WMJqH89fb2--


