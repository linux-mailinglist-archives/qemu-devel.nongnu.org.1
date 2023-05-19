Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24687708FF5
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 08:41:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pztmW-0001yH-A3; Fri, 19 May 2023 02:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1pztmU-0001y0-Ej; Fri, 19 May 2023 02:40:02 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1pztmS-0001J9-Hw; Fri, 19 May 2023 02:40:02 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-966287b0f72so535386366b.0; 
 Thu, 18 May 2023 23:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684478398; x=1687070398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XkHBfqXijCuSOiW+CSML581/q7hUOmAL1bzpkIvLh0o=;
 b=ZumwCGD6d3J15NWxYI+SXQ9Ryt0ndJ6tYBtSLX0ITlJcEd0RWP6fDTP743Elj6tsYB
 oXUOR2r2vUoUq4cUNq+13gIf+pPkzIqX+gKhMvNfDd4eSP5e7yabGBXszpBDXtMjfe24
 vjRDpbRi8y3N+Z2wi0CPy0X5S7pAEuA9jnc1r/8sVo33M1grzNhlI92cEc3lazRqg6RO
 nyipWL2a36DyC/EU+vLs99zBnvVjMP9TwB5hyea3h8hWYm4b7f01iFqB1pvCDcExxHYb
 XdudZtmC9V/u6l/3+o7bd7mwGvNieGs2Tc/DjgDNh972mkU8SCi0OmwIhN/mE1oWZ0/n
 pxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684478398; x=1687070398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XkHBfqXijCuSOiW+CSML581/q7hUOmAL1bzpkIvLh0o=;
 b=BbPCFdRT0SZkpwp4cf8YzAIxiYKJMGLP2DpUQi+ji0/6xUR1s29SeZROXQFI52ZKon
 fp8AeN2cYqnOBKl5qtbunAZ6ujDqPE30x606P7FZeXkuPdYhDsIsEywcgP93NmIlJ73s
 lGCzvLokKCt5wXgocCz66eFAm4OdJnmebZYYWfjrmaF9Qg0ITdm0sbJTVrcqQrSSjX+4
 mFCc2GL3a0swC8KrhZRQG5wobELV3FN5yN6YM5RpQm/MclYOQTxQYcVg0kcf9/43rkIJ
 Wwn0t6YYEQbDMq3ydEpsYiALXYzWa0V7h2XPk7hboxAw41lQZJfJ7rLA2L452h736WbZ
 ITQA==
X-Gm-Message-State: AC+VfDy1XNuL8hdCt10AIuHDYOpMnujSwd7RQ2GBW25ZRBQ4aeVMfwnw
 fI9J9RmpGDJGcZxzaCC28A5fwHgrJFItWKwMHn8TgtNuSUhgTg==
X-Google-Smtp-Source: ACHHUZ7wsk/CAE9Gn3PJQkNDhVoOZDYwy41H9YRvrnkRJzmiY+f6aoIHcS6rEpnE7GYf3GESNd8rFsh1u/VSP0wyE50=
X-Received: by 2002:a17:906:6a0d:b0:96a:928c:d391 with SMTP id
 qw13-20020a1709066a0d00b0096a928cd391mr781295ejc.4.1684478397838; Thu, 18 May
 2023 23:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230519062137.1251741-1-tommy.wu@sifive.com>
In-Reply-To: <20230519062137.1251741-1-tommy.wu@sifive.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 19 May 2023 08:39:46 +0200
Message-ID: <CAJy5ezoRZOqzWDe_ZAq_TF2k=9ZCXZkp8Ea2iaxoRV=yw+tGNw@mail.gmail.com>
Subject: Re: [PATCH] hw/dma/xilinx_axidma: Check DMASR.HALTED to prevent
 infinite loop.
To: Tommy Wu <tommy.wu@sifive.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000088f95505fc0630f7"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ej1-x62b.google.com
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

--00000000000088f95505fc0630f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 8:21=E2=80=AFAM Tommy Wu <tommy.wu@sifive.com> wrot=
e:

> When we receive a packet from the xilinx_axienet and then try to s2mem
> through the xilinx_axidma, if the descriptor ring buffer is full in the
> xilinx axidma driver, we=E2=80=99ll assert the DMASR.HALTED in the
> function : stream_process_s2mem and return 0. In the end, we=E2=80=99ll b=
e stuck in
> an infinite loop in axienet_eth_rx_notify.
>
> This patch checks the DMASR.HALTED state when we try to push data
> from xilinx axi-enet to xilinx axi-dma. When the DMASR.HALTED is asserted=
,
> we will not keep pushing the data and then prevent the infinte loop.
>
> Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> ---
>  hw/dma/xilinx_axidma.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index 6030c76435..12c90267df 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -168,6 +168,11 @@ static inline int stream_idle(struct Stream *s)
>      return !!(s->regs[R_DMASR] & DMASR_IDLE);
>  }
>
> +static inline int stream_halted(struct Stream *s)
>

At some point we should probably change all of these helpers to return
booleans...
Anyway, this fix looks good to me:

Reviewed-by: Edgar E. Iglesias <edgar@zeroasic.com>




> +{
> +    return !!(s->regs[R_DMASR] & DMASR_HALTED);
> +}
> +
>  static void stream_reset(struct Stream *s)
>  {
>      s->regs[R_DMASR] =3D DMASR_HALTED;  /* starts up halted.  */
> @@ -269,7 +274,7 @@ static void stream_process_mem2s(struct Stream *s,
> StreamSink *tx_data_dev,
>      uint64_t addr;
>      bool eop;
>
> -    if (!stream_running(s) || stream_idle(s)) {
> +    if (!stream_running(s) || stream_idle(s) || stream_halted(s)) {
>          return;
>      }
>
> @@ -326,7 +331,7 @@ static size_t stream_process_s2mem(struct Stream *s,
> unsigned char *buf,
>      unsigned int rxlen;
>      size_t pos =3D 0;
>
> -    if (!stream_running(s) || stream_idle(s)) {
> +    if (!stream_running(s) || stream_idle(s) || stream_halted(s)) {
>          return 0;
>      }
>
> @@ -407,7 +412,7 @@ xilinx_axidma_data_stream_can_push(StreamSink *obj,
>      XilinxAXIDMAStreamSink *ds =3D XILINX_AXI_DMA_DATA_STREAM(obj);
>      struct Stream *s =3D &ds->dma->streams[1];
>
> -    if (!stream_running(s) || stream_idle(s)) {
> +    if (!stream_running(s) || stream_idle(s) || stream_halted(s)) {
>          ds->dma->notify =3D notify;
>          ds->dma->notify_opaque =3D notify_opaque;
>          return false;
> --
> 2.31.1
>
>

--00000000000088f95505fc0630f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Fri, May 19, 2023 at 8:21=E2=80=AFAM T=
ommy Wu &lt;<a href=3D"mailto:tommy.wu@sifive.com">tommy.wu@sifive.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">When =
we receive a packet from the xilinx_axienet and then try to s2mem<br>
through the xilinx_axidma, if the descriptor ring buffer is full in the<br>
xilinx axidma driver, we=E2=80=99ll assert the DMASR.HALTED in the<br>
function : stream_process_s2mem and return 0. In the end, we=E2=80=99ll be =
stuck in<br>
an infinite loop in axienet_eth_rx_notify.<br>
<br>
This patch checks the DMASR.HALTED state when we try to push data<br>
from xilinx axi-enet to xilinx axi-dma. When the DMASR.HALTED is asserted,<=
br>
we will not keep pushing the data and then prevent the infinte loop.<br>
<br>
Signed-off-by: Tommy Wu &lt;<a href=3D"mailto:tommy.wu@sifive.com" target=
=3D"_blank">tommy.wu@sifive.com</a>&gt;<br>
---<br>
=C2=A0hw/dma/xilinx_axidma.c | 11 ++++++++---<br>
=C2=A01 file changed, 8 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c<br>
index 6030c76435..12c90267df 100644<br>
--- a/hw/dma/xilinx_axidma.c<br>
+++ b/hw/dma/xilinx_axidma.c<br>
@@ -168,6 +168,11 @@ static inline int stream_idle(struct Stream *s)<br>
=C2=A0 =C2=A0 =C2=A0return !!(s-&gt;regs[R_DMASR] &amp; DMASR_IDLE);<br>
=C2=A0}<br>
<br>
+static inline int stream_halted(struct Stream *s)<br></blockquote><div><br=
></div><div>At some point we should probably change all of these helpers to=
 return booleans...</div><div>Anyway, this fix looks good to me:</div><div>=
<br></div><div>Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar@z=
eroasic.com">edgar@zeroasic.com</a>&gt;<br></div><div><br></div><div><br></=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+{<br>
+=C2=A0 =C2=A0 return !!(s-&gt;regs[R_DMASR] &amp; DMASR_HALTED);<br>
+}<br>
+<br>
=C2=A0static void stream_reset(struct Stream *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;regs[R_DMASR] =3D DMASR_HALTED;=C2=A0 /* starts u=
p halted.=C2=A0 */<br>
@@ -269,7 +274,7 @@ static void stream_process_mem2s(struct Stream *s, Stre=
amSink *tx_data_dev,<br>
=C2=A0 =C2=A0 =C2=A0uint64_t addr;<br>
=C2=A0 =C2=A0 =C2=A0bool eop;<br>
<br>
-=C2=A0 =C2=A0 if (!stream_running(s) || stream_idle(s)) {<br>
+=C2=A0 =C2=A0 if (!stream_running(s) || stream_idle(s) || stream_halted(s)=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -326,7 +331,7 @@ static size_t stream_process_s2mem(struct Stream *s, un=
signed char *buf,<br>
=C2=A0 =C2=A0 =C2=A0unsigned int rxlen;<br>
=C2=A0 =C2=A0 =C2=A0size_t pos =3D 0;<br>
<br>
-=C2=A0 =C2=A0 if (!stream_running(s) || stream_idle(s)) {<br>
+=C2=A0 =C2=A0 if (!stream_running(s) || stream_idle(s) || stream_halted(s)=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -407,7 +412,7 @@ xilinx_axidma_data_stream_can_push(StreamSink *obj,<br>
=C2=A0 =C2=A0 =C2=A0XilinxAXIDMAStreamSink *ds =3D XILINX_AXI_DMA_DATA_STRE=
AM(obj);<br>
=C2=A0 =C2=A0 =C2=A0struct Stream *s =3D &amp;ds-&gt;dma-&gt;streams[1];<br=
>
<br>
-=C2=A0 =C2=A0 if (!stream_running(s) || stream_idle(s)) {<br>
+=C2=A0 =C2=A0 if (!stream_running(s) || stream_idle(s) || stream_halted(s)=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ds-&gt;dma-&gt;notify =3D notify;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ds-&gt;dma-&gt;notify_opaque =3D notify_o=
paque;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
-- <br>
2.31.1<br>
<br>
</blockquote></div></div>

--00000000000088f95505fc0630f7--

