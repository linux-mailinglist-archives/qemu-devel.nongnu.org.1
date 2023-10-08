Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFE77BCFA3
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 20:40:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpYgY-0003vh-2m; Sun, 08 Oct 2023 14:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1qpYgV-0003vQ-Hz
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 14:39:23 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1qpYgT-0007Rn-E7
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 14:39:23 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a2536adaf3so46487897b3.2
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 11:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1696790359; x=1697395159;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x05GkkRkMVwLJeJT/sRxmBSOBuzhZ4q1uvQvt27nLNc=;
 b=aGz/pFC3hoxWNGtBEtjC8LNlW/Wso9hf/tocnfNjfygmRVZlWIl/4arNpB1zJWvxeR
 jFlzr51Vb/blnwiqfN9TDbsl+VhCszPPRyd/f4jbTUSLideFtDfGQ6nOhDhyb24II3Tm
 Kq21DQu+tLUaMraSZasaAA/BpASPnLqAWfBZ7LG5/yzx7ACUsVev/fflX2zYUCZl19nc
 LyACnk2uQSY5QziawjL95hH+A3EIaGoBQTeWSXBMObmF+4ATP3QZKALS4iNpJuA/RxVO
 D0eAWSQnW13K8TsK9D4RjFaoYHa+cIOlspZAQ1s5Bi0xQAJc/b2A0Zvayj/WO9UOe85l
 DGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696790359; x=1697395159;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x05GkkRkMVwLJeJT/sRxmBSOBuzhZ4q1uvQvt27nLNc=;
 b=CyDzYXBvB4gyDH0s+Lq9dYocKZaNfcjy6Y9aLE1ZnTCfVwrNoNiZ9S4WYhDo1mRhdc
 ODLtxuBaJmVO/ExzXHW4v9aPAs0gpzFvzVffizpMajRWU+Pm9oiB4QaSwxQhCry6AryP
 orycqdPWSJqaZPk8Dhy4gVLT7M/YBokCVdykSj1f4ETMAzkkAp6TeBAIG4ISM/gcQaBK
 klTmBnWrJfyeys3vNhoyVEV8xfJxPJFrKfrXG8LK98Cbu0dQrGEd4EE9fIqu2kNOE0CL
 KqRd39qpGeEaXGfrbL3Z0z4irHBBZw5gBF/R6Gi3tRajmSZk8GQCfSOQJ2iBLwNd9oG6
 fVTw==
X-Gm-Message-State: AOJu0YxHkXSIJFYa/aU/ZAaiZ9SQlo7+wlpOCEuodImtQ5udIiuWYDxv
 516tMYeNhNSq0VCyOhpmGmwIXEXXPuph50n8jgzR/w==
X-Google-Smtp-Source: AGHT+IG8WfTk3txnaiQHbUPI9m1xN0k4MBhg8+kF6rMHnVwDruhNbrgrbwP3g7x7XQ0vvskZPMICS48Ub1cwyj2XVTY=
X-Received: by 2002:a05:6902:18b:b0:d6e:3544:9871 with SMTP id
 t11-20020a056902018b00b00d6e35449871mr11435399ybh.44.1696790359399; Sun, 08
 Oct 2023 11:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230922140914.13906-1-phil@philjordan.eu>
 <20230922140914.13906-3-phil@philjordan.eu>
 <ZSLzq33DgMNYBsQT@roolebo.dev>
In-Reply-To: <ZSLzq33DgMNYBsQT@roolebo.dev>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Sun, 8 Oct 2023 20:39:08 +0200
Message-ID: <CAAibmn35JypPWfUophMgONTkgbYFvaaRhuD9+1kif9EOFx9HxQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] i386: hvf: In kick_vcpu use hv_vcpu_interrupt to
 force exit
To: Roman Bolshakov <roman@roolebo.dev>
Cc: qemu-devel@nongnu.org, dirty@apple.com, rbolshakov@ddn.com, 
 lists@philjordan.eu
Content-Type: multipart/alternative; boundary="000000000000a17478060738cac6"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::1136;
 envelope-from=phil@philjordan.eu; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000a17478060738cac6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 8 Oct 2023 at 20:23, Roman Bolshakov <roman@roolebo.dev> wrote:

> On Fri, Sep 22, 2023 at 04:09:13PM +0200, Phil Dennis-Jordan wrote:
> > When interrupting a vCPU thread, this patch actually tells the
> hypervisor to
> > stop running guest code on that vCPU.
> >
> > Calling hv_vcpu_interrupt actually forces a vCPU exit, analogously to
> > hv_vcpus_exit on aarch64.
> >
> > Previously, hvf_kick_vcpu_thread relied upon hv_vcpu_run returning very
> > frequently, including many spurious exits, which made it less of a
> problem that
> > nothing was actively done to stop the vCPU thread running guest code.
> > The newer, more efficient hv_vcpu_run_until exits much more rarely, so =
a
> true
> > "kick" is needed.
> >
>

Hi Roman,

Thanks for the review and test of this patch and the preceding one!


> I see severe performance regression with the patch on a Windows XP
> guest. The display is not refreshed properly like a broken LVDS panel,
> only some horizontal lines appear on it.


OK, that's interesting - I've been running into that sort of issue while
trying to integrate HVF's APIC implementation into Qemu. I assume that's
with patch 3/3 applied as well? The fact you've repro'd it with just these
patch would explain why I've not been able to fix it on the APIC side=E2=80=
=A6

My test laptop for x86 hvf is
> MBA 2015 with the latest Big Sur. What are you runing QEMU/HVF on?
>

Most of the testing has been with 2018 Mac Mini (Intel Coffee Lake) hosts
running Big Sur (11), Monterey (12), and Ventura (13), and using macOS
guests. I've also sanity-checked with a 2015 MBP (Broadwell) Monterey host
with various macOS guests as well as Linux and FreeBSD guests. Guess I
should have tried Windows guests too, sorry about the regression!


> FWIW. I recall a few years ago I submitted a similar patch that does
> something similar but addresses a few more issues:
>
> https://patchwork.kernel.org/project/qemu-devel/patch/20200729124832.7937=
5-1-r.bolshakov@yadro.com/
>
> I don't remember why it never got merged.
>

Looks like the VM kick might be a more complex undertaking than I was
anticipating. I'll try to repro the problem you ran into, and then look
over your original patch and make sense of it. Hopefully an updated version
of your 'kick' implementation will work well in combination with the
newer hv_vcpu_run_until() API from patch 3/3. I'll keep you posted.

Thanks again,
Phil

--000000000000a17478060738cac6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Sun, 8 Oct 2023 at 20:23, Roman Bolsha=
kov &lt;<a href=3D"mailto:roman@roolebo.dev">roman@roolebo.dev</a>&gt; wrot=
e:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Fri, Sep 22, 2023 at 04:09:13PM +0200, Phil Dennis-Jordan =
wrote:<br>
&gt; When interrupting a vCPU thread, this patch actually tells the hypervi=
sor to<br>
&gt; stop running guest code on that vCPU.<br>
&gt; <br>
&gt; Calling hv_vcpu_interrupt actually forces a vCPU exit, analogously to<=
br>
&gt; hv_vcpus_exit on aarch64.<br>
&gt; <br>
&gt; Previously, hvf_kick_vcpu_thread relied upon hv_vcpu_run returning ver=
y<br>
&gt; frequently, including many spurious exits, which made it less of a pro=
blem that<br>
&gt; nothing was actively done to stop the vCPU thread running guest code.<=
br>
&gt; The newer, more efficient hv_vcpu_run_until exits much more rarely, so=
 a true<br>
&gt; &quot;kick&quot; is needed.<br>
&gt;<br>
</blockquote><div><br></div><div><div dir=3D"ltr">Hi Roman,</div><div><br><=
/div><div>Thanks for the review and test of this patch and the preceding on=
e!</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
I see severe performance regression with the patch on a Windows XP<br>
guest. The display is not refreshed properly like a broken LVDS panel,<br>
only some horizontal lines appear on it.</blockquote><div><br></div><div>OK=
, that&#39;s interesting - I&#39;ve been running into that sort of issue wh=
ile trying to integrate HVF&#39;s APIC implementation into Qemu. I assume t=
hat&#39;s with patch 3/3 applied as well? The fact you&#39;ve repro&#39;d i=
t with just these patch would explain why I&#39;ve not been able to fix it =
on the APIC side=E2=80=A6</div><div><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"> My test laptop for x86 hvf is<br>
MBA 2015 with the latest Big Sur. What are you runing QEMU/HVF on?<br></blo=
ckquote><div><br></div><div>Most of the testing has been with 2018 Mac Mini=
 (Intel Coffee Lake) hosts running Big Sur (11), Monterey (12), and Ventura=
 (13), and using macOS guests. I&#39;ve also sanity-checked with a 2015 MBP=
 (Broadwell) Monterey host with various macOS guests as well as Linux and F=
reeBSD guests. Guess I should have tried Windows guests too, sorry about th=
e regression!</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
FWIW. I recall a few years ago I submitted a similar patch that does<br>
something similar but addresses a few more issues:<br>
<a href=3D"https://patchwork.kernel.org/project/qemu-devel/patch/2020072912=
4832.79375-1-r.bolshakov@yadro.com/" rel=3D"noreferrer" target=3D"_blank">h=
ttps://patchwork.kernel.org/project/qemu-devel/patch/20200729124832.79375-1=
-r.bolshakov@yadro.com/</a><br>
<br>
I don&#39;t remember why it never got merged.<br></blockquote><div><br></di=
v><div>Looks like the VM kick might be a more complex undertaking than I wa=
s anticipating. I&#39;ll try to repro the problem you ran into, and then lo=
ok over your original patch and make sense of it. Hopefully an updated vers=
ion of your &#39;kick&#39; implementation will work well in combination wit=
h the newer=C2=A0hv_vcpu_run_until() API from patch 3/3. I&#39;ll keep you =
posted.</div><div><br></div><div>Thanks again,</div><div>Phil</div><div><br=
></div></div></div>

--000000000000a17478060738cac6--

