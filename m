Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EAB7F939A
	for <lists+qemu-devel@lfdr.de>; Sun, 26 Nov 2023 16:58:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7HVB-0006vr-IF; Sun, 26 Nov 2023 10:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r7HV9-0006vi-7n
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 10:56:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r7HV6-0002qN-6c
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 10:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701014208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xq5PPwZ111LoAk/tv7fyzGCGzMywQ/o85KZOqOpyUtg=;
 b=h6IMw3oG6XNQfZj/YwndR//JTIoBzptbMXWCnyv5RCUcXqzyuO5QI0Kybnh5c34Jx8du2c
 wH4Cauoh6/YfH8A/BMiH4cpt9Rx7znBh142mnUXUqEZ3WxixUmczk3hp56FJ7lPFE6uhD2
 BjerfF+VJqQQtML1S0E/izizmitVu20=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-tQOUmTxkPSOQB5ZQFX5A7Q-1; Sun, 26 Nov 2023 10:56:46 -0500
X-MC-Unique: tQOUmTxkPSOQB5ZQFX5A7Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a047f347c1cso467812466b.1
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 07:56:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701014205; x=1701619005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xq5PPwZ111LoAk/tv7fyzGCGzMywQ/o85KZOqOpyUtg=;
 b=YY0K8294K1WB9lxvXef1Rb4Mv5S2F8DK3u7j03plYkVx9INk8d9MyB5vZw3TEUDGi/
 GcuD7bLEuE4Iz7tF8EayXgG1DPrBmi68E6/+GPDqw4qgyeOrRVa0ZVYIgoyNwOUbjq74
 9MwRrmkWY02GN+ds/COUZI1DOL/eYsO+oIMUkQsMWoWZhwdINavOHNF2KpbdIPnAm/lo
 vapG+H8VL9OYjYY6GbqU0crQ4o4n1DVk1PySvdlLjhAudLJ4Fzni82b5doWlVPDO0dtC
 rHeo/NHhH43PgUb+vyxoz2nyDVxWj6tANTEdcON4QwSuTiCIrGPs9rAoyrA6oejWf+hn
 uPHg==
X-Gm-Message-State: AOJu0YzO4boWtlmTLV18vcqP4LnY3WUBf95M3z8IjEZ0GpQeKmpG+O/F
 WtDPEaPoCProc6/7WMusunZVr4aHMwdQQaSWukHikjSBYrAT/XQa/k+FVHf4cGvC0PPb0asLomh
 Z1nG3USje6YfMp7N727CACFBnJMmEXKQ=
X-Received: by 2002:a17:906:c791:b0:9ad:8a96:ad55 with SMTP id
 cw17-20020a170906c79100b009ad8a96ad55mr11255758ejb.14.1701014205135; 
 Sun, 26 Nov 2023 07:56:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEv0GJXNHx3LABRt5iulHak9Uo8FBtlJp9cYNL1p53NCAyvC5yRJwGD0ajhOnVRCulqkRHq0PHUAVVVPN4dkCs=
X-Received: by 2002:a17:906:c791:b0:9ad:8a96:ad55 with SMTP id
 cw17-20020a170906c79100b009ad8a96ad55mr11255751ejb.14.1701014204835; Sun, 26
 Nov 2023 07:56:44 -0800 (PST)
MIME-Version: 1.0
References: <6826113a-d428-401e-b5a3-56ad5d8fbaa4@gmail.com>
In-Reply-To: <6826113a-d428-401e-b5a3-56ad5d8fbaa4@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 26 Nov 2023 16:56:31 +0100
Message-ID: <CABgObfabW_WKdfGFgao0BJ0wHYHRx6KzMsLzvqUvzu3ZMx5Bdw@mail.gmail.com>
Subject: Re: [PATCH] qemu/timer: Don't use RDTSC on i486
To: Petr Cvek <petrcvekcz@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "S. Tsirkin, Michael" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006ffd7d060b103bac"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000006ffd7d060b103bac
Content-Type: text/plain; charset="UTF-8"

Il sab 25 nov 2023, 13:23 Petr Cvek <petrcvekcz@gmail.com> ha scritto:

> GCC defines __i386__ for i386 and i486, which both lack RDTSC instruction.
> The i386 seems to be impossible to distinguish, but i486 can be identified
> by checking for undefined __i486__.
>

As far as I know QEMU cannot be run on i486 anyway since TCG assumes the
presence of CPUID. Have you actually tried?

Paolo


> Signed-off-by: Petr Cvek <petrcvekcz@gmail.com>
> ---
>  include/qemu/timer.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index 9a366e551f..7baa5d1d41 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -872,7 +872,7 @@ static inline int64_t cpu_get_host_ticks(void)
>      return retval;
>  }
>
> -#elif defined(__i386__)
> +#elif defined(__i386__) && !defined(__i486__)
>
>  static inline int64_t cpu_get_host_ticks(void)
>  {
> --
> 2.43.0
>
>

--0000000000006ffd7d060b103bac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 25 nov 2023, 13:23 Petr Cvek &lt;<a href=3D"mai=
lto:petrcvekcz@gmail.com">petrcvekcz@gmail.com</a>&gt; ha scritto:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">GCC defines __i386__ for i386 and i486, whi=
ch both lack RDTSC instruction.<br>
The i386 seems to be impossible to distinguish, but i486 can be identified<=
br>
by checking for undefined __i486__.<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">As far as I know QEMU cannot be run on i=
486 anyway since TCG assumes the presence of CPUID. Have you actually tried=
?</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
<br>
Signed-off-by: Petr Cvek &lt;<a href=3D"mailto:petrcvekcz@gmail.com" target=
=3D"_blank" rel=3D"noreferrer">petrcvekcz@gmail.com</a>&gt;<br>
---<br>
=C2=A0include/qemu/timer.h | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/include/qemu/timer.h b/include/qemu/timer.h<br>
index 9a366e551f..7baa5d1d41 100644<br>
--- a/include/qemu/timer.h<br>
+++ b/include/qemu/timer.h<br>
@@ -872,7 +872,7 @@ static inline int64_t cpu_get_host_ticks(void)<br>
=C2=A0 =C2=A0 =C2=A0return retval;<br>
=C2=A0}<br>
<br>
-#elif defined(__i386__)<br>
+#elif defined(__i386__) &amp;&amp; !defined(__i486__)<br>
<br>
=C2=A0static inline int64_t cpu_get_host_ticks(void)<br>
=C2=A0{<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div></div>

--0000000000006ffd7d060b103bac--


