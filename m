Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B788481A3A1
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:04:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFz2x-0002Xc-1w; Wed, 20 Dec 2023 11:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFz2p-0002Ws-MY
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:03:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFz2n-000259-Lw
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703088216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1r8Sjrw/MxavwS0SZdbtdydcPP3tAnzIjz5+ztRyErY=;
 b=aOTT7s7mTMX64PlJa/J+lyu6mXCaYjf6mqzMWa3zS8Y2S77kj4+DK2WX7u/Bn3g4fFiWBG
 zvGyXYY08M3XWcXKEM9Lj/zMBoliIpngRG/jgF3LcDck20T3CtWAcLL1LDNwcsuFEYOUBt
 iwbu6/whBdp6C33lFfxP3/X4EeT+Png=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-vm-VXFYKN7G7Jm8qSm9TVg-1; Wed, 20 Dec 2023 11:03:33 -0500
X-MC-Unique: vm-VXFYKN7G7Jm8qSm9TVg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8933C101A551;
 Wed, 20 Dec 2023 16:03:32 +0000 (UTC)
Received: from localhost (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D33561C060AF;
 Wed, 20 Dec 2023 16:03:31 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:03:30 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/47] vfio queue
Message-ID: <20231220160330.GA843210@fedora>
References: <20231219185643.725448-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zdPPpYEsEaGZRwiA"
Content-Disposition: inline
In-Reply-To: <20231219185643.725448-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--zdPPpYEsEaGZRwiA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--zdPPpYEsEaGZRwiA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWDEFIACgkQnKSrs4Gr
c8iMvwf+Oeh89BKHNGeAvvxVVOCao3nmkpiiFwu1unrW7adgCaGp9Y5nhoR8KmaP
Aht+LAoPEJf2n9ZEeD5mrAocSR+NmfvjsXHuc07YHdc7sNFyVNt4BnX0xuHxxMcb
kWlDYZe7KLYP09DaFb9pRCHm45mkbpLqm96Bz/Po47bOSMLpguYVT9tDpBNjyiTe
IsUmelp4e1vTj6PQ9vLBlaJCurZwkLNmuQUxA4L7DYY0rJ7XXZIXUJuDQHipAIJR
wut5GbdGAmXpDxIzkVXVTI7CjlvxJijmJjwAJJX7n4azdlyTUBvoNU6TwwxRxadT
1GRNEd0ZKtifsdBIibflbB2cEF4mlQ==
=f8fO
-----END PGP SIGNATURE-----

--zdPPpYEsEaGZRwiA--


