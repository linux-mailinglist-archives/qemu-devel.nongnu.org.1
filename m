Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89668793EA8
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:22:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtQ7-0004aY-Q0; Wed, 06 Sep 2023 10:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qdtQ3-0004RV-3w
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:22:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qdtPx-0003Ez-9V
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694010122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tn6fzFAGEz9ICUvWdVc1sLyhlG61D2BI0W2TGpLpKt8=;
 b=ZlWjAp5ZONfFZ2i+S7m9rFhz6wuZLobrgY8VTdaLpQBJDmxRaHjJJBiFHZveHYYTUK4YtB
 LYiQOgqFVI1+xnlBsE6+HhVcQzgIhtZt1qGtetkFNUjZ0L7m8pVict95cpppbd5xK29+F1
 sks9QqIu1Ewle/CwVdsH/+bdUGHWUgY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-7lwvru-VNGGCBWp4mJjgLQ-1; Wed, 06 Sep 2023 10:21:57 -0400
X-MC-Unique: 7lwvru-VNGGCBWp4mJjgLQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-501bf3722dfso2021808e87.3
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 07:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694010114; x=1694614914;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tn6fzFAGEz9ICUvWdVc1sLyhlG61D2BI0W2TGpLpKt8=;
 b=LNKDbfau0xrgvNzqRCkPfrxqbvkhSz8Da0dAqcAn8BfrqBYUuR3V9V1SnG/Q2COeOd
 8sJsHGbEL6E3xLsjyg/49U1irXNuA8wETVMMY8gePpgQCVR/vpiCYKlGbR2OP59u63Wg
 GosYbhuuc0HqRxwo3fbAztb5PYUsy53Zdq+ywg2dSuR/GRmYFH+M6g4VWzCmR47Z2fBR
 XTTVNYyhwsGkJvPY++MxT/ztuQ/D3pkK3simMn5c6E6ZVUr10R8ihA3MOccJYRR4LkZH
 PRoBblaNZS6Rl18oaUwNpT+V79oEMlWE/nKAXi/yWomrS6HQEakzRd9PfQ3DZZQsQvm8
 SJJw==
X-Gm-Message-State: AOJu0Ywvp0s2BbVTD11E0lXwg07otqjETsDueZqYXuuyNZMOuEnwbevP
 hpRrN8/fG0VOXJaQuGZUWbS6lVmpXOWJ2dnfI0B1RMiOF7bln6zhrmm+ES0dstnxIiqOtbP82bU
 OjVdCa55GLHypz7ERAClzD8o=
X-Received: by 2002:a19:4f4f:0:b0:500:bb99:69b0 with SMTP id
 a15-20020a194f4f000000b00500bb9969b0mr2144864lfk.57.1694010114448; 
 Wed, 06 Sep 2023 07:21:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpl7ip2vcLRULWMFmLc3E/6+cmBW2iMvdriTBhshcYModieyE+q7fhl912M5leOVHHvSNL4Q==
X-Received: by 2002:a19:4f4f:0:b0:500:bb99:69b0 with SMTP id
 a15-20020a194f4f000000b00500bb9969b0mr2144851lfk.57.1694010113891; 
 Wed, 06 Sep 2023 07:21:53 -0700 (PDT)
Received: from redhat.com ([2.52.23.134]) by smtp.gmail.com with ESMTPSA id
 gf16-20020a170906e21000b0098669cc16b2sm9031761ejb.83.2023.09.06.07.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 07:21:53 -0700 (PDT)
Date: Wed, 6 Sep 2023 10:21:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tim Wiederhake <twiederh@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/4] target/i386: Translate feature_word_info to xml
Message-ID: <20230906102118-mutt-send-email-mst@kernel.org>
References: <20230811135011.23343-1-twiederh@redhat.com>
 <20230811135011.23343-3-twiederh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811135011.23343-3-twiederh@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 11, 2023 at 03:50:09PM +0200, Tim Wiederhake wrote:
> This is the data file that will be used to generate the C code.
> All information, including the comments, is preserved.
> 
> Signed-off-by: Tim Wiederhake <twiederh@redhat.com>

I'd use json I think - we don't use xml widely in qemu ATM.

> ---
>  target/i386/feature_word_info.xml | 1607 +++++++++++++++++++++++++++++
>  1 file changed, 1607 insertions(+)
>  create mode 100644 target/i386/feature_word_info.xml
> 
> diff --git a/target/i386/feature_word_info.xml b/target/i386/feature_word_info.xml
> new file mode 100644
> index 0000000000..ff741b9f5a
> --- /dev/null
> +++ b/target/i386/feature_word_info.xml
> @@ -0,0 +1,1607 @@
> +<feature_words>
> +    <feature_word index="FEAT_1_EDX">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature>"fpu"</feature>
> +            <feature>"vme"</feature>
> +            <feature>"de"</feature>
> +            <feature>"pse"</feature>
> +            <feature>"tsc"</feature>
> +            <feature>"msr"</feature>
> +            <feature>"pae"</feature>
> +            <feature>"mce"</feature>
> +            <feature>"cx8"</feature>
> +            <feature>"apic"</feature>
> +            <feature></feature>
> +            <feature>"sep"</feature>
> +            <feature>"mtrr"</feature>
> +            <feature>"pge"</feature>
> +            <feature>"mca"</feature>
> +            <feature>"cmov"</feature>
> +            <feature>"pat"</feature>
> +            <feature>"pse36"</feature>
> +            <feature>"pn"</feature><!-- Intel psn -->
> +            <feature>"clflush"</feature><!-- Intel clfsh -->
> +            <feature></feature>
> +            <feature>"ds"</feature><!-- Intel dts -->
> +            <feature>"acpi"</feature>
> +            <feature>"mmx"</feature>
> +            <feature>"fxsr"</feature>
> +            <feature>"sse"</feature>
> +            <feature>"sse2"</feature>
> +            <feature>"ss"</feature>
> +            <feature>"ht"</feature><!-- Intel htt -->
> +            <feature>"tm"</feature>
> +            <feature>"ia64"</feature>
> +            <feature>"pbe"</feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>1</eax>
> +            <reg>R_EDX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_FEATURES</tcg_features>
> +    </feature_word>
> +    <feature_word index="FEAT_1_ECX">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature>"pni"</feature><!-- Intel,AMD sse3 -->
> +            <feature>"pclmulqdq"</feature>
> +            <feature>"dtes64"</feature>
> +            <feature>"monitor"</feature>
> +            <feature>"ds-cpl"</feature>
> +            <feature>"vmx"</feature>
> +            <feature>"smx"</feature>
> +            <feature>"est"</feature>
> +            <feature>"tm2"</feature>
> +            <feature>"ssse3"</feature>
> +            <feature>"cid"</feature>
> +            <feature></feature>
> +            <feature>"fma"</feature>
> +            <feature>"cx16"</feature>
> +            <feature>"xtpr"</feature>
> +            <feature>"pdcm"</feature>
> +            <feature></feature>
> +            <feature>"pcid"</feature>
> +            <feature>"dca"</feature>
> +            <feature>"sse4.1"</feature>
> +            <feature>"sse4.2"</feature>
> +            <feature>"x2apic"</feature>
> +            <feature>"movbe"</feature>
> +            <feature>"popcnt"</feature>
> +            <feature>"tsc-deadline"</feature>
> +            <feature>"aes"</feature>
> +            <feature>"xsave"</feature>
> +            <feature></feature><!-- osxsave -->
> +            <feature>"avx"</feature>
> +            <feature>"f16c"</feature>
> +            <feature>"rdrand"</feature>
> +            <feature>"hypervisor"</feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>1</eax>
> +            <reg>R_ECX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_EXT_FEATURES</tcg_features>
> +    </feature_word>
> +    <!-- Feature names that are already defined on feature_name[] but
> +     * are set on CPUID[8000_0001].EDX on AMD CPUs don't have their
> +     * names on feat_names below. They are copied automatically
> +     * to features[FEAT_8000_0001_EDX] if and only if CPU vendor is AMD. -->
> +    <feature_word index="FEAT_8000_0001_EDX">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature></feature><!-- fpu -->
> +            <feature></feature><!-- vme -->
> +            <feature></feature><!-- de -->
> +            <feature></feature><!-- pse -->
> +            <feature></feature><!-- tsc -->
> +            <feature></feature><!-- msr -->
> +            <feature></feature><!-- pae -->
> +            <feature></feature><!-- mce -->
> +            <feature></feature><!-- cx8 -->
> +            <feature></feature><!-- apic -->
> +            <feature></feature>
> +            <feature>"syscall"</feature>
> +            <feature></feature><!-- mtrr -->
> +            <feature></feature><!-- pge -->
> +            <feature></feature><!-- mca -->
> +            <feature></feature><!-- cmov -->
> +            <feature></feature><!-- pat -->
> +            <feature></feature><!-- pse36 -->
> +            <feature></feature>
> +            <feature></feature><!-- Linux mp -->
> +            <feature>"nx"</feature>
> +            <feature></feature>
> +            <feature>"mmxext"</feature>
> +            <feature></feature><!-- mmx -->
> +            <feature></feature><!-- fxsr -->
> +            <feature>"fxsr-opt"</feature>
> +            <feature>"pdpe1gb"</feature>
> +            <feature>"rdtscp"</feature>
> +            <feature></feature>
> +            <feature>"lm"</feature>
> +            <feature>"3dnowext"</feature>
> +            <feature>"3dnow"</feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>0x80000001</eax>
> +            <reg>R_EDX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_EXT2_FEATURES</tcg_features>
> +    </feature_word>
> +    <feature_word index="FEAT_8000_0001_ECX">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature>"lahf-lm"</feature>
> +            <feature>"cmp-legacy"</feature>
> +            <feature>"svm"</feature>
> +            <feature>"extapic"</feature>
> +            <feature>"cr8legacy"</feature>
> +            <feature>"abm"</feature>
> +            <feature>"sse4a"</feature>
> +            <feature>"misalignsse"</feature>
> +            <feature>"3dnowprefetch"</feature>
> +            <feature>"osvw"</feature>
> +            <feature>"ibs"</feature>
> +            <feature>"xop"</feature>
> +            <feature>"skinit"</feature>
> +            <feature>"wdt"</feature>
> +            <feature></feature>
> +            <feature>"lwp"</feature>
> +            <feature>"fma4"</feature>
> +            <feature>"tce"</feature>
> +            <feature></feature>
> +            <feature>"nodeid-msr"</feature>
> +            <feature></feature>
> +            <feature>"tbm"</feature>
> +            <feature>"topoext"</feature>
> +            <feature>"perfctr-core"</feature>
> +            <feature>"perfctr-nb"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>0x80000001</eax>
> +            <reg>R_ECX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_EXT3_FEATURES</tcg_features>
> +        <!-- * TOPOEXT is always allowed but can't be enabled blindly by
> +         * "-cpu host", as it requires consistent cache topology info
> +         * to be provided so it doesn't confuse guests. -->
> +        <no_autoenable_flags>CPUID_EXT3_TOPOEXT</no_autoenable_flags>
> +    </feature_word>
> +    <feature_word index="FEAT_C000_0001_EDX">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"xstore"</feature>
> +            <feature>"xstore-en"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"xcrypt"</feature>
> +            <feature>"xcrypt-en"</feature>
> +            <feature>"ace2"</feature>
> +            <feature>"ace2-en"</feature>
> +            <feature>"phe"</feature>
> +            <feature>"phe-en"</feature>
> +            <feature>"pmm"</feature>
> +            <feature>"pmm-en"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>0xC0000001</eax>
> +            <reg>R_EDX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_EXT4_FEATURES</tcg_features>
> +    </feature_word>
> +    <feature_word index="FEAT_KVM">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature>"kvmclock"</feature>
> +            <feature>"kvm-nopiodelay"</feature>
> +            <feature>"kvm-mmu"</feature>
> +            <feature>"kvmclock"</feature>
> +            <feature>"kvm-asyncpf"</feature>
> +            <feature>"kvm-steal-time"</feature>
> +            <feature>"kvm-pv-eoi"</feature>
> +            <feature>"kvm-pv-unhalt"</feature>
> +            <feature></feature>
> +            <feature>"kvm-pv-tlb-flush"</feature>
> +            <feature></feature>
> +            <feature>"kvm-pv-ipi"</feature>
> +            <feature>"kvm-poll-control"</feature>
> +            <feature>"kvm-pv-sched-yield"</feature>
> +            <feature>"kvm-asyncpf-int"</feature>
> +            <feature>"kvm-msi-ext-dest-id"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"kvmclock-stable-bit"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>KVM_CPUID_FEATURES</eax>
> +            <reg>R_EAX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_KVM_FEATURES</tcg_features>
> +    </feature_word>
> +    <feature_word index="FEAT_KVM_HINTS">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature>"kvm-hint-dedicated"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>KVM_CPUID_FEATURES</eax>
> +            <reg>R_EDX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_KVM_FEATURES</tcg_features>
> +        <!-- * KVM hints aren't auto-enabled by -cpu host, they need to be
> +         * explicitly enabled in the command-line. -->
> +        <no_autoenable_flags>~0U</no_autoenable_flags>
> +    </feature_word>
> +    <feature_word index="FEAT_SVM">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature>"npt"</feature>
> +            <feature>"lbrv"</feature>
> +            <feature>"svm-lock"</feature>
> +            <feature>"nrip-save"</feature>
> +            <feature>"tsc-scale"</feature>
> +            <feature>"vmcb-clean"</feature>
> +            <feature>"flushbyasid"</feature>
> +            <feature>"decodeassists"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"pause-filter"</feature>
> +            <feature></feature>
> +            <feature>"pfthreshold"</feature>
> +            <feature>"avic"</feature>
> +            <feature></feature>
> +            <feature>"v-vmsave-vmload"</feature>
> +            <feature>"vgif"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vnmi"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"svme-addr-chk"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>0x8000000A</eax>
> +            <reg>R_EDX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_SVM_FEATURES</tcg_features>
> +    </feature_word>
> +    <feature_word index="FEAT_7_0_EBX">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature>"fsgsbase"</feature>
> +            <feature>"tsc-adjust"</feature>
> +            <feature>"sgx"</feature>
> +            <feature>"bmi1"</feature>
> +            <feature>"hle"</feature>
> +            <feature>"avx2"</feature>
> +            <feature></feature>
> +            <feature>"smep"</feature>
> +            <feature>"bmi2"</feature>
> +            <feature>"erms"</feature>
> +            <feature>"invpcid"</feature>
> +            <feature>"rtm"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"mpx"</feature>
> +            <feature></feature>
> +            <feature>"avx512f"</feature>
> +            <feature>"avx512dq"</feature>
> +            <feature>"rdseed"</feature>
> +            <feature>"adx"</feature>
> +            <feature>"smap"</feature>
> +            <feature>"avx512ifma"</feature>
> +            <feature>"pcommit"</feature>
> +            <feature>"clflushopt"</feature>
> +            <feature>"clwb"</feature>
> +            <feature>"intel-pt"</feature>
> +            <feature>"avx512pf"</feature>
> +            <feature>"avx512er"</feature>
> +            <feature>"avx512cd"</feature>
> +            <feature>"sha-ni"</feature>
> +            <feature>"avx512bw"</feature>
> +            <feature>"avx512vl"</feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>7</eax>
> +            <needs_ecx>true</needs_ecx>
> +            <ecx>0</ecx>
> +            <reg>R_EBX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_7_0_EBX_FEATURES</tcg_features>
> +    </feature_word>
> +    <feature_word index="FEAT_7_0_ECX">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature></feature>
> +            <feature>"avx512vbmi"</feature>
> +            <feature>"umip"</feature>
> +            <feature>"pku"</feature>
> +            <feature></feature><!-- ospke -->
> +            <feature>"waitpkg"</feature>
> +            <feature>"avx512vbmi2"</feature>
> +            <feature></feature>
> +            <feature>"gfni"</feature>
> +            <feature>"vaes"</feature>
> +            <feature>"vpclmulqdq"</feature>
> +            <feature>"avx512vnni"</feature>
> +            <feature>"avx512bitalg"</feature>
> +            <feature></feature>
> +            <feature>"avx512-vpopcntdq"</feature>
> +            <feature></feature>
> +            <feature>"la57"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"rdpid"</feature>
> +            <feature></feature>
> +            <feature>"bus-lock-detect"</feature>
> +            <feature>"cldemote"</feature>
> +            <feature></feature>
> +            <feature>"movdiri"</feature>
> +            <feature>"movdir64b"</feature>
> +            <feature></feature>
> +            <feature>"sgxlc"</feature>
> +            <feature>"pks"</feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>7</eax>
> +            <needs_ecx>true</needs_ecx>
> +            <ecx>0</ecx>
> +            <reg>R_ECX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_7_0_ECX_FEATURES</tcg_features>
> +    </feature_word>
> +    <feature_word index="FEAT_7_0_EDX">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"avx512-4vnniw"</feature>
> +            <feature>"avx512-4fmaps"</feature>
> +            <feature>"fsrm"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"avx512-vp2intersect"</feature>
> +            <feature></feature>
> +            <feature>"md-clear"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"serialize"</feature>
> +            <feature></feature>
> +            <feature>"tsx-ldtrk"</feature>
> +            <feature></feature>
> +            <feature></feature><!-- pconfig -->
> +            <feature>"arch-lbr"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"amx-bf16"</feature>
> +            <feature>"avx512-fp16"</feature>
> +            <feature>"amx-tile"</feature>
> +            <feature>"amx-int8"</feature>
> +            <feature>"spec-ctrl"</feature>
> +            <feature>"stibp"</feature>
> +            <feature>"flush-l1d"</feature>
> +            <feature>"arch-capabilities"</feature>
> +            <feature>"core-capability"</feature>
> +            <feature>"ssbd"</feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>7</eax>
> +            <needs_ecx>true</needs_ecx>
> +            <ecx>0</ecx>
> +            <reg>R_EDX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_7_0_EDX_FEATURES</tcg_features>
> +    </feature_word>
> +    <feature_word index="FEAT_7_1_EAX">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"avx-vnni"</feature>
> +            <feature>"avx512-bf16"</feature>
> +            <feature></feature>
> +            <feature>"cmpccxadd"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"fzrm"</feature>
> +            <feature>"fsrs"</feature>
> +            <feature>"fsrc"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"amx-fp16"</feature>
> +            <feature></feature>
> +            <feature>"avx-ifma"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>7</eax>
> +            <needs_ecx>true</needs_ecx>
> +            <ecx>1</ecx>
> +            <reg>R_EAX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_7_1_EAX_FEATURES</tcg_features>
> +    </feature_word>
> +    <feature_word index="FEAT_7_1_EDX">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"avx-vnni-int8"</feature>
> +            <feature>"avx-ne-convert"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"prefetchiti"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>7</eax>
> +            <needs_ecx>true</needs_ecx>
> +            <ecx>1</ecx>
> +            <reg>R_EDX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_7_1_EDX_FEATURES</tcg_features>
> +    </feature_word>
> +    <feature_word index="FEAT_7_2_EDX">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"mcdt-no"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>7</eax>
> +            <needs_ecx>true</needs_ecx>
> +            <ecx>2</ecx>
> +            <reg>R_EDX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_7_2_EDX_FEATURES</tcg_features>
> +    </feature_word>
> +    <feature_word index="FEAT_8000_0007_EDX">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"invtsc"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>0x80000007</eax>
> +            <reg>R_EDX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_APM_FEATURES</tcg_features>
> +        <unmigratable_flags>CPUID_APM_INVTSC</unmigratable_flags>
> +    </feature_word>
> +    <feature_word index="FEAT_8000_0008_EBX">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature>"clzero"</feature>
> +            <feature></feature>
> +            <feature>"xsaveerptr"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"wbnoinvd"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"ibpb"</feature>
> +            <feature></feature>
> +            <feature>"ibrs"</feature>
> +            <feature>"amd-stibp"</feature>
> +            <feature></feature>
> +            <feature>"stibp-always-on"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"amd-ssbd"</feature>
> +            <feature>"virt-ssbd"</feature>
> +            <feature>"amd-no-ssb"</feature>
> +            <feature></feature>
> +            <feature>"amd-psfd"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>0x80000008</eax>
> +            <reg>R_EBX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_8000_0008_EBX</tcg_features>
> +        <unmigratable_flags>0</unmigratable_flags>
> +    </feature_word>
> +    <feature_word index="FEAT_8000_0021_EAX">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature>"no-nested-data-bp"</feature>
> +            <feature></feature>
> +            <feature>"lfence-always-serializing"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"null-sel-clr-base"</feature>
> +            <feature></feature>
> +            <feature>"auto-ibrs"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>0x80000021</eax>
> +            <reg>R_EAX</reg>
> +        </cpuid>
> +        <tcg_features>0</tcg_features>
> +        <unmigratable_flags>0</unmigratable_flags>
> +    </feature_word>
> +    <feature_word index="FEAT_XSAVE">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature>"xsaveopt"</feature>
> +            <feature>"xsavec"</feature>
> +            <feature>"xgetbv1"</feature>
> +            <feature>"xsaves"</feature>
> +            <feature>"xfd"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>0xd</eax>
> +            <needs_ecx>true</needs_ecx>
> +            <ecx>1</ecx>
> +            <reg>R_EAX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_XSAVE_FEATURES</tcg_features>
> +    </feature_word>
> +    <feature_word index="FEAT_XSAVE_XSS_LO">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>0xD</eax>
> +            <needs_ecx>true</needs_ecx>
> +            <ecx>1</ecx>
> +            <reg>R_ECX</reg>
> +        </cpuid>
> +    </feature_word>
> +    <feature_word index="FEAT_XSAVE_XSS_HI">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <cpuid>
> +            <eax>0xD</eax>
> +            <needs_ecx>true</needs_ecx>
> +            <ecx>1</ecx>
> +            <reg>R_EDX</reg>
> +        </cpuid>
> +    </feature_word>
> +    <feature_word index="FEAT_6_EAX">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"arat"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>6</eax>
> +            <reg>R_EAX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_6_EAX_FEATURES</tcg_features>
> +    </feature_word>
> +    <feature_word index="FEAT_XSAVE_XCR0_LO">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <cpuid>
> +            <eax>0xD</eax>
> +            <needs_ecx>true</needs_ecx>
> +            <ecx>0</ecx>
> +            <reg>R_EAX</reg>
> +        </cpuid>
> +        <tcg_features>~0U</tcg_features>
> +        <migratable_flags>XSTATE_FP_MASK | XSTATE_SSE_MASK | XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK | XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK | XSTATE_PKRU_MASK</migratable_flags>
> +    </feature_word>
> +    <feature_word index="FEAT_XSAVE_XCR0_HI">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <cpuid>
> +            <eax>0xD</eax>
> +            <needs_ecx>true</needs_ecx>
> +            <ecx>0</ecx>
> +            <reg>R_EDX</reg>
> +        </cpuid>
> +        <tcg_features>~0U</tcg_features>
> +    </feature_word>
> +    <!-- Below are MSR exposed features -->
> +    <feature_word index="FEAT_ARCH_CAPABILITIES">
> +        <type>MSR_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature>"rdctl-no"</feature>
> +            <feature>"ibrs-all"</feature>
> +            <feature>"rsba"</feature>
> +            <feature>"skip-l1dfl-vmentry"</feature>
> +            <feature>"ssb-no"</feature>
> +            <feature>"mds-no"</feature>
> +            <feature>"pschange-mc-no"</feature>
> +            <feature>"tsx-ctrl"</feature>
> +            <feature>"taa-no"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"sbdr-ssdp-no"</feature>
> +            <feature>"fbsdp-no"</feature>
> +            <feature>"psdp-no"</feature>
> +            <feature></feature>
> +            <feature>"fb-clear"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"pbrsb-no"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <msr>MSR_IA32_ARCH_CAPABILITIES</msr>
> +        <!-- * FEAT_ARCH_CAPABILITIES only affects a read-only MSR, which
> +         * cannot be read from user mode.  Therefore, it has no impact
> +         > on any user-mode operation, and warnings about unsupported
> +         * features do not matter. -->
> +        <tcg_features>~0U</tcg_features>
> +    </feature_word>
> +    <feature_word index="FEAT_CORE_CAPABILITY">
> +        <type>MSR_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"split-lock-detect"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <msr>MSR_IA32_CORE_CAPABILITY</msr>
> +    </feature_word>
> +    <feature_word index="FEAT_PERF_CAPABILITIES">
> +        <type>MSR_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"full-width-write"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <msr>MSR_IA32_PERF_CAPABILITIES</msr>
> +    </feature_word>
> +    <feature_word index="FEAT_VMX_PROCBASED_CTLS">
> +        <type>MSR_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-vintr-pending"</feature>
> +            <feature>"vmx-tsc-offset"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-hlt-exit"</feature>
> +            <feature></feature>
> +            <feature>"vmx-invlpg-exit"</feature>
> +            <feature>"vmx-mwait-exit"</feature>
> +            <feature>"vmx-rdpmc-exit"</feature>
> +            <feature>"vmx-rdtsc-exit"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-cr3-load-noexit"</feature>
> +            <feature>"vmx-cr3-store-noexit"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-cr8-load-exit"</feature>
> +            <feature>"vmx-cr8-store-exit"</feature>
> +            <feature>"vmx-flexpriority"</feature>
> +            <feature>"vmx-vnmi-pending"</feature>
> +            <feature>"vmx-movdr-exit"</feature>
> +            <feature>"vmx-io-exit"</feature>
> +            <feature>"vmx-io-bitmap"</feature>
> +            <feature></feature>
> +            <feature>"vmx-mtf"</feature>
> +            <feature>"vmx-msr-bitmap"</feature>
> +            <feature>"vmx-monitor-exit"</feature>
> +            <feature>"vmx-pause-exit"</feature>
> +            <feature>"vmx-secondary-ctls"</feature>
> +        </feat_names>
> +        <msr>MSR_IA32_VMX_TRUE_PROCBASED_CTLS</msr>
> +    </feature_word>
> +    <feature_word index="FEAT_VMX_SECONDARY_CTLS">
> +        <type>MSR_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature>"vmx-apicv-xapic"</feature>
> +            <feature>"vmx-ept"</feature>
> +            <feature>"vmx-desc-exit"</feature>
> +            <feature>"vmx-rdtscp-exit"</feature>
> +            <feature>"vmx-apicv-x2apic"</feature>
> +            <feature>"vmx-vpid"</feature>
> +            <feature>"vmx-wbinvd-exit"</feature>
> +            <feature>"vmx-unrestricted-guest"</feature>
> +            <feature>"vmx-apicv-register"</feature>
> +            <feature>"vmx-apicv-vid"</feature>
> +            <feature>"vmx-ple"</feature>
> +            <feature>"vmx-rdrand-exit"</feature>
> +            <feature>"vmx-invpcid-exit"</feature>
> +            <feature>"vmx-vmfunc"</feature>
> +            <feature>"vmx-shadow-vmcs"</feature>
> +            <feature>"vmx-encls-exit"</feature>
> +            <feature>"vmx-rdseed-exit"</feature>
> +            <feature>"vmx-pml"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-xsaves"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-tsc-scaling"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <msr>MSR_IA32_VMX_PROCBASED_CTLS2</msr>
> +    </feature_word>
> +    <feature_word index="FEAT_VMX_PINBASED_CTLS">
> +        <type>MSR_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature>"vmx-intr-exit"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-nmi-exit"</feature>
> +            <feature></feature>
> +            <feature>"vmx-vnmi"</feature>
> +            <feature>"vmx-preemption-timer"</feature>
> +            <feature>"vmx-posted-intr"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <msr>MSR_IA32_VMX_TRUE_PINBASED_CTLS</msr>
> +    </feature_word>
> +    <feature_word index="FEAT_VMX_EXIT_CTLS">
> +        <type>MSR_FEATURE_WORD</type>
> +        <!-- * VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE is copied from
> +         * the LM CPUID bit. -->
> +        <feat_names>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-exit-nosave-debugctl"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature><!-- vmx-exit-host-addr-space-size -->
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-exit-load-perf-global-ctrl"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-exit-ack-intr"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-exit-save-pat"</feature>
> +            <feature>"vmx-exit-load-pat"</feature>
> +            <feature>"vmx-exit-save-efer"</feature>
> +            <feature>"vmx-exit-load-efer"</feature>
> +            <feature>"vmx-exit-save-preemption-timer"</feature>
> +            <feature>"vmx-exit-clear-bndcfgs"</feature>
> +            <feature></feature>
> +            <feature>"vmx-exit-clear-rtit-ctl"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-exit-load-pkrs"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <msr>MSR_IA32_VMX_TRUE_EXIT_CTLS</msr>
> +    </feature_word>
> +    <feature_word index="FEAT_VMX_ENTRY_CTLS">
> +        <type>MSR_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-entry-noload-debugctl"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-entry-ia32e-mode"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-entry-load-perf-global-ctrl"</feature>
> +            <feature>"vmx-entry-load-pat"</feature>
> +            <feature>"vmx-entry-load-efer"</feature>
> +            <feature>"vmx-entry-load-bndcfgs"</feature>
> +            <feature></feature>
> +            <feature>"vmx-entry-load-rtit-ctl"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-entry-load-pkrs"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <msr>MSR_IA32_VMX_TRUE_ENTRY_CTLS</msr>
> +    </feature_word>
> +    <feature_word index="FEAT_VMX_MISC">
> +        <type>MSR_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-store-lma"</feature>
> +            <feature>"vmx-activity-hlt"</feature>
> +            <feature>"vmx-activity-shutdown"</feature>
> +            <feature>"vmx-activity-wait-sipi"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-vmwrite-vmexit-fields"</feature>
> +            <feature>"vmx-zero-len-inject"</feature>
> +            <feature></feature>
> +        </feat_names>
> +        <msr>MSR_IA32_VMX_MISC</msr>
> +    </feature_word>
> +    <feature_word index="FEAT_VMX_EPT_VPID_CAPS">
> +        <type>MSR_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature>"vmx-ept-execonly"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-page-walk-4"</feature>
> +            <feature>"vmx-page-walk-5"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-ept-2mb"</feature>
> +            <feature>"vmx-ept-1gb"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-invept"</feature>
> +            <feature>"vmx-eptad"</feature>
> +            <feature>"vmx-ept-advanced-exitinfo"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-invept-single-context"</feature>
> +            <feature>"vmx-invept-all-context"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-invvpid"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-invvpid-single-addr"</feature>
> +            <feature>"vmx-invept-single-context"</feature>
> +            <feature>"vmx-invvpid-all-context"</feature>
> +            <feature>"vmx-invept-single-context-noglobals"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <msr>MSR_IA32_VMX_EPT_VPID_CAP</msr>
> +    </feature_word>
> +    <feature_word index="FEAT_VMX_BASIC">
> +        <type>MSR_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"vmx-ins-outs"</feature>
> +            <feature>"vmx-true-ctls"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <msr>MSR_IA32_VMX_BASIC</msr>
> +        <!-- Just to be safe - we don't support setting the MSEG version field. -->
> +        <no_autoenable_flags>MSR_VMX_BASIC_DUAL_MONITOR</no_autoenable_flags>
> +    </feature_word>
> +    <feature_word index="FEAT_VMX_VMFUNC">
> +        <type>MSR_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature>"vmx-eptp-switching"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <msr>MSR_IA32_VMX_VMFUNC</msr>
> +    </feature_word>
> +    <feature_word index="FEAT_14_0_ECX">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"intel-pt-lip"</feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>0x14</eax>
> +            <needs_ecx>true</needs_ecx>
> +            <ecx>0</ecx>
> +            <reg>R_ECX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_14_0_ECX_FEATURES</tcg_features>
> +    </feature_word>
> +    <feature_word index="FEAT_SGX_12_0_EAX">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature>"sgx1"</feature>
> +            <feature>"sgx2"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"sgx-edeccssa"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>0x12</eax>
> +            <needs_ecx>true</needs_ecx>
> +            <ecx>0</ecx>
> +            <reg>R_EAX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_SGX_12_0_EAX_FEATURES</tcg_features>
> +    </feature_word>
> +    <feature_word index="FEAT_SGX_12_0_EBX">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature>"sgx-exinfo"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>0x12</eax>
> +            <needs_ecx>true</needs_ecx>
> +            <ecx>0</ecx>
> +            <reg>R_EBX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_SGX_12_0_EBX_FEATURES</tcg_features>
> +    </feature_word>
> +    <feature_word index="FEAT_SGX_12_1_EAX">
> +        <type>CPUID_FEATURE_WORD</type>
> +        <feat_names>
> +            <feature></feature>
> +            <feature>"sgx-debug"</feature>
> +            <feature>"sgx-mode64"</feature>
> +            <feature></feature>
> +            <feature>"sgx-provisionkey"</feature>
> +            <feature>"sgx-tokenkey"</feature>
> +            <feature></feature>
> +            <feature>"sgx-kss"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature>"sgx-aex-notify"</feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +            <feature></feature>
> +        </feat_names>
> +        <cpuid>
> +            <eax>0x12</eax>
> +            <needs_ecx>true</needs_ecx>
> +            <ecx>1</ecx>
> +            <reg>R_EAX</reg>
> +        </cpuid>
> +        <tcg_features>TCG_SGX_12_1_EAX_FEATURES</tcg_features>
> +    </feature_word>
> +</feature_words>
> -- 
> 2.39.2
> 
> 


