Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BF07A9359
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 11:56:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjGPM-0000Tu-6x; Thu, 21 Sep 2023 05:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qjGPK-0000TT-2M
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:55:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qjGPI-0000nk-6Z
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695290135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dri3RsH3g8lndNa43NZRaqbHtPvOO5pz32k35v82aAo=;
 b=RYEL6kyyvrJj507eABp1uEQmc99F1QTfwe5kmzqdIGHL7NYqPfC121DyND0dAw+j174Ynw
 B+OWCpCw/p30x9n2sCsHLBu69K+NcCnAkQvQlHQpyI877OhqG+dENxSLbSb3Pf75cSAoD1
 ClFr9Ei0AJD05y0aHEF/DADfcNGBVug=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-aEqpiZWgMLiUaVwhpOo28g-1; Thu, 21 Sep 2023 05:55:33 -0400
X-MC-Unique: aEqpiZWgMLiUaVwhpOo28g-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-504319087d9so321127e87.1
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 02:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695290132; x=1695894932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dri3RsH3g8lndNa43NZRaqbHtPvOO5pz32k35v82aAo=;
 b=EbgRBmrfQALN1ucyl6rjBCBWqRUVkyUaeseaw70SRYfVuMo67oyCyVxOCJZi+KDRoH
 SOStjVdZw9JU/TQfcxX6he48itb+QRmFAe/AZzGYJLmeht3qVV+y32kSfR3p+XCZ33GB
 HB5y/DLVSwgJYSHHz9L59hYwt8CMVvaUR2tHI/ZxCVDS52fo+WqkK71d69Cu+uj9dRd/
 Z3ZJ6aOt7gMx7HKC3qGXJ1a5shkxLSz4QmTrdhoJg/uq/hvht7b6Mj/pQrgL9unngWSx
 JKvDD4BMRHf+PaOYU4kTHzHL5bvBvvIUIqniJ/eTmbjLfYW65cvkUJp1tuRud6bIiNJ9
 SaTQ==
X-Gm-Message-State: AOJu0YwZtIOvEb1XAC1eIN73jH24OYU79ZB/HC2il6xWK8OPaKtkCGxb
 K4kZFMFPwU0qNI/JtG/tiyc2eSeVDeja9uNtBVIv/ufEExJXZPP94/Ih6+vrPLBMhGXTXoW2Xdm
 CJhCapTb/c2wKydLAj1s1NZx5Rakzvas=
X-Received: by 2002:a05:6512:524:b0:503:95b:db02 with SMTP id
 o4-20020a056512052400b00503095bdb02mr4281152lfc.18.1695290132412; 
 Thu, 21 Sep 2023 02:55:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIgZ1SUvQ3U7xGiITrsg7alOXTzXL8i6eQBn9LT708ZhTY9j6S3JAQKxIrukYg9Xsp/NOZpKBEIoXLzfAJaZo=
X-Received: by 2002:a05:6512:524:b0:503:95b:db02 with SMTP id
 o4-20020a056512052400b00503095bdb02mr4281141lfc.18.1695290132051; Thu, 21 Sep
 2023 02:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695034158.git.dxu@dxuuu.xyz>
 <ae16e9ec85a25e6ed679ca1360c57b3f2cafd138.1695034158.git.dxu@dxuuu.xyz>
In-Reply-To: <ae16e9ec85a25e6ed679ca1360c57b3f2cafd138.1695034158.git.dxu@dxuuu.xyz>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Thu, 21 Sep 2023 12:55:20 +0300
Message-ID: <CAPMcbCogd+n0E3sngsOP+fO2cp3A1uQE0wBqCBJpj05EPg4B_Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] qga: Fix memory leak when output stream is unused
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: michael.roth@amd.com, berrange@redhat.com, qemu-devel@nongnu.org, 
 hmodi@aviatrix.com
Content-Type: multipart/alternative; boundary="0000000000001cf6940605db7e04"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000001cf6940605db7e04
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Mon, Sep 18, 2023 at 2:00=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:

> If capture-output is requested but one of the channels goes unused (eg.
> we attempt to capture stderr but the command never writes to stderr), we
> can leak memory.
>
> guest_exec_output_watch() is (from what I understand) unconditionally
> called for both streams if output capture is requested. The first call
> will always pass the `p->size =3D=3D p->length` check b/c both values are
> 0. Then GUEST_EXEC_IO_SIZE bytes will be allocated for the stream.
>
> But when we reap the exited process there's a `gei->err.length > 0`
> check to actually free the buffer. Which does not get run if the command
> doesn't write to the stream.
>
> Fix by making free() unconditional.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  qga/commands.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qga/commands.c b/qga/commands.c
> index 09c683e263..ce172edd2d 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -206,15 +206,15 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid,
> Error **errp)
>  #endif
>          if (gei->out.length > 0) {
>              ges->out_data =3D g_base64_encode(gei->out.data,
> gei->out.length);
> -            g_free(gei->out.data);
>              ges->has_out_truncated =3D gei->out.truncated;
>          }
> +        g_free(gei->out.data);
>
>          if (gei->err.length > 0) {
>              ges->err_data =3D g_base64_encode(gei->err.data,
> gei->err.length);
> -            g_free(gei->err.data);
>              ges->has_err_truncated =3D gei->err.truncated;
>          }
> +        g_free(gei->err.data);
>
>          QTAILQ_REMOVE(&guest_exec_state.processes, gei, next);
>          g_free(gei);
> --
> 2.41.0
>
>

--0000000000001cf6940605db7e04
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">
Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" =
target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 18, 2023 at 2:=
00=E2=80=AFPM Daniel Xu &lt;<a href=3D"mailto:dxu@dxuuu.xyz">dxu@dxuuu.xyz<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I=
f capture-output is requested but one of the channels goes unused (eg.<br>
we attempt to capture stderr but the command never writes to stderr), we<br=
>
can leak memory.<br>
<br>
guest_exec_output_watch() is (from what I understand) unconditionally<br>
called for both streams if output capture is requested. The first call<br>
will always pass the `p-&gt;size =3D=3D p-&gt;length` check b/c both values=
 are<br>
0. Then GUEST_EXEC_IO_SIZE bytes will be allocated for the stream.<br>
<br>
But when we reap the exited process there&#39;s a `gei-&gt;err.length &gt; =
0`<br>
check to actually free the buffer. Which does not get run if the command<br=
>
doesn&#39;t write to the stream.<br>
<br>
Fix by making free() unconditional.<br>
<br>
Signed-off-by: Daniel Xu &lt;<a href=3D"mailto:dxu@dxuuu.xyz" target=3D"_bl=
ank">dxu@dxuuu.xyz</a>&gt;<br>
---<br>
=C2=A0qga/commands.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/qga/commands.c b/qga/commands.c<br>
index 09c683e263..ce172edd2d 100644<br>
--- a/qga/commands.c<br>
+++ b/qga/commands.c<br>
@@ -206,15 +206,15 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid, E=
rror **errp)<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (gei-&gt;out.length &gt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ges-&gt;out_data =3D g_base=
64_encode(gei-&gt;out.data, gei-&gt;out.length);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(gei-&gt;out.data);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ges-&gt;has_out_truncated =
=3D gei-&gt;out.truncated;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(gei-&gt;out.data);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (gei-&gt;err.length &gt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ges-&gt;err_data =3D g_base=
64_encode(gei-&gt;err.data, gei-&gt;err.length);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(gei-&gt;err.data);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ges-&gt;has_err_truncated =
=3D gei-&gt;err.truncated;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(gei-&gt;err.data);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QTAILQ_REMOVE(&amp;guest_exec_state.proce=
sses, gei, next);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(gei);<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div>

--0000000000001cf6940605db7e04--


