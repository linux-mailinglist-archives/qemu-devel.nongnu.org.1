Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8500E7C01B2
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 18:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqFed-0002GL-Hh; Tue, 10 Oct 2023 12:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qqFeb-0002G3-SX
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 12:32:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qqFea-0000qI-8r
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 12:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696955534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mSk3O2zxEd2Lf3qM/OyaKUDFGSk+lQi3TpqjqFHKrsM=;
 b=MCP9Y5U6Id03rALPt16mxrfdasx1irnVlCvbEMkVODCIsm/+wZJidTYoCj35gjxfItLy9N
 sayN07qoxiYFmIx7vss2Dri975KO5UkqfU3HdDTjgz7WQgmnLdfS/lgh6lE6hV18cf+XNp
 j1dD44AmzfMsKdy6FcfFS+rDQfhlp9w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-Mo2ba7HJMaK_uVGi4aDkgA-1; Tue, 10 Oct 2023 12:32:10 -0400
X-MC-Unique: Mo2ba7HJMaK_uVGi4aDkgA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E97D9185A795;
 Tue, 10 Oct 2023 16:32:09 +0000 (UTC)
Received: from localhost (unknown [10.39.195.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82332492B01;
 Tue, 10 Oct 2023 16:32:09 +0000 (UTC)
Date: Tue, 10 Oct 2023 12:32:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Hyman Huang <yong.huang@smartx.com>
Subject: Re: [PULL 0/2] Dirty page rate and dirty page limit 20231010 patches
Message-ID: <20231010163207.GA1754262@fedora>
References: <cover.1696896603.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pti0GJ5zz4i5oWip"
Content-Disposition: inline
In-Reply-To: <cover.1696896603.git.yong.huang@smartx.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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


--pti0GJ5zz4i5oWip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--pti0GJ5zz4i5oWip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUlfIcACgkQnKSrs4Gr
c8h9YwgAvpadDLluOwbCRHROxY+kI/1xckNLOFf9cIO3G+Pqa5qbgHpE2hD7r90U
sn8hCnFhOOGYDqG/iwTN3ylovvyDqssmEOUB3NWpm+rQvzX4jsxmeH+k+FJWt77X
fSLfRCWj1rC+Z/llw5no7+3aHH/RVeihoZzlqFNCAvWdHCEvBbEtIcKDizcrDHBS
xTvR8fM4lNrepQH1uEWx8A9nWIiI0nJn7r2oc7RCYDQagC9I/7GHr2rsA/U+iV7X
fVVbp+T3Np0tROc7iSSuqTR2ZoQI4jkM8wmgxcdwySaRHnk2CQLGCbMRoWgwpXyb
eZNsBOya4GAXEF6ukrypC1TdXr7iDQ==
=JfJN
-----END PGP SIGNATURE-----

--pti0GJ5zz4i5oWip--


