Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 079C27DFE5C
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 04:24:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyknE-0003aQ-FD; Thu, 02 Nov 2023 23:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qyknC-0003a4-QX
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 23:24:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qyknB-0006Cr-Er
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 23:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698981856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JAvS2W6X1rLj5DbAGZ3bSjkQ7iEPMKFfMBqRCeYgCE0=;
 b=fN5fJXenrHtv0m+eiqRvSid678N66auGjvoeM5u2PYUCgn2KOGh0FTlQ8GQnotdie0c1ia
 CG/+S215JWbkCrhG0K7pPZrXVLP42apbJTwbz6UAMk0PcGF5LgY11K7Q5RjXlmOv7J1XC4
 LMzQxAAgDGze2gNfw6KePfWnwhlDfsk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-gBYXaCtvMfGmEt-mPyHeWg-1; Thu,
 02 Nov 2023 23:24:10 -0400
X-MC-Unique: gBYXaCtvMfGmEt-mPyHeWg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5690D2808FD0;
 Fri,  3 Nov 2023 03:24:09 +0000 (UTC)
Received: from localhost (unknown [10.39.192.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84301492BE0;
 Fri,  3 Nov 2023 03:24:08 +0000 (UTC)
Date: Thu, 2 Nov 2023 18:31:28 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 dlemoal@kernel.org, hare@suse.de, dmitry.fomichev@wdc.com,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 2/4] qcow2: add configurations for zoned format
 extension
Message-ID: <20231102103128.GC726730@fedora>
References: <20231030121847.4522-1-faithilikerun@gmail.com>
 <20231030121847.4522-3-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CHnBSA66sKD49IUR"
Content-Disposition: inline
In-Reply-To: <20231030121847.4522-3-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.393, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--CHnBSA66sKD49IUR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 30, 2023 at 08:18:45PM +0800, Sam Li wrote:
> +typedef struct Qcow2ZoneListEntry {
> +    QLIST_ENTRY(Qcow2ZoneListEntry) exp_open_zone_entry;
> +    QLIST_ENTRY(Qcow2ZoneListEntry) imp_open_zone_entry;
> +    QLIST_ENTRY(Qcow2ZoneListEntry) closed_zone_entry;

Where is closed_zone_entry used?

--CHnBSA66sKD49IUR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVDeoAACgkQnKSrs4Gr
c8h4ugf/fr9tsyQlw2rRW+2SvRYFuDRyAjle4R7ifMvO6ESEImGOTTjxmP4Hmypx
sHI09jXCLqMRwUBq4l+NMv0zXCZwcGAjsJ9L3fbPWBBGx5Nrb7rudcS9LGOyI087
MHlWLdBu2sLZ0Hk29Egms8yvFPVVbPyCKExUPLwiwjLFJ6ZZa1c1LdJhjHmFIOt+
pM5vgmyir6tOCSB/gq8H3knhpdxtedWLLKEbhCz8XhSDq3xdo1Qc0WCxnw3KwoLp
vBiU+WnwMSha30XUZ2B6T1aZdi4JciUftfp6aZIrzlYxagXdurUIYT6HeocPuFvQ
k2uJ8Q7Kv6Il8c16VA3WahBmC62fqw==
=/KUQ
-----END PGP SIGNATURE-----

--CHnBSA66sKD49IUR--


