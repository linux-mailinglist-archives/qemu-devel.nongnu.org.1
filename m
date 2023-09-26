Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A44827AF002
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 17:53:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAMw-0003kD-KO; Tue, 26 Sep 2023 11:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qlAMq-0003ju-O0
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:52:57 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qlAMn-0006AT-QJ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:52:56 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9ad8bba8125so1204001666b.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695743571; x=1696348371;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BFaVUZW49P+IElwolKNu0dOJlugGOJpps57+paXb8Mw=;
 b=ZoHIKMTaibuc8cv0W9yyiA1UPI/5ZTohuuV5buNtMGmR1tAFfg/T9DGdo1dKzrqBoP
 +mwgghSJf5QEgWA/mjHVbjd3PQhi/RfBLaMh4CnT8k2h3Jg4XcltFBDAx+qEvPGnZeVp
 MpeEGtqxUHRY59WN6jsQi/c5vwEDr+tiqk+fPDRrcuGanUk04swM8UH5zdvTP5+wTZzb
 HqRy2LpjylWO/LkIr4W4Y8zpxw/MJIitTqAQGIHeQUOq088wUB0ChA8u0eSyKcz6ruqz
 ZGMOGf4hE78vwI+V9RBAB2VIUuMguagpFh7Ii2IvS0n3fVzlqVTyGkBofhCyUsxuLMrf
 HY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695743571; x=1696348371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BFaVUZW49P+IElwolKNu0dOJlugGOJpps57+paXb8Mw=;
 b=uzqwUw6/YXbZgpbkg55CXzPgZJMmoyBI19iVd3kGnjRqMQRGciIDITWEMEk8d0i66Y
 +kFH50WSm0yD93RfS3QK4uAUxkNtdUd5q10EGy3bczKGRDPPZv3rBtf/8JrwTnrKLam7
 6yootp7YWup3nKlDMxMPlQ9UEPE8NtKMlytx9x6nOHPIb9P/+tjtrUze8UlzIww3b70C
 JybNF6xVSChj1LW0d4mYBRzfiPWWGLVr24IjRlj/4ckDMvCko6GePANmJGToGPekcRpy
 Bnm0GKpviNUTGRJSmoIhMfJiPZ20zcd1Ee78vtxTWM0wxWkHsL4asgwqT3sfgfAAJEJO
 A8sQ==
X-Gm-Message-State: AOJu0YwlIhBIwduLLPiVDFov3nSY0wD7Gvuab2WTsFLpZTk2DZxvjxSV
 1BCzGpD4viMuaEiRvZWL0Mi8GPNlCrDxqd5GGokUww==
X-Google-Smtp-Source: AGHT+IHo68julc4xaY2UoHEBHpAamo8jJ3xpTcuW2TT5aWnN3W8gyAo2M+CK3dxg70Jg3UnvccV+BXppkZqnUK6S+N8=
X-Received: by 2002:a17:907:7818:b0:9ae:654d:5105 with SMTP id
 la24-20020a170907781800b009ae654d5105mr9618641ejc.47.1695743571154; Tue, 26
 Sep 2023 08:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <87y1gtnggy.fsf@pond.sub.org>
In-Reply-To: <87y1gtnggy.fsf@pond.sub.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 26 Sep 2023 09:52:39 -0600
Message-ID: <CANCZdfoaEuOQkeRsdBYuwer2mU6=J4RQ9Vnt5JWQB=T6-q_eRA@mail.gmail.com>
Subject: Re: [v2] Help wanted for enabling -Wshadow=local
To: Markus Armbruster <armbru@redhat.com>
Cc: Brian Cain <bcain@quicinc.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: multipart/alternative; boundary="0000000000003070f50606451111"
Received-SPF: none client-ip=2a00:1450:4864:20::631;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x631.google.com
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

--0000000000003070f50606451111
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 8:43=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Brian, Gerd, Jason, Marc-Andr=C3=A9, Michael, we need your help to enable
> -Wshadow=3Dlocal.
>
> Paolo, you already took care of several subsystems (thanks!), except you
> left a few warnings in target/i386/tcg/seg_helper.c.
>
>
> Local variables shadowing other local variables or parameters make the
> code needlessly hard to understand.  Bugs love to hide in such code.
> Evidence: "[PATCH v3 1/7] migration/rdma: Fix save_page method to fail
> on polling error".
>
> Enabling -Wshadow would prevent bugs like this one.  But we have to
> clean up all the offenders first.
>
> People responded quickly to my first call for help.  Thank you so much!
>
> I'm collecting patches in my git repo at
> https://repo.or.cz/qemu/armbru.git in branch shadow-next, output of
> git-shortlog appended.  I'm happy to do pull requests.  I don't mind
> maintainers merging patches for their subsystems; interference should be
> minimal.
>
> My test build is down to 19 files with warnings.  Sorted by subsystems,
> files covered by multiple subsystems marked "(*NUMBER*)":
>

Please make sure it's disabled for the bsd-user build. I have 3 patches in
my queue
to fix that, but I'm recovering from an illness and trying to land a large
number of patches
from my gsoc student Karim and git publish is being a pain. If this can
wait a week, I'll
likely be better enough by then and can submit the patches. They are all
trivial, but one
depends on the tcg header cleanups.

Thanks

Warner


> Guest CPU cores (TCG)
> ---------------------
> Hexagon TCG CPUs
> M: Brian Cain <bcain@quicinc.com>
>     target/hexagon/gen_helper_funcs.py
>     target/hexagon/mmvec/macros.h
>     target/hexagon/op_helper.c
>     target/hexagon/translate.c
>
> X86 TCG CPUs
> M: Paolo Bonzini <pbonzini@redhat.com>
> M: Richard Henderson <richard.henderson@linaro.org>
> M: Eduardo Habkost <eduardo@habkost.net>
>     target/i386/tcg/seg_helper.c
>
> Devices
> -------
> Network devices
> M: Jason Wang <jasowang@redhat.com>
>     hw/net/vhost_net.c(*2*)
>
> USB
> M: Gerd Hoffmann <kraxel@redhat.com>
>     hw/usb/desc.c
>     hw/usb/dev-hub.c
>     hw/usb/dev-storage.c
>     hw/usb/hcd-xhci.c
>     hw/usb/host-libusb.c
>
> vhost
> M: Michael S. Tsirkin <mst@redhat.com>
>     contrib/vhost-user-gpu/vhost-user-gpu.c(*2*)
>     contrib/vhost-user-gpu/vugpu.h(*2*)
>     hw/net/vhost_net.c(*2*)
>     hw/virtio/vhost.c
>
> virtio
> M: Michael S. Tsirkin <mst@redhat.com>
>     hw/virtio/virtio-pci.c
>     include/hw/virtio/virtio-gpu.h(*2*)
>
> virtio-gpu
> M: Gerd Hoffmann <kraxel@redhat.com>
>     include/hw/virtio/virtio-gpu.h(*2*)
>
> vhost-user-gpu
> M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> R: Gerd Hoffmann <kraxel@redhat.com>
>     contrib/vhost-user-gpu/vhost-user-gpu.c(*2*)
>     contrib/vhost-user-gpu/vugpu.h(*2*)
>
> Subsystems
> ----------
> Overall Audio backends
> M: Gerd Hoffmann <kraxel@redhat.com>
> M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>     audio/audio.c
>
> Open Sound System (OSS) Audio backend
> M: Gerd Hoffmann <kraxel@redhat.com>
>     audio/ossaudio.c
>
> Dump
> M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>     dump/dump.c
>
>
> Patches collected so far:
>
> Alberto Garcia (1):
>       test-throttle: don't shadow 'index' variable in do_test_accounting(=
)
>
> Alistair Francis (4):
>       hw/riscv: opentitan: Fixup local variables shadowing
>       target/riscv: cpu: Fixup local variables shadowing
>       target/riscv: vector_helper: Fixup local variables shadowing
>       softmmu/device_tree: Fixup local variables shadowing
>
> Ani Sinha (1):
>       hw/acpi: changes towards enabling -Wshadow=3Dlocal
>
> C=C3=A9dric Le Goater (13):
>       hw/ppc: Clean up local variable shadowing in _FDT helper routine
>       pnv/psi: Clean up local variable shadowing
>       spapr: Clean up local variable shadowing in spapr_dt_cpus()
>       spapr: Clean up local variable shadowing in spapr_init_cpus()
>       spapr: Clean up local variable shadowing in spapr_get_fw_dev_path()
>       spapr/drc: Clean up local variable shadowing in
> rtas_ibm_configure_connector()
>       spapr/pci: Clean up local variable shadowing in spapr_phb_realize()
>       spapr/drc: Clean up local variable shadowing in prop_get_fdt()
>       aspeed/i2c: Clean up local variable shadowing
>       aspeed: Clean up local variable shadowing
>       aspeed/i3c: Rename variable shadowing a local
>       aspeed/timer: Clean up local variable shadowing
>       target/ppc: Rename variables to avoid local variable shadowing in
> VUPKPX
>
> Daniel P. Berrang=C3=A9 (2):
>       crypto: remove shadowed 'ret' variable
>       seccomp: avoid shadowing of 'action' variable
>
> Eric Blake (1):
>       qemu-nbd: changes towards enabling -Wshadow=3Dlocal
>
> Klaus Jensen (1):
>       hw/nvme: Clean up local variable shadowing in nvme_ns_init()
>
> Laurent Vivier (1):
>       disas/m68k: clean up local variable shadowing
>
> Markus Armbruster (8):
>       meson: Enable -Wshadow as a warning
>       migration/rdma: Fix save_page method to fail on polling error
>       migration: Clean up local variable shadowing
>       ui: Clean up local variable shadowing
>       block/dirty-bitmap: Clean up local variable shadowing
>       block/vdi: Clean up local variable shadowing
>       block: Clean up local variable shadowing
>       qobject atomics osdep: Make a few macros more hygienic
>
> Paolo Bonzini (8):
>       mptsas: avoid shadowed local variables
>       pm_smbus: rename variable to avoid shadowing
>       vl: remove shadowed local variables
>       target/i386/kvm: eliminate shadowed local variables
>       target/i386/cpu: avoid shadowed local variables
>       target/i386/translate: avoid shadowed local variables
>       target/i386/svm_helper: eliminate duplicate local variable
>       target/i386/seg_helper: remove shadowed variable
>
> Peter Maydell (4):
>       hw/intc/arm_gicv3_its: Avoid shadowing variable in
> do_process_its_cmd()
>       hw/misc/arm_sysctl.c: Avoid shadowing local variable
>       hw/arm/smmuv3.c: Avoid shadowing variable
>       hw/arm/smmuv3-internal.h: Don't use locals in statement macros
>
> Peter Xu (1):
>       intel_iommu: Fix shadow local variables on "size"
>
> Philippe Mathieu-Daud=C3=A9 (23):
>       tcg: Clean up local variable shadowing
>       target/arm/tcg: Clean up local variable shadowing
>       target/arm/hvf: Clean up local variable shadowing
>       target/mips: Clean up local variable shadowing
>       target/m68k: Clean up local variable shadowing
>       target/tricore: Clean up local variable shadowing
>       hw/arm/armv7m: Clean up local variable shadowing
>       hw/arm/virt: Clean up local variable shadowing
>       hw/arm/allwinner: Clean up local variable shadowing
>       hw/ide/ahci: Clean up local variable shadowing
>       hw/m68k: Clean up local variable shadowing
>       hw/microblaze: Clean up local variable shadowing
>       hw/nios2: Clean up local variable shadowing
>       net/eth: Clean up local variable shadowing
>       crypto/cipher-gnutls.c: Clean up local variable shadowing
>       util/vhost-user-server: Clean up local variable shadowing
>       semihosting/arm-compat: Clean up local variable shadowing
>       linux-user/strace: Clean up local variable shadowing
>       sysemu/device_tree: Clean up local variable shadowing
>       softmmu/memory: Clean up local variable shadowing
>       softmmu/physmem: Clean up local variable shadowing
>       hw/core/machine: Clean up local variable shadowing
>       hw/intc/openpic: Clean up local variable shadowing
>
>
>

--0000000000003070f50606451111
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 26, 2023 at 8:43=E2=80=AF=
AM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Brian, Gerd, Jason, Marc-Andr=C3=A9, Michael, we need your help to enab=
le<br>
-Wshadow=3Dlocal.<br>
<br>
Paolo, you already took care of several subsystems (thanks!), except you<br=
>
left a few warnings in target/i386/tcg/seg_helper.c.<br>
<br>
<br>
Local variables shadowing other local variables or parameters make the<br>
code needlessly hard to understand.=C2=A0 Bugs love to hide in such code.<b=
r>
Evidence: &quot;[PATCH v3 1/7] migration/rdma: Fix save_page method to fail=
<br>
on polling error&quot;.<br>
<br>
Enabling -Wshadow would prevent bugs like this one.=C2=A0 But we have to<br=
>
clean up all the offenders first.<br>
<br>
People responded quickly to my first call for help.=C2=A0 Thank you so much=
!<br>
<br>
I&#39;m collecting patches in my git repo at<br>
<a href=3D"https://repo.or.cz/qemu/armbru.git" rel=3D"noreferrer" target=3D=
"_blank">https://repo.or.cz/qemu/armbru.git</a> in branch shadow-next, outp=
ut of<br>
git-shortlog appended.=C2=A0 I&#39;m happy to do pull requests.=C2=A0 I don=
&#39;t mind<br>
maintainers merging patches for their subsystems; interference should be<br=
>
minimal.<br>
<br>
My test build is down to 19 files with warnings.=C2=A0 Sorted by subsystems=
,<br>
files covered by multiple subsystems marked &quot;(*NUMBER*)&quot;:<br></bl=
ockquote><div><br></div><div>Please make sure it&#39;s disabled for the bsd=
-user build. I have 3 patches in my queue</div><div>to fix that, but I&#39;=
m recovering from an illness and trying to land a large number of patches</=
div><div>from my gsoc student Karim and git publish is being a pain. If thi=
s can wait a week, I&#39;ll</div><div>likely be better enough by then and c=
an submit the patches. They are all trivial, but one</div><div>depends on t=
he tcg header cleanups.</div><div><br></div><div>Thanks</div><div><br></div=
><div>Warner<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
Guest CPU cores (TCG)<br>
---------------------<br>
Hexagon TCG CPUs<br>
M: Brian Cain &lt;<a href=3D"mailto:bcain@quicinc.com" target=3D"_blank">bc=
ain@quicinc.com</a>&gt;<br>
=C2=A0 =C2=A0 target/hexagon/gen_helper_funcs.py<br>
=C2=A0 =C2=A0 target/hexagon/mmvec/macros.h<br>
=C2=A0 =C2=A0 target/hexagon/op_helper.c<br>
=C2=A0 =C2=A0 target/hexagon/translate.c<br>
<br>
X86 TCG CPUs<br>
M: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blan=
k">pbonzini@redhat.com</a>&gt;<br>
M: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org" ta=
rget=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
M: Eduardo Habkost &lt;<a href=3D"mailto:eduardo@habkost.net" target=3D"_bl=
ank">eduardo@habkost.net</a>&gt;<br>
=C2=A0 =C2=A0 target/i386/tcg/seg_helper.c<br>
<br>
Devices<br>
-------<br>
Network devices<br>
M: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">=
jasowang@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 hw/net/vhost_net.c(*2*)<br>
<br>
USB<br>
M: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank"=
>kraxel@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 hw/usb/desc.c<br>
=C2=A0 =C2=A0 hw/usb/dev-hub.c<br>
=C2=A0 =C2=A0 hw/usb/dev-storage.c<br>
=C2=A0 =C2=A0 hw/usb/hcd-xhci.c<br>
=C2=A0 =C2=A0 hw/usb/host-libusb.c<br>
<br>
vhost<br>
M: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blan=
k">mst@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 contrib/vhost-user-gpu/vhost-user-gpu.c(*2*)<br>
=C2=A0 =C2=A0 contrib/vhost-user-gpu/vugpu.h(*2*)<br>
=C2=A0 =C2=A0 hw/net/vhost_net.c(*2*)<br>
=C2=A0 =C2=A0 hw/virtio/vhost.c<br>
<br>
virtio<br>
M: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blan=
k">mst@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 hw/virtio/virtio-pci.c<br>
=C2=A0 =C2=A0 include/hw/virtio/virtio-gpu.h(*2*)<br>
<br>
virtio-gpu<br>
M: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank"=
>kraxel@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 include/hw/virtio/virtio-gpu.h(*2*)<br>
<br>
vhost-user-gpu<br>
M: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com=
" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
R: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank"=
>kraxel@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 contrib/vhost-user-gpu/vhost-user-gpu.c(*2*)<br>
=C2=A0 =C2=A0 contrib/vhost-user-gpu/vugpu.h(*2*)<br>
<br>
Subsystems<br>
----------<br>
Overall Audio backends<br>
M: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank"=
>kraxel@redhat.com</a>&gt;<br>
M: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com=
" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 audio/audio.c<br>
<br>
Open Sound System (OSS) Audio backend<br>
M: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank"=
>kraxel@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 audio/ossaudio.c<br>
<br>
Dump<br>
M: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com=
" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 dump/dump.c<br>
<br>
<br>
Patches collected so far:<br>
<br>
Alberto Garcia (1):<br>
=C2=A0 =C2=A0 =C2=A0 test-throttle: don&#39;t shadow &#39;index&#39; variab=
le in do_test_accounting()<br>
<br>
Alistair Francis (4):<br>
=C2=A0 =C2=A0 =C2=A0 hw/riscv: opentitan: Fixup local variables shadowing<b=
r>
=C2=A0 =C2=A0 =C2=A0 target/riscv: cpu: Fixup local variables shadowing<br>
=C2=A0 =C2=A0 =C2=A0 target/riscv: vector_helper: Fixup local variables sha=
dowing<br>
=C2=A0 =C2=A0 =C2=A0 softmmu/device_tree: Fixup local variables shadowing<b=
r>
<br>
Ani Sinha (1):<br>
=C2=A0 =C2=A0 =C2=A0 hw/acpi: changes towards enabling -Wshadow=3Dlocal<br>
<br>
C=C3=A9dric Le Goater (13):<br>
=C2=A0 =C2=A0 =C2=A0 hw/ppc: Clean up local variable shadowing in _FDT help=
er routine<br>
=C2=A0 =C2=A0 =C2=A0 pnv/psi: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 spapr: Clean up local variable shadowing in spapr_dt_c=
pus()<br>
=C2=A0 =C2=A0 =C2=A0 spapr: Clean up local variable shadowing in spapr_init=
_cpus()<br>
=C2=A0 =C2=A0 =C2=A0 spapr: Clean up local variable shadowing in spapr_get_=
fw_dev_path()<br>
=C2=A0 =C2=A0 =C2=A0 spapr/drc: Clean up local variable shadowing in rtas_i=
bm_configure_connector()<br>
=C2=A0 =C2=A0 =C2=A0 spapr/pci: Clean up local variable shadowing in spapr_=
phb_realize()<br>
=C2=A0 =C2=A0 =C2=A0 spapr/drc: Clean up local variable shadowing in prop_g=
et_fdt()<br>
=C2=A0 =C2=A0 =C2=A0 aspeed/i2c: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 aspeed: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 aspeed/i3c: Rename variable shadowing a local<br>
=C2=A0 =C2=A0 =C2=A0 aspeed/timer: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 target/ppc: Rename variables to avoid local variable s=
hadowing in VUPKPX<br>
<br>
Daniel P. Berrang=C3=A9 (2):<br>
=C2=A0 =C2=A0 =C2=A0 crypto: remove shadowed &#39;ret&#39; variable<br>
=C2=A0 =C2=A0 =C2=A0 seccomp: avoid shadowing of &#39;action&#39; variable<=
br>
<br>
Eric Blake (1):<br>
=C2=A0 =C2=A0 =C2=A0 qemu-nbd: changes towards enabling -Wshadow=3Dlocal<br=
>
<br>
Klaus Jensen (1):<br>
=C2=A0 =C2=A0 =C2=A0 hw/nvme: Clean up local variable shadowing in nvme_ns_=
init()<br>
<br>
Laurent Vivier (1):<br>
=C2=A0 =C2=A0 =C2=A0 disas/m68k: clean up local variable shadowing<br>
<br>
Markus Armbruster (8):<br>
=C2=A0 =C2=A0 =C2=A0 meson: Enable -Wshadow as a warning<br>
=C2=A0 =C2=A0 =C2=A0 migration/rdma: Fix save_page method to fail on pollin=
g error<br>
=C2=A0 =C2=A0 =C2=A0 migration: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 ui: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 block/dirty-bitmap: Clean up local variable shadowing<=
br>
=C2=A0 =C2=A0 =C2=A0 block/vdi: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 block: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 qobject atomics osdep: Make a few macros more hygienic=
<br>
<br>
Paolo Bonzini (8):<br>
=C2=A0 =C2=A0 =C2=A0 mptsas: avoid shadowed local variables<br>
=C2=A0 =C2=A0 =C2=A0 pm_smbus: rename variable to avoid shadowing<br>
=C2=A0 =C2=A0 =C2=A0 vl: remove shadowed local variables<br>
=C2=A0 =C2=A0 =C2=A0 target/i386/kvm: eliminate shadowed local variables<br=
>
=C2=A0 =C2=A0 =C2=A0 target/i386/cpu: avoid shadowed local variables<br>
=C2=A0 =C2=A0 =C2=A0 target/i386/translate: avoid shadowed local variables<=
br>
=C2=A0 =C2=A0 =C2=A0 target/i386/svm_helper: eliminate duplicate local vari=
able<br>
=C2=A0 =C2=A0 =C2=A0 target/i386/seg_helper: remove shadowed variable<br>
<br>
Peter Maydell (4):<br>
=C2=A0 =C2=A0 =C2=A0 hw/intc/arm_gicv3_its: Avoid shadowing variable in do_=
process_its_cmd()<br>
=C2=A0 =C2=A0 =C2=A0 hw/misc/arm_sysctl.c: Avoid shadowing local variable<b=
r>
=C2=A0 =C2=A0 =C2=A0 hw/arm/smmuv3.c: Avoid shadowing variable<br>
=C2=A0 =C2=A0 =C2=A0 hw/arm/smmuv3-internal.h: Don&#39;t use locals in stat=
ement macros<br>
<br>
Peter Xu (1):<br>
=C2=A0 =C2=A0 =C2=A0 intel_iommu: Fix shadow local variables on &quot;size&=
quot;<br>
<br>
Philippe Mathieu-Daud=C3=A9 (23):<br>
=C2=A0 =C2=A0 =C2=A0 tcg: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 target/arm/tcg: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 target/arm/hvf: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 target/mips: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 target/m68k: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 target/tricore: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 hw/arm/armv7m: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 hw/arm/virt: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 hw/arm/allwinner: Clean up local variable shadowing<br=
>
=C2=A0 =C2=A0 =C2=A0 hw/ide/ahci: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 hw/m68k: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 hw/microblaze: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 hw/nios2: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 net/eth: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 crypto/cipher-gnutls.c: Clean up local variable shadow=
ing<br>
=C2=A0 =C2=A0 =C2=A0 util/vhost-user-server: Clean up local variable shadow=
ing<br>
=C2=A0 =C2=A0 =C2=A0 semihosting/arm-compat: Clean up local variable shadow=
ing<br>
=C2=A0 =C2=A0 =C2=A0 linux-user/strace: Clean up local variable shadowing<b=
r>
=C2=A0 =C2=A0 =C2=A0 sysemu/device_tree: Clean up local variable shadowing<=
br>
=C2=A0 =C2=A0 =C2=A0 softmmu/memory: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 softmmu/physmem: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 hw/core/machine: Clean up local variable shadowing<br>
=C2=A0 =C2=A0 =C2=A0 hw/intc/openpic: Clean up local variable shadowing<br>
<br>
<br>
</blockquote></div></div>

--0000000000003070f50606451111--

