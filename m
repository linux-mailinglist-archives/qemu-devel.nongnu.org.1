Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F12607358F1
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 15:50:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFGI-0004M8-Ru; Mon, 19 Jun 2023 09:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBFG7-0004Lp-OD
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBFG5-0006uH-8x
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687182567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bLzMxjQCoNSWqFSI03GNszVFCgzmxprpSpY1/CGSVio=;
 b=POY/cdKDxPn28tHoPwG//80N4eLbh8Jm/iPrQrWyL+XRKglsVNeQutM1HQYkJso1N3FRgQ
 eTPjT6G2HXawXBLroQ9fW1xXRBMo20V62dVaRjB83cz4hi4BBu+OSDIO/ZgjBXYV2nqe8k
 bGhpey0kXbcHdQB33ZUm7PBFExfz0vo=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-2HxTUBsWPhOZseeKWHVWtg-1; Mon, 19 Jun 2023 09:49:25 -0400
X-MC-Unique: 2HxTUBsWPhOZseeKWHVWtg-1
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-471795eaba7so198552e0c.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 06:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687182565; x=1689774565;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bLzMxjQCoNSWqFSI03GNszVFCgzmxprpSpY1/CGSVio=;
 b=BgEtgPVSpp99UgZb4MyrpnIj/RvpvcYGnzwVBDhdhNOH8R8+iwh92PXWY0AAyjPFiD
 I0lWlHdmZHE8s1RVm83cmkxO9KWAgB2J2yADP5zlPniI2oENcKBsVVH3hqk8zKcdNo3c
 OWURN3ELrNm+Ba+1kllZo86NMAEsYICuFUuAdnlpT7rO+rOsWAtGZY+VHJbZ1p6L2L/m
 T/e7fi8d140HUUmjxF4lmu2XqxX4yTCcmz5WCHqCo2wh6fg75QlGuZx1PsrISLqZYeue
 wKYyCcaAMcpxgXJtIBPPHG9fSp3cZP3LgQNI0jn0WqR+hafD3lD+q5u1EV/+Eg7yFqeZ
 nSHQ==
X-Gm-Message-State: AC+VfDyXH48fP3wOZJoCLtx5rUpcEwwWuE9FSZhnA/R2boqV17+rnOKb
 U7LDuEhEXA2lkntqArqfvicEnR9OlqVsxmZST2YvC2XIWZlnid1H8YfinktVX/clMbTidY27tZf
 gBjEjzQ1dG7pnnr6OBPtpcXnZKyCNxSuWzVUkf6ByEw==
X-Received: by 2002:a05:6102:51b:b0:434:8401:beae with SMTP id
 l27-20020a056102051b00b004348401beaemr666375vsa.34.1687182565091; 
 Mon, 19 Jun 2023 06:49:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ405SgiUG/zVoCt+rHOQzudHKBOK0TQ4RDFlL0BjVAMYq88CUf/luTXKs3BbyIJlLcRHelqO+IqofkLlPaf5mI=
X-Received: by 2002:a05:6102:51b:b0:434:8401:beae with SMTP id
 l27-20020a056102051b00b004348401beaemr666368vsa.34.1687182564810; Mon, 19 Jun
 2023 06:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230618215114.107337-1-pbonzini@redhat.com>
 <20230618215114.107337-5-pbonzini@redhat.com>
In-Reply-To: <20230618215114.107337-5-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 19 Jun 2023 15:49:12 +0200
Message-ID: <CABgObfaW6bccGJE4SEuck32Eg6fqRgsaJxfBZ+MePKfoNkR6vw@mail.gmail.com>
Subject: Re: [PATCH 4/7] target/i386: TCG supports 32-bit SYSCALL
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000072762405fe7bcd46"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

--00000000000072762405fe7bcd46
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il dom 18 giu 2023, 23:51 Paolo Bonzini <pbonzini@redhat.com> ha scritto:

> TCG supports both 32-bit and 64-bit SYSCALL, so expose it
> with "-cpu max" even for 32-bit emulators.
>

Nope, this is broken... My bad for assuming that glibc will use syscall if
available=E2=80=94that doesn't happen because the syscall instruction actua=
lly is
in the vsyscall page or vDSO.

The fix is still pretty easy, and even SYSENTER could be supported since
after all QEMU *is* exposing the SEP feature when doing user mode
emulation. SYSENTER's design is so hideous though, that in practice no
program will ever use it outside the vDSO/vsyscall page.

Paolo


> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index fc4246223d4..be16c66341d 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -637,7 +637,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t
> vendor1,
>            CPUID_EXT_X2APIC, CPUID_EXT_TSC_DEADLINE_TIMER */
>
>  #ifdef TARGET_X86_64
> -#define TCG_EXT2_X86_64_FEATURES (CPUID_EXT2_SYSCALL | CPUID_EXT2_LM)
> +#define TCG_EXT2_X86_64_FEATURES CPUID_EXT2_LM
>  #else
>  #define TCG_EXT2_X86_64_FEATURES 0
>  #endif
> @@ -645,7 +645,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t
> vendor1,
>  #define TCG_EXT2_FEATURES ((TCG_FEATURES & CPUID_EXT2_AMD_ALIASES) | \
>            CPUID_EXT2_NX | CPUID_EXT2_MMXEXT | CPUID_EXT2_RDTSCP | \
>            CPUID_EXT2_3DNOW | CPUID_EXT2_3DNOWEXT | CPUID_EXT2_PDPE1GB | =
\
> -          TCG_EXT2_X86_64_FEATURES)
> +          CPUID_EXT2_SYSCALL | TCG_EXT2_X86_64_FEATURES)
>  #define TCG_EXT3_FEATURES (CPUID_EXT3_LAHF_LM | CPUID_EXT3_SVM | \
>            CPUID_EXT3_CR8LEG | CPUID_EXT3_ABM | CPUID_EXT3_SSE4A | \
>            CPUID_EXT3_3DNOWPREFETCH)
> --
> 2.40.1
>
>

--00000000000072762405fe7bcd46
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il dom 18 giu 2023, 23:51 Paolo Bonzini &lt;<a href=3D=
"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; ha scritto:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">TCG supports both 32-bit and 64-bit SYSCA=
LL, so expose it<br>
with &quot;-cpu max&quot; even for 32-bit emulators.<br></blockquote></div>=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Nope, this is broken...=
 My bad for assuming that glibc will use syscall if available=E2=80=94that =
doesn&#39;t happen because the syscall instruction actually is in the vsysc=
all page or vDSO.</div><div dir=3D"auto"><br></div><div dir=3D"auto">The fi=
x is still pretty easy, and even SYSENTER could be supported since after al=
l QEMU *is* exposing the SEP feature when doing user mode emulation. SYSENT=
ER&#39;s design is so hideous though, that in practice no program will ever=
 use it outside the vDSO/vsyscall page.</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
---<br>
=C2=A0target/i386/cpu.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/target/i386/cpu.c b/target/i386/cpu.c<br>
index fc4246223d4..be16c66341d 100644<br>
--- a/target/i386/cpu.c<br>
+++ b/target/i386/cpu.c<br>
@@ -637,7 +637,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendo=
r1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_EXT_X2APIC, CPUID_EXT_TSC_DE=
ADLINE_TIMER */<br>
<br>
=C2=A0#ifdef TARGET_X86_64<br>
-#define TCG_EXT2_X86_64_FEATURES (CPUID_EXT2_SYSCALL | CPUID_EXT2_LM)<br>
+#define TCG_EXT2_X86_64_FEATURES CPUID_EXT2_LM<br>
=C2=A0#else<br>
=C2=A0#define TCG_EXT2_X86_64_FEATURES 0<br>
=C2=A0#endif<br>
@@ -645,7 +645,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendo=
r1,<br>
=C2=A0#define TCG_EXT2_FEATURES ((TCG_FEATURES &amp; CPUID_EXT2_AMD_ALIASES=
) | \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_EXT2_NX | CPUID_EXT2_MMXEXT =
| CPUID_EXT2_RDTSCP | \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_EXT2_3DNOW | CPUID_EXT2_3DNO=
WEXT | CPUID_EXT2_PDPE1GB | \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCG_EXT2_X86_64_FEATURES)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUID_EXT2_SYSCALL | TCG_EXT2_X86_64_FE=
ATURES)<br>
=C2=A0#define TCG_EXT3_FEATURES (CPUID_EXT3_LAHF_LM | CPUID_EXT3_SVM | \<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_EXT3_CR8LEG | CPUID_EXT3_ABM=
 | CPUID_EXT3_SSE4A | \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUID_EXT3_3DNOWPREFETCH)<br>
-- <br>
2.40.1<br>
<br>
</blockquote></div></div></div>

--00000000000072762405fe7bcd46--


