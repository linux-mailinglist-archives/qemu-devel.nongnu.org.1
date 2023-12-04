Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53497803BE2
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 18:42:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rACx2-0004L3-Tk; Mon, 04 Dec 2023 12:41:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1rACwX-0004Ha-9o
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 12:41:29 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1rACwI-0003BN-8p
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 12:41:04 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-54744e66d27so164a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 09:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1701711656; x=1702316456; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zsDUtfMGXWp14w8h6Nx+AaNjriclI5Ckd8QZdFb7Sy4=;
 b=BjV01pBhuHgtJ3MgbuSbRBmrPe2GFPNila9H/42CVXT8TcO7Yo94OR49nFMnxChLbv
 wXDhwXUMhzVXhgWvXKi3ZLFk/8BvzYR0VOmzPiWxrTOKZXsmDg60sPzxDmughqHuYy0Y
 dk//UX4rP6rWXSkxfEn6tmHDu3MfKnf9COWysQ5oalvEqotFlywtG7sN0kctvqwDoL+p
 nFct0zXqO0tLBQyLYgfij/8ygzJ7P6Ub558dDauHF3J25zs2kfWtCJxl6Qxw29urjqLZ
 uh/qxV+EFHMvpmrptJ9qSX3ALk4ghgw959cxKolAqGArYXxfrQEjR5oE/hbK4nGydkaC
 VPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701711656; x=1702316456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zsDUtfMGXWp14w8h6Nx+AaNjriclI5Ckd8QZdFb7Sy4=;
 b=M9o1QuDwtyo9TkMYjAbZCeA7apdGpi+eek5Zt9uxSoOSmmOwCXYvNLEO8xci32+aRy
 1PXzZZHWyxnHrUk3kK1A5ZR8qe+ck2sbrWYrPZwxMhTVsfYz9Wenc94IXkEeIXKWbYGE
 zsCaR5HYiZW7iomMtO7CIJgi923vMaSkLVJAsxSjGI95jD1tbSjmr72Hg1eq9k05P2bt
 F9Ey3tbu2DjxTCtg6mpnK9EJYDyKPHhY04sROSY/hko1ZsVJIcSU1tdzfrWczN6f9/8Y
 mQtNjqw8w4MMbt5ceTfJ+2rShQ3nA5VMgES5aRyYmZkgtvM4SvJoMvffirCTJHqj+TTr
 k71Q==
X-Gm-Message-State: AOJu0YxM5wcvT6M6XvwhHabXD2SWTQjM96otGEeDblYy+6Qttxy3o2X4
 9lqopf6e5KHVfgSRGgDj9YcKfBQpTnA0obZjM2Qgwg==
X-Google-Smtp-Source: AGHT+IH9gUsGjR2HQxXU8FGFzJPw6bj+qZhsUYlf6Xd/ax/ic6AGISduqcstCrTAQaBwEkksBCGQMuwmRgziF6p6SmU=
X-Received: by 2002:a50:d797:0:b0:54b:6b3f:4aa8 with SMTP id
 w23-20020a50d797000000b0054b6b3f4aa8mr421200edi.4.1701711655897; Mon, 04 Dec
 2023 09:40:55 -0800 (PST)
MIME-Version: 1.0
References: <20231116163633.276671-1-venture@google.com>
 <40d8f91c-e951-413f-8f15-446f0f1b4938@redhat.com>
 <CAO=notyr9V2Z3Ad=rm6qinVmfobB4ESn70Bn5rA-3gGm3Siv-w@mail.gmail.com>
 <c7ff45ab-4eb4-460d-bc63-e1fafe6ea239@linaro.org>
In-Reply-To: <c7ff45ab-4eb4-460d-bc63-e1fafe6ea239@linaro.org>
From: Patrick Venture <venture@google.com>
Date: Mon, 4 Dec 2023 09:40:43 -0800
Message-ID: <CAO=notzZ9_oRN-ptXHw-9LGHep1ZTHZ9BRqjv+-cpG=W5cQjiQ@mail.gmail.com>
Subject: Re: [PATCH v2] system/memory: use ldn_he_p/stn_he_p
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: David Hildenbrand <david@redhat.com>, pbonzini@redhat.com,
 peterx@redhat.com, 
 peter.maydell@linaro.org, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, Chris Rauer <crauer@google.com>, 
 Peter Foley <pefoley@google.com>
Content-Type: multipart/alternative; boundary="000000000000c32139060bb29eae"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=venture@google.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000c32139060bb29eae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 3:24=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> Hi Patrick,
>
> On 3/12/23 16:42, Patrick Venture wrote:
>
> > Friendly ping? Is this going to be applied or do I need to add another
> > CC or?  I do think it should go into stable.
>
> I'll send a PR with this patch included.
>

Thanks!

>
> Regards,
>
> Phil.
>

--000000000000c32139060bb29eae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 4, 2023 at 3:24=E2=80=AFA=
M Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phil=
md@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Hi Patrick,<br>
<br>
On 3/12/23 16:42, Patrick Venture wrote:<br>
<br>
&gt; Friendly=C2=A0ping? Is this going to be applied or do I need to add an=
other <br>
&gt; CC or?=C2=A0 I do think it should go into stable.<br>
<br>
I&#39;ll send a PR with this patch included.<br></blockquote><div><br></div=
><div>Thanks!=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Regards,<br>
<br>
Phil.<br>
</blockquote></div></div>

--000000000000c32139060bb29eae--

