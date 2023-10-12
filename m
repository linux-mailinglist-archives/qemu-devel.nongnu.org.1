Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B577E7C88C4
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:35:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrKBv-0005E4-Cg; Fri, 13 Oct 2023 11:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qrKBc-00057K-3k
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qrKBa-0003VP-2u
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697211285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6w3Gjd4KpxH+o7tPBz+LZSQXQnBk+2VFyDSxf6tC8K4=;
 b=O1q3AfqJRiu/8I1btUflRWMEpgjqApJGYvTKhfI0apkGrTP3qxw5VW4dyb41PRXQvDfhyp
 wPCuNm7i6rMJf1WffeFTPgzlz6PX4VLQaiwv+pvnwM4m/U7Ym0wlo7m/LnnFL2ee6RZ+bg
 S7Gevt8LlbU5Cm31Pi5HwFVJCDLsDm0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-ie26iDEKOVaJTdxL13JPMA-1; Fri, 13 Oct 2023 11:34:43 -0400
X-MC-Unique: ie26iDEKOVaJTdxL13JPMA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 110BE29AB416;
 Fri, 13 Oct 2023 15:34:43 +0000 (UTC)
Received: from localhost (unknown [10.39.192.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 997C7C15BBC;
 Fri, 13 Oct 2023 15:34:42 +0000 (UTC)
Date: Thu, 12 Oct 2023 14:51:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PULL 00/54] riscv-to-apply queue
Message-ID: <20231012185137.GA370885@fedora>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aHWL6+yQ2PFSXF7U"
Content-Disposition: inline
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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


--aHWL6+yQ2PFSXF7U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--aHWL6+yQ2PFSXF7U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUoQDkACgkQnKSrs4Gr
c8heogf/eG4skbqkEsyTRH8CtpIc/vCpF4+/a0SFJo1FdutijgSBlpEm+CVtKI0u
Jut64XNycznLrl+DcqTsbHaKVQLrY+CxWvCQM/6ROpihXMycmg4RhLp3qZmeOPte
WFBGUBdFJ2+MMJG0WAJxqxEP2OCjulXqtWC5EPi6mhN1vvytMEsGy/yqI1btLRlY
QBjjYE67a5/6XNi+AgLKlQ/OQIe5nGUQ7yrvd9XrZjq9tAiZvWqU20m+dq/DqSgw
AsdRyvs417xJMrhQgNuO1aeA2Ot/jllO+7DtxPphabzLR5FBAI42QGGuYczvjlHP
cwLu0Igd2+0Qq+4xyQlry67uspWbyA==
=tVG1
-----END PGP SIGNATURE-----

--aHWL6+yQ2PFSXF7U--


