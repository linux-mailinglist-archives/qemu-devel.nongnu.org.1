Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F95AA546D
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Apr 2025 21:05:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACjN-0000nd-Ku; Wed, 30 Apr 2025 15:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uACjK-0000mc-LJ
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 15:04:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uACjJ-0001oT-54
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 15:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746039864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G1wZHD7N4iVZt2ScQtOvbzREYqLuGfCjG5gmfEOfbBE=;
 b=Pqfx+h4X37j4Y2jsupila99ksdyNYcB2g1druQldP8+uSuT32/f65LIEpwFBI0IDM9QpkJ
 7GYIJW6o7fW+Io4uZjwVuNWIcCABaG2PNN19fi5qOr5WkVSOyQejEsDcyLk4B4xHQ9eXaJ
 ODe1m/1g5ZEwHqjFJhIwEYWp4b1oB0s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-qd3tWYIwMQyUTnfy_XUZVQ-1; Wed,
 30 Apr 2025 15:04:22 -0400
X-MC-Unique: qd3tWYIwMQyUTnfy_XUZVQ-1
X-Mimecast-MFC-AGG-ID: qd3tWYIwMQyUTnfy_XUZVQ_1746039861
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FA0A1800876; Wed, 30 Apr 2025 19:04:21 +0000 (UTC)
Received: from localhost (unknown [10.2.17.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44B7B19560A3; Wed, 30 Apr 2025 19:04:20 +0000 (UTC)
Date: Wed, 30 Apr 2025 15:04:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Czenczek <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/1] Block patches
Message-ID: <20250430190420.GA65554@fedora>
References: <20250430154712.57125-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bOBnkB+L+hn5pwJj"
Content-Disposition: inline
In-Reply-To: <20250430154712.57125-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--bOBnkB+L+hn5pwJj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--bOBnkB+L+hn5pwJj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmgSdDQACgkQnKSrs4Gr
c8gEDggAnvMBg5Tfi1MlD3beiWYFPLgpmMkYkame6pLcrDQI2YJuj+cL3bVwuPXf
qY22x7ZnqqEdRVLmSU1LRK21SLeA9gWEFpHON37zJ85MPb5k8+2ZmkOOBNPLL+Q1
kiW4jFwpfaO0eRJ9S9psSREbMgAtU5SSmZ7Y0pwBnF/a7/IJL5NHvrqqvVJ9eN6h
uTPWyff+OBB8Q6MrefjCD4PKdiw843OaUdxT0hF4nwZiIjTj7Cpz2cUz4WbfSIbP
Xx3Frpu4DGZA0zMicDP042qJBq3ZdVT4gPLbIbMPqtXos/OFVP7+L9ywqEaUOhWA
VwRxetQdL2VdRadKQtktjc0HhGMEgw==
=h2Oa
-----END PGP SIGNATURE-----

--bOBnkB+L+hn5pwJj--


