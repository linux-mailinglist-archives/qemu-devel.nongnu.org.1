Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15474805DE2
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 19:44:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAaNp-0007Pn-FE; Tue, 05 Dec 2023 13:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAaNi-0007PU-87
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 13:42:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAaNg-0000qj-HF
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 13:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701801770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JcVS9LVuJkCSlBS3tKPelpOFNgmsXJM4YYt1h7S0+oM=;
 b=dVzpEm8sw4ZrWXIK/AoyKbmV7zShRiw6ynsYovEu1fOTD0OKNKRPWEmhyOnq+38jgNvrsw
 iEP75qgi2ZQ1AaFZwNFktL4RqgZqwwXf+8S7xL3gT5/A8Wyy2NeuJwwVQXXInEA1SLIdZG
 wTN6p1YbUj5mjKuiBxHD4j5VtBlhIYU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-pD7YB4f3Oi2CdZ_XwdPAIg-1; Tue,
 05 Dec 2023 13:42:46 -0500
X-MC-Unique: pD7YB4f3Oi2CdZ_XwdPAIg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7386E381D4A5;
 Tue,  5 Dec 2023 18:42:46 +0000 (UTC)
Received: from localhost (unknown [10.39.194.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFBDFC159B0;
 Tue,  5 Dec 2023 18:42:45 +0000 (UTC)
Date: Tue, 5 Dec 2023 13:42:44 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: fam@euphon.net, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/2] vhost-scsi: Support worker ioctls
Message-ID: <20231205184244.GB1978051@fedora>
References: <20231204231618.21962-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YlljmirrXibd3Bvk"
Content-Disposition: inline
In-Reply-To: <20231204231618.21962-1-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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


--YlljmirrXibd3Bvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 05:16:16PM -0600, Mike Christie wrote:
> The following patches allow users to configure the vhost worker threads
> for vhost-scsi. With vhost-net we get a worker thread per rx/tx virtqueue
> pair, but for vhost-scsi we get one worker for all workqueues. This
> becomes a bottlneck after 2 queues are used.
>=20
> In the upstream linux kernel commit:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/vhost/vhost.c?id=3Dc1ecd8e9500797748ae4f79657971955d452d69d
>=20
> we enabled the vhost layer to be able to create a worker thread and
> attach it to a virtqueue.
>=20
> This patchset adds support to vhost-scsi to use these ioctls so we are
> no longer limited to the single worker.
>=20
> v3:
> - Warn user if they have set worker_per_virtqueue=3Dtrue but the kernel
> doesn't support it.
> v2:
> - Make config option a bool instead of an int.
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--YlljmirrXibd3Bvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVvbyMACgkQnKSrs4Gr
c8ixnAgAhU/WTl4GgfFqu7KK4EEIT3Kuh07Fw/A/GhIPzMjJvYhePnLm5tSU2ZFj
EbrbSCR/ncPXuwsriaWfVwCBQUotX+xHcxDMdlyP6uhSMkMgSuPLRrb+CSivr5cO
8gGlXH9P8bi/5iSA88fdZZYwuKjL89eH9Am+E6+ynUwVojYzG4qd7pjwcnm0cTjp
H+jVP9rIBt037vlwXXitw0nbsnhVEhLOADHo6TB6QNjAu0qAXFsD5D0yfsv6Qv4Y
wED5PR6/ZNgfEVUD4akZrzrdIVqRUvbGTyYtYingOpbo7mPTgNzU+d8SHHfnGc+t
NBJciFSMKzdtZ8Wrz92JOcrzuFq9xQ==
=dagG
-----END PGP SIGNATURE-----

--YlljmirrXibd3Bvk--


