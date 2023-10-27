Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3569D7DA448
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 02:13:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwWvn-0007HX-Ou; Fri, 27 Oct 2023 20:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qwWvb-0007Ft-TX
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 20:11:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qwWvZ-0001U5-PC
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 20:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698451904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9G+DcZlJp3VLQ6kSC7i8uZHzkuRdE847hmslJoSd36U=;
 b=NV9pzLJoGhCYVqfv3Br/9TWQQ0tzUJyyBAKeRq59RIyjC9O+T5fXc/TTxamNgXsKd7Dy7Z
 7rei0ZxWai/H1dVe82T9a6HyG35nKByCAJmYeFa1IOdQlJQMQz9vTF9FlUxZfr2I0qANrq
 V/7r5EgaGPSHRnXkggMpmE1kuTZeDvQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-v_iMlD-bM9ugHBzmoppelQ-1; Fri, 27 Oct 2023 20:11:32 -0400
X-MC-Unique: v_iMlD-bM9ugHBzmoppelQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AAC65828AC3;
 Sat, 28 Oct 2023 00:11:31 +0000 (UTC)
Received: from localhost (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86D1B40C6F79;
 Sat, 28 Oct 2023 00:11:30 +0000 (UTC)
Date: Fri, 27 Oct 2023 19:08:27 +0900
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PULL 00/24] x86, KVM changes for 2023-10-26
Message-ID: <20231027100827.GA554392@172-11-0-127.lightspeed.jcvlfl.sbcglobal.net>
References: <20231025232709.89392-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oUiSxvvKiNAvnueG"
Content-Disposition: inline
In-Reply-To: <20231025232709.89392-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--oUiSxvvKiNAvnueG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--oUiSxvvKiNAvnueG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmU7jBsACgkQnKSrs4Gr
c8hdjggAkGuJ7U3HzJH6CvH86jt2gOC4GAe9h5LanZ8857dfvX5M1mgMR3Ufj9TA
Z0igohOWJSqd4BmslF3YqbpGP3E/QQadSCFrgFj3c4X9Z+HErgsocdJwxdcLmBDH
gXmAqPaZwMqYvwTHOyK2IE1BJZ1bAlswHExeiU2HYOpUkrvT7/nBX/WIpaPf2S0m
H9GVIKOoZFDOEDcQHecySLXC+ao4p/QOHWafOFuy3Lh4baiKI5f1TMtGYrfkoFRP
aJP8/lJw6xq/MYm6hAQAbFS7SlUeK9rwz8w5xxXXTkWf4W1tdKEjHEkahe4QIkNz
XNA+DLq7rFvOvJqQU711ntbnwQSSIg==
=7Y5d
-----END PGP SIGNATURE-----

--oUiSxvvKiNAvnueG--


