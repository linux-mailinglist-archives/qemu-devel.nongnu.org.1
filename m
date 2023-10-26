Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6AA7D7EC8
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 10:47:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvw1p-0000hl-RK; Thu, 26 Oct 2023 04:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qvw1k-0000Yz-UL
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:47:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qvw1i-0001LB-Bx
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698310057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pSzWPCwm38nP0Fl32ef0orK/fEfO45xAOtYnvNMzkU4=;
 b=hG6mIKPqbicQqBYfqmU90FRKEzudlJ3x5wngcnXX9l2IZAh2sepDo8wbRNWX8Jfx8gjyLF
 4Sf6dNRqShmo1wYDpq/3gZqDCnSZrYCekVIhbbKa+moP6Go8oR3gdBR6ZNMp79osAUijBT
 5H2Q5OxiBr3k8vgTFI8Uu0I2RTr2pV8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-fu1VpZFINu2G8soslZhiiQ-1; Thu, 26 Oct 2023 04:47:35 -0400
X-MC-Unique: fu1VpZFINu2G8soslZhiiQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507cc15323aso667420e87.0
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 01:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698310054; x=1698914854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pSzWPCwm38nP0Fl32ef0orK/fEfO45xAOtYnvNMzkU4=;
 b=Qmqnlf7eSizwQb9s4doyz2iqx2zjnV5EoNYlg6zDwcu9Qr+sQiUpPoIQDQMat6TvdM
 bx+FVe939iDyExvefPVrdeGNxfMHXKtuC7BWmoANOSXd2Y8PSxsVpn74iPVTwClpFTTW
 4Q0Q2XhHHtRbMAMhEi7TrRHp9ckgQg5m1CNyGSvz6EJIsi0xJUbCTeB+YRLk67Ahay3S
 TPhtltn3Bv99qmcyIe1P11g2nSlNaGHDyaEvZKdzYw8O6op9h0QpKwrPBoehpW9ZD0LX
 6sxFK61RBYGRTCar9gsD6szn6zU7HBBUJC8YWyE1TvsjX/NfVs3LUKwqWyZi+TN1+hMo
 doKw==
X-Gm-Message-State: AOJu0YxYS1a8Rggdfvg2zpj9CNbWpP4DefhO/UfiJ9+sj4n68wEFmBsm
 uS6DdJ7jU1sUVA0znQRAEJ+uo2oCSHdbPvJ1GJ3sCZrQinFt0V7e/w/DbDfHqGTOBhfdoXZR0H4
 DDPc4/mobB6PUnQhUUkraS1MllH2gyNM=
X-Received: by 2002:a19:6510:0:b0:507:a66b:edda with SMTP id
 z16-20020a196510000000b00507a66beddamr12505158lfb.18.1698310054425; 
 Thu, 26 Oct 2023 01:47:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7IE/RJyj2ZCOF7d8aOSpvdK1EX1lxFPZqN4UGoVOKIh9ofcdWsg0DmCxVuRnmfhtbB0zHEY65AfFoDhpp2JM=
X-Received: by 2002:a19:6510:0:b0:507:a66b:edda with SMTP id
 z16-20020a196510000000b00507a66beddamr12505150lfb.18.1698310054103; Thu, 26
 Oct 2023 01:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231025140058.113376-1-alexander.ivanov@virtuozzo.com>
 <20231025140058.113376-7-alexander.ivanov@virtuozzo.com>
In-Reply-To: <20231025140058.113376-7-alexander.ivanov@virtuozzo.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Thu, 26 Oct 2023 11:47:23 +0300
Message-ID: <CAPMcbCrO+cBNeFW-E0rTqS2eJAsWOTveU4Mh6Qmj94mvrontDg@mail.gmail.com>
Subject: Re: [PATCH 6/6] qga: Cancel async snapshot before abort
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, den@virtuozzo.com, michael.roth@amd.com, 
 marcandre.lureau@gmail.com
Content-Type: multipart/alternative; boundary="0000000000007e685106089a9f49"
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

--0000000000007e685106089a9f49
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Wed, Oct 25, 2023 at 5:01=E2=80=AFPM Alexander Ivanov <
alexander.ivanov@virtuozzo.com> wrote:

> VSS requestor calls abort after the timeout of the backup operation
> expires. In the result later the process hangs on some internal VSS
> lock. Cancel async snapshot before abort.
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

--0000000000007e685106089a9f49
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 2=
5, 2023 at 5:01=E2=80=AFPM Alexander Ivanov &lt;<a href=3D"mailto:alexander=
.ivanov@virtuozzo.com">alexander.ivanov@virtuozzo.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">VSS requestor calls ab=
ort after the timeout of the backup operation<br>
expires. In the result later the process hangs on some internal VSS<br>
lock. Cancel async snapshot before abort.<br>
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
</blockquote></div>

--0000000000007e685106089a9f49--


