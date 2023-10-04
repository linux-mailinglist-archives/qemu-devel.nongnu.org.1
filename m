Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1217B9D13
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 14:54:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNqb-0001nv-Vi; Thu, 05 Oct 2023 08:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoNqZ-0001mI-9Y
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:52:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoNqX-0005eM-MO
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696510371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uYgiKbfGfS25iSc7KQIvDPsaVvaQ+F1HY1DLixetCHQ=;
 b=h10gVyxL6rIkuv2YqBi2wOsus+EhoV9jPHftfFpGyjrJFDlLAsFFJ655qxLsqPBK4keZg5
 +LKJxmA1vww+dRSuCi59Xb+5IqeATzxplsUg1c27YeHhN7FhYtVVgvLqiE13StvjJMBeeV
 kDF9qKX4aZ4GC3F8804Oji5rmmzw6Rg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-VX6xR2p6PZe892PTapLsiQ-1; Thu, 05 Oct 2023 08:52:48 -0400
X-MC-Unique: VX6xR2p6PZe892PTapLsiQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5ABFC811E94;
 Thu,  5 Oct 2023 12:52:47 +0000 (UTC)
Received: from localhost (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C895E215671F;
 Thu,  5 Oct 2023 12:52:46 +0000 (UTC)
Date: Wed, 4 Oct 2023 14:33:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>
Subject: Re: [PULL 00/51] Bsd user mmap patches
Message-ID: <20231004183327.GA1287823@fedora>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="K2/l1N1jKldVP5qA"
Content-Disposition: inline
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--K2/l1N1jKldVP5qA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--K2/l1N1jKldVP5qA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUdr/cACgkQnKSrs4Gr
c8glfgf/TW985qb0PlHGM2tqdLeiJ0xaQSrRgLC5mpPh1SJQ/L8cyUp+AYKEzLgB
J9jI+uwXGsNnxvV4zhbvEl+R/FmMb9tmc6DdBHmORIsV5VxTqCuAw6CBq85GZsYe
T/2z2DQqClbREa4rwjujZJGso6hsBC7wQVzXfaYVmQeIFwk2MoPjGf6K0PtZlQM/
jxCd0/x4A+wnV3YHAWy/CzyTarj7H2ABFi3g50EM23vE+F/RB1iDbEISNsU7obRZ
mwT0nsiy9bQvEOoBs59xHNL/Fwehoq7R8PoFFqHo75F8xBXbsnopfvUMZRggKkhS
A1sa1//xWZ3agriFPsBqVMHTAg1GTg==
=sGt/
-----END PGP SIGNATURE-----

--K2/l1N1jKldVP5qA--


