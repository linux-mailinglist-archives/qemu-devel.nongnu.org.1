Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 413C8A5EC61
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Mar 2025 08:07:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsceE-00041E-EE; Thu, 13 Mar 2025 03:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tscdm-0003my-E1
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tscdg-0007wv-GI
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741849555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DMfZJIVdO/tVwWPCwGzQ6OLdEM5DJC9wdGkriNxHEng=;
 b=NfY3Xs1bvA7400hoEFgUogFImVHPr9Z02S62TRGVLyghGg8QMOSJyCDU2ALOkxADF4zcLV
 ccYTg2UcQj19EYO41gUakLDBINw3RPjEBOFx3jxbgjBLuD7qGWb8U2b+NEGKz/HxP9xY00
 6sW6UQkfsTpwFeFlhV/rFM7upkOMxj0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-D8FSqV_LO-KzeDMkyYA4ZA-1; Thu,
 13 Mar 2025 03:05:52 -0400
X-MC-Unique: D8FSqV_LO-KzeDMkyYA4ZA-1
X-Mimecast-MFC-AGG-ID: D8FSqV_LO-KzeDMkyYA4ZA_1741849551
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 770F61955E90
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 07:05:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E4C0E1828AA4; Thu, 13 Mar 2025 07:05:48 +0000 (UTC)
Date: Thu, 13 Mar 2025 15:05:45 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/21] vfio queue
Message-ID: <20250313070545.GA1086215@fedora>
References: <20250311181328.1200431-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+dXouVQVuDjdHA2u"
Content-Disposition: inline
In-Reply-To: <20250311181328.1200431-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--+dXouVQVuDjdHA2u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--+dXouVQVuDjdHA2u
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfSg8kACgkQnKSrs4Gr
c8gDwwgAh0BLZS9xrmTjRb5dgl02duK0EFuS7Kk4nAZWrOmS7cLbQGk4aIgF/UTy
Ped7VyyjupV4RzaXshTfOMzKHEtORHv2iWJO6Sp61E88Adx3YWkPuQF6CRIG+aYl
9wte2NHlAtxG/O8mvIJRjEI8TMrhAyY0Seyvk2aOWoeIp9LB+gzF7UFqQpkjE7Ob
XKM5Hj/ZyfAOvkTPGbx8487kZT4w6I0kBGGuNtQlByAXEmv69N8wjWh+USpHVBRV
3THk95ZCXu65ul/pAcsh6feCf0UZ0gihxYlOyGGfPRr8RAZatv+PBtkIHXmVbb7D
TsJ/e++/6uV6sskgNfBNtF/IXDBFFQ==
=Lxov
-----END PGP SIGNATURE-----

--+dXouVQVuDjdHA2u--


