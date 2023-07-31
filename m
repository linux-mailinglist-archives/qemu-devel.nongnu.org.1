Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DF876B8C5
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 17:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQrSg-0007Ir-4i; Tue, 01 Aug 2023 11:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qQrSe-0007Ij-Gs
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qQrSd-0002JS-4a
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690904338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQnEZicL3B4jVEN3X3EzzjS5H/PG2wtQtTIE5Ywlvwo=;
 b=K5IyBGi6lF/TlxfvPAAzwbHh8JOc7XpyW7Y9ojVmAuqydx34TdaM6kEBm6aitmKmrALsPX
 dUwoYXF9bBMj2Ox8iodYTNJhtzIY8Fw4B3Q+6kIHtM7k4oMFurlStNSuoby7FkEp2oLKk7
 TOVgqQ11Ga+iSK5Z7jdETDyqHkTeyP4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-NBrugrnqO5Si1tv3F-qfvQ-1; Tue, 01 Aug 2023 11:38:54 -0400
X-MC-Unique: NBrugrnqO5Si1tv3F-qfvQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08BAE1C2C5A8
 for <qemu-devel@nongnu.org>; Tue,  1 Aug 2023 15:38:54 +0000 (UTC)
Received: from localhost (unknown [10.39.195.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70DF12166B26;
 Tue,  1 Aug 2023 15:38:53 +0000 (UTC)
Date: Mon, 31 Jul 2023 15:15:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Alex Kalenyuk <akalenyu@redhat.com>, Adam Litke <alitke@redhat.com>,
 qemu-devel@nongnu.org, kwolf@redhat.com,
 "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: qemu-img cache modes with Linux cgroup v1
Message-ID: <20230731191527.GB1281379@fedora>
References: <20230731154036.GA1258836@fedora>
 <ZMftO2aPh9YOu5R0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ShuC8vWVFodWiywl"
Content-Disposition: inline
In-Reply-To: <ZMftO2aPh9YOu5R0@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--ShuC8vWVFodWiywl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Daniel,
I agree with your points.

Stefan

--ShuC8vWVFodWiywl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTICE8ACgkQnKSrs4Gr
c8hLBggAt+XOREdud9Z+//U5ZekgOyzhv5zEmsPi0YCDGcmj14pb3Ftk1x0qRFWh
NAPtL+QPMdsXWuyvjcOQxdVao4tb/k7rqh3x4kBjdHBcdX4zASWjfXtCbSarPleN
u455eRpTVreuDJulZcR7DWsXW1Gw6/sDEgG4RzRFplp9LRgqxBzzOwiMMcFu/Tsv
OzELenaxqW0I+NuDsz+te9AisURJHQE0Ck5xvp02NLJvEEZgsSAzcjkGLv4TnA86
xw1vU9xr6vcTWejVLywcEWPrsmmqm/jjAPpTn01Zqs2KdyP1jifDMDeb//C/mUam
yRd+UxLznMA6SXQOqVYFaRiZ/eN8qg==
=9eJ9
-----END PGP SIGNATURE-----

--ShuC8vWVFodWiywl--


