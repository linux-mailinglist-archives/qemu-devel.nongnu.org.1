Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FD47D13B0
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 18:08:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qts1C-0005TO-FZ; Fri, 20 Oct 2023 12:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qts1A-0005Qh-Hn
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qts18-0001Rr-V2
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697817989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9RXS10nRLlrpnIAKX71Uy+TF4GmnLEpXdow9WdtYwfM=;
 b=AIolRqFwOPr9luqw27dkT1Oqse9xUQgl26dr37Wzw6Xi5BtnfzE/vyzCS8dkr92CFZhMz/
 VT3jIAwyApv1M3UgtzBAQrNrvqBwFRLE5j9L7a+6Q5xMEUoo85WR1JKs6D4Uq83YIBEcg5
 YJWRkZdwxjwTyJ+GwTWUEERCQzQXSdI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-Pu1mBYfeO0u_9N7b-bIeoA-1; Fri, 20 Oct 2023 12:06:25 -0400
X-MC-Unique: Pu1mBYfeO0u_9N7b-bIeoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B85C888B767;
 Fri, 20 Oct 2023 16:06:24 +0000 (UTC)
Received: from localhost (unknown [10.39.192.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2554B1C060AE;
 Fri, 20 Oct 2023 16:06:23 +0000 (UTC)
Date: Fri, 20 Oct 2023 09:06:22 -0700
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/24] target-arm queue
Message-ID: <20231020160622.GA471962@fedora>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sxKmQIl/9NWxAFfg"
Content-Disposition: inline
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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


--sxKmQIl/9NWxAFfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--sxKmQIl/9NWxAFfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUypX4ACgkQnKSrs4Gr
c8jatAf/SvEMsyD0yCeUtdg/P9SQ52EwdxdF5/JhKNTGVsjFo47pWEOUj23GODM+
Entl7nwYxdMh32wgYNWcLuW16hpPuT7czRl8SBpBwe8uThkZv15By8p8QglkrC9R
aKcu6xBd14AZ0sbaR5GIe5eLtOo4IEB5FGSSh2i5MACFVTot91jHAhofYFa+nJn1
oIJv1NEqe/pep8CAYw8J146/+qdQczvrqRdG/DsztUIQgLd6iA4X7ZOEO6xR9bc0
H4sFWpk0OyqBDUO8ujOlbA0X5E/XQ5iW/EWXr4adV9at4zbIdbB99lcwJwZ8zuQf
jhXbF6bbz5WDxW6zVwYbdSEsZj0j7g==
=RHCB
-----END PGP SIGNATURE-----

--sxKmQIl/9NWxAFfg--


