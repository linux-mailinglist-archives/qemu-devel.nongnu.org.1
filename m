Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 806C27B9B6E
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 09:41:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoIyD-0000pG-Kl; Thu, 05 Oct 2023 03:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qoIyB-0000oo-GS
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:40:27 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qoIy9-00038k-SX
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:40:27 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5335725cf84so1053665a12.2
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 00:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696491623; x=1697096423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dmGAE349TjttZmQHzHVNptWjIA4qPizw69F+Q22010k=;
 b=gXdtnfaYnSEgxKkIKozW8ZATDYp2oZKOMIAWnvwPl6gIqhpSyE/zAUDKyjDnEshJCS
 CPF0Hg9GPG7iQtYqiINBqL1hmtAmjMdwj+lT0tlLt+dtAi1E6aB6QX03+Zzzh4umcPb5
 ybbEG1bYn3E9YY4rTms55DeK7k2EoGQyQXrTvpehRDpNh6bIpPPLCWSWnWvHM8PfYEUF
 yP4PFJ8Vxzs3P+w2FrV0at2AKaJpAl6eVL8d3cagUEYvmN545w4zDBGT2RXa0nIcrOtn
 djLHWtzluT8uE+Cu8EliVhFpxxRxqYpeIl9RKXKSAGTOU/Ms3RVrq90idRKgeZq8DgFA
 P22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696491623; x=1697096423;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dmGAE349TjttZmQHzHVNptWjIA4qPizw69F+Q22010k=;
 b=nAPGROugbmjkjq0Ct7iSJVTqKOszHinAxIoHNvlC5r4M6J32muTiZndfiVuuk7Q0Fj
 kupT8FkSpOf/KNpTWyvyESM8iWTLFJWlw3yyzhV1/RWFmrhmgfcBCxgpSQwVmI2E7xdT
 xHudXlPmHml6PO7YY3zVzX87i+nTeQceueyeGLW++Da3eWSeTgFibzej+ZBj2vMYjv7p
 jlINAGxLEM85t6iZ9sv7Qk3Xi5QGeF31Ju9dBvZjlGjA+f8WB4V9CdasvABpyKdTeFZq
 tFHCUglazojS3DSOCxUDXC0fFLbHUeY14JSwTUACnBNaQUYkSq/ky1I4NGm5Aa3Rl8tI
 4gpQ==
X-Gm-Message-State: AOJu0Yxq4AOuXKgXDIOkSNzN2pPUC5AXOCTu+DGL10767EEZ2vOOd9iy
 GTsCGhhEmdLj5I3nnC2AwDg=
X-Google-Smtp-Source: AGHT+IEdTjYTauwViE1WsDzKEyMaelWINQmLzVw5QDfyNbPfdaYxsLmHhSkwbka0PcAtKeRGiSMDOw==
X-Received: by 2002:a17:907:75da:b0:9ad:a46c:2936 with SMTP id
 jl26-20020a17090775da00b009ada46c2936mr4077170ejc.8.1696491623175; 
 Thu, 05 Oct 2023 00:40:23 -0700 (PDT)
Received: from ?IPv6:::1?
 (p200300faaf2af200ad058901f594a09a.dip0.t-ipconnect.de.
 [2003:fa:af2a:f200:ad05:8901:f594:a09a])
 by smtp.gmail.com with ESMTPSA id
 qx18-20020a170906fcd200b0099bc8bd9066sm716245ejb.150.2023.10.05.00.40.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 00:40:22 -0700 (PDT)
Date: Thu, 05 Oct 2023 07:40:17 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/5=5D_hw/i386/apic=3A_Defer_error_?=
 =?US-ASCII?Q?check_from_apic=5Fget=5Fclass_to_kvm=5Fapic=5Frealize?=
In-Reply-To: <e2dc91e2-9ed3-6919-8a7e-d9e159a55b43@linaro.org>
References: <20231003082728.83496-1-philmd@linaro.org>
 <20231003082728.83496-3-philmd@linaro.org>
 <8527EF0C-E466-41A0-B1A2-9AEF301B5B5E@gmail.com>
 <e2dc91e2-9ed3-6919-8a7e-d9e159a55b43@linaro.org>
Message-ID: <8E1773C3-D1DB-47B4-A218-387C8C58D225@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 5=2E Oktober 2023 07:06:38 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>Hi Bernhard,
>
>On 4/10/23 01:21, Bernhard Beschow wrote:
>> Am 3=2E Oktober 2023 08:27:25 UTC schrieb "Philippe Mathieu-Daud=C3=A9"=
 <philmd@linaro=2Eorg>:
>>> apic_get_class() isn't supposed to fail=2E kvm_apic_realize() is
>>> DeviceRealize() handler, which can fail=2E Defer the error check
>>> to the latter=2E
>>>=20
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>>> ---
>>> hw/i386/kvm/apic=2Ec       | 5 +++++
>>> target/i386/cpu-sysemu=2Ec | 8 --------
>>> 2 files changed, 5 insertions(+), 8 deletions(-)
>
>                        "kvm-apic-msi", APIC_SPACE_SIZE);
>>>=20
>>> diff --git a/target/i386/cpu-sysemu=2Ec b/target/i386/cpu-sysemu=2Ec
>>> index 2375e48178=2E=2E6a228c9178 100644
>>> --- a/target/i386/cpu-sysemu=2Ec
>>> +++ b/target/i386/cpu-sysemu=2Ec
>>> @@ -253,10 +253,6 @@ APICCommonClass *apic_get_class(Error **errp)
>>>=20
>>>      /* TODO: in-kernel irqchip for hvf */
>>>      if (kvm_enabled()) {
>>> -        if (!kvm_irqchip_in_kernel()) {
>>> -            error_setg(errp, "KVM does not support userspace APIC");
>>> -            return NULL;
>>> -        }
>>>          apic_type =3D "kvm-apic";
>>>      } else if (xen_enabled()) {
>>>          apic_type =3D "xen-apic";
>>> @@ -272,10 +268,6 @@ void x86_cpu_apic_create(X86CPU *cpu, Error **err=
p)
>>>      APICCommonState *apic;
>>>      APICCommonClass *apic_class =3D apic_get_class(errp);
>>>=20
>>> -    if (!apic_class) {
>>> -        return;
>>> -    }
>>> -
>>=20
>> Did you intend to remove these lines in the next commit? There you're w=
riting to simplify x86_cpu_apic_create() which you're doing here already=2E
>
>No: apic_get_class() doesn't return NULL anymore, so this is dead code=2E

Yes, makes sense=2E

Maybe move "It can't return NULL neither, so simplify x86_cpu_apic_create(=
)=2E" of the next commit message here? There, you're applying the same chan=
ge to various functions but point out x86_cpu_apic_create() explicitly whic=
h is the part I was confused about=2E Though this may not warrant a respin=
=2E

Best regards,
Bernhard

>
>>=20
>> Best regards,
>> Bernhard

