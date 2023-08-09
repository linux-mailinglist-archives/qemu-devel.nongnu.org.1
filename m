Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB0B775086
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 03:51:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTYLb-0000mj-EA; Tue, 08 Aug 2023 21:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qTYLZ-0000l7-7c
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 21:50:49 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qTYLX-0005Lu-09
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 21:50:49 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-523100882f2so7592212a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 18:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1691545843; x=1692150643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y035M7j4dfeyylO7mmJsqInY0SIo/T2Et0LpPMev5PU=;
 b=KKzGID34Yw62A4s5ULoVX55hpvQZ3GARTnUXeRSoqLJ/wWN9Yfvu+MWDfpjr0uCInR
 Vq2YLtmGgSd/AhEBHj5FJvFVxPadfIVy0M+gTAf5079w/scJcm0sg0KYl+WA7bneSoqQ
 cBQUsCxRTJ4wTJY1D0qy4/YNrtTZrIMVWq9mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691545843; x=1692150643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y035M7j4dfeyylO7mmJsqInY0SIo/T2Et0LpPMev5PU=;
 b=EaaCkhwvh83tvrVrq80s2Xct3HhpXYvVotEMl+LrF7a0TyCqkLR5nwnfgS5wnn/tm9
 tRUeZZSb1fNyR6uKxIqwazPBqAuO5P0jWyIXJTk+g/BqhSXdAzbU6M5dPoCfGyH3FDiK
 4oCgEXprxdshV8LbyW6X1/0V8AZsmKHMmNBtUiuUwuQo9aapIjNMMYK6H8OFE0Wx/M9H
 5kCiWvDncJ6WXNiAmKzQZiKMprP5VUH3WwV5KEYefTzWww7rV/7VbrdpuO3zhFnmbdV+
 3LUJ8K9WCFWZHy+6Jwa+07JRUStKAJzKUbArS2GKhuFOyPpH5RXrKxF1wCwIJx/W3UuY
 9NuA==
X-Gm-Message-State: AOJu0Yxh1ICTP0yZa+zz4v7PtKS6PEi7arCF2SGNsVYe8xex/5AUn1jv
 njgvhAe29NteoLxMhobCLFkIyvoeu0pKQ/JYMSa38w==
X-Google-Smtp-Source: AGHT+IFFg9kgU2/mANQBurG4/QyTIJhA95L5mHH5y517n5Ai95ANW33aATjtF4ggmLgF8lh2lse48A==
X-Received: by 2002:a50:ed13:0:b0:51e:2e39:9003 with SMTP id
 j19-20020a50ed13000000b0051e2e399003mr1032502eds.40.1691545842772; 
 Tue, 08 Aug 2023 18:50:42 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com.
 [209.85.208.51]) by smtp.gmail.com with ESMTPSA id
 v7-20020aa7dbc7000000b0052333e5237esm4411711edt.88.2023.08.08.18.50.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 18:50:42 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-521e046f6c7so3696a12.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 18:50:42 -0700 (PDT)
X-Received: by 2002:a50:d683:0:b0:522:cc9c:f5a4 with SMTP id
 r3-20020a50d683000000b00522cc9cf5a4mr27574edi.4.1691545841921; Tue, 08 Aug
 2023 18:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230803235502.373-1-gurchetansingh@google.com>
 <b9dc2c50-00cf-12ae-d1c9-cb31d089a24d@redhat.com>
In-Reply-To: <b9dc2c50-00cf-12ae-d1c9-cb31d089a24d@redhat.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Tue, 8 Aug 2023 18:50:29 -0700
X-Gmail-Original-Message-ID: <CAAfnVB=wVMy9zUF+-MYZpH=j3cv9-qHz9-4xOjkFhoour89asg@mail.gmail.com>
Message-ID: <CAAfnVB=wVMy9zUF+-MYZpH=j3cv9-qHz9-4xOjkFhoour89asg@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] gfxstream + rutabaga_gfx
To: Erico Nunes <ernunes@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com, 
 akihiko.odaki@gmail.com, dmitry.osipenko@collabora.com, ray.huang@amd.com, 
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is
Content-Type: multipart/alternative; boundary="000000000000080539060273b5a0"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000080539060273b5a0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 7, 2023 at 7:24=E2=80=AFAM Erico Nunes <ernunes@redhat.com> wro=
te:

> Hello,
>
> On 04/08/2023 01:54, Gurchetan Singh wrote:
> > Prior versions:
> >
> > https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg05801.html
> >
> > https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02341.html
> >
> >
> https://patchew.org/QEMU/20230421011223.718-1-gurchetansingh@chromium.org=
/
> >
> > Changes since v2:
> > - Incorporated review feedback
> >
> > How to build both rutabaga and gfxstream guest/host libs:
> >
> > https://crosvm.dev/book/appendix/rutabaga_gfx.html
> >
> > Branch containing this patch series:
> >
> >
> https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qe=
mu-gfxstream-v3
>
> I tried this on Fedora with a Fedora guest and I was able to get Vulkan
> headless applications as well as Wayland proxy with sommelier to work.
> If you don't mind, I have a few questions.
> I was not able to run Vulkan applications over the Wayland proxy, only
> unaccelerated apps. This seems to be unsupported yet; is actually
> unsupported for now or was something missing in my setup?
>

Yes, currently this is unsupported.  In the near future, I do imagine 3D
accelerated rendering over cross-domain to be a thing (among many context
types, not just gfxstream VK).

Re: using gfxstream VK in Linux distros, depends on your use case.  If you
are looking for best performance over virtio on open-source Linux
platforms, perhaps gfxstream Vulkan (or any API virtualization solution) is
not your best bet.  The Mesa native context work looks particularly
exciting there:

https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21658

We are interested in running gfxstream VK in Linux guests, but we envisage
that for reference and testing.  For all embedded use cases, using the host
driver in the guest will predominate due to performance considerations
(either through virtio or HW direct / mediated passthru).

Also apparently GL/GLES is only supported on Android right now as you
> mentioned, since on Linux the gfxstream guest only installs the Vulkan
> library and icd. What is the plan to support GL on Linux; provide
> gfxstream GL guest libraries later or enable Zink or some other solution?
> Then if I understand correctly, Mesa virgl is not used at all with the
> gfxstream solution, so I guess we would need to find a way to ship the
> gfxstream guest libraries too on distributions?



Also I wonder about including all of the the dependencies required to
> get this to build on distributions as well to enable the feature on
> distribution-provided qemu, but I guess we can figure this out later...
>
> And finally out of curiosity, I see that rutabaga also has a
> virgl_renderer (and virgl_renderer_next) backend which would then not
> use gfxstream but virglrenderer instead. I wonder if there would be any
> benefit/features in enabling that with qemu later compared to the
> current qemu virtio/virglrenderer implementation (if that would make
> sense at all)?
>

Yeah, maybe later if there's developer interest,  rutabaga FFI can build
its virglrenderer bindings in a subsequent release.  So far I don't have
time to test, and the most important use case is gfxstream + Android for
Emulator.  As ever, patches are welcome.

Thanks
>
> Erico
>
>

--000000000000080539060273b5a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 7, 2023 at 7:24=E2=80=AFA=
M Erico Nunes &lt;<a href=3D"mailto:ernunes@redhat.com">ernunes@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">H=
ello,<br>
<br>
On 04/08/2023 01:54, Gurchetan Singh wrote:<br>
&gt; Prior versions:<br>
&gt; <br>
&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg05=
801.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archiv=
e/html/qemu-devel/2023-07/msg05801.html</a><br>
&gt; <br>
&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02=
341.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archiv=
e/html/qemu-devel/2023-07/msg02341.html</a><br>
&gt; <br>
&gt; <a href=3D"https://patchew.org/QEMU/20230421011223.718-1-gurchetansing=
h@chromium.org/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/Q=
EMU/20230421011223.718-1-gurchetansingh@chromium.org/</a><br>
&gt; <br>
&gt; Changes since v2:<br>
&gt; - Incorporated review feedback<br>
&gt; <br>
&gt; How to build both rutabaga and gfxstream guest/host libs:<br>
&gt; <br>
&gt; <a href=3D"https://crosvm.dev/book/appendix/rutabaga_gfx.html" rel=3D"=
noreferrer" target=3D"_blank">https://crosvm.dev/book/appendix/rutabaga_gfx=
.html</a><br>
&gt; <br>
&gt; Branch containing this patch series:<br>
&gt; <br>
&gt; <a href=3D"https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstrea=
m/-/commits/qemu-gfxstream-v3" rel=3D"noreferrer" target=3D"_blank">https:/=
/gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstr=
eam-v3</a><br>
<br>
I tried this on Fedora with a Fedora guest and I was able to get Vulkan<br>
headless applications as well as Wayland proxy with sommelier to work.<br>
If you don&#39;t mind, I have a few questions.<br>
I was not able to run Vulkan applications over the Wayland proxy, only<br>
unaccelerated apps. This seems to be unsupported yet; is actually<br>
unsupported for now or was something missing in my setup?<br></blockquote><=
div><br></div><div>Yes, currently this is unsupported.=C2=A0 In the near fu=
ture, I do imagine 3D accelerated rendering over cross-domain to be a thing=
 (among many context types, not just gfxstream VK).=C2=A0=C2=A0</div><div><=
br></div>Re: using gfxstream VK in Linux distros,=C2=A0depends on your use =
case.=C2=A0 If you are looking for best performance over virtio on open-sou=
rce Linux platforms, perhaps gfxstream Vulkan (or any API virtualization so=
lution) is not your best bet.=C2=A0 The Mesa native context work looks part=
icularly exciting there:<br><br><a href=3D"https://gitlab.freedesktop.org/m=
esa/mesa/-/merge_requests/21658">https://gitlab.freedesktop.org/mesa/mesa/-=
/merge_requests/21658</a>=C2=A0=C2=A0</div><div class=3D"gmail_quote"><br><=
/div><div class=3D"gmail_quote">We are interested in running gfxstream VK i=
n Linux guests, but we envisage that for reference and testing.=C2=A0 For a=
ll embedded use cases, using the host driver in the guest will predominate =
due to performance considerations (either through virtio or HW direct / med=
iated passthru).=C2=A0 =C2=A0=C2=A0<br><div><br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
Also apparently GL/GLES is only supported on Android right now as you<br>
mentioned, since on Linux the gfxstream guest only installs the Vulkan<br>
library and icd. What is the plan to support GL on Linux; provide<br>
gfxstream GL guest libraries later or enable Zink or some other solution?<b=
r>
Then if I understand correctly, Mesa virgl is not used at all with the<br>
gfxstream solution, so I guess we would need to find a way to ship the<br>
gfxstream guest libraries too on distributions?=C2=A0=C2=A0</blockquote><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0</blockquote><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
Also I wonder about including all of the the dependencies required to<br>
get this to build on distributions as well to enable the feature on<br>
distribution-provided qemu, but I guess we can figure this out later...<br>
<br>
And finally out of curiosity, I see that rutabaga also has a<br>
virgl_renderer (and virgl_renderer_next) backend which would then not<br>
use gfxstream but virglrenderer instead. I wonder if there would be any<br>
benefit/features in enabling that with qemu later compared to the<br>
current qemu virtio/virglrenderer implementation (if that would make<br>
sense at all)?<br></blockquote><div><br></div><div>Yeah, maybe later if the=
re&#39;s developer interest,=C2=A0 rutabaga FFI can build its virglrenderer=
 bindings in a subsequent release.=C2=A0 So far I don&#39;t have time to te=
st, and the most=C2=A0important use case is gfxstream + Android for Emulato=
r.=C2=A0 As ever, patches are welcome.=C2=A0 =C2=A0 =C2=A0</div><div><br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
Thanks<br>
<br>
Erico<br>
<br>
</blockquote></div></div>

--000000000000080539060273b5a0--

