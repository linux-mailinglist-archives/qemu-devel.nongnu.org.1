Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D2F7BA359
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 17:55:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoQgp-0007tB-1l; Thu, 05 Oct 2023 11:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoQgl-0007su-U7
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoQgj-0005qU-Oc
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696521297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q1vIQb+2uRfH/kbEVbbaMg1ZbKiFH5PY25c69EjCVkg=;
 b=DlGLtjsseVlxWBqnHhSjadSBrCB0F4UaE75G0CYLdcm7gghfTosxRtGDHG+Nw0l9jSNblt
 77lIBv6pyqbVuWNmsWBf5EoHTGPNm5G0k8ZQVScQKztzD3TYZLzKGJ4lR3MvlUdr9LTeuH
 C3O7HpyJOXQ6FYDKXFz3OABOwW6sUAo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-q7RzGU2hOSq9m2NkZS_BPg-1; Thu, 05 Oct 2023 11:54:50 -0400
X-MC-Unique: q7RzGU2hOSq9m2NkZS_BPg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DF9681D786;
 Thu,  5 Oct 2023 15:54:50 +0000 (UTC)
Received: from localhost (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 955C840C6EA8;
 Thu,  5 Oct 2023 15:54:49 +0000 (UTC)
Date: Thu, 5 Oct 2023 11:54:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tyler Fanelli <tfanelli@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 philmd@linaro.org, berrange@redhat.com, marcandre.lureau@gmail.com
Subject: Re: [RFC PATCH v2 1/9] Add Rust SEV library as subproject
Message-ID: <20231005155448.GA1342722@fedora>
References: <20231004203418.56508-1-tfanelli@redhat.com>
 <20231004203418.56508-2-tfanelli@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fzb3v7sp5FIR0VEw"
Content-Disposition: inline
In-Reply-To: <20231004203418.56508-2-tfanelli@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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


--fzb3v7sp5FIR0VEw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 04:34:10PM -0400, Tyler Fanelli wrote:
> The Rust sev library provides a C API for the AMD SEV launch ioctls, as
> well as the ability to build with meson. Add the Rust sev library as a
> QEMU subproject with the goal of outsourcing all SEV launch ioctls to C
> APIs provided by it.
>=20
> Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
> ---
>  meson.build                   | 8 ++++++++
>  meson_options.txt             | 2 ++
>  scripts/meson-buildoptions.sh | 3 +++
>  subprojects/sev.wrap          | 6 ++++++
>  target/i386/meson.build       | 2 +-
>  5 files changed, 20 insertions(+), 1 deletion(-)
>  create mode 100644 subprojects/sev.wrap
>=20
> diff --git a/meson.build b/meson.build
> index 20ceeb8158..8a17c29de8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -960,6 +960,13 @@ if not get_option('slirp').auto() or have_system
>    endif
>  endif
> =20
> +sev =3D not_found
> +if not get_option('sev').auto()

When 'sev' is auto, then it won't be built. That seems strange. The
auto-detection part is missing! I did you test this on a system that
doesn't have libsev installed system-wide?

I guess the auto-detection would look something like:

  cargo =3D find_program('cargo', required: true)

  if not get_option('sev').auto() or cargo.found()
      ...

That way 'sev' is only built automatically on systems that have cargo
installed.

> +  sev =3D dependency('sev',
> +                   method: 'pkg-config',
> +                   required: get_option('sev'))
> +endif

If you update the auto logic, see the documentation about fallbacks to
subprojects for optional dependencies:
https://mesonbuild.com/Wrap-dependency-system-manual.html#provide-section

It might be necessary to add dependency(..., fallback=3D'sev').

> +
>  vde =3D not_found
>  if not get_option('vde').auto() or have_system or have_tools
>    vde =3D cc.find_library('vdeplug', has_headers: ['libvdeplug.h'],
> @@ -4331,6 +4338,7 @@ summary_info +=3D {'libudev':           libudev}
>  # Dummy dependency, keep .found()
>  summary_info +=3D {'FUSE lseek':        fuse_lseek.found()}
>  summary_info +=3D {'selinux':           selinux}
> +summary_info +=3D {'sev':               sev}
>  summary_info +=3D {'libdw':             libdw}
>  summary(summary_info, bool_yn: true, section: 'Dependencies')
> =20
> diff --git a/meson_options.txt b/meson_options.txt
> index 57e265c871..5b8d283717 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -204,6 +204,8 @@ option('sdl_image', type : 'feature', value : 'auto',
>         description: 'SDL Image support for icons')
>  option('seccomp', type : 'feature', value : 'auto',
>         description: 'seccomp support')
> +option('sev', type : 'feature', value : 'auto',
> +        description: 'Rust AMD SEV library')
>  option('smartcard', type : 'feature', value : 'auto',
>         description: 'CA smartcard emulation support')
>  option('snappy', type : 'feature', value : 'auto',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index e4b46d5715..e585a548fa 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -161,6 +161,7 @@ meson_options_help() {
>    printf "%s\n" '  sdl-image       SDL Image support for icons'
>    printf "%s\n" '  seccomp         seccomp support'
>    printf "%s\n" '  selinux         SELinux support in qemu-nbd'
> +  printf "%s\n" '  sev             SEV library support'
>    printf "%s\n" '  slirp           libslirp user mode network backend su=
pport'
>    printf "%s\n" '  slirp-smbd      use smbd (at path --smbd=3D*) in slir=
p networking'
>    printf "%s\n" '  smartcard       CA smartcard emulation support'
> @@ -440,6 +441,8 @@ _meson_option_parse() {
>      --disable-seccomp) printf "%s" -Dseccomp=3Ddisabled ;;
>      --enable-selinux) printf "%s" -Dselinux=3Denabled ;;
>      --disable-selinux) printf "%s" -Dselinux=3Ddisabled ;;
> +    --enable-sev) printf "%s" -Dsev=3Denabled ;;
> +    --disable-sev) printf "%s" -Dsev=3Ddisabled ;;
>      --enable-slirp) printf "%s" -Dslirp=3Denabled ;;
>      --disable-slirp) printf "%s" -Dslirp=3Ddisabled ;;
>      --enable-slirp-smbd) printf "%s" -Dslirp_smbd=3Denabled ;;
> diff --git a/subprojects/sev.wrap b/subprojects/sev.wrap
> new file mode 100644
> index 0000000000..5be1faccf6
> --- /dev/null
> +++ b/subprojects/sev.wrap
> @@ -0,0 +1,6 @@
> +[wrap-git]
> +url =3D https://github.com/tylerfanelli/sev
> +revision =3D b81b1da5df50055600a5b0349b0c4afda677cccb
> +
> +[provide]
> +sev =3D sev_dep
> diff --git a/target/i386/meson.build b/target/i386/meson.build
> index 6f1036d469..8972a4fb17 100644
> --- a/target/i386/meson.build
> +++ b/target/i386/meson.build
> @@ -20,7 +20,7 @@ i386_system_ss.add(files(
>    'monitor.c',
>    'cpu-sysemu.c',
>  ))
> -i386_system_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'), if_false=
: files('sev-sysemu-stub.c'))
> +i386_system_ss.add(when: 'CONFIG_SEV', if_true: [sev, files('sev.c')], i=
f_false: files('sev-sysemu-stub.c'))
> =20
>  i386_user_ss =3D ss.source_set()
> =20
> --=20
> 2.40.1
>=20

--fzb3v7sp5FIR0VEw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUe3EgACgkQnKSrs4Gr
c8j66wf8C7NuC2rARpP3ibl4u7X0bkMGuRKUMBhsXS5I0D8PjxIVg3PLv+Y6J1cf
b0/QQpw/qPvP8whMLZN93jWpEXRhd+Rk4i0QL+Gi4styacbJ7KZk6Of17M5QKE4w
igE7HI01DK/bxKK74U9nkmXnxxo079i2XB7kxvN4Yq76kSTbJ8dOvhxcgd2Bv6H3
8F853nFmC1jxRJH0umSIaKMAzhXTNZRoqQJqqBu+IyoFNPCfEGu9E+kZY2QZEQu8
xoWr21GDEIP3X8rX0ZL7hkaCQGuc00fyAJOZ2NFrlo0ynBQvHOtCKmKvnwqic5Jb
sicb1unKJzXG1vcqckrgiRHmnhG5Og==
=yBXF
-----END PGP SIGNATURE-----

--fzb3v7sp5FIR0VEw--


