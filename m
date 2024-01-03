Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3477822692
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 02:34:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKq8K-0002e3-Mz; Tue, 02 Jan 2024 20:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rKq8E-0002b7-5h
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 20:33:19 -0500
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rKq87-0007Da-Ob
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 20:33:16 -0500
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-35fe9a6609eso74759455ab.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 17:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1704245468; x=1704850268;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ywxW50Jy/Sin0WRO6XGAbIkrX/VVttxz/rhGzy/Cg/k=;
 b=YXMd8D7mwr6YSzmhOOzvghw/sziJLKTCsSyQGpmMmB4Z8SipnJoKWmW+BnMPrG6Jlo
 Vy06iKRUTRbN2Mrk+fYkCieyrxw8e8iAJG1bnkjGQ0lRJXrFoVpSYBBFc/Qico9Ua73U
 MDIkNXS+dP6I7VXbPKvjxyAZYzUp1reLzxPU4OQkhugtLlSKWWXvcKwqfNr9SGFYw6Yn
 +ipfyxtsBQ5ZORAsSeAJIV0N2G1wDpq8KAAbW0hzEB3gg/juFyU0OhvJmDzNmKp0Gfo4
 sbs06qJyoesu5WUvwXt3Pl0hYhV8I86kt5x71iAPxHLB3R8OsfFUtI3vLh72MFgJwTdV
 DkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704245468; x=1704850268;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ywxW50Jy/Sin0WRO6XGAbIkrX/VVttxz/rhGzy/Cg/k=;
 b=lYj8OYV6aTgrOansQibz5seAe+IszL/1PjwhDaAFDEGzy/lag8le2BoPsHDU4svJ2W
 dORXLC/AgVyjmIU+pqoXqCpifSPQdsuj1hns1CaJnV+zOV89mIvg9GPussvH0QcWzmpR
 UsbZ00UUDYzmyjpPRnj67Us+wUhxx/fSIrHr4F55g27zJhLtq2mSnIU0DNb52ZQhWhOc
 EDfiPHUmSv8vsJn12GufEmNvR3QQks7ga9cbKsQ4eyGUr6EHoN4cIeL13FTnte6ZQpe0
 TPGhfdd3TZkbHfIpDrSZhq6Jrdf5WJZ0L+DjFVn/FeumQwllATX40gcxlatMXmgmZYFJ
 cRTA==
X-Gm-Message-State: AOJu0YzdVvv+QtghCjdVw5E1cxVmZ65zBfEQ1HJ/uG7o9fAf/DRln7TO
 MQvMw6gKo9q0pJ9mrAANFOo3WxzoCBtlpKsjZmQvPR1tcMAS4w==
X-Google-Smtp-Source: AGHT+IEO6PN1X+U2EYepasNqR6B1KB2zcCdR4yOlo4fh9aZ/HcHhlINs2ZokLztIVZHYXjP5TjC9djiK2ntbdYCBrdI=
X-Received: by 2002:a05:6e02:17c5:b0:35f:e253:887a with SMTP id
 z5-20020a056e0217c500b0035fe253887amr26256159ilu.59.1704245467180; Tue, 02
 Jan 2024 17:31:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1703787712.git.yong.huang@smartx.com>
 <138716dee4162ad959ac3580da0d4681fabd6185.1703787712.git.yong.huang@smartx.com>
 <2f7919b1-eb19-4998-9fd6-c89351255e34@linaro.org>
In-Reply-To: <2f7919b1-eb19-4998-9fd6-c89351255e34@linaro.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 3 Jan 2024 09:30:51 +0800
Message-ID: <CAK9dgmYj2EyUiNzYByv7zVx9FC+ErOgzF8bzpET+BnFcgKH-fw@mail.gmail.com>
Subject: Re: [PATCH 1/2] qapi/virtio: Keep feature and status bits in the QMP
 output
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ae8c55060e0091e4"
Received-SPF: none client-ip=2607:f8b0:4864:20::129;
 envelope-from=yong.huang@smartx.com; helo=mail-il1-x129.google.com
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

--000000000000ae8c55060e0091e4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, I'll fix that in the next version.

On Fri, Dec 29, 2023 at 5:31=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi,
>
> On 28/12/23 19:52, Hyman Huang wrote:
> > Maintain the feature and status bits in the x-query-virtio-status
> > output and, as usual, add human-readable output only in HMP.
> >
> > Applications may find it useful to compare features and status
> > information directly. An upper application, for example, could
> > use the QMP command x-query-virtio-status to retrieve vhost-user
> > net device features and the "ovs-vsctl list interface" command to
> > retrieve interface features (in number format) in order to verify
> > the correctness of the virtio negotiation between guest, QEMU,
> > and OVS-DPDK. The application could then compare the two features
> > directly, without the need for additional feature encoding.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >   hw/virtio/virtio-hmp-cmds.c |  25 +++--
> >   hw/virtio/virtio-qmp.c      |  23 ++---
> >   qapi/virtio.json            | 192 ++++-------------------------------=
-
> >   3 files changed, 45 insertions(+), 195 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
> > index 477c97dea2..721c630ab0 100644
> > --- a/hw/virtio/virtio-hmp-cmds.c
> > +++ b/hw/virtio/virtio-hmp-cmds.c
> > @@ -6,6 +6,7 @@
> >    */
> >
> >   #include "qemu/osdep.h"
> > +#include "virtio-qmp.h"
> >   #include "monitor/hmp.h"
> >   #include "monitor/monitor.h"
> >   #include "qapi/qapi-commands-virtio.h"
> > @@ -145,13 +146,17 @@ void hmp_virtio_status(Monitor *mon, const QDict
> *qdict)
> >       monitor_printf(mon, "  endianness:              %s\n",
> >                      s->device_endian);
> >       monitor_printf(mon, "  status:\n");
> > -    hmp_virtio_dump_status(mon, s->status);
> > +    hmp_virtio_dump_status(mon,
> > +        qmp_decode_status(s->status));
>
> Why not let the callee do this call?
>
> >       monitor_printf(mon, "  Guest features:\n");
> > -    hmp_virtio_dump_features(mon, s->guest_features);
> > +    hmp_virtio_dump_features(mon,
> > +        qmp_decode_features(s->device_id, s->guest_features));
> >       monitor_printf(mon, "  Host features:\n");
> > -    hmp_virtio_dump_features(mon, s->host_features);
> > +    hmp_virtio_dump_features(mon,
> > +        qmp_decode_features(s->device_id, s->host_features));
> >       monitor_printf(mon, "  Backend features:\n");
> > -    hmp_virtio_dump_features(mon, s->backend_features);
> > +    hmp_virtio_dump_features(mon,
> > +        qmp_decode_features(s->device_id, s->backend_features));
> >
> >       if (s->vhost_dev) {
> >           monitor_printf(mon, "  VHost:\n");
> > @@ -172,13 +177,17 @@ void hmp_virtio_status(Monitor *mon, const QDict
> *qdict)
> >           monitor_printf(mon, "    log_size:       %"PRId64"\n",
> >                          s->vhost_dev->log_size);
> >           monitor_printf(mon, "    Features:\n");
> > -        hmp_virtio_dump_features(mon, s->vhost_dev->features);
> > +        hmp_virtio_dump_features(mon,
> > +            qmp_decode_features(s->device_id, s->vhost_dev->features))=
;
>
> Ditto.
>
> >           monitor_printf(mon, "    Acked features:\n");
> > -        hmp_virtio_dump_features(mon, s->vhost_dev->acked_features);
> > +        hmp_virtio_dump_features(mon,
> > +            qmp_decode_features(s->device_id,
> s->vhost_dev->acked_features));
> >           monitor_printf(mon, "    Backend features:\n");
> > -        hmp_virtio_dump_features(mon, s->vhost_dev->backend_features);
> > +        hmp_virtio_dump_features(mon,
> > +            qmp_decode_features(s->device_id,
> s->vhost_dev->backend_features));
> >           monitor_printf(mon, "    Protocol features:\n");
> > -        hmp_virtio_dump_protocols(mon, s->vhost_dev->protocol_features=
);
> > +        hmp_virtio_dump_protocols(mon,
> > +            qmp_decode_protocols(s->vhost_dev->protocol_features));
> >       }
>
>

--=20
Best regards

--000000000000ae8c55060e0091e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:comic sa=
ns ms,sans-serif">Thanks, I&#39;ll fix that in the next version.<br></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Fri, Dec 29, 2023 at 5:31=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);p=
adding-left:1ex">Hi,<br>
<br>
On 28/12/23 19:52, Hyman Huang wrote:<br>
&gt; Maintain the feature and status bits in the x-query-virtio-status<br>
&gt; output and, as usual, add human-readable output only in HMP.<br>
&gt; <br>
&gt; Applications may find it useful to compare features and status<br>
&gt; information directly. An upper application, for example, could<br>
&gt; use the QMP command x-query-virtio-status to retrieve vhost-user<br>
&gt; net device features and the &quot;ovs-vsctl list interface&quot; comma=
nd to<br>
&gt; retrieve interface features (in number format) in order to verify<br>
&gt; the correctness of the virtio negotiation between guest, QEMU,<br>
&gt; and OVS-DPDK. The application could then compare the two features<br>
&gt; directly, without the need for additional feature encoding.<br>
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/virtio/virtio-hmp-cmds.c |=C2=A0 25 +++--<br>
&gt;=C2=A0 =C2=A0hw/virtio/virtio-qmp.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 23 ++--=
-<br>
&gt;=C2=A0 =C2=A0qapi/virtio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| 192 ++++--------------------------------<br>
&gt;=C2=A0 =C2=A03 files changed, 45 insertions(+), 195 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c=
<br>
&gt; index 477c97dea2..721c630ab0 100644<br>
&gt; --- a/hw/virtio/virtio-hmp-cmds.c<br>
&gt; +++ b/hw/virtio/virtio-hmp-cmds.c<br>
&gt; @@ -6,6 +6,7 @@<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;virtio-qmp.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;monitor/hmp.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;monitor/monitor.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qapi/qapi-commands-virtio.h&quot;<br>
&gt; @@ -145,13 +146,17 @@ void hmp_virtio_status(Monitor *mon, const QDict=
 *qdict)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_printf(mon, &quot;=C2=A0 endianness:=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %s\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 s-&gt;device_endian);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_printf(mon, &quot;=C2=A0 status:\n&q=
uot;);<br>
&gt; -=C2=A0 =C2=A0 hmp_virtio_dump_status(mon, s-&gt;status);<br>
&gt; +=C2=A0 =C2=A0 hmp_virtio_dump_status(mon,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_status(s-&gt;status));<br>
<br>
Why not let the callee do this call?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_printf(mon, &quot;=C2=A0 Guest featu=
res:\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;guest_features);<br=
>
&gt; +=C2=A0 =C2=A0 hmp_virtio_dump_features(mon,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(s-&gt;device_id, s-&g=
t;guest_features));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_printf(mon, &quot;=C2=A0 Host featur=
es:\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;host_features);<br>
&gt; +=C2=A0 =C2=A0 hmp_virtio_dump_features(mon,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(s-&gt;device_id, s-&g=
t;host_features));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_printf(mon, &quot;=C2=A0 Backend fea=
tures:\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;backend_features);<=
br>
&gt; +=C2=A0 =C2=A0 hmp_virtio_dump_features(mon,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(s-&gt;device_id, s-&g=
t;backend_features));<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;vhost_dev) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_printf(mon, &quot;=C2=
=A0 VHost:\n&quot;);<br>
&gt; @@ -172,13 +177,17 @@ void hmp_virtio_status(Monitor *mon, const QDict=
 *qdict)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_printf(mon, &quot;=C2=
=A0 =C2=A0 log_size:=C2=A0 =C2=A0 =C2=A0 =C2=A0%&quot;PRId64&quot;\n&quot;,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 s-&gt;vhost_dev-&gt;log_size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_printf(mon, &quot;=C2=
=A0 =C2=A0 Features:\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;vhost=
_dev-&gt;features);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_features(mon,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(s-&gt;d=
evice_id, s-&gt;vhost_dev-&gt;features));<br>
<br>
Ditto.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_printf(mon, &quot;=C2=
=A0 =C2=A0 Acked features:\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;vhost=
_dev-&gt;acked_features);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_features(mon,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(s-&gt;d=
evice_id, s-&gt;vhost_dev-&gt;acked_features));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_printf(mon, &quot;=C2=
=A0 =C2=A0 Backend features:\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_features(mon, s-&gt;vhost=
_dev-&gt;backend_features);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_features(mon,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_features(s-&gt;d=
evice_id, s-&gt;vhost_dev-&gt;backend_features));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_printf(mon, &quot;=C2=
=A0 =C2=A0 Protocol features:\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_protocols(mon, s-&gt;vhos=
t_dev-&gt;protocol_features);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_virtio_dump_protocols(mon,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_decode_protocols(s-&gt;=
vhost_dev-&gt;protocol_features));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div>

--000000000000ae8c55060e0091e4--

