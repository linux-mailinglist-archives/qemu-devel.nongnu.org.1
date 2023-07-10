Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 062DB74D854
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 16:00:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIrPz-00077s-T8; Mon, 10 Jul 2023 09:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldoktor@redhat.com>)
 id 1qIrPx-00077V-QX
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:59:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldoktor@redhat.com>)
 id 1qIrPw-0001sd-04
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688997544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LO34GpSQrfTBNqjjguZnKZZ4ZYi+crOiUogrqXMDWZc=;
 b=M8IAm96q0okz/ZvkXjK/odRT3njUM9j+WDwZFlkJZe6JLPFmcnJs5MC57/WmecA9Eeoedo
 sOsgMmG5HEn3ypeRkHhEDCpREvgEyYBkqZYqOr/I2/cWMmlUbENZ7WiqN0XjnSPVFm6prr
 KvS0aQWhsLfF8dz/WiVlcFh2cQLlTig=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-CQ6tJlcgP8KAuPeS5447ZA-1; Mon, 10 Jul 2023 09:57:17 -0400
X-MC-Unique: CQ6tJlcgP8KAuPeS5447ZA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD8281C0513F;
 Mon, 10 Jul 2023 13:57:16 +0000 (UTC)
Received: from [10.45.225.5] (unknown [10.45.225.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15B9C111CD25;
 Mon, 10 Jul 2023 13:57:14 +0000 (UTC)
Message-ID: <d6d0c668-97c7-8a35-3fba-6b69149e9765@redhat.com>
Date: Mon, 10 Jul 2023 15:57:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] virtio-blk: fix host notifier issues during dataplane
 start/stop
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
References: <20230704151527.193586-1-stefanha@redhat.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Autocrypt: addr=ldoktor@redhat.com; keydata=
 xsBNBFcV6vsBCADa8NUYov+a+AmCEEUB3stiiMM0NQc1WwlcxGoMxKHcqqIj/kdPhUDvFS32
 V94V7en1Lx+cpXKRMZP3n+3WG+VZWLwaktJgqrECZ161zE7xF5d1H3CLmwStbe6Cw1oR4LYQ
 HBpuqFEA5znoLuTTsP1uXs9h1cYNzX7hmOTvPCLJfDJ1iv954FsgCGtoVvl4CoxaR3u2VNOs
 hXsTTVyJM6gDTsyqn0uvLOHGWGIGVhDkLV4hv6pSdiKrtQKWIUji3Z8x41MbZybmJxHkpOVz
 Jl3jnNE3CbiEq77Is9LMI4yTF2CESs3V4XMBLfZPLrQBC0gzjeRxwCnbdOZRwY5KI457ABEB
 AAHNK0x1a2FzIERva3RvciAoUmVkIEhhdCkgPGxkb2t0b3JAcmVkaGF0LmNvbT7CwJUEEwEI
 AD8CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEF
 AmPzIV8FCRCqWrUACgkQJrNi5H/PIsHvywgAiraQGpYPxQvjYAFJzJZcPcp42pdHe2TvJjTS
 lT/w0ZOD76W/Y+b3S7wTzFaOXxxdECG0u9m63hBYL5wvgkWxfmhNfv2+qK21hhqEl8027qIv
 6zyNIDPm3LiHAv6u9npOC07eEwECqTSzGKBpP0pRon591Tzscq0w3nKHQCWOEO+nv2Y5djM/
 rpUUqaRZiU6c1XbnbwnW9vFMozh5gC/4zma53rv94Jl5I1nhHtellNUgxLzvub4rcDnPC0vS
 UojdUq2GjGafeFq0zMIELmf5u2yi+cDTO6+BynmR0QHpkFhVlgRuckYZrbu/rCrSmNiIaR1b
 B+1morL7YKr/vbn9CM7ATQRXFer7AQgAw8JIK9pZUfZWNZirBIwOevkdZu1aLhgH84EfXw40
 ynMEFa1t/c0baOiuLNcVbdnHLGvUAQJ2oN/+rdGpEWITVSjDxFYf3JOnySZJhLnQgGMG4j3m
 dFZMubPG1GJEuubPAAB0huRfjQTvOvpIK03J2H5cMoug862OHOnT+mfonGruTkSO0PBq3wtf
 P+Z3gLCuEDkmEZSh4IKxs0CoLU4KxWRQHpoTOxcAiHzj8cm5qbu3Cb1KrXz8dEmYhCq2fpFf
 /h+GfEO8gU/ICJD8WQUHYcVK0bbiZskCcSOGtStjwq0QqitZMbcsPEset/2L3z44MLPuVApv
 c9wORs/3iT9BhwARAQABwsB8BBgBCAAmAhsMFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAmPz
 IWoFCRCqWrUACgkQJrNi5H/PIsFuxAf/f05XIXj+CcefmLazMRJ8iGTSlCBDhWjqQbGLUtCs
 xNO/5adp24FpsXYcW2wNDynbu914IhHfRxyRAhMOk2YCu6aRtcuunvNhlYyzn23XoP6m0IMi
 uVpNzyeWtalPVRCPy32FfG3CS0JEOxd0fLuNJoziVdxlALZKugK6SO3J+bzve667Kl2mUwx9
 mXrP37Y79y8UlkNIjVITptktYBFAsTMIl/b+swGwCEy4kwxqZp/HMprQjMdhz5HBYix4eRam
 50nhAfj1r6ASgGQKKYptjSU/yS9X+8Sgt7Sq9GnXjq4rCEA3wd2OicKzkFTwqLf9hDni6mNs
 6mnnuy4hp59Pog==
In-Reply-To: <20230704151527.193586-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Uauzoc60ofUFMhjKeJ2skOj0"
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ldoktor@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Uauzoc60ofUFMhjKeJ2skOj0
Content-Type: multipart/mixed; boundary="------------g9jQIQIGPuiW0FfExbNL1ght";
 protected-headers="v1"
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Message-ID: <d6d0c668-97c7-8a35-3fba-6b69149e9765@redhat.com>
Subject: Re: [PATCH] virtio-blk: fix host notifier issues during dataplane
 start/stop
References: <20230704151527.193586-1-stefanha@redhat.com>
In-Reply-To: <20230704151527.193586-1-stefanha@redhat.com>

--------------g9jQIQIGPuiW0FfExbNL1ght
Content-Type: multipart/mixed; boundary="------------jQVE13TPwkFUE97KLFJWPD84"

--------------jQVE13TPwkFUE97KLFJWPD84
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thank you, Stefan, I tested it with the extended set of tests and it addr=
esses the issue.

Regards,
Luk=C3=A1=C5=A1

Tested-by: Lukas Doktor <ldoktor@redhat.com>


Dne 04. 07. 23 v 17:15 Stefan Hajnoczi napsal(a):
> The main loop thread can consume 100% CPU when using --device
> virtio-blk-pci,iothread=3D<iothread>. ppoll() constantly returns but
> reading virtqueue host notifiers fails with EAGAIN. The file descriptor=
s
> are stale and remain registered with the AioContext because of bugs in
> the virtio-blk dataplane start/stop code.
>=20
> The problem is that the dataplane start/stop code involves drain
> operations, which call virtio_blk_drained_begin() and
> virtio_blk_drained_end() at points where the host notifier is not
> operational:
> - In virtio_blk_data_plane_start(), blk_set_aio_context() drains after
>   vblk->dataplane_started has been set to true but the host notifier ha=
s
>   not been attached yet.
> - In virtio_blk_data_plane_stop(), blk_drain() and blk_set_aio_context(=
)
>   drain after the host notifier has already been detached but with
>   vblk->dataplane_started still set to true.
>=20
> I would like to simplify ->ioeventfd_start/stop() to avoid interactions=

> with drain entirely, but couldn't find a way to do that. Instead, this
> patch accepts the fragile nature of the code and reorders it so that
> vblk->dataplane_started is false during drain operations. This way the
> virtio_blk_drained_begin() and virtio_blk_drained_end() calls don't
> touch the host notifier. The result is that
> virtio_blk_data_plane_start() and virtio_blk_data_plane_stop() have
> complete control over the host notifier and stale file descriptors are
> no longer left in the AioContext.
>=20
> This patch fixes the 100% CPU consumption in the main loop thread and
> correctly moves host notifier processing to the IOThread.
>=20
> Fixes: 1665d9326fd2 ("virtio-blk: implement BlockDevOps->drained_begin(=
)")
> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/block/dataplane/virtio-blk.c | 67 +++++++++++++++++++--------------=

>  1 file changed, 38 insertions(+), 29 deletions(-)
>=20
> diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virti=
o-blk.c
> index c227b39408..da36fcfd0b 100644
> --- a/hw/block/dataplane/virtio-blk.c
> +++ b/hw/block/dataplane/virtio-blk.c
> @@ -219,13 +219,6 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev=
)
> =20
>      memory_region_transaction_commit();
> =20
> -    /*
> -     * These fields are visible to the IOThread so we rely on implicit=
 barriers
> -     * in aio_context_acquire() on the write side and aio_notify_accep=
t() on
> -     * the read side.
> -     */
> -    s->starting =3D false;
> -    vblk->dataplane_started =3D true;
>      trace_virtio_blk_data_plane_start(s);
> =20
>      old_context =3D blk_get_aio_context(s->conf->conf.blk);
> @@ -244,6 +237,18 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev=
)
>          event_notifier_set(virtio_queue_get_host_notifier(vq));
>      }
> =20
> +    /*
> +     * These fields must be visible to the IOThread when it processes =
the
> +     * virtqueue, otherwise it will think dataplane has not started ye=
t.
> +     *
> +     * Make sure ->dataplane_started is false when blk_set_aio_context=
() is
> +     * called above so that draining does not cause the host notifier =
to be
> +     * detached/attached prematurely.
> +     */
> +    s->starting =3D false;
> +    vblk->dataplane_started =3D true;
> +    smp_wmb(); /* paired with aio_notify_accept() on the read side */
> +
>      /* Get this show started by hooking up our callbacks */
>      if (!blk_in_drain(s->conf->conf.blk)) {
>          aio_context_acquire(s->ctx);
> @@ -273,7 +278,6 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)=

>    fail_guest_notifiers:
>      vblk->dataplane_disabled =3D true;
>      s->starting =3D false;
> -    vblk->dataplane_started =3D true;
>      return -ENOSYS;
>  }
> =20
> @@ -327,6 +331,32 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev=
)
>          aio_wait_bh_oneshot(s->ctx, virtio_blk_data_plane_stop_bh, s);=

>      }
> =20
> +    /*
> +     * Batch all the host notifiers in a single transaction to avoid
> +     * quadratic time complexity in address_space_update_ioeventfds().=

> +     */
> +    memory_region_transaction_begin();
> +
> +    for (i =3D 0; i < nvqs; i++) {
> +        virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
> +    }
> +
> +    /*
> +     * The transaction expects the ioeventfds to be open when it
> +     * commits. Do it now, before the cleanup loop.
> +     */
> +    memory_region_transaction_commit();
> +
> +    for (i =3D 0; i < nvqs; i++) {
> +        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), i);
> +    }
> +
> +    /*
> +     * Set ->dataplane_started to false before draining so that host n=
otifiers
> +     * are not detached/attached anymore.
> +     */
> +    vblk->dataplane_started =3D false;
> +
>      aio_context_acquire(s->ctx);
> =20
>      /* Wait for virtio_blk_dma_restart_bh() and in flight I/O to compl=
ete */
> @@ -340,32 +370,11 @@ void virtio_blk_data_plane_stop(VirtIODevice *vde=
v)
> =20
>      aio_context_release(s->ctx);
> =20
> -    /*
> -     * Batch all the host notifiers in a single transaction to avoid
> -     * quadratic time complexity in address_space_update_ioeventfds().=

> -     */
> -    memory_region_transaction_begin();
> -
> -    for (i =3D 0; i < nvqs; i++) {
> -        virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
> -    }
> -
> -    /*
> -     * The transaction expects the ioeventfds to be open when it
> -     * commits. Do it now, before the cleanup loop.
> -     */
> -    memory_region_transaction_commit();
> -
> -    for (i =3D 0; i < nvqs; i++) {
> -        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), i);
> -    }
> -
>      qemu_bh_cancel(s->bh);
>      notify_guest_bh(s); /* final chance to notify guest */
> =20
>      /* Clean up guest notifier (irq) */
>      k->set_guest_notifiers(qbus->parent, nvqs, false);
> =20
> -    vblk->dataplane_started =3D false;
>      s->stopping =3D false;
>  }
--------------jQVE13TPwkFUE97KLFJWPD84
Content-Type: application/pgp-keys; name="OpenPGP_0x26B362E47FCF22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0x26B362E47FCF22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
xMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEB
AQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEE
BSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2
Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOU
lZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn
6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD0oqSf8aTBzyeKkJHvTPlB6H9a6DMT
bzwaChI7UuRuz81PDL6sDSGVmi+bv+AqF4FB3knFXzsPQkVyniTxTBp7vb27LJcj
gkdE/wDr1E6igrsqMHJ2RqzSwwgl3KqOvtUf9uaTZwFjdwBjk43ivJNV1m4vZCbm
eRvRNx/yKxTO2/0+hrmdaUtjdUeXdnr8+v6Tc2RQX0e9fujdjmqlpqUIhlRbpWc9
Ar5rytZn5Klvck4AqDz5A7P5zFh021Go+VHvkVyTDCwzygBp4uMFiTyRXkWi+M7/
AE5FR5DPCoy0cnOB7HqK9H0PVLXXrNp4t8TrgMjEHHfr3rWLvoZNWKd1Mf7RuD6y
UkUoDNjr3q9LoDSSs7XZJc5GFFRjQZFfiYbCeTnB/lT9mw5kN8/KjJ5NQGUg4yav
/wBjx5wJ92PQ1C+kDccK5980vZthzo60jPam+WTyQPyqQ89ARTSoJ6ZNdZiAwByC
KQsO1LsJ6Cq1/cixsJ7hhny0LY9TSbsrjSu7GH4q8SJpVsbeFx9qcdj9weteT3V8
HZnL7nY5yT3pmu3091cytJJueRizHPU1Lovhu5vrczSSFS33cjoK86cud80mehTh
y+6jPEgJOB7lmprTKR8qM/vjiu6sPCNtF/rQZD3LVsJ4dtFAAiX8qj2iNvZM8tCs
y52H6VXkD7sbGPtzXro8OWp48sY+lMfQbNeBCg+gqlURDos8kaGdYWZEK8elb3g3
xO+kXChiXtGY+Yp5K5Hb9K7K80OB4GRYwMg9uteaTWr6VrbW8g+STgZ/SrjO+xlO
lbc980u9tNRg86zmEitzwM4/CrBhZlZYypAPG05rxjStXutBvlubdm8vjzI88Edx
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
jonCs5BU8Ki3/YQ54upjbOpp57suIaefT6I=3D
=3DaBeO
-----END PGP PUBLIC KEY BLOCK-----

--------------jQVE13TPwkFUE97KLFJWPD84--

--------------g9jQIQIGPuiW0FfExbNL1ght--

--------------Uauzoc60ofUFMhjKeJ2skOj0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAmSsDjkFAwAAAAAACgkQJrNi5H/PIsED
NAgA0WlsvFw+bJgNlVTyi4oTGBcx9AYUioVydbgyxFuB44+BUD8tzOZlbj7kQ4WHUiKdlV5IIedj
sGxMRCkzC7CUUZTyvCr7SL5IYujxJNaeBmaQEmzRrBp07KSH9ZYwWqazS36A7aylpENQ2uI0ocOL
Ygbt9rUVO43YcmyWtmPwOSg3NLw6msJYLpe9uQSCstJLwvMPLW+3CX/hx+x2a+gGDqmIUA66wklY
TB7tfT7+E05Hp9V/9pyNLRagufqhR42SBwhJX6CIU51DxS7cVkpVMBfHMNu9mtYu+e129CNXGqtJ
VWimy2Inl70kzgWT0Owb8IRuVZlXer8hvhompGwt4Q==
=mXZC
-----END PGP SIGNATURE-----

--------------Uauzoc60ofUFMhjKeJ2skOj0--


