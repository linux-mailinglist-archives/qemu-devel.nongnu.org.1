Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C38277513B
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 05:08:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTZYf-0004K9-VV; Tue, 08 Aug 2023 23:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTZYe-0004I8-4O
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:08:24 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTZYc-0002Tq-BE
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:08:23 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-977e0fbd742so866531766b.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 20:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1691550501; x=1692155301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XbqqlvjtrNYSbdaHLDI9JhVjKFzo1pVOsCxM/nwGb/8=;
 b=UN2paP44vlkwqrB5iPH+RItbRbRI2te7J30klht+UNe8sffKCCeV7XNgpOhv58xJi3
 Oh34hHxt0XEHo80CMTi1WzQAonNMeA/BcmGOjPIRlFgdGYg8ox38MM4mYZ8YGAdZWpyF
 Y0NpKDHLf5fBIARoMkxqkoeLCKRC7nGItf0+mFvRoRZAVZ89azQuGvL69fOeovhyZEQY
 Hx0Jv47iTA7XlhJnGQjBJkPi4PWlWn+ISBZM0HaXWOTzGaGh3rb8KT8kiCmVQZzrLZ9t
 Vmka5YDsar9dQ00UYj+gh4c8SF68O9YnGH+4E8WWc4kgv4bL7PHRsCZZpdzSHfG2bDds
 HDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691550501; x=1692155301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XbqqlvjtrNYSbdaHLDI9JhVjKFzo1pVOsCxM/nwGb/8=;
 b=P87AF8XvIl4tMD9LAJZ3vi98IeiPhXwVBpir+DPH1Nc/zph/gzHuI9sG81Acvew4Wc
 ZWxTsBvCDgliOFJUpmR6O1W9ZJgTGO1wEqhl/QbBK1UlOYKxKbHdotQRY9TXjF9f891W
 c2EpGb4bVnvN6hg76Hx8WeangNugYHwd7zLdC+jJ8Gwj/XNbyVhu69C1BzdJ+4WjaglY
 xcXWdjzPdMRgXNK18pN6NBCgoemqtcEIFmWCCe6C5CLf5CHfTHXYJmuo3INGOwdtjpWO
 +zkEc0n7d+PtPOjKnkClF+ZZ7lT9QmAJOS4SXasOaQohFa5Vu1OD1Rj9H84vbtDOtma6
 7rlA==
X-Gm-Message-State: AOJu0YwJzaYy29dtmHba/8tFixl0xR83DIK92xtJ2MYrWEg/l9t9ocq1
 vTL1RUJe02pk3PP7XfSnGZiJfzPu0M/ArpqEzDw9LA==
X-Google-Smtp-Source: AGHT+IG6+XebQsayyXLZ+my9MjHZlQ5H1di/3OReTcg0wX+N0yuhraOj8cHFbcgraIs/5lwJoY9yqXiwLGeKAegt5/U=
X-Received: by 2002:a17:906:cc14:b0:99c:bb4d:f590 with SMTP id
 ml20-20020a170906cc1400b0099cbb4df590mr944616ejb.47.1691550500889; Tue, 08
 Aug 2023 20:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-3-kariem.taha2.7@gmail.com>
 <612acdbb-865d-0e32-9212-df9440a0e8bb@linaro.org>
 <CANCZdfoLG8vpwgnxB2hW1ZoNeoTZvQuMfXYkB45eLisEtgbLYA@mail.gmail.com>
 <51f6d14a-bf36-1d3a-e9ee-de86bc506eaf@linaro.org>
In-Reply-To: <51f6d14a-bf36-1d3a-e9ee-de86bc506eaf@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 8 Aug 2023 21:08:11 -0600
Message-ID: <CANCZdfpG2Us1hV2ZRY0Xj4O_4sM-=A=_g4Wn6rEuZGR4wParZw@mail.gmail.com>
Subject: Re: [PATCH 02/33] Disable clang warnings arising from bsd-user/qemu.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org, 
 Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000b9b855060274ca36"
Received-SPF: none client-ip=2a00:1450:4864:20::635;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x635.google.com
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

--000000000000b9b855060274ca36
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 8, 2023 at 9:05=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/8/23 19:56, Warner Losh wrote:
> > Looking at this now, This bug is in clang 7, from 2018. For FreeBSD, we
> don't support
> > anything older than clang 12 or 13 However, the bug still exists in
> clang 16, the latest.
> > I believe this was also copied verbatim from linux-user, so let's leave
> it and then make
> > this one of the common things as a followup... ok?
>
> Ah.  In which case this should simply be moved to qemu/compiler.h.
>

OK. That we can do. I'll look into it.

Warner


>
> r~
>

--000000000000b9b855060274ca36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 8, 2023 at 9:05=E2=80=AFP=
M Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ric=
hard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 8/8/23 19:56, Warner Losh wrote:<br>
&gt; Looking at this now, This bug is in clang 7, from 2018. For FreeBSD, w=
e don&#39;t support<br>
&gt; anything older than clang 12 or 13 However, the bug still exists in cl=
ang 16, the latest.<br>
&gt; I believe this was also copied verbatim from linux-user, so let&#39;s =
leave it and then make<br>
&gt; this one of the common things as a followup... ok?<br>
<br>
Ah.=C2=A0 In which case this should simply be moved to qemu/compiler.h.<br>=
</blockquote><div><br></div><div>OK. That we can do. I&#39;ll look into it.=
</div><div><br></div><div>Warner<br></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
r~<br>
</blockquote></div></div>

--000000000000b9b855060274ca36--

