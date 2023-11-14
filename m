Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B53557EB58E
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:35:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2xIS-0002l1-OS; Tue, 14 Nov 2023 12:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r2xIP-0002kV-BC
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:33:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r2xIM-0003WA-Qc
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 12:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699983227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MZwSXNXnfPVjJfXOKlDxEgLrBgbfVfuneuVsFxXMuV4=;
 b=Bkd8VNTTJqnT9WP8v+HXzaq5q92aJh00jWfP9cPaCoFuSGwvro3Cu1bgXmcV7zeD1ttmBe
 N/9kzl7zpH7ZtWslbyUmr0fKIF5x5VgtJZtgx3VnOIgIeOz95wGBVg/gOUifxm/d7WYua3
 IU8xdsKzmIuH36G8yD3/GeVvnuGVQl4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-y7QpyT9TOaiAqce4JSBT-w-1; Tue,
 14 Nov 2023 12:33:44 -0500
X-MC-Unique: y7QpyT9TOaiAqce4JSBT-w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 867F938130BE;
 Tue, 14 Nov 2023 17:33:43 +0000 (UTC)
Received: from localhost (unknown [10.39.192.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 033DC25C0;
 Tue, 14 Nov 2023 17:33:42 +0000 (UTC)
Date: Tue, 14 Nov 2023 12:31:30 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/12] target/hppa: last minute hppa64 fixes
Message-ID: <20231114173130.GA273934@fedora>
References: <20231113173237.48233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="j3alfDw1R3+1m+i0"
Content-Disposition: inline
In-Reply-To: <20231113173237.48233-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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


--j3alfDw1R3+1m+i0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--j3alfDw1R3+1m+i0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVTrvIACgkQnKSrs4Gr
c8gP6AgAjT4NpLITWaFjOThOM+K1SWvjXCTHD2kBmkVArp6x1+kW6qgfUymwF9Ey
YXatz2lCiRFz2O08zzHnhKvNl18KdlSifyDStCqnOb2ksDjr/OCtxnbE0vGs4fHK
yQjtCeT7yYiOKTS3C/o37/PJ56O6JsycHZ/cTo8e1GXyeUm5Q6kzdNcooOcy28C3
DlK8wevZ94tf5SLlGvdndWpmXXesIM5eJQJrEDzIenx5CXLmZaz1YqE+sYO4Q/+Z
X2bxfQJIuPzmK3/6C5qz8UFObtsKP8BqOKikSxc0dqIkPeUhiUChDRyLn/cS+1TJ
F8BdVvR57gGVINkbF3iRFm3smTvoSg==
=WS1k
-----END PGP SIGNATURE-----

--j3alfDw1R3+1m+i0--


