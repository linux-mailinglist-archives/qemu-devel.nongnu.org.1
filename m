Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9937B65C9
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 11:45:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnbxB-0000cO-Tm; Tue, 03 Oct 2023 05:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnbxA-0000cF-7p
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 05:44:32 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnbx5-0007LA-Gt
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 05:44:32 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4054f790190so6929175e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 02:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696326266; x=1696931066; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8SiphgAucNQGHkryF9frgBMe7PR/MSSiUUKJotN2TEg=;
 b=CcHBq/bxKXkQazXFcMSdRybaTSGHVk/fajmikteHPgDbyn+T4rkHd92+EAOHkr933U
 00T5bxkV4EbdKW1PX2ez0+/q1JC4GOhg2/rrVTJvhc526FSOWxRGf9ohFKI7NlKP0DeX
 sTQWBC34uOi5/FPwMmKP8LscGYOTpsBsYPBk0LgfbJ9AQDIJ8+N42pKLU05p2MOf1f8w
 r4O3LEtuY54WEMVh8fyAj3zWnO7srbqr3gpTP61bLfglBGA9aXbWEThxueo7bvcyo9ND
 HMm7W4O3ijP9ZJrADdpY2NW2vZQu8963dGg1d0fvXYv8sLdlKz00gjAhh5KmfrQv5fP5
 aSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696326266; x=1696931066;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8SiphgAucNQGHkryF9frgBMe7PR/MSSiUUKJotN2TEg=;
 b=f9ZSAXwYagLYPGMFxG33FHS9CXzBszErn2xP6k0J/zayjNzyIHREcMPbKtqMDXq2wy
 BbU4+qhn+egho8qA63kQXY0Z3X8natADZ+uef2AuceK5rt52Lh1RYuPUVFjpCvgdbiCz
 /h1iYJOiBy6Kgy95VPzV3s/l9bcd7lOlgfF13hwy7FxH8agaYR2019T1D8VNL+TeF6mf
 c9ySEU0EazfwzLu/sGNNNwDNA0tK4Gfx/XhrmTvXjsU/gzcLBl+4tisbzPd85utK7W97
 7JFMW1Ysj06BzujWQdQAXSnV8zgwuROS4tDJzUs7p7dTIOXR30pPN738+ZQhnmN2JIDp
 cJeA==
X-Gm-Message-State: AOJu0YzEvz1q/leuk/cmQ5/xZsTHwfZlK1/sXDv0v4FSfDimWYbGdJ/3
 vzFPSATSNUGpsJC1cBmNN/0ckw==
X-Google-Smtp-Source: AGHT+IGCM3/s1kXMoc0VE92CwctV0Hho3NjC09QRAkR719GNUddg3X21PBuO4Q5zhOifZ+nAKkpCjw==
X-Received: by 2002:a05:600c:1c1a:b0:406:53c0:3c71 with SMTP id
 j26-20020a05600c1c1a00b0040653c03c71mr11663731wms.37.1696326265861; 
 Tue, 03 Oct 2023 02:44:25 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-246.abo.bbox.fr.
 [176.131.222.246]) by smtp.gmail.com with ESMTPSA id
 w6-20020a5d6806000000b003196b1bb528sm1153901wru.64.2023.10.03.02.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 02:44:25 -0700 (PDT)
Message-ID: <213c8a98-5025-6fc1-2926-8f6f15180835@linaro.org>
Date: Tue, 3 Oct 2023 11:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/5] accel: Declare AccelClass::[un]realize_cpu() handlers
Content-Language: en-US
To: Claudio Fontana <cfontana@suse.de>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, kvm@vger.kernel.org,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20230915190009.68404-1-philmd@linaro.org>
 <20230915190009.68404-4-philmd@linaro.org>
 <39bac54e-be9f-f425-81be-62395633ad13@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <39bac54e-be9f-f425-81be-62395633ad13@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.321,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/10/23 10:55, Claudio Fontana wrote:
> On 9/15/23 21:00, Philippe Mathieu-Daudé wrote:
>> Currently accel_cpu_realize() only performs target-specific
>> realization. Introduce the [un]realize_cpu fields in the
>> base AccelClass to be able to perform target-agnostic
>> [un]realization of vCPUs.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Just thinking, for the benefit of the reader trying to understand the code later on,
> maybe putting in a "target_" in there somewhere in the function name?
> like "realize_cpu_target", vs "realize_cpu_generic" ?

Good idea, I like it, thanks!


