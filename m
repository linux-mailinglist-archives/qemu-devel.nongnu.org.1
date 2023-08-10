Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDCA777A3D
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 16:14:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU6Q5-0006Nm-Bp; Thu, 10 Aug 2023 10:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qU6Q3-0006LV-O3
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 10:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qU6Q1-00049x-Tb
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 10:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691676820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WxYXM6cRU3VgO4HqnDK/7ut3y9KuKig5mKLrs4m51yE=;
 b=eJmoE/Qq+qRPl3bzA5/+RfhUyQHTTgHLDDGEjbgCgsUSBJZzCS+Xr5YQgWJ1eiRo77nfSk
 /GvYgzELs7YZnJ5tR07ayf99PeyUlSjzWFRBs0kDkOUxuRO6TUmAWJCX3wW5Pn3x/7yAwi
 umcfYfymyXErZXqYXJhYJ/keV4kn6C0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-DFk5jPS6MQeqBjCgWCE0JQ-1; Thu, 10 Aug 2023 10:13:38 -0400
X-MC-Unique: DFk5jPS6MQeqBjCgWCE0JQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E024E8DC661;
 Thu, 10 Aug 2023 14:13:37 +0000 (UTC)
Received: from localhost (unknown [10.39.194.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5EF275CBFF;
 Thu, 10 Aug 2023 14:13:37 +0000 (UTC)
Date: Thu, 10 Aug 2023 10:13:35 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "longguang.yue" <kvmluck@163.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, "mst@redhat.com" <mst@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: LTP test related to virtio releasing and reassigning resource
 leads to guest hung
Message-ID: <20230810141335.GA2931656@fedora>
References: <461df15f.15e2d.189deaa6eed.Coremail.kvmluck@163.com>
 <38e69323-0185-32bb-2de1-8e5b36de2abc@tls.msk.ru>
 <3c1a93da.16493.189df040e16.Coremail.kvmluck@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="C0aUbutZkQIXwC4Q"
Content-Disposition: inline
In-Reply-To: <3c1a93da.16493.189df040e16.Coremail.kvmluck@163.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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


--C0aUbutZkQIXwC4Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 06:35:32PM +0800, longguang.yue wrote:
> could you please give me some tips to diagnose?  I could do tests on qemu=
 8.0, but product environment could not update.
> I test on different kernel version 5.10.0-X, one is better and results sh=
ow problem is more about host kernel  rather than qemu.
>=20
>=20
> test cases are different combination of i440fx/q35 and virtio/scsi and ke=
rnel.

Can you post the guest kernel messages (dmesg)? If the guest is hanging
then it may be easiest to configure a serial console so the kernel
messages are sent to the host where you can see them.

Does the hang occur during the LTP code you linked or afterwards when
the PCI device is bound to a virtio driver?

Which virtio device causes the problem?

Can you describe the hang in more detail: is the guest still responsive
(e.g. console or network)? Is the QEMU HMP/QMP monitor still responsive?

Thanks,
Stefan

>=20
>=20
>=20
>=20
> thanks
>=20
>=20
>=20
>=20
> ---- Replied Message ----
> | From | Michael Tokarev<mjt@tls.msk.ru> |
> | Date | 08/10/2023 17:08 |
> | To | longguang.yue<kvmluck@163.com> ,
> qemu-devel<qemu-devel@nongnu.org> ,
> linux-kernel<linux-kernel@vger.kernel.org> |
> | Subject | Re: LTP test related to virtio releasing and reassigning reso=
urce leads to guest hung |
> 10.08.2023 11:57, longguang.yue wrote:
> Hi, all:
> A ltp test leads to guest hung(io hung), the test releases virtio device =
resource and then reassign.
> I find device=E2=80=99s mem prefetchable resource 64-bit is changed.
>=20
> ltp
> test: https://github.com/linux-test-project/ltp/blob/522d7fba4afc84e07b25=
2aa4cd91b241e81d6613/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tp=
ci.c#L428
>=20
> Do you know what cause the problem?
>=20
> Thanks very much.
>=20
> --------------------------
> ENV: kernel 5.10.0, qemu 6.2
>=20
> Current qemu is 8.1 (well, almost, to be released this month;
> previous release is 8.0 anyway).
>=20
> This might be interesting to test in a current version before
> going any further.
>=20
> Thanks,
>=20
> /mjt

--C0aUbutZkQIXwC4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTU8I8ACgkQnKSrs4Gr
c8iftQf/VbD9nqCTiUqYNyNgpBMqri6AccV8q9Bl8Cz5cyCjt1cg0Fry3XWudOzS
mNOj+3NMhcLdeVJ8RUSslk2/dFtbJN8DjVrKVAyaJt4lzZAtdcwk7EkazgifFXio
+S9Qp/HTHltKKubizxkOcrztPdxJVQroftYiM4gMQFU66153jj+CQR0HifEpaSIv
BvAijLPjEZCRypnXJctOkOh1X9IhddkXj/WVzaebqNKtzo6nCKlilyzGkj4QWWDq
mXtOls4skkbGQr0109aXYWZ0VC/f8LAG2rdGV7wNvdn2hlan302GV9OANtoAr9zE
RIU30sexogHvshQKciba5s95wgfP9w==
=0C0d
-----END PGP SIGNATURE-----

--C0aUbutZkQIXwC4Q--


