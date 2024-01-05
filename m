Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A4B825C4B
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 23:00:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLsDE-0008De-PQ; Fri, 05 Jan 2024 16:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLsD3-0008D9-6D
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 16:58:33 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLsD1-0003Jt-HW
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 16:58:32 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2cd33336b32so141461fa.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 13:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704491909; x=1705096709; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rTXe84X7ycrLtfWbDnQxa78JZNNc80rEwTvPwOJMnIQ=;
 b=Rol7yFDn96l/k4GBwGyTnKeWpEn0rs1aYsoFmfy1317UbjuYMED5WB11wwBaeIUEUR
 aySDHSqb2H9Jg+QMbMAHxBIr+aLxQ1z73Y6zvza7+uq9cE5ECZMDSrmSGTmcw1ZztBPt
 6ecqN1MfLAFdu5KwdxtErBqa+q9QCK4YM4qmDkOjbZdbnNa5hD+vbx6PliRpu2mc/fDM
 qXn7v+ktNx+8g5DCXG9q/7XBq3GbYHPf8w3MR9YjEGvH5dCBXkVMrwzGnpLWw/WdvFBl
 HRXFVyVNwVE3Kd6PwWJF3dCiDVht+p4Hc56gzkpPZb01qeCw/vSIFcje6yfKH3WdUgLZ
 Jiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704491909; x=1705096709;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rTXe84X7ycrLtfWbDnQxa78JZNNc80rEwTvPwOJMnIQ=;
 b=J2ySxFNr4obwlP1uXRHWcA4/iIIbSufi1mp4/ZNBA8bYi56cJmRSZIyepgt+iyUHcj
 SldPmHalv2YqGpeiURs+cRMezVhq+VxiQCCtDENbv6TYQQICuaXVrXT7kUPtmG7PheiK
 j1TQq05WX1N2CyikluaHy2PNlWqbGLGvnBlAlG1sxeGgJyD1YU39kKKZW8CvN5j7lVis
 LdQILeyr/Sb4wAQlFsJw/XU8JZP0sYiA2uvovHFRaivUVHWo+dj5SP+HHZcjJBFMFUNu
 KYHTf8O35+PY7eOKgYs6tABonReacBJ5nAz50G3MebAWaN5CUVfDhLtT0U+5UK7diwlO
 Mwjg==
X-Gm-Message-State: AOJu0YxpeN680AXyMbXO9Ft97wf/PMGkXoR+bD5JxefGmv/XjDm//YJV
 GABWuGygyxsK6mRMoUkRz3CnoBiSfwFQLw==
X-Google-Smtp-Source: AGHT+IGMJWNGXZ1in/L5RZVyYUGugjH2rjDfeHlqIWJdLerNcvX9dZQIpORRbgCbO9BIhNZiBDn3eQ==
X-Received: by 2002:a05:6512:ba2:b0:50e:4632:1d09 with SMTP id
 b34-20020a0565120ba200b0050e46321d09mr53083lfv.71.1704491909351; 
 Fri, 05 Jan 2024 13:58:29 -0800 (PST)
Received: from [192.168.69.100] (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 g13-20020a17090669cd00b00a274f3396a0sm1305063ejs.145.2024.01.05.13.58.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 13:58:28 -0800 (PST)
Message-ID: <d5a99a5a-f028-4155-babc-5e185aea3951@linaro.org>
Date: Fri, 5 Jan 2024 22:58:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/net/can/sja1000: fix bug for single acceptance
 filter and standard frame
Content-Language: en-US
To: Pavel Pisa <pisa@fel.cvut.cz>, qemu-devel@nongnu.org,
 Philippe Mathieu-Daude <philmd@redhat.com>,
 Grant Ramsay <gramsay@enphaseenergy.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vikram Garhwal <fnu.vikram@xilinx.com>, Jin-Yang <jinyang.sia@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-stable@nongnu.org,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
References: <20240103231426.5685-1-pisa@fel.cvut.cz>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240103231426.5685-1-pisa@fel.cvut.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

On 4/1/24 00:14, Pavel Pisa wrote:
> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> 
> A CAN sja1000 standard frame filter mask has been computed and applied
> incorrectly for standard frames when single Acceptance Filter Mode
> (MOD_AFM = 1) has been selected. The problem has not been found
> by Linux kernel testing because it uses dual filter mode (MOD_AFM = 0)
> and leaves falters fully open.
> 
> The problem has been noticed by Grant Ramsay when testing with Zephyr
> RTOS which uses single filter mode.
> 
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> Reported-by: Grant Ramsay <gramsay@enphaseenergy.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2028
> Fixes: 733210e754 ("hw/net/can: SJA1000 chip register level emulation")
> ---
>   hw/net/can/can_sja1000.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Patch merged as commit 25145a7d77.

