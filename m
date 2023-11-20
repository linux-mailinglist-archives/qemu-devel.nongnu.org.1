Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5927F15E4
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 15:40:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55Ri-00036H-Mb; Mon, 20 Nov 2023 09:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r55RJ-00032q-Jh
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 09:39:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r55RH-0004Qj-Sr
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 09:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700491191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ymD+KHWGeoklQqtYLZDZD3p4cdEXAYl18NPEDDk4+J4=;
 b=YBAi/vFsdCEyUZ2XXIyNUeNRHdB7GJksAJMEZenaFu9la8gkuEd/tm7VzHHHJTgEtvweg7
 Y0PGffwVxtsLWBXL8BCwo9DLLRmF9SLLsLG0xesl6XOfpUxddLyqoeFgtLZQgro6oATNEi
 /warFjt1CyKFfxuiDsUuCoBKiMC4KU4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-8X75_gwMPcO9B4Q-1sqkpA-1; Mon,
 20 Nov 2023 09:39:49 -0500
X-MC-Unique: 8X75_gwMPcO9B4Q-1sqkpA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34EC51C06ED6
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 14:39:49 +0000 (UTC)
Received: from localhost (unknown [10.39.195.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC40F10EA1;
 Mon, 20 Nov 2023 14:39:48 +0000 (UTC)
Date: Mon, 20 Nov 2023 09:39:47 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 0/7] Error reporting patches for 2023-11-17
Message-ID: <20231120143947.GA568850@fedora>
References: <20231117095334.1819613-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BWP1wdL0g7Lpy5um"
Content-Disposition: inline
In-Reply-To: <20231117095334.1819613-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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


--BWP1wdL0g7Lpy5um
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--BWP1wdL0g7Lpy5um
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVbb7MACgkQnKSrs4Gr
c8hV+wf5AZwLiU7K+wR0lQExZOooOPCEIoiK2kLDxRYhQ5RhqdSAzHZkqnKxp5wC
HXuDqHDGRW7XbZlJlXyWau9bJvfVNT9MAdGqJft4Z96aNvVfGdIvgJL38SpzHw4x
SJBVMhmVykBvYXPrfUXCWjJOaxQs/hv647Ji5UHhMepJqoYsuZyZMK528JndG3Na
5Fi68CWWICUDNIqdyCmsVJfE6IGWVuYoQUMNN56IfsgHTrZ7hRB0ZQCxeX9XhJEL
UU2TqFIPAxP+UnuHgBoADPT4FYpHWf4P8OZl1CmQWO35SiypQ5m7Xa92BnqKqhPq
ahhAhx2qKCGU3bjdx46FjFWbff0Cfg==
=ltVz
-----END PGP SIGNATURE-----

--BWP1wdL0g7Lpy5um--


