Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBEE78F101
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 18:16:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbkKY-0003zd-TD; Thu, 31 Aug 2023 12:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbkKG-0003xF-D0
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbkKD-0002St-An
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 12:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693498515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tI/+XH48l2+uMbdY+sc9xjk+JnMNsqIHZ03LKdP/lE0=;
 b=I74szP2Y3bBMQhzvkYjBAdyCDO6QxgaRBOYZhrGcFF6yxMmXjEun+POL2ybyf1iJ+bY8lt
 +Qma7+FmApkI+b83GaWMPCJ5TzrcXYEXqV/1XbeBt/5QSuNWdXuuen15PH+cxilWmnjpd4
 4nL870uS18Dqu9a7mtDtVvxHUTU65zI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-PvlMjb9LNyiRYXPgxvfq6g-1; Thu, 31 Aug 2023 12:15:13 -0400
X-MC-Unique: PvlMjb9LNyiRYXPgxvfq6g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5570F3803907;
 Thu, 31 Aug 2023 16:15:12 +0000 (UTC)
Received: from localhost (unknown [10.39.192.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E49DE413709;
 Thu, 31 Aug 2023 16:15:11 +0000 (UTC)
Date: Thu, 31 Aug 2023 12:15:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/24] target-arm queue
Message-ID: <20230831161510.GA541302@fedora>
References: <20230831104519.3520658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="R3o6wLAgoWgtGyir"
Content-Disposition: inline
In-Reply-To: <20230831104519.3520658-1-peter.maydell@linaro.org>
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


--R3o6wLAgoWgtGyir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--R3o6wLAgoWgtGyir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTwvI4ACgkQnKSrs4Gr
c8hPmwgApOi8IcVmh5stctXroVraApuTBBqXsNmFj2yQDUukTHZxPNdq1iVYM0z6
h35KXk5KKGmjmUcwrpkQ0Im+CoRj3ffZqDYNuqxERjarW6i1Ack/OgjcQoVkFB+n
/qOkLxqCV9ibQDrBKa3w1/EbGsAgGwHP0ovEzXN5Vcf0JapsObfnKSMXQ1m127NF
eEPq7sxCOSyca9R5av94PLHjpniMTIM+VoaYxd4okQiXdSpkShks/kHoOTzYUj5E
4ojtozw18x4cxsjXs4HKB0yppK5ellSx3oBNtVVLaHq2EsNpTEIgP4yle455LbiB
0jkpmnFvVvHQHp21z5btNQiZaoC4bA==
=X/RM
-----END PGP SIGNATURE-----

--R3o6wLAgoWgtGyir--


