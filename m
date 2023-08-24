Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6309D786445
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 02:35:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYyIH-0007nz-SJ; Wed, 23 Aug 2023 20:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qYyIE-0007nq-Ko
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 20:33:46 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qYyI9-0003fg-52
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 20:33:46 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6bd045336c6so4633921a34.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 17:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1692837097; x=1693441897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zIF+5QgWEI9ojCezE0sZ7jLMJClYeaHkZOkXYOC6FYE=;
 b=lVQlq1w+tZSzK/HLhQkJhWyyC0rE4J/U8AUfNeMOkW3V/CsJv5i+AOMnIqW3ocZ057
 F7wXBOuX+SbnJmTanQjqIqoDoZ+b0auj6hlbRV3dBMqLh+C381OZL8taiTN1PT+4fA2/
 z74J3aBVbL+OXs/Z9hTAWY1eK9bEqYiOs/ryl7cwYt0d/1ymcs7Ed8bI2QKHCOwS/wRK
 G6uJWnwSHgOZ5j3L6Gd0YryYKHpfdgEw/L5zTQNA4LS752sXLXR14CjV0VUGj7OFe+BU
 eYJuqlolLdLUQsxUVb3K2bELuK+chzZ4Qhkk/jsoVw301Hj8WDBC0ZW2Lle/Bor+cubb
 xzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692837097; x=1693441897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zIF+5QgWEI9ojCezE0sZ7jLMJClYeaHkZOkXYOC6FYE=;
 b=PGmu27Rb4XJZur+eoVa9hlzaSr8OuTxoyGu46DcQ8Vsj0nOeu0BBBqBsOsvqpg4QPL
 IZVsjN/CYdwfxh/DdU0T+XHCUFGWj2B5Ihhccl0xcC4yNbGSIDiWHhTkFn+CHP7bAD4r
 FoJkqSXCM/M+fV/Ds1vTWR7Imn17vCjDV4bSF9o6WSpR0fqVZAptMGIBJ9clno6dWHyO
 ztxqL23X5kKa80nmjs6HWhG7ta8n3OWHDwKC/P3b29Hgx8aDTfveOjVtR5IxSWLLfekw
 M2jFXWTw4gZophL1VonB+L7oQhdhOz248hpumVgn54N8ZO+o2Wg8eZ3MabkMLKG5nV+g
 +VtQ==
X-Gm-Message-State: AOJu0YzfV78yy7DB6XBfxVb0dYpxP9gbFq5YuH+FTSqQiRZYxIkme0mQ
 P62ir7p62V5D2DvNfrqYYn8PLUatZl8t3Z7ap7UQrA==
X-Google-Smtp-Source: AGHT+IH1VNWU7SdISm6X10ULjvvD3YxUtG4WCK0IDu4LlQUGwgJNceAaC4CnU21lpYMQNF4TpO07JmJunB6z7oWF8uo=
X-Received: by 2002:a05:6870:b50d:b0:1b0:408a:1d05 with SMTP id
 v13-20020a056870b50d00b001b0408a1d05mr16406212oap.38.1692837097215; Wed, 23
 Aug 2023 17:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <SA1PR11MB67606FB284BF14ED9F11D436F51CA@SA1PR11MB6760.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB67606FB284BF14ED9F11D436F51CA@SA1PR11MB6760.namprd11.prod.outlook.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Thu, 24 Aug 2023 08:31:21 +0800
Message-ID: <CAK9dgmaXp1yE+VdMDpfKE2TVam1sx2UD9w49tVN16nYcF_ajFw@mail.gmail.com>
Subject: Re: [PATCH] softmmu: Fix dirtylimit memory leak
To: alloc.young@outlook.com
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d7a9290603a059d7"
Received-SPF: none client-ip=2607:f8b0:4864:20::32f;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000d7a9290603a059d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 3:48=E2=80=AFPM <alloc.young@outlook.com> wrote:

> From: "alloc.young" <alloc.young@outlook.com>
>
> Fix memory leak in hmp_info_vcpu_dirty_limit,use g_autoptr
> handle memory deallocation, alse use g_free to match g_malloc
> && g_new functions.
>
> Signed-off-by: alloc.young <alloc.young@outlook.com>
> ---
>  softmmu/dirtylimit.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>
> [...]

> diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c
> index 3c275ee55b..fa959d7743 100644
> --- a/softmmu/dirtylimit.c
> +++ b/softmmu/dirtylimit.c
> @@ -100,7 +100,7 @@ static void vcpu_dirty_rate_stat_collect(void)
>              stat.rates[i].dirty_rate;
>      }
>
> -    free(stat.rates);
> +    g_free(stat.rates);
>  }
>
> Code optimization.

>  static void *vcpu_dirty_rate_stat_thread(void *opaque)
> @@ -171,10 +171,10 @@ void vcpu_dirty_rate_stat_initialize(void)
>
>  void vcpu_dirty_rate_stat_finalize(void)
>  {
> -    free(vcpu_dirty_rate_stat->stat.rates);
> +    g_free(vcpu_dirty_rate_stat->stat.rates);
>      vcpu_dirty_rate_stat->stat.rates =3D NULL;
>
> -    free(vcpu_dirty_rate_stat);
> +    g_free(vcpu_dirty_rate_stat);
>      vcpu_dirty_rate_stat =3D NULL;
>  }
>
> Likewise...

> @@ -220,10 +220,10 @@ void dirtylimit_state_initialize(void)
>
>  void dirtylimit_state_finalize(void)
>  {
> -    free(dirtylimit_state->states);
> +    g_free(dirtylimit_state->states);
>      dirtylimit_state->states =3D NULL;
>
> -    free(dirtylimit_state);
> +    g_free(dirtylimit_state);
>      dirtylimit_state =3D NULL;
>
> Likewise...

>      trace_dirtylimit_state_finalize();
> @@ -653,7 +653,8 @@ struct DirtyLimitInfoList
> *qmp_query_vcpu_dirty_limit(Error **errp)
>
>  void hmp_info_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
>  {
> -    DirtyLimitInfoList *limit, *head, *info =3D NULL;
> +    DirtyLimitInfoList *info;
> +    g_autoptr(DirtyLimitInfoList) head =3D NULL;
>      Error *err =3D NULL;
>
>      if (!dirtylimit_in_service()) {
> @@ -661,20 +662,17 @@ void hmp_info_vcpu_dirty_limit(Monitor *mon, const
> QDict *qdict)
>          return;
>      }
>
> -    info =3D qmp_query_vcpu_dirty_limit(&err);
> +    head =3D qmp_query_vcpu_dirty_limit(&err);
>      if (err) {
>          hmp_handle_error(mon, err);
>          return;
>      }
>
> -    head =3D info;
> -    for (limit =3D head; limit !=3D NULL; limit =3D limit->next) {
> +    for (info =3D head; info !=3D NULL; info =3D info->next) {
>          monitor_printf(mon, "vcpu[%"PRIi64"], limit rate %"PRIi64 "
> (MB/s),"
>                              " current rate %"PRIi64 " (MB/s)\n",
> -                            limit->value->cpu_index,
> -                            limit->value->limit_rate,
> -                            limit->value->current_rate);
> +                            info->value->cpu_index,
> +                            info->value->limit_rate,
> +                            info->value->current_rate);
>      }
> -
> -    g_free(info);
>
Fix memory leak.

>  }
> --
> 2.39.3
>
> I'll choose the memory leak modifications to keep the patch focused on a
single
independent issue.

Anyway,

Reviewed-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>

--=20
Best regards

--000000000000d7a9290603a059d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 23, 20=
23 at 3:48=E2=80=AFPM &lt;<a href=3D"mailto:alloc.young@outlook.com" target=
=3D"_blank">alloc.young@outlook.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;=
border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex=
">From: &quot;alloc.young&quot; &lt;<a href=3D"mailto:alloc.young@outlook.c=
om" target=3D"_blank">alloc.young@outlook.com</a>&gt;<br>
<br>
Fix memory leak in hmp_info_vcpu_dirty_limit,use g_autoptr<br>
handle memory deallocation, alse use g_free to match g_malloc<br>
&amp;&amp; g_new functions.<br>
<br>
Signed-off-by: alloc.young &lt;<a href=3D"mailto:alloc.young@outlook.com" t=
arget=3D"_blank">alloc.young@outlook.com</a>&gt;<br>
---<br>
=C2=A0softmmu/dirtylimit.c | 26 ++++++++++++--------------<br>
=C2=A01 file changed, 12 insertions(+), 14 deletions(-)<br>
<br></blockquote><div class=3D"gmail_default" style=3D"font-family:&quot;co=
mic sans ms&quot;,sans-serif">[...]</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:s=
olid;border-left-color:rgb(204,204,204);padding-left:1ex">
diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c<br>
index 3c275ee55b..fa959d7743 100644<br>
--- a/softmmu/dirtylimit.c<br>
+++ b/softmmu/dirtylimit.c<br>
@@ -100,7 +100,7 @@ static void vcpu_dirty_rate_stat_collect(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stat.rates[i].dirty_rate;<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 free(stat.rates);<br>
+=C2=A0 =C2=A0 g_free(stat.rates);<br>
=C2=A0}<br>
<br></blockquote><div class=3D"gmail_default" style=3D"font-family:&quot;co=
mic sans ms&quot;,sans-serif">Code optimization.</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border=
-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
=C2=A0static void *vcpu_dirty_rate_stat_thread(void *opaque)<br>
@@ -171,10 +171,10 @@ void vcpu_dirty_rate_stat_initialize(void)<br>
<br>
=C2=A0void vcpu_dirty_rate_stat_finalize(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 free(vcpu_dirty_rate_stat-&gt;stat.rates);<br>
+=C2=A0 =C2=A0 g_free(vcpu_dirty_rate_stat-&gt;stat.rates);<br>
=C2=A0 =C2=A0 =C2=A0vcpu_dirty_rate_stat-&gt;stat.rates =3D NULL;<br>
<br>
-=C2=A0 =C2=A0 free(vcpu_dirty_rate_stat);<br>
+=C2=A0 =C2=A0 g_free(vcpu_dirty_rate_stat);<br>
=C2=A0 =C2=A0 =C2=A0vcpu_dirty_rate_stat =3D NULL;<br>
=C2=A0}<br>
<br></blockquote><div class=3D"gmail_default" style=3D"font-family:&quot;co=
mic sans ms&quot;,sans-serif">Likewise...</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-s=
tyle:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
@@ -220,10 +220,10 @@ void dirtylimit_state_initialize(void)<br>
<br>
=C2=A0void dirtylimit_state_finalize(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 free(dirtylimit_state-&gt;states);<br>
+=C2=A0 =C2=A0 g_free(dirtylimit_state-&gt;states);<br>
=C2=A0 =C2=A0 =C2=A0dirtylimit_state-&gt;states =3D NULL;<br>
<br>
-=C2=A0 =C2=A0 free(dirtylimit_state);<br>
+=C2=A0 =C2=A0 g_free(dirtylimit_state);<br>
=C2=A0 =C2=A0 =C2=A0dirtylimit_state =3D NULL;<br>
<br></blockquote><div><span style=3D"font-family:&quot;comic sans ms&quot;,=
sans-serif">Likewise...</span>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:=
solid;border-left-color:rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0trace_dirtylimit_state_finalize();<br>
@@ -653,7 +653,8 @@ struct DirtyLimitInfoList *qmp_query_vcpu_dirty_limit(E=
rror **errp)<br>
<br>
=C2=A0void hmp_info_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 DirtyLimitInfoList *limit, *head, *info =3D NULL;<br>
+=C2=A0 =C2=A0 DirtyLimitInfoList *info;<br>
+=C2=A0 =C2=A0 g_autoptr(DirtyLimitInfoList) head =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0Error *err =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!dirtylimit_in_service()) {<br>
@@ -661,20 +662,17 @@ void hmp_info_vcpu_dirty_limit(Monitor *mon, const QD=
ict *qdict)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 info =3D qmp_query_vcpu_dirty_limit(&amp;err);<br>
+=C2=A0 =C2=A0 head =3D qmp_query_vcpu_dirty_limit(&amp;err);<br>
=C2=A0 =C2=A0 =C2=A0if (err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hmp_handle_error(mon, err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 head =3D info;<br>
-=C2=A0 =C2=A0 for (limit =3D head; limit !=3D NULL; limit =3D limit-&gt;ne=
xt) {<br>
+=C2=A0 =C2=A0 for (info =3D head; info !=3D NULL; info =3D info-&gt;next) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_printf(mon, &quot;vcpu[%&quot;PRI=
i64&quot;], limit rate %&quot;PRIi64 &quot; (MB/s),&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; current rate %&quot;PRIi64 &quot; (MB=
/s)\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 limit-&gt;value-&gt;cpu_index,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 limit-&gt;value-&gt;limit_rate,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 limit-&gt;value-&gt;current_rate);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;value-&gt;cpu_index,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;value-&gt;limit_rate,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;value-&gt;current_rate);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 g_free(info);<br></blockquote><div class=3D"gmail_default" s=
tyle=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Fix memory leak.<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,2=
04);padding-left:1ex">
=C2=A0}<br>
-- <br>
2.39.3<br>
<br>
</blockquote></div><div class=3D"gmail_default" style=3D"font-family:&quot;=
comic sans ms&quot;,sans-serif">I&#39;ll choose the memory leak modificatio=
ns to keep the patch focused on a single</div><div class=3D"gmail_default" =
style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">independent issu=
e.</div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans =
ms&quot;,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-f=
amily:&quot;comic sans ms&quot;,sans-serif">Anyway,<br></div><div class=3D"=
gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><=
br></div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans=
 ms&quot;,sans-serif">Reviewed-by:=C2=A0Hyman Huang(=E9=BB=84=E5=8B=87) &lt=
;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@smar=
tx.com</a>&gt;<br></div><div><br></div><span class=3D"gmail_signature_prefi=
x">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr=
"><font face=3D"comic sans ms, sans-serif">Best regards</font></div></div><=
/div>

--000000000000d7a9290603a059d7--

