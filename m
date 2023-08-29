Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC4678C678
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:51:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaz74-00026K-0D; Tue, 29 Aug 2023 09:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qaz6q-00024l-DO
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:50:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qaz6n-0006iX-EB
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693317015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LfDGnwV1cUbrRDywFM9leTqtFP6qHJNCQuQjShj3LPU=;
 b=A5OaHY9LnWjiII7iJve55djbP8WIj3y7oP63zQRGr1rd3NFm9tH/BUK20mC2Ej3gAhRCna
 lLB3kuw+WALYtOJID5lifP3skHQlkDRV0/PqEUIDy0aoLiOTKtc/Y5dPBnUAHxzdEj972W
 wdXbw9jqxrSDkMqjC/KbVYdpTHZMdWQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-vLLdN7ZHMgev6ZpN4fSmCg-1; Tue, 29 Aug 2023 09:50:13 -0400
X-MC-Unique: vLLdN7ZHMgev6ZpN4fSmCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F11C9280BC40;
 Tue, 29 Aug 2023 13:50:11 +0000 (UTC)
Received: from localhost (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A487C15BAE;
 Tue, 29 Aug 2023 13:50:11 +0000 (UTC)
Date: Tue, 29 Aug 2023 09:50:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Reinoud Zandijk <reinoud@netbsd.org>,
 Warner Losh <imp@bsdimp.com>, Ryo ONODERA <ryoon@netbsd.org>,
 Kyle Evans <kevans@freebsd.org>
Subject: Re: [PULL 00/36] 2023q3 bsd user patches
Message-ID: <20230829135009.GA179554@fedora>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L0wLH+SL22z3CBWz"
Content-Disposition: inline
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--L0wLH+SL22z3CBWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks. In the future, please invoke git-request-pull(1) with
the public HTTPS repo URL to make it easier for anyone to fetch the
changes:

> are available in the Git repository at:
>
>  git@gitlab.com:bsdimp/qemu.git tags/2023q3-bsd-user-pull-request
   ^^^^^^^^^^^^^^

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

Thanks!

--L0wLH+SL22z3CBWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTt95EACgkQnKSrs4Gr
c8jNiAf/Wu41It8WaFblm/DvPWQnNpRLUyvVTMmEkzmOPy73vjSLdylbRI20vf23
Gj0Xsyw3IiLKrKVo+KDDSdQyCpV8gvf5WCIHWNXvJRATTbvCxEW17QYO6MY0Ln++
Gx2iHHCUjGAN2Wr9KTOEeiooxK2X1v6RvCWLLr2S/cQK/qDB2fM5l4sxJHtdryiT
RP469GYrE3Dmtq7HeENXJ93PBXGo1u6yP/qh22HGJBHIA8bErQsJSv6JRLJqh5TS
4SE03J/02zxnIXcCNkbJb8PQ986HwqIF+kXEQvZBk021QIvgIBqIAxarXD7sqkgo
XEMT2CmQpyeXDScQFNOX7TK/mRQDSQ==
=mklB
-----END PGP SIGNATURE-----

--L0wLH+SL22z3CBWz--


