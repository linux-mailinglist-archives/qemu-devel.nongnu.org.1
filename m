Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 263487AEE78
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 16:35:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql98k-0005oD-Dj; Tue, 26 Sep 2023 10:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ql98i-0005o1-PH
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 10:34:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ql98h-00043O-1d
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 10:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695738852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NAH3Up23Pi/E35jm/8kjqEt549DeTjX6kaIyJ5kpa4M=;
 b=csZ4Kjmy2QivLAM3XeJvazQpyYPIBv0jfW95UCE4HGAGYbZhryluSvd7OZ3hEROC+D6Y1z
 mTOhs7Jbw/KJbNTOkiZ2J3OKj9gY6jabHGLxGhQGNYHB5YNwjcbV/gY8aY32MDLkM3f0sA
 LdwitqPsDeW9FX7Bn8AC/R+4CSkbSwk=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-Bog_BLNKMHGXUgyp_FYGgg-1; Tue, 26 Sep 2023 10:34:08 -0400
X-MC-Unique: Bog_BLNKMHGXUgyp_FYGgg-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-4526d86db34so4878378137.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 07:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695738847; x=1696343647;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NAH3Up23Pi/E35jm/8kjqEt549DeTjX6kaIyJ5kpa4M=;
 b=Cf4AVAf+dDf2Rp2wMlGe3sQhWrpUSumnNrb2aIOGcL/L14UeVQK/Dnhg6MKCasc/N0
 TNSDIHWdrcTtdXTdg8P8J90R+8/wKMYhLarh7MLGlkT27GNrtHU6DbkH9piJoWQpLrDo
 Ak2NkpZNvegOAUgfn3AAmPI3MCNSBqU94cDhFakG5YTrfyLwflq23VAsoWKqbMrBGHIt
 1Hor04eBH1HlD9OS0v7w5lGypgE6bKjYBgspHB9lvfJZxvJS6VB58YseYh63LR+8wFt2
 /tmpDUtjskl6+38sbzJPrsPBWNvll1+Q7fi439osS8+As1VOb8o1Vx6CheHePG/4B6zV
 JlXQ==
X-Gm-Message-State: AOJu0YwNr11RZ3izT1oDiWuOmJXoHXgT4IWoXWgRFf9psAxClzaHy4pO
 FRjSwV7tMFOnCz+9PfP9PUll9A63RZ7+wre0EJhPtuNJT6Wsoyyzdqa69sfsVChpMbfqgT1nGLR
 yTPcGWtjhNVAlt+/gBEZ1RXneL6siBKc=
X-Received: by 2002:a05:6102:3c3:b0:44e:a216:59a6 with SMTP id
 n3-20020a05610203c300b0044ea21659a6mr6371691vsq.4.1695738847635; 
 Tue, 26 Sep 2023 07:34:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7lzDDgugmAs5jPVa7vSyijiZAnkJZhPHW1PmHwlaxVocc38LrtQvSzLIa/8B4Y74Ym8uOf1QI0a3Oy+In6jU=
X-Received: by 2002:a05:6102:3c3:b0:44e:a216:59a6 with SMTP id
 n3-20020a05610203c300b0044ea21659a6mr6371675vsq.4.1695738847365; Tue, 26 Sep
 2023 07:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230925144922.529963-1-pbonzini@redhat.com>
 <8734z1qdli.fsf@pond.sub.org>
In-Reply-To: <8734z1qdli.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 26 Sep 2023 16:33:55 +0200
Message-ID: <CABgObfbt5ZsbQy2D9wb9Ns+rc_r3+6-Y_oG3O8Pe0+T3XtxBzg@mail.gmail.com>
Subject: Re: [PATCH] target/i386/seg_helper: remove shadowed variable
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000a12846060643f7b4"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

--000000000000a12846060643f7b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 26 set 2023, 15:16 Markus Armbruster <armbru@redhat.com> ha scritto:

> I still get these:
>
> ../target/i386/tcg/seg_helper.c: In function =E2=80=98switch_tss_ra=E2=80=
=99:
> ../target/i386/tcg/seg_helper.c:344:22: warning: declaration of =E2=80=98=
ptr=E2=80=99
> shadows a previous local [-Wshadow=3Dcompatible-local]
>   344 |         target_ulong ptr;
>       |                      ^~~
> ../target/i386/tcg/seg_helper.c:245:18: note: shadowed declaration is her=
e
>   245 |     target_ulong ptr;
>       |                  ^~~
> ../target/i386/tcg/seg_helper.c:345:18: warning: declaration of =E2=80=98=
e2=E2=80=99
> shadows a parameter [-Wshadow=3Dcompatible-local]
>   345 |         uint32_t e2;
>       |                  ^~
> ../target/i386/tcg/seg_helper.c:235:48: note: shadowed declaration is her=
e
>   235 |                          uint32_t e1, uint32_t e2, int source,
>       |                                       ~~~~~~~~~^~
> ../target/i386/tcg/seg_helper.c:402:22: warning: declaration of =E2=80=98=
ptr=E2=80=99
> shadows a previous local [-Wshadow=3Dcompatible-local]
>   402 |         target_ulong ptr;
>       |                      ^~~
> ../target/i386/tcg/seg_helper.c:245:18: note: shadowed declaration is her=
e
>   245 |     target_ulong ptr;
>       |                  ^~~
> ../target/i386/tcg/seg_helper.c:403:18: warning: declaration of =E2=80=98=
e2=E2=80=99
> shadows a parameter [-Wshadow=3Dcompatible-local]
>   403 |         uint32_t e2;
>       |                  ^~
> ../target/i386/tcg/seg_helper.c:235:48: note: shadowed declaration is her=
e
>   235 |                          uint32_t e1, uint32_t e2, int source,
>       |                                       ~~~~~~~~~^~
>

There's another seg_helper patch. 8)

Paolo


>

--000000000000a12846060643f7b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 26 set 2023, 15:16 Markus Armbruster &lt;<a hre=
f=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; ha scritto:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">I still get these:<br>
<br>
../target/i386/tcg/seg_helper.c: In function =E2=80=98switch_tss_ra=E2=80=
=99:<br>
../target/i386/tcg/seg_helper.c:344:22: warning: declaration of =E2=80=98pt=
r=E2=80=99 shadows a previous local [-Wshadow=3Dcompatible-local]<br>
=C2=A0 344 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong ptr;<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ^~~<br>
../target/i386/tcg/seg_helper.c:245:18: note: shadowed declaration is here<=
br>
=C2=A0 245 |=C2=A0 =C2=A0 =C2=A0target_ulong ptr;<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^~~<br>
../target/i386/tcg/seg_helper.c:345:18: warning: declaration of =E2=80=98e2=
=E2=80=99 shadows a parameter [-Wshadow=3Dcompatible-local]<br>
=C2=A0 345 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t e2;<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^~<br>
../target/i386/tcg/seg_helper.c:235:48: note: shadowed declaration is here<=
br>
=C2=A0 235 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t e1, uint32_t e2, int source,<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0~~~~~~~~~^~<br>
../target/i386/tcg/seg_helper.c:402:22: warning: declaration of =E2=80=98pt=
r=E2=80=99 shadows a previous local [-Wshadow=3Dcompatible-local]<br>
=C2=A0 402 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong ptr;<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ^~~<br>
../target/i386/tcg/seg_helper.c:245:18: note: shadowed declaration is here<=
br>
=C2=A0 245 |=C2=A0 =C2=A0 =C2=A0target_ulong ptr;<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^~~<br>
../target/i386/tcg/seg_helper.c:403:18: warning: declaration of =E2=80=98e2=
=E2=80=99 shadows a parameter [-Wshadow=3Dcompatible-local]<br>
=C2=A0 403 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t e2;<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^~<br>
../target/i386/tcg/seg_helper.c:235:48: note: shadowed declaration is here<=
br>
=C2=A0 235 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t e1, uint32_t e2, int source,<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0~~~~~~~~~^~<br></blockquote></div></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">There&#39;s another seg_helper patch. 8)</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
<br>
</blockquote></div></div></div>

--000000000000a12846060643f7b4--


