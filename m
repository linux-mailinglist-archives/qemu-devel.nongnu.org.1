Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E24997CB01E
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:46:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQj9-00055j-Vi; Mon, 16 Oct 2023 12:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1qsQiq-00055L-PF
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:45:40 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1qsQin-0005ZO-T0
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:45:40 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c51682fddeso22493661fa.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1697474734; x=1698079534;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mPsu11n6iqKViPVaFG0JRJRe+PVDwKUpn0230LRsElk=;
 b=yeeSIBjUO2wK9kx5ihvushaYGDiGEAJpVE1OyJu1VfDyUf1VApJn9GVJTv2peZitHZ
 RqHG7b5mjxmEjsXszJw/QNCeuur0UcnOc5y9Ebu6oTGrLgk1t8IJKUu5PH364Uk58jBt
 bSMhZQ+mlKdKkaxviDMGOxSutbqokl7aExP4moevJr6R7DUl9dfk0Bg7ckEDqaKcjZVl
 w19HS4cuZL8YnjHrpFU2NE5Wz6XEqu8q0Dsim/9L/Vg/GeVSOPB61OYdshmJndpSRVJ1
 DCPuH/KpEf05P+22CGLQlNFVhf0wdDVDkjzuIi/n6SkIhUCSnCdne97muHiJR46kFDjb
 HdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697474734; x=1698079534;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mPsu11n6iqKViPVaFG0JRJRe+PVDwKUpn0230LRsElk=;
 b=wAJE201WJ2Hu33gbd0yq6sSoqKo24uOJP5lGo7W87FHKDYE7QHwrNmWH7hOf+5X3+i
 4uErySM0hEaYvZsv0qHG2UfRD0XdczDww6rP/eODyKHtEBOcURbqX2qeL1+/eNc4k/MU
 AXwAdugmek4Jph7irx9VqhF8HxAb55LVV6xu6uaGl6Gj1sCSoQrZW/KdKWzvxzVXwF5P
 67bj4Ud01VtYl451N9Ny/tsZJi640tBgrmdm4uUiVwU+6Uq2KnOj3S7G0t9kwnj7lcEr
 WB5g7utuZo2RjJWebFe1Y/1mUZibdg/XkYY1rdjNv8slPoaJvQp6pNr1BZPLZCfkN0WM
 XUSw==
X-Gm-Message-State: AOJu0YyZhdMCWdVzxm8ZV1+JrJr3+vR9lfg4dJxZKNUCPRaYRXBp9zeO
 R4FoX+Go2Urj2nbdJFwjzrl01kaopdAluHG2o0tWbw==
X-Google-Smtp-Source: AGHT+IEZGhabQ8zWWhrCBijl9DNS+gwDQkZrhS2urjoRiWGb5T+arHcPnTslOIDcf+99KykJpqFZ3xT1CEYoS552+jM=
X-Received: by 2002:a2e:9911:0:b0:2c5:2d7:40b with SMTP id
 v17-20020a2e9911000000b002c502d7040bmr5315346lji.26.1697474733496; 
 Mon, 16 Oct 2023 09:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230922140914.13906-1-phil@philjordan.eu>
 <4319fcd1-981c-4ef0-b6b9-1f7f57c1c4ca@redhat.com>
In-Reply-To: <4319fcd1-981c-4ef0-b6b9-1f7f57c1c4ca@redhat.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Mon, 16 Oct 2023 18:45:22 +0200
Message-ID: <CAGCz3vuF1=Ee6_G+23QJD-u+-cY0jVJW8kz9Lrgz+KAoMMy1=w@mail.gmail.com>
Subject: Re: [PATCH 0/3] hvf x86 correctness and efficiency improvements
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, dirty@apple.com,
 qemu-devel@nongnu.org, rbolshakov@ddn.com
Content-Type: multipart/alternative; boundary="0000000000008174460607d822af"
Received-SPF: neutral client-ip=2a00:1450:4864:20::22c;
 envelope-from=lists@philjordan.eu; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--0000000000008174460607d822af
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,


On Mon, 16 Oct 2023 at 16:39, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 9/22/23 16:09, Phil Dennis-Jordan wrote:
> > Patch 1 enables the INVTSC CPUID bit when running with hvf. This can
> > enable some optimisations in the guest OS, and I've not found any reaso=
n
> > it shouldn't be allowed for hvf based hosts.
>
> It can be enabled, but it should include a migration blocker.  In fact,
> probably HVF itself should include a migration blocker because QEMU
> doesn't support TSC scaling.

I didn't think Qemu's HVF backend supported migration in any form at this
point anyway? Or do you mean machine model versioning of the default
setting?

> > Patch 2 fixes hvf_kick_vcpu_thread so it actually forces a VM exit
instead of
> > doing nothing. I guess this previously didn't cause any huge issues
because
> > hvf's hv_vcpu_run() would exit so extremely frequently on its own
accord.
>
> No, it's because signal delivery should already kick the vCPU out of
> guest mode.  I guess it does with hv_vcpu_run(), but not with
> hv_vcpu_run_until()?

It's possible! At any rate, hv_vcpu_run() only seems to run for VERY short
time slices in practice. I'll try gathering some data on exit reasons/kick
delivery latencies with the various combinations of kick methods and vcpu
run APIs if that helps.

> hv_vcpu_interrupt() is a problematic API, in that it is not clear how it
> handles races with hv_vcpu_run().  In particular, whether this causes an
> immediate vmexit or not:
>
>             thread 1                         thread 2
>             -----------------------          -----------------------
>                                              <CPU not in guest mode>
>             hv_vcpu_interrupt()
>                                              hv_vcpu_run() (or run_until)

Roman brought me up to speed on this issue in the thread here:
https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg02156.html
including a patch and discussion on the subject from 2020. I've now updated
Roman's old patch which addressed it thanks to your feedback at the time
but which never got merged. (Judging by the list archives, v4 just never
got reviewed.) Details on my latest progress here:

https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg04752.html


> Not that the current code is any better; there is no guarantee that the
> signal is delivered before hv_vcpu_run() is called.  However, if as you
> said hv_vcpu_run() will exit often on its own accord but
> hv_vcpu_run_until() does not, then this could cause difficult to
> reproduce bugs by switching to the latter.

At least with Roman's updated kick patch, according to tracing points I
inserted locally, I'm not seeing any slow or undelivered kicks with
hv_vcpu_run_until. However, I'm still observing the (S)VGA issues to which
Roman drew my attention at the same time, so I'm wondering if the issues
we're seeing with hv_vcpu_run_until aren't (all) related to interrupt
delivery. (To be clear, switching to hv_vcpu_run_until() WITHOUT
hv_vcpu_interrupt() causes some very obvious problems where the vCPU simply
doesn't exit at all for long periods.)

From my point of view, there are at least 2 strong incentives for switching
to hv_vcpu_run_until():

1. hv_vcpu_run() exits very frequently, and often there is actually nothing
for the VMM to do except call hv_vcpu_run() again. With Qemu's current hvf
backend, each exit causes a BQL acquisition, and VMs with a bunch of vCPUs
rapidly become limited by BQL contention according to my profiling.

2. The HVF in macOS 12 and newer contains an in-kernel APIC implementation,
in a similar vein to KVM=E2=80=99s kernel irqchip. This should further redu=
ce
apparent VM exits, but using it is conditional on using hv_vcpu_run_until()=
.
Calling hv_vcpu_run() errors out with that enabled. Integrating that into
Qemu is still a work in progress, but I=E2=80=99ve got pretty far. (most of=
 the
APIC and IOAPIC suites in kvm-unit-tests pass)

For those 2 reasons I=E2=80=99m pretty motivated to make things work with
hv_vcpu_run_until()
one way or another.

> > The temp variable is needed because the pointer expected by the
hv_vcpu_interrupt()
> > call doesn't match the fd field's type in the hvf accel's struct
AccelCPUState.
> > I'm unsure if it would be better to change that struct field to the
relevant
> > architecture's handle types, hv_vcpuid_t (x86, unsigned int) and
hv_vcpu_t
> > (aarch64, uint64_t), perhaps via an intermediate typedef?
>
> I think fd and the HVF type should be placed in an anonymous union.

That=E2=80=99s a good idea, I=E2=80=99ll put a patch together doing exactly=
 that.

Thanks,
Phil

--0000000000008174460607d822af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Paolo,</div><div><br>
<br>
On Mon, 16 Oct 2023 at 16:39, Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@=
redhat.com" target=3D"_blank">pbonzini@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On 9/22/23 16:09, Phil Dennis-Jordan wrote:<br>
&gt; &gt; Patch 1 enables the INVTSC CPUID bit when running with hvf. This =
can<br>
&gt; &gt; enable some optimisations in the guest OS, and I&#39;ve not found=
 any reason<br>
&gt; &gt; it shouldn&#39;t be allowed for hvf based hosts.<br>
&gt;<br>
&gt; It can be enabled, but it should include a migration blocker.=C2=A0 In=
 fact,<br>
&gt; probably HVF itself should include a migration blocker because QEMU<br=
>
&gt; doesn&#39;t support TSC scaling.<br>
<br></div><div dir=3D"auto">
I didn&#39;t think Qemu&#39;s HVF backend supported migration in any form a=
t this point anyway? Or do you mean machine model versioning of the default=
 setting?</div><div>
<br>
&gt; &gt; Patch 2 fixes hvf_kick_vcpu_thread so it actually forces a VM exi=
t instead of<br>
&gt; &gt; doing nothing. I guess this previously didn&#39;t cause any huge =
issues because<br>
&gt; &gt; hvf&#39;s hv_vcpu_run() would exit so extremely frequently on its=
 own accord.<br>
&gt;<br>
&gt; No, it&#39;s because signal delivery should already kick the vCPU out =
of<br>
&gt; guest mode.=C2=A0 I guess it does with hv_vcpu_run(), but not with<br>
&gt; hv_vcpu_run_until()?<br>
<br></div><div dir=3D"auto">
It&#39;s possible! At any rate, hv_vcpu_run() only seems to run for VERY sh=
ort time slices in practice. I&#39;ll try gathering some data on exit reaso=
ns/kick delivery latencies with the various combinations of kick methods an=
d vcpu run APIs if that helps.</div><div>
<br>
&gt; hv_vcpu_interrupt() is a problematic API, in that it is not clear how =
it<br>
&gt; handles races with hv_vcpu_run().=C2=A0 In particular, whether this ca=
uses an<br>
&gt; immediate vmexit or not:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0thread 1=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0thread 2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-----------------------=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -----------------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &lt;CPU not in guest mode&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hv_vcpu_interrupt()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 hv_vcpu_run() (or run_until)<br>
<br></div><div>
Roman brought me up to speed on this issue in the thread here: <a href=3D"h=
ttps://lists.gnu.org/archive/html/qemu-devel/2023-10/msg02156.html" rel=3D"=
noreferrer" target=3D"_blank">https://lists.gnu.org/archive/html/qemu-devel=
/2023-10/msg02156.html</a> including a patch and discussion on the subject =
from 2020. I&#39;ve now updated Roman&#39;s old patch which addressed it th=
anks to your feedback at the time but which never got merged. (Judging by t=
he list archives, v4 just never got reviewed.) Details on my latest progres=
s here:<br>
<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg04752.h=
tml" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archive/htm=
l/qemu-devel/2023-10/msg04752.html</a></div><div><br>
<br>
&gt; Not that the current code is any better; there is no guarantee that th=
e<br>
&gt; signal is delivered before hv_vcpu_run() is called.=C2=A0 However, if =
as you<br>
&gt; said hv_vcpu_run() will exit often on its own accord but<br>
&gt; hv_vcpu_run_until() does not, then this could cause difficult to<br>
&gt; reproduce bugs by switching to the latter.<br>
<br></div><div>
At least with Roman&#39;s updated kick patch, according to tracing points I=
 inserted locally, I&#39;m not seeing any slow or undelivered kicks with hv=
_vcpu_run_until. However, I&#39;m still observing the (S)VGA issues to whic=
h Roman drew my attention at the same time, so I&#39;m wondering if the iss=
ues we&#39;re seeing with hv_vcpu_run_until aren&#39;t (all) related to int=
errupt delivery. (To be clear, switching to hv_vcpu_run_until() WITHOUT hv_=
vcpu_interrupt() causes some very obvious problems where the vCPU simply do=
esn&#39;t exit at all for long periods.)<br>
<br>
From my point of view, there are at least 2 strong incentives for switching=
 to hv_vcpu_run_until():<br><br></div><div dir=3D"auto">
1. hv_vcpu_run() exits very frequently, and often there is actually nothing=
 for the VMM to do except call hv_vcpu_run() again. With Qemu&#39;s current=
 hvf backend, each exit causes a BQL acquisition, and VMs with a bunch of v=
CPUs rapidly become limited by BQL contention according to my profiling.<br=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">2. The HVF in macOS 12=
 and newer contains an in-kernel APIC implementation, in a similar vein to =
KVM=E2=80=99s kernel irqchip. This should further reduce apparent VM exits,=
 but using it is conditional on using=C2=A0<span style=3D"background-color:=
rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">hv_vcpu_run_until()=
. Calling=C2=A0</span><span style=3D"background-color:rgba(0,0,0,0);border-=
color:rgb(0,0,0);color:rgb(0,0,0)">hv_vcpu_run() errors out with that enabl=
ed. Integrating that into Qemu is still a work in progress, but I=E2=80=99v=
e got pretty far. (most of the APIC and IOAPIC suites in kvm-unit-tests pas=
s)</span></div><div dir=3D"auto"><span style=3D"background-color:rgba(0,0,0=
,0);border-color:rgb(0,0,0);color:rgb(0,0,0)"><br></span></div><div dir=3D"=
auto"><span style=3D"background-color:rgba(0,0,0,0);border-color:rgb(0,0,0)=
;color:rgb(0,0,0)">For those 2 reasons I=E2=80=99m pretty motivated to make=
 things work with=C2=A0</span><span style=3D"background-color:rgba(0,0,0,0)=
;border-color:rgb(0,0,0);color:rgb(0,0,0)">hv_vcpu_run_until() one way or a=
nother.</span></div><div dir=3D"auto">
<br>
&gt; &gt; The temp variable is needed because the pointer expected by the h=
v_vcpu_interrupt()<br>
&gt; &gt; call doesn&#39;t match the fd field&#39;s type in the hvf accel&#=
39;s struct AccelCPUState.<br>
&gt; &gt; I&#39;m unsure if it would be better to change that struct field =
to the relevant<br>
&gt; &gt; architecture&#39;s handle types, hv_vcpuid_t (x86, unsigned int) =
and hv_vcpu_t<br>
&gt; &gt; (aarch64, uint64_t), perhaps via an intermediate typedef?<br>
&gt;<br>
&gt; I think fd and the HVF type should be placed in an anonymous union.<br=
><br>
</div><div dir=3D"auto">That=E2=80=99s a good idea, I=E2=80=99ll put a patc=
h together doing exactly that.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Thanks,</div><div dir=3D"auto">Phil</div>

--0000000000008174460607d822af--

