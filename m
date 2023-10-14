Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5C17C9453
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 13:27:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrcm8-0004T6-B7; Sat, 14 Oct 2023 07:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1qrclu-0004Oc-Gd
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 07:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1qrclo-0003NB-0D
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 07:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697282721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sYgOgcptxHx65h1xRRIC536iyAD2XNCw/YU0yt6awBY=;
 b=K+1tHOLIDMUC3TJaK8V/V9pZXk57Jlo3YNmXT39Y1BNKV1xHDeCoO9DHT5DERbOXLhiAKS
 8QI9CjkVi/MTYLsIHXy+92T1nPFLE8S3vmM3wdbb5zNzpT7EEo7YBssTrFV4a59EgVj4VS
 0jQHeLPJdsusuF+xROBDTPK3hhvAw3s=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-wBs7Pc24MaSzoSrNE1S7SQ-1; Sat, 14 Oct 2023 07:24:09 -0400
X-MC-Unique: wBs7Pc24MaSzoSrNE1S7SQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3ae30e1ad6cso4621573b6e.0
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 04:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697282648; x=1697887448;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sYgOgcptxHx65h1xRRIC536iyAD2XNCw/YU0yt6awBY=;
 b=vmr9Mu1EW8Qviweylq+Vv+Vfk7V7nJzQFCUkB1asQJK99QeiSIEn6Tu6VUXYZ/BZ3d
 D8q7DK0gfXLHF1KW4UP3whQBRYgpVp3Bxoarn7JLJwpXtwumepGoOxdjV9vO92s4S4B3
 Z2hCKBr8DbbVEMlcoHPJCfWImgTSYjal85SxOf8ynb/QE4P5v9fqzmsfIZBaa0AV0LQ5
 qJWFzv9bXw/FiJ33NgKpKBJijoKVU/YZs4tTUTztg7YsHdG/dI07z3Hs4YDQTQ5OctnS
 TvdhEKDGVp5L5lyA5Zyh1vY/LCjEBHMv3w1jGM7q0xa5Gp50BApGIVnjwaPwM0t+nQ5u
 nudw==
X-Gm-Message-State: AOJu0YwTyOWUpsI6DJfkvdo10JkqoihVFDIdmpzLvRNwW5OBZ/1fpGaj
 VZtOOu6o2fh8u8SL9awhMjKlhloOrcc5joeg1sLX9JbyQc8sLXV9PT8JcRBhRtiA9Zl1oG4Aq2A
 +oxsFFcRCz+6+xOpaNXW2IoCD5py0iYo=
X-Received: by 2002:a05:6808:1594:b0:3ae:1254:ea8a with SMTP id
 t20-20020a056808159400b003ae1254ea8amr36887088oiw.41.1697282648671; 
 Sat, 14 Oct 2023 04:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4jXZbBzIXvvkQshsv91asnGzWo2KfxVxml0rzVBbBs1hKq+Sd4FXbOOL3sWUuZQq3+mkG832JuZpbaoMOAw8=
X-Received: by 2002:a05:6808:1594:b0:3ae:1254:ea8a with SMTP id
 t20-20020a056808159400b003ae1254ea8amr36887077oiw.41.1697282648424; Sat, 14
 Oct 2023 04:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230907215326.367847-1-den@openvz.org>
In-Reply-To: <20230907215326.367847-1-den@openvz.org>
From: Nir Soffer <nsoffer@redhat.com>
Date: Sat, 14 Oct 2023 14:23:52 +0300
Message-ID: <CAMRbyyuC3wL_br26DAPVY9JrayfqGv=_1ZjnGb1eHo9SXi7YAg@mail.gmail.com>
Subject: Re: [PATCH 1/1] block: improve alignment detection and fix 271 test
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Nir Soffer <nirsof@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alberto Garcia <berto@igalia.com>
Content-Type: multipart/alternative; boundary="00000000000057dbb00607ab696f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--00000000000057dbb00607ab696f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 8, 2023 at 12:54=E2=80=AFAM Denis V. Lunev <den@openvz.org> wro=
te:

> Unfortunately 271 IO test is broken if started in non-cached mode.
>

Is this a real world issue? For example in oVirt you cannot create a disk
with
size < 4k so there is no way that 4k is not a good alignment.

Should we fix the test to reflect real world usage?

    _reset_img 2083k

I guess it works with:

    _reset_img 2084k

Commits
>     commit a6b257a08e3d72219f03e461a52152672fec0612
>     Author: Nir Soffer <nirsof@gmail.com>
>     Date:   Tue Aug 13 21:21:03 2019 +0300
>     file-posix: Handle undetectable alignment
> and
>     commit 9c60a5d1978e6dcf85c0e01b50e6f7f54ca09104
>     Author: Kevin Wolf <kwolf@redhat.com>
>     Date:   Thu Jul 16 16:26:00 2020 +0200
>     block: Require aligned image size to avoid assertion failure
> have interesting side effect if used togather.
>
> If the image size is not multiple of 4k and that image falls under
> original constraints of Nil's patch, the image can not be opened
> due to the check in the bdrv_check_perm().
>
> The patch tries to satisfy the requirements of bdrv_check_perm()
> inside raw_probe_alignment(). This is at my opinion better that just
> disallowing to run that test in non-cached mode. The operation is legal
> by itself.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Nir Soffer <nirsof@gmail.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Alberto Garcia <berto@igalia.com>
> ---
>  block/file-posix.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index b16e9c21a1..988cfdc76c 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -447,8 +447,21 @@ static void raw_probe_alignment(BlockDriverState *bs=
,
> int fd, Error **errp)
>          for (i =3D 0; i < ARRAY_SIZE(alignments); i++) {
>              align =3D alignments[i];
>              if (raw_is_io_aligned(fd, buf, align)) {
> -                /* Fallback to safe value. */
> -                bs->bl.request_alignment =3D (align !=3D 1) ? align :
> max_align;
> +                if (align !=3D 1) {
> +                    bs->bl.request_alignment =3D align;
> +                    break;
> +                }
> +                /*
> +                 * Fallback to safe value. max_align is perfect, but the
> size of the device must be multiple of
> +                 * the virtual length of the device. In the other case w=
e
> will get a error in
> +                 * bdrv_node_refresh_perm().
> +                 */
> +                for (align =3D max_align; align > 1; align /=3D 2) {
> +                    if ((bs->total_sectors * BDRV_SECTOR_SIZE) % align =
=3D=3D
> 0) {
>

Moving image size calculation out of the loop would make the intent of the
code
more clear:

    if (image_size % align =3D=3D 0) {

Since qemu does not enforce image size alignment, I can see how you create
a 512 bytes
aligned image and in the case when qemu cannot detect the alignment, we end
with
align =3D 4k. In this case this loop would select align =3D 512, but with t=
he
image aligned to
some strange value, this loop may select align =3D 2 or some other value th=
at
does not
make sense.

So I can see using 4k or 512 bytes as a good fallback value, but anything
else should not
be possible, so maybe we should fix this in bdrv_check_perm()?

Nir

--00000000000057dbb00607ab696f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Sep 8, 2023 at 12:54=E2=80=AFAM D=
enis V. Lunev &lt;<a href=3D"mailto:den@openvz.org">den@openvz.org</a>&gt; =
wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Unfortunately 271 IO test is broken if started in non-cac=
hed mode.<br></blockquote><div><br></div><div><div>Is this a real world iss=
ue? For example in oVirt you cannot create a disk with</div><div>size &lt; =
4k so there is no way that 4k is not a good alignment.</div><br class=3D"gm=
ail-Apple-interchange-newline"></div><div>Should we fix the test to reflect=
 real world usage?</div><div><br></div><div>=C2=A0 =C2=A0 _reset_img 2083k<=
br></div><div><br></div><div>I guess it works with:</div><div><br></div><di=
v><div>=C2=A0 =C2=A0 _reset_img 2084k<br></div><div><br></div></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
Commits<br>
=C2=A0 =C2=A0 commit a6b257a08e3d72219f03e461a52152672fec0612<br>
=C2=A0 =C2=A0 Author: Nir Soffer &lt;<a href=3D"mailto:nirsof@gmail.com" ta=
rget=3D"_blank">nirsof@gmail.com</a>&gt;<br>
=C2=A0 =C2=A0 Date:=C2=A0 =C2=A0Tue Aug 13 21:21:03 2019 +0300<br>
=C2=A0 =C2=A0 file-posix: Handle undetectable alignment<br>
and<br>
=C2=A0 =C2=A0 commit 9c60a5d1978e6dcf85c0e01b50e6f7f54ca09104<br>
=C2=A0 =C2=A0 Author: Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com" ta=
rget=3D"_blank">kwolf@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 Date:=C2=A0 =C2=A0Thu Jul 16 16:26:00 2020 +0200<br>
=C2=A0 =C2=A0 block: Require aligned image size to avoid assertion failure<=
br>
have interesting side effect if used togather.<br>
<br>
If the image size is not multiple of 4k and that image falls under<br>
original constraints of Nil&#39;s patch, the image can not be opened<br>
due to the check in the bdrv_check_perm().<br>
<br>
The patch tries to satisfy the requirements of bdrv_check_perm()<br>
inside raw_probe_alignment(). This is at my opinion better that just<br>
disallowing to run that test in non-cached mode. The operation is legal<br>
by itself.<br>
<br>
Signed-off-by: Denis V. Lunev &lt;<a href=3D"mailto:den@openvz.org" target=
=3D"_blank">den@openvz.org</a>&gt;<br>
CC: Nir Soffer &lt;<a href=3D"mailto:nirsof@gmail.com" target=3D"_blank">ni=
rsof@gmail.com</a>&gt;<br>
CC: Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com" target=3D"_blank">kw=
olf@redhat.com</a>&gt;<br>
CC: Hanna Reitz &lt;<a href=3D"mailto:hreitz@redhat.com" target=3D"_blank">=
hreitz@redhat.com</a>&gt;<br>
CC: Alberto Garcia &lt;<a href=3D"mailto:berto@igalia.com" target=3D"_blank=
">berto@igalia.com</a>&gt;<br>
---<br>
=C2=A0block/file-posix.c | 17 +++++++++++++++--<br>
=C2=A01 file changed, 15 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/block/file-posix.c b/block/file-posix.c<br>
index b16e9c21a1..988cfdc76c 100644<br>
--- a/block/file-posix.c<br>
+++ b/block/file-posix.c<br>
@@ -447,8 +447,21 @@ static void raw_probe_alignment(BlockDriverState *bs, =
int fd, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ARRAY_SIZE(alignment=
s); i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0align =3D alignments[i];<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (raw_is_io_aligned(fd, b=
uf, align)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Fallback to saf=
e value. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bs-&gt;bl.request_=
alignment =3D (align !=3D 1) ? align : max_align;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (align !=3D 1) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bs-&=
gt;bl.request_alignment =3D align;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Fallback t=
o safe value. max_align is perfect, but the size of the device must be mult=
iple of<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the virtua=
l length of the device. In the other case we will get a error in<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* bdrv_node_=
refresh_perm().<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (align =3D max=
_align; align &gt; 1; align /=3D 2) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
(bs-&gt;total_sectors * BDRV_SECTOR_SIZE) % align =3D=3D 0) {<br></blockquo=
te><div><br></div><div>Moving image size calculation out of the loop would =
make the intent of the code</div><div>more clear:</div><div><br></div><div>=
=C2=A0 =C2=A0 if (image_size % align =3D=3D 0) {</div><div><br></div><div>S=
ince qemu does not enforce image size alignment, I can see how you create a=
 512 bytes</div><div>aligned image and in the case when qemu cannot detect =
the alignment, we end with=C2=A0</div><div>align =3D 4k. In this case this =
loop would select align =3D 512, but with the image aligned to</div><div>so=
me strange value, this loop may select align =3D 2 or some other value that=
 does not</div><div>make sense.</div><div><br></div><div>So I can see using=
 4k or 512 bytes as a good fallback value, but anything else should not</di=
v><div>be possible, so maybe we should fix this in bdrv_check_perm()?</div>=
<div><br></div><div>Nir</div></div></div>

--00000000000057dbb00607ab696f--


