Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E4C7B5CAA
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 23:57:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnQuM-0008SG-LN; Mon, 02 Oct 2023 17:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qnQuK-0008Rx-3c
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 17:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qnQuI-0000nV-JJ
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 17:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696283809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bm9T/xXnvLXQFwT9pkJG9uApvL6yT+u3bgF0MTdlblA=;
 b=PBANxPgt7gRuUM39PusrAoeTKsjZakxy8Z5YuFA10o6wqKmjxtjGlivN3fmSEV1UYWK6WA
 Tji41fhaVLdcUONgCb/F6307ZRj9mHoWKrMynOrLhQC9oPRKYRq6YvPtX28TRSoJNUkJn8
 d2y/PGHQcIIiMnfpBatrjdFHyqMAfls=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-gc4BhFUrNVyCUt87381kBA-1; Mon, 02 Oct 2023 17:56:46 -0400
X-MC-Unique: gc4BhFUrNVyCUt87381kBA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A89528039D1;
 Mon,  2 Oct 2023 21:56:45 +0000 (UTC)
Received: from localhost (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 402152026D4B;
 Mon,  2 Oct 2023 21:56:45 +0000 (UTC)
Date: Mon, 2 Oct 2023 17:56:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/6] tcg patch queue
Message-ID: <20231002215644.GA1077555@fedora>
References: <20230928194156.237351-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MyHZ6k9Kc0vNl6OH"
Content-Disposition: inline
In-Reply-To: <20230928194156.237351-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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


--MyHZ6k9Kc0vNl6OH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--MyHZ6k9Kc0vNl6OH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUbPJsACgkQnKSrs4Gr
c8jK5AgAq5Ofnc//BWPibNh31FSa4VKNT++N6rQUaRt3Mfngt6G1ZdTPLd1ZN/CD
hx7mD+7PjVY+Whhya5XphbN6jWYCFGwS2F0suGm6+P0Zoh5jp9XUKyzgNyu2po/C
i/2VCPmBk+Pa+D5DgRtav27Sz6kEmRH7TAp1AkYvVbUhY5RLERlxTgAmLZ7X4wRk
2x569SbK9M9xR5SkOX+HdzV+ZnopDyER/BqdDB8nqFpPbUCyO7AkrgCOvPxhyPQi
9u/50/fLNz9Gd/FOrwuBcfGFRGWow/0C7keGc5YDPTffB7RDSk31hc/H8gPydOlR
7GhMiXrG78avzAKlPwdbgqpKbxnHmQ==
=+VES
-----END PGP SIGNATURE-----

--MyHZ6k9Kc0vNl6OH--


