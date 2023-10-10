Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C837C01B5
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 18:33:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqFer-0002K1-SV; Tue, 10 Oct 2023 12:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qqFeq-0002I1-Dz
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 12:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qqFeo-0000tE-Rs
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 12:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696955548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CU/wSf0m9/lSY6IBx32P2qfRIeOLie024vsmGCsGmYY=;
 b=dd9h5jJ2MWvmq4marSK9RkSFLGKrD6P8UBILufo0pvkmo/P3xezaTMw7vzx7egj+h1/kh3
 Zd/Yg+R5+l7BP3ObIEf8tDq3JNflpZ5pNdN2uA4QvmnQdFQfobp01jJPNy7BMufR6nIfiG
 /H5EIOHhkYytVm83UqjRGOVa6s7cI/8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-STo1VNHCMr-SaivsbfF7SQ-1; Tue, 10 Oct 2023 12:32:27 -0400
X-MC-Unique: STo1VNHCMr-SaivsbfF7SQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 192BD1C2B66D
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 16:32:27 +0000 (UTC)
Received: from localhost (unknown [10.39.195.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FF3220290AD;
 Tue, 10 Oct 2023 16:32:26 +0000 (UTC)
Date: Tue, 10 Oct 2023 12:32:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PULL 0/6] Firmware/seabios 20231010 patches
Message-ID: <20231010163225.GA1754330@fedora>
References: <20231010112610.2618091-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="acxoTCRx5fSEdMDK"
Content-Disposition: inline
In-Reply-To: <20231010112610.2618091-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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


--acxoTCRx5fSEdMDK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--acxoTCRx5fSEdMDK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUlfJkACgkQnKSrs4Gr
c8iaxwf/fHQQ3zvMjzUWHMAIHzZAuAXXp4bRG1/uNPjILCa0QZou5MLr09xAN99C
LiXxYBNWBSnKPkSf19vTLSHJw0XZZjFqWCkYkd70Bahgu3JPOcdkG9wLztR5DKJg
yMJcNJy2a9d9LLcuPlLE8L8d+NRhztX+JCKpKdRLBIhZ1OREe1OLy4QhfhP/fc7Y
DLe1We2Xb725SjEmjw416pSqkncAzKRi081euhE4gVKXS/QJZm+x0+S3JuexJpWK
ePHzbyvGGpqSPzmbyIWpZQvCKZS7iAqH6V3CtW2IukHpIKmfNSyZVbW+BM+i8HBW
GrP3M5opKn7p9wy57ot5HKPjSObDRA==
=4xcu
-----END PGP SIGNATURE-----

--acxoTCRx5fSEdMDK--


