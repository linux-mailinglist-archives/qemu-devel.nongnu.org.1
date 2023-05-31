Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 081C17188A9
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 19:42:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Pq2-0000WW-PP; Wed, 31 May 2023 13:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4Ppv-0000Vt-Of
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4Ppu-0003yl-1r
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685554932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8kE0WdaCab60zTzYqMdhI0/Jl3oy1rvvys29jTONFhA=;
 b=gQEAq2xkFYmDz5a8Abeqoz4GJ3jduoLHMtYlkxzBXVUR+HSvdoVIccMb+0TEiq5BeEJB8u
 p5DZRelN4rryBudpiMVuahD4481CU0T0IL0rwrCvxtKkh3M3Fx3uV4Bl+BsMgCr5ezTeDW
 xL6Ku6zq+UskfsUv5JH14VMLjN1NrrQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-2fKSXdRuOoKBJJQvAHaWeA-1; Wed, 31 May 2023 13:42:07 -0400
X-MC-Unique: 2fKSXdRuOoKBJJQvAHaWeA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAB89101B04F;
 Wed, 31 May 2023 17:42:06 +0000 (UTC)
Received: from localhost (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5731A421D7;
 Wed, 31 May 2023 17:42:06 +0000 (UTC)
Date: Wed, 31 May 2023 13:42:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Markus Armbruster <armbru@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v6 00/11] tracing: remove dynamic vcpu state
Message-ID: <20230531174204.GK1248296@fedora>
References: <20230526165401.574474-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="E8sSfFR28V4ZyRK3"
Content-Disposition: inline
In-Reply-To: <20230526165401.574474-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--E8sSfFR28V4ZyRK3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 05:53:50PM +0100, Alex Benn=E9e wrote:
> Hi Stefan,
>=20
> The references dynamic vcpu tracing support was removed when the
> original TCG trace points where removed. However there was still a
> legacy of dynamic trace state to track this in cpu.h and extra hash
> variables to track TBs. While the removed vcpu tracepoints are not in
> generated code (or helpers) they still bring in a bunch of machinery
> to manage the state so I've pulled them out. We keep and rename one
> (cpu_reset) to a static trace points which dump vcpu->index as it is
> useful to f4bug.
>=20
> v6 new patch to shuffle deprecated, added rth's rb, qapi doc cleanups
>=20
> Please queue into your tree.
>=20
> Alex Benn=E9e (11):
>   *-user: remove the guest_user_syscall tracepoints
>   trace-events: remove the remaining vcpu trace events
>   trace: remove vcpu_id from the TraceEvent structure
>   scripts/qapi: document the tool that generated the file
>   docs/deprecated: move QMP events bellow QMP command section
>   qapi: make the vcpu parameters deprecated for 8.1
>   trace: remove code that depends on setting vcpu
>   trace: remove control-vcpu.h
>   tcg: remove the final vestiges of dstate
>   hw/9pfs: use qemu_xxhash4
>   accel/tcg: include cs_base in our hash calculations
>=20
>  docs/about/deprecated.rst     |  25 +++++---
>  qapi/trace.json               |  40 ++++++-------
>  accel/tcg/tb-hash.h           |   6 +-
>  include/exec/exec-all.h       |   3 -
>  include/hw/core/cpu.h         |   5 --
>  include/qemu/xxhash.h         |  23 +++++--
>  include/user/syscall-trace.h  |   4 --
>  trace/control-internal.h      |  10 ----
>  trace/control-vcpu.h          |  63 --------------------
>  trace/control.h               |  48 ---------------
>  trace/event-internal.h        |   2 -
>  accel/tcg/cpu-exec.c          |   7 +--
>  accel/tcg/tb-maint.c          |   5 +-
>  accel/tcg/translate-all.c     |   6 --
>  bsd-user/freebsd/os-syscall.c |   2 -
>  hw/9pfs/9p.c                  |   5 +-
>  hw/core/cpu-common.c          |   6 +-
>  stubs/trace-control.c         |  13 ----
>  trace/control-target.c        | 109 +++-------------------------------
>  trace/control.c               |  28 ---------
>  trace/qmp.c                   |  76 +++---------------------
>  trace/trace-hmp-cmds.c        |  18 +-----
>  util/qsp.c                    |   2 +-
>  hw/core/trace-events          |   3 +
>  scripts/qapi/gen.py           |   9 ++-
>  scripts/tracetool/format/c.py |   6 --
>  scripts/tracetool/format/h.py |  16 +----
>  trace-events                  |  50 ----------------
>  28 files changed, 94 insertions(+), 496 deletions(-)
>  delete mode 100644 trace/control-vcpu.h
>=20
> --=20
> 2.39.2
>=20

Thanks, applied to my tracing tree:
https://gitlab.com/stefanha/qemu/commits/tracing

Stefan

--E8sSfFR28V4ZyRK3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmR3huwACgkQnKSrs4Gr
c8gmsgf8DoCpa70EsD47gBqDkaI9GyFzISYR0UTJb7xFyCqAnO6oDbKxE2FB/QwS
rV0dYmIzcME3mjSmEsr61e/WVJoOU6GpayrVux+qCLJeoyeUeCsGoUqOEUC/+VXE
bpT9ncAhOXdkyP5MWEy4Oh8K3OBWVwSdU9O3pg/ThkOBrlHn6xukaiOxzUlzE5u0
/c4cmwxUesieMDja2Xm9FqjaRb67SpQ+2x90HjrUsl7CCBVgb7GIBRmXVJhrYGjV
MNVT989+OkM8zRqwtYBGaljRGY2uUCVhk62onjoM9/+knVX+g48wkf1/M+azXHws
iVsRMQjcYs11FZRVZUhnOSylkPfrTQ==
=7mng
-----END PGP SIGNATURE-----

--E8sSfFR28V4ZyRK3--


