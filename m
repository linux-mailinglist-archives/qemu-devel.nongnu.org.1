Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1817359D8
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:41:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBG3i-0007Z1-G3; Mon, 19 Jun 2023 10:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qBG3c-0007WW-Vx
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:40:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qBG3a-0006F6-QU
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687185638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xxZ+oMcxxKSX3cys38mFagURnbIkT9nXhAto4riqm9o=;
 b=X5tSjBACFF6kQ0qfJM+l4MUwmNsJij9qJXg2JgJPRg8C1BSyrGJXAGeRl1UFU9Xhxb1I56
 BNGhkA0M60xBXHXqnFbD0VQFrMLYQSy6fR+CWLXM/d0aA6iN0le0kDZhX+tP+4rBt/Ircp
 vyck2FfQiiwebW6hqFGqVVVz+vzyUUY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-j263Iv3CPseJ4kl30Ntalg-1; Mon, 19 Jun 2023 10:40:34 -0400
X-MC-Unique: j263Iv3CPseJ4kl30Ntalg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2842680120F;
 Mon, 19 Jun 2023 14:40:34 +0000 (UTC)
Received: from localhost (unknown [10.39.192.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A60591415102;
 Mon, 19 Jun 2023 14:40:33 +0000 (UTC)
Date: Mon, 19 Jun 2023 16:40:31 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org, dmitry.fomichev@wdc.com,
 hare@suse.de, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [RFC 4/4] iotests: test the zoned format feature for qcow2 file
Message-ID: <20230619144031.GE2497337@fedora>
References: <20230605104108.125270-1-faithilikerun@gmail.com>
 <20230605104108.125270-5-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eZuivMguxG32AiNC"
Content-Disposition: inline
In-Reply-To: <20230605104108.125270-5-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--eZuivMguxG32AiNC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2023 at 06:41:08PM +0800, Sam Li wrote:
> The zoned format feature can be tested by:
> $ tests/qemu-iotests/check zoned-qcow2
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  tests/qemu-iotests/tests/zoned-qcow2     | 110 +++++++++++++++++++++++
>  tests/qemu-iotests/tests/zoned-qcow2.out |  87 ++++++++++++++++++
>  2 files changed, 197 insertions(+)
>  create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
>  create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out
>=20
> diff --git a/tests/qemu-iotests/tests/zoned-qcow2 b/tests/qemu-iotests/te=
sts/zoned-qcow2
> new file mode 100755
> index 0000000000..6aa5ab3a03
> --- /dev/null
> +++ b/tests/qemu-iotests/tests/zoned-qcow2
> @@ -0,0 +1,110 @@
> +#!/usr/bin/env bash
> +#
> +# Test zone management operations for qcow2 file.
> +#
> +
> +seq=3D"$(basename $0)"
> +echo "QA output created by $seq"
> +status=3D1 # failure is the default!
> +
> +file_name=3D"zbc.qcow2"

Please use $TEST_IMG_FILE instead of defining your own variable here.
(TEST_IMG_FILE is already defined in common.rc.)

> +_cleanup()
> +{
> +  _cleanup_test_img
> +  _rm_test_img "$file_name"
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ../common.rc
> +. ../common.filter
> +. ../common.qemu
> +
> +# This test only runs on Linux hosts with qcow2 image files.

Then you need to add:
_supported_fmt qcow2

> +_supported_proto file
> +_supported_os Linux

Is this test really Linux-specific?

> +
> +echo
> +echo "=3D=3D=3D Initial image setup =3D=3D=3D"
> +echo
> +
> +$QEMU_IMG create -f qcow2 $file_name -o size=3D768M -o zone_size=3D64M \
> +-o zone_capacity=3D64M -o zone_nr_conv=3D0 -o max_append_sectors=3D512 \
> +-o max_open_zones=3D0 -o max_active_zones=3D0 -o zoned_profile=3Dzbc
> +
> +IMG=3D"--image-opts -n driver=3Dqcow2,file.driver=3Dfile,file.filename=
=3D$file_name"
> +QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT
> +
> +echo
> +echo "=3D=3D=3D Testing a qcow2 img with zoned format =3D=3D=3D"
> +echo
> +echo "case 1: if the operations work"
> +
> +echo "(1) report the first zone:"
> +$QEMU_IO $IMG -c "zrp 0 1"
> +echo
> +echo "report the first 10 zones"
> +$QEMU_IO $IMG -c "zrp 0 10"
> +echo
> +echo "report the last zone:"
> +$QEMU_IO $IMG -c "zrp 0x2C000000 2" # 0x2C000000 / 512 =3D 0x160000
> +echo
> +echo
> +echo "(2) opening the first zone"
> +$QEMU_IO $IMG -c "zo 0 0x4000000" # 0x4000000 / 512 =3D 0x20000
> +echo "report after:"
> +$QEMU_IO $IMG -c "zrp 0 1"
> +echo
> +echo "opening the second zone"
> +$QEMU_IO $IMG -c "zo 0x4000000 0x4000000"
> +echo "report after:"
> +$QEMU_IO $IMG -c "zrp 0x4000000 1"
> +echo
> +echo "opening the last zone"
> +$QEMU_IO $IMG -c "zo 0x2C000000 0x4000000"
> +echo "report after:"
> +$QEMU_IO $IMG -c "zrp 0x2C000000 2"
> +echo
> +echo
> +echo "(3) closing the first zone"
> +$QEMU_IO $IMG -c "zc 0 0x4000000"
> +echo "report after:"
> +$QEMU_IO $IMG -c "zrp 0 1"
> +echo
> +echo "closing the last zone"
> +$QEMU_IO $IMG -c "zc 0x3e70000000 0x4000000"
> +echo "report after:"
> +$QEMU_IO $IMG -c "zrp 0x3e70000000 2"
> +echo
> +echo
> +echo "(4) finishing the second zone"
> +$QEMU_IO $IMG -c "zf 0x4000000 0x4000000"
> +echo "After finishing a zone:"
> +$QEMU_IO $IMG -c "zrp 0x4000000 1"
> +echo
> +echo
> +echo "(5) resetting the second zone"
> +$QEMU_IO $IMG -c "zrs 0x4000000 0x4000000"
> +echo "After resetting a zone:"
> +$QEMU_IO $IMG -c "zrp 0x4000000 1"
> +echo
> +echo
> +echo "(6) append write" # the physical block size of the device is 4096
> +$QEMU_IO $IMG -c "zrp 0 1"
> +$QEMU_IO $IMG -c "zap -p 0 0x1000 0x2000"
> +echo "After appending the first zone firstly:"
> +$QEMU_IO $IMG -c "zrp 0 1"
> +$QEMU_IO $IMG -c "zap -p 0 0x1000 0x2000"
> +echo "After appending the first zone secondly:"
> +$QEMU_IO $IMG -c "zrp 0 1"
> +$QEMU_IO $IMG -c "zap -p 0x4000000 0x1000 0x2000"
> +echo "After appending the second zone firstly:"
> +$QEMU_IO $IMG -c "zrp 0x4000000 1"
> +$QEMU_IO $IMG -c "zap -p 0x4000000 0x1000 0x2000"
> +echo "After appending the second zone secondly:"
> +$QEMU_IO $IMG -c "zrp 0x4000000 1"
> +
> +# success, all done
> +echo "*** done"
> +rm -f $seq.full
> +status=3D0
> diff --git a/tests/qemu-iotests/tests/zoned-qcow2.out b/tests/qemu-iotest=
s/tests/zoned-qcow2.out
> new file mode 100644
> index 0000000000..288bceffc4
> --- /dev/null
> +++ b/tests/qemu-iotests/tests/zoned-qcow2.out
> @@ -0,0 +1,87 @@
> +QA output created by zoned-qcow2
> +
> +=3D=3D=3D Initial image setup =3D=3D=3D
> +
> +Formatting 'zbc.qcow2', fmt=3Dqcow2 cluster_size=3D65536 extended_l2=3Do=
ff compression_type=3Dzlib zoned_profile=3Dzbc zone_size=3D67108864 zone_ca=
pacity=3D67108864 zone_nr_conv=3D0 max_append_sectors=3D512 max_active_zone=
s=3D0 max_open_zones=3D0 size=3D805306368 lazy_refcounts=3Doff refcount_bit=
s=3D16
> +
> +=3D=3D=3D Testing a qcow2 img with zoned format =3D=3D=3D
> +
> +case 1: if the operations work
> +(1) report the first zone:
> +start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
> +
> +report the first 10 zones
> +start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
> +start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: =
2]
> +start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: =
2]
> +start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: =
2]
> +start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: =
2]
> +start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: =
2]
> +start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: =
2]
> +start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: =
2]
> +start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type=
: 2]
> +start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type=
: 2]
> +
> +report the last zone:
> +start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type=
: 2]
> +
> +
> +(2) opening the first zone
> +wps[0]: 0x0
> +report after:
> +start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:3, [type: 2]
> +
> +opening the second zone
> +wps[1]: 0x20000
> +report after:
> +start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:3, [type: =
2]
> +
> +opening the last zone
> +wps[11]: 0x160000
> +report after:
> +start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:3, [type=
: 2]
> +
> +
> +(3) closing the first zone
> +wps[0]: 0x0
> +report after:
> +start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:4, [type: 2]
> +
> +closing the last zone
> +zone close failed: Input/output error
> +report after:
> +start: 0x1f380000, len 0x20000, cap 0x20000, wptr 0x0, zcond:0, [type: 2]
> +start: 0x1f3a0000, len 0x20000, cap 0x20000, wptr 0x0, zcond:0, [type: 2]
> +
> +
> +(4) finishing the second zone
> +wps[1]: 0x40000
> +After finishing a zone:
> +start: 0x20000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:14, [type:=
 2]
> +
> +
> +(5) resetting the second zone
> +wps[1]: 0x20000
> +After resetting a zone:
> +start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: =
2]
> +
> +
> +(6) append write
> +start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:4, [type: 2]
> +wps[0]: 0x18
> +After zap done, the append sector is 0x0
> +After appending the first zone firstly:
> +start: 0x0, len 0x20000, cap 0x20000, wptr 0x18, zcond:2, [type: 2]
> +wps[0]: 0x30
> +After zap done, the append sector is 0x18
> +After appending the first zone secondly:
> +start: 0x0, len 0x20000, cap 0x20000, wptr 0x30, zcond:2, [type: 2]
> +wps[1]: 0x20018
> +After zap done, the append sector is 0x20000
> +After appending the second zone firstly:
> +start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20018, zcond:2, [type: =
2]
> +wps[1]: 0x20030
> +After zap done, the append sector is 0x20018
> +After appending the second zone secondly:
> +start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20030, zcond:2, [type: =
2]
> +*** done
> --=20
> 2.40.1
>=20

--eZuivMguxG32AiNC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSQaN8ACgkQnKSrs4Gr
c8ghhAgAudoyHkD0Nuu9TOb4vWaEsbLY9yHO+0aYmZe/+xnwCT7iw7rQtVBkVqH4
Y2A1p9S0ddLQTMAcO4fPxVShz2tazYJIN81DGKt7OGV0h8JBb76pZtdPtGRjHcz/
XxHhIE9xneNP2tQ75rSVLZBhDDTPh7qr6uZIQnEgjDrYSHqH1v4++MyuY1IruMYF
V2SnhGaVDgR3DDvps+ljQex+FOAphp7H1ahKmmeuxiw8UaLPPfdzG3hQ30LIh/qy
1LYfGmGKxZMr2lGYVMftln3zk1rqVH7OF0trkSp543EfjkJBQWHuKsbU9CErT0Cu
1j+PJ85QMRliScSsUac/0BZQzxkFYw==
=8ePv
-----END PGP SIGNATURE-----

--eZuivMguxG32AiNC--


