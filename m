Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 662887A957A
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 17:17:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjLPu-0003dx-O1; Thu, 21 Sep 2023 11:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qjLPY-0003XA-If
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 11:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qjLPV-00061B-FB
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 11:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695309367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oJJaT199/c3uC84gYRiw+Bxc0Ib1OOoYu0YgqJZCgyE=;
 b=RW7rSqp9xLI38FbMf/CBlNhKczWehAaS0wx1wE3AsIX/c0SgFe6NrA1VmjqHxzlfZiDgiU
 cc0ZbZhuvu2j5GX6HUaUFSbJYupJrvRM346pvk5qPEs8WAO9WKEbss4Pj8xBw0HKkbZevx
 bNgZ0PhFH9yaqnzgFzwqbwdZVKB99uw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-Ma1K0r49OUCNOCFmye3KVQ-1; Thu, 21 Sep 2023 11:16:03 -0400
X-MC-Unique: Ma1K0r49OUCNOCFmye3KVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E89C0381170F;
 Thu, 21 Sep 2023 15:16:02 +0000 (UTC)
Received: from localhost (unknown [10.39.195.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CB761006B73;
 Thu, 21 Sep 2023 15:16:02 +0000 (UTC)
Date: Thu, 21 Sep 2023 11:16:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL v3 0/9] testing updates (back to green!)
Message-ID: <20230921151600.GA1106816@fedora>
References: <20230920161711.1295646-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="U7f/uSSAI0Aoim3+"
Content-Disposition: inline
In-Reply-To: <20230920161711.1295646-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--U7f/uSSAI0Aoim3+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--U7f/uSSAI0Aoim3+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUMXjAACgkQnKSrs4Gr
c8j3IQf/RB+43E9O7drK1DR98mp0m0f4qc0b/Zt+aj38o7VnNF/fGbznsVslwjaP
LaAlyMzFJO3MWk3quUvO8pijSZiFkWUsAGMbrermVoiIc+TQr9wbke33kscLUGoJ
UEMTkMF+GEBiS8IUy8FC3yE66DpFZvXu2lpfsvTQHpEQUYEPgPiJzk4Q9vEoIdJ6
PQkhnAgdD0H29MWGIAP26Pf+Nu3a/clnO7hmyJ0Udliev63M7ryjdvMqWA1NpZNi
zXZl8pAxAs1gFeg4xyFwxakFcjdR41caQ60REYKbCMpta+ltTfCTDwZcygcFTAAv
4aws/dFEswVRndwqUUyRadvvgXlTtA==
=BWsX
-----END PGP SIGNATURE-----

--U7f/uSSAI0Aoim3+--


