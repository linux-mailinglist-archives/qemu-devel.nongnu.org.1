Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9BA78BA15
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 23:15:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qajZl-0001og-8O; Mon, 28 Aug 2023 17:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qajZj-0001oK-9Y
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 17:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qajZh-0002Nv-2D
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 17:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693257304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+k9KXqpV3XTEO1/N2HJSjoa1z/IRBroqYNHe0mFejs8=;
 b=DvzpQHESiJqe4MaP17RaEQfo4ZELBAePeXA596NYpdkSbdBQ2ojhWdjCI2bjjNjqPAY6NQ
 Q8KPbqEhfB2+xBf6PSDTidIAlbfEVVXmw1vJKUV7ZoR3iygftX0GsWIG4mzsVc6Ea1X5EZ
 DGFy+JqeUN6ARDdApMeFZXoQDDSdznE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-6Pr85QtUO2OCX8vxKxNbzA-1; Mon, 28 Aug 2023 17:15:00 -0400
X-MC-Unique: 6Pr85QtUO2OCX8vxKxNbzA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41E0A1C09A4B;
 Mon, 28 Aug 2023 21:15:00 +0000 (UTC)
Received: from localhost (unknown [10.39.192.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB71B4021B9;
 Mon, 28 Aug 2023 21:14:59 +0000 (UTC)
Date: Mon, 28 Aug 2023 17:14:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 00/48] tcg patch queue
Message-ID: <20230828211458.GA70641@fedora>
References: <20230824182854.1572951-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UW3kr4YiWIBjvJe1"
Content-Disposition: inline
In-Reply-To: <20230824182854.1572951-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--UW3kr4YiWIBjvJe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--UW3kr4YiWIBjvJe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTtDlIACgkQnKSrs4Gr
c8hDGAf9FQSxvfwwMDfQK1k0LeFgXx9s560ksL7YUqnOYqAxvWUue6TvrRZjUjUB
CxjO0J9Y9HBo0nApCRGwhBhfUdZam0oGMKVwBkVP4WHeAi2yse+N0pFc465abRTZ
0AWGygtFLgqUq6Qo7kp0LjztroHQMiixQU+HHTuK5Tu2q2hJXPpn1CNlQdKSVlvF
Og1ZKVf2gaI4ad1xudK0zjM5pesRnA3pKz2NLTKdPmW7SjCHR9bXlZ2SxFLY4Gp/
3wOcBh55ES7JC2TlVVf+FfWlCAEphxRUkudJ/YxnT7cU9gBBDV9ZGPkhgkMuO3jo
v3k6W+4fNoppxLzZJBt50vjYbTAOyg==
=N80+
-----END PGP SIGNATURE-----

--UW3kr4YiWIBjvJe1--


