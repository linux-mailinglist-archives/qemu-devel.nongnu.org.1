Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3B5787431
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:29:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCFh-0006U8-2v; Thu, 24 Aug 2023 11:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZCFf-0006U0-FD
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:28:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZCFc-0002gR-U7
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692890879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jqM/JhB67ETwF7aoquYKzAnW5Dv2SRv0OH9GEbpR1cQ=;
 b=N3VkuaKq3jS0VOhhFMId3LJ5Mjgy+m+AHL+hXllYUi9qm+r61BV4vq7ZgfsGTE6wsJZDGp
 kyeIVDdTMcb3KUE8uvTfJqL/QZo+FSVX4fnkS0Vyg4lTil/4CDyY4EugSLmH8dniq016Bl
 i5wBot5MKFleHam5X8CvpH9l1y90kG4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-y5aMCUtAOJqAepJCvQX3Gg-1; Thu, 24 Aug 2023 11:27:56 -0400
X-MC-Unique: y5aMCUtAOJqAepJCvQX3Gg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52B34805599;
 Thu, 24 Aug 2023 15:27:56 +0000 (UTC)
Received: from localhost (unknown [10.39.194.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B58C7140E917;
 Thu, 24 Aug 2023 15:27:55 +0000 (UTC)
Date: Thu, 24 Aug 2023 11:27:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
	richard.henderson@linaro.org
Subject: Re: [PULL 00/31] loongarch-to-apply queue
Message-ID: <20230824152754.GA1606765@fedora>
References: <20230824092409.1492470-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MMOD9UR4u7HwmrHN"
Content-Disposition: inline
In-Reply-To: <20230824092409.1492470-1-gaosong@loongson.cn>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--MMOD9UR4u7HwmrHN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--MMOD9UR4u7HwmrHN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTndvoACgkQnKSrs4Gr
c8hANQgApsSmbblogO/sWosUGxEbUFEiTzsP3K1P1Dk8s4TAwBjPo8rQM7sSvDZ+
GIgEvzs2q5nzPvO38yEijR2PYcApex5i0XFR2aEEjTVOeaJvl0lycPl4tTrxFwIy
tG8TTjxpSmbEJI8mIwEtJUvBEnRE1Z4Hpcf8arx1aURYEX3S78a/7G9wRzf0fivN
3UrUysfMMzMC/UTsEec6gzHeQOjm//1reawTwnur1vn+yIn0TtPphinEijpQs78g
7gTJqErBgkvEKfVR5sK29serWx/4YcO3imIQo3HFmDL4Im6B8fPym91kDnf6XFhu
k9kQT+IJI0t4aa62sgeccZ1gKl6f1Q==
=Loew
-----END PGP SIGNATURE-----

--MMOD9UR4u7HwmrHN--


