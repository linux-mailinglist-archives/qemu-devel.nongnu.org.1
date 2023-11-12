Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F78C7E920D
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 19:44:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2FQZ-0005h1-US; Sun, 12 Nov 2023 13:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r2FQM-0005gj-TY
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 13:43:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r2FQH-0002XU-6D
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 13:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699814584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mwTJKcwfepq5ihk6QtJsohNKQQcTYcatZflpB/K5Pf0=;
 b=doPvCPmcYX9dBYrJhYeIPWxihdfMcVMw1D7v/HMDpkucbEaNX/iZMxOSY16k1klZ4/G670
 NaTctPkh6t1BuCJ4igwgfjFzWcW6m2JWZsr+u30igH6bq40UzB6PdU1y3k+F4/JFPamkZz
 5nQnEhMPE0KsjiM3TWy99xMU8+AgEDY=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-6nRORqPPPhGwnovQgFChYQ-1; Sun, 12 Nov 2023 13:43:01 -0500
X-MC-Unique: 6nRORqPPPhGwnovQgFChYQ-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7b9b2b08b42so4184690241.1
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 10:43:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699814581; x=1700419381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mwTJKcwfepq5ihk6QtJsohNKQQcTYcatZflpB/K5Pf0=;
 b=P1QCaZammXfQa4qMIyp6nfGYB4ISB50ZmUPJJ4XJD3hye8hghHVNuWJs5bL0zafPhu
 okk25ZqCESKKyonPcTZ+KOimU3HeoFkLKlYhSct4RoCrS/mFnHVqmaZo+cHIn5NHqWGl
 YB6qMYtdaCR11epKlEzvjDgAEDn5IYl5UPjNMycE2KoWa7oXWa2KtGp9rWPkwdx4PnNz
 Yw019A4rjbHlYoTFcRQeCvX6s15aC91Jq73EBlg4kAipfurs9zHZBxHydo6iur9SlNYf
 K0Da6xedBvLSCGz6zfsZuOzk/hH5HOzVU/59V3++pk+C3VxhSttDxGh1z6avslE+DHto
 4vYw==
X-Gm-Message-State: AOJu0Yx4xgi3rFq+JS9BZlGy8jtOKrtJalNQr4E0lY3i2xneA5gAH8D0
 QOiPN+1A5ToRNbr0zkqP9bi6odAIPkMB7O7gcn6PxWnRlcjEpvBRp2DL5KXe7fjGUNyKcbc3Q16
 7hzaDKDHV6LJta1KLsEtDa8DKtIkosrNMecNKktCUUg==
X-Received: by 2002:a05:6102:c9:b0:452:6478:3e24 with SMTP id
 u9-20020a05610200c900b0045264783e24mr3456802vsp.12.1699814580828; 
 Sun, 12 Nov 2023 10:43:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEb+7heKdfjBZVu/GcJ7bN0NoPRd3SJxlXypaa4uGcCNIU27hM8JMYh2bqQ2bLa4kpAnANPtzTeP/ETyUTDMnU=
X-Received: by 2002:a05:6102:c9:b0:452:6478:3e24 with SMTP id
 u9-20020a05610200c900b0045264783e24mr3456798vsp.12.1699814580522; Sun, 12 Nov
 2023 10:43:00 -0800 (PST)
MIME-Version: 1.0
References: <610aad34-da0b-4b8a-aa22-4ad19513ae28@tls.msk.ru>
In-Reply-To: <610aad34-da0b-4b8a-aa22-4ad19513ae28@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 12 Nov 2023 18:03:47 +0100
Message-ID: <CABgObfYYnwD+hP2kh=O0jWG5soVno4hNy2iicszgXm--5CyFUg@mail.gmail.com>
Subject: Re: disable-pie build
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000041a9270609f8ecff"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
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

--00000000000041a9270609f8ecff
Content-Type: text/plain; charset="UTF-8"

Il sab 11 nov 2023, 03:40 Michael Tokarev <mjt@tls.msk.ru> ha scritto:

> Hi!
>
> It looks like --disable-pie configure, which uses -fno-pie -no-pie flags
> for the compiler, is broken: it does not not tell the *linker* about the
> option, so the link fails (at least on debian bookworm):
>
> /usr/bin/ld: libcommon.fa.p/hw_core_cpu-common.c.o: relocation R_X86_64_32
> against `.rodata' can not be used when making a PIE object; recompile with
> -fPIE
> /usr/bin/ld: failed to set dynamic section sizes: bad value
>
> This is failing for *all* executables, including tests, qemu-img, etc.
>

Is this new in bookworm? And also can you compare 8.0, 8.1 and 8.2?

Paolo

The following change fixes it:
>
> diff --git a/meson.build b/meson.build
> index a9c4f28247..0b7ca45d48 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -278,7 +278,8 @@ endif
>   # tries to build an executable instead of a shared library and fails.  So
>   # don't add -no-pie anywhere and cross fingers. :(
>   if not get_option('b_pie')
> -  qemu_common_flags += cc.get_supported_arguments('-fno-pie', '-no-pie')
> +  qemu_common_flags += cc.get_supported_arguments('-fno-pie')
> +  qemu_ldflags += cc.get_supported_arguments('-no-pie')
>   endif
>
>   if not get_option('stack_protector').disabled()
>
>
>

--00000000000041a9270609f8ecff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 11 nov 2023, 03:40 Michael Tokarev &lt;<a href=
=3D"mailto:mjt@tls.msk.ru">mjt@tls.msk.ru</a>&gt; ha scritto:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">Hi!<br>
<br>
It looks like --disable-pie configure, which uses -fno-pie -no-pie flags<br=
>
for the compiler, is broken: it does not not tell the *linker* about the<br=
>
option, so the link fails (at least on debian bookworm):<br>
<br>
/usr/bin/ld: libcommon.fa.p/hw_core_cpu-common.c.o: relocation R_X86_64_32 =
against `.rodata&#39; can not be used when making a PIE object; recompile w=
ith <br>
-fPIE<br>
/usr/bin/ld: failed to set dynamic section sizes: bad value<br>
<br>
This is failing for *all* executables, including tests, qemu-img, etc.<br><=
/blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Is th=
is new in bookworm? And also can you compare 8.0, 8.1 and 8.2?</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">The following change fixes it:<br>
<br>
diff --git a/meson.build b/meson.build<br>
index a9c4f28247..0b7ca45d48 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -278,7 +278,8 @@ endif<br>
=C2=A0 # tries to build an executable instead of a shared library and fails=
.=C2=A0 So<br>
=C2=A0 # don&#39;t add -no-pie anywhere and cross fingers. :(<br>
=C2=A0 if not get_option(&#39;b_pie&#39;)<br>
-=C2=A0 qemu_common_flags +=3D cc.get_supported_arguments(&#39;-fno-pie&#39=
;, &#39;-no-pie&#39;)<br>
+=C2=A0 qemu_common_flags +=3D cc.get_supported_arguments(&#39;-fno-pie&#39=
;)<br>
+=C2=A0 qemu_ldflags +=3D cc.get_supported_arguments(&#39;-no-pie&#39;)<br>
=C2=A0 endif<br>
<br>
=C2=A0 if not get_option(&#39;stack_protector&#39;).disabled()<br>
<br>
<br>
</blockquote></div></div></div>

--00000000000041a9270609f8ecff--


