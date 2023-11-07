Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A587E37F3
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:37:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0IW1-00023A-1m; Tue, 07 Nov 2023 04:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0IVz-00022v-7X
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:36:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0IVx-0004NU-KE
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699349809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RyEiPbrO0onCRVik6K8s5rWTxjuAnZS4XYSssdPhPLo=;
 b=VDwGxs/26TgW2TzyiiWwhjmnFcUGN4G9+pH4ZzRDHiq/ts5jFRevYsPCEDuc1Mi832tCGd
 ezDvpJ/BnCN89thuqQxxz3bXvlmbZ7mUws9Dzj1+0utDOw+f0Nf3O+r9wAYVTXOgbqQgUd
 CruWnZ/rZyvVPqQVgxFVsGEcvh9zb2w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-gT6eLcW6MCiXHVbIin2Y_Q-1; Tue, 07 Nov 2023 04:36:47 -0500
X-MC-Unique: gT6eLcW6MCiXHVbIin2Y_Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C8FC831716;
 Tue,  7 Nov 2023 09:36:46 +0000 (UTC)
Received: from localhost (unknown [10.39.193.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4ECCFC12918;
 Tue,  7 Nov 2023 09:36:44 +0000 (UTC)
Date: Tue, 7 Nov 2023 17:36:41 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/85] target/hppa patch queue
Message-ID: <20231107093641.GA986261@fedora>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hkzxfhrm8BPAfpRN"
Content-Disposition: inline
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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


--hkzxfhrm8BPAfpRN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--hkzxfhrm8BPAfpRN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVKBSkACgkQnKSrs4Gr
c8gZyQf/eeTejiUslAS5+CRnLvziPLHAgQAX57jiHY1Q/qim6dF+EW9klSP5roGZ
2qfABUKMPdxWEwm9g0JI8qTIFEs85cymPk7pE9fBFggJN0/VYuQVHLKkSHFncfec
KEaRnUihqnceztFvSO9bxh8p1tIj1i8HU3SW2+zMSBLkbH4o9Jp/zIxXyUJyGa6X
aWzxqdJwjkvE5rqQz+r6kquL0RVdXOH27UmC3njoamev9Qcs99tbrBH0R8QZ6KDS
Zv6OBNrBTBwwLVok4E5E4Ls9JYOpdzaAX4XXGb8yxBi1uDdDeFrOdLlfpg0Vloi8
lp8oXFvsBebmwTytLIlYhwDs2ucErg==
=MUCu
-----END PGP SIGNATURE-----

--hkzxfhrm8BPAfpRN--


