Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BD182966E
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:43:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNV6w-0004ZX-MT; Wed, 10 Jan 2024 04:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNV6j-0004T7-6v
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:42:46 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNV6h-0005a4-37
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:42:44 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40d8902da73so37449055e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704879761; x=1705484561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rAhTGlf2fVyNUq4i4U/vQ/mn9mIcoupPvq/XTpb76kE=;
 b=kzCjlodCqQsSvzMT6WSb3R8NQ5Rqf0St40dqHm0vtL0NqM1cNXwihjDm/3o2uonbOo
 yoBmmFqXW71H+ZTTB/AaO5pDo2GRov4qgfDCGgDi2/xTq40iCuyXkCkgoCyFnUV9m7Uu
 KF9To0LKT0yWT4t/Vggc0PZFc05JkKvyOl+OfltqfIfBo89FRdPe1EyN/Sv3jWCveWeT
 EOYPxi02eFUuYzKwhx8GhULYO6FsoNfu63HdDI+Ok0iVZcgYz/MG831OEBgqEFXulO5/
 VS6RpB/PbHW1PQBgERx4AlCSfeRXXGAkPNUdmu5d2y92zCdt0O/eUtUKfRsanrJRfX0p
 dJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704879761; x=1705484561;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rAhTGlf2fVyNUq4i4U/vQ/mn9mIcoupPvq/XTpb76kE=;
 b=KUh95SYRysegKOdOfB1TEydNX5NoJUodrktR1DsX29DNUpsPbZfQ5zzpe5rHaAXMch
 mnOc7cP+mpg67F8Y47wB0Ch6gc94WZ1pwYM6TavxpWBa4nknNEENOiR1WJ9r/NCMOy3A
 ncM/tXnLP5HIs0QxSO4oPwIxZJkVScBTFJJ4BfaUZKeCTafcMTmuYRTAJOrSFcTOVQbl
 tsuvCo6aXG4KEfb8intu/ioeyryVcoS4tRYmk332yb8HNrfnLYPuMrtZdIsmPWI4MFnu
 SWxEuJsr+jIROLcb/mTpFeDcCl/eVvtQYgGceRmJjh2+I/rZycZHYXx2h2zJNBXqqBRB
 +4eg==
X-Gm-Message-State: AOJu0Yy5hOSRDNSzCSViN9dfzEq2kwRCRcZ/bwlEL2EUp41iiLp4xWms
 k1+MdVA1qWi9ksyykWqAkjU1ToMotcXCHw==
X-Google-Smtp-Source: AGHT+IHvjfWB1yVYNN4m6KKSgOC4Q5Auk4jp82DwodkYlr41P+FbScM8T81GfIKrE8tF8uo2T8yXKw==
X-Received: by 2002:a05:600c:3b97:b0:40e:4ac1:865e with SMTP id
 n23-20020a05600c3b9700b0040e4ac1865emr402541wms.52.1704879761385; 
 Wed, 10 Jan 2024 01:42:41 -0800 (PST)
Received: from [192.168.1.102] ([176.167.134.179])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c198a00b0040e56830a35sm1336824wmq.18.2024.01.10.01.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 01:42:40 -0800 (PST)
Message-ID: <84dc483e-08fc-4a47-a192-3db2003b38cd@linaro.org>
Date: Wed, 10 Jan 2024 10:42:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] Add loongarch kvm accel support
Content-Language: en-US
To: gaosong <gaosong@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, richard.henderson@linaro.org, peter.maydell@linaro.org,
 yangxiaojuan@loongson.cn
References: <20240105075804.1228596-1-zhaotianrui@loongson.cn>
 <a51860ec-26f7-6567-bee5-86b03afb9dad@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a51860ec-26f7-6567-bee5-86b03afb9dad@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Song,

On 10/1/24 03:46, gaosong wrote:
> 在 2024/1/5 下午3:57, Tianrui Zhao 写道:

>> This series add loongarch kvm support, mainly implement
>> some interfaces used by kvm, such as kvm_arch_get/set_regs,
>> kvm_arch_handle_exit, kvm_loongarch_set_interrupt, etc.


>> Tianrui Zhao (9):
>>    linux-headers: Synchronize linux headers from linux v6.7.0-rc8
>>    target/loongarch: Define some kvm_arch interfaces
>>    target/loongarch: Supplement vcpu env initial when vcpu reset
>>    target/loongarch: Implement kvm get/set registers
>>    target/loongarch: Implement kvm_arch_init function
>>    target/loongarch: Implement kvm_arch_init_vcpu
>>    target/loongarch: Implement kvm_arch_handle_exit
>>    target/loongarch: Implement set vcpu intr for kvm
>>    target/loongarch: Add loongarch kvm into meson build


> Applied to loongarch-next.

Sorry it took me some time to test this on a loongarch64
host. I made minor changes to patch #8, please consider
the alternative:
https://lore.kernel.org/qemu-devel/20240110094152.52138-1-philmd@linaro.org/ 
and
https://lore.kernel.org/qemu-devel/20240110094152.52138-2-philmd@linaro.org/

