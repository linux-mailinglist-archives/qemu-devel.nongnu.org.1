Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0F17CB34B
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 21:21:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsT9f-0000AZ-NM; Mon, 16 Oct 2023 15:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsT9c-0008Sm-QL
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 15:21:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qsT9Z-0005ff-Qk
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 15:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697484063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rWgyrDAPa3/joeLpJU+imlLGd0Sgi3MVpT3Vqb3s5js=;
 b=J6jI1gE2WAQxAHZq/Xonhsf7J/aivLRhMYTmuykedVr8Z9wrr4hTCR0y8ijmr/4m9wA0SQ
 ZOAq2IBUIYm7BNFA17U0SVqrzAaR+tgJx7n+ZtDEHgn+jKWrH1+oHWBR0Ct7yBB5vIvCLg
 ymgrdnYklEssIk8jWE3PWb/xJUjwUOU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-VNAMNlMgPwygkwppmtR0mA-1; Mon, 16 Oct 2023 15:20:52 -0400
X-MC-Unique: VNAMNlMgPwygkwppmtR0mA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0206029AA2E6;
 Mon, 16 Oct 2023 19:20:52 +0000 (UTC)
Received: from localhost (unknown [10.39.195.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A6C3492BEF;
 Mon, 16 Oct 2023 19:20:51 +0000 (UTC)
Date: Mon, 16 Oct 2023 15:20:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, stefanha@gmail.com
Subject: Re: [PULL 0/7] loongarch-to-apply queue
Message-ID: <20231016192050.GA161348@fedora>
References: <20231013081750.2944412-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZgoT/SRheVdweEVL"
Content-Disposition: inline
In-Reply-To: <20231013081750.2944412-1-gaosong@loongson.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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


--ZgoT/SRheVdweEVL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--ZgoT/SRheVdweEVL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUtjRIACgkQnKSrs4Gr
c8gBJQf+M3z0vVo4iWmY4eZFCCtTg6FKuq5WXgaFtyScnF/m5Z8YdM7M6RSW4Iav
4IFoPoeuhHmddsjrQ8BHV4LmqvQrQW4gvK5djDvUYEnjIz8umMQsOsfUhTzvKJ6D
bzwku1TaXQXSdiuviJ0y1SM/zlGKfKvyRl5KYRRw18l12wepKWlvv4+5XiDEdY6C
s70yUriGATE6qX3P3wI7Of5QIHPTjPQjpYmLdwcpnduMtd7coofeIuaZBtJT4dPz
HiHiSB6k1WIoKlcOk8hNyxn68Jp6MCzxvFZ5zT4agmzLU6dbcq888R5agnh+YtIM
5mtm6JmprDN1lS5dw2vE9HTJTPRFig==
=H7Bz
-----END PGP SIGNATURE-----

--ZgoT/SRheVdweEVL--


