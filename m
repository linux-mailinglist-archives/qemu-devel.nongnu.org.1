Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E757E26B4
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:24:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00Wm-0007zJ-5v; Mon, 06 Nov 2023 09:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r00Wa-0007su-M5
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:24:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r00WX-0005zq-Pa
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699280655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9oRi4XGsMswIpNIUDMVbWocjV0ieNVIu+9ZJYQyj0Ek=;
 b=Nd7BCorBc/N2FRfJkfJIZEEXxK9zYCK1ZZkU3kdZpRu6U6AGbPFeApHtKeM++DA7v4+kDV
 WiEeee+CNofe8LpySA3ysmG2LaLvYOrdQo4Qi2IytuJ5RqVKPNzIfaK1BYx3AblAKrS2GH
 E9HxBtSORbcloAXlcWy3qfj0ICMXTJI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-iE23apOONzOmVcgbNHf6DQ-1; Mon,
 06 Nov 2023 09:24:11 -0500
X-MC-Unique: iE23apOONzOmVcgbNHf6DQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 515BE38157A2;
 Mon,  6 Nov 2023 14:24:10 +0000 (UTC)
Received: from localhost (unknown [10.39.195.175])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57CDA10EA1;
 Mon,  6 Nov 2023 14:24:08 +0000 (UTC)
Date: Mon, 6 Nov 2023 22:22:54 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PULL 0/8] Dump patches
Message-ID: <20231106142254.GA929037@fedora>
References: <20231103070136.437557-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TO+13mFi7dyGu1JZ"
Content-Disposition: inline
In-Reply-To: <20231103070136.437557-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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


--TO+13mFi7dyGu1JZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--TO+13mFi7dyGu1JZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVI9r4ACgkQnKSrs4Gr
c8ijuwf9EOyo3QgZl4bQy8+p5krxfbAMAHIEcatwbp9lzgIyMD7sUs19OA503cJ/
Iu/u1sHqL/FSCIAra33VpNEysCSzk7RJRKxFi204G0pPhY+mRHQVCHbojeEgmvt4
B/AuBE8bTTM+dvYdcf0I5PQtoOe2BmoCVwu0Ttt8EPZNBvnPw9dC57V7yfnmAev1
5Fr8yiX+YJwQQ33NvxNDEhsbF+vbyXPgCWN1EoaLRZ1Buj12VH7Gu957l7BNqjYW
xEfpLkfk0ZVRk3VifcYmWSzI0IBViwd2mQC2fv6GZ81GYzhrnLruCQBYGK/35s6P
AuPqn9vp6Xhs+PgJGEatGcy3T52qEA==
=YqYR
-----END PGP SIGNATURE-----

--TO+13mFi7dyGu1JZ--


