Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC485A4C003
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Mar 2025 13:14:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp4gD-0002qE-Fe; Mon, 03 Mar 2025 07:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tp4fP-0002dn-TZ
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:13:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tp4fO-0004UT-5p
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741003981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SnPLu4ytelhOgOSZTxn0cix7dS0dpd6MRuFU0iqoYtU=;
 b=J8Rn71ACOugo+y1/C3ygakEzCkIZXn7IxsqDO3Ir0wLnWCy/LryDxk2rv/3XUM4r5qcm4y
 Bk+iLhBf9R/j0bihrtmN3c4X6q5y20nmOq1vvsc3A6HWZJdyVn/tPjxh4MKJn7AXBmlxc5
 A+QXJn7/PLO/7deo078ZnoL/lW2H3mg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-gQJYjxL-PuWaw0uFDQ_Pvw-1; Mon,
 03 Mar 2025 07:12:48 -0500
X-MC-Unique: gQJYjxL-PuWaw0uFDQ_Pvw-1
X-Mimecast-MFC-AGG-ID: gQJYjxL-PuWaw0uFDQ_Pvw_1741003968
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AF0119373DC
 for <qemu-devel@nongnu.org>; Mon,  3 Mar 2025 12:12:48 +0000 (UTC)
Received: from localhost (unknown [10.2.16.61])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CAF821956094; Mon,  3 Mar 2025 12:12:45 +0000 (UTC)
Date: Mon, 3 Mar 2025 20:12:42 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 00/18] Functional and other test improvements
Message-ID: <20250303121242.GA215655@fedora>
References: <20250226095731.1172375-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Kyqc6BxSmZW/+d51"
Content-Disposition: inline
In-Reply-To: <20250226095731.1172375-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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


--Kyqc6BxSmZW/+d51
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--Kyqc6BxSmZW/+d51
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfFnLoACgkQnKSrs4Gr
c8gm6Af+IJ4B8n71k6hVP6TV+sG3x4O9c+Ii9aK5xOov7KaS8B4+vytz3EFtz7uS
E8KEJVHSlZ3Ie/3fAuwsOA4qsBhDhzYFtyH5OzDeYiLYf+K3kOk9IZi78oOD9Ej1
vjhEaWRX7M6GqvikvZ8t4ZIHqt6ckcAudKqZgnQUlTrRaNXw3HH5JpVeEkJWU0GM
FV1fLCPn9sWPuk0oX5+ZUtbg+6uGdcgSUOxUPmiczDPYxFIs4TtShF2W1vcVd6vK
jJi8+jmFmfKD9IDJA0Sa+C4YWB3CZvKYkIqibGle/pU9rsZxVPdgzaToJUzDXEVt
aP+yYQlHmP4hqG1Wfg6nJl0HY3LGBw==
=wP06
-----END PGP SIGNATURE-----

--Kyqc6BxSmZW/+d51--


