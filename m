Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F5D828F4D
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 22:54:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNK3D-0007fe-Ed; Tue, 09 Jan 2024 16:54:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNK3A-0007f2-Te
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:54:20 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNK39-0005xR-4h
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 16:54:20 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6dddf7ea893so877566a34.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 13:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704837257; x=1705442057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vjdXptcDKX/t0PLPPJb/luCBab5AI24m2DuNpvTfHg0=;
 b=Furdw9/qvznISmhJRRHblIYbIg6QUMFLj/A3z8G7D3YAKsGNH+hmcRPe0649YXNW/9
 Hnyx3RPo1c+KNl54Sc6x+T6WA6M2nA8975hkNo1ZRx3Mxwbq4TjIiiw9zISfBGMx84aK
 HS3j1YXReXLMJFLvr1xGISQ4+3bRMlVZjeyBSawbcfPNRoYInn+e/WH0RJLC1Uhs3XbD
 PJge5SRq8zFeeXPtW6c5Stcyr771kQeS71rG1JmA9cQoN43Ch3PiwrUWe1GFY1Wtg7QL
 +mNQqma+kS/0frLxy/f29KUTkTEn9HwM9ybbRP0NnuXBUCeCKEq4TGyQ71++vRlrXsKJ
 xD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704837257; x=1705442057;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vjdXptcDKX/t0PLPPJb/luCBab5AI24m2DuNpvTfHg0=;
 b=ffCinzg/dcPMs4bhMMew+s8QbtZjruY0ZeP68CeBe/RbDK8keliUb5wKR63mwcE3RL
 Ak88F6R8qy/7YHe0adG5nuTXJ/31Sq08NZG/dmeIjmWJaL5N3lQVBxEEHyP0/G3+WqU+
 wo0SKuleONtsGygEzyodOqsH6gg9ABq0Kk5783nCNsj04ylPMJt19v9fwiqn4iR9znNd
 HsfFWXoB+aj9Q3A1k9AvAwtTz+9wKEgjdD0adYuFGvgA4pdMVRHYZKg3BmgpF9AlAsfd
 9CE/sJvpYaKLAfwodVWaH8rwFU42Fog9fjLFfx1cn1Y9mNfoRWsd5lKz2SbB63z2si2B
 I0iw==
X-Gm-Message-State: AOJu0Yx6j2zplq9k0AfnRkNArwRtednPVqQLQJjpzu8/EQwj8+/oePIe
 YZhPYq0YpbB3DsQVxxGRXRiADG68p0KsvA==
X-Google-Smtp-Source: AGHT+IHygXInG6G/gbxX+uxHbw2o0jTvN8I1wba29j9WierOwLXWYCpeICgRMOQrocobBw/hbENdtg==
X-Received: by 2002:a05:6830:2685:b0:6dd:ef0b:4f7c with SMTP id
 l5-20020a056830268500b006ddef0b4f7cmr31544otu.34.1704837257627; 
 Tue, 09 Jan 2024 13:54:17 -0800 (PST)
Received: from [192.168.44.231] ([172.58.109.85])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a05683022d400b006dc8ce3b8b6sm505460otc.69.2024.01.09.13.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 13:54:17 -0800 (PST)
Message-ID: <e48a1c7e-6a32-4905-ac5f-a5ebc0144d90@linaro.org>
Date: Wed, 10 Jan 2024 08:54:06 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] target/hppa: Fix PDC address translation on PA2.0
 with PSW.W=0
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, deller@kernel.org, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>
References: <20240107132237.50553-1-deller@kernel.org>
 <20240107132237.50553-5-deller@kernel.org>
 <48cc72dd-bf52-4cd2-a5e1-d7d1a7e08dd1@linaro.org>
 <9c8e5d0a-99e7-4332-bf69-a7e56a62c2e3@gmx.de>
 <f8056d9d-803a-47b9-9e2e-007d164829b0@linaro.org>
 <060dc700-e8f9-4bcc-bfda-0d09b81dc081@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <060dc700-e8f9-4bcc-bfda-0d09b81dc081@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

On 1/10/24 08:06, Helge Deller wrote:
>> What evidence?  So far, all I can see is for your seabios button, which doesn't run on 
>> physical hardware.
> 
> You are wrong on this.
> My Seabios just mimics the real hardware. And the hardware has such a button
> which is reported back by the PDC firmware.
> Here is what the Linux kernel reports on *physical* hardware:
> 64-bit kernel -> powersw: Soft power switch at 0xfffffff0f0400804 enabled.
> 32-bit kernel -> powersw: Soft power switch at 0xf0400804 enabled
> Just look at the old dmesg from another user (with Linux kernel 2.6.16):
> http://ftp.parisc-linux.org/dmesg/dmesg_C3700.txt
> (search for "power" in that log).

Ok, fair enough.  I just wish HP had been more accurate in their diagrams.  :-)


r~

