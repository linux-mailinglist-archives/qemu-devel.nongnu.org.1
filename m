Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF67E758658
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 22:58:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLrki-0000Xx-R4; Tue, 18 Jul 2023 16:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLrke-0000Ur-6Y
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 16:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLrkc-0004M4-8M
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 16:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689713813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yTFXfKu+Uh0qiaNk1kypzI+QRzqFwS3GBjgyDvSb7DE=;
 b=KEd7n19rRZFouv2lrCE1EY1zfRwfQUD0+25WgWr6s2jXhr6Aobykog5T1GzM520RXE51F5
 9T0O7oJgErn+yQn/t2WiYpCDvpiTInweEcumJxZdjZ+VbPADbR3nimU0Q4e8tgnJyXOTKP
 rdsd1PynhTcKj+5U0UVVzJAkN7c1SfY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-Oygc1tH3MmGtknH1EYnWtA-1; Tue, 18 Jul 2023 16:56:46 -0400
X-MC-Unique: Oygc1tH3MmGtknH1EYnWtA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E30B282CCA2;
 Tue, 18 Jul 2023 20:56:46 +0000 (UTC)
Received: from localhost (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66097C2C8DF;
 Tue, 18 Jul 2023 20:56:45 +0000 (UTC)
Date: Tue, 18 Jul 2023 16:56:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, hreitz@redhat.com,
 k.jensen@samsung.com, kwolf@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, philmd@linaro.org, thuth@redhat.com,
 Jeuk Kim <jeuk20.kim@samsung.com>
Subject: Re: [PATCH v4 3/3] hw/ufs: Support for UFS logical unit
Message-ID: <20230718205643.GQ44841@fedora>
References: <cover.1688459061.git.jeuk20.kim@gmail.com>
 <f88df6b8f0fc145b8a9bbb66ccac49721dfddbad.1688459061.git.jeuk20.kim@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2FQgZNh40++CBBLW"
Content-Disposition: inline
In-Reply-To: <f88df6b8f0fc145b8a9bbb66ccac49721dfddbad.1688459061.git.jeuk20.kim@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--2FQgZNh40++CBBLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 04, 2023 at 05:33:59PM +0900, Jeuk Kim wrote:
> +static Property ufs_lu_props[] = {
> +    DEFINE_PROP_DRIVE_IOTHREAD("drive", UfsLu, qdev.conf.blk),

This device is not aware of IOThreads, so I think DEFINE_PROP_DRIVE()
should be used instead.

--2FQgZNh40++CBBLW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS2/IsACgkQnKSrs4Gr
c8hqogf9FOTBbN4xNkd3ZGNAbB7PYIHf/SxXOX02ytL0MqLofgkz1YkpGE8wOldI
QIrHHCOO57Bc31xobmziSK08s9/XN+Ugw0AYnQVZSVCakPmrCoc+7XMB5ylJZ4Ly
T5XzkRFRNX2ca532nqdOklzL58EKc8px0CqObYvONRDnhX2zYKQ8ZtdAZjvJRBQo
YAVWk3PLXD6G08zO3rUvNSoRkzwJ9d8UliJhhRrMxjfarr4euAPe60RX6d1K+fe3
o+0wRxeTsQdyuqWWnJGjpTWwzGSC0/W9mdpHUOybljp55io1ezR3zcdMuVoLOdXv
tI5YCMXsKk3+Iwxm0kxX8+ddn200Cw==
=Xxai
-----END PGP SIGNATURE-----

--2FQgZNh40++CBBLW--


