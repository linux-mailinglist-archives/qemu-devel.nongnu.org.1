Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C40E7C5A47
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 19:34:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqd4W-0007Xm-2G; Wed, 11 Oct 2023 13:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qqd4R-0007Wy-5i
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 13:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qqd4P-00011e-MS
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 13:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697045549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YyNwAyUFNEhrX2TUcgEge1zv5O5qEJ6z32PHLw5a730=;
 b=XMdxHZmPEWLBrGbi6b9uhS+SRrwSZuTw/DTr4g1zies72WTwbLntFU1WTE+vzK4/h3Qxv9
 WvX9Ge5cmqTP8fmSyxLA8H3I83iIHOX5iGdtdgZ0K9k+1Jv74KodQDGJF1q9Ya4t182Klj
 gLqZjMR4+xsHqTi4s/fKl50HmSIxT/Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-678-NPTivgxtMNm9_Sd9Txs3KA-1; Wed, 11 Oct 2023 13:32:25 -0400
X-MC-Unique: NPTivgxtMNm9_Sd9Txs3KA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50DE83C176F4;
 Wed, 11 Oct 2023 17:32:25 +0000 (UTC)
Received: from localhost (unknown [10.39.192.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C0A03492B04;
 Wed, 11 Oct 2023 17:32:24 +0000 (UTC)
Date: Wed, 11 Oct 2023 13:04:29 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PULL 00/65] Migration 20231011 patches
Message-ID: <20231011170429.GA13446@fedora>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vPkhOfXAbmjhqQEG"
Content-Disposition: inline
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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


--vPkhOfXAbmjhqQEG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--vPkhOfXAbmjhqQEG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUm1Z0ACgkQnKSrs4Gr
c8gXrQgAifsSrzOMR/fz0dQPtabKjmSUa6FjmPy/b+eLImudRyzPDz8WUVj3bjx0
k+lPYao8KNdmTC4u1pUya9S4cN/ASaCPF9YNXPy6rNn6S7BfBl9D0rrzvtrlgLNh
4hKlwtbGzKedpczWk2+EuaQrzpcSYDoUjFKHTc6/4hi2YZLyGaDdfvoQoYmCFSOE
cmQqR3pHt2DWtGEfBHiEn3qap8dTECYuSSEIVTZA+lwhSz834U4o0/4o5LUJ68FQ
kqT6llPfY2Glt1PzCp6fgsZWPN2EHokR3u+TfEgaMXYXDg2VOYQShh4nnNORiGRX
bPGpJdU2Y1N541oVnHTxYBUTXwjjdA==
=8xXw
-----END PGP SIGNATURE-----

--vPkhOfXAbmjhqQEG--


