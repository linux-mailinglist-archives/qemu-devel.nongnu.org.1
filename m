Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4C0B120D2
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Jul 2025 17:26:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKIT-0007Bj-RN; Fri, 25 Jul 2025 11:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ufKIN-00077C-Tm
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ufKIL-0005db-Q5
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753457111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5dLpjxeUKPYgnKyDtTgUuTUvqXNzs0qpzNnyd3JFIoY=;
 b=XVP/0j3uaZUGekcLd6mEJNi16/VTtnZ9QoqS5QbbQ8Nx4og/nKY7Lb5fU3/tK8BfDhQXSG
 78Y0Svmx+mH3vu9Xzq0wbNnc2MixsgnwU6t02rhmaivc7VNdqtI8ICPBJ0gbn4zc/WEkhb
 Z75f6hGBS9KNN0jIauk0dOkXOO+TiE8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-D3To110GO-O9XXgAqi0v7A-1; Fri,
 25 Jul 2025 11:25:09 -0400
X-MC-Unique: D3To110GO-O9XXgAqi0v7A-1
X-Mimecast-MFC-AGG-ID: D3To110GO-O9XXgAqi0v7A_1753457109
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDACF1892D87
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 15:24:58 +0000 (UTC)
Received: from localhost (unknown [10.2.16.248])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A78A195609D; Fri, 25 Jul 2025 15:24:57 +0000 (UTC)
Date: Fri, 25 Jul 2025 11:24:56 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 0/7] ppc queue
Message-ID: <20250725152456.GA603960@fedora>
References: <20250724133126.1695824-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HVFlQYvmId3e6qOC"
Content-Disposition: inline
In-Reply-To: <20250724133126.1695824-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--HVFlQYvmId3e6qOC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--HVFlQYvmId3e6qOC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmiDocgACgkQnKSrs4Gr
c8j8UwgArh4zvNVp2646N1YZQDmHbb9MuytibWEAHXVd+YmdjJ9B6FFFkoCPc2gF
x5t6g7OvjNdFRHKxLZaNSQvTEMdTFjkF3/mkGFIL5PjI2QLa297JxQweBSRg1sY7
IKc0IJaEWFItt8fCfXmVJA9TLb3HPyFHujhMlX5NuVvsB00nCRXmB63U1p8lBq4c
/gJeEn3RT3IVZQmYY7Xmp22cMm21qlJbcpY7Cmlgp4Ft/Kf9/urlmCqHctKoeigc
Z4U7RZOPZyeC7ImzuHlHAz652Ei0xRKNM34ysWYYhw+hDMA0koqp/eVzGS0db6sk
xUuIEt5tenJ5rEaeosK/Ib48ca7Yug==
=BI1X
-----END PGP SIGNATURE-----

--HVFlQYvmId3e6qOC--


