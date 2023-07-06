Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 084597496D8
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 09:55:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHJpc-0001PQ-Et; Thu, 06 Jul 2023 03:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHJpS-0001NR-TL
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 03:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHJpR-0006wR-8S
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 03:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688630104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WpagJKcD957bqNBG0NhbnwEA8KGS51hVUldyc/CUoxw=;
 b=I2V6JHGpTZtbsoxCV+FOPj5L3Sjo7o8ksXcdjPZJPO6982ePgx1g49M45hM8I2Yvlmz0fN
 b7ESUT+klrTlU4RYmZ2p9YGELcJnQ8wxgPxy2iXBtDXVbgmo1vs12G5xAmXV1l7TDyKKmB
 96wy+cp2K+8RCPRcm8kzRUQfnEANzmQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-zE4TYP7wONeUPqCr0SphLA-1; Thu, 06 Jul 2023 03:55:02 -0400
X-MC-Unique: zE4TYP7wONeUPqCr0SphLA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b6fdb7eeafso3721281fa.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 00:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688630099; x=1691222099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WpagJKcD957bqNBG0NhbnwEA8KGS51hVUldyc/CUoxw=;
 b=Y91wF62kog/x0m3M9+Jh38ROUAXArNobYPsHtTY4qcBCqULw++MDcEsOvylXGEN36U
 4QXb5M06AeV3ZDgTDO393/U++gmyevStpmFzHoCRxWOQv+zG1u34JbmWHA2lj36JkTBb
 iM72m+DhROjClyXCLFshXvfWR9Nm7Y7lxEAM7fjc64XOBwra195IWY3WDeUhMCtocFbC
 NK4MH6b5rkA40qv9QPV/inEh2hy520ZFmqK7fdOLSbCN7rix7sP16zZmZdEYVBwOvuZm
 a9bd+xNwQp0f1j980tiQcuKFcZU2ilfBQtlxFV0F7BAVEevsfJWWM5DJK+bhFYoal6FY
 65nw==
X-Gm-Message-State: ABy/qLaleYunGeTa4dqAO4IJZBS7uDjJGZ79DbZOHh2W94v7h9LqWvs4
 v1eP59ie7GieDMMGJVgXpnDlb/6essyUMl5+oLjLFGtjHBTro6Xmv9vo8kif8n29tkRiX3nSxX9
 FcJUEmeUO++FXFOTT3t1SqRDjn32EWrI=
X-Received: by 2002:a2e:98c7:0:b0:2b6:e2c1:9816 with SMTP id
 s7-20020a2e98c7000000b002b6e2c19816mr814020ljj.20.1688630099407; 
 Thu, 06 Jul 2023 00:54:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHDbutMUqa8boZKxNvrWbp2niV5xCtenKTH91Z3Von1YKbfBDo44q+mrqTLOKErgiSL3sQy5XwVdL5dcLR+w5g=
X-Received: by 2002:a2e:98c7:0:b0:2b6:e2c1:9816 with SMTP id
 s7-20020a2e98c7000000b002b6e2c19816mr814009ljj.20.1688630099116; Thu, 06 Jul
 2023 00:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230705141205.525776-1-kkostiuk@redhat.com>
 <20230705141205.525776-2-kkostiuk@redhat.com>
 <413a30a2-c050-7587-8c0e-a6d89c8b7ab3@linaro.org>
In-Reply-To: <413a30a2-c050-7587-8c0e-a6d89c8b7ab3@linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Thu, 6 Jul 2023 10:54:47 +0300
Message-ID: <CAPMcbCp2Rx4jz3S9R8VbaeRZrkakn4HE7e-GZtubv5b29Km1OA@mail.gmail.com>
Subject: Re: [PATCH 1/4] QGA VSS: Add wrapper to send log to debugger and
 stderr
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000037137e05ffccd5bb"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--00000000000037137e05ffccd5bb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Wed, Jul 5, 2023 at 11:35=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi Konstantin,
>
> On 5/7/23 16:12, Konstantin Kostiuk wrote:
> > Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> > ---
> >   qga/vss-win32/vss-debug.h | 31 +++++++++++++++++++++++++++++++
> >   1 file changed, 31 insertions(+)
> >   create mode 100644 qga/vss-win32/vss-debug.h
>
>
> > +#define PRINT_DEBUG(fmt, ...) {
>        \
> > +    char user_sting[512] =3D { 0 };
>        \
> > +    char full_string[640] =3D { 0 };
>       \
> > +    snprintf(user_sting, 512, fmt, ## __VA_ARGS__);
>        \
> > +    snprintf(full_string, 640, QGA_PROVIDER_NAME"[%lu]: %s %s\n",
>        \
> > +        GetCurrentThreadId(), __func__, user_sting);
>       \
> > +    OutputDebugString(full_string);
>        \
> > +    fprintf(stderr, "%s", full_string);
>        \
> > +}
>
> Why not simply use a plain function?
>

I am not sure what you mean.

If you mean to call OutputDebugString directly, then we need to concatenate
the proper string
for each call.
If you mean convert PRINT_DEBUG to function, then we can't use the __func__
macro in
PRINT_DEBUG to get the real function name. We can convert PRINT_DEBUG to
function
and a new macro that will call PRINT_DEBUG and pass a proper value of
__fucn__.

What solution is better there?


>
> > +#define PRINT_DEBUG_BEGIN PRINT_DEBUG("begin")
> > +#define PRINT_DEBUG_END PRINT_DEBUG("end")
> > +
> > +#endif
>
>

--00000000000037137e05ffccd5bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe,<br></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 5, 2023 at 11=
:35=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Hi Konstantin,<br>
<br>
On 5/7/23 16:12, Konstantin Kostiuk wrote:<br>
&gt; Signed-off-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redha=
t.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0qga/vss-win32/vss-debug.h | 31 +++++++++++++++++++++++++++=
++++<br>
&gt;=C2=A0 =C2=A01 file changed, 31 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 qga/vss-win32/vss-debug.h<br>
<br>
<br>
&gt; +#define PRINT_DEBUG(fmt, ...) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 char user_sting[512] =3D { 0 };=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 char full_string[640] =3D { 0 };=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 snprintf(user_sting, 512, fmt, ## __VA_ARGS__);=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 snprintf(full_string, 640, QGA_PROVIDER_NAME&quot;[%lu]=
: %s %s\n&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 GetCurrentThreadId(), __func__, user_stin=
g);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 OutputDebugString(full_string);=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 fprintf(stderr, &quot;%s&quot;, full_string);=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +}<br>
<br>
Why not simply use a plain function?<br></blockquote><div><br></div><div>I =
am not sure what you mean. <br><br>If you mean to call OutputDebugString di=
rectly, then we need to concatenate the proper string</div><div>for each ca=
ll.<br>If you mean convert PRINT_DEBUG to function, then we can&#39;t use t=
he __func__ macro in</div><div>PRINT_DEBUG to get the real function name. W=
e can convert PRINT_DEBUG to function <br></div><div>and a new macro that w=
ill call PRINT_DEBUG and pass a proper value of __fucn__.<br><br>What solut=
ion is better there? </div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
&gt; +#define PRINT_DEBUG_BEGIN PRINT_DEBUG(&quot;begin&quot;)<br>
&gt; +#define PRINT_DEBUG_END PRINT_DEBUG(&quot;end&quot;)<br>
&gt; +<br>
&gt; +#endif<br>
<br>
</blockquote></div></div>

--00000000000037137e05ffccd5bb--


