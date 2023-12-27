Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C85781EDE8
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 10:50:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIQXQ-0006X6-Tx; Wed, 27 Dec 2023 04:49:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rIQXP-0006Vp-8D
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 04:49:19 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rIQXN-0008Bv-7M
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 04:49:18 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d5ae89c72so11133365e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 01:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703670555; x=1704275355; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iVpi8RoNmLJenFFQcgf0+WfQqyWi+UE8e3gBdNcgpk8=;
 b=yn/6wUAYc9EGmojqg9YaN91S6IFq11esnspzhVjgk2sAB2Hxb9egGKgLhg2l+RVzIH
 xO7TRmfUJEtmw5GwuXTRRKh+2f6WF6uk3oLNV3i/Z+PPug53xth4D3NL14DOVkaGnrxe
 +MCyBtAEKTsdeL6BmvQkElqOk3m993Y2EWoBRwnWaQ0nQ7OK1vN667jMq6i4dZLA/CkM
 +P08qtrIii3JAJac1PbaKiMNZ602MzetsPg7qfJr3VD7ZrNwjhPQFbm+RUPRmh9+C/ZU
 y0mzdK9yeaRuPLxbPUtfAuLJDXOk6P7EmZWCDLDT/3xxdPN7g3+6GgMyNxq5BHqBtZli
 dhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703670555; x=1704275355;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iVpi8RoNmLJenFFQcgf0+WfQqyWi+UE8e3gBdNcgpk8=;
 b=whfIbQGgsKunIDQ1Q5B/BvalghxsDD3e6fg1hcTD4qeDdtE0U+VYJi5b2z2Xj6ps/d
 rX76nF8QsjLcHF5J3P6Fxq1P7YFBPg2w82NIL/076AYcwP4amySz+b62PteqqhLlXcG3
 3+Zr+54rq/Ux1Aw2X1fImnZsdJTfiV1UWDmTXKq7Mpuklbt2GAHUcVdBx30yffs+faMf
 JDIeWzjuD4mbHJVMowcc/eLnRI4XIWRjPF3afC2mE7S5UdU6Q7MnwPzHBvovZfVbCOqX
 Sy+452eZfMErLAnuPEMRK+SYgX3hTL+6ICJ2ILKJp5D13b398DYc1orXTcZy0EEWXjTe
 Uhog==
X-Gm-Message-State: AOJu0YyUqhMPlk4WlGRtle+qXPY4JNi++05ZNCr5k7GoHK7kmSnvVHwT
 74c73ia6weNOd8VkLmuQ+OHKOLpc8accZQ==
X-Google-Smtp-Source: AGHT+IGsOfUC2BdQtbOUtG1X9aEdqqHXiI4O8tfxy0Ion76/Xsnz89nYnw0hw46N9sKUi2Q59YZEaQ==
X-Received: by 2002:a05:600c:4ec9:b0:40d:5f64:e516 with SMTP id
 g9-20020a05600c4ec900b0040d5f64e516mr145462wmq.72.1703670555503; 
 Wed, 27 Dec 2023 01:49:15 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.122])
 by smtp.gmail.com with ESMTPSA id
 r19-20020a05600c459300b0040d128e9c62sm31073731wmo.18.2023.12.27.01.49.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 01:49:14 -0800 (PST)
Message-ID: <3d4f33b7-031f-4cc1-a696-56625a89f2ab@linaro.org>
Date: Wed, 27 Dec 2023 10:49:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/arm: Prefer arm_feature() over
 object_property_find()
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Radoslaw Biernacki
 <rad@semihalf.com>, qemu-arm@nongnu.org,
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20231214171447.44025-1-philmd@linaro.org>
 <CAFEAcA-Je+_tNCwiL_sQb-tDmCRJ2LWm5mAfuowtxbUBNEWQXQ@mail.gmail.com>
 <871qbkug24.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <871qbkug24.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Markus, Kevin,

On 18/12/23 08:26, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Thu, 14 Dec 2023 at 17:14, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>
>>> QOM properties are added on the ARM vCPU object when a
>>> feature is present. Rather than checking the property
>>> is present, check the feature.
>>>
>>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> RFC: If there is no objection on this patch, I can split
>>>       as a per-feature series if necessary.
>>>
>>> Based-on: <20231123143813.42632-1-philmd@linaro.org>
>>>    "hw: Simplify accesses to CPUState::'start-powered-off' property"
>>
>> I'm not a super-fan of board-level code looking inside
>> the QOM object with direct use of arm_feature() when
>> it doesn't have to. What's wrong with asking whether
>> the property exists before trying to set it?
> 
> I'm not a fan of using QOM instead of the native C interface.
> 
> The native C interface is CPUArmState method arm_feature().
> 
> Attempts to use it on anything but a CPUArmState * will be caught by the
> compiler.  object_property_find() will happily take any Object.
> 
> Likewise, typos in its second argument will be caught by the compiler.
> object_property_find() will happily return NULL then.
> 
> 
> I also don't like adding QOM properties to instances.
> arm_cpu_post_init() seems to do that.  I feel it's best to stick to
> class properties whenever practical.
> 
> More so when management applications are expected to use them, because
> introspection is much easier to use correctly when existence of
> properties doesn't depend on run-time state.
> 
> Kevin's "[RFC PATCH 00/12] QOM/QAPI integration part 1" explores
> QAPIfication of object configuration, loosely based on
> <https://wiki.qemu.org/Features/QOM-QAPI_integration>.  A QOM class's
> instance configuration interface becomes compile-time static.

What is your take on this pattern from commit f50cd31413
("arm: Don't clear ARM_FEATURE_PMSA for no-mpu configs"):

commit f50cd31413d8bc9d1eef8edd1f878324543bf65d

     arm: Don't clear ARM_FEATURE_PMSA for no-mpu configs

     Fix the handling of QOM properties for PMSA CPUs with no MPU:

     Allow no-MPU to be specified by either:
      * has-mpu = false
      * pmsav7_dregion = 0
     and make setting one imply the other. Don't clear the PMSA
     feature bit in this situation.

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f844af5673..76a5e20111 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -763,8 +763,14 @@ static void arm_cpu_realizefn(DeviceState *dev, 
Error **errp)
          cpu->id_pfr1 &= ~0xf000;
      }

+    /* MPU can be configured out of a PMSA CPU either by setting has-mpu
+     * to false or by setting pmsav7-dregion to 0.
+     */
      if (!cpu->has_mpu) {
-        unset_feature(env, ARM_FEATURE_PMSA);
+        cpu->pmsav7_dregion = 0;
+    }
+    if (cpu->pmsav7_dregion == 0) {
+        cpu->has_mpu = false;
      }

      if (arm_feature(env, ARM_FEATURE_PMSA) &&

---

Both "has-mpu" and "pmsav7-dregion" are static properties, used as QOM
configuration provided by /before/ the realize() handler; but then one
is (en)forced /after/ realize().

Logically this looks like a AND configuration gate; is this acceptable?

I tend to see QOM config properties as writable *before* realize() and
then to be used as read-only within/after realize(). So here the KISS
approach would be to report an error the 2 properties differ, as an XNOR
gate:

   if (cpu->has_mpu ^ !cpu->pmsav7_dregion) {
       error_setg(errp,
                  "%u pmsav7-dregions requested but no MPU available",
                  cpu->pmsav7_dregion);
       return false;
   }

Thanks,

Phil.

