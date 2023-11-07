Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 681727E3369
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:03:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CMe-0001S2-Ef; Mon, 06 Nov 2023 22:02:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0CMa-0001Ak-It
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:02:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0CMY-0008VL-0e
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699326165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mySBv+yuiWXTFBYIcltEFZUFPjwPzrkyDLltOVkuh7M=;
 b=M7mZtkpeoVDSQCPRE/O76IydmNYgnpZdkCd4xnIFMh1wQMIgSW0IRBFrSKbNmk8JuHclLZ
 8bpyYGpr45XPo1FBk9a+TuMA+GgbvHF1uJZU10LjrUdMJO6M1YJ8M8vTJgzurh/Pp/S8g7
 bH1QwP/5G9Gr4YFEDXlTofs08i3ACS8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-eMRp3kYDOduyrY08GEvaUA-1; Mon,
 06 Nov 2023 22:02:38 -0500
X-MC-Unique: eMRp3kYDOduyrY08GEvaUA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6971C28B72F4;
 Tue,  7 Nov 2023 03:02:38 +0000 (UTC)
Received: from localhost (unknown [10.39.192.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CADAC1596F;
 Tue,  7 Nov 2023 03:02:37 +0000 (UTC)
Date: Tue, 7 Nov 2023 11:02:35 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PULL 00/10] Hyper-V Dynamic Memory Protocol driver (hv-balloon)
 pull req fixed
Message-ID: <20231107030235.GA952729@fedora>
References: <cover.1699279190.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lujxUvorvES5oO/U"
Content-Disposition: inline
In-Reply-To: <cover.1699279190.git.maciej.szmigiero@oracle.com>
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


--lujxUvorvES5oO/U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--lujxUvorvES5oO/U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVJqMsACgkQnKSrs4Gr
c8hLPAgAgOjReLGYrNNLbCzE3NwIi+vPR33Y/kmy0Xl4Vhj4kngL7zuJUSJdY5Z/
ya9PJXm2Iw/STNswmj3S+a9KeqySPhkg/N7ubHVun0qByGHaO7qDqixs/4ZlmRKZ
E7+NrhI6TGzUnada5nZhOn1BfyqhHcca9Pjl/qW8JeAUxL14TdgXB6IvFb+YFJZh
JTgmWvrLmeoIXsSB3aNCyNHKBi6HrtZMdwLUdC4NPnAjhZRZUPtrare+mocIUxAc
Vtw0Qx1YjJgjpOV/oirmm0jPcs/ck8qwJL/QH1Tb8F3cQ7w9aYrMybVhDT2Xo9Og
KvcfGGxREcnpH/arsxk9hkm4tgSquw==
=/2qn
-----END PGP SIGNATURE-----

--lujxUvorvES5oO/U--


