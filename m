Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B5F7FBB49
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 14:19:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7xzZ-0005Os-DN; Tue, 28 Nov 2023 08:19:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r7xzV-0005NX-T2
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:19:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r7xzU-0003oN-3x
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701177542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0uEMI6wX77RWr9NKrq+alP3ex6YVAFPsaZT52MC6InM=;
 b=GXY40jTge2WftsLpTOssvUKs7wM0zVo0bOFFqj+gree0jANoaN/C0EaEBW3CiV+MfG6Ogk
 +32hxwVb2WQ8sk8RQrJCb9XmuuISWqAlyIqiejNk7fHb3rTNsc5zrefeamVLUi9b+K7fr3
 Vw+akQw2LucpJpLfFMhLgHNqkvPnzaU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-4q90tbufMJintCsL5xPa7g-1; Tue, 28 Nov 2023 08:19:01 -0500
X-MC-Unique: 4q90tbufMJintCsL5xPa7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFC60811E82
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 13:19:00 +0000 (UTC)
Received: from localhost (unknown [10.39.195.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6ABC01C060AE;
 Tue, 28 Nov 2023 13:19:00 +0000 (UTC)
Date: Tue, 28 Nov 2023 08:01:32 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/10] Misc bug fixes for QEMU 8.2.0-rc2
Message-ID: <20231128130132.GA483827@fedora>
References: <20231124152408.140936-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k35UTLtRcUpJQlzj"
Content-Disposition: inline
In-Reply-To: <20231124152408.140936-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--k35UTLtRcUpJQlzj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--k35UTLtRcUpJQlzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVl5KwACgkQnKSrs4Gr
c8io8QgAiCJMwCAdGJ0nYY0Ky+9JXbDiy2AW5Cu3uKCb1WdgaEIbtKDQb2n7ni2B
2twES7JmHsSM/2FhuOvDfSsZmkdPv9ExWvgnBooFjc3+hNHsj1y/mO2EXQx1ntT8
vKAv32lARl9oLIxzanH+QWoporuMjKcNCUGuHHDuro0oO0O6KcuhCLe0CX9yDGVI
RipKfSBO1LJCk/dMWLdwTAFlfD6am/kxo6Sn74kHifGQ/N+V0Xipql5i8A4kjKdc
Ef2KM2MtYiQ2oklCyQdJvUR3hZBv6wLTAFeaD/gh2Tprm3PmyxV7Ehu2/kfzZEBS
xZBZPgivnuVghr3h5K3mNkfCX7HGxQ==
=0IB0
-----END PGP SIGNATURE-----

--k35UTLtRcUpJQlzj--


