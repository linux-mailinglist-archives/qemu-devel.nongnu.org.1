Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D36A7D7F6F
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 11:18:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvwUl-0000Rk-Er; Thu, 26 Oct 2023 05:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qvwUj-0000RV-OP
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 05:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qvwUi-0005Ow-A1
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 05:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698311854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QG6J751IPANtqrPwlBC26qomMJd2R8dLKHkW0R5RWok=;
 b=bKB3eXEvEvVYtnfq9NeZKjEeSTIhfT+LYYGL8R4UUYbYXOCJScJsk21bxU53TAnhj0Q8Vq
 37DDO+CggG4NfF388HY4WdQY6U2tcuR0fw0oY1AFWyHp34Niy6VReoyGHoffc2Z1dFtBs3
 l0amFzfrKq9JKJAtHXivjXB2J7Pm3k8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-te0Uwjr4OLWtLChbunsnIw-1; Thu, 26 Oct 2023 05:17:33 -0400
X-MC-Unique: te0Uwjr4OLWtLChbunsnIw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5079fe7cc7cso658499e87.2
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 02:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698311851; x=1698916651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QG6J751IPANtqrPwlBC26qomMJd2R8dLKHkW0R5RWok=;
 b=LfB7ciFSGBT7qH6BlrThTg+kZD995K4CJ9nEVztGQojocMjaoWJEp5rkPwIgwo84i3
 XLbnFaM4+qVa4jJTHyaGS2ST6ypdYzJZ+iuZTVeuEliVTBetNWSwTJDslffZHHrp1I7m
 ttvLnMYhps/NnKiZyWDr6UqYtbAJjJzsUvsyHOwYOGl4ZufG5Te2oBKOCPyT/t6B3sS5
 mIZ1PfQGgPjn19Bp/LRGvimrQkM8S51vNY9LXlRSkFUUcysOdz0BQFtF+Vl36qAmuG5h
 MRsDlRJnSq5dbtMF8Xi/Jt6jh0Nb1LXyVN+3WM6Vg0eRRhdwqs+BIZ2k9iq37zXivibl
 BBog==
X-Gm-Message-State: AOJu0Yx8OV5e/rTVkjHlp2cpWcuZU9m+2JFqAPSXb93l+Q3Glf/uR8/K
 2kyY4eQ2s4wYKBZk4Pfw49oAkmhS3VBJZHV+tR9c+uboHvCdL/4M3uUcKs7u/mugY9wrJkF3Jho
 +wi4Y0Bhguo9DEDdpBgCTE9GuujTYmz6P1CBIftdcUQ==
X-Received: by 2002:a05:6512:52a:b0:507:cb04:59d4 with SMTP id
 o10-20020a056512052a00b00507cb0459d4mr11600755lfc.8.1698311851248; 
 Thu, 26 Oct 2023 02:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETPkrihj0odhUmbfJVwdOzaQqCeRZ95QKH77wfopeTWUeulAyxHvFLgUmf9Jm818KlFnb+kX0rqho3xira1/I=
X-Received: by 2002:a05:6512:52a:b0:507:cb04:59d4 with SMTP id
 o10-20020a056512052a00b00507cb0459d4mr11600745lfc.8.1698311850884; Thu, 26
 Oct 2023 02:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231025140058.113376-1-alexander.ivanov@virtuozzo.com>
 <20231025140058.113376-7-alexander.ivanov@virtuozzo.com>
In-Reply-To: <20231025140058.113376-7-alexander.ivanov@virtuozzo.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Thu, 26 Oct 2023 12:17:19 +0300
Message-ID: <CAPMcbCoh2u+0Gx2DVBW2Uht2TsevxkYUEHAr6s92y481RoNpFw@mail.gmail.com>
Subject: Re: [PATCH 6/6] qga: Cancel async snapshot before abort
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Dehan Meng <demeng@redhat.com>
Cc: qemu-devel@nongnu.org, den@virtuozzo.com, michael.roth@amd.com, 
 marcandre.lureau@gmail.com
Content-Type: multipart/alternative; boundary="000000000000971aeb06089b0ac8"
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

--000000000000971aeb06089b0ac8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 5:01=E2=80=AFPM Alexander Ivanov <
alexander.ivanov@virtuozzo.com> wrote:

> VSS requestor calls abort after the timeout of the backup operation
> expires. In the result later the process hangs on some internal VSS
> lock. Cancel async snapshot before abort.
>

Can you share some information on how to reproduce this issue?


>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>  qga/vss-win32/requester.cpp | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index 9884c65e70..20680a42a1 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -533,6 +533,7 @@ void requester_freeze(int *num_vols, void
> *mountpoints, ErrorSet *errset)
>      }
>
>      if (wait_status !=3D WAIT_OBJECT_0) {
> +        vss_ctx.pAsyncSnapshot->Cancel();
>          err_set(errset, E_FAIL,
>                  "couldn't receive Frozen event from VSS provider");
>          goto out;
> --
> 2.34.1
>
>

--000000000000971aeb06089b0ac8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 25, 2023 at 5:01=E2=80=AF=
PM Alexander Ivanov &lt;<a href=3D"mailto:alexander.ivanov@virtuozzo.com">a=
lexander.ivanov@virtuozzo.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">VSS requestor calls abort after the timeout of=
 the backup operation<br>
expires. In the result later the process hangs on some internal VSS<br>
lock. Cancel async snapshot before abort.<br></blockquote><div><br></div><d=
iv>Can you share some information on how to reproduce this issue? <br></div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Alexander Ivanov &lt;<a href=3D"mailto:alexander.ivanov@virt=
uozzo.com" target=3D"_blank">alexander.ivanov@virtuozzo.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/requester.cpp | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp<br>
index 9884c65e70..20680a42a1 100644<br>
--- a/qga/vss-win32/requester.cpp<br>
+++ b/qga/vss-win32/requester.cpp<br>
@@ -533,6 +533,7 @@ void requester_freeze(int *num_vols, void *mountpoints,=
 ErrorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (wait_status !=3D WAIT_OBJECT_0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vss_ctx.pAsyncSnapshot-&gt;Cancel();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err_set(errset, E_FAIL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;couldn&=
#39;t receive Frozen event from VSS provider&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000971aeb06089b0ac8--


