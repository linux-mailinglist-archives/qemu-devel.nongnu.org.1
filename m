Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7FB798975
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 17:03:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeczd-0007NF-Mk; Fri, 08 Sep 2023 11:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeczS-0007Mf-Pj
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 11:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeczP-0005o2-EK
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 11:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694185300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=53Vqw/CAQiGyPLiFcor4M98KM7yxx+g4a+Oj3BLfSRI=;
 b=VjQdApVKg5V6NljhpytVCFJFyI109gARdzKBQ4u4PPGoYqkIrrmIScqSDdTYdiWaxNxoyv
 kZ4PZTMdJCQoAszH4C+4GOaOU7AL9FspahjPXNMZeHQFWm3nqLreQR2ZLwt1Zos9sUeC4C
 aBZCLlsB9qXqlkTPYD4w8mVDYPcGR48=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-H_UawQ3nNX2czdB_YQ2wNA-1; Fri, 08 Sep 2023 11:01:38 -0400
X-MC-Unique: H_UawQ3nNX2czdB_YQ2wNA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 681631C09CF2
 for <qemu-devel@nongnu.org>; Fri,  8 Sep 2023 15:01:38 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C68FD6B595;
 Fri,  8 Sep 2023 15:01:37 +0000 (UTC)
Date: Fri, 8 Sep 2023 17:01:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 00/51] Build system, i386 changes for 2023-09-07
Message-ID: <ZPs3UB8W4lsOFnxW@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907154412.GA1550739@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PU9knbuswbMhcETn"
Content-Disposition: inline
In-Reply-To: <20230907154412.GA1550739@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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


--PU9knbuswbMhcETn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 07.09.2023 um 17:44 hat Stefan Hajnoczi geschrieben:
> Applied, thanks.
>=20
> Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for an=
y user-visible changes.

Something in this has broken the build for me, it seems to be the
linux-user binary that doesn't link any more:

  /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in funct=
ion `cpu_x86_cpuid':
  /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:6180: undefined =
reference to `kvm_arch_get_supported_cpuid'
  /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in funct=
ion `x86_cpu_filter_features':
  /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:7158: undefined =
reference to `kvm_arch_get_supported_cpuid'
  /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:715=
9: undefined reference to `kvm_arch_get_supported_cpuid'
  /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:716=
0: undefined reference to `kvm_arch_get_supported_cpuid'
  /usr/bin/ld: /home/kwolf/source/qemu/build-clang/../target/i386/cpu.c:716=
1: undefined reference to `kvm_arch_get_supported_cpuid'
  /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o:/home/kwo=
lf/source/qemu/build-clang/../target/i386/cpu.c:7162: more undefined refere=
nces to `kvm_arch_get_supported_cpuid' follow
  clang-15: error: linker command failed with exit code 1 (use -v to see in=
vocation)

In case it makes a difference, I'm using clang on F37.

Kevin

--PU9knbuswbMhcETn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmT7N1AACgkQfwmycsiP
L9YAoxAAgS8/v1mU0WIwfj9TP2sMOSAqpjZjCM3nXcelDWom/g8NbSEDkZ/CzrP3
qjqy5BEEEdt8VvSZ8cClIPP10lsk0NtsUHs9hVWClobgaRtcJoVytLa9SGVEj/T7
3cLQ/M+n+HD8kKAQJhXv0ls6erlsu7fwfyNUnlKsZp/63vG/FiHyCIGCqYcr2YUF
xugJvYQ5pA2lA0Do1WW83uVO5dKJhEEuaSr9dXWSzpEu4QH0YAf/EAvES5hBDC22
RjPUKVqbhfmX/1eFeOuvfSNC1GMIcNJcgeorYpEpCWZl/MX3De1K2IIPynk4VQfh
uMjBjUL26ZltPYIk/auHK0FxMx8yVbno1xr4dyXZaVOfCgX1oTo8ZlHisK44adzA
ESYurjYvErU1H7aTWtVqnqUYTCtirN7GvNXLkjXuSPFkYku0ctf8gc1gSHIQs+iZ
j7M+ETYGNSGuabyVG9uVWrDiOfm/d2BYm0qondBBq6Unpu28OrbOH3NV42lKUw5y
FmylBJhe/yW9QeYHm3hQAeZ4pB0aTnYRJ2veEhmj0aE+6sBcYHziibut4xFtqb0A
c1vLz8tRigP5vd89PoItFbSx19c8s1VM3TLgT18owA3QKOBLuai10DbBRiIIt9jB
rct9swW+poVzmZsDb5BW3ukLT2MyG220kx20JKGGHYVPHL6NGsc=
=DgbI
-----END PGP SIGNATURE-----

--PU9knbuswbMhcETn--


