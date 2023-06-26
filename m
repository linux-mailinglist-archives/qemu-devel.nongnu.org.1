Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C9273DDD3
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:38:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkWx-000227-OV; Mon, 26 Jun 2023 07:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qDkWp-00021k-MY
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:37:08 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qDkWn-0007A5-Rh
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:37:07 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4f8735ac3e3so4303579e87.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687779423; x=1690371423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sIHmpBVtJfD3c+NMBJotSI920QHbt6In1XfVXsVDlro=;
 b=NhjieTsiS2a2ncrkEQJ8pCjJmctNGvEWdEDTzDndBtygYBFAiSneRCnCwEkjzQtlMd
 FDonAwwmPj9+S3XG3gHEfY1kPmNmkmCJec2Z0r6jGGYM8s0Zm29JbM0wyrvZqr0gPJ8y
 crQvQ2ApYa7ALV2DmSxYBxdKEw+AH83nX0f9Qva7ckPr/5ei2hdoalFdikhy6G+B1GxE
 ktb/4HzVpXxSakGRq28ACOopOJIEnQ2l3VAbT4W0aXRu1CjPTup9pVxI+MtHlFWlqxVX
 hLZfn21iScGkZOKJBDzctWv3hK9vGfu4gW09H9Lr3lESvp7CnPqlBOzuFni7CBoWHTaC
 C3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687779423; x=1690371423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sIHmpBVtJfD3c+NMBJotSI920QHbt6In1XfVXsVDlro=;
 b=NgKyNcweTD0QIx5xJOArQpHHwzgiwNCJ1D4Y9H1Oq+dkvNkFQeUifeiAaa62tkOW6s
 o4w61pMW+68szB6KSvjeqZAhoeIEJU01OV3FRbZ8AC2fa9X6g8VhznHEwfv+vtN8Ij+u
 mQnNRTYfFzD6G6JAQb3MRTnM5A0fJ+9bekCW7W9l1gCAgkEvTly0ZNjFV7jPJM2yZFJx
 oCXjKSnSEaVD6ayxUFSH69LZuyzB8/2zCB6YGOrksTtfDsKLdcM/3urQwX2rCCaiCtnF
 z0X/eUaNzH2s+fj3BG9MTBNrnspTvuym9ilvGvhH/I6W9okLneJ+Dt8K3QsXbcXuIv+i
 v37w==
X-Gm-Message-State: AC+VfDwfKLs5sA06cJ0X80z8FTeV1p5f/DEHURjuD0Dc7pgviZuCwjng
 zp2rTq3BcKhlmit5RLr4e6ftC9E4+rCStJzK6h0=
X-Google-Smtp-Source: ACHHUZ7RjDIZKjw+6eMG/MS56Hi/9fWXYgeUkEXAkzgwwCM0i61YzCUYDPr1Vqa9mMAYi5o7I9nju1RhuXSWW+pS+nI=
X-Received: by 2002:a05:6512:3f9:b0:4fa:5fbc:bdc8 with SMTP id
 n25-20020a05651203f900b004fa5fbcbdc8mr2526790lfq.5.1687779423328; Mon, 26 Jun
 2023 04:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230623060454.3749910-1-vivek.kasireddy@intel.com>
In-Reply-To: <20230623060454.3749910-1-vivek.kasireddy@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 26 Jun 2023 13:36:51 +0200
Message-ID: <CAJ+F1CLzMnHUQE9is9YEFoFvp5+Zo5dwMmy1gGMOR5mvL=EW=Q@mail.gmail.com>
Subject: Re: [PATCH v1] virtio-gpu: Make non-gl display updates work again
 when blob=true
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Dongwon Kim <dongwon.kim@intel.com>
Content-Type: multipart/alternative; boundary="000000000000fc9ef405ff06c4cd"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000fc9ef405ff06c4cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2023 at 8:27=E2=80=AFAM Vivek Kasireddy <vivek.kasireddy@in=
tel.com>
wrote:

> In the case where the console does not have gl capability, and
> if blob is set to true, make sure that the display updates still
> work. Commit e86a93f55463 accidentally broke this by misplacing
> the return statement (in resource_flush) causing the updates to
> be silently ignored.
>
> Fixes: e86a93f55463 ("virtio-gpu: splitting one extended mode guest fb
> into n-scanouts")
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/display/virtio-gpu.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 66cddd94d9..97cd987cf3 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -498,6 +498,8 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
>      struct virtio_gpu_resource_flush rf;
>      struct virtio_gpu_scanout *scanout;
>      pixman_region16_t flush_region;
> +    bool within_bounds =3D false;
> +    bool update_submitted =3D false;
>      int i;
>
>      VIRTIO_GPU_FILL_CMD(rf);
> @@ -518,13 +520,28 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
>                  rf.r.x < scanout->x + scanout->width &&
>                  rf.r.x + rf.r.width >=3D scanout->x &&
>                  rf.r.y < scanout->y + scanout->height &&
> -                rf.r.y + rf.r.height >=3D scanout->y &&
> -                console_has_gl(scanout->con)) {
> -                dpy_gl_update(scanout->con, 0, 0, scanout->width,
> -                              scanout->height);
> +                rf.r.y + rf.r.height >=3D scanout->y) {
> +                within_bounds =3D true;
> +
> +                if (console_has_gl(scanout->con)) {
> +                    dpy_gl_update(scanout->con, 0, 0, scanout->width,
> +                                  scanout->height);
> +                    update_submitted =3D true;
> +                }
>              }
>          }
> -        return;
> +
> +        if (update_submitted) {
> +            return;
> +        }
> +        if (!within_bounds) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: flush bounds outside
> scanouts"
> +                          " bounds for flush %d: %d %d %d %d\n",
> +                          __func__, rf.resource_id, rf.r.x, rf.r.y,
> +                          rf.r.width, rf.r.height);
> +            cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +            return;
> +        }
>      }
>
>      if (!res->blob &&
> --
> 2.39.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000fc9ef405ff06c4cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 23, 2023 at 8:27=E2=80=AF=
AM Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasireddy@intel.com">vivek.k=
asireddy@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">In the case where the console does not have gl capability=
, and<br>
if blob is set to true, make sure that the display updates still<br>
work. Commit e86a93f55463 accidentally broke this by misplacing<br>
the return statement (in resource_flush) causing the updates to<br>
be silently ignored.<br>
<br>
Fixes: e86a93f55463 (&quot;virtio-gpu: splitting one extended mode guest fb=
 into n-scanouts&quot;)<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_bla=
nk">dongwon.kim@intel.com</a>&gt;<br>
Signed-off-by: Vivek Kasireddy &lt;<a href=3D"mailto:vivek.kasireddy@intel.=
com" target=3D"_blank">vivek.kasireddy@intel.com</a>&gt;<br></blockquote><d=
iv><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto=
:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div=
>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/display/virtio-gpu.c | 27 ++++++++++++++++++++++-----<br>
=C2=A01 file changed, 22 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c<br>
index 66cddd94d9..97cd987cf3 100644<br>
--- a/hw/display/virtio-gpu.c<br>
+++ b/hw/display/virtio-gpu.c<br>
@@ -498,6 +498,8 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,<br>
=C2=A0 =C2=A0 =C2=A0struct virtio_gpu_resource_flush rf;<br>
=C2=A0 =C2=A0 =C2=A0struct virtio_gpu_scanout *scanout;<br>
=C2=A0 =C2=A0 =C2=A0pixman_region16_t flush_region;<br>
+=C2=A0 =C2=A0 bool within_bounds =3D false;<br>
+=C2=A0 =C2=A0 bool update_submitted =3D false;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0VIRTIO_GPU_FILL_CMD(rf);<br>
@@ -518,13 +520,28 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rf.r.x &lt; s=
canout-&gt;x + scanout-&gt;width &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rf.r.x + rf.r=
.width &gt;=3D scanout-&gt;x &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rf.r.y &lt; s=
canout-&gt;y + scanout-&gt;height &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rf.r.y + rf.r.heig=
ht &gt;=3D scanout-&gt;y &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 console_has_gl(sca=
nout-&gt;con)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_gl_update(scan=
out-&gt;con, 0, 0, scanout-&gt;width,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scanout-&gt;height);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rf.r.y + rf.r.heig=
ht &gt;=3D scanout-&gt;y) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 within_bounds =3D =
true;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (console_has_gl=
(scanout-&gt;con)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_=
gl_update(scanout-&gt;con, 0, 0, scanout-&gt;width,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scanout-&gt;height);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 upda=
te_submitted =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (update_submitted) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!within_bounds) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &=
quot;%s: flush bounds outside scanouts&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot; bounds for flush %d: %d %d %d %d\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 __func__, rf.resource_id, rf.r.x, rf.r.y,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 rf.r.width, rf.r.height);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;error =3D VIRTIO_GPU_RES=
P_ERR_INVALID_PARAMETER;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!res-&gt;blob &amp;&amp;<br>
-- <br>
2.39.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000fc9ef405ff06c4cd--

