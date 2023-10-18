Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9585D7CEB5A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:33:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtF6H-0008AM-Nm; Wed, 18 Oct 2023 18:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qtF5z-0007zq-5v
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:32:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qtF5w-0003QS-SI
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697668369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DXxxUh+ZIZA2E0OtedLd3/aF+2UaV32JeFIDnlAtzPY=;
 b=S6tNk/Fd+d6chRnQsBjDAMTq7uNP/HPHJXGUcGtPGuBAkIyCwEIE3a5WcBc5cKyvY+XSZP
 70jgoYl7nq833CtcgpQ4fudNyrszTgJYpoBWEDtYIxR7BPemeWf7lMC2XFBazl5FKIcLNG
 tjhSdpW2HHzZGoA1+jdOnkeNo3gtQDg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-N29Vn8dtNQaOEBuviXgvjw-1; Wed, 18 Oct 2023 18:32:47 -0400
X-MC-Unique: N29Vn8dtNQaOEBuviXgvjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1724810201F0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 22:32:47 +0000 (UTC)
Received: from localhost (unknown [10.39.192.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 778A02166B28;
 Wed, 18 Oct 2023 22:32:46 +0000 (UTC)
Date: Wed, 18 Oct 2023 18:32:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/32] x86 and build system changes for 2023-10-18
Message-ID: <20231018223243.GA295143@fedora>
References: <20231018082752.322306-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="byHHG6MZOZG8BWYj"
Content-Disposition: inline
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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


--byHHG6MZOZG8BWYj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--byHHG6MZOZG8BWYj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUwXQsACgkQnKSrs4Gr
c8ib5wf/UvxdXzEf5yq41eAPtum0zIvfTGheM+uYlhKqFjETdAMNmy1okpiDOnqP
3DFrLUSxB9+KV4iNxGoV3wxrIgnWQrdumi1SRC7rgWwFOzVvKurkEGJ92wXauzJG
XGfck0p9f0XhAnrEVg3Fs6v1MDWREhANkzfjcocYAxLSlIFz5SnGBjJP28h6mC7E
Ab72j7UH4bHYa+2nrKWYzajC/53hTayaI67EChOcJZrUNst95zVBsIP74ylHGGQW
YPBIB4gTO0zeVDwIeoZYcB2lcHCfWAaWtoG6PMZ3ThNwrnIizJAawWSyKZqhNeZO
xRjcHWLer1M2WuwxZtrlg3smMBIIbA==
=KPL4
-----END PGP SIGNATURE-----

--byHHG6MZOZG8BWYj--


