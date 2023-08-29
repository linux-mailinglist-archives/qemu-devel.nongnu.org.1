Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 038A778D0D0
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:58:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb8bK-0008PE-Uh; Tue, 29 Aug 2023 19:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb8bI-0008Ol-Sb
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:58:24 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb8bG-0000Bg-D8
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 19:58:24 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99bed101b70so622818366b.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 16:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693353501; x=1693958301;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=geVQM3OwX7yJ839W1TyWV+7gVZBT5wv3nU0l9T87ivg=;
 b=Vr46JoBMzbufjcQj64d8CSTYsHDvS+ojKF/aKBJmGD0fcHj+MbaN0a28SCJDtG1eIf
 BLZ5CeiC2xBCQHm4+nIoCJpRmmzsGmtZQTH57Y1L6TQGu3O0v9eW+t5hX4rlRQDGa7Ah
 mVsIYJNrtr10d3lfKPurhyvfGu+U81iOMcdXWdWpq9dytcHJ0Hwmk+kkdfU9LxPT8PXJ
 OZfbxrpZkUvIrdhboTamK0dpMoQCpst/583PnHtUethKVW9wmK5Pq+KYNcl9qh3XBz5r
 ZRGRIChlcLpIVm19T/yGjJbIhZZlq/6YICOMAiZBzBswiEt7qV3Bc7xm6jgRDeddc5WR
 7ClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693353501; x=1693958301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=geVQM3OwX7yJ839W1TyWV+7gVZBT5wv3nU0l9T87ivg=;
 b=WFfRhtGvSNhzovIMifctVnS+R90OM6qcjXRDywOpgT9zIDD7L2areFTOqKo/TT9J5o
 ubn1rs3O5yz1N/84CoI05+Nc6FB4ffMhBpKeBS7YVbIKn0+ah1wkLnv6xwOPY7kGWcPy
 di7mz/GayrCGfq7AJGrmKb+T9enVU5nEnXrZ3s5GQck1jwURTkOMxL+v0S2NFtNuyUXs
 qPueAWw6VyEXnR2n3kR4UbtICLfCjzjAS2DqHJS3o1riN4Fc+SGY/UE/SzWr8ir4o730
 VR2rlCjUgueFzTyE8XCgIBNMuXupMu2YPSoJKfN28MQ12UiLL0EW8guOA7VbvjJ5jfa7
 HjMQ==
X-Gm-Message-State: AOJu0YwkN5YW5cAKn1yIG+EL8rRTavK8wUwa66/f3hwkGNKDPA14zOxR
 1U4UQCoBPrmKxDlzsUEF9vR82zefR1bVAndO7CyZkA==
X-Google-Smtp-Source: AGHT+IEvAVbILtXl7ER4kSkP1DAOOtLHenL2s6djMR1phQYZWxIeT0gQtedWh5JFPmaAMqOE/SRAyYNJrjs207KZU9Y=
X-Received: by 2002:a17:906:3015:b0:9a1:ec69:23ec with SMTP id
 21-20020a170906301500b009a1ec6923ecmr348785ejz.17.1693353500560; Tue, 29 Aug
 2023 16:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230829184743.54557-1-imp@bsdimp.com>
 <67903f3f-89b0-06c5-2b50-911682554c75@linaro.org>
 <CANCZdfqfkAGh2TqYe8JGZYG52Y-=mABAggQx_7LmGZrYNa39Eg@mail.gmail.com>
In-Reply-To: <CANCZdfqfkAGh2TqYe8JGZYG52Y-=mABAggQx_7LmGZrYNa39Eg@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 29 Aug 2023 17:58:09 -0600
Message-ID: <CANCZdfrARBEY-viR1=u9QqmZG10PXiRjKwhEibObbnSBj_z4-w@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user: Move PRAGMA_DISABLE_PACKED_WARNING to
 compiler.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="000000000000e161bb06041895bf"
Received-SPF: none client-ip=2a00:1450:4864:20::62e;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x62e.google.com
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

--000000000000e161bb06041895bf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 5:57=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrote:

>
>
> On Tue, Aug 29, 2023 at 5:35=E2=80=AFPM Richard Henderson <
> richard.henderson@linaro.org> wrote:
>
>> On 8/29/23 11:47, Warner Losh wrote:
>> > Replace the slightly older version of this in include/qemu/compiler.h
>> > that was commit as part of bsd-user changes with the newer one from
>> > linux-user. bsd-user has no regreassions with this.
>> >
>> > Signed-off-by: Warner Losh <imp@bsdimp.com>
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> > diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
>> > index bbd55b4d18c..9bff3b763b5 160000
>> > --- a/tests/lcitool/libvirt-ci
>> > +++ b/tests/lcitool/libvirt-ci
>> > @@ -1 +1 @@
>> > -Subproject commit bbd55b4d18cce8f89b5167675e434a6941315634
>> > +Subproject commit 9bff3b763b5531a1490e238bfbf77306dc3a6dbb
>>
>> Be careful about these.
>>
>
> Doh! how did I miss that... Oh, I only did the git submodule update on my
> blitz branch, but not also on the master branch before I created this. Ni=
ce
> catch.
>
> My love for submodules... is not increasing. Do I need to fix that and
> send a v3?
>

.... or just send the pull request with your reviewed by?

Warner

--000000000000e161bb06041895bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 29, 2023 at 5:57=E2=80=AF=
PM Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Aug 29, 2023 at 5:35=E2=80=AFPM Richa=
rd Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org" target=3D"=
_blank">richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 8/29/23 11:47, Warner Losh wrote:<br=
>
&gt; Replace the slightly older version of this in include/qemu/compiler.h<=
br>
&gt; that was commit as part of bsd-user changes with the newer one from<br=
>
&gt; linux-user. bsd-user has no regreassions with this.<br>
&gt; <br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
&gt; diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci<br>
&gt; index bbd55b4d18c..9bff3b763b5 160000<br>
&gt; --- a/tests/lcitool/libvirt-ci<br>
&gt; +++ b/tests/lcitool/libvirt-ci<br>
&gt; @@ -1 +1 @@<br>
&gt; -Subproject commit bbd55b4d18cce8f89b5167675e434a6941315634<br>
&gt; +Subproject commit 9bff3b763b5531a1490e238bfbf77306dc3a6dbb<br>
<br>
Be careful about these.<br></blockquote><div><br></div><div>Doh! how did I =
miss that... Oh, I only did the git submodule update on my blitz branch, bu=
t not also on the master branch before I created this. Nice catch.</div><di=
v><br></div><div>My love for submodules... is not increasing. Do I need to =
fix that and send a v3?</div></div></div></blockquote><div><br></div><div>.=
... or just send the pull request with your reviewed by?</div><div><br></di=
v><div>Warner=C2=A0</div></div></div>

--000000000000e161bb06041895bf--

