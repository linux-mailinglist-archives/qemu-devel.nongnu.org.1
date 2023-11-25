Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE237F8CD7
	for <lists+qemu-devel@lfdr.de>; Sat, 25 Nov 2023 18:36:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6wZE-0002p7-2Q; Sat, 25 Nov 2023 12:35:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1r6wZC-0002ox-3v
 for qemu-devel@nongnu.org; Sat, 25 Nov 2023 12:35:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1r6wZ9-0005PJ-Qg
 for qemu-devel@nongnu.org; Sat, 25 Nov 2023 12:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700933738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hd4dRXDmxVpj1s4Xe47IfFisp6wwyLox245ybZxi4zI=;
 b=V3ircB+oRu9Fe1tScbSD5umKzSNKIecEunyeB3xKjdqHXz5sdbeLRKuys4ZKY6CDIThmlk
 1MEfGZLAn/TlsgS//OjxBvcf/OlgWu7uzie7i3m5F0C0cNEIh92+3Llf6ATgyYXaGEFQNQ
 GhHdskUIBnkO/ihz21l03hqu4Fhr3ZU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-iFWK_O8-Nfat9t0hhAQ73A-1; Sat, 25 Nov 2023 12:35:36 -0500
X-MC-Unique: iFWK_O8-Nfat9t0hhAQ73A-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c5161838d8so25949831fa.1
 for <qemu-devel@nongnu.org>; Sat, 25 Nov 2023 09:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700933735; x=1701538535;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hd4dRXDmxVpj1s4Xe47IfFisp6wwyLox245ybZxi4zI=;
 b=iiDkwPCOL4o6DsJVYHtyAApwQsiqO+3+jxWsudNMZO3SRGEtFnX6xsFqMitD/r4541
 HMUFOrSuNpyS0ONU2caL6pG0vpsvFoUlN5xaWpNlmFeKMcxm6bkYGrL2LvIyLUjsy7Dm
 QxTmjRgyXLUiFbva/9NK89m0rkK2/+J7URfLv9YRKYPs6aaoOwQBq7yMpgzX6c06tOW1
 He09s19PADXFk08i6tHVz4AAS2SNt779ADUk4OWAzDHcr/rOi4/eIuiE5u8RbansGn+4
 lqDZKL7b6P7tRExCii9aR3WwQoiSRw0qaoJG8P7j088cYFAKKq7YYiwmSteqhsx8Yu9s
 MUuQ==
X-Gm-Message-State: AOJu0Yyg31lYC1yMuJx1TPyzf4pnRDMTSBN18mP53fQAONVWvlIndGyJ
 U1DVKdQXgGW0/VMkFzBllVp+UnTLSTnVedRKaZRc82QsuhFVnUh/mBSGlZu0AAeH62qwKhB7ULi
 NNA3rrz0AagvV2S6Qu1zRx2YkLR7uuD8=
X-Received: by 2002:ac2:558d:0:b0:507:9ae6:6913 with SMTP id
 v13-20020ac2558d000000b005079ae66913mr3745985lfg.28.1700933735222; 
 Sat, 25 Nov 2023 09:35:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHqWS85Q2/zGtUmh9m8gGsAdILK62rxUvqLofAxNv+Huix68++fU/AYcPvb4XI816W/aF3y3ksmXyr7YLQJF0=
X-Received: by 2002:ac2:558d:0:b0:507:9ae6:6913 with SMTP id
 v13-20020ac2558d000000b005079ae66913mr3745976lfg.28.1700933734829; Sat, 25
 Nov 2023 09:35:34 -0800 (PST)
MIME-Version: 1.0
References: <20231102141010.300310-1-marcandre.lureau@redhat.com>
 <CAPMcbCoaRdeUvrZosMbdVjsCM+LJQYMGcwdfWY0MwEfJotxe5g@mail.gmail.com>
In-Reply-To: <CAPMcbCoaRdeUvrZosMbdVjsCM+LJQYMGcwdfWY0MwEfJotxe5g@mail.gmail.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Sat, 25 Nov 2023 19:35:23 +0200
Message-ID: <CAPMcbCr2jwFJ50xEuRbckrLO-ycVmEKj0h=PkgZ8d_eSNJ97YA@mail.gmail.com>
Subject: Re: [PATCH] build-sys: fix meson project version usage
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000000d29b2060afd7f82"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--0000000000000d29b2060afd7f82
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

PULL sent
https://patchew.org/QEMU/20231125173011.374840-1-kkostiuk@redhat.com/

On Sat, Nov 25, 2023 at 7:15=E2=80=AFPM Konstantin Kostiuk <kkostiuk@redhat=
.com>
wrote:

> Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
>
> On Thu, Nov 2, 2023 at 4:10=E2=80=AFPM <marcandre.lureau@redhat.com> wrot=
e:
>
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Program wixl found: YES (/usr/bin/wixl)
>>
>> ../qga/meson.build:149:16: ERROR: Unknown variable "project".
>>
>> Fixes: e20d68aa0b9 ("configure, meson: use command line options to
>> configure qemu-ga")
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  qga/meson.build | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/qga/meson.build b/qga/meson.build
>> index 940a51d55d..ff7a8496e4 100644
>> --- a/qga/meson.build
>> +++ b/qga/meson.build
>> @@ -146,7 +146,7 @@ if targetos =3D=3D 'windows'
>>        libpcre =3D 'libpcre2'
>>      endif
>>      qga_msi_version =3D get_option('qemu_ga_version') =3D=3D '' \
>> -      ? project.version() \
>> +      ? meson.project_version() \
>>        : get_option('qemu_ga_version')
>>      qga_msi =3D custom_target('QGA MSI',
>>                              input: files('installer/qemu-ga.wxs'),
>> --
>> 2.41.0
>>
>>

--0000000000000d29b2060afd7f82
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">PULL sent <a href=3D"https://patchew.org/QEMU/202311251730=
11.374840-1-kkostiuk@redhat.com/">https://patchew.org/QEMU/20231125173011.3=
74840-1-kkostiuk@redhat.com/</a></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Sat, Nov 25, 2023 at 7:15=E2=80=AFPM Kon=
stantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com">kkostiuk@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:k=
kostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, No=
v 2, 2023 at 4:10=E2=80=AFPM &lt;<a href=3D"mailto:marcandre.lureau@redhat.=
com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">From: Marc-Andr=C3=A9 Lur=
eau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank">ma=
rcandre.lureau@redhat.com</a>&gt;<br>
<br>
Program wixl found: YES (/usr/bin/wixl)<br>
<br>
../qga/meson.build:149:16: ERROR: Unknown variable &quot;project&quot;.<br>
<br>
Fixes: e20d68aa0b9 (&quot;configure, meson: use command line options to con=
figure qemu-ga&quot;)<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/meson.build | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/qga/meson.build b/qga/meson.build<br>
index 940a51d55d..ff7a8496e4 100644<br>
--- a/qga/meson.build<br>
+++ b/qga/meson.build<br>
@@ -146,7 +146,7 @@ if targetos =3D=3D &#39;windows&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0libpcre =3D &#39;libpcre2&#39;<br>
=C2=A0 =C2=A0 =C2=A0endif<br>
=C2=A0 =C2=A0 =C2=A0qga_msi_version =3D get_option(&#39;qemu_ga_version&#39=
;) =3D=3D &#39;&#39; \<br>
-=C2=A0 =C2=A0 =C2=A0 ? project.version() \<br>
+=C2=A0 =C2=A0 =C2=A0 ? meson.project_version() \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0: get_option(&#39;qemu_ga_version&#39;)<br>
=C2=A0 =C2=A0 =C2=A0qga_msi =3D custom_target(&#39;QGA MSI&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input: files(&#39;installer/qemu-ga.wxs&#39;=
),<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div>
</blockquote></div>

--0000000000000d29b2060afd7f82--


