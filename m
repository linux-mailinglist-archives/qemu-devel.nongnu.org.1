Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4A67E26B5
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:24:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00Wo-00080b-DN; Mon, 06 Nov 2023 09:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r00Wi-0007zM-NQ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:24:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r00Wg-000615-K5
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699280664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P+I7cNYWSlomosThAj6cLOLjeJT30wjLGYXEDSqN3Ew=;
 b=M0r4s67pOqfJ06meEty5kJC2/Kv1OhKML0REFc2dXaq9U1f8ark0MeIjQQ4kNoOQJsb0Gl
 x5yjL1hremTK1dwiv9etzvZlwanJ9s8q7JVURO9nWuFaf146joJCidG/DIaqCFjp1T5Q+9
 4BEf3DAEXGX8rDGbG2fLB6Z74jWdukc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-cw4oBLGmOVqkOUcZYb-bpg-1; Mon, 06 Nov 2023 09:24:20 -0500
X-MC-Unique: cw4oBLGmOVqkOUcZYb-bpg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96D57185A78E;
 Mon,  6 Nov 2023 14:24:20 +0000 (UTC)
Received: from localhost (unknown [10.39.195.175])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3997502B;
 Mon,  6 Nov 2023 14:24:19 +0000 (UTC)
Date: Mon, 6 Nov 2023 22:23:16 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/21] target/sparc: Cleanup condition codes
Message-ID: <20231106142316.GA929088@fedora>
References: <20231105201222.202395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TuRI/cb3YzYAvXcJ"
Content-Disposition: inline
In-Reply-To: <20231105201222.202395-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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


--TuRI/cb3YzYAvXcJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--TuRI/cb3YzYAvXcJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVI9tQACgkQnKSrs4Gr
c8hCAwgAtLICI1T7DEJFO7JG+fHQiIpontutSrcXjkzQ+zHaxdwkWcYQ6v4911gB
Qkxe1quguSrJ661GHrMegkGB2sOR/8h+c+7cEo5DYQmdtkT3r+mJRcZ9g5nIP+1P
whAeiW8Cm3pIR+GoJOhyydasXLv3xDEQRfl0UIYYo4o6DnbDSJvL1xlIdSQah7TK
EUnOP2XpwIfG4aLoFoAorX5+EagdeB9wu67seUIyCq+8JD7j7JfJLZtxpNT3UU3r
sET/f2cUr7oHnpwDHHN5tUYcN1hpOZS0ez0Q/n2FgcEjHF1yATa245vYkOEy//5p
iFzxDJseqoo3ULsQokq1KRu0DdPqyw==
=mgjA
-----END PGP SIGNATURE-----

--TuRI/cb3YzYAvXcJ--


