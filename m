Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22845769B4A
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 17:52:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQVB3-0002I9-RN; Mon, 31 Jul 2023 11:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qQVAz-0002Hc-A6
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 11:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qQVAw-0001PC-Ts
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 11:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690818673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VMFuek0uUJbfRXRIBLqXo/g5muPRy+uEg+9LOR88CxY=;
 b=LEgAL0GmT05MMBa7RGSgsipYkSZ7PC8oD5m5AgbjoFtyv0lvAwkwdgHbSY4bo6EBZuiccf
 Q/BpArm4y1dDENoCpAOa8oY1RYutPSNCfFZoVr33Mm/4qSy4AthHm5OZcSt3u1D64jG7Nk
 Gw16VHt/oGviisanmKa5TWw6l4GXbXc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-olUhvVuvPJKWaXEdBOJViQ-1; Mon, 31 Jul 2023 11:51:09 -0400
X-MC-Unique: olUhvVuvPJKWaXEdBOJViQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36209104458E;
 Mon, 31 Jul 2023 15:51:09 +0000 (UTC)
Received: from localhost (unknown [10.39.192.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 992B11121325;
 Mon, 31 Jul 2023 15:51:08 +0000 (UTC)
Date: Mon, 31 Jul 2023 11:51:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Subject: Re: virtio-blk using a single iothread
Message-ID: <20230731155106.GB1253041@fedora>
References: <c206fa1d-077d-ae9b-476f-f43eec36a187@grimberg.me>
 <20230608160817.GK2138915@fedora>
 <d8028f17-8d33-790b-8d3e-fa1170108774@grimberg.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pS4WBcSF+Q2GcTc0"
Content-Disposition: inline
In-Reply-To: <d8028f17-8d33-790b-8d3e-fa1170108774@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


--pS4WBcSF+Q2GcTc0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 11, 2023 at 03:27:57PM +0300, Sagi Grimberg wrote:
> Maybe I'm doing something wrong? Didn't expect to find a regression
> against mainline on the default setup.

Hi Sagi,
I ran the latest branch against ed8ad9728a where it forked off master.
master achieves fewer IOPS.

It looks like the regression you saw was solved by the changes I made
last week.

Both "master" and "modified" are running with 1 IOThread:

                           IOPS
			  ------
randread 4k 64 master-1   213504
randread 4k 64 master-2   212650
randread 4k 64 master-3   211699
randread 4k 64 master-4   211940
randread 4k 64 master-5   214110
randread 4k 64 modified-1 234708
randread 4k 64 modified-2 236014
randread 4k 64 modified-3 235328
randread 4k 64 modified-4 235742

The improvement is around 10%.

You can find the benchmark configuration and raw data here:
https://gitlab.com/stefanha/virt-playbooks/-/tree/1a464c0676fe9133fb244d8a2dd1439001c7bc42

The configuration is in go.yml, plays/benchmark.yml, files/test.xml.j2,
and files/fio.sh.

The raw data is in notebook/fio-output/ and you can explore the Jupyter
notebook by running notebook/go.sh.

Stefan

--pS4WBcSF+Q2GcTc0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTH2GoACgkQnKSrs4Gr
c8h7swf4/ck8r/4Z8OZ4SbLtMJdIes7pDxFwpS343wFSmzGmC/6B5cMt8q+Trl1j
U3Oq7x45gX5SpMUcvsgU7C1xaEAP0fjA9mMgJjh2mxuXYgvkz9HMjyoeQ02K3LvX
dMPCXKRLFZmAukkxrV5twG7IoT9ZGH/50bcbxmLbZPckFZbux3vnfhwUbnr3oeU8
OBo0m1xOz5GW1aoNAmBDriGpU09kdUPTpHdkA3420LB1+a/kYdoZlTP22PjcXJ1U
QlsENySyaiS4N9tL0hLzDSdPiBY/yzrRrlt0YKScVf4A6oSltmIzQcfXHNuJofro
T7emWmyA2Yc+pt4+qn5A/6ROj9F6
=KM9R
-----END PGP SIGNATURE-----

--pS4WBcSF+Q2GcTc0--


