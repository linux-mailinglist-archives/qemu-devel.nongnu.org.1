Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6021C7DC7BC
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 08:56:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxjbq-0004jj-Dy; Tue, 31 Oct 2023 03:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qxjbo-0004j4-4X
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 03:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qxjbm-00031S-Ou
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 03:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698738978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tLiRX4WYzsRaWmXa/wBlaj4NZ5A2coozuJNIyzvKgWg=;
 b=V9CW1Ht9Qi8KAEaakn/r9d8HkBWGpXgKvrjqGUyKEJD0aUiic2NAdivh1Ig72uaoyWd27f
 lv11x3vy5rjvO/ntMEGxMrpj5ZP11d67xHP2nMU4c0Vh4kfYDAx9oYxuC6831pqngJhhCL
 04Cp+a5ZeozqtdGJ7bAA6Cc3ufjwr3E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-DMHFcepDN526dLEIlzVB8A-1; Tue, 31 Oct 2023 03:56:14 -0400
X-MC-Unique: DMHFcepDN526dLEIlzVB8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCA89856F61;
 Tue, 31 Oct 2023 07:56:13 +0000 (UTC)
Received: from localhost (unknown [10.39.193.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B6115028;
 Tue, 31 Oct 2023 07:56:12 +0000 (UTC)
Date: Tue, 31 Oct 2023 16:51:01 +0900
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/21] linux-user patch queue
Message-ID: <20231031075101.GA644073@fedora>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JlDU+Cmf6n3zFrcp"
Content-Disposition: inline
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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


--JlDU+Cmf6n3zFrcp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--JlDU+Cmf6n3zFrcp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVAseUACgkQnKSrs4Gr
c8hS5QgAx3aWB56H1OjKGzTT8yS6hyv45+zUSf2miLQX8hSQdNOxHAKM6QYA56qc
fT/Wo5jEP+h8cOciAgvtWpedPOlaYGEr5ZheYs0zgeoPjZ8krtM3mxLZyRPKJwYI
IWI7ByL4b/uEdRANZQ9ZaOApY8eXH/M05/UyiUmgoeDlfGYZpjbkqGisc5B1t+4e
1xjGsp/WjEmh8iffHjN+KVL8tb9sPrxjk6YnpPYidBIDdxSKSa5+SJmX2OyptMwo
3Rin3ROynKx30WKIoaFw16kpdOc1MkNgb3M7yD/OEwkIjOR/OM6Into4iGA+Au+7
Jp6DLLXfxm3MC7bWH0GuFJvdwjBpAA==
=FXTq
-----END PGP SIGNATURE-----

--JlDU+Cmf6n3zFrcp--


