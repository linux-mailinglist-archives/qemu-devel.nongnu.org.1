Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 047827CB346
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 21:20:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsT8o-0006dO-9J; Mon, 16 Oct 2023 15:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsT8j-0006Xj-Dt
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 15:20:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsT8h-0005WJ-GU
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 15:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697484030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a9kmcNNnPGztM/vl7Z0HYbwp+CzoUTkbOPRLw0nCZ5g=;
 b=ZWEGpsOsMO4OZt4hbqebE7T5OGgDnVDHxg9w8TdmVWaXVwpEi5j/AfuyiiG2SQFdu+qZI+
 8oz0J5WDppdtAwwppVlp1xCWJuElK+0xIEHaQcsg7JH/FUWOGsh8XRzXxsk81N6xj3nCIB
 JRsc3DR3uLaEGKUkXiAQ14rcsssWrWI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-tgCptGnCMyycilqEyvU5PA-1; Mon, 16 Oct 2023 15:20:28 -0400
X-MC-Unique: tgCptGnCMyycilqEyvU5PA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A359185A78E
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 19:20:28 +0000 (UTC)
Received: from localhost (unknown [10.39.195.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 063D4492BEE;
 Mon, 16 Oct 2023 19:20:27 +0000 (UTC)
Date: Mon, 16 Oct 2023 15:20:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/7] Misc patches
Message-ID: <20231016192026.GA161257@fedora>
References: <20231012165108.913443-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KTux9gHX91diIIhp"
Content-Disposition: inline
In-Reply-To: <20231012165108.913443-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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


--KTux9gHX91diIIhp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--KTux9gHX91diIIhp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUtjPoACgkQnKSrs4Gr
c8gEBQgAkTxTV9OBG9bLaaN/CUJL3E9LtbTkdsyBSCmvbXWDwJ05NUhPGOjgAQEa
5ns8GMBe2nMNYHZtY4PnZL6dswV11fsfx65ooy7juj9qEdpx9ijBWJ2Ws70Phht8
Rxj49DVGWRMyaSWSXnqSALLc6XzDYNEt+rpLsth9uOvGZVRlVBAE1bm5DpdrDvhU
5v4X4GFP79B75C9VRJvwhOS05AZRynUDlK1XlpYJm5yvktOH8EMXPRIXoHrj8cNc
3XmRx1L4bvGdmSCYUywzPNUhWCx6yU+pZBvLdkJyDO8/AJMb2OS+RjZ5ju3FwYtT
egm3S1N1O3/ifJ/I6bZ8NLoy8bpmTA==
=6/zW
-----END PGP SIGNATURE-----

--KTux9gHX91diIIhp--


