Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C82B9A7C220
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Apr 2025 19:09:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kWj-0007ec-Vg; Fri, 04 Apr 2025 13:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u0kWh-0007eH-Q6
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:08:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u0kWg-0005Ep-6v
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743786497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NWV3oh4kpdX2uS45BQAYF7d7mCFCPebY1Zv9x98pKtI=;
 b=ZjRg5KB/GBdkbLzeJ6jnr38Yx8xZYt+ribB70r5GvhreoTvvGrBcSTkkzAKhOjNW7DpvLL
 JL1JgQQ3VXU2Ojc32ikDBl/CyJ6YUHtkqGNwK6obpukWH+R7RfUxnFzOJdb1BW2SeNO3Tl
 Q1OnXMsCaBtur1ESIdrMcun3XqwN+gg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-xpDGOtVpPX6dhEH-0zetjQ-1; Fri,
 04 Apr 2025 13:08:14 -0400
X-MC-Unique: xpDGOtVpPX6dhEH-0zetjQ-1
X-Mimecast-MFC-AGG-ID: xpDGOtVpPX6dhEH-0zetjQ_1743786493
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2222180025E; Fri,  4 Apr 2025 17:08:09 +0000 (UTC)
Received: from localhost (unknown [10.2.16.156])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 87B1E19560AD; Fri,  4 Apr 2025 17:08:08 +0000 (UTC)
Date: Fri, 4 Apr 2025 13:08:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/6] tcg patch queue for 10.0-rc3
Message-ID: <20250404170807.GA378981@fedora>
References: <20250404010930.164329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pV2uxd2sjRMyh/o1"
Content-Disposition: inline
In-Reply-To: <20250404010930.164329-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
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


--pV2uxd2sjRMyh/o1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--pV2uxd2sjRMyh/o1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfwEfcACgkQnKSrs4Gr
c8iMwwgApyLLNeSYKr3+X9uQMyhLzXDyUHy1hQcbFXpue9P9BpgvKfia8IFxuFH5
fVMnNSQK1WWWmXcyN5bsxX56RpbFlNU2V9H730FGqcSbnbOAGgGIlMuKpbndUS8S
9MTpxTR+8Yjdj/dQSvscf2cjHvMwu2srClErT0tdEUs0vEDaW0HTjCipX00JU3eV
mqKhFdUfii6ZwtyKpKhFg1sTVRSTVpKYEO/j6aByCw2mF27jl911HlkxsZQCAEjp
n6mGmeF14rlgpHAH8NmbGrdZ/UqrXeh7XW8i9Y0ULsIKXDqqudY60KAR8ksNXJOd
FUJFb4iZW54FErDQdYR3HVl3W2OQaA==
=f64r
-----END PGP SIGNATURE-----

--pV2uxd2sjRMyh/o1--


