Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B698C810D92
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 10:44:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDLlT-0007hw-3o; Wed, 13 Dec 2023 04:42:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDLlQ-0007hL-MP
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 04:42:48 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDLlO-0007uE-MM
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 04:42:48 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50e04354de0so2828390e87.1
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 01:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702460564; x=1703065364; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K853PDx7iHxwDMRe2s2uwXiHrYbBJ011260FxoeToU8=;
 b=r1t60xG7Zhv0qXv6W3ir2hCAsO1LvK0Sgyyg6ysxH5kS3v3jn00rZDZglTPVa+Rb9z
 hAE4JSfBzRjzsC4Jryi6R9mWgtLSlMsaaLTPRaIjhwPWZdvSYM6hdOPPLecmSD9ZmNrK
 xOD+KiSpF/nMt0OyoAz65+qkgF3QB/NILJPxlr+wgnOqV4NSmPWOMsMzjd/0D6kehfh9
 kWBIERneBxGy3+7I1lX77cj7huHv8OMw6VXS896pwK1KUgmSmuEnTIIgfdTJadXEo2t3
 ZhAS4+ij2PlfGZO9D+eeGqzJXppfdj8WJgT79y0SiO8q+GmhT9KW5cVv+LuqQFuOT5Rz
 pRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702460564; x=1703065364;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K853PDx7iHxwDMRe2s2uwXiHrYbBJ011260FxoeToU8=;
 b=srh+UAvClBdYQPgFlJIGfRDe42AIUPET7Kc3OsWbv8NqZv9PoD7dBeVu76KxLub7f9
 VTxmTR6zvY9nFBr7afVE/1VLFZBLz3Me6iWkUH8Pkh4pSx4GBPs4ETcbWJdim9HWDpeH
 8nYU2WCV2L+R3DHNJ+xcSANZ8q7vqiqoyauKX1ofaBkedOuvFDr98F35VuLc7n5bXBQE
 XaFJvSAPZfGbGveQg2d/IYwIKEwmHXG2SGkzJOk8Lipypa1xMW6WXLqzHdMVAN3ts2bb
 LgdBNfhdW2eVw5f5BKMPA+PO1YoTWtVqoaN5e7f4HqYd1IY/KLlbr+wNR+REFVMekrUf
 kjrw==
X-Gm-Message-State: AOJu0YyAubS/xhOvHawQKcg2d+0BEAZClCI4WD4fQMgpnhrYLyjEPYMI
 bHUvdjJzLtfKXrOGd+vf3yGCKA==
X-Google-Smtp-Source: AGHT+IEVEhRhPHOrDnVVCzhBwNeqUb8Stu2A+hAmOs4abuCm4K/3UvB9W5XfQbOz3KvfEYZ8FNI0aA==
X-Received: by 2002:a05:6512:ea3:b0:50b:eec1:2b4 with SMTP id
 bi35-20020a0565120ea300b0050beec102b4mr4700825lfb.79.1702460564574; 
 Wed, 13 Dec 2023 01:42:44 -0800 (PST)
Received: from [192.168.27.175] (234.red-88-28-2.dynamicip.rima-tde.net.
 [88.28.2.234]) by smtp.gmail.com with ESMTPSA id
 w13-20020a5d608d000000b00333357a77c4sm12791087wrt.34.2023.12.13.01.42.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 01:42:44 -0800 (PST)
Message-ID: <e4443aa8-1b36-41fd-b1a8-6ed7ddb2f130@linaro.org>
Date: Wed, 13 Dec 2023 10:42:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 00/16] target/arm/kvm: Unify kvm_arm_FOO() API
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <CAFEAcA8S7Ug8uFpvDO9FarLpLhTr_236H8gOK=dEOWQZe-3zgg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8S7Ug8uFpvDO9FarLpLhTr_236H8gOK=dEOWQZe-3zgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 11/12/23 15:36, Peter Maydell wrote:
> On Thu, 23 Nov 2023 at 18:35, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Half of the API takes CPUState, the other ARMCPU...
>>
>> $ git grep -F 'CPUState *' target/arm/kvm_arm.h | wc -l
>>        16
>> $ git grep -F 'ARMCPU *' target/arm/kvm_arm.h | wc -l
>>        14
>>
>> Since this is ARM specific, have it always take ARMCPU, and
>> call the generic KVM API casting with the CPU() macro.
> 
> 
> 
> Applied to target-arm.next for 9.0, thanks.

Thanks Peter, the only change I added from Gavin review is
on top of patch #3:

-- >8 --
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 6fb8a5f67e..3abbef0260 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -148,7 +148,7 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);

  /**
   * kvm_arm_add_vcpu_properties:
- * @obj: The CPU object to add the properties to
+ * @cpu: The CPU object to add the properties to
   *
   * Add all KVM specific CPU properties to the CPU object. These
   * are the CPU properties with "kvm-" prefixed names.
---


