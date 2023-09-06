Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E053A794303
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 20:25:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdxCS-00018z-JI; Wed, 06 Sep 2023 14:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdxCM-00017v-Qi
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 14:24:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdxCK-0008QB-9g
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 14:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694024652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+baSq7qiQ//hYtxuAvyzqF6fR6J/0sYFJ6q1mOQ6clo=;
 b=LlzXRKI1ane9EuysaEz9/i+J5/APQ5yPk1q4cTxlQmCsqBjNaAMzTNoL+vXlfeu8qt78x4
 GV6lhw/oIUA+k4VFtT6esjNir1ydDFUF5T7MDjU2kV+gDIqdpRx9RQnhdOitcDhL3r7xe6
 ydl6xbGQrc2vdi/w12aNQVBXsjZBIUI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-6J-mYOGlOvGjCpCX06wXXw-1; Wed, 06 Sep 2023 14:24:07 -0400
X-MC-Unique: 6J-mYOGlOvGjCpCX06wXXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1AFD182EF45;
 Wed,  6 Sep 2023 18:24:05 +0000 (UTC)
Received: from localhost (unknown [10.39.193.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67173200BABC;
 Wed,  6 Sep 2023 18:24:05 +0000 (UTC)
Date: Wed, 6 Sep 2023 14:24:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PULL 00/26] aspeed queue
Message-ID: <20230906182404.GA1282605@fedora>
References: <20230901094214.296918-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="azU0J3sEjH/FQVCp"
Content-Disposition: inline
In-Reply-To: <20230901094214.296918-1-clg@kaod.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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


--azU0J3sEjH/FQVCp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--azU0J3sEjH/FQVCp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT4w8MACgkQnKSrs4Gr
c8gBnQgArCMSfvmgC8tNjPnhGgLKYCczmZ53+XNMLQC32T8j7BWEMzUQJr56Z7bq
k4GQHErfo1OoIxaYQyRsDROu2leD29ifgSBbk/GVQDlUDzeQCFibnfJ2jH/MMPhr
jRqP+R5ZmvpY+yJ8PvXrWL9xC9OzOyU+iU2DTqIdkHPPTnVyhhWa8Lj1r1zt7bkm
9YlkHmQScTe1CcZud8KCigV+dMO7PmEklS2pUboOcfkZc1G7UTf53n6rrei81FbV
XkjRyQzXiqA0qpRG4LzUps4DXJAOpzxQQPuv2hQ6pmzJ6f5O/xzKJhYD8rMam8cL
fsANeCCyuwKtMaLh2j5oHbeyjuhcvQ==
=QMsS
-----END PGP SIGNATURE-----

--azU0J3sEjH/FQVCp--


