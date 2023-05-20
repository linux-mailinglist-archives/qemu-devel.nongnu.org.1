Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9493270A732
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 12:35:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0Jud-0007C0-N3; Sat, 20 May 2023 06:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1q0Jub-0007Bk-Sx
 for qemu-devel@nongnu.org; Sat, 20 May 2023 06:34:09 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1q0Jua-0005FN-3x
 for qemu-devel@nongnu.org; Sat, 20 May 2023 06:34:09 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f3a7241c0aso3023116e87.1
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 03:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1684578846; x=1687170846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Js7Gj50rkXYdkybC9kl0kjLwoor0AqWNqdAXr7RgTGc=;
 b=FcHVFztY11egaFJL+bsBSMjqKLNoHWb6q0IHWlA+equ9ullq6DD/Vms/VA0KtnicLu
 W7+LwLDdwFckEOi/IxtGYSUEemILs5fpgIPtr3BJheBpHfIO0C4MT1rNvqY1ivyJoimS
 /daNdA+Ryjebw4vSRDxazoL2MbbEr92+3G+2hjkQudrbv62a6gNk7u/WgoaWz1HBNCb1
 paEo3tr5wQs+EmPyT2yhp30/ce183RKN6jD7pbrXndp8zGN4P0uqx+VStjJhIxM6cGtV
 5e6aQoir84zrK/f0jsexQsf1G+6neeDs54dTMDR6a2N1VsFAMKiCwoOPXs1YKoR4zpsc
 tevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684578846; x=1687170846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Js7Gj50rkXYdkybC9kl0kjLwoor0AqWNqdAXr7RgTGc=;
 b=MXaKvl5uPIafpe+9Ju9Nx9XPTKimYzy4+bh52ALBFhN1JqJGk+IdwaClZIRcPeUZTD
 iyXFprV90ei7FlZXSf0GuI0EDDtCs0+MAf069OYUWWyEefuXNQGPw6PsBgCNNWRbl6OP
 901ZmPwZ6CWSxX9WWHG+V+Mh30aTWETfBgMJ9K/blTeyZPj09tuOqcvQ3YuyvQ67WU2a
 FKS4IlvLxfnGBhYCKrs2PHmeJ9EZy1UnGY2E9FJGGJoupIko+qG4Wpxy0aaXMdGdmqaO
 lez7aJWUwquzpXtmHOevEhvddXGAxlaLAllOT9xh4ynLcuoJrrH74LY2XyM+bnio30jA
 5yVA==
X-Gm-Message-State: AC+VfDxFpXGkOa1toENG6MC7qwkOf0y0pDtjKRNc8+FPGT3mnSs9MnC+
 u64lDronauJRV8p9P3ZCh6H0YHFNUXCZG1PWvafoUKu7z/Gmb5B1i1E3jYleFyFXdVhhPnNhMh/
 OQBrihw0MjlCd2RVxvexPNXVvh1Q+q8HPNGkOxCpmGuNTXd0naakpg8a+3+aFV3gCPPTMXFEM/I
 cNZw==
X-Google-Smtp-Source: ACHHUZ5muScheN2hmiajMsuWsFSH3RY63zedb7Oukj7Dj5BlNqTwNnFJyvH0Mu7j6ZuleODx/21xYw==
X-Received: by 2002:a19:7413:0:b0:4f3:a99f:1ea7 with SMTP id
 v19-20020a197413000000b004f3a99f1ea7mr1833842lfe.55.1684578845822; 
 Sat, 20 May 2023 03:34:05 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com.
 [209.85.167.44]) by smtp.gmail.com with ESMTPSA id
 w26-20020ac254ba000000b004f3a1033078sm228209lfk.52.2023.05.20.03.34.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 May 2023 03:34:05 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-4f3a7241c0aso3023044e87.1; 
 Sat, 20 May 2023 03:34:04 -0700 (PDT)
X-Received: by 2002:ac2:5215:0:b0:4f2:5393:b79 with SMTP id
 a21-20020ac25215000000b004f253930b79mr1646072lfl.54.1684578844654; Sat, 20
 May 2023 03:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230519062137.1251741-1-tommy.wu@sifive.com>
In-Reply-To: <20230519062137.1251741-1-tommy.wu@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Sat, 20 May 2023 18:33:53 +0800
X-Gmail-Original-Message-ID: <CANzO1D2Q1ogLJRGzhf6N348OgLUcK084LoP4NiRMtLjPBM8PGw@mail.gmail.com>
Message-ID: <CANzO1D2Q1ogLJRGzhf6N348OgLUcK084LoP4NiRMtLjPBM8PGw@mail.gmail.com>
Subject: Re: [PATCH] hw/dma/xilinx_axidma: Check DMASR.HALTED to prevent
 infinite loop.
To: Tommy Wu <tommy.wu@sifive.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a1c4df05fc1d9328"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--000000000000a1c4df05fc1d9328
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Frank Chang <frank.chang@sifive.com>

On Fri, May 19, 2023 at 2:23=E2=80=AFPM Tommy Wu <tommy.wu@sifive.com> wrot=
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
>

--000000000000a1c4df05fc1d9328
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang=
@sifive.com">frank.chang@sifive.com</a>&gt;</div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 19, 2023 at 2:23=E2=
=80=AFPM Tommy Wu &lt;<a href=3D"mailto:tommy.wu@sifive.com">tommy.wu@sifiv=
e.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">When we receive a packet from the xilinx_axienet and then try to s2mem=
<br>
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
+static inline int stream_halted(struct Stream *s)<br>
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
<br>
</blockquote></div>

--000000000000a1c4df05fc1d9328--

