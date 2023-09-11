Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2CD79A98C
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:20:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfihP-0001j0-RP; Mon, 11 Sep 2023 11:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qfihL-0001hr-JX
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qfihI-0007DX-Lj
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694445570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TUVq1AV9hXaQsxONKXJGM5byhgfuUUmyG/HZyO6Ul/w=;
 b=aL+arLfcjeg8abfXkbagEFRFW5SIpWZxoDLyBbLqoXRUsKj3CwEn2VsCGZG/7WiMDmN1yb
 0Ay3an/1sK1lYDWv+fW80sMoOAEaRigMvya8Z5kQOzw12q7VF8KSYf8ak3Jap1BcedBwKh
 D0EJ96orkw5LuId9SU1HCiUia323pRE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-x0H23sSwPxmkA8h8e7rU5Q-1; Mon, 11 Sep 2023 11:19:28 -0400
X-MC-Unique: x0H23sSwPxmkA8h8e7rU5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63B091C0514A;
 Mon, 11 Sep 2023 15:19:28 +0000 (UTC)
Received: from localhost (unknown [10.39.195.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFBBD4402E;
 Mon, 11 Sep 2023 15:19:27 +0000 (UTC)
Date: Mon, 11 Sep 2023 11:19:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/15] Block layer patches
Message-ID: <20230911151926.GA4101441@fedora>
References: <20230908171139.397473-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="34mSj0JL4wGxr2zC"
Content-Disposition: inline
In-Reply-To: <20230908171139.397473-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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


--34mSj0JL4wGxr2zC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--34mSj0JL4wGxr2zC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT/L/4ACgkQnKSrs4Gr
c8jf0wf9EyxqAntmPJSjiTBR6vexOErojIABGfMt/fB/YmgoWzWq10tpvFM0VNQE
cFJdSWmNWj0iADfLlHrLV0Rz7X1CvBF7xGo9Fx3c6J5aNLJ9VpouPTd5AqnhfeHr
C1yRTa3cpZNXW9tFkk9hnHlArTHQqaxHxYjBnwzkS17tJqh6EaqdK5+V5qysvMwy
PM56EwQskC6dIO2yhLu2X5OE9lchJEJL+126I1s3+Z6+AcUhaADLH6FKv30ZPSmj
dUUDUFpsudfKWhKw5rXfJ8bqIZtIpE3VxUvSXWC79xTMk0qLFvDJ+mtgEZyw0B8h
1OyjgZvxcipC1Z+GppS0yhFmXnQzYQ==
=WuT5
-----END PGP SIGNATURE-----

--34mSj0JL4wGxr2zC--


