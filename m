Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB077A514B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 19:53:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiIQK-00027t-Ar; Mon, 18 Sep 2023 13:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qiIPt-00027L-01
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qiIPq-0001HD-1e
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695059528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qe+MJwl8Al2/GDzcYSj0t4D1q4zs3OV2hb2k6m2xAOI=;
 b=OU/AFst5fqrr8HhEAeGSZbGaIJo7fXVRziN+DeddcUV6LAPu3LPSjo+6fF5GiPAhx49E2K
 Q7PhwerY2+Ru5QS5Gb87UJ1uFDdhFnv7qFWxBdUB0lsT6fOQKJo2xIo1DeSuFJq2hhVoj8
 If2BZHOQrh3yICaWno7rRPWSeCuMSVU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-aahNUPbGNzaNNmBik9ixeQ-1; Mon, 18 Sep 2023 13:52:03 -0400
X-MC-Unique: aahNUPbGNzaNNmBik9ixeQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DC45858F1B;
 Mon, 18 Sep 2023 17:52:02 +0000 (UTC)
Received: from localhost (unknown [10.39.195.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A94052156702;
 Mon, 18 Sep 2023 17:52:01 +0000 (UTC)
Date: Mon, 18 Sep 2023 13:52:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/19] crypto: Provide clmul.h and host accel
Message-ID: <20230918175200.GA1454109@fedora>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TriX+uAzxGVeAHoy"
Content-Disposition: inline
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--TriX+uAzxGVeAHoy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--TriX+uAzxGVeAHoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUIjkAACgkQnKSrs4Gr
c8iqBQgAnGz1fA9CeYS6NV7GgGLsdzOZHu927FusvCLejfBNJ2HQWTA6T5/BVXdG
we25/j49OMkk+0Sj/ypmvziP0Xm40k7XaWTMEo2mDyKe5ZMIUSLdaeSrS5XCP3pg
HHIQiHwm6OGDHxlz9eudphAA7ruSNWSLMWKWLudVfdj0mZOVqU1s4WIWkrCnUd25
mz1BgZsswElNfnatxgmwn2rH986MCPbpZ0MfVYZGnoAKv+F5cLzz9iK7FMCkc1CP
Y1siGx2JG6ho78l4fXYyhU0ZbWOFolxh5Wh64wqCm3CGSXtp9wJhHdkldit8v47q
GS4qkKXDzIAWi8uKkEAwbct3rpgpYg==
=0QTk
-----END PGP SIGNATURE-----

--TriX+uAzxGVeAHoy--


