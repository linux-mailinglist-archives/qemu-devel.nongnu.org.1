Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 482DE749790
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:36:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKTO-0003cT-CS; Thu, 06 Jul 2023 04:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHKTM-0003bm-2G
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qHKTK-000763-61
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688632576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3SjgP7686GQZfv8fgkyfl4FZEkpLB8N63udlicjyxwQ=;
 b=c+KOvEZutYrjrPNTQeHLYiD74qgMjX/xPMkixKZShFlRPYizVsW8fBLz/n0xWVyrlwP2Dv
 EB4g+G3HkDYwYsb8nvUIC8nAlpMGRLiIexDC0V3g6FJVBWHVw7TNX1DzfWsiLpnTGKXfP2
 ez+/D3CrX4yE3LekwhR/HnHqSXSkkGI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-xDvrBiplM3-8vezK_Lu9_A-1; Thu, 06 Jul 2023 04:36:14 -0400
X-MC-Unique: xDvrBiplM3-8vezK_Lu9_A-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4edc7ab63ccso192353e87.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688632573; x=1691224573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3SjgP7686GQZfv8fgkyfl4FZEkpLB8N63udlicjyxwQ=;
 b=ak8HpM5d0MRZDz4yy+t/drLamEWbOOVAY/VXk0KcxUTpygQRRF1y7C/oaNwuBMS9RT
 /tFpVZ+opf02mAi98bElDXzQtrnU/rOWSu497YHVlogu8IRPJL6AlJK6g5pywjApGYK+
 06BMGNoHjmrUHp4V/cVtpBHQV8Pc7mROwjg58EUMPsvQH2rb/plC+t68GIZryite3/YC
 qvPbcFNwwyjv3ekoAqS7NZun+kMjHbuMnaekvjN1xa8WdGl7qBRNIDWmGjd6I9qAM1yw
 AAYBaxO7sOwNI9iV0Y6LbPZy7TzVYqf1r1ZLH+drcjWzwRVzowRy+b0faZlcn/fS++pa
 nW5g==
X-Gm-Message-State: ABy/qLZ2qXfWtiT5h0rqYwHhbp7eRGb9j4Jc8/1TVAO2q870KszbU6qj
 1gaWiRnKvbMIh6GFDSWfG34hwYrv1fAB8zM9ZkRbiDviZMDytf0LLIHdvaeMoNRvxEUByq21S5Z
 S7kD+IrnW/hHjfweniEdXhlXwLSrqEfI=
X-Received: by 2002:a2e:3a1a:0:b0:2b6:3651:f12f with SMTP id
 h26-20020a2e3a1a000000b002b63651f12fmr811197lja.3.1688632573278; 
 Thu, 06 Jul 2023 01:36:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFPHj8Imvp/IGZnkx5FhbU+iSwPLKVgbRRT+rwumlvD9B2R5Frs7r3lREqL6cvMEevDt0c9XoUZaLXXxveTQyg=
X-Received: by 2002:a2e:3a1a:0:b0:2b6:3651:f12f with SMTP id
 h26-20020a2e3a1a000000b002b63651f12fmr811190lja.3.1688632573015; Thu, 06 Jul
 2023 01:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230705141205.525776-1-kkostiuk@redhat.com>
 <20230705141205.525776-3-kkostiuk@redhat.com>
 <fe2afd5c-fc4b-f1f5-017b-a33cb9bfe894@linaro.org>
In-Reply-To: <fe2afd5c-fc4b-f1f5-017b-a33cb9bfe894@linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Thu, 6 Jul 2023 11:36:01 +0300
Message-ID: <CAPMcbCqbzGMZJ2V2ZPxovR5_MB4UCZuwYoLqqpbeQLqFfnEjkg@mail.gmail.com>
Subject: Re: [PATCH 2/4] QGA VSS: Replace 'fprintf(stderr' with PRINT_DEBUG
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000abcf5d05ffcd684a"
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

--000000000000abcf5d05ffcd684a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 5, 2023 at 11:36=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 5/7/23 16:12, Konstantin Kostiuk wrote:
> > Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> > ---
> >   qga/vss-win32/install.cpp   | 13 +++++++------
> >   qga/vss-win32/requester.cpp |  9 +++++----
> >   2 files changed, 12 insertions(+), 10 deletions(-)
> >
> > diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> > index ff93b08a9e..c10a397e51 100644
> > --- a/qga/vss-win32/install.cpp
> > +++ b/qga/vss-win32/install.cpp
> > @@ -13,6 +13,7 @@
> >   #include "qemu/osdep.h"
> >
> >   #include "vss-common.h"
> > +#include "vss-debug.h"
> >   #ifdef HAVE_VSS_SDK
> >   #include <vscoordint.h>
> >   #else
> > @@ -54,7 +55,7 @@ void errmsg(DWORD err, const char *text)
> >                     FORMAT_MESSAGE_FROM_SYSTEM |
> FORMAT_MESSAGE_IGNORE_INSERTS,
> >                     NULL, err, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT=
),
> >                     (char *)&msg, 0, NULL);
> > -    fprintf(stderr, "%.*s. (Error: %lx) %s\n", len, text, err, msg);
> > +    PRINT_DEBUG("%.*s. (Error: %lx) %s\n", len, text, err, msg);
>
> PRINT_DEBUG() ends calling fprintf(stderr)...
>
>
Yes, PRINT_DEBUG calling fprintf(stderr).
This patch replaces fprintf(stderr call from errmsg with PRINT_DEBUG.

What do you mean by this comment?

--000000000000abcf5d05ffcd684a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 5, 2023 at 11:36=E2=80=AF=
PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phi=
lmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 5/7/23 16:12, Konstantin Kostiuk wrote:<br>
&gt; Signed-off-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redha=
t.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0qga/vss-win32/install.cpp=C2=A0 =C2=A0| 13 +++++++------<b=
r>
&gt;=C2=A0 =C2=A0qga/vss-win32/requester.cpp |=C2=A0 9 +++++----<br>
&gt;=C2=A0 =C2=A02 files changed, 12 insertions(+), 10 deletions(-)<br>
&gt; <br>
&gt; diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp<br>
&gt; index ff93b08a9e..c10a397e51 100644<br>
&gt; --- a/qga/vss-win32/install.cpp<br>
&gt; +++ b/qga/vss-win32/install.cpp<br>
&gt; @@ -13,6 +13,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &quot;vss-common.h&quot;<br>
&gt; +#include &quot;vss-debug.h&quot;<br>
&gt;=C2=A0 =C2=A0#ifdef HAVE_VSS_SDK<br>
&gt;=C2=A0 =C2=A0#include &lt;vscoordint.h&gt;<br>
&gt;=C2=A0 =C2=A0#else<br>
&gt; @@ -54,7 +55,7 @@ void errmsg(DWORD err, const char *text)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0NULL, err, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(char *)&amp;msg, 0, NULL);<br>
&gt; -=C2=A0 =C2=A0 fprintf(stderr, &quot;%.*s. (Error: %lx) %s\n&quot;, le=
n, text, err, msg);<br>
&gt; +=C2=A0 =C2=A0 PRINT_DEBUG(&quot;%.*s. (Error: %lx) %s\n&quot;, len, t=
ext, err, msg);<br>
<br>
PRINT_DEBUG() ends calling fprintf(stderr)...<br>
<br></blockquote><div><br></div><div>Yes, PRINT_DEBUG calling fprintf(stder=
r).</div><div>This patch replaces fprintf(stderr call from errmsg with PRIN=
T_DEBUG.</div><div><br></div><div>What do you mean by this comment? <br></d=
iv><div>=C2=A0</div></div></div>

--000000000000abcf5d05ffcd684a--


