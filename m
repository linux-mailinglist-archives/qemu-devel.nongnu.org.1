Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E9B78E41C
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 03:05:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbW6m-0008Uh-8K; Wed, 30 Aug 2023 21:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qbW6i-0008UZ-Iy
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 21:04:24 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qbW6f-0001Wk-Bv
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 21:04:24 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1c8be41e5efso119596fac.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 18:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1693443736; x=1694048536;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S6qUesVrF9fvpx6JB+jyIlGxeckD4XA/tJUqPVmmNDg=;
 b=bRJlmGoxIbgPCXJpona5EdkdWfdipE2WY0gBA8FnMdR7JXasYeSYpANDvmVHTSUrpC
 euZ7kk/G91PoDe+/XYAxJ3PS95+hBN8G+BAl/kuhJ4yfIK3FqeFvuCyrVXwYPmHyNXEE
 P8eBs6qMM2AqPjWjvAwvwQ1aEAsaHI0qGA6JCpvT+b72LhKmExvqBQAC1HScPDItVXI3
 74Yxlmw3wJh65gxblT8sNJXen4kT4qiXlQD7cDVwpxe7q9yUPx19jQsSFbD/YPL5tgmu
 Tq66NxcRfOWWQyzP+UCJazo9C0LHNAuT5fOdnZYg9FK4vumruMbpHYh0E8c7BiLPFQn3
 gyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693443736; x=1694048536;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S6qUesVrF9fvpx6JB+jyIlGxeckD4XA/tJUqPVmmNDg=;
 b=QrlSRFQYRCIFreKKpjiEiaTBFwAsSh7GBukoR2UB3HeN9+jqj9h9t2JsN0S84+THFp
 2fl8SVrnM/IEcHxDQwKsI2cdkKR6N41Aq4e8VU0kc+b0XSfeo7wKQ5HRH0IA3l6Z9YyD
 ym0rsSgFG9Gk7dN5cvtIJHEfSzpQnhKDYl+6ewetnShVSH9XmyE44Y6tFoycKVsEc5xc
 9Pqw3FsrZygrrpM5edyeAaKQTxXG6oaW++m3ehWYT8o7HdAV1F8rJXLTkb2ittHuJnGf
 OH5GVoEEtrOwAO6ZWM2zqtGa8wXK6Ui4eDuBJQhLjSfJO+66uOxdcZFwPJx3VARqsHSI
 VMiA==
X-Gm-Message-State: AOJu0YzgYOpQP5L5wp7TndbuGCS641IOQvv9lGHC1Pj5G0MGrQYVmTLA
 NxCncdCved+2Rlb+stHmpmEo3BV+lIbK8CXYDvps1w==
X-Google-Smtp-Source: AGHT+IFzr4h8YTWGWqoit+uo8HCUcyCAMdL7xiaqm2guGUI7jUmR1rI5OQakcVbH83AnoS5zWKHkVuKsIKZScS4tD94=
X-Received: by 2002:a05:6870:789:b0:1bf:77e2:95cc with SMTP id
 en9-20020a056870078900b001bf77e295ccmr4301629oab.17.1693443735727; Wed, 30
 Aug 2023 18:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693322363.git.yong.huang@smartx.com>
 <ff118704fa5498c64a55d7a732fd42515fdc356c.1693322363.git.yong.huang@smartx.com>
 <aa868e42-334d-50f3-29fb-19ffa6fda72f@tls.msk.ru>
In-Reply-To: <aa868e42-334d-50f3-29fb-19ffa6fda72f@tls.msk.ru>
From: Yong Huang <yong.huang@smartx.com>
Date: Thu, 31 Aug 2023 09:01:59 +0800
Message-ID: <CAK9dgmY=bu4jNtpVEURcCRnxOdSE-K6+X0RDpOBwwQz5za2NwQ@mail.gmail.com>
Subject: Re: [PULL 1/3] softmmu: Fix dirtylimit memory leak
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, "alloc.young" <alloc.young@outlook.com>
Content-Type: multipart/alternative; boundary="00000000000050c56a06042d9834"
Received-SPF: none client-ip=2001:4860:4864:20::35;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x35.google.com
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

--00000000000050c56a06042d9834
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 12:55=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> w=
rote:

> 29.08.2023 18:29, Hyman Huang wrote:
> > From: "alloc.young" <alloc.young@outlook.com>
> >
> > Fix memory leak in hmp_info_vcpu_dirty_limit,use g_autoptr
> > to handle memory deallocation.
>
> It does not feel like -stable-worthy, or am I wrong and it should be
> picked up
> for -stable?


Since the leak occurs when using the hmp command instead of qmp, which
lowers the frequency, it is, in my opinion, somewhat tolerable for the
dirtylimit feature.
It is undoubtedly not -stable-worthy for the memory leak issue by itself,
which is regrettable. :( And the valgrind tool would be applied as much as
possible for my further work.

Thanks,

Yong


> Thanks,
>
> /mjt
>


--=20
Best regards

--00000000000050c56a06042d9834
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 31, 20=
23 at 12:55=E2=80=AFAM Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru=
">mjt@tls.msk.ru</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:s=
olid;border-left-color:rgb(204,204,204);padding-left:1ex">29.08.2023 18:29,=
 Hyman Huang wrote:<br>
&gt; From: &quot;alloc.young&quot; &lt;<a href=3D"mailto:alloc.young@outloo=
k.com" target=3D"_blank">alloc.young@outlook.com</a>&gt;<br>
&gt; <br>
&gt; Fix memory leak in hmp_info_vcpu_dirty_limit,use g_autoptr<br>
&gt; to handle memory deallocation.<br>
<br>
It does not feel like -stable-worthy, or am I wrong and it should be picked=
 up<br>
for -stable?</blockquote><div><div class=3D"gmail_default" style=3D"font-fa=
mily:&quot;comic sans ms&quot;,sans-serif"><br></div></div><div class=3D"gm=
ail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Sin=
ce the leak occurs when using the hmp command instead of qmp, which</div><d=
iv class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,s=
ans-serif">lowers the frequency, it is, in my opinion, somewhat tolerable f=
or the</div><div class=3D"gmail_default" style=3D"font-family:&quot;comic s=
ans ms&quot;,sans-serif">dirtylimit feature.=C2=A0</div><div class=3D"gmail=
_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">It is =
undoubtedly not -stable-worthy for the memory leak issue by itself,=C2=A0</=
div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&q=
uot;,sans-serif">which is regrettable. :( And the valgrind tool would be ap=
plied as much as</div><div class=3D"gmail_default" style=3D"font-family:&qu=
ot;comic sans ms&quot;,sans-serif">possible for my further work.=C2=A0</div=
><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot=
;,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-family:&=
quot;comic sans ms&quot;,sans-serif">Thanks,=C2=A0</div><div><br></div><div=
 class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,san=
s-serif">Yong</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
<br>
/mjt<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--00000000000050c56a06042d9834--

