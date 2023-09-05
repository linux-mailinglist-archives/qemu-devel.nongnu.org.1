Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9EA79240C
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 17:45:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdYDT-0003Bz-MF; Tue, 05 Sep 2023 11:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdYDR-0003AI-G5
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:43:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdYDO-0006Qj-7t
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693928618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a5WGAJZyp73IyeP5m9wRPrGJch89yloHcw/0SyiT6tM=;
 b=If1C5ZVT9EI0QdVW0RRYXJtr4WEXG8c4RdtMLptFMkc4Amqr/Y4XRBj8bU3m1vp6mNRX5/
 +5SQpeeCc0Uusit9sT3vANtdi/cKbKczhlRF4sF6t3dIl5pUe92DxizwGmtZEFDBm8wpKA
 EEV3k7s4O9PK6TJpQxphnTXv28TDIH8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-DFMjWM7MMpmD8m-kcRPADQ-1; Tue, 05 Sep 2023 11:43:37 -0400
X-MC-Unique: DFMjWM7MMpmD8m-kcRPADQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8F57928E6A
 for <qemu-devel@nongnu.org>; Tue,  5 Sep 2023 15:43:36 +0000 (UTC)
Received: from localhost (unknown [10.39.192.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4824046F522;
 Tue,  5 Sep 2023 15:43:36 +0000 (UTC)
Date: Tue, 5 Sep 2023 11:08:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/7] s390x and qtest patches
Message-ID: <20230905150853.GA286544@fedora>
References: <20230831191719.140001-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="reJVwgz0MG10zAAb"
Content-Disposition: inline
In-Reply-To: <20230831191719.140001-1-thuth@redhat.com>
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


--reJVwgz0MG10zAAb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--reJVwgz0MG10zAAb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT3RIQACgkQnKSrs4Gr
c8ivrwgAti2JEo/kvbF8/CW0UWtANQi4FzT9B8NlCouuSUfKlpktZ/wm0kYJTcSG
X5cJvzInm59Iro7hDiymJ7hSgIOIvh45WFNs1VdRsuFpYWu0MPaPOQIHOwBJt6Tx
ZvXKFpqKnWGX4c1BB0HYu2G7qkGG9066sHEV1DbX/Axlb1n6TTpNBAvcqIvNvrXP
HL+R3sn7sp1SD5f3ACi7mcpOa+w1cIbu5/Wcucg9JKWQt2MyZFZwAl7w0AI+jB9j
tpzbVP4ySuRVzw3+897F/97NjBw4/YgA9AGc8wVBdEb14lFqlzDAVIk4WnK7G8sj
cauO+demErON2VdUZ3WAfOh85So82Q==
=4bm/
-----END PGP SIGNATURE-----

--reJVwgz0MG10zAAb--


