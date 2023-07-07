Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7668374ADD0
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 11:31:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHhnO-0004UZ-IN; Fri, 07 Jul 2023 05:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qHhnM-0004UM-NN; Fri, 07 Jul 2023 05:30:32 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qHhnK-0007de-3g; Fri, 07 Jul 2023 05:30:32 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4009ea1597bso13178991cf.1; 
 Fri, 07 Jul 2023 02:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688722227; x=1691314227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BUfY3MB1xVdojrWWLdh+vtnnRE+UpxTIaHfNaVkrfC4=;
 b=kvMkCT9nOY4L2rmJ9m6vioZA3d3qNpu5puDFTeYFUSuy9tzwx7+8InHDECd3CsE829
 hFej0XAunOUsu+iDd04rlL9j+wG8qTQPmmc/VmrcGSYdEG8beCXa5jZ4OzC2usf2X+zo
 QbijSmhq5J+IhLgOYbFHMmO3FU6419I3ikXGPf+8/HL5p37dp74n+EZj43Nt2X76CSWR
 fjxlGaB6D4XANQY82OJ3cpjWVPYHiGgKCdAxFWtvbC4D5vADTr2bM5hpluDXZz0qXyZr
 wWA0f3aIuM7TDmD5p1w+AlzGMkFhzcfgRY2kzjw83MNrPkLCjjJPkL5xt1g/qe4O47em
 xDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688722227; x=1691314227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BUfY3MB1xVdojrWWLdh+vtnnRE+UpxTIaHfNaVkrfC4=;
 b=WCKUhq43rRfVNmMmed5d7SiSEVVFg+rOJ4NlQtAgryF8Cy8hT5ZS5VMigzM6bRp2Vn
 9Lb1eGRHMaQNWMOV8QB9rBQMKYS2OQY2WD/PxUb+G8f+MMxRJQ710QxQGOwLB2fhI6Yq
 n9OAoOxhsjKwOltpQxuW88Y+d5Wx19i+732rf8d/n4OM+CtIRcyGpFvUeHOsqL3eY52n
 bgkbFMFrgN3f9FJfGBPCOYVsxTIQGAzTiLfR9UQiNCTZa3P6Z2qRjpMhsX6f7x5P0ogX
 E8PVxE8FRjz6Yxcx5fWKLGeiR+U3Qm4d/08X9V7kCMIGCyvjHbiphqapwW6lIgTKVCeK
 omVA==
X-Gm-Message-State: ABy/qLZkiaBw5Gs426IgSrs7OoZUsodyV7Ho93mvJB0d+fz6DwPsjA7s
 uGyN7vHdh9toDUOfFySLz99jNF64hUwQ1Jdm8ro=
X-Google-Smtp-Source: APBJJlH/zb0DDK/kbL0zD5IRrUKSzAt/GlT3Y9e4KLrtNHn38L6chaad3KmrT3NginE+lXbs/Xn5TrK7H+AWlTKQ/QA=
X-Received: by 2002:ac8:5c4c:0:b0:400:8eb6:4bf2 with SMTP id
 j12-20020ac85c4c000000b004008eb64bf2mr5906800qtj.13.1688722227423; Fri, 07
 Jul 2023 02:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230705181718.387522-1-berrange@redhat.com>
In-Reply-To: <20230705181718.387522-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 7 Jul 2023 13:30:16 +0400
Message-ID: <CAJ+F1CJt1PPSVwMAstLRog5PtPvAvA4xuccZgenTDc5SBLTGQQ@mail.gmail.com>
Subject: Re: [PATCH] io: remove io watch if TLS channel is closed during
 handshake
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Mauro Matteo Cascella <mcascell@redhat.com>, jiangyegen <jiangyegen@huawei.com>
Content-Type: multipart/alternative; boundary="0000000000007d71ea05ffe248ef"
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000007d71ea05ffe248ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 5, 2023 at 10:20=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> The TLS handshake make take some time to complete, during which time an
> I/O watch might be registered with the main loop. If the owner of the
> I/O channel invokes qio_channel_close() while the handshake is waiting
> to continue the I/O watch must be removed. Failing to remove it will
> later trigger the completion callback which the owner is not expecting
> to receive. In the case of the VNC server, this results in a SEGV as
> vnc_disconnect_start() tries to shutdown a client connection that is
> already gone / NULL.
>
> CVE-2023-3354
> Reported-by: jiangyegen <jiangyegen@huawei.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>



> ---
>  include/io/channel-tls.h |  1 +
>  io/channel-tls.c         | 18 ++++++++++++------
>  2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
> index 5672479e9e..26c67f17e2 100644
> --- a/include/io/channel-tls.h
> +++ b/include/io/channel-tls.h
> @@ -48,6 +48,7 @@ struct QIOChannelTLS {
>      QIOChannel *master;
>      QCryptoTLSSession *session;
>      QIOChannelShutdown shutdown;
> +    guint hs_ioc_tag;
>  };
>
>  /**
> diff --git a/io/channel-tls.c b/io/channel-tls.c
> index 9805dd0a3f..e327e6a5c2 100644
> --- a/io/channel-tls.c
> +++ b/io/channel-tls.c
> @@ -198,12 +198,13 @@ static void
> qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
>          }
>
>          trace_qio_channel_tls_handshake_pending(ioc, status);
> -        qio_channel_add_watch_full(ioc->master,
> -                                   condition,
> -                                   qio_channel_tls_handshake_io,
> -                                   data,
> -                                   NULL,
> -                                   context);
> +        ioc->hs_ioc_tag =3D
> +            qio_channel_add_watch_full(ioc->master,
> +                                       condition,
> +                                       qio_channel_tls_handshake_io,
> +                                       data,
> +                                       NULL,
> +                                       context);
>      }
>  }
>
> @@ -218,6 +219,7 @@ static gboolean
> qio_channel_tls_handshake_io(QIOChannel *ioc,
>      QIOChannelTLS *tioc =3D QIO_CHANNEL_TLS(
>          qio_task_get_source(task));
>
> +    tioc->hs_ioc_tag =3D 0;
>      g_free(data);
>      qio_channel_tls_handshake_task(tioc, task, context);
>
> @@ -378,6 +380,10 @@ static int qio_channel_tls_close(QIOChannel *ioc,
>  {
>      QIOChannelTLS *tioc =3D QIO_CHANNEL_TLS(ioc);
>
> +    if (tioc->hs_ioc_tag) {
> +        g_source_remove(tioc->hs_ioc_tag);
>

set it to 0 ?
or
g_clear_handle_id(&tios->hs_ioc_tag, g_source_remove);


> +    }
> +
>      return qio_channel_close(tioc->master, errp);
>  }
>
> --
> 2.41.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000007d71ea05ffe248ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 5, 2023 at 10:20=E2=80=AF=
PM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berra=
nge@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">The TLS handshake make take some time to complete, during whi=
ch time an<br>
I/O watch might be registered with the main loop. If the owner of the<br>
I/O channel invokes qio_channel_close() while the handshake is waiting<br>
to continue the I/O watch must be removed. Failing to remove it will<br>
later trigger the completion callback which the owner is not expecting<br>
to receive. In the case of the VNC server, this results in a SEGV as<br>
vnc_disconnect_start() tries to shutdown a client connection that is<br>
already gone / NULL.<br>
<br>
CVE-2023-3354<br>
Reported-by: jiangyegen &lt;<a href=3D"mailto:jiangyegen@huawei.com" target=
=3D"_blank">jiangyegen@huawei.com</a>&gt;<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br></blockquote><div><=
br></div>=C2=A0<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0include/io/channel-tls.h |=C2=A0 1 +<br>
=C2=A0io/channel-tls.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 18 ++++++++++++--=
----<br>
=C2=A02 files changed, 13 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h<br>
index 5672479e9e..26c67f17e2 100644<br>
--- a/include/io/channel-tls.h<br>
+++ b/include/io/channel-tls.h<br>
@@ -48,6 +48,7 @@ struct QIOChannelTLS {<br>
=C2=A0 =C2=A0 =C2=A0QIOChannel *master;<br>
=C2=A0 =C2=A0 =C2=A0QCryptoTLSSession *session;<br>
=C2=A0 =C2=A0 =C2=A0QIOChannelShutdown shutdown;<br>
+=C2=A0 =C2=A0 guint hs_ioc_tag;<br>
=C2=A0};<br>
<br>
=C2=A0/**<br>
diff --git a/io/channel-tls.c b/io/channel-tls.c<br>
index 9805dd0a3f..e327e6a5c2 100644<br>
--- a/io/channel-tls.c<br>
+++ b/io/channel-tls.c<br>
@@ -198,12 +198,13 @@ static void qio_channel_tls_handshake_task(QIOChannel=
TLS *ioc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_qio_channel_tls_handshake_pending(i=
oc, status);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qio_channel_add_watch_full(ioc-&gt;master,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0condition,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qio_channel_tls_handsha=
ke_io,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0context);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ioc-&gt;hs_ioc_tag =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qio_channel_add_watch_full(ioc-&=
gt;master,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0condition=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qio_chann=
el_tls_handshake_io,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0context);=
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -218,6 +219,7 @@ static gboolean qio_channel_tls_handshake_io(QIOChannel=
 *ioc,<br>
=C2=A0 =C2=A0 =C2=A0QIOChannelTLS *tioc =3D QIO_CHANNEL_TLS(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qio_task_get_source(task));<br>
<br>
+=C2=A0 =C2=A0 tioc-&gt;hs_ioc_tag =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0g_free(data);<br>
=C2=A0 =C2=A0 =C2=A0qio_channel_tls_handshake_task(tioc, task, context);<br=
>
<br>
@@ -378,6 +380,10 @@ static int qio_channel_tls_close(QIOChannel *ioc,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0QIOChannelTLS *tioc =3D QIO_CHANNEL_TLS(ioc);<br>
<br>
+=C2=A0 =C2=A0 if (tioc-&gt;hs_ioc_tag) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_source_remove(tioc-&gt;hs_ioc_tag);<br></blo=
ckquote><div><br></div><div>set it to 0 ?</div><div>or<br></div><div>g_clea=
r_handle_id(&amp;tios-&gt;hs_ioc_tag, g_source_remove);</div><div>=C2=A0<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return qio_channel_close(tioc-&gt;master, errp);<br>
=C2=A0}<br>
<br>
-- <br>
2.41.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000007d71ea05ffe248ef--

