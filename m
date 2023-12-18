Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5964816B57
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 11:42:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFB3Z-0000Lu-JP; Mon, 18 Dec 2023 05:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rFB3X-0000JB-Pf
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 05:41:03 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rFB3W-0000qY-17
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 05:41:03 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5e4ee907295so14859397b3.3
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 02:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702896060; x=1703500860; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Raru0pnZo5Gy/exbxe4Of++plFGtxd5H0q972+tj32Y=;
 b=ICsdBH7BKc/bEk8ZkJi7XrFDN3dj5unFIgdtCZEAj0DNJG0yAk4pY8Fcq/Aw/dyiRH
 ma67cdOZUPbmmaOevec23SA+Iyr12xJvHWSnU9ulWEZg3kyUOFzOipQFhYN9SqRy3WUV
 zgaWcCvv6ETWhuMxypMJXs5x3A2F84NNV7IrWZiEASEH1G8J2zkqp5uFqg6tjlxCQofh
 riG92J4V8dl7WHvud3Jxc4oW3yxENTfphOMzSD0R2rUJN0JVYQehtU0rt5zzifsX9EHG
 PF9g0GGsm0xRVPh1LWmDHrHStwsLoT5RhmXEIWRVeDB6xcTc5MBcA4EYoPjwf6e0VsVl
 27OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702896060; x=1703500860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Raru0pnZo5Gy/exbxe4Of++plFGtxd5H0q972+tj32Y=;
 b=cNz4Okw8HuzWaIhQD6VwS5v9ieJzy+y5AmGCEDnnJPjyC9WDCfNlg+auHqVp4kHPl3
 ZhS/n0Y1pNWAuJuARG/j+AXipka0/mMykv44yyNu/3q+ktVaF+MRg43hTgm7Ajai9bbE
 wYUyezfeEeOdsh484zJb4krXvGmnW2TE9RO9A7TrtFFgN39Q9fe5Qtn8WyUpx9xrZkk1
 ogneoGPKXXbzwXGBVgYPyasFUzEtX+XZm6jUylbIyVjtd4VA3NJKKgsuQARlzQ47aS7f
 LvY9drLf/bXb/h8a/fbH0Rv2l9xdvrD2nwlFBIw0usHT7aEdWDjEUpkw9CGfvPgzaLQJ
 rZrA==
X-Gm-Message-State: AOJu0YzuKE4yft2FiYb7khB0wBUiKxYF7VtjYcI2rAfaEOnvxf1NwKQc
 yHQrdtfAgZOoMj37LbXTmlVCNUmIw0zwltAJd/SVOitHwyY=
X-Google-Smtp-Source: AGHT+IEeVdughzZ5UiaJyqB3tMDPhXJApzfjCuUUBSI28ellESMNQbQDFxAJm/Bl98z9dWeFenQWDaILOCJlOVtHdpE=
X-Received: by 2002:a0d:dd89:0:b0:5e3:7ce6:5269 with SMTP id
 g131-20020a0ddd89000000b005e37ce65269mr5289684ywe.28.1702896060101; Mon, 18
 Dec 2023 02:41:00 -0800 (PST)
MIME-Version: 1.0
References: <20231117173916.3658-1-n.ostrenkov@gmail.com>
In-Reply-To: <20231117173916.3658-1-n.ostrenkov@gmail.com>
From: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Date: Mon, 18 Dec 2023 13:40:49 +0300
Message-ID: <CAC8KSA1SydreP4hT+3bJS-tZeeFH5_ZWbHCMCAMedM1pYjMP-w@mail.gmail.com>
Subject: Re: [PATCH v3] hw/usb: fix xhci port notify
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c07e4e060cc662b0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=n.ostrenkov@gmail.com; helo=mail-yw1-x112a.google.com
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

--000000000000c07e4e060cc662b0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping
https://patchew.org/QEMU/20231117173916.3658-1-n.ostrenkov@gmail.com/

=D0=BF=D1=82, 17 =D0=BD=D0=BE=D1=8F=D0=B1. 2023=E2=80=AF=D0=B3., 20:39 Niki=
ta Ostrenkov <n.ostrenkov@gmail.com>:

> From MCF5253 Reference manual
> https://www.nxp.com/docs/en/reference-manual/MCF5253RM.pdf
>
> Host mode: Port Change Detect. The controller sets this bit to a one when
> on any port a Connect Status occurs, a PortEnable/Disable Change occurs, =
an
> Over Current Change occurs, or the Force Port Resume bit is set as
> theresult of a J-K transition on the suspended port.
>
> Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
> ---
>  hw/usb/hcd-xhci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 4b60114207..1b2f4ac721 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -2627,6 +2627,7 @@ static void xhci_port_notify(XHCIPort *port,
> uint32_t bits)
>      if (!xhci_running(port->xhci)) {
>          return;
>      }
> +    port->xhci->usbsts |=3D USBSTS_PCD;
>      xhci_event(port->xhci, &ev, 0);
>  }
>
> --
> 2.34.1
>
>

--000000000000c07e4e060cc662b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">ping<div dir=3D"auto"><a href=3D"https://patchew.org/QEMU=
/20231117173916.3658-1-n.ostrenkov@gmail.com/">https://patchew.org/QEMU/202=
31117173916.3658-1-n.ostrenkov@gmail.com/</a><br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D1=82, 17 =D0=
=BD=D0=BE=D1=8F=D0=B1. 2023=E2=80=AF=D0=B3., 20:39 Nikita Ostrenkov &lt;<a =
href=3D"mailto:n.ostrenkov@gmail.com">n.ostrenkov@gmail.com</a>&gt;:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">From MCF5253 Reference manual <a href=3D"=
https://www.nxp.com/docs/en/reference-manual/MCF5253RM.pdf" rel=3D"noreferr=
er noreferrer" target=3D"_blank">https://www.nxp.com/docs/en/reference-manu=
al/MCF5253RM.pdf</a><br>
<br>
Host mode: Port Change Detect. The controller sets this bit to a one when o=
n any port a Connect Status occurs, a PortEnable/Disable Change occurs, an =
Over Current Change occurs, or the Force Port Resume bit is set as theresul=
t of a J-K transition on the suspended port.<br>
<br>
Signed-off-by: Nikita Ostrenkov &lt;<a href=3D"mailto:n.ostrenkov@gmail.com=
" target=3D"_blank" rel=3D"noreferrer">n.ostrenkov@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/usb/hcd-xhci.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c<br>
index 4b60114207..1b2f4ac721 100644<br>
--- a/hw/usb/hcd-xhci.c<br>
+++ b/hw/usb/hcd-xhci.c<br>
@@ -2627,6 +2627,7 @@ static void xhci_port_notify(XHCIPort *port, uint32_t=
 bits)<br>
=C2=A0 =C2=A0 =C2=A0if (!xhci_running(port-&gt;xhci)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 port-&gt;xhci-&gt;usbsts |=3D USBSTS_PCD;<br>
=C2=A0 =C2=A0 =C2=A0xhci_event(port-&gt;xhci, &amp;ev, 0);<br>
=C2=A0}<br>
<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--000000000000c07e4e060cc662b0--

