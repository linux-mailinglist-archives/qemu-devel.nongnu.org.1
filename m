Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BFBAD5E0C
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Jun 2025 20:23:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPQ5b-0005Sg-J3; Wed, 11 Jun 2025 14:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPQ5Z-0005RR-GL
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:22:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uPQ5Y-0000oX-0s
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749666134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HsEpo4zBUpNZSU+Oa4erca8zGDP06kr91wfc/BCTQ9I=;
 b=UdDib4PoZDPha1hG2S/LRdfs3N9GhVc5KOzc9thU1RrBUVE60QupT+Rpr3LkNi+VjUw/ay
 /+Tu9scQzAhc4WDKRqp+pC9UcMfoh/g5nVIRqPUaMOP+tuvgTjjJ9R2uLGTzLr82etQUiv
 dgZelUrXIBbVkCYkrPEo62qL14JOhzs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-DT3EKGgBPIarOOtzZDx63A-1; Wed,
 11 Jun 2025 14:22:12 -0400
X-MC-Unique: DT3EKGgBPIarOOtzZDx63A-1
X-Mimecast-MFC-AGG-ID: DT3EKGgBPIarOOtzZDx63A_1749666131
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E83A018002E4; Wed, 11 Jun 2025 18:22:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C40C30002C3; Wed, 11 Jun 2025 18:22:09 +0000 (UTC)
Date: Wed, 11 Jun 2025 14:22:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com
Subject: Re: [PULL 0/7] loongarch-to-apply queue
Message-ID: <20250611182208.GA197498@fedora>
References: <20250610075350.865626-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ljIlcR1b0DPuRFss"
Content-Disposition: inline
In-Reply-To: <20250610075350.865626-1-gaosong@loongson.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--ljIlcR1b0DPuRFss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--ljIlcR1b0DPuRFss
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhJyVAACgkQnKSrs4Gr
c8hZtggAv6lYh6KTbec4NABPLBWNrgyZp+KF22Mu1g9kCNFVZVxjkbMFUtomo0V/
8igBcpbwr3P+X9/vFMrt9JU89gH5LyrZ/dAMA/EWcHmltVKYIX0rBzeIf5EI6IEe
lvZaZVRL68/rcT8KKYzkdPMyTHT2Y/j8ylYGmbMfBKhSwV0M8boHLFOOku1xopUw
vTLsckQmrHyScB53WNrCwA65Jpg24qfugWYCcQLNHfm/bcFltn3ev4dBm3Et9N5a
vGnX47aMQIKI7Q4dgBNVapptSXSPCFhcz6A34feDVB3xhvEYCn70VIexmcMaqNOa
4gvm3LyCZQkqmnmSbs3YyRNA3RYf8A==
=BO4o
-----END PGP SIGNATURE-----

--ljIlcR1b0DPuRFss--


