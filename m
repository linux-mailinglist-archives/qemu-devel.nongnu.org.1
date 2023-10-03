Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A727B6BED
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:44:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qngcb-0003hd-Ct; Tue, 03 Oct 2023 10:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qngcO-0003e7-VT
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qngcN-0001Ku-GG
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696344202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9aVDekaQLTyh8Id50YmeIGKh12D3a7eASiLNXiZbVms=;
 b=GiIYruaSY0jfAohXeYhxLt/lwBihb3TnfODUldBfI02xK02hzoVdMhxQo80eFYx6IrWeg0
 BzvXDdQRWipiT4+wJqel95/Uab3w2swN0DHr51LOuf5nYxnOiu0Ajz5uMDACu9YZb796Ln
 CC3N2LMm8s5r3i1NEvrEaGsi6qbugCk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-FtiyhzhIPcevaTriCIQ98w-1; Tue, 03 Oct 2023 10:43:15 -0400
X-MC-Unique: FtiyhzhIPcevaTriCIQ98w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A13C185A790
 for <qemu-devel@nongnu.org>; Tue,  3 Oct 2023 14:43:15 +0000 (UTC)
Received: from localhost (unknown [10.39.194.147])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A66AF2156A27;
 Tue,  3 Oct 2023 14:43:14 +0000 (UTC)
Date: Tue, 3 Oct 2023 10:43:13 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/24] Audio, build system, misc fixes for 2023-10-03
Message-ID: <20231003144313.GA1120113@fedora>
References: <20231003083042.110065-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LCiydX+MMyKRTLLj"
Content-Disposition: inline
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--LCiydX+MMyKRTLLj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--LCiydX+MMyKRTLLj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUcKIEACgkQnKSrs4Gr
c8hbMAf/ZYjSTmwOHvNVj5NS3Xe9WnUkQs/KeD3hsVHaR4jcWaOXArRDWLy2YD8T
raq5M9dpgJJuu7NLH1mGuN1Q1sO/IGwNIZaEWw1FfMP5iqAKEjuBu26TzeKLHsxA
/t5jet9gdnXXS6rnl/mIw2pUSD5Czi8ltiTARXaICHyoeOqbtOBL/ifLEAi7OQ5j
YC98Eo+8P0gnqOSM96uD6/2GHJMGoprl7QYWQIa5/XoegvmWAfNx0Nuz3OVAYcr/
mD16dzk3imeMJ8lUbdCYCF0NxKud9Pxi3bvKvaEvzZO0hgMt48W+XPT/DEpOwORu
Nmkw/wHBFgV9M5kQkIn6HB2o2/eS+g==
=fxMp
-----END PGP SIGNATURE-----

--LCiydX+MMyKRTLLj--


