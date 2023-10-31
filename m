Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2673A7DCBBA
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 12:25:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxmr9-0005GK-Cp; Tue, 31 Oct 2023 07:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qxmr6-0005Fn-RR
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:24:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qxmr5-0001wJ-4c
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698751457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sERtDIyT1ty5WWqNi52O4FutI2g/SWVD+rN2jDIz1c4=;
 b=dZlUdTDKr4WjGT2/dBz0aXyoJ9rTX6cN7cpdEZsnmDbQ5RVgbqWBfrZeiLhX3f2qdnNdBd
 rGSFAmTqc2MZ3seLYr885gVqMIjmDZIsaWXRCLu5T9z82/XMpIy0YYHAG5HQaM8ZRKjG7T
 WEI4b7Psw70NeT3Faq8Q/mY0xqeBnaI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-wqRpjFFLNTCnqm_YYM2KBg-1; Tue, 31 Oct 2023 07:24:15 -0400
X-MC-Unique: wqRpjFFLNTCnqm_YYM2KBg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5090f6a04e1so3374151e87.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 04:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698751454; x=1699356254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sERtDIyT1ty5WWqNi52O4FutI2g/SWVD+rN2jDIz1c4=;
 b=tqnnm3pLzBOarb+aamlX9JwZAPYIfl//kfdfafUFtx/SfRGz/mLEiu1IVrwTPPpWqf
 5+v0yaR2dC4lvKh1HPkQvLFm3vy+oACPGwkPnVURC2bwyLxoGLU/cliKL33S84++Dxbt
 BOV/x7JEU+azo8VE391JGzR9cDNibnnNqpfKinP3vX8cn7lno5IAG0y/EWPzcfRHF9Ok
 dSmW2dL5t6ZNaofjtRUpfACI63mnrK74dFe+cMiC//HilwuLfXTc3+Q2uqENspbRoQpu
 BHAcMmxDPNhRtVkQXCZ2Jr9w2FsiZ4Ns/kxgrM/HbD+e7HmD1pniNAtcy0sUw9Tck3BO
 Gf0A==
X-Gm-Message-State: AOJu0YzJobYV3WfIm+tkfnSANf56bU8yyJ/cHB4yLfBJknJ9zJbbSk2M
 ONPmILZBTFCSnEiaefhNQSd4g4OsEroRpg2obBDSDKpUkLGd6yRkFdHfAebrR3dLoFMAOq60EHm
 2hScvUiYrVTwsXY9uD3m4sdLn+f+pdEQ=
X-Received: by 2002:a05:6512:3b3:b0:500:be57:ce53 with SMTP id
 v19-20020a05651203b300b00500be57ce53mr8828030lfp.42.1698751454274; 
 Tue, 31 Oct 2023 04:24:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+OyVK+Ml8/AltaAsiZE0CnlPH26MOeKCSleAQ364t8cZFoZp0zXl37Z3TMVET3P/GcOqFwiBp8XkSLqR4Ni0=
X-Received: by 2002:a05:6512:3b3:b0:500:be57:ce53 with SMTP id
 v19-20020a05651203b300b00500be57ce53mr8828009lfp.42.1698751453914; Tue, 31
 Oct 2023 04:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231031111059.3407803-1-armbru@redhat.com>
 <20231031111059.3407803-4-armbru@redhat.com>
In-Reply-To: <20231031111059.3407803-4-armbru@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Tue, 31 Oct 2023 13:24:03 +0200
Message-ID: <CAPMcbCorwUODbRiWsgWZvNN-728qTHRfN8JzxvU9hoyxh3vd6g@mail.gmail.com>
Subject: Re: [PATCH 3/7] qga: Improve guest-exec-status error message
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, npiggin@gmail.com, 
 danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au, 
 harshpb@linux.ibm.com, dave@treblig.org, jasowang@redhat.com, 
 michael.roth@amd.com, mst@redhat.com, david@redhat.com, kraxel@redhat.com, 
 marcandre.lureau@redhat.com, qemu-ppc@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f902520609016489"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

--000000000000f902520609016489
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Tue, Oct 31, 2023 at 1:11=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> When the PID passed to guest-exec-status does not exist, we report
>
>     "Invalid parameter 'pid'"
>
> Improve this to
>
>     "PID 1234 does not exist"
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qga/commands.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qga/commands.c b/qga/commands.c
> index ce172edd2d..88c1c99fe5 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -154,7 +154,7 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid,
> Error **errp)
>
>      gei =3D guest_exec_info_find(pid);
>      if (gei =3D=3D NULL) {
> -        error_setg(errp, QERR_INVALID_PARAMETER, "pid");
> +        error_setg(errp, "PID " PRId64 " does not exist");
>          return NULL;
>      }
>
> --
> 2.41.0
>
>

--000000000000f902520609016489
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 3=
1, 2023 at 1:11=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@r=
edhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">When the PID passed to guest-exec-status does n=
ot exist, we report<br>
<br>
=C2=A0 =C2=A0 &quot;Invalid parameter &#39;pid&#39;&quot;<br>
<br>
Improve this to<br>
<br>
=C2=A0 =C2=A0 &quot;PID 1234 does not exist&quot;<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/qga/commands.c b/qga/commands.c<br>
index ce172edd2d..88c1c99fe5 100644<br>
--- a/qga/commands.c<br>
+++ b/qga/commands.c<br>
@@ -154,7 +154,7 @@ GuestExecStatus *qmp_guest_exec_status(int64_t pid, Err=
or **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0gei =3D guest_exec_info_find(pid);<br>
=C2=A0 =C2=A0 =C2=A0if (gei =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_INVALID_PARAMETER, &quot=
;pid&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;PID &quot; PRId64 &quot=
; does not exist&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div>

--000000000000f902520609016489--


