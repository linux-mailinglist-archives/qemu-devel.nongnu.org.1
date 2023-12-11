Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C752E80CB58
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:49:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCgeH-000705-W2; Mon, 11 Dec 2023 08:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rCgeG-0006zi-4p
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:48:40 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rCgeD-0004gw-Fy
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:48:39 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50c05ea5805so5251694e87.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 05:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702302515; x=1702907315;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LBCQfnKnjC6EqlviWMzxlIwCxlHWG4+0kLFXJpnDENw=;
 b=u6VZ68wG5vO2WM3Gr+NtF4IVnbxigRCGuLWYjew8CDV5d8TuxF8/gZCKcnSo/o8iWf
 ln9G8mcSltDL6xxDI0YEHuFJSP0UocRi4HP+OlrmkYVrnGtPbVFp8jEFuveiYaSfql6m
 efI9IniWrutEwxmqRTMwvUlL6wxkyIowSI/rRr/EG080zjehSlFsfZuE4BPhpwkuMjrF
 Ez51TN5QNCrIBfowRO0UhoMVxaJf/QDbEOycAeCoNwoSyjNscMm3vMuKkDo/EGnjGBbK
 bYwD5UAndAqORgENL0Ar7qJ/ScuSJ3Lngl32lgyAPJ64tu8nQNIxU63YPM4ZsgCIPV3N
 CzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702302515; x=1702907315;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LBCQfnKnjC6EqlviWMzxlIwCxlHWG4+0kLFXJpnDENw=;
 b=WPfKOITMB8wcFHlsl2DrOOiIH13MlmO1Ihjl12Vjnklnu/gz8WXQvzPCN8fLW+3d9c
 KPBeU4Z/5XVsIMIL8lxgAknpRkGeBv/ECGB/TkhnXg6y21UuwND/SsWC1PihyjuKd780
 ZXSYaO5zoZcUUvaBjBRF8vq6jqrx7bulj/mBcPR8DL2b6UkGg17EftQPR4kC21Xg0ZGY
 XulG08PN1Lp2WkwiuaGuwqRsPz7TDQ8Rv7MQI7fYQo+kSH9NgQvJ9aMmhJG0XoZlhgaS
 QBxq56o4Jil00OpsxFWSeleIjycVaH6Cs233Zyaj/z7wUhglbjXX1T2wIaV1AuuqMWry
 nAxg==
X-Gm-Message-State: AOJu0YxyNAj26SjCxYkx6/8WRZu6w6/8NarYosZC+C59gkOJboynThjp
 ccfds4mOt5fdWazSv8ISOtFwqqhrlRstoxrluraBRw==
X-Google-Smtp-Source: AGHT+IGvl7Oag6m2cFpg1oGmUBPB4us/U3cVkJxERTzTNB3zJSQq4ryL7oIEPNH9rTzub8aC+35B992H9ABM3wxWv8Q=
X-Received: by 2002:a05:6512:290:b0:50d:162d:c571 with SMTP id
 j16-20020a056512029000b0050d162dc571mr1949043lfp.69.1702302515590; Mon, 11
 Dec 2023 05:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20230831065140.496485-1-andrew@daynix.com>
 <20230831065140.496485-2-andrew@daynix.com>
 <46697e3b-3ec4-4635-97d5-39919068d709@gmail.com>
In-Reply-To: <46697e3b-3ec4-4635-97d5-39919068d709@gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 11 Dec 2023 15:48:23 +0200
Message-ID: <CAOEp5Od+_KHm86L7PLVo22KqLZuBc4dWjh0=4iAvT_zyhSRLMw@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] ebpf: Added eBPF map update through mmap.
To: Akihiko Odaki <akihiko.odaki@gmail.com>
Cc: Andrew Melnychenko <andrew@daynix.com>, jasowang@redhat.com, mst@redhat.com,
 armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, 
 berrange@redhat.com, yan@daynix.com
Content-Type: multipart/alternative; boundary="000000000000be0c68060c3c3013"
Received-SPF: none client-ip=2a00:1450:4864:20::12a;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lf1-x12a.google.com
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

--000000000000be0c68060c3c3013
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Akihiko,
This series was already discussed several months ago.
I'd suggest to postpone commenting on it and resume them after merging.

Thanks for understanding.
Yuri

On Mon, Dec 11, 2023 at 3:05=E2=80=AFPM Akihiko Odaki <akihiko.odaki@gmail.=
com>
wrote:

> On 2023/08/31 15:51, Andrew Melnychenko wrote:
> > Changed eBPF map updates through mmaped array.
> > Mmaped arrays provide direct access to map data.
> > It should omit using bpf_map_update_elem() call,
> > which may require capabilities that are not present.
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >   ebpf/ebpf_rss.c | 117 ++++++++++++++++++++++++++++++++++++++---------=
-
> >   ebpf/ebpf_rss.h |   5 +++
> >   2 files changed, 99 insertions(+), 23 deletions(-)
> >
> > diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
> > index cee658c158..247f5eee1b 100644
> > --- a/ebpf/ebpf_rss.c
> > +++ b/ebpf/ebpf_rss.c
> > @@ -27,19 +27,83 @@ void ebpf_rss_init(struct EBPFRSSContext *ctx)
> >   {
> >       if (ctx !=3D NULL) {
> >           ctx->obj =3D NULL;
> > +        ctx->program_fd =3D -1;
> > +        ctx->map_configuration =3D -1;
> > +        ctx->map_toeplitz_key =3D -1;
> > +        ctx->map_indirections_table =3D -1;
> > +
> > +        ctx->mmap_configuration =3D NULL;
> > +        ctx->mmap_toeplitz_key =3D NULL;
> > +        ctx->mmap_indirections_table =3D NULL;
> >       }
> >   }
> >
> >   bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
> >   {
> > -    return ctx !=3D NULL && ctx->obj !=3D NULL;
> > +    return ctx !=3D NULL && (ctx->obj !=3D NULL || ctx->program_fd !=
=3D -1);
> > +}
> > +
> > +static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
> > +{
> > +    if (!ebpf_rss_is_loaded(ctx)) {
> > +        return false;
> > +    }
> > +
> > +    ctx->mmap_configuration =3D mmap(NULL, qemu_real_host_page_size(),
> > +                                   PROT_READ | PROT_WRITE, MAP_SHARED,
> > +                                   ctx->map_configuration, 0);
> > +    if (ctx->mmap_configuration =3D=3D MAP_FAILED) {
> > +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF configuration
> array");
> > +        return false;
> > +    }
> > +    ctx->mmap_toeplitz_key =3D mmap(NULL, qemu_real_host_page_size(),
> > +                                   PROT_READ | PROT_WRITE, MAP_SHARED,
> > +                                   ctx->map_toeplitz_key, 0);
> > +    if (ctx->mmap_toeplitz_key =3D=3D MAP_FAILED) {
> > +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF toeplitz key")=
;
> > +        goto toeplitz_fail;
> > +    }
> > +    ctx->mmap_indirections_table =3D mmap(NULL,
> qemu_real_host_page_size(),
> > +                                   PROT_READ | PROT_WRITE, MAP_SHARED,
> > +                                   ctx->map_indirections_table, 0);
> > +    if (ctx->mmap_indirections_table =3D=3D MAP_FAILED) {
> > +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF indirection
> table");
> > +        goto indirection_fail;
> > +    }
> > +
> > +    return true;
> > +
> > +indirection_fail:
> > +    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
> > +toeplitz_fail:
> > +    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
> > +
> > +    ctx->mmap_configuration =3D NULL;
> > +    ctx->mmap_toeplitz_key =3D NULL;
> > +    ctx->mmap_indirections_table =3D NULL;
>
> What about:
>
>  > +indirection_fail:
>  > +    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
>  > +    ctx->mmap_toeplitz_key =3D NULL;
>  > +toeplitz_fail:
>  > +    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
>  > +    ctx->mmap_configuration =3D NULL;
>
> It will be clearer when the pointer becomes invalid this way.
>
> > +    return false;
> > +}
> > +
> > +static void ebpf_rss_munmap(struct EBPFRSSContext *ctx)
> > +{
> > +    if (!ebpf_rss_is_loaded(ctx)) {
> > +        return;
> > +    }
> > +
> > +    munmap(ctx->mmap_indirections_table, qemu_real_host_page_size());
> > +    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
> > +    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
> > +
> > +    ctx->mmap_configuration =3D NULL;
> > +    ctx->mmap_toeplitz_key =3D NULL;
> > +    ctx->mmap_indirections_table =3D NULL;
> >   }
> >
> >   bool ebpf_rss_load(struct EBPFRSSContext *ctx)
> >   {
> >       struct rss_bpf *rss_bpf_ctx;
> >
> > -    if (ctx =3D=3D NULL) {
> > +    if (ctx =3D=3D NULL || ebpf_rss_is_loaded(ctx)) {
> >           return false;
> >       }
>
> You can omit ctx =3D=3D NULL just as you do for ebpf_rss_munmap().
>
> >
> > @@ -66,10 +130,18 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
> >       ctx->map_toeplitz_key =3D bpf_map__fd(
> >               rss_bpf_ctx->maps.tap_rss_map_toeplitz_key);
> >
> > +    if (!ebpf_rss_mmap(ctx)) {
> > +        goto error;
> > +    }
> > +
> >       return true;
> >   error:
> >       rss_bpf__destroy(rss_bpf_ctx);
> >       ctx->obj =3D NULL;
> > +    ctx->program_fd =3D -1;
> > +    ctx->map_configuration =3D -1;
> > +    ctx->map_toeplitz_key =3D -1;
> > +    ctx->map_indirections_table =3D -1;
> >
> >       return false;
> >   }
> > @@ -77,15 +149,11 @@ error:
> >   static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
> >                                   struct EBPFRSSConfig *config)
> >   {
> > -    uint32_t map_key =3D 0;
> > -
> >       if (!ebpf_rss_is_loaded(ctx)) {
> >           return false;
> >       }
> > -    if (bpf_map_update_elem(ctx->map_configuration,
> > -                            &map_key, config, 0) < 0) {
> > -        return false;
> > -    }
> > +
> > +    memcpy(ctx->mmap_configuration, config, sizeof(*config));
> >       return true;
> >   }
> >
> > @@ -93,27 +161,19 @@ static bool ebpf_rss_set_indirections_table(struct
> EBPFRSSContext *ctx,
> >                                               uint16_t
> *indirections_table,
> >                                               size_t len)
> >   {
> > -    uint32_t i =3D 0;
> > -
> >       if (!ebpf_rss_is_loaded(ctx) || indirections_table =3D=3D NULL ||
> >          len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
> >           return false;
> >       }
> >
> > -    for (; i < len; ++i) {
> > -        if (bpf_map_update_elem(ctx->map_indirections_table, &i,
> > -                                indirections_table + i, 0) < 0) {
> > -            return false;
> > -        }
> > -    }
> > +    memcpy(ctx->mmap_indirections_table, indirections_table,
> > +            sizeof(*indirections_table) * len);
>
> This line is not aligned with the parenthesis on the previous line.
>

--000000000000be0c68060c3c3013
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Akihiko,<div>This series was already discussed several mon=
ths ago.</div><div>I&#39;d suggest to postpone commenting on it and resume =
them after merging.</div><div><br></div><div>Thanks for understanding.</div=
><div>Yuri</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon, Dec 11, 2023 at 3:05=E2=80=AFPM Akihiko Odaki &lt;<=
a href=3D"mailto:akihiko.odaki@gmail.com">akihiko.odaki@gmail.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 2023/08=
/31 15:51, Andrew Melnychenko wrote:<br>
&gt; Changed eBPF map updates through mmaped array.<br>
&gt; Mmaped arrays provide direct access to map data.<br>
&gt; It should omit using bpf_map_update_elem() call,<br>
&gt; which may require capabilities that are not present.<br>
&gt; <br>
&gt; Signed-off-by: Andrew Melnychenko &lt;<a href=3D"mailto:andrew@daynix.=
com" target=3D"_blank">andrew@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0ebpf/ebpf_rss.c | 117 ++++++++++++++++++++++++++++++++++++=
++----------<br>
&gt;=C2=A0 =C2=A0ebpf/ebpf_rss.h |=C2=A0 =C2=A05 +++<br>
&gt;=C2=A0 =C2=A02 files changed, 99 insertions(+), 23 deletions(-)<br>
&gt; <br>
&gt; diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c<br>
&gt; index cee658c158..247f5eee1b 100644<br>
&gt; --- a/ebpf/ebpf_rss.c<br>
&gt; +++ b/ebpf/ebpf_rss.c<br>
&gt; @@ -27,19 +27,83 @@ void ebpf_rss_init(struct EBPFRSSContext *ctx)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ctx !=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;obj =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;program_fd =3D -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;map_configuration =3D -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;map_toeplitz_key =3D -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;map_indirections_table =3D -1;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;mmap_configuration =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;mmap_toeplitz_key =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;mmap_indirections_table =3D NULL;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 return ctx !=3D NULL &amp;&amp; ctx-&gt;obj !=3D NULL;<=
br>
&gt; +=C2=A0 =C2=A0 return ctx !=3D NULL &amp;&amp; (ctx-&gt;obj !=3D NULL =
|| ctx-&gt;program_fd !=3D -1);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (!ebpf_rss_is_loaded(ctx)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ctx-&gt;mmap_configuration =3D mmap(NULL, qemu_real_hos=
t_page_size(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PROT_READ | PROT_WR=
ITE, MAP_SHARED,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;map_configu=
ration, 0);<br>
&gt; +=C2=A0 =C2=A0 if (ctx-&gt;mmap_configuration =3D=3D MAP_FAILED) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_ebpf_error(&quot;eBPF RSS&quot;, &q=
uot;can not mmap eBPF configuration array&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 ctx-&gt;mmap_toeplitz_key =3D mmap(NULL, qemu_real_host=
_page_size(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PROT_READ | PROT_WR=
ITE, MAP_SHARED,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;map_toeplit=
z_key, 0);<br>
&gt; +=C2=A0 =C2=A0 if (ctx-&gt;mmap_toeplitz_key =3D=3D MAP_FAILED) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_ebpf_error(&quot;eBPF RSS&quot;, &q=
uot;can not mmap eBPF toeplitz key&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto toeplitz_fail;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 ctx-&gt;mmap_indirections_table =3D mmap(NULL, qemu_rea=
l_host_page_size(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PROT_READ | PROT_WR=
ITE, MAP_SHARED,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;map_indirec=
tions_table, 0);<br>
&gt; +=C2=A0 =C2=A0 if (ctx-&gt;mmap_indirections_table =3D=3D MAP_FAILED) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_ebpf_error(&quot;eBPF RSS&quot;, &q=
uot;can not mmap eBPF indirection table&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto indirection_fail;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +<br>
&gt; +indirection_fail:<br>
&gt; +=C2=A0 =C2=A0 munmap(ctx-&gt;mmap_toeplitz_key, qemu_real_host_page_s=
ize());<br>
&gt; +toeplitz_fail:<br>
&gt; +=C2=A0 =C2=A0 munmap(ctx-&gt;mmap_configuration, qemu_real_host_page_=
size());<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ctx-&gt;mmap_configuration =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 ctx-&gt;mmap_toeplitz_key =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 ctx-&gt;mmap_indirections_table =3D NULL;<br>
<br>
What about:<br>
<br>
=C2=A0&gt; +indirection_fail:<br>
=C2=A0&gt; +=C2=A0 =C2=A0 munmap(ctx-&gt;mmap_toeplitz_key, qemu_real_host_=
page_size());<br>
=C2=A0&gt; +=C2=A0 =C2=A0 ctx-&gt;mmap_toeplitz_key =3D NULL;<br>
=C2=A0&gt; +toeplitz_fail:<br>
=C2=A0&gt; +=C2=A0 =C2=A0 munmap(ctx-&gt;mmap_configuration, qemu_real_host=
_page_size());<br>
=C2=A0&gt; +=C2=A0 =C2=A0 ctx-&gt;mmap_configuration =3D NULL;<br>
<br>
It will be clearer when the pointer becomes invalid this way.<br>
<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void ebpf_rss_munmap(struct EBPFRSSContext *ctx)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (!ebpf_rss_is_loaded(ctx)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 munmap(ctx-&gt;mmap_indirections_table, qemu_real_host_=
page_size());<br>
&gt; +=C2=A0 =C2=A0 munmap(ctx-&gt;mmap_toeplitz_key, qemu_real_host_page_s=
ize());<br>
&gt; +=C2=A0 =C2=A0 munmap(ctx-&gt;mmap_configuration, qemu_real_host_page_=
size());<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ctx-&gt;mmap_configuration =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 ctx-&gt;mmap_toeplitz_key =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 ctx-&gt;mmap_indirections_table =3D NULL;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0bool ebpf_rss_load(struct EBPFRSSContext *ctx)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rss_bpf *rss_bpf_ctx;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 if (ctx =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 if (ctx =3D=3D NULL || ebpf_rss_is_loaded(ctx)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
You can omit ctx =3D=3D NULL just as you do for ebpf_rss_munmap().<br>
<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -66,10 +130,18 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;map_toeplitz_key =3D bpf_map__fd(<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rss_bpf_ctx-&gt;=
maps.tap_rss_map_toeplitz_key);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 if (!ebpf_rss_mmap(ctx)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
&gt;=C2=A0 =C2=A0error:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rss_bpf__destroy(rss_bpf_ctx);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;obj =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 ctx-&gt;program_fd =3D -1;<br>
&gt; +=C2=A0 =C2=A0 ctx-&gt;map_configuration =3D -1;<br>
&gt; +=C2=A0 =C2=A0 ctx-&gt;map_toeplitz_key =3D -1;<br>
&gt; +=C2=A0 =C2=A0 ctx-&gt;map_indirections_table =3D -1;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; @@ -77,15 +149,11 @@ error:<br>
&gt;=C2=A0 =C2=A0static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct EBPFRSSConfig=
 *config)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 uint32_t map_key =3D 0;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ebpf_rss_is_loaded(ctx)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 if (bpf_map_update_elem(ctx-&gt;map_configuration,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;map_key, config, 0) &lt; 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memcpy(ctx-&gt;mmap_configuration, config, sizeof(*conf=
ig));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -93,27 +161,19 @@ static bool ebpf_rss_set_indirections_table(struc=
t EBPFRSSContext *ctx,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint16_t *indirections_table,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0size_t len)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 uint32_t i =3D 0;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ebpf_rss_is_loaded(ctx) || indirections=
_table =3D=3D NULL ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len &gt; VIRTIO_NET_RSS_MAX_TABLE_LE=
N) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 for (; i &lt; len; ++i) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bpf_map_update_elem(ctx-&gt;map_indir=
ections_table, &amp;i,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indirections_table + i, 0) &lt; =
0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 memcpy(ctx-&gt;mmap_indirections_table, indirections_ta=
ble,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(*indirections_table)=
 * len);<br>
<br>
This line is not aligned with the parenthesis on the previous line.<br>
</blockquote></div>

--000000000000be0c68060c3c3013--

