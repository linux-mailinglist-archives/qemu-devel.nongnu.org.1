Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0A17FBF25
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 17:23:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r80rR-0000KY-5t; Tue, 28 Nov 2023 11:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r80rO-0000Jk-KN
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 11:22:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r80rM-0004fM-2J
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 11:22:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701188571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nVNlVwh5aGlg2eEVcNXqY+lxezkL/zYFTxYCQuvzJ+M=;
 b=WkljUw+zU1QB1YSDvQX5U50EINEWWo1DtFfbtR3vXBVMg1ffcUoAFwqfLMq4CecK7Yqk2Q
 asxk3NlGMqTJiCBqym44wgH5jKl5AGL+ZDWjmL58n6Vp47eBEgEGfp7SNJqx0gXonFMT7z
 +1qzyQb2GL9Mq6v2I7HKVgjaBQ1hrdQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-0xkLy_NBPtmM-wPDSp5GPA-1; Tue, 28 Nov 2023 11:22:47 -0500
X-MC-Unique: 0xkLy_NBPtmM-wPDSp5GPA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D75E283DCCD;
 Tue, 28 Nov 2023 16:22:46 +0000 (UTC)
Received: from localhost (unknown [10.39.195.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 665EE492BFC;
 Tue, 28 Nov 2023 16:22:46 +0000 (UTC)
Date: Tue, 28 Nov 2023 11:22:44 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/13] target-arm queue
Message-ID: <20231128162244.GA600291@fedora>
References: <20231127170823.589863-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hp4rVZLt9kzfVyam"
Content-Disposition: inline
In-Reply-To: <20231127170823.589863-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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


--hp4rVZLt9kzfVyam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--hp4rVZLt9kzfVyam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVmE9QACgkQnKSrs4Gr
c8h4XQf+IfjO2EVZDkzw65VUzE0Ubo0g3NVl2GjuMe8gR4HEyuwi338HlMVJeiW4
Fl2luIVgyB7OSpJ0MzVLYf8Okc+JnJprde/RCzx3cRN6NpswcBMTcbvZGOjQN2vk
sCy2SchThqjhcnpc5i3XTZ+dWXSZ2VHCCv39BOOZm9rJ6Bgl7Ou08gw8b0tiwUmJ
06Gp2scmBMgzhGCc/topQKAZ6uJQbj9TU7oX5bXeZXndoSMWyQ/6BAA5SBgwyDc8
NH3Mj9WdFBwm8oU6RG1mBGHKOY9/knfBlTNPzX9hWwjPvwlBqwW2iJ6d2G7Uthht
rKPP2HM8AUfuDiigp4GEtgoAqS7Ssg==
=Vh6C
-----END PGP SIGNATURE-----

--hp4rVZLt9kzfVyam--


