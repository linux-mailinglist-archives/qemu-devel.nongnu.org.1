Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A31C81CCAB
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 17:20:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGiEh-0006pO-BZ; Fri, 22 Dec 2023 11:18:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rGiEf-0006p8-Qk
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 11:18:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rGiEe-0007wj-BX
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 11:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703261931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jPmkgVDXkHrz749bsNiHbZat0upDiJWhH+wKU+51AsM=;
 b=Sn8T/EwVlX5mrUhewZiXiHdJ+Xd8UvsI1p4IuPVcYWWPh4vaaO2GjB5srpSnoRWKYGfDAz
 QPAstVYvDT8V98XeL9zLn3NzLql84rVPCATCfG+2TkOw1pdU5zq/FdRy3XJ04o9OPA3r9M
 iQ8qbicYD+fprxbPcPjz9hXMVjaoEB0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-jjbIYi4_O5WoSjkJX6_FLQ-1; Fri,
 22 Dec 2023 11:18:49 -0500
X-MC-Unique: jjbIYi4_O5WoSjkJX6_FLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 166043C0278C;
 Fri, 22 Dec 2023 16:18:49 +0000 (UTC)
Received: from localhost (unknown [10.39.192.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 948073C25;
 Fri, 22 Dec 2023 16:18:48 +0000 (UTC)
Date: Fri, 22 Dec 2023 11:17:34 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: Re: [PULL 0/2] loongarch-to-apply queue
Message-ID: <20231222161734.GA13799@fedora>
References: <20231221080611.2960977-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kxj7drvHosHHPmLv"
Content-Disposition: inline
In-Reply-To: <20231221080611.2960977-1-gaosong@loongson.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
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


--kxj7drvHosHHPmLv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0 for any user-visible changes.

--kxj7drvHosHHPmLv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWFtp0ACgkQnKSrs4Gr
c8gJRAf/VTjcKMgke9pHrveaK8hRDgGgcrfv02gbeGLpXoyqOBmOmbqWU+REg1X/
ED88iKU07kww7gP/FK0OdNUHcgoGYBUZ6TVZIi7IVcpTu3o+vOQ6r83UwrNjOOrZ
QsuluXflcZ0cFuYjpDm+G5GelR8+dW2yLmMH7Od2fa0fC249gIlZeG5wu5bgGLf9
1rYPmDG9kpX7r4Gq3nbiVTPB9rr2UmMW0Ejkz8orOP9HzWqkd2VMCkQLD5JnlqiZ
Qbjcu1mN+nwYq0x1P3qM1Y7jgApaxxNbPVJnq6Wt+/PaxcKLRplLBgsDbUz9bKWi
vKY9bAh/O8Ih54cbezw8NNVPMbG5gA==
=v3a2
-----END PGP SIGNATURE-----

--kxj7drvHosHHPmLv--


