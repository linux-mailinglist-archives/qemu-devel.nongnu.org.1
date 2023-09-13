Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E5579F1D7
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 21:18:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgVN0-0003AJ-1z; Wed, 13 Sep 2023 15:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgVMx-0003AB-Ru
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgVMv-0001KW-Gy
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694632665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cs06DPzMKVzbSqLI4XfpyowE4jnUaUkBxnfvfQpc5X4=;
 b=CWfrFZkL7puvUKbbPLIswFNc8AmC764AXDg8x303SRJgC3rISesn/ei6sX15PBqB+TAMd7
 J3Cv3kIErqXuBpZ1WMztgF3sV+uRFOuDHpKzuZPmEaeS2NqoJZbxxeqcM+vaqddJS1zwPK
 zjMqVm/5JIm8y4W9IW25Qk+Fx8Y7dbU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-cfel67xYPD6G-qMC8cqLBA-1; Wed, 13 Sep 2023 15:17:42 -0400
X-MC-Unique: cfel67xYPD6G-qMC8cqLBA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E448C857A9A;
 Wed, 13 Sep 2023 19:17:41 +0000 (UTC)
Received: from localhost (unknown [10.39.192.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7963E2026D4B;
 Wed, 13 Sep 2023 19:17:41 +0000 (UTC)
Date: Wed, 13 Sep 2023 15:17:40 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PULL v3 0/1] Merge tpm 2023/09/12 v3
Message-ID: <20230913191740.GA916858@fedora>
References: <20230913125227.504709-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="C10oD2ltpJTv78oe"
Content-Disposition: inline
In-Reply-To: <20230913125227.504709-1-stefanb@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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


--C10oD2ltpJTv78oe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--C10oD2ltpJTv78oe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUCCtQACgkQnKSrs4Gr
c8iQJwf+NehuIBI0PcQvzJ+VpPTlNphTM8pdaqBKzRpyBjzQyt4vSQEXz2Ip6pfF
d3g49+OZHDKAwetRN3r7sWHzXxQ8blfZw9qN/Is4ih8SfCUHZzDOGn2rHZjyGnlX
JhYY4lTuZTdXq9T5Rlfzo+1J2FKhwsIxAS7cjdkZ1XzfE+QfRm3oVkEonFz1CXMD
PbGNS1QsgOllFrB6tpGAs3uRXnaYiXUGT9YGD1zIwRNlJ60Xk2N1g8HVj/KRb65q
2To1XQuAJblxJ3nUdW5lE2MVmhpaAVNtftZX6EsMnCnW4JaXweEA0tWvYBzFX3/x
QX209GFHNh/8ikSLhSWPNBQmNRmlvw==
=KkpI
-----END PGP SIGNATURE-----

--C10oD2ltpJTv78oe--


