Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B151681E894
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 18:00:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIAmF-0000VD-It; Tue, 26 Dec 2023 11:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rIAmC-0000Uj-Ra
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 11:59:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rIAmA-0007Vu-PB
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 11:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703609970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8oQJ4jUhT8bkkuNhlVghUfMFSJllmZ9PM6KSwbcnwOU=;
 b=WikgHQrQznidVOf+ENnRELYIrV3tLvYALmQ8Jnc/uaeC14h3LLY3HYGdQcts3OUF6ToJ4R
 1LsEUdiMhv9xDriVVnU9MfyENN/97mA5wc3PJVhfgy3KTIHIZ4NE4NhLVzUiV55+zdvCM7
 Rxtt/C1k626403KXl1MsZ7NKTLuVicE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-PfcBlDQONPGETH2Qw4Y09Q-1; Tue,
 26 Dec 2023 11:59:27 -0500
X-MC-Unique: PfcBlDQONPGETH2Qw4Y09Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A2691C32944;
 Tue, 26 Dec 2023 16:59:27 +0000 (UTC)
Received: from localhost (unknown [10.39.192.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6652C15E6A;
 Tue, 26 Dec 2023 16:59:26 +0000 (UTC)
Date: Tue, 26 Dec 2023 09:15:20 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/21] virtio,pc,pci: features, cleanups, fixes
Message-ID: <20231226141520.GA103391@fedora>
References: <cover.1703582625.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vp5ERKBTDhmUx4iO"
Content-Disposition: inline
In-Reply-To: <cover.1703582625.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.851,
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


--vp5ERKBTDhmUx4iO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0 for any user-visible changes.

--vp5ERKBTDhmUx4iO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWK3/gACgkQnKSrs4Gr
c8hraggAhSbSil9widhjYM1jsbqJyMctEzwARLlg/+HUZu/8tIGqcsyrX35cGCAl
OWyQsP1IcRJqRcxTUKUqm4+QL5vDh2f+XWGyDfgvrjLu66wUJlm8mzu8JljvZwTR
iLgq+8fA2TO4WcDalgvHTCmJXnfFQhYHosLhCVda0WfXiM6y1h2XvpRKaFyMAXm8
p3vx6OAZ7CxxleAogSQVMuhhL3NjqEZUoBm3rdZZkqolJXvRirfJZjz2L8I9JGCH
/SpVhlzEQbK4d5xCPjJm6NoC1tqfPGCgoIxDbfVBKSztQgIwjqPBtpQUqCEL3XHw
Vfdw3NUm4/mHf3DsKuZNzDzLb+lFhA==
=D3Mr
-----END PGP SIGNATURE-----

--vp5ERKBTDhmUx4iO--


