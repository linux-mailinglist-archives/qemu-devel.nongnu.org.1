Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 038287B496C
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 21:20:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qn1yN-0005PM-Ab; Sun, 01 Oct 2023 15:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qn1yE-0005Hf-U7
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 15:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qn1y9-0007gD-AW
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 15:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696187947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LqM01s9qwhz4FTHDK2DMibsL6AllKhQEYlXp5iZOORg=;
 b=L6x4rJUqhi19s8c9BW+J7eTaREPQkBTj17ZR1BqGE0DhZ0IiCYR4mbWq4zJgveiCAOyITc
 pGyIZNM0s6RwQcLSioENdwRBYHI3T4v5oIcvyV8lJmvCq9cTHsiEgggURsZfOv5Bn8WJSb
 cbR3WIJtLw2RiLUvxqKtRkE1JFxVARk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-KcP5YoDZM2KlGsDwe4ag3g-1; Sun, 01 Oct 2023 15:18:49 -0400
X-MC-Unique: KcP5YoDZM2KlGsDwe4ag3g-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50428596a79so2016160e87.0
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 12:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696187928; x=1696792728;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LqM01s9qwhz4FTHDK2DMibsL6AllKhQEYlXp5iZOORg=;
 b=CPyojU08e7FsQPDpltCaxlEHRmwl0r5rfMNIlyW1Ai1zMEDoA8oTxip433EfdBveNO
 lDDrJlCSHzBxdhbr3Qn/jomxXaaV+arQzz4lacyx1zTcJWgckapPRBr8zlAGvdrEPWwt
 u07+s5ZEE0AKX4BI1+/I3qtwGNB2YjzwNHmOezAbg5DQhjli8YDX/hB2I5xreJjhXkun
 Spy1pZ8lF6UszoL0xacTX3fr5Irt1GBlw/QoAUW1OBs3+yAc7jErEdL7Xnj5A2QxToyo
 7Vejnq5Yj2QdYk7Dr56ZeyFwKTNZOZ+Td0icD9stvYgf1LbR23HGSPLWCK8C+1d3ZzTt
 CgBQ==
X-Gm-Message-State: AOJu0Yyae94Mgr6m/7+5ekZxXpohAjosu/m1pCtmcr9FzLG3zVXW7Nfv
 CA4PrklF7HQ1+D9wt25Vdsh4z0zkbeu2hbDsu1DThvUAsWVfwOEDnz+CJ0qFT3BqPjR/XonoSAp
 +j4zWusQ9Czo/OBHjjOJRd1yKTfMxhPw=
X-Received: by 2002:a05:6512:39cb:b0:500:943f:11c9 with SMTP id
 k11-20020a05651239cb00b00500943f11c9mr6818336lfu.3.1696187928374; 
 Sun, 01 Oct 2023 12:18:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTPCoW2BcI6ld39mOQAkDASqbPsvg7nkTdbR0Z7Cg9ValqpqOMokjGk1+1pfY4MCpNsoXhz88Gh3KFttBOqXY=
X-Received: by 2002:a05:6512:39cb:b0:500:943f:11c9 with SMTP id
 k11-20020a05651239cb00b00500943f11c9mr6818332lfu.3.1696187928157; Sun, 01 Oct
 2023 12:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696185261.git.dxu@dxuuu.xyz>
 <935735389830bbe8407d95ebf89632792bf11a30.1696185261.git.dxu@dxuuu.xyz>
In-Reply-To: <935735389830bbe8407d95ebf89632792bf11a30.1696185261.git.dxu@dxuuu.xyz>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Sun, 1 Oct 2023 22:18:37 +0300
Message-ID: <CAPMcbCry_WyXACfeapns47Mr1FtO7uG1+omwPxw72X+Rir=+nw@mail.gmail.com>
Subject: Re: [PATCH 2/2] qapi: qga: Clarify when out-data and err-data are
 populated
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: michael.roth@amd.com, armbru@redhat.com, berrange@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ee37bf0606ac8680"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000ee37bf0606ac8680
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Sun, Oct 1, 2023 at 9:39=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:

> If output is being captured for a guest-exec invocation, the out-data
> and err-data fields of guest-exec-status are only populated after the
> process is reaped. This is somewhat counter intuitive and too late to
> change. Thus, it would be good to document the behavior.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  qga/qapi-schema.json | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index b720dd4379..876e2a8ea8 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1220,11 +1220,13 @@
>  # @signal: signal number (linux) or unhandled exception code (windows)
>  #     if the process was abnormally terminated.
>  #
> -# @out-data: base64-encoded stdout of the process
> +# @out-data: base64-encoded stdout of the process. This field will only
> +#     be populated after the process exits.
>  #
> -# @err-data: base64-encoded stderr of the process Note: @out-data and
> +# @err-data: base64-encoded stderr of the process. Note: @out-data and
>  #     @err-data are present only if 'capture-output' was specified for
> -#     'guest-exec'
> +#     'guest-exec'. This field will only be populated after the process
> +#     exits.
>  #
>  # @out-truncated: true if stdout was not fully captured due to size
>  #     limitation.
> --
> 2.42.0
>
>

--000000000000ee37bf0606ac8680
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Oct 1=
, 2023 at 9:39=E2=80=AFPM Daniel Xu &lt;<a href=3D"mailto:dxu@dxuuu.xyz">dx=
u@dxuuu.xyz</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">If output is being captured for a guest-exec invocation, the out=
-data<br>
and err-data fields of guest-exec-status are only populated after the<br>
process is reaped. This is somewhat counter intuitive and too late to<br>
change. Thus, it would be good to document the behavior.<br>
<br>
Signed-off-by: Daniel Xu &lt;<a href=3D"mailto:dxu@dxuuu.xyz" target=3D"_bl=
ank">dxu@dxuuu.xyz</a>&gt;<br>
---<br>
=C2=A0qga/qapi-schema.json | 8 +++++---<br>
=C2=A01 file changed, 5 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index b720dd4379..876e2a8ea8 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1220,11 +1220,13 @@<br>
=C2=A0# @signal: signal number (linux) or unhandled exception code (windows=
)<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0if the process was abnormally terminated.<br>
=C2=A0#<br>
-# @out-data: base64-encoded stdout of the process<br>
+# @out-data: base64-encoded stdout of the process. This field will only<br=
>
+#=C2=A0 =C2=A0 =C2=A0be populated after the process exits.<br>
=C2=A0#<br>
-# @err-data: base64-encoded stderr of the process Note: @out-data and<br>
+# @err-data: base64-encoded stderr of the process. Note: @out-data and<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0@err-data are present only if &#39;capture-outpu=
t&#39; was specified for<br>
-#=C2=A0 =C2=A0 =C2=A0&#39;guest-exec&#39;<br>
+#=C2=A0 =C2=A0 =C2=A0&#39;guest-exec&#39;. This field will only be populat=
ed after the process<br>
+#=C2=A0 =C2=A0 =C2=A0exits.<br>
=C2=A0#<br>
=C2=A0# @out-truncated: true if stdout was not fully captured due to size<b=
r>
=C2=A0#=C2=A0 =C2=A0 =C2=A0limitation.<br>
-- <br>
2.42.0<br>
<br>
</blockquote></div>

--000000000000ee37bf0606ac8680--


