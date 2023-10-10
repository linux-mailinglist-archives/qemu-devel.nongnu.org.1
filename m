Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9DA7BF04B
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 03:30:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq1ZE-00074C-Aq; Mon, 09 Oct 2023 21:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qq1ZC-00073a-EL
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 21:29:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qq1Z7-0001qE-Sa
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 21:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696901381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KlfG3MJ07fkWSfaYfQbLpSZUv8xvTo31wtmQ0PaLs4o=;
 b=T9uyquzI5jK1F+GwPM23zs9mCT3jfcVunUMJYeFmOD2iTNz7k8w+3GdJxV5AxCmhXkcGJJ
 bnOuYkpttPDZgbLfN//TIJwMP6vN8h/bQX44qpLLcBnlDmyixEAlU66GXhY5DopNMLNaNp
 XOpzlauJZTqe82wrdmb0vd8U9h5RwP8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-m8iiD9ylNa6bVGlLV5NeIg-1; Mon, 09 Oct 2023 21:29:22 -0400
X-MC-Unique: m8iiD9ylNa6bVGlLV5NeIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CEA3810BDD;
 Tue, 10 Oct 2023 01:29:22 +0000 (UTC)
Received: from localhost (unknown [10.39.192.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B9E6150;
 Tue, 10 Oct 2023 01:29:21 +0000 (UTC)
Date: Mon, 9 Oct 2023 21:29:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, phildmd@linaro.org
Subject: Re: [PULL v2 00/25] Audio, source reorg, HVF changes for 2023-10-06
Message-ID: <20231010012920.GA1674630@fedora>
References: <20231009063556.72450-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AKBRlGa3j+SJWJLz"
Content-Disposition: inline
In-Reply-To: <20231009063556.72450-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--AKBRlGa3j+SJWJLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--AKBRlGa3j+SJWJLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUkqPAACgkQnKSrs4Gr
c8gerAgAyXh76/rgY3vqRBtRYmlArtLjbvz41+OyPzpSAkj2nXegPQbL7JGo4N0k
IHJI1k/7EXj3n20v2EryN2sVTeAhzidV8p5WUBxuaMpUtn5YU8dSoa7EXWbnpcUp
3cd6NkovUqi2mnLSdvAWnEqzHodOYtsxSqD8OVuxik6uPNgXk3tKv/fiVL9fhoU8
gOuVsJc+eg4jTA+qr00kVhBcXoXlWVg1WyfruHN8kWZzKB+vgPDivGTpLumzfqF4
JOqbSjmSctAHfUeH5h72BC00Lea/umL8pDMAgEuE3G1Ef2Jz/i54f5IlcBXp/SZP
jsnXaZ0plI2zRTmNrHw6G3fyVUNG5w==
=qhOj
-----END PGP SIGNATURE-----

--AKBRlGa3j+SJWJLz--


