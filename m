Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F76D804134
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 22:56:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAGtj-0003bU-Eh; Mon, 04 Dec 2023 16:54:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAGtc-0003ac-PU
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 16:54:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAGtY-00010k-RW
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 16:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701726867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=RfXeFBcwSHtpLfMVeYT9A9vKi2iFc+hpjmx251ub8a8=;
 b=hlBrhSjRmesphrBW1EPq8wf0vdbbMUUztt1DqKFduQIV4v/JnSgj3+px+Vw6+jYU0lyrg5
 UNwyHxch0QC4cehA4yDTMoif4qogdAMfxCfbNZVy4kydtlw+n7oKs7xQ5oN+7ROJFqx8Do
 lHeqOL7shKEFBVejMragICkkgGN41aQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-9wgbIbThPuOS2QeSQv09XA-1; Mon, 04 Dec 2023 16:54:24 -0500
X-MC-Unique: 9wgbIbThPuOS2QeSQv09XA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE988811E7E
 for <qemu-devel@nongnu.org>; Mon,  4 Dec 2023 21:54:23 +0000 (UTC)
Received: from localhost (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AB2F492BFC;
 Mon,  4 Dec 2023 21:54:23 +0000 (UTC)
Date: Mon, 4 Dec 2023 16:54:21 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Willian Rampazzo <willianr@redhat.com>, Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: QEMU CentOS Stream 8 x86_64 runner is offline
Message-ID: <20231204215421.GA1734660@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oWohqCW6Ct0Mexgu"
Content-Disposition: inline
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


--oWohqCW6Ct0Mexgu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
GitLab is reporting that that the CentOS Stream 8 x86_64 runner
(#12198892) has been offline for a few hours.

The machine responds to ping so maybe gitlab-runner just needs to be
restarted?

Thanks,
Stefan

--oWohqCW6Ct0Mexgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVuSo0ACgkQnKSrs4Gr
c8iI7wf/fh+cWp6/yNySGHcwgUkS2zDPAL4zZOgjr1Ddfo+ci42Ixqjs24YzThLC
vrxKtG9yfqIr8GSLAFoRu+s7TpCqijSJMidr8MT+Ia5jaN/KQaMPYD35+vtcXZrF
nvtFj9lmKilgnSS/++gtxFP4CBer4VqNwtdry1a7YsLaUKRyvgaFPV4Kpel1VTuD
v97cNqAtVZK1ETEUp4Mrf1tlhaY1ICX25XSp4x5OH5eUYvzrvmnLNHqltY54nkyL
3E5WAekCVk4j8sJynwlqzo5EeMLEW/0vRRolSdksUO5J/ZZ+j3+W/UzkZFfNj3+t
PZ8sL6o9V93lvw6WmwkqzWwPMX6Peg==
=rUKc
-----END PGP SIGNATURE-----

--oWohqCW6Ct0Mexgu--


