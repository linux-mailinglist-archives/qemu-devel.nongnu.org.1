Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1C581E898
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 18:03:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIAmC-0000Tv-AQ; Tue, 26 Dec 2023 11:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rIAm9-0000TF-VD
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 11:59:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rIAm8-0007Tp-9u
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 11:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703609966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V951hyZl/+j1s272BoBCQf8wgzrkw5qx5wEmhc0OMXo=;
 b=SikRUueZwRQkOd5DZYQDkfJAMe8QgyQ0pnAvSeJy30okPqsp4JPPV1WNh021XgwJrwWdWy
 E5cj9tAX2YOUnL3gskN6lN9N1euF6IuZo/eLxyYgWHK+1tCPUZN7mj0Na8hoOaqZ7U1QhE
 C4P1SbISQOEu0CpHQ/8qMQ9Cp5aBha4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-nRcAu9iNOqCEDQmR4CNxYw-1; Tue,
 26 Dec 2023 11:59:23 -0500
X-MC-Unique: nRcAu9iNOqCEDQmR4CNxYw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A41CF386A0A7;
 Tue, 26 Dec 2023 16:59:22 +0000 (UTC)
Received: from localhost (unknown [10.39.192.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DC6E492BC6;
 Tue, 26 Dec 2023 16:59:22 +0000 (UTC)
Date: Tue, 26 Dec 2023 09:14:47 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PULL 00/11] m68k next-cube patches
Message-ID: <20231226141447.GA103314@fedora>
References: <20231222134527.15705-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7uQooOq2o1ArGlC7"
Content-Disposition: inline
In-Reply-To: <20231222134527.15705-1-huth@tuxfamily.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.851,
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


--7uQooOq2o1ArGlC7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0 for any user-visible changes.

--7uQooOq2o1ArGlC7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWK39cACgkQnKSrs4Gr
c8gKQggAq3N8gRu1MvqofvS3IdU8RTItPiWTUHlPUkGf7SkcGYoR8ieTw7CoFI/d
sxerLncd2PxXqDgpbd1fcjVCojmJ1IwYZ2Bejyr/Mi7wpGc88L7mrobfRdKAi8Y8
li9oNNrbfd/+KZpU7WGcJP5zmxoakIgZ5xifO0yDVHJlfJdndcJaLpeKl996q0yR
4WoWKW9t+pfr26RCUc4ovRTHdSt7awDtOZtOdcMIGWXsp2eEtvNTvRYOMaNn1IN4
A/+NcDm74BmMYmMYVcCbkwnicTY0iIAkQSMz0F8AZPLnUK7Nbzfs7YzccFXdYT2F
M2CtJYhd47BeQu40UcyA9gvuGLJITQ==
=h4+F
-----END PGP SIGNATURE-----

--7uQooOq2o1ArGlC7--


