Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2CD7F3207
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 16:13:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5SQi-0007iM-Lz; Tue, 21 Nov 2023 10:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r5SQf-0007gS-1U
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:12:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r5SQc-0007ju-7K
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700579559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V2MCfwbq1+rUPZnj/khnb2Q5CuTWA+jhxGxBhXeLRLQ=;
 b=YhoZ/OUNMvYuKqEvaajC8xoNMEAMMzsdqE7QXp8ooCzsk7JOmjC2fiIeU/m+puNViRUFSG
 LBU8jFXHGOURXStfTX3Ce8lz1Fy63WDqMs6up2PQeVHH1bjZelNPNUuyWqgK4N1EIfPVLR
 LODHMFns0B8+Rc4WCNZa3up+0gJb2Ws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-3FLNu0eDPdy6XupnoyCLTA-1; Tue, 21 Nov 2023 10:12:37 -0500
X-MC-Unique: 3FLNu0eDPdy6XupnoyCLTA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59D2585A5BD;
 Tue, 21 Nov 2023 15:12:37 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A46A91121306;
 Tue, 21 Nov 2023 15:12:36 +0000 (UTC)
Date: Tue, 21 Nov 2023 10:12:34 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 0/1] loongarch fixes for 8.2
Message-ID: <20231121151234.GA3480241@fedora>
References: <20231121022219.384628-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="q+/B9HW/Qy7v2CFH"
Content-Disposition: inline
In-Reply-To: <20231121022219.384628-1-gaosong@loongson.cn>
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


--q+/B9HW/Qy7v2CFH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.

--q+/B9HW/Qy7v2CFH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVcyOIACgkQnKSrs4Gr
c8iWxAgAv9BY1pFj/ZH+FwvcMQ+mEq0912G6ZqSCSs8T5yx15DHxVrEwZHtWbusu
6eQTIU8l6POlROBwZaS2RXSb1RPdtVTHibKhDsRUCuEG0BpQTup16Crw1AvnFR+0
w/13+DrSgPyPJxxhB+W0/ALVi8tkwhrtnfmdDFEDZ9be36fqxmu4e1xmda//jyMP
pl5SIsmVnMLjNrXx1IIvcAql1ckE9BaKf2PJDTq6aILrPqqpuaeUnmWSVCiTdqKj
UyPa3vdDmIOoD2RpM36CYX+ogrp0HG7lnHjx94BPse4qgkLg458629K8EROGwQAX
ZPLyA5JGL++TZTZoqX8dZAitz5bFsQ==
=qB2x
-----END PGP SIGNATURE-----

--q+/B9HW/Qy7v2CFH--


