Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2775377B428
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 10:30:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVSxg-0007rB-J8; Mon, 14 Aug 2023 04:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1qVSxS-0007hm-4s
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:29:51 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1qVSxP-0000Q5-UU
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:29:49 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso535633766b.2
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 01:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1692001784; x=1692606584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h5xXaJtSHsUCOt1abFAo5kXKDkaoj9wojQfltbiz2Is=;
 b=BqWKycREQlSqRAjkQJ2cBqWh676rb65YMj5EPABQCBM40LO86i5FSEJOiaOO+06p8i
 onIIkw17ujsOEtASs9EwwimUuQpDu2B6uP1Wqw3EFCbYc0b7w/SAvd5Oe4TrqWFZG8h9
 DfQoeEopI+NS0f3jd34EFxeP6aX4JaFTbGMfoKxfY5eHaCEwbxJBeoaHu73U0WvGXoZ6
 4ry+dM71x2WrjOSN4nXBnRIzvbhvi9nft5Pt7WC+osyi1j/Me6ln4r+X9bKxjVHySKEQ
 rGToeMlOyQGw+jvD7o5qByjbRuhtuVleF6WcBOevV/cV0zPIH9F4iA8o5Gc8PrOZhHAt
 lI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692001784; x=1692606584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h5xXaJtSHsUCOt1abFAo5kXKDkaoj9wojQfltbiz2Is=;
 b=G1pyPYpQHunDIkAzJo/7Tmg9W40h526fMV3qlztihTXClEn8ez/UtomPBKVYUeYFnj
 PEoaONGYI5/5+hXQKRVeFnVkO+buMmk7CrehTEDaKqA85BxpGtGuCgekvH8gKgqpTVhN
 a70kH7aiI7Vhhqg0waxPbO3mRk7BqbUhAOWbnZHqZ216/ElMgGb2JLS4O5H2twmJHvXK
 ++Q7vqfZTZ/OF/B6hxhE1PnEjYKdSx5CH3GQ3OwX+bYQbKj0jvnMEdmLzFB73ql16GKV
 Xz+pM8jS0mbWV5oUofG1Ft5gQIJDjo/z/ilpdZUyuIsc2dwKDQUiE4Cj2WettgyBAzx/
 DGyQ==
X-Gm-Message-State: AOJu0YyGPi5bUYgmJQKfRpCyeNhtlURSxsLcSP0H2wKH5Ndd94EPuSti
 NT7AkrVQw33YkPD49JqY7XDXrXqGtAtg2WJXKxEfFr5GrxgxjkZstLQ=
X-Google-Smtp-Source: AGHT+IFYOHE8YQRhPmjrgZo9Tc+ZrRZFQa0sOZBDlp4F85nLNvT/8asU3eB3YegGD6+AAxwVSZc5XuWw3I8dyVLF4PU=
X-Received: by 2002:aa7:d486:0:b0:522:cb97:f196 with SMTP id
 b6-20020aa7d486000000b00522cb97f196mr8329025edr.36.1692001783923; Mon, 14 Aug
 2023 01:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffEmG6TNq0n3+4OJAgXc8J0OevY60KHZekXCBs3LoK9vehA@mail.gmail.com>
In-Reply-To: <CAMGffEmG6TNq0n3+4OJAgXc8J0OevY60KHZekXCBs3LoK9vehA@mail.gmail.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 14 Aug 2023 10:29:33 +0200
Message-ID: <CAMGffE=rsxpHpZQSDGoKO1RTuEaGzowTH7NuY82VtXfa8awong@mail.gmail.com>
Subject: Re: RFC: guest INTEL GDS mitigation status on patched host
To: qemu-devel <qemu-devel@nongnu.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
 daniel.sneddon@linux.intel.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, tao1.su@linux.intel.com,
 xiaoyao.li@intel.com, Yu Zhang <yu.zhang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::630;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Pawan, hi Daniel

Thanks for the patch.

I tried similar patch on Icelake server:
Architecture:                       x86_64
CPU op-mode(s):                     32-bit, 64-bit
Byte Order:                         Little Endian
Address sizes:                      46 bits physical, 57 bits virtual
CPU(s):                             64
On-line CPU(s) list:                0-63
Thread(s) per core:                 2
Core(s) per socket:                 16
Socket(s):                          2
NUMA node(s):                       2
Vendor ID:                          GenuineIntel
CPU family:                         6
Model:                              106
Model name:                         Intel(R) Xeon(R) Gold 6346 CPU @ 3.1
                                    0GHz
Stepping:                           6
CPU MHz:                            3100.000
CPU max MHz:                        3600,0000
CPU min MHz:                        800,0000
BogoMIPS:                           6200.00
Virtualization:                     VT-x
L1d cache:                          1,5 MiB
L1i cache:                          1 MiB
L2 cache:                           40 MiB
L3 cache:                           72 MiB
NUMA node0 CPU(s):                  0,2,4,6,8,10,12,14,16,18,20,22,24,26
                                    ,28,30,32,34,36,38,40,42,44,46,48,50
                                    ,52,54,56,58,60,62
NUMA node1 CPU(s):                  1,3,5,7,9,11,13,15,17,19,21,23,25,27
                                    ,29,31,33,35,37,39,41,43,45,47,49,51
                                    ,53,55,57,59,61,63
Vulnerability Gather data sampling: Mitigation; Microcode
Vulnerability Itlb multihit:        Not affected
Vulnerability L1tf:                 Not affected
Vulnerability Mds:                  Not affected
Vulnerability Meltdown:             Not affected
Vulnerability Mmio stale data:      Mitigation; Clear CPU buffers; SMT v
                                    ulnerable
Vulnerability Retbleed:             Not affected
Vulnerability Spec rstack overflow: Not affected
Vulnerability Spec store bypass:    Mitigation; Speculative Store Bypass
                                     disabled via prctl and seccomp
Vulnerability Spectre v1:           Mitigation; usercopy/swapgs barriers
                                     and __user pointer sanitization
Vulnerability Spectre v2:           Mitigation; Enhanced IBRS, IBPB cond
                                    itional, RSB filling, PBRSB-eIBRS SW
                                     sequence
Vulnerability Srbds:                Not affected
Vulnerability Tsx async abort:      Not affected

 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 97ad229d8ba3..48709b77689f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1155,7 +1155,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] =3D =
{
             NULL, "sbdr-ssdp-no", "fbsdp-no", "psdp-no",
             NULL, "fb-clear", NULL, NULL,
             NULL, NULL, NULL, NULL,
-            "pbrsb-no", NULL, NULL, NULL,
+            "pbrsb-no", NULL, "gds-no", NULL,
             NULL, NULL, NULL, NULL,
         },
         .msr =3D {
--=20
2.34.1
For the change Pawan provided, I tested on Icelake server, it works as expe=
cted.
Somehow I'm not cc for the patch, but please consider it tested

Reported-by: Jack Wang <jinpu.wang@ionos.com>
Tested-by: Jack Wang <jinpu.wang@ionos.com>

Thx!
Jinpu Wang


while if I patches QEMU below:



On Fri, Aug 11, 2023 at 3:12=E2=80=AFPM Jinpu Wang <jinpu.wang@ionos.com> w=
rote:
>
> Hi folks on the list:
>
> I'm testing the latest Downfall cpu vulnerability mitigation. what I
> notice is when both host and guest are using patched kernel +
> microcode eg kernel 5.15.125 +  intel-microcode 20230808 on affected
> server eg Icelake server.
>
> The mitigation status inside guest is:
>
> Vulnerabilities:
>   Gather data sampling:  Unknown: Dependent on hyp
>                          ervisor status
> -----------------------------------> this one.
>   Itlb multihit:         Not affected
>   L1tf:                  Not affected
>   Mds:                   Not affected
>   Meltdown:              Not affected
>   Mmio stale data:       Vulnerable: Clear CPU buf
>                          fers attempted, no microc
>                          ode; SMT Host state unkno
>                          wn
>   Retbleed:              Not affected
>   Spec rstack overflow:  Not affected
>   Spec store bypass:     Mitigation; Speculative S
>                          tore Bypass disabled via
>                          prctl and seccomp
>   Spectre v1:            Mitigation; usercopy/swap
>                          gs barriers and __user po
>                          inter sanitization
>   Spectre v2:            Mitigation; Enhanced IBRS
>                          , IBPB conditional, RSB f
>                          illing, PBRSB-eIBRS SW se
>                          quence
>   Srbds:                 Not affected
>   Tsx async abort:       Not affected
>
> According to kernel commit below
> commit 81ac7e5d741742d650b4ed6186c4826c1a0631a7
> Author: Daniel Sneddon <daniel.sneddon@linux.intel.com>
> Date:   Wed Jul 12 19:43:14 2023 -0700
>
>     KVM: Add GDS_NO support to KVM
>
>     Gather Data Sampling (GDS) is a transient execution attack using
>     gather instructions from the AVX2 and AVX512 extensions. This attack
>     allows malicious code to infer data that was previously stored in
>     vector registers. Systems that are not vulnerable to GDS will set the
>     GDS_NO bit of the IA32_ARCH_CAPABILITIES MSR. This is useful for VM
>     guests that may think they are on vulnerable systems that are, in
>     fact, not affected. Guests that are running on affected hosts where
>     the mitigation is enabled are protected as if they were running
>     on an unaffected system.
>
>     On all hosts that are not affected or that are mitigated, set the
>     GDS_NO bit.
>
>     Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
>     Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>     Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
>
> KVM also has the support of GDS_NO, but seems qemu side doesn't pass
> the info to guest, that's why it is unknown. IMO qemu should pass
> GDS_NO if the host is already patched.
>
> Is Intel or anyone already working on the qemu patch? I know it's not
> a must, but good to do.
>
> Thx!
> Jinpu Wang @ IONOS Cloud

