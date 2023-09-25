Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B17F7ADBA0
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:37:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkndK-0005Hc-6P; Mon, 25 Sep 2023 11:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qkndE-0005FA-RJ
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qkndD-0001PQ-99
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695656178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sk0zlzV5cx4Yq30Y7cxfg8O7p/Az48Q0fFvGCfBgVjQ=;
 b=S6llIvq97328G04z95gIwXrTFyh6ZGZqxjtBcD+HEPEesfmQrzADT8OdBgu8D1H8aAcDGW
 ZdYaMDBP6EyhZzegSgZ4ni5DWHYRWOcrH5AlioVk2PusIPzCp2VDQ3VyNXU9PZ3B0DF1rU
 AxbuMiGXlzQsLavCvqyYZ4eb2TYUS+s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663--v6feFYdNumefS0wxLLxtw-1; Mon, 25 Sep 2023 11:36:14 -0400
X-MC-Unique: -v6feFYdNumefS0wxLLxtw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E6BE185A79C;
 Mon, 25 Sep 2023 15:36:13 +0000 (UTC)
Received: from localhost (unknown [10.39.194.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B00F1140E962;
 Mon, 25 Sep 2023 15:36:12 +0000 (UTC)
Date: Mon, 25 Sep 2023 11:36:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, balaton@eik.bme.hu
Subject: Re: [PULL v2 0/9] i386, audio changes for 2023-09-22
Message-ID: <20230925153611.GA309781@fedora>
References: <20230922154228.304933-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Yw0tkoRieeYLaEfv"
Content-Disposition: inline
In-Reply-To: <20230922154228.304933-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--Yw0tkoRieeYLaEfv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--Yw0tkoRieeYLaEfv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmURqOsACgkQnKSrs4Gr
c8gKKQf/XMAi2sYek2JbEH11IAzvNewYYSeJkJ8TA34b4iWXaM1KI6qKcM8t2DP0
4+2RGCTcwDmPtCSIyCzfWqUtte6e0LRqLBaWJiaCsFu/PdxR5rnIg4y0S6/VXm2Y
RKz+KzZ9o2S8fs9jqLFPE9q03Nn/6lbBPGeBrzHJm+78UpzHkYC/U0m/gPwZBZjl
vFQBNRWvQsRfXR5D1Ed5mjBTFMefGtE22i6F/vrGPNuekdv14SW0oJSUIHzPbA8o
4n7a0pAjvpWonlAtRkhySzFSDjT853KWsSsK4VwmxhcTV8kkNTBWagWG3/zbIdgQ
VpAwaZkwL687O+ch24jT30LnCGLDcw==
=L8tf
-----END PGP SIGNATURE-----

--Yw0tkoRieeYLaEfv--


