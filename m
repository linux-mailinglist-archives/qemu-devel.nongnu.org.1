Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DB1A561C0
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Mar 2025 08:28:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqS8M-0003Gg-FB; Fri, 07 Mar 2025 02:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tqS81-0002zV-CO
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:28:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tqS7y-0002Jb-O0
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741332493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yCK5LsQ4T0ctC0GXc1xYeuqmX7YkOeoHvduBY8XRX7s=;
 b=f6NUkS7X6ZgR+ygC3mcXYOIFN0JqVbgjN2Klls1lkULSXbbzKOs8oBioKXX8bOSTPbAqMW
 kN9P8TZ/eVqF4hwbIg3gqZ/OoBj293OwWkdkX5YjzfqWzOYOkTPdf2Mx+3Eyi6PCh4bidk
 KPrHNjMuL7xLqEtEEL5oo+lHPxT4SIk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-VaIHdiC4OXSmEBCyfPPrcQ-1; Fri,
 07 Mar 2025 02:28:09 -0500
X-MC-Unique: VaIHdiC4OXSmEBCyfPPrcQ-1
X-Mimecast-MFC-AGG-ID: VaIHdiC4OXSmEBCyfPPrcQ_1741332488
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5572D195609E
 for <qemu-devel@nongnu.org>; Fri,  7 Mar 2025 07:28:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52E6E18009BC; Fri,  7 Mar 2025 07:28:00 +0000 (UTC)
Date: Fri, 7 Mar 2025 15:18:42 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/42] vfio queue
Message-ID: <20250307071842.GA362082@fedora>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GRcAEBbHZ1nhL9jM"
Content-Disposition: inline
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--GRcAEBbHZ1nhL9jM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--GRcAEBbHZ1nhL9jM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfKndEACgkQnKSrs4Gr
c8iELgf/XI59QLJdjcOypULiNydmBwaP86Z0i0TseYj4s12MBbzF1NwlGUMOKtHH
JsRDVssiuw8wjBZ4HLO7p3R2TC9bUBnjY2ftj8ETIRZU6TuoiQF0vkm1TLDIyeFm
PXT4Tavipmm+yhmeCIWj9Iblbz/4PqPUHPHElhxeIIyeDdkD1cbO+LywphLRCWtB
sATaPJPRpn0gRQjtIVMvn+5tMT0IhZ0PKx2OEbgtekd8Q/ix7zRaqhiydpfv+jj4
magRD6kLwhV5xxMH+d2r5gmsqWFufN1gVPbAzLujU7TWuJtM/fKaDmDnumJI2zbr
T+LEj45HXMGLoTkNZmEU4Etse1llhg==
=2dN7
-----END PGP SIGNATURE-----

--GRcAEBbHZ1nhL9jM--


