Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 426B67F44B6
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 12:11:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5l7k-0001w4-HQ; Wed, 22 Nov 2023 06:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5l7f-0001vm-0F
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 06:10:23 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5l7d-0001gp-DM
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 06:10:22 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-332c0c32d19so2802254f8f.3
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 03:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700651419; x=1701256219; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vQYdded+nNhrvOuaSIFjiUL+tKO6S6O0UnMYXjwEKd8=;
 b=h+1IMpLbZj3snuacdwnQfju4h6LgivzjVpOOfDeQNZhsXPHtqpFsKt/vZ0x/YI0PxJ
 0S4BqJ6/nBnlYfBm2hkM6osxN/JziHawJ3AUJmjL12ypfqxpxQlxj6RjAtlObuOqOHqE
 dn8p4NeLA1FtFj3mJHNhRHrsayAq38GlkQnGUBiOUfjPx3H4/OgVZjdjBGjF72kboxWA
 Z90I2LnllMYS3P+f86Y5NmEU+wKJKh6h3A01RElUk7HO+GXVsXmIXKK8aUb1UqsMZ127
 8OnYWGLSxC2WJCz+KeM5HcW04+i7rd6JH2bL/TZvgxfLYDvYEVNAf4SgeUC5oDB3X1Se
 ko1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700651419; x=1701256219;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vQYdded+nNhrvOuaSIFjiUL+tKO6S6O0UnMYXjwEKd8=;
 b=RbxRs/NfLH5IAFmxbLI9S0ke2UfDOq54rZK7R7ej647vwBiUDROFZMWkMNv4jMaA4u
 mSBDsNbFOnjxiIZgGRI4Et/shGk0gsDfvoEHHqDDvvsARht0bTHqId6cJq/1ICcHYxRK
 x1ZQNZBxrj26TmFeoONBfgMbbgBVp1oFmHXCEBfB0M7nWYxJsIRGadPzkO//h2s2C8oN
 n1gAToSxGtif8nD2vsq2rgZdgkGzFUCsJpfaw4VB1SKABc5CL2U6PRagBGV73GV5vpEl
 HWJ7rEvcZo/S1AUkz4Kd5Bm3FWxtHqT22Qc6LN6BrhQKTcVcb0rXhMtHXg/zGLUo9LP6
 xFtQ==
X-Gm-Message-State: AOJu0YzUiJ+6WTMRebdmc6ulaFGC6lVRMEjCBFPRVFRJo2tIvvUK7KD0
 fp0T8/KWfw1S9YNLm5KfYvfswA==
X-Google-Smtp-Source: AGHT+IHFtoIhvI7XyWoi03yjuzCDw9EKhPJEVhtLD9H3cdNWjGdLeQwdvsxaRORcYkj9lpXeOZDsGA==
X-Received: by 2002:a5d:6803:0:b0:32d:5cc0:2f0c with SMTP id
 w3-20020a5d6803000000b0032d5cc02f0cmr1281724wru.40.1700651419546; 
 Wed, 22 Nov 2023 03:10:19 -0800 (PST)
Received: from [192.168.69.100] (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 r15-20020a5d6c6f000000b00332cb17f87csm7232590wrz.5.2023.11.22.03.10.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 03:10:19 -0800 (PST)
Message-ID: <3c095762-20b8-41eb-8027-854bdbb2affe@linaro.org>
Date: Wed, 22 Nov 2023 12:10:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] xen_arm: Set mc->max_cpus to GUEST_MAX_VCPUS in
 xen_arm_init()
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20231121221023.419901-1-volodymyr_babchuk@epam.com>
 <20231121221023.419901-6-volodymyr_babchuk@epam.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231121221023.419901-6-volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 21/11/23 23:10, Volodymyr Babchuk wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> The number of vCPUs used for the IOREQ configuration (machine->smp.cpus)
> should really match the system value as for each vCPU we setup a dedicated
> evtchn for the communication with Xen at the runtime. This is needed
> for the IOREQ to be properly configured and work if the involved domain
> has more than one vCPU assigned.
> 
> Set the number of current supported guest vCPUs here (128) which is
> defined in public header arch-arm.h. And the toolstack should then
> pass max_vcpus using "-smp" arg.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> ---
>   hw/arm/xen_arm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



