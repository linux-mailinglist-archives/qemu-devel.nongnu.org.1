Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A158F7EF636
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 17:30:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r41hw-00017p-Qg; Fri, 17 Nov 2023 11:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r41hu-00017h-Gp
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 11:28:38 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r41hs-0001xA-0Z
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 11:28:38 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5c1acc1fa98so2551409a12.0
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 08:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1700238392; x=1700843192;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C4qdAgtvSEKabvRoxfjA+/aFPw7NVFHKm6PISMcolrg=;
 b=fpPu9XIIVMLpfRF1WOLgd6Sg8bgIWI8gKjhqRRI35PD38K7MsnN4HshCxQhQ7Mxffe
 uZlHE2vyVwbyrBe2Ix/PsNT40i07J1Ba+zv7V6DuGPhzCYbTGGhzx7GAYjboXxgOXDlU
 fAtfOP8ENU3kMT5hsgk9rXowgG67xT9VwgZ/9IpeFQv1FGkXBm8So+tDMNLZnBYQIuJy
 GVLjCllig9nSF/V0lkLoMAwleCQt0H2j3w5uqWn8yHVXrGtuQ5azqwZ5F6Kyxxmc5OtM
 O2kwAkapCcl1pmp5/bjtMT0Ihz4LdcLawK/ZrV4AP8Er9xNWj4vQAYyQw9MYN3umPqM3
 nCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700238392; x=1700843192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C4qdAgtvSEKabvRoxfjA+/aFPw7NVFHKm6PISMcolrg=;
 b=qAIFaXlOmMIM3bsqhBq/EQka1vVIlPDe3c89nV8YeOs4y63MOA1qf85KD3SE0HhRDn
 qGX27AQWzhAmWZKjUveYHluQse4iQm7RvUSvXCcSHwT5GXP5VE/Tlqf+NCqQn05AnOou
 2e8t2QQdecCnrjhfKCVUzb2XgtQLg/zFUpxxNcbtHZNbnHeou/RvFk/6617Mr+wiRIg1
 thIXbYIf237M+zBSm9cIolGVEDBJ8CmQ7e/b6Tt7giCEO46YmtvKVZInizht1b2nup4+
 R673+sRLMLL/3NYf5nKBvhaa1g8tsqchn65pOW8UnuWEfIkCePPRpHg+RK9cF49Wa7vz
 +EvQ==
X-Gm-Message-State: AOJu0Yz81oJnHCYMojwLXqLUK1VrZOkb6cEP3IczPU0byCLvD6sH733F
 mgDFmdLO9uh6xeRQ+hppxIg6Lj5ij8rM9ZIYKM34UQ==
X-Google-Smtp-Source: AGHT+IERwP5DZN8iDc5cGc2hvCVUqQwc8IfCpUscqzqxTMgxrTgKfj8j3in7/XH/kT5YRDqMFAXDNLJNJvzrkdhk8iA=
X-Received: by 2002:a17:90b:4f8b:b0:280:892a:75ab with SMTP id
 qe11-20020a17090b4f8b00b00280892a75abmr7927352pjb.10.1700238391290; Fri, 17
 Nov 2023 08:26:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699793550.git.yong.huang@smartx.com>
 <CAK9dgmbjF__gwDn+oEehiyS0P2vSGh-onfFXCHsuOGZhzNhc+g@mail.gmail.com>
 <20231117052838-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231117052838-mutt-send-email-mst@kernel.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Sat, 18 Nov 2023 00:26:15 +0800
Message-ID: <CAK9dgmZO9jmSzsEin2Lq0cR8H835-vjgOuo3_aqB+4kk2ztO5g@mail.gmail.com>
Subject: Re: [RFC 0/2] vhost-user-test: Add negotiated features check
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000058c3e2060a5b991f"
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x530.google.com
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

--00000000000058c3e2060a5b991f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 6:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Thu, Nov 16, 2023 at 09:01:28AM +0800, Yong Huang wrote:
> > ping
>
> Sit tight pls it's only been a couple of days.
> But if you want to, address comments by Markus pls.
>
> I'm happy to do that, of course, and thank you also for the reminder. :)

--=20
Best regards

--00000000000058c3e2060a5b991f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 17, 20=
23 at 6:29=E2=80=AFPM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.c=
om">mst@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style=
:solid;border-left-color:rgb(204,204,204);padding-left:1ex">On Thu, Nov 16,=
 2023 at 09:01:28AM +0800, Yong Huang wrote:<br>
&gt; ping<br>
<br>
Sit tight pls it&#39;s only been a couple of days.<br>
But if you want to, address comments by Markus pls.<br>
<br>
</blockquote></div><div class=3D"gmail_default" style=3D"font-family:&quot;=
comic sans ms&quot;,sans-serif">I&#39;m happy to do that, of course, and th=
ank you also for the reminder. :)</div><div><br></div><span class=3D"gmail_=
signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">=
<div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</fon=
t></div></div></div>

--00000000000058c3e2060a5b991f--

