Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD6C7DB31A
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 07:10:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxLT7-0002I4-2A; Mon, 30 Oct 2023 02:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qxLSv-0002HE-WE
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 02:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qxLSu-00042F-H8
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 02:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698646171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YbZkT9EpZwL+NBHRS46AsvxmuKAua96ShpCI79mJQv8=;
 b=Sz/ZjDL0XbFdig4fDQbDTy7pp01Yvy1eUqCrLzzmxjQYUN0RYGc0W2x3lYD5fQYMl8XPAi
 V1sIXwqeMNHm4JxJhKrM+DFa2RFPXeHKhI7ZM+Lj4J2cGtAXqg8O1WzbfSM6y7PIV8ZxTM
 0Aen7bbfAZz5VecyaAuOZrTw4mnaT4M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-KJQA-ZH6NhavoyOcU5xJZw-1; Mon,
 30 Oct 2023 02:09:14 -0400
X-MC-Unique: KJQA-ZH6NhavoyOcU5xJZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68B9529AA3B7
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 06:09:14 +0000 (UTC)
Received: from localhost (unknown [10.39.192.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9321D1121314;
 Mon, 30 Oct 2023 06:09:13 +0000 (UTC)
Date: Mon, 30 Oct 2023 13:39:39 +0900
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 00/11] testing patches (+ 1 deprecation patch)
Message-ID: <20231030043939.GA613643@fedora>
References: <20231027093710.273558-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+vN3ozMVwarndvvI"
Content-Disposition: inline
In-Reply-To: <20231027093710.273558-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.478,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


--+vN3ozMVwarndvvI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--+vN3ozMVwarndvvI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmU/M4sACgkQnKSrs4Gr
c8gHUQgAticuAJkfAxaNtLVEiVzkA/GpSsKuj/ihkMRIOHZUgYEBjQdMYST8t5ZM
I9DEhllB5DI4GeGva/1xqUNBAMmFibLj34bUjv2cYk7EaaBd6I1AKPM4lEdnEFbA
YYGdsyJiQasdT9jV4A5BYGLwwAxaeDP8PsOSPnPLIdiq3FhMHkdmdjMguek8V8gi
mxviM2hUESNYKPF7JD4kST4PjhMQagUrwURsuTCSSjI/qjMfkjRankuIrxH+7Z8T
hJapW+ofoiGu1fWIjsjHy9fzGJH8nJTE3KRmU2OHpIjDjf2G3UIIXi9EHS2zGE5k
iRitAOCBL9EBUgLrazQtOlBahYCFMA==
=SZ2+
-----END PGP SIGNATURE-----

--+vN3ozMVwarndvvI--


