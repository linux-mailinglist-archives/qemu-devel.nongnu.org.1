Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0917F7A957C
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 17:17:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjLQT-0003wn-0V; Thu, 21 Sep 2023 11:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qjLQC-0003qs-NQ
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 11:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qjLQB-0006BL-76
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 11:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695309409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rf4fQBTi41eXwGibyGah6AZbjsA4T8VWLKjUMXBFxpc=;
 b=b7dpFSW+tVmdJBeFNgwdliCfh0oMgA5JBwsQZbiSueFsar5EAr0lw6Vd5YnSF4WBH7PzV1
 /FKRaE8fcglhUwPqDEVHhv4S/PHRRXSbrvGKA187lq/0qOgHEx2hCxm31Oz5huCOqQUTT7
 2o/Tw/rksgZEmUe7Af5g1BZeyxxvf7Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-dZ4e2kRgOKWMDPVUQ3Ohcw-1; Thu, 21 Sep 2023 11:16:45 -0400
X-MC-Unique: dZ4e2kRgOKWMDPVUQ3Ohcw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AB33101A529;
 Thu, 21 Sep 2023 15:16:44 +0000 (UTC)
Received: from localhost (unknown [10.39.195.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C65E22156701;
 Thu, 21 Sep 2023 15:16:42 +0000 (UTC)
Date: Thu, 21 Sep 2023 11:16:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-trivial@nongnu.org
Subject: Re: [PULL 00/17] Trivial patches for 2023-09-21
Message-ID: <20230921151641.GA1120616@fedora>
References: <20230921083506.509032-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VeUcQCU/fqKVyFId"
Content-Disposition: inline
In-Reply-To: <20230921083506.509032-1-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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


--VeUcQCU/fqKVyFId
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--VeUcQCU/fqKVyFId
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUMXlkACgkQnKSrs4Gr
c8iGGQgAnLgEBIHmclsFW9pifVUTkljAD+1i7oe81ehPnA788UFl67vmUv2MEskU
huAGcZNKHwmFLM14ztQ7nSaG2qNlQnM62ANaEoYSkIux1kAcc0IIeIvb2eyB8njS
7cmsARJyMypObE94xxfjgHmdeyzA2asio/8MxSzI6kPJzks+kP3yuFpp8E1lUF7I
Xrj39NeOdDRw5xiwy6lBENRbhS+phfUXSIitU9ZFuMVs39fqekD1tELIe22ApqrB
YYZvFh/sfr6EeLOq7dHlj8GrfpsZ7Lk16/CaiLyk703KBnNjbyWyO/sTFd5Z3q/S
Rj3ty7cbr7SBFkKGE3YK00cVAo1PaA==
=mUJ+
-----END PGP SIGNATURE-----

--VeUcQCU/fqKVyFId--


