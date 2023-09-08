Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E220B798AAD
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 18:29:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeeKd-0002Pu-CL; Fri, 08 Sep 2023 12:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeeKQ-0002DA-A0
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 12:27:32 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeeKM-0007m4-9a
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 12:27:28 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52bcb8b199aso3036363a12.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 09:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694190443; x=1694795243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fvyEhJy8E3cdTNy8rLCXGh8mZ8gmLQ4qGQ31CGWtdjA=;
 b=RhXHelzpcPa4RaZrjv0VixsJi14FzNi03Y3p2A6glspQz4J3qY5/83H/CBpLWoWFut
 BS4j2C54zmcbicynwd/+EIEhipA361HbVgEFBsXitpwvr+0R61Dp2nppieVpLhJEd7ic
 U/49PH89dzmqYp0yr3ZZXSr16CpegmqfqKwQOMVUivxgKN/K1L0P/Asp3I6ebGZjbsZv
 jsImW7/l+dXkVAJQTZyPlzrORHsV86MmCHyaS82qVEEmk8v3becPBDeV5NWHF/xSK6pY
 XEadbCVxcEyGRjOR7ZUFW229yALbHwjeHJsui46ovmuT75uLRDnnwiHIgQhPk3SVyuSK
 ZzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694190443; x=1694795243;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fvyEhJy8E3cdTNy8rLCXGh8mZ8gmLQ4qGQ31CGWtdjA=;
 b=ZXAFaOLXpAnjrnbNpasvh3StvtJNt3HqedeCvDzXpVU+wZ3ou4mQdt+OxCGR0iwTyI
 AsT0R7ldhka03YVwKwKfzieCNwb3d0AgEKu9zF+JyPdR1OcZ1vj3yReYIeXsajmEWCgM
 wO6Dd2v6cRfwfKlmfp63+wu8IcNfRjoQ8DwjhdVnooyQz5HSQyOzEeqx7P3+1u9OLdk2
 trLYBBGdPmCaxdQQIUB1pRUwO1gbZcc6j8213bVW4TD7ClUEdAUfipU8O6UyqHADpha1
 DLffvLvJjwdZVIIQcEx3cVuK3ytin7MDqcmsezmav4QEy4A1o5wzWdTJPRLJgsUyubGG
 3Ahg==
X-Gm-Message-State: AOJu0YxoneW21uspGy42/psb6m8CKrLB4C7gIPH2/92VgG0sTpUR0Knb
 a3MrbvPT0bLDmdr27k96z9Ilvw==
X-Google-Smtp-Source: AGHT+IG+qgfll6YLzf58kKzpP6ZECqqImztcX26cFDCHtMW+hqHrGax340gJNPRgBHwx9rTsfJLQ0A==
X-Received: by 2002:aa7:cd6c:0:b0:527:3a95:5bea with SMTP id
 ca12-20020aa7cd6c000000b005273a955beamr2355429edb.32.1694190443399; 
 Fri, 08 Sep 2023 09:27:23 -0700 (PDT)
Received: from [192.168.69.115]
 (lfb24-h01-176-173-167-175.dsl.sta.abo.bbox.fr. [176.173.167.175])
 by smtp.gmail.com with ESMTPSA id
 r18-20020aa7cfd2000000b00527e7087d5dsm1208805edy.15.2023.09.08.09.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 09:27:22 -0700 (PDT)
Message-ID: <fee31724-3b75-95d6-f4d6-2e7b8f17bf96@linaro.org>
Date: Fri, 8 Sep 2023 18:27:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PULL 24/51] meson: compile bundled device trees
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907130004.500601-25-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907130004.500601-25-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/9/23 14:59, Paolo Bonzini wrote:
> If dtc is available, compile the .dts files in the pc-bios directory
> instead of using the precompiled binaries.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   pc-bios/Makefile    | 19 -------------------
>   pc-bios/meson.build | 25 +++++++++++++++++++++----
>   2 files changed, 21 insertions(+), 23 deletions(-)
>   delete mode 100644 pc-bios/Makefile

FWIW I'm getting:

[50/1419] Generating pc-bios/bamboo.dts with a custom command
../../pc-bios/bamboo.dts:45.9-48.4: Warning (unit_address_vs_reg): 
/memory: node has a reg or ranges property, but no unit name
../../pc-bios/bamboo.dts:87.13-154.5: Warning (unit_address_vs_reg): 
/plb/opb: node has a reg or ranges property, but no unit name
../../pc-bios/bamboo.dts:198.3-50: Warning (chosen_node_stdout_path): 
/chosen:linux,stdout-path: Use 'stdout-path' instead
../../pc-bios/bamboo.dts:87.13-154.5: Warning (interrupts_property): 
/plb/opb: Missing interrupt-parent
../../pc-bios/bamboo.dts:100.14-108.6: Warning (interrupts_property): 
/plb/opb/ebc: Missing interrupt-parent
[51/1419] Generating pc-bios/canyonlands.dts with a custom command
../../pc-bios/canyonlands.dts:47.9-50.4: Warning (unit_address_vs_reg): 
/memory: node has a reg or ranges property, but no unit name
../../pc-bios/canyonlands.dts:210.13-429.5: Warning 
(unit_address_vs_reg): /plb/opb: node has a reg or ranges property, but 
no unit name
../../pc-bios/canyonlands.dts:464.26-504.5: Warning (pci_bridge): 
/plb/pciex@d00000000: node name is not "pci" or "pcie"
../../pc-bios/canyonlands.dts:506.26-546.5: Warning (pci_bridge): 
/plb/pciex@d20000000: node name is not "pci" or "pcie"
pc-bios/canyonlands.dtb: Warning (unit_address_format): Failed 
prerequisite 'pci_bridge'
pc-bios/canyonlands.dtb: Warning (pci_device_reg): Failed prerequisite 
'pci_bridge'
pc-bios/canyonlands.dtb: Warning (pci_device_bus_num): Failed 
prerequisite 'pci_bridge'
../../pc-bios/canyonlands.dts:268.14-289.7: Warning 
(avoid_unnecessary_addr_size): /plb/opb/ebc/ndfc@3,0: unnecessary 
#address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" 
property


