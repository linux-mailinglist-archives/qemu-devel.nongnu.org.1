Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4B67EA3BE
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 20:29:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2cc0-0006Xs-OV; Mon, 13 Nov 2023 14:28:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r2cbx-0006XE-1s
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:28:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r2cbv-0004Gp-Hq
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699903718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RDA4zhgxZWFdrzDN6CUwERQgsgsPx3ffh7Td26ZJB7k=;
 b=NVUs+BXHZrZQSy3NtL9elfXmqyVpWq9sQ3kD7LfxpgxUsi9DDN4nOIj+L6iZ8ovWwmxnCy
 LORAV0fEllQ8cZf30IOyemaPBMl2Qg+i2C3hug984rm+OyFDokJoF9eYVju1Gzq9GDCwx0
 zF5mx8prZJJ4z55CGJXlsJvnVJqyWWU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-OU2Co-HPM1qquX2NHgKdHQ-1; Mon, 13 Nov 2023 14:28:36 -0500
X-MC-Unique: OU2Co-HPM1qquX2NHgKdHQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46A8F101A54C
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 19:28:36 +0000 (UTC)
Received: from localhost (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 495FE492BE0;
 Mon, 13 Nov 2023 19:28:35 +0000 (UTC)
Date: Mon, 13 Nov 2023 14:27:30 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 0/3] QAPI patches patches for 2023-11-13
Message-ID: <20231113192730.GA241598@fedora>
References: <20231113103431.913394-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hyq+/wlBXOcsz5XV"
Content-Disposition: inline
In-Reply-To: <20231113103431.913394-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--hyq+/wlBXOcsz5XV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--hyq+/wlBXOcsz5XV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVSeKIACgkQnKSrs4Gr
c8gi4Qf/S6ibLVmO2TqXrg+OiMum+WYIu6E0pUj8uq/bp7cOZMYIEqfPAy45xz6g
rQpcs0JFyiMsHhZDMmRIrCPbDGne+NICBGVqtJ+wLZ7h6I1esZpiO2oChgc2WOZu
9/qd8U1WaEmaLD5VtkT3zOb+p/fUCYHMOECKC8blW9C34wIo2aNU1S786w6NyEpA
fJjVBtAKMpWE4c+9cm4yYSvs4S2Gl0i0e/Kg1PjTGf1KEDxKhvrtSXyN2GPC4t+o
ezmvWhiYRWSHU4Le+WcdVTf16cBpFRAtuvjxC6fxU8HPAtm8DgIE5abH6L8RbSW9
eodTDmjctzeIU1lOJvj3Fclf4tnfTA==
=CsGS
-----END PGP SIGNATURE-----

--hyq+/wlBXOcsz5XV--


