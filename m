Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E55DA5B83A
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 06:05:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trrmq-0000xU-G5; Tue, 11 Mar 2025 01:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trrmc-0000vG-Ps
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 01:04:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trrma-0006Na-Vn
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 01:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741669437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0QtkeO9g82YiM7g8XvcvyvcYbQc0JwuFGrybPcor47w=;
 b=F9HhR25+97NEW5NvGASg3mYMe/F8DksGsOH5VUhP9JxnUKOATI/WTcuIdmRHTtbwk9WTr8
 rfro8ryNc+YoQBCQX7QVU12M5JzS/kAbnaqVePlgQs+HouxXufE3pmD5fakG+ATHZlwqnY
 k7Skx1YB719fVlEcrGCYYy8UaiW9t4I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-kHXdbFirNWCadaTvYfcDhQ-1; Tue,
 11 Mar 2025 01:03:54 -0400
X-MC-Unique: kHXdbFirNWCadaTvYfcDhQ-1
X-Mimecast-MFC-AGG-ID: kHXdbFirNWCadaTvYfcDhQ_1741669433
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 517F0180AF4C; Tue, 11 Mar 2025 05:03:52 +0000 (UTC)
Received: from localhost (unknown [10.2.16.75])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5810A30001A2; Tue, 11 Mar 2025 05:03:50 +0000 (UTC)
Date: Tue, 11 Mar 2025 13:03:48 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL v2 00/31] testing, plugin and maintainer updates
Message-ID: <20250311050348.GA602793@fedora>
References: <20250310114957.3401710-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2Bpix0fXp/9Oyl4u"
Content-Disposition: inline
In-Reply-To: <20250310114957.3401710-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--2Bpix0fXp/9Oyl4u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0 for any user-visible changes.

--2Bpix0fXp/9Oyl4u
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfPxDQACgkQnKSrs4Gr
c8hWbQgAoNDrfGUD+a+sWWtBRYy4a0kNgd3oPh6aTtP2tOasiMskaz+kFevwFt6E
oHTjpV0hyzgORRXrgYHsG0BR6GQeidtZ84MIGqxtc7I2mJVN5j9G6D5ulapYvpVB
dZXKVcvr9EDiKfCbKKOElKtqeTHU+PvZjrHNBpAv0YCMZV+3yaO2/QNtPwvh668l
lmn6Nh02bVzlKYANRfh2uuv1P1UoUhXYeBm1RK30zS6dT7W4I+eyJVySidJoqLpG
iL3FU+fCOnJyJeJr+7dEBXQhmI/6ujH11mAIn1kI07qJNwH/9SGjnipxGXcjFtL5
lR4s/qRv+xpL9BUUbWi+SzRhaOV+3g==
=qVR7
-----END PGP SIGNATURE-----

--2Bpix0fXp/9Oyl4u--


