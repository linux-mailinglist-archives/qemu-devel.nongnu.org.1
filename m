Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A0D7E336A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:03:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CMq-0002O3-OS; Mon, 06 Nov 2023 22:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0CMo-0002IB-Po
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:03:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0CMg-00008k-RP
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699326173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F023wEQYEG2XoKx2EpsCETuLDwMkKMsZLBcnsen8ntM=;
 b=Nr9eUIgJJyozznPJnCLgDJ4G6q/31QMkbz7uPcyy3jH+N5aAfqdjZnl+7rNjUU7YBqs1He
 O2A8kqU+W1RvWHY9D1sgr1hov9XgczXxFJ9ssZGT0U0fRj1mEvtLxeQOmQ/nKuGXLv0+0h
 AyXAt/cHakqlNJeELAEtsfUAL9E3kTg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-pzjuRJzUMd2fUVZD0kKduQ-1; Mon,
 06 Nov 2023 22:02:49 -0500
X-MC-Unique: pzjuRJzUMd2fUVZD0kKduQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74CFD381CBB6
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 03:02:49 +0000 (UTC)
Received: from localhost (unknown [10.39.192.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2E4A1121306;
 Tue,  7 Nov 2023 03:02:48 +0000 (UTC)
Date: Tue, 7 Nov 2023 11:02:46 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PULL 00/22] vfio queue
Message-ID: <20231107030246.GA952815@fedora>
References: <20231106143653.302391-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="StvLpSK85yD5Bxmc"
Content-Disposition: inline
In-Reply-To: <20231106143653.302391-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--StvLpSK85yD5Bxmc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--StvLpSK85yD5Bxmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVJqNYACgkQnKSrs4Gr
c8gzxwf/QlGApxRRjr0fSgtWb960x+WRplkggr83VQa0POOA1hCJrRBdl+K8NdlJ
DHu2C6zwxmsSWpf1Fsr0jQCO9LTGeubUOGysqkoLa/WtUiplxpVQHT82URI+fTKg
1nrDppl6TUf2bToV9vZFYQWXXdK6V5gfb0LweDec6mLCEODpTJzyxjWaOD6Rh0Kr
sqtL+JRSthJs4eDyz0ea7HWqdQmtNGBRptypzpBnvFbnbTvJoWm4af7b5kY5ptnM
/OlSdWj0x1ut0yq0r7NIVIwuDa0xRW0G8aG2hkw7ncHorU1Vp7SkhKZPEMUI1FQT
HYtgI+4CKvEGEwjVYLgfoML+v9EZqw==
=OZ8D
-----END PGP SIGNATURE-----

--StvLpSK85yD5Bxmc--


