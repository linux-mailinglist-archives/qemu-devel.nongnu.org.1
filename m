Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4F88190F9
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:40:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfvw-0001Qv-8v; Tue, 19 Dec 2023 14:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rFfvr-0001Qj-EO
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:39:12 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rFfvp-0007mB-B7
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:39:11 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-553729ee917so3034936a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1703014746; x=1703619546;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P1lucA3+f8CIaQwytRR1Zq/ljVuYBCZPDGKitsbuS74=;
 b=zyEpVSzuoL/YKt+Re7caUmwZYb+2HmYK639AtPQpWpclSX5NIdi71jBI+2D8+AX38u
 DzEoKPZAVv6sG2qMyrIpL6DPcScLY4XwWSJMbHZ3tEgRVCAAsijU3XCa+DW5jOLjMVGw
 sv0TwUhxclbs1ONczBfJlgrRoyMjiOWbBN2lZAal/Ha5c+tWY54yIbmtpHByBFaZhSPf
 WF0UlyIr+FSFLOw67YifjkY1gkWnaVfFLzrWVdv0D3wxXikTOjN/QDUsUHj1DadRxFfH
 hErBtAknITgpWcglgJzOdVS+yfgFZVxHbcjJLejOpS+Is1FKzysp30rv4X4dS1lqhfmn
 wnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703014746; x=1703619546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P1lucA3+f8CIaQwytRR1Zq/ljVuYBCZPDGKitsbuS74=;
 b=gQOwGjTJGG8oGa8/IYKtlzfNDH4e28MqQ/I6/qFOkF5uvJ/XB+Tt2EcK0/6nG4FxJh
 WB4aHtwVsZkv6dZeKqYeXa2tbH5Jxey3HCPD5hcziyzVcf9xI6TagoYFEqQ15fChHEYs
 rOOof8x9RYrmt8jFAfm9VUCOWDVAsyYoxkAATsPxGoK5xBAUlBkPqzwqaQlAyZgwqNzh
 MevrhLVPp3wl/YyXRlbboxs9t9JJlTnN1tNTWwqgqKNBf6dBICcmgXqfFtcsTfzcKasD
 KwXovsI4Mn7ixFiksGPkkMXpMnJ2i4ULkWYrMy2kz50+l+JOrJxj8zHIo8cIcH3vN7tX
 ngvA==
X-Gm-Message-State: AOJu0Yzc1Wsg3XHUBurTmHoxgIKOM/wryySbC9QyeJQb7PMbgbPRore2
 ffmGbXQZvC+O89Lgt75na3/KdgUMk42FlCXQCC8T1uGS/kgnESpm5fY=
X-Google-Smtp-Source: AGHT+IGVP54zyagbMNGjJe5jdEw2Oi7FLSq+gs4cCRrKyO5/Myn8yBkqFzHeB37fUnrv0jefN3e1+6TqIXD25tDX0jE=
X-Received: by 2002:a17:906:6a95:b0:a23:6264:ff32 with SMTP id
 p21-20020a1709066a9500b00a236264ff32mr1707228ejr.115.1703014746205; Tue, 19
 Dec 2023 11:39:06 -0800 (PST)
MIME-Version: 1.0
References: <20231219132135.c4bff4807c9d7215b179f240@killthe.net>
In-Reply-To: <20231219132135.c4bff4807c9d7215b179f240@killthe.net>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 19 Dec 2023 12:38:54 -0700
Message-ID: <CANCZdfqn0DuO_jssdCgOtmi+dEVrp59TVn97d8UHXF_Dx8Xm7g@mail.gmail.com>
Subject: Re: Qemu resets terminal to crazy defaults
To: Dave Blanchard <dave@killthe.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000fec2cc060ce20483"
Received-SPF: none client-ip=2a00:1450:4864:20::52d;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52d.google.com
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

--000000000000fec2cc060ce20483
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023, 12:20=E2=80=AFPM Dave Blanchard <dave@killthe.net> wr=
ote:

> Hello all, can you please help me to understand what Qemu is doing here?
>
> When connecting to the guest for example using a serial/tcp/telnet link,
> some kind of code is being immediately transmitted over the link which
> screws up my Xterm terminal settings, including changing the text cursor
> shape and most notably, disabling wraparound of long lines, so that they
> get truncated at the edge of the window instead.
>
> Can this behavior be disabled by command line, and if not, what is the
> code doing exactly so I can know where to disable it? I tried disabling a=
ll
> calls to tcsetattr() but that had no effect.
>

Is it qemu doing this or your boit loader. What you describe has nothing to
do with tcsetattr, and everything to do with the state of your terminal
emulation... which is controlled with escape sequences...

Warner


Dave
>
>

--000000000000fec2cc060ce20483
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Dec 19, 2023, 12:20=E2=80=AFPM Dave Blanchard =
&lt;<a href=3D"mailto:dave@killthe.net">dave@killthe.net</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">Hello all, can you please help me to u=
nderstand what Qemu is doing here? <br>
<br>
When connecting to the guest for example using a serial/tcp/telnet link, so=
me kind of code is being immediately transmitted over the link which screws=
 up my Xterm terminal settings, including changing the text cursor shape an=
d most notably, disabling wraparound of long lines, so that they get trunca=
ted at the edge of the window instead. <br>
<br>
Can this behavior be disabled by command line, and if not, what is the code=
 doing exactly so I can know where to disable it? I tried disabling all cal=
ls to tcsetattr() but that had no effect.<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Is it qemu doing this or your boit=
 loader. What you describe has nothing to do with tcsetattr, and everything=
 to do with the state of your terminal emulation... which is controlled wit=
h escape sequences...</div><div dir=3D"auto"><br></div><div dir=3D"auto">Wa=
rner</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Dave<br>
<br>
</blockquote></div></div></div>

--000000000000fec2cc060ce20483--

