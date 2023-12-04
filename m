Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E8A8029ED
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 02:35:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9xrk-0003HJ-81; Sun, 03 Dec 2023 20:35:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r9xra-0003H0-7h
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 20:35:10 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r9xrX-0003wR-Jo
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 20:35:09 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5c206572eedso2045143a12.0
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 17:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701653584; x=1702258384;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XpLiahXX8QVSJvkEM/fc5j+Uyi32SyZmYyq0K55CA+s=;
 b=wPvx8Le9fhdfd/Zz9GcrQq7fQOcqLbR/UEaZvY+u1JpdwFtStFqRTBW574PBG11pr3
 tAFFRzc8iDHDwkkX9Xj/kuuBdSEL+ZplYSBbHYHHaKRx+7oMizdmt2CbJ/GBZdlR4jvU
 32T7aBjCHslbVCN5R45qUyyBEShNbnzaHfOuSUwOYWbc0Pk6hSZPUdOzdSJ73/rCf9/h
 SA8tlnVWE3uYEos8zUzfG9jleClFFjLvFSQPcfYK7f1H2lgGnb4Xo21DPl2SIB6NdePM
 nOElNd4WskVyqLWXFZhFxlM8PINLdTIRWbZRDOZ1S+ybbaw5cucQPmoLnPc9e1rNR/dR
 Et/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701653584; x=1702258384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XpLiahXX8QVSJvkEM/fc5j+Uyi32SyZmYyq0K55CA+s=;
 b=fCAXJqOIjqIV+ln2zGPmpnPtJCJS4DtI1H+zypIGaDQksTaUTytWMjQz5b4uSFRwCg
 jShPTW3ehYZe57Yhf2iNaqvyvACVPgrEWKwdsFzIZ9ZfFUfwj2+xPaSUz8y8A//xzXbj
 oHVqEMgeoepFTO33dQbbtxHhY9Zsgk8RLb1i9f7FJcTFuaUlwVwFUin/dssYobOB3/Ii
 mkqLQhYqcpCPdMyXuQQ8Fv3PGGa0/vuvdvvz2AByROeMudhp+VN60PsRor3yuF3isKVK
 P12/iubjbAA5Ul8Q35oxlFITqAN9oCi74Gyg3bfpwBvd1ZO8cRZtc/FeTvPfNY05sv1L
 XZqg==
X-Gm-Message-State: AOJu0Yxd/XTtNO4HbA+qle4EzZ2gAovdUW6ak0+AUlv2NO6U+ycWseH0
 jFyAm+ObHdAki3VNf20hwJT0qsOIScQD0uAGwzJd3xcYHbUWx3/N/bT/I7us
X-Google-Smtp-Source: AGHT+IENP9d0OncZ1LzCdEnwtyib+L9K6WYBLxLARDNBaLFOFYUXzTqJPTXSRyAYxp2leokYhpZ1ELf706aVJ8yrKxg=
X-Received: by 2002:a05:6a20:d904:b0:18c:4b78:37a8 with SMTP id
 jd4-20020a056a20d90400b0018c4b7837a8mr4230557pzb.45.1701653582630; Sun, 03
 Dec 2023 17:33:02 -0800 (PST)
MIME-Version: 1.0
References: <20231204012230.4123-1-wafer@jaguarmicro.com>
In-Reply-To: <20231204012230.4123-1-wafer@jaguarmicro.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 4 Dec 2023 09:32:46 +0800
Message-ID: <CAK9dgmb4DNoNiyVFbNUMCgTLri_8BHDuUNmpeNCS2YC=upU3zg@mail.gmail.com>
Subject: Re: [PATCH] migration/dirtyrate: Remove an extra parameter
To: Wafer <wafer@jaguarmicro.com>
Cc: qemu-devel@nongnu.org, angus.chen@jaguarmicro.com
Content-Type: multipart/alternative; boundary="00000000000052e2cc060ba5195d"
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--00000000000052e2cc060ba5195d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 9:23=E2=80=AFAM Wafer <wafer@jaguarmicro.com> wrote:

> vcpu_dirty_stat_collect() has an unused parameter so remove it.
>
> Signed-off-by: Wafer <wafer@jaguarmicro.com>
> ---
>  migration/dirtyrate.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 036ac017fc..62d86b8be2 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -129,8 +129,7 @@ static DirtyPageRecord *vcpu_dirty_stat_alloc(VcpuSta=
t
> *stat)
>      return g_new0(DirtyPageRecord, nvcpu);
>  }
>
> -static void vcpu_dirty_stat_collect(VcpuStat *stat,
> -                                    DirtyPageRecord *records,
> +static void vcpu_dirty_stat_collect(DirtyPageRecord *records,
>                                      bool start)
>  {
>      CPUState *cpu;
> @@ -158,7 +157,7 @@ retry:
>      WITH_QEMU_LOCK_GUARD(&qemu_cpu_list_lock) {
>          gen_id =3D cpu_list_generation_id_get();
>          records =3D vcpu_dirty_stat_alloc(stat);
> -        vcpu_dirty_stat_collect(stat, records, true);
> +        vcpu_dirty_stat_collect(records, true);
>      }
>
>      duration =3D dirty_stat_wait(calc_time_ms, init_time_ms);
> @@ -172,7 +171,7 @@ retry:
>              cpu_list_unlock();
>              goto retry;
>          }
> -        vcpu_dirty_stat_collect(stat, records, false);
> +        vcpu_dirty_stat_collect(records, false);
>      }
>
>      for (i =3D 0; i < stat->nvcpu; i++) {
> --
> 2.27.0
>
>
Reviewed-by: Hyman Huang <yong.huang@smartx.com>

Thanks

--=20
Best regards

--00000000000052e2cc060ba5195d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 4, 202=
3 at 9:23=E2=80=AFAM Wafer &lt;<a href=3D"mailto:wafer@jaguarmicro.com">waf=
er@jaguarmicro.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style=
:solid;border-left-color:rgb(204,204,204);padding-left:1ex">vcpu_dirty_stat=
_collect() has an unused parameter so remove it.<br>
<br>
Signed-off-by: Wafer &lt;<a href=3D"mailto:wafer@jaguarmicro.com" target=3D=
"_blank">wafer@jaguarmicro.com</a>&gt;<br>
---<br>
=C2=A0migration/dirtyrate.c | 7 +++----<br>
=C2=A01 file changed, 3 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c<br>
index 036ac017fc..62d86b8be2 100644<br>
--- a/migration/dirtyrate.c<br>
+++ b/migration/dirtyrate.c<br>
@@ -129,8 +129,7 @@ static DirtyPageRecord *vcpu_dirty_stat_alloc(VcpuStat =
*stat)<br>
=C2=A0 =C2=A0 =C2=A0return g_new0(DirtyPageRecord, nvcpu);<br>
=C2=A0}<br>
<br>
-static void vcpu_dirty_stat_collect(VcpuStat *stat,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DirtyPageRecord *recor=
ds,<br>
+static void vcpu_dirty_stat_collect(DirtyPageRecord *records,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool start)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cpu;<br>
@@ -158,7 +157,7 @@ retry:<br>
=C2=A0 =C2=A0 =C2=A0WITH_QEMU_LOCK_GUARD(&amp;qemu_cpu_list_lock) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_id =3D cpu_list_generation_id_get();<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0records =3D vcpu_dirty_stat_alloc(stat);<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu_dirty_stat_collect(stat, records, true);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu_dirty_stat_collect(records, true);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0duration =3D dirty_stat_wait(calc_time_ms, init_time_ms=
);<br>
@@ -172,7 +171,7 @@ retry:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_list_unlock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto retry;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu_dirty_stat_collect(stat, records, false);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu_dirty_stat_collect(records, false);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; stat-&gt;nvcpu; i++) {<br>
-- <br>
2.27.0<br>
<br>
</blockquote></div><br clear=3D"all"><div><font face=3D"comic sans ms, sans=
-serif">Reviewed-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.co=
m">yong.huang@smartx.com</a>&gt;</font><br></div><div><br></div><div><div c=
lass=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-=
serif">Thanks</div><br></div><span class=3D"gmail_signature_prefix">-- </sp=
an><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font fa=
ce=3D"comic sans ms, sans-serif">Best regards</font></div></div></div>

--00000000000052e2cc060ba5195d--

