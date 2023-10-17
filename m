Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED4C7CBCBD
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 09:49:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsep9-0005CY-71; Tue, 17 Oct 2023 03:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qsep7-00058q-4C
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 03:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qsep5-0005zU-HV
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 03:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697528941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ow8jYmpI554zrBrPE0YQ87Y+2hX+ZjAY5qjpD3cyFek=;
 b=QeUYXuU61FCD7z8Bhj0BX4ezZnwUFwXq4RNgEwSfGvpd36A5Ph4miMLDKh2RBrryR4NzVv
 2ldj2sA41xoG44siM9nRJH4Vimb2wZ9L+0XcNwQqXi+K0iSxmHFnQwq4cpYzph8hbE+F56
 zpQvzBG5k6g4aM4ZrOuE3AGfJoEAkjs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-u5Kx--P6PvqbfecvJ59Y0A-1; Tue, 17 Oct 2023 03:48:59 -0400
X-MC-Unique: u5Kx--P6PvqbfecvJ59Y0A-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c50d73e212so30163301fa.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 00:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697528937; x=1698133737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ow8jYmpI554zrBrPE0YQ87Y+2hX+ZjAY5qjpD3cyFek=;
 b=ahFLWooK8SAE7ygtMY4YAYugNshrcC5606UOWP0S9g7xjfFO0aQ7pcVqb93Bn46p/i
 BPyD3feR2xByINMmIomt5Qv0fgJBQ1pANcR81kj2lFaHtVi5rCcbIl5GWtRWcgF/0f1e
 XvvI7tvdRdeKP6PVkYUPmVigNlc1dDqiNKQHOrD3ST1zsFbwRGIeyHAVNi5JZ6OymA9h
 8e+Uvte3dhJNevC9LWGzviqfEFSUN/dn8l0rYTeTuwRju1P0O+NZH/wJcP8h3q9tQHfU
 KU1oCtq2dmtWaj1+Jq2GnhAcTqad/mzsN7+Q6JRmG1nQGC1MXTQ1TlgLHJrg5SohqS49
 9e2A==
X-Gm-Message-State: AOJu0YxRTjg7Co9cn/oDaw7V5CSqxh2WVHGpMRfoXyZfDKJnGeNWm19e
 Wlpoo5cw4YfmiKq6ZHpk2qB/rwonxDY4PRNYPegIHFPt4RCcOlGfpUehmbxtzA73QDnAmhmw0Sb
 /xwASik4rBlHAuVZ7E0NqRjbqAw/lLi23QiPxHKpfmQ==
X-Received: by 2002:a2e:b52a:0:b0:2c5:106f:540f with SMTP id
 z10-20020a2eb52a000000b002c5106f540fmr1075355ljm.43.1697528937425; 
 Tue, 17 Oct 2023 00:48:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3fVhC7/Ixku+Dp6PgrEwGczRNhnWvVGC4JIseq0VOW2IN9Ku52W9ZmfsFWPCR/p8Cr17WVFSIZfwCca2q/sQ=
X-Received: by 2002:a2e:b52a:0:b0:2c5:106f:540f with SMTP id
 z10-20020a2eb52a000000b002c5106f540fmr1075347ljm.43.1697528937132; Tue, 17
 Oct 2023 00:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
 <e42c16ba150141c248368ab3666aae54b93bd59b.1697186560.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <e42c16ba150141c248368ab3666aae54b93bd59b.1697186560.git.manos.pitsidianakis@linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Tue, 17 Oct 2023 10:48:46 +0300
Message-ID: <CAPMcbCpZQUCtnOdhYmsTf=XWJBJD3KhF7Ns_us7bbbOdhCJC9w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 60/78] qga: add fallthrough pseudo-keyword
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000004b48a30607e4c149"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

--0000000000004b48a30607e4c149
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Fri, Oct 13, 2023 at 11:50=E2=80=AFAM Emmanouil Pitsidianakis <
manos.pitsidianakis@linaro.org> wrote:

> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  qga/main.c                  | 2 +-
>  qga/vss-win32/requester.cpp | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/qga/main.c b/qga/main.c
> index 8668b9f3d3..40471e8a0b 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -663,7 +663,7 @@ static gboolean channel_event_cb(GIOCondition
> condition, gpointer data)
>          if (!s->virtio) {
>              return false;
>          }
> -        /* fall through */
> +        fallthrough;
>      case G_IO_STATUS_AGAIN:
>          /* virtio causes us to spin here when no process is attached to
>           * host-side chardev. sleep a bit to mitigate this
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index 9884c65e70..36fa4fdf28 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -611,6 +611,7 @@ void requester_thaw(int *num_vols, void *mountpints,
> ErrorSet *errset)
>              break;
>          }
>          /* fall through if hEventTimeout is signaled */
> +        fallthrough;
>
>      case (HRESULT)VSS_E_HOLD_WRITES_TIMEOUT:
>          err_set(errset, hr, "couldn't hold writes: "
> --
> 2.39.2
>
>

--0000000000004b48a30607e4c149
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 13, 2023 at 11:50=
=E2=80=AFAM Emmanouil Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianak=
is@linaro.org">manos.pitsidianakis@linaro.org</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">In preparation of raising -Wim=
plicit-fallthrough to 5, replace all<br>
fall-through comments with the fallthrough attribute pseudo-keyword.<br>
<br>
Signed-off-by: Emmanouil Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidia=
nakis@linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;<=
br>
---<br>
=C2=A0qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 2 +-<br>
=C2=A0qga/vss-win32/requester.cpp | 1 +<br>
=C2=A02 files changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/qga/main.c b/qga/main.c<br>
index 8668b9f3d3..40471e8a0b 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -663,7 +663,7 @@ static gboolean channel_event_cb(GIOCondition condition=
, gpointer data)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!s-&gt;virtio) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fall through */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fallthrough;<br>
=C2=A0 =C2=A0 =C2=A0case G_IO_STATUS_AGAIN:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* virtio causes us to spin here when no =
process is attached to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * host-side chardev. sleep a bit to miti=
gate this<br>
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp<br>
index 9884c65e70..36fa4fdf28 100644<br>
--- a/qga/vss-win32/requester.cpp<br>
+++ b/qga/vss-win32/requester.cpp<br>
@@ -611,6 +611,7 @@ void requester_thaw(int *num_vols, void *mountpints, Er=
rorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through if hEventTimeout is signa=
led */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fallthrough;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case (HRESULT)VSS_E_HOLD_WRITES_TIMEOUT:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err_set(errset, hr, &quot;couldn&#39;t ho=
ld writes: &quot;<br>
-- <br>
2.39.2<br>
<br>
</blockquote></div>

--0000000000004b48a30607e4c149--


