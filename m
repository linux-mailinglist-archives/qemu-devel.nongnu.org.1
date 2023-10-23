Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3537F7D283F
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 04:06:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qukKo-00022k-Rc; Sun, 22 Oct 2023 22:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qukKl-00022b-9a
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 22:06:23 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qukKi-0006dY-0n
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 22:06:22 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b89ab5ddb7so2825035b3a.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 19:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1698026654; x=1698631454;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aatEPjTPPfaOvu73cpmJDj5YFaZJCOCjoWvUhDBIaAg=;
 b=fMBKyPz/799+9HqoPvGh0OOexB7Nn9MZEoRtZn3Hn5qLp8HNkqb6WIu2Ud4pB6YNsa
 D/jCW2WNz8QTUEzdj70MO3NCsQwkV8bM/vcCz/OrOQ6RyNSqkzJVef1D+adq4NTcVs30
 g4QWDrWI2hePrc80Uta4jpXZV6n221txz2JRnE+qmSwjgziCEY7FM1ZGIkxa4c0kPkYs
 SdzKqI18lD/QzfzWeM6rTBNZ6rS+3gV5Stwa79XKZlTN3H1ukWDsuvVij7RXtV+/yFVG
 k/IW7phq/+95LnQzeHD1yZdQgA6xe+1/qsax2z7qKvunIED27ylRbB8a67EBO4BgSOAA
 oFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698026654; x=1698631454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aatEPjTPPfaOvu73cpmJDj5YFaZJCOCjoWvUhDBIaAg=;
 b=u+3aLmBiEo0eharrhGcrFL0gBTsUz9H74NLE43yUaXg6hFAhZiZrVt5eO3zT4gVdfO
 89vhz0eL0xY25iYSa9n2fhJgUs0aIBGH63bU/CgzH8aEiMrcVI2l1sukqhgNfQhCFMjX
 TKRGm11/EGsGnaaD+IXp1W43si2w9eK83mUsUEOZMgc1R7qo3uDxAJv6kHKRFBKWWqIg
 EwPiU0xqvzXepmCVzXrDCqxUa96aWGIubGK743/Dk8IxvDbr/24js3tkX5i6Q39BKyYF
 Uu5J+s6BTGODB25SdmYud69jI0RvbEuv3ufVqk+ZLnER7bBOT+Wz10G6FXikTgtrkSWY
 wMGQ==
X-Gm-Message-State: AOJu0Yw/gRC6EXcAfFCAuITAq8mg0HSaPZFZ/fLl0QU3KAjUasi0YSqB
 PU9vZib2fSj0jX3TBPn/wsofPdhiwNxKq5RaLx+LjIdcPi+skO5DGlRuo/VW
X-Google-Smtp-Source: AGHT+IFcVF61J5yy09qjqEAB67D/+QMVZmlILPBNHlf5EAmusaASGN3arMGWMVyXo7SLLmHUzwyKzX5cG6N+2JIQfJk=
X-Received: by 2002:a05:6a21:6801:b0:172:9b19:66b6 with SMTP id
 wr1-20020a056a21680100b001729b1966b6mr7976926pzb.32.1698026653619; Sun, 22
 Oct 2023 19:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697815117.git.yong.huang@smartx.com>
 <bd9f195883fb5081f67f680bd2972a4b0a5b3520.1697815117.git.yong.huang@smartx.com>
In-Reply-To: <bd9f195883fb5081f67f680bd2972a4b0a5b3520.1697815117.git.yong.huang@smartx.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 23 Oct 2023 10:03:57 +0800
Message-ID: <CAK9dgmYqBBFkLNWNsH4th7znTAOiGiYMg-SzNTWVPk=csZw_jw@mail.gmail.com>
Subject: Re: [v2 4/6] tests/migration: Introduce dirty-ring-size option into
 guestperf
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000822b25060858a33e"
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000822b25060858a33e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping.

Regarding the performance of the live migration, Guestperf could provide us
with a clear response. IMHO, by just adding a few metrics, it might be
developed
into a more user-friendly metrics system in the future.

We may still enrich it prior to that.

On Fri, Oct 20, 2023 at 11:24=E2=80=AFPM Hyman Huang <yong.huang@smartx.com=
> wrote:

> Dirty ring size configuration is not supported by guestperf tool.
>
> Introduce dirty-ring-size (ranges in [1024, 65536]) option so
> developers can play with dirty-ring and dirty-limit feature easier.
>
> To set dirty ring size with 4096 during migration test:
> $ ./tests/migration/guestperf.py --dirty-ring-size 4096 xxx
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  tests/migration/guestperf/engine.py   | 6 +++++-
>  tests/migration/guestperf/hardware.py | 8 ++++++--
>  tests/migration/guestperf/shell.py    | 6 +++++-
>  3 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/tests/migration/guestperf/engine.py
> b/tests/migration/guestperf/engine.py
> index da96ca034a..aabf6de4d9 100644
> --- a/tests/migration/guestperf/engine.py
> +++ b/tests/migration/guestperf/engine.py
> @@ -325,7 +325,6 @@ def _get_common_args(self, hardware, tunnelled=3DFals=
e):
>              cmdline =3D "'" + cmdline + "'"
>
>          argv =3D [
> -            "-accel", "kvm",
>              "-cpu", "host",
>              "-kernel", self._kernel,
>              "-initrd", self._initrd,
> @@ -333,6 +332,11 @@ def _get_common_args(self, hardware, tunnelled=3DFal=
se):
>              "-m", str((hardware._mem * 1024) + 512),
>              "-smp", str(hardware._cpus),
>          ]
> +        if hardware._dirty_ring_size:
> +            argv.extend(["-accel", "kvm,dirty-ring-size=3D%s" %
> +                         hardware._dirty_ring_size])
> +        else:
> +            argv.extend(["-accel", "kvm"])
>
>          argv.extend(self._get_qemu_serial_args())
>
> diff --git a/tests/migration/guestperf/hardware.py
> b/tests/migration/guestperf/hardware.py
> index 3145785ffd..f779cc050b 100644
> --- a/tests/migration/guestperf/hardware.py
> +++ b/tests/migration/guestperf/hardware.py
> @@ -23,7 +23,8 @@ def __init__(self, cpus=3D1, mem=3D1,
>                   src_cpu_bind=3DNone, src_mem_bind=3DNone,
>                   dst_cpu_bind=3DNone, dst_mem_bind=3DNone,
>                   prealloc_pages =3D False,
> -                 huge_pages=3DFalse, locked_pages=3DFalse):
> +                 huge_pages=3DFalse, locked_pages=3DFalse,
> +                 dirty_ring_size=3D0):
>          self._cpus =3D cpus
>          self._mem =3D mem # GiB
>          self._src_mem_bind =3D src_mem_bind # List of NUMA nodes
> @@ -33,6 +34,7 @@ def __init__(self, cpus=3D1, mem=3D1,
>          self._prealloc_pages =3D prealloc_pages
>          self._huge_pages =3D huge_pages
>          self._locked_pages =3D locked_pages
> +        self._dirty_ring_size =3D dirty_ring_size
>
>
>      def serialize(self):
> @@ -46,6 +48,7 @@ def serialize(self):
>              "prealloc_pages": self._prealloc_pages,
>              "huge_pages": self._huge_pages,
>              "locked_pages": self._locked_pages,
> +            "dirty_ring_size": self._dirty_ring_size,
>          }
>
>      @classmethod
> @@ -59,4 +62,5 @@ def deserialize(cls, data):
>              data["dst_mem_bind"],
>              data["prealloc_pages"],
>              data["huge_pages"],
> -            data["locked_pages"])
> +            data["locked_pages"],
> +            data["dirty_ring_size"])
> diff --git a/tests/migration/guestperf/shell.py
> b/tests/migration/guestperf/shell.py
> index 8a809e3dda..7d6b8cd7cf 100644
> --- a/tests/migration/guestperf/shell.py
> +++ b/tests/migration/guestperf/shell.py
> @@ -60,6 +60,8 @@ def __init__(self):
>          parser.add_argument("--prealloc-pages", dest=3D"prealloc_pages",
> default=3DFalse)
>          parser.add_argument("--huge-pages", dest=3D"huge_pages",
> default=3DFalse)
>          parser.add_argument("--locked-pages", dest=3D"locked_pages",
> default=3DFalse)
> +        parser.add_argument("--dirty-ring-size", dest=3D"dirty_ring_size=
",
> +                            default=3D0, type=3Dint)
>
>          self._parser =3D parser
>
> @@ -89,7 +91,9 @@ def split_map(value):
>
>                          locked_pages=3Dargs.locked_pages,
>                          huge_pages=3Dargs.huge_pages,
> -                        prealloc_pages=3Dargs.prealloc_pages)
> +                        prealloc_pages=3Dargs.prealloc_pages,
> +
> +                        dirty_ring_size=3Dargs.dirty_ring_size)
>
>
>  class Shell(BaseShell):
> --
> 2.39.1
>
>

--=20
Best regards

--000000000000822b25060858a33e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:comic sa=
ns ms,sans-serif">ping.</div><div class=3D"gmail_default" style=3D"font-fam=
ily:comic sans ms,sans-serif"><br></div><div class=3D"gmail_default" style=
=3D"font-family:comic sans ms,sans-serif">Regarding the performance of the =
live migration, Guestperf could provide us</div><div class=3D"gmail_default=
" style=3D"font-family:comic sans ms,sans-serif">with a clear response. IMH=
O, by just adding a few metrics, it might be developed</div><div class=3D"g=
mail_default" style=3D"font-family:comic sans ms,sans-serif">into a more us=
er-friendly metrics system in the future.=C2=A0</div><div class=3D"gmail_de=
fault" style=3D"font-family:comic sans ms,sans-serif"><br></div><div class=
=3D"gmail_default" style=3D"font-family:comic sans ms,sans-serif">We may st=
ill enrich it prior to that.<br></div></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 20, 2023 at 11:24=E2=80=
=AFPM Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com">yong.huang@s=
martx.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
border-left-color:rgb(204,204,204);padding-left:1ex">Dirty ring size config=
uration is not supported by guestperf tool.<br>
<br>
Introduce dirty-ring-size (ranges in [1024, 65536]) option so<br>
developers can play with dirty-ring and dirty-limit feature easier.<br>
<br>
To set dirty ring size with 4096 during migration test:<br>
$ ./tests/migration/guestperf.py --dirty-ring-size 4096 xxx<br>
<br>
Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" tar=
get=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
---<br>
=C2=A0tests/migration/guestperf/engine.py=C2=A0 =C2=A0| 6 +++++-<br>
=C2=A0tests/migration/guestperf/hardware.py | 8 ++++++--<br>
=C2=A0tests/migration/guestperf/shell.py=C2=A0 =C2=A0 | 6 +++++-<br>
=C2=A03 files changed, 16 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestper=
f/engine.py<br>
index da96ca034a..aabf6de4d9 100644<br>
--- a/tests/migration/guestperf/engine.py<br>
+++ b/tests/migration/guestperf/engine.py<br>
@@ -325,7 +325,6 @@ def _get_common_args(self, hardware, tunnelled=3DFalse)=
:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmdline =3D &quot;&#39;&quo=
t; + cmdline + &quot;&#39;&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0argv =3D [<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;-accel&quot;, &quot;kvm&qu=
ot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;-cpu&quot;, &quot;hos=
t&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;-kernel&quot;, self._=
kernel,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;-initrd&quot;, self._=
initrd,<br>
@@ -333,6 +332,11 @@ def _get_common_args(self, hardware, tunnelled=3DFalse=
):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;-m&quot;, str((hardwa=
re._mem * 1024) + 512),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;-smp&quot;, str(hardw=
are._cpus),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if hardware._dirty_ring_size:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv.extend([&quot;-accel&quot;,=
 &quot;kvm,dirty-ring-size=3D%s&quot; %<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0hardware._dirty_ring_size])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv.extend([&quot;-accel&quot;,=
 &quot;kvm&quot;])<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0argv.extend(self._get_qemu_serial_args())=
<br>
<br>
diff --git a/tests/migration/guestperf/hardware.py b/tests/migration/guestp=
erf/hardware.py<br>
index 3145785ffd..f779cc050b 100644<br>
--- a/tests/migration/guestperf/hardware.py<br>
+++ b/tests/migration/guestperf/hardware.py<br>
@@ -23,7 +23,8 @@ def __init__(self, cpus=3D1, mem=3D1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 src_cpu_bind=
=3DNone, src_mem_bind=3DNone,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dst_cpu_bind=
=3DNone, dst_mem_bind=3DNone,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prealloc_pag=
es =3D False,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0huge_pages=
=3DFalse, locked_pages=3DFalse):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0huge_pages=
=3DFalse, locked_pages=3DFalse,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dirty_ring_s=
ize=3D0):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._cpus =3D cpus<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._mem =3D mem # GiB<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._src_mem_bind =3D src_mem_bind # Lis=
t of NUMA nodes<br>
@@ -33,6 +34,7 @@ def __init__(self, cpus=3D1, mem=3D1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._prealloc_pages =3D prealloc_pages<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._huge_pages =3D huge_pages<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._locked_pages =3D locked_pages<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._dirty_ring_size =3D dirty_ring_size<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0def serialize(self):<br>
@@ -46,6 +48,7 @@ def serialize(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;prealloc_pages&quot;:=
 self._prealloc_pages,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;huge_pages&quot;: sel=
f._huge_pages,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;locked_pages&quot;: s=
elf._locked_pages,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dirty_ring_size&quot;: sel=
f._dirty_ring_size,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0@classmethod<br>
@@ -59,4 +62,5 @@ def deserialize(cls, data):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data[&quot;dst_mem_bind&quo=
t;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data[&quot;prealloc_pages&q=
uot;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data[&quot;huge_pages&quot;=
],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[&quot;locked_pages&quot;])<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[&quot;locked_pages&quot;],<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data[&quot;dirty_ring_size&quot;=
])<br>
diff --git a/tests/migration/guestperf/shell.py b/tests/migration/guestperf=
/shell.py<br>
index 8a809e3dda..7d6b8cd7cf 100644<br>
--- a/tests/migration/guestperf/shell.py<br>
+++ b/tests/migration/guestperf/shell.py<br>
@@ -60,6 +60,8 @@ def __init__(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parser.add_argument(&quot;--prealloc-page=
s&quot;, dest=3D&quot;prealloc_pages&quot;, default=3DFalse)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parser.add_argument(&quot;--huge-pages&qu=
ot;, dest=3D&quot;huge_pages&quot;, default=3DFalse)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parser.add_argument(&quot;--locked-pages&=
quot;, dest=3D&quot;locked_pages&quot;, default=3DFalse)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 parser.add_argument(&quot;--dirty-ring-size&qu=
ot;, dest=3D&quot;dirty_ring_size&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 default=3D0, type=3Dint)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._parser =3D parser<br>
<br>
@@ -89,7 +91,9 @@ def split_map(value):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0locked_pages=3Dargs.locked_pages,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0huge_pages=3Dargs.huge_pages,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 prealloc_pages=3Dargs.prealloc_pages)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 prealloc_pages=3Dargs.prealloc_pages,<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dirty_ring_size=3Dargs.dirty_ring_size)<br>
<br>
<br>
=C2=A0class Shell(BaseShell):<br>
-- <br>
2.39.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div>

--000000000000822b25060858a33e--

