Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B6A72DC0A
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 10:08:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8z49-0001yX-8B; Tue, 13 Jun 2023 04:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8z47-0001y7-6W; Tue, 13 Jun 2023 04:07:47 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8z45-0005dV-LF; Tue, 13 Jun 2023 04:07:46 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4652fcb2ac1so2136421e0c.1; 
 Tue, 13 Jun 2023 01:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686643664; x=1689235664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ciFMPtsm0MR17JnUHMUbyGZPGjmipZFXian0Z+D/0jo=;
 b=hNOOP/LCJhmYPKA9Hift8B3pLhII1zd8ZWkz5u4WDmGOi5IEVc1k8rbx0IvI0f9dsM
 GhpkaKprHQ18STeetSYmeUaV4/m6rFsK7NzO9WauPNWpT6ql1EOyy8OzQWV9oNTSiSc0
 CguVNg38+GtJJm+9R22u4VqqscIH24mT1fMufJifiiucsP55s4UYr4O+ng+Exwv1gked
 YTm0D+lN5QODEzGeyGIDK1ekd0o1ZsHYtHZMmHKDUGJ1VzKu1VypsI4bRZy3/CRZRGbr
 2ux+NW1Dg5g6f7M5rIyS7U0euAErpLjipClvS6983HNRMhTjFrTS9Y9+VlMi8FfgGiaS
 fxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686643664; x=1689235664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ciFMPtsm0MR17JnUHMUbyGZPGjmipZFXian0Z+D/0jo=;
 b=hSdQdocoZf1DADz4xDGvtrbPuI3RwpW4R9tr3wr26lq1jrCjN/GTXifGrypbMdcrbw
 XtLLtBS4uOYnNEeO9Ep1SsqCzBbbavRX7ZTz9OWDXkO/Xe6lGEwNRhmpVYbANqmLrf70
 THMlePTIw2jSbKeTa4X8paiWQNCBr4oT2JO7/MTIgGYu/lJaxEEmeUIiqbbjmMk+AQX7
 X2gCtopApsf5ndsyOtBsYlVH8kTGH0U5TuRUwrEqiKpZh170PCMpVY1Q2y3bqcasc4YA
 wpAFMXjShbM/TAM7ZAlV8cxiXVSoMVmIQTT5VsCsPpbwtF5Tl7L/BPSlC3RTn0gmyJsN
 jOIA==
X-Gm-Message-State: AC+VfDxOzsNQgBbt2J34jGTTcmkVDDpMxbO3YBSiYykL84ZxX8tVc3gv
 oV9MRMac5GuMCEINzcuA2c5eEqFx4nJq7OIbVOQ=
X-Google-Smtp-Source: ACHHUZ7j+wwlsiCHn2x7sPwNZaZ2c8O8jcyAmeBc0BEgequ525TuaJIoVHnGzgTxYw9ow7xcwJik8Pi38JFGGkwdQUc=
X-Received: by 2002:a1f:d405:0:b0:464:cd5c:b37e with SMTP id
 l5-20020a1fd405000000b00464cd5cb37emr6279948vkg.0.1686643664187; Tue, 13 Jun
 2023 01:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230609185119.691152-1-mark.cave-ayland@ilande.co.uk>
 <20230609185119.691152-6-mark.cave-ayland@ilande.co.uk>
 <76F6648A-47D8-4975-8344-93BE5DD6A071@gmail.com>
 <b2226d76-7c93-3623-69f0-5029ddc42aa3@linaro.org>
In-Reply-To: <b2226d76-7c93-3623-69f0-5029ddc42aa3@linaro.org>
From: Bernhard Beschow <shentey@gmail.com>
Date: Tue, 13 Jun 2023 10:07:30 +0200
Message-ID: <CAG4p6K66SoZERUDKEWvWigrqygvZ=N6GaGfYkXYtx7Ze0izZAA@mail.gmail.com>
Subject: Re: [PATCH 5/5] cmd646: move device-specific BMDMA registers to
 separate memory region
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000077776805fdfe5454"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=shentey@gmail.com; helo=mail-vk1-xa33.google.com
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

--00000000000077776805fdfe5454
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 12:39=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
wrote:

> On 12/6/23 21:28, Bernhard Beschow wrote:
> >
> >
> > Am 9. Juni 2023 18:51:19 UTC schrieb Mark Cave-Ayland <
> mark.cave-ayland@ilande.co.uk>:
> >> The aim here is to eliminate any device-specific registers from the
> main BMDMA
> >> bar memory region so it can potentially be moved into the shared PCI
> IDE device.
> >>
> >> For each BMDMA bus create a new cmd646-bmdma-specific memory region
> representing
> >> the device-specific BMDMA registers and then map them using aliases
> onto the
> >> existing BMDMAState memory region.
> >>
> >> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >> ---
> >> hw/ide/cmd646.c         | 111 +++++++++++++++++++++++++++++++---------
> >> include/hw/ide/cmd646.h |   4 ++
> >> 2 files changed, 90 insertions(+), 25 deletions(-)
>
>
> >> struct CMD646IDEState {
> >>      PCIIDEState parent_obj;
> >> +
> >> +    MemoryRegion bmdma_mem[2];
> >> +    MemoryRegion bmdma_mem_alias[2][2];
> >
> > The added complexity of a two-dimensional alias array seems like a toug=
h
> call for me. I'm not totally against it but I'm reluctant.
>
> Alternative:
>
>          struct {
>              MemoryRegion mem;
>              MemoryRegion mem_alias[2];
>

If `mem_alias` became an anonymous struct as well we could avoid fiddling
with two indices in a matrix, lowering the complexity.

Best regards,
Bernhard

>          } bmdma[2];
>
> >> };
> >>
> >> #endif
> >
>
>

--00000000000077776805fdfe5454
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 13, 2023 at 12:39=E2=80=
=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">=
philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On 12/6/23 21:28, Bernhard Beschow wrote:<br>
&gt; <br>
&gt; <br>
&gt; Am 9. Juni 2023 18:51:19 UTC schrieb Mark Cave-Ayland &lt;<a href=3D"m=
ailto:mark.cave-ayland@ilande.co.uk" target=3D"_blank">mark.cave-ayland@ila=
nde.co.uk</a>&gt;:<br>
&gt;&gt; The aim here is to eliminate any device-specific registers from th=
e main BMDMA<br>
&gt;&gt; bar memory region so it can potentially be moved into the shared P=
CI IDE device.<br>
&gt;&gt;<br>
&gt;&gt; For each BMDMA bus create a new cmd646-bmdma-specific memory regio=
n representing<br>
&gt;&gt; the device-specific BMDMA registers and then map them using aliase=
s onto the<br>
&gt;&gt; existing BMDMAState memory region.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ay=
land@ilande.co.uk" target=3D"_blank">mark.cave-ayland@ilande.co.uk</a>&gt;<=
br>
&gt;&gt; ---<br>
&gt;&gt; hw/ide/cmd646.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 111 +++++++++++=
++++++++++++++++++++---------<br>
&gt;&gt; include/hw/ide/cmd646.h |=C2=A0 =C2=A04 ++<br>
&gt;&gt; 2 files changed, 90 insertions(+), 25 deletions(-)<br>
<br>
<br>
&gt;&gt; struct CMD646IDEState {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 PCIIDEState parent_obj;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 MemoryRegion bmdma_mem[2];<br>
&gt;&gt; +=C2=A0 =C2=A0 MemoryRegion bmdma_mem_alias[2][2];<br>
&gt; <br>
&gt; The added complexity of a two-dimensional alias array seems like a tou=
gh call for me. I&#39;m not totally against it but I&#39;m reluctant.<br>
<br>
Alternative:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion mem;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion mem_alias[2];<=
br></blockquote><div><br></div><div>If `mem_alias` became an anonymous stru=
ct as well we could avoid fiddling with two indices in a matrix, lowering t=
he complexity.</div><div><br></div><div>Best regards,</div><div>Bernhard<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} bmdma[2];<br>
<br>
&gt;&gt; };<br>
&gt;&gt;<br>
&gt;&gt; #endif<br>
&gt; <br>
<br>
</blockquote></div></div>

--00000000000077776805fdfe5454--

