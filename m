Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BE4A6E32F
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Mar 2025 20:18:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twnIu-0001SU-7C; Mon, 24 Mar 2025 15:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twnIr-0001RU-Q9
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:17:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1twnIp-0003zc-JX
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742843857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oLzZbC8k88ywq5bBxcH/9o+u30/By5ATbxfGMW6iYwI=;
 b=MBTowUl+mFlwTP2q8Dz00S0jm2R+ZvOlsIh08UTJuup2sbJsjRO7izgeYQaLtBE6Zc+l5P
 uBdyBTZ4437HOtevh4QJIrhuFhFy55H1DSDyagx29A2jBiWpwPFBNuMNeP0SgqIFVBe6mS
 EE5M+sPUSBmvkafnVDYYySaNXWBO/UI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-LBjhT8D_MtqUbY9tQWPndQ-1; Mon,
 24 Mar 2025 15:17:33 -0400
X-MC-Unique: LBjhT8D_MtqUbY9tQWPndQ-1
X-Mimecast-MFC-AGG-ID: LBjhT8D_MtqUbY9tQWPndQ_1742843853
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E91A9196D2CF; Mon, 24 Mar 2025 19:17:31 +0000 (UTC)
Received: from localhost (unknown [10.2.16.139])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 81C101955DCE; Mon, 24 Mar 2025 19:17:30 +0000 (UTC)
Date: Mon, 24 Mar 2025 15:17:29 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 0/3] aspeed queue
Message-ID: <20250324191729.GA76777@fedora>
References: <20250323174541.406860-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SQWSzCYHumHknuLA"
Content-Disposition: inline
In-Reply-To: <20250323174541.406860-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--SQWSzCYHumHknuLA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--SQWSzCYHumHknuLA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfhr8gACgkQnKSrs4Gr
c8jxEAgAxc/P42e/xq0w+oYTxS3kIoVqFOyKqip20qMemoEU10BYC+/54cXokYO3
4VaHSp4348oK5bnx6Q4KXBReJeA5HQXK3kYscIulcXGdbTgT26IkKctRX8dlFLRF
wB68+90/d3CsUktgygihYebxIPO1s2GmnU9Jpjkdi+sdsCQ4SjHfa1tEGygAZ/fi
VViL5LSSGDqaSHECjvQxfZbD+yeEUeLFeYXOLicjLuKXIH0kudr/wkq0dgiLEkcg
6boozb9j6dwSuCycngxSOG0tU34exlst4IN8GTW1xdtpXWnz2cGhF5IBhSdHwbSI
/zwphlw+RSfP6f6WjHlJL+hU51Qv9g==
=p2eC
-----END PGP SIGNATURE-----

--SQWSzCYHumHknuLA--


