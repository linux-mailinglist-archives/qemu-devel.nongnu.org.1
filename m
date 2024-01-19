Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0490B8330AE
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 23:08:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQx0x-0004PK-DI; Fri, 19 Jan 2024 17:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQx0u-0004P1-Vr
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 17:07:00 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQx0s-0003lF-Lv
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 17:07:00 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e586a62f7so14376715e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 14:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705702016; x=1706306816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Svj6rBdujdVK5IvwDYFsEMyWWvimTiYPtbnJDAnh4to=;
 b=Z+RwWy40KK85synkstM+YnAtEIn4HmfnP0+8z2zqOs3QtATBHX9LiHaIUY1XVnPAEG
 jv4zZUxzqm600mk1SDpml8UO2pAXDqCuzn8TTto6CALnsDwUvTVwggq1IumPE2wpNZGa
 NJKWTNvXQ065We3HJT9085OVg9I6k60HR6BKNFmdhXCeEUdFgf7/pSVuoWVVmLx1vJ/u
 ZCrskVU+XqgeNngCAosprnqYTaiEh/10/8ise358hwovVGoT545MDvBhCNAnk9AB7sfK
 yCQovmHRJXBVrKQey/f5NBct4kSY+VyvHHFQGcsib7OfNKT3v/v2qAZo2o6MjPlpxWju
 GrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705702016; x=1706306816;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Svj6rBdujdVK5IvwDYFsEMyWWvimTiYPtbnJDAnh4to=;
 b=ZpjBeAcyDSHxENPzcx6IL/P+jl8RYzawrEYzvLJIMOs/a9tpmMRm9CQv1MG23PoTc2
 Wxk/As1OOZxnA5noOk/G4U0dizHH0YzgbTKJkRuEAvRhtpDpfbc11fMCkNHMHHaOHMB+
 g+a1ccAX2k8Ig7w5vCcqD1Oc00JdmiD74iNlWdgZn9QVD5I7NuYFIFSfyeLHBvXiDrvj
 m8ytVgFbNIDKw5O4OIxsT6zt9fL7Dkm/WokdJVdMtdX1SDEZhBNX3PTxMoAMIkXv+Idf
 IW4U97avqB9igqPtMtUHpZr0qn/0XArQXlqkxR2szxqeb7iQbO6T5zeiLRtqRkZ8vw2f
 RI+Q==
X-Gm-Message-State: AOJu0Yw6+pjcZj5GwTi+NAuOTREc1er32AQPX1foDzux13MaUE0WrR/9
 n5umIuUz+H0b/tC9NCUe1Mha3LwUx8gHrgIVNIeszufoQw6Cu+S//I9rc5Hv4Ug=
X-Google-Smtp-Source: AGHT+IEBdy9RGp0dIJ9xH037QQAjcjsi3gyuC6/bNBZOMEeci++CE89cQJUxWm6YyAIFl7ipw1EZfQ==
X-Received: by 2002:a05:600c:4ecc:b0:40e:779f:416 with SMTP id
 g12-20020a05600c4ecc00b0040e779f0416mr292750wmq.2.1705702016520; 
 Fri, 19 Jan 2024 14:06:56 -0800 (PST)
Received: from [192.168.1.67] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 q7-20020adffec7000000b0033926505eafsm350322wrs.32.2024.01.19.14.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jan 2024 14:06:56 -0800 (PST)
Message-ID: <ae955912-8a77-4c96-8525-500dc6e7c357@linaro.org>
Date: Fri, 19 Jan 2024 23:06:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/arm: Unconditionally map MMIO-based USB host
 controllers
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>,
 qemu-arm@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
References: <20240115165615.78323-1-philmd@linaro.org>
 <CAFEAcA9abVk_BvWYE6ctcsLrk0CP=aqy38ncgxNrooNroe_1mA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9abVk_BvWYE6ctcsLrk0CP=aqy38ncgxNrooNroe_1mA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 19/1/24 17:51, Peter Maydell wrote:
> On Mon, 15 Jan 2024 at 16:56, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> When a chipset contain a USB controller, we can not simply
>> remove it. We could disable it, but that requires more changes
>> this series isn't aiming for. For more context:
>> https://lore.kernel.org/qemu-devel/56fde49f-7dc6-4f8e-9bbf-0336a20a9ebf@roeck-us.net/
>>
>> Philippe Mathieu-Daudé (2):
>>    hw/arm/allwinner-a10: Unconditionally map the USB Host controllers
>>    hw/arm/nseries: Unconditionally map the TUSB6010 USB Host controller
>>
> 
> 
> 
> Applied to target-arm.next, thanks.

Thanks! I posted a v2 with the requested changes (mention
migration compat break):
https://lore.kernel.org/qemu-devel/20240119215106.45776-1-philmd@linaro.org/


