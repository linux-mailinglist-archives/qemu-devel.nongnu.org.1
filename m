Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DB97BA387
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 17:58:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoQil-0001VJ-Ez; Thu, 05 Oct 2023 11:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoQig-0001Un-3D
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoQid-0006JO-M4
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696521414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=crnUVyzz+T4FdpXyz/kAjNWC17+6KCD9D14jZh/k0Kg=;
 b=SNjH4Zb2iT9UuvqK6DFFKJkUEiWoMIbQP+kakc5nbdoE+bnLpvmPAx/J9Aj7lpLnD4z4J/
 a48qAnLXUZicPupTKE76nDaeIVKImI068RozLLSvVS8F+nolGVyrQvspygQIAYH2uV4TrY
 zDXEOdUatO/WA0GVdlOLDqOkcQfqTts=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-x9DzBHRWM3SuWKHXuwI0HA-1; Thu, 05 Oct 2023 11:56:42 -0400
X-MC-Unique: x9DzBHRWM3SuWKHXuwI0HA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2383718175B4;
 Thu,  5 Oct 2023 15:56:42 +0000 (UTC)
Received: from localhost (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F574140E953;
 Thu,  5 Oct 2023 15:56:41 +0000 (UTC)
Date: Thu, 5 Oct 2023 11:56:40 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com
Subject: Re: [PULL v2 00/47] tcg patch queue
Message-ID: <20231005155640.GA1344708@fedora>
References: <20231004183930.1882948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WVO+4+5LctyHuml9"
Content-Disposition: inline
In-Reply-To: <20231004183930.1882948-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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


--WVO+4+5LctyHuml9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--WVO+4+5LctyHuml9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUe3LgACgkQnKSrs4Gr
c8g2qggAv+gf8wTfjv7MVXZHiqMtSnsEmbxnhzAHLNQYp83/CjTLdPIqgJmEKvst
cZpiI0RR/vfxhoa8eTP73nXUMNKeLYlrEtv4WQcwpy79kZie/XRC6uijInxRYagE
5pQRltmjjeHQFGm/6Gx3F/kp/j1sanEAObZVSMS1SUcfbdVVUBuONdTnZ7MyIZcP
8X5uh1E1MTrGE10lL1YEKh4B9xTuGRFZCslkA3TVJg/RCJ+IHO3q0PiGPg8rC4Ub
5BWrCYJ9L7NVwYtVv0ZU/S3zpd+Qyl2RJBRze/t3u8XlW+Tl17ZoVhRJhjjpwaKs
BjenK/kIEnpsN6jg3v7jY7IRNCYzdg==
=LAog
-----END PGP SIGNATURE-----

--WVO+4+5LctyHuml9--


