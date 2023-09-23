Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A4E7ABE24
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 08:46:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjwOQ-00063B-5c; Sat, 23 Sep 2023 02:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qjwOM-00061G-5U
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 02:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qjwOK-0002KL-0U
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 02:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695451522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TCWr3Q+m0+yoocfKom/ZoXFffFGYPnSEzsg4wIRUFSI=;
 b=FHaM9KNp6uJ7Vv+4sohQxjNO+zapBcZ6URt/7WjQt4EHgvAu2Hza9HgzFmiZeXLF+maCy+
 S/hs8CjrOmB3puQyfkA/oi7a1S81tIrBElWxvsw0oA1/XfDSLeWb8VSXV5dcbWYEztT1nz
 RW9Mxvv9ksLo6Jo7aRy+drAEfSNlfhc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-DR0guO-zNN2yDllcCxP9dw-1; Sat, 23 Sep 2023 02:45:21 -0400
X-MC-Unique: DR0guO-zNN2yDllcCxP9dw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99bca0b9234so238204066b.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 23:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695451520; x=1696056320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TCWr3Q+m0+yoocfKom/ZoXFffFGYPnSEzsg4wIRUFSI=;
 b=P8mNLvIDykVTNrYObT+0u+qTGQUQEoNc+2Oj+ULFIDd5+AcQOsyDzDHhIanPHcvNmX
 gwu0+9gY1GMQiwcbybYCV99d+7VPtR5h0N8PlfGhYIFlZbwh2iCw4A9ongrVXrD/sYCm
 DNt1MeVQDIzWWDAfG9ZYSYntmwlRpiKbe+1Igrj8MoZFaCYwnV85DTGJVLDpqlrj3eBa
 SMXrSabKHnii6M+q2f8EZ1bWLbAHznJ+hTXnEH0cDaR02pHEHDu3AgHS3lOLboDWm8NN
 pJYEBYCNKPdBbjVqxcbu6Q6CD/PGW+Ep4cQsbPZ1Z1BihQDVi/jxIRaYHXxAQdEYEmZA
 yLSA==
X-Gm-Message-State: AOJu0YwW5ytycJd/v3OUPB+2Qi3WYbTpiZZtg0BJF8bnqUOzRGbf2lNg
 DU4ckqssq96YxPBWjzroje4MmTQt8t3Ym+BLj5u7w/Nr63I+ATWvcjL3gQ/0ZZoLm0gJ5ih6vAv
 u+4JnTtamDx49Tf77OMegeou+xkKktIM=
X-Received: by 2002:a17:906:8a64:b0:9ae:577b:caed with SMTP id
 hy4-20020a1709068a6400b009ae577bcaedmr1208897ejc.26.1695451520033; 
 Fri, 22 Sep 2023 23:45:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVY/NhtogggG7KyO7F18csFEqeZnOJ95u4joc1Vt0vSXoz1emyk1KePYq0SSEF0fCFTJLOCcgA3pUdzFUFd+g=
X-Received: by 2002:a17:906:8a64:b0:9ae:577b:caed with SMTP id
 hy4-20020a1709068a6400b009ae577bcaedmr1208878ejc.26.1695451519699; Fri, 22
 Sep 2023 23:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230922160413.165702-1-anisinha@redhat.com>
 <4535dfe6-a8cd-65e5-3079-498d04233750@linaro.org>
In-Reply-To: <4535dfe6-a8cd-65e5-3079-498d04233750@linaro.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Sat, 23 Sep 2023 12:15:07 +0530
Message-ID: <CAK3XEhO4A_K1Ho6Aq8Wxnmapt7DzcZBfP=uArybL4qkSZaxJOQ@mail.gmail.com>
Subject: Re: [PATCH v6] hw/i386/pc: improve physical address space bound check
 for 32-bit x86 systems
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000090dfc306060111d8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--00000000000090dfc306060111d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Sept, 2023, 10:25 pm Philippe Mathieu-Daud=C3=A9, <philmd@linaro=
.org>
wrote:

> On 22/9/23 18:04, Ani Sinha wrote:
> > 32-bit x86 systems do not have a reserved memory for hole64. On those
> 32-bit
> > systems without PSE36 or PAE CPU features, hotplugging memory devices
> are not
> > supported by QEMU as QEMU always places hotplugged memory above 4 GiB
> boundary
> > which is beyond the physical address space of the processor. Linux
> guests also
> > does not support memory hotplug on those systems. Please see Linux
> > kernel commit b59d02ed08690 ("mm/memory_hotplug: disable the
> functionality
> > for 32b") for more details.
> >
> > Therefore, the maximum limit of the guest physical address in the
> absence of
> > additional memory devices effectively coincides with the end of
> > "above 4G memory space" region for 32-bit x86 without PAE/PSE36. When
> users
> > configure additional memory devices, after properly accounting for the
> > additional device memory region to find the maximum value of the guest
> > physical address, the address will be outside the range of the
> processor's
> > physical address space.
> >
> > This change adds improvements to take above into consideration.
> >
> > For example, previously this was allowed:
> >
> > $ ./qemu-system-x86_64 -cpu pentium -m size=3D10G
> >
> > With this change now it is no longer allowed:
> >
> > $ ./qemu-system-x86_64 -cpu pentium -m size=3D10G
> > qemu-system-x86_64: Address space limit 0xffffffff < 0x2bfffffff
> phys-bits too low (32)
> >
> > However, the following are allowed since on both cases physical address
> > space of the processor is 36 bits:
> >
> > $ ./qemu-system-x86_64 -cpu pentium2 -m size=3D10G
> > $ ./qemu-system-x86_64 -cpu pentium,pse36=3Don -m size=3D10G
> >
> > For 32-bit, without PAE/PSE36, hotplugging additional memory is no
> longer allowed.
> >
> > $ ./qemu-system-i386 -m size=3D1G,maxmem=3D3G,slots=3D2
> > qemu-system-i386: Address space limit 0xffffffff < 0x1ffffffff phys-bit=
s
> too low (32)
> > $ ./qemu-system-i386 -machine q35 -m size=3D1G,maxmem=3D3G,slots=3D2
> > qemu-system-i386: Address space limit 0xffffffff < 0x1ffffffff phys-bit=
s
> too low (32)
> >
> > A new compatibility flag is introduced to make sure pc_max_used_gpa()
> keeps
> > returning the old value for machines 8.1 and older.
> > Therefore, the above is still allowed for older machine types in order
> to support
> > compatibility. Hence, the following still works:
> >
> > $ ./qemu-system-i386 -machine pc-i440fx-8.1 -m size=3D1G,maxmem=3D3G,sl=
ots=3D2
> > $ ./qemu-system-i386 -machine pc-q35-8.1 -m size=3D1G,maxmem=3D3G,slots=
=3D2
> >
> > Further, following is also allowed as with PSE36, the processor has
> 36-bit
> > address space:
> >
> > $ ./qemu-system-i386 -cpu 486,pse36=3Don -m size=3D1G,maxmem=3D3G,slots=
=3D2
> >
> > After calling CPUID with EAX=3D0x80000001, all AMD64 compliant processo=
rs
> > have the longmode-capable-bit turned on in the extended feature flags
> (bit 29)
> > in EDX. The absence of CPUID longmode can be used to differentiate
> between
> > 32-bit and 64-bit processors and is the recommended approach. QEMU take=
s
> this
> > approach elsewhere (for example, please see x86_cpu_realizefn()), With
> > this change, pc_max_used_gpa() also uses the same method to detect 32-b=
it
> > processors.
> >
> > Unit tests are modified to not run 32-bit x86 tests that use memory
> hotplug.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > ---
> >   hw/i386/pc.c                   | 32 +++++++++++++++++++++++++++++---
> >   hw/i386/pc_piix.c              |  4 ++++
> >   hw/i386/pc_q35.c               |  2 ++
> >   include/hw/i386/pc.h           |  6 ++++++
> >   tests/qtest/bios-tables-test.c | 26 ++++++++++++++++++--------
> >   tests/qtest/numa-test.c        |  7 ++++++-
> >   6 files changed, 65 insertions(+), 12 deletions(-)
> >
> > changelog:
> > v6: more code messaging. incorporated another of phil's suggestions.
>
> Thank you Ani, appreciated!
>

The code looks lot cleaner now. Thanks for the suggestions.

> v5: addressed phil's suggestions in code reorg to make it cleaner.
> > v4: address comments from v3. Fix a bug where compat knob was absent
> > from q35 machines. Commit message adjustment.
> > v3: still accounting for additional memory device region above 4G.
> > unit tests fixed (not running for 32-bit where mem hotplug is used).
> > v2: removed memory hotplug region from max_gpa. added compat knobs.
>
>

--00000000000090dfc306060111d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, 22 Sept, 2023, 10:25 pm Philippe Mathieu-Daud=
=C3=A9, &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">On 22/9/23 18:04, Ani Sinha =
wrote:<br>
&gt; 32-bit x86 systems do not have a reserved memory for hole64. On those =
32-bit<br>
&gt; systems without PSE36 or PAE CPU features, hotplugging memory devices =
are not<br>
&gt; supported by QEMU as QEMU always places hotplugged memory above 4 GiB =
boundary<br>
&gt; which is beyond the physical address space of the processor. Linux gue=
sts also<br>
&gt; does not support memory hotplug on those systems. Please see Linux<br>
&gt; kernel commit b59d02ed08690 (&quot;mm/memory_hotplug: disable the func=
tionality<br>
&gt; for 32b&quot;) for more details.<br>
&gt; <br>
&gt; Therefore, the maximum limit of the guest physical address in the abse=
nce of<br>
&gt; additional memory devices effectively coincides with the end of<br>
&gt; &quot;above 4G memory space&quot; region for 32-bit x86 without PAE/PS=
E36. When users<br>
&gt; configure additional memory devices, after properly accounting for the=
<br>
&gt; additional device memory region to find the maximum value of the guest=
<br>
&gt; physical address, the address will be outside the range of the process=
or&#39;s<br>
&gt; physical address space.<br>
&gt; <br>
&gt; This change adds improvements to take above into consideration.<br>
&gt; <br>
&gt; For example, previously this was allowed:<br>
&gt; <br>
&gt; $ ./qemu-system-x86_64 -cpu pentium -m size=3D10G<br>
&gt; <br>
&gt; With this change now it is no longer allowed:<br>
&gt; <br>
&gt; $ ./qemu-system-x86_64 -cpu pentium -m size=3D10G<br>
&gt; qemu-system-x86_64: Address space limit 0xffffffff &lt; 0x2bfffffff ph=
ys-bits too low (32)<br>
&gt; <br>
&gt; However, the following are allowed since on both cases physical addres=
s<br>
&gt; space of the processor is 36 bits:<br>
&gt; <br>
&gt; $ ./qemu-system-x86_64 -cpu pentium2 -m size=3D10G<br>
&gt; $ ./qemu-system-x86_64 -cpu pentium,pse36=3Don -m size=3D10G<br>
&gt; <br>
&gt; For 32-bit, without PAE/PSE36, hotplugging additional memory is no lon=
ger allowed.<br>
&gt; <br>
&gt; $ ./qemu-system-i386 -m size=3D1G,maxmem=3D3G,slots=3D2<br>
&gt; qemu-system-i386: Address space limit 0xffffffff &lt; 0x1ffffffff phys=
-bits too low (32)<br>
&gt; $ ./qemu-system-i386 -machine q35 -m size=3D1G,maxmem=3D3G,slots=3D2<b=
r>
&gt; qemu-system-i386: Address space limit 0xffffffff &lt; 0x1ffffffff phys=
-bits too low (32)<br>
&gt; <br>
&gt; A new compatibility flag is introduced to make sure pc_max_used_gpa() =
keeps<br>
&gt; returning the old value for machines 8.1 and older.<br>
&gt; Therefore, the above is still allowed for older machine types in order=
 to support<br>
&gt; compatibility. Hence, the following still works:<br>
&gt; <br>
&gt; $ ./qemu-system-i386 -machine pc-i440fx-8.1 -m size=3D1G,maxmem=3D3G,s=
lots=3D2<br>
&gt; $ ./qemu-system-i386 -machine pc-q35-8.1 -m size=3D1G,maxmem=3D3G,slot=
s=3D2<br>
&gt; <br>
&gt; Further, following is also allowed as with PSE36, the processor has 36=
-bit<br>
&gt; address space:<br>
&gt; <br>
&gt; $ ./qemu-system-i386 -cpu 486,pse36=3Don -m size=3D1G,maxmem=3D3G,slot=
s=3D2<br>
&gt; <br>
&gt; After calling CPUID with EAX=3D0x80000001, all AMD64 compliant process=
ors<br>
&gt; have the longmode-capable-bit turned on in the extended feature flags =
(bit 29)<br>
&gt; in EDX. The absence of CPUID longmode can be used to differentiate bet=
ween<br>
&gt; 32-bit and 64-bit processors and is the recommended approach. QEMU tak=
es this<br>
&gt; approach elsewhere (for example, please see x86_cpu_realizefn()), With=
<br>
&gt; this change, pc_max_used_gpa() also uses the same method to detect 32-=
bit<br>
&gt; processors.<br>
&gt; <br>
&gt; Unit tests are modified to not run 32-bit x86 tests that use memory ho=
tplug.<br>
&gt; <br>
&gt; Suggested-by: David Hildenbrand &lt;<a href=3D"mailto:david@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">david@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Ani Sinha &lt;<a href=3D"mailto:anisinha@redhat.com" ta=
rget=3D"_blank" rel=3D"noreferrer">anisinha@redhat.com</a>&gt;<br>
&gt; Reviewed-by: David Hildenbrand &lt;<a href=3D"mailto:david@redhat.com"=
 target=3D"_blank" rel=3D"noreferrer">david@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/i386/pc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 32 +++++++++++++++++++++++++++++---<br>
&gt;=C2=A0 =C2=A0hw/i386/pc_piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 4 ++++<br>
&gt;=C2=A0 =C2=A0hw/i386/pc_q35.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 =C2=A0include/hw/i386/pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 6 ++++++<br>
&gt;=C2=A0 =C2=A0tests/qtest/bios-tables-test.c | 26 ++++++++++++++++++----=
----<br>
&gt;=C2=A0 =C2=A0tests/qtest/numa-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 7 ++++++-<br>
&gt;=C2=A0 =C2=A06 files changed, 65 insertions(+), 12 deletions(-)<br>
&gt; <br>
&gt; changelog:<br>
&gt; v6: more code messaging. incorporated another of phil&#39;s suggestion=
s.<br>
<br>
Thank you Ani, appreciated!<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">The code looks lot cleaner now. Thanks for the s=
uggestions.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
&gt; v5: addressed phil&#39;s suggestions in code reorg to make it cleaner.=
<br>
&gt; v4: address comments from v3. Fix a bug where compat knob was absent<b=
r>
&gt; from q35 machines. Commit message adjustment.<br>
&gt; v3: still accounting for additional memory device region above 4G.<br>
&gt; unit tests fixed (not running for 32-bit where mem hotplug is used).<b=
r>
&gt; v2: removed memory hotplug region from max_gpa. added compat knobs.<br=
>
<br>
</blockquote></div></div></div>

--00000000000090dfc306060111d8--


