Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3D8799E92
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 15:59:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfKwf-0000ah-44; Sun, 10 Sep 2023 09:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qfKwb-0000ZR-Jk
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 09:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qfKwY-00057l-1U
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 09:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694354261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d4b64Dd3L3fpyYWybJP0jMOmxwIGMDdUO2cCJvdws2U=;
 b=IvWE8ia7dmnz+UTI4VkVj+Iko3tN5O9aKuzFCJOEnwyuG/oJGwixBAtIR087p/33xL1B0s
 2c45CNq3lroMkOI8Pu+lOqpAA1PLg0jp5UONQvRELRShZrgXVPY2chbRJk5qpUKP/DCXZg
 6v9h++R8wYikNd5dti6u/3lclIxribs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-y-xBBpzTOje9fsSTI2t8vg-1; Sun, 10 Sep 2023 09:57:38 -0400
X-MC-Unique: y-xBBpzTOje9fsSTI2t8vg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A7E63C0256B
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 13:57:38 +0000 (UTC)
Received: from localhost (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D565A400F36F;
 Sun, 10 Sep 2023 13:57:37 +0000 (UTC)
Date: Fri, 8 Sep 2023 11:55:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/13] NBD patches for 2023-09-07
Message-ID: <20230908155537.GA3575192@fedora>
References: <20230908122625.1031340-15-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xvVi7LUbnt0H4lFq"
Content-Disposition: inline
In-Reply-To: <20230908122625.1031340-15-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--xvVi7LUbnt0H4lFq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--xvVi7LUbnt0H4lFq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT7Q/kACgkQnKSrs4Gr
c8h+pQgAicEHFF0oQT3fXWhyCDbW3/LWJjW98c0+w2k0yY3s1OJ4lHyh1k1c47u3
D3IpU+755z3NB/7isOeDYJKfol8sFbNJn5gFyQimey94r+y5FFjWwfyUB73Rp8AI
ZjvkGMVBQV5HyrYwlJwje0eT72p7oeZ+vMUG6s6LqHQWRmDEhMLCiX8MbMf5iRIH
Yw6ll1nqyHLgol6fn4c0NlazETNuEhEcVw+NlcFT6UYcmvFCXTI3Y1Py2RLNaPuQ
9vhHCEBiXXC0z1PyCBLMzNDZTYBncXJGbHAR7kJ2otGaZl6F7ElSAul8PbuBb2yb
++alHpf3F6UoksXdrGXWtjqD9YyKDA==
=iAit
-----END PGP SIGNATURE-----

--xvVi7LUbnt0H4lFq--


