Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7711882C668
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 21:41:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOOJX-0001uK-9a; Fri, 12 Jan 2024 15:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOOJT-0001se-0x
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 15:39:35 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOOJR-0000ed-6p
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 15:39:34 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d3eb299e2eso45560675ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 12:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705091971; x=1705696771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WWV0a1mcIp+LqXwhfTlWyKlZwm/P+HXXqZoy+uSbLrQ=;
 b=Ta8LQrg1d58agi9f3PI9Q00xQoflUQDz/21xd3d8sWctqtZVShh0K3hbg44e4D24Xq
 zA8lQ8bEHTWz188yPDIyYFknZXvEgxWVjoLXPP79KyM1ODGP75u1vidpk147OANAdClM
 zp2AZdOn48gpUs4dZqPgjDCQqNtrH180Q22rTk9RVuaQuRbHIydE9i8c3s0Le2dI7Tgx
 nvPc9hwoMnvgZsjzA1whLWT4jrTWvsEMH7qRx4fKGKbZ9xFau7I2TihGMRZ+E3zcHRBQ
 GSQa9lbefKtABMQvArA45zGCQxouf+98HWcQbMLh9nEBT5Mm4Mj3WWjjCLUJFKOufmT1
 C55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705091971; x=1705696771;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WWV0a1mcIp+LqXwhfTlWyKlZwm/P+HXXqZoy+uSbLrQ=;
 b=Pco0FLVMPPPGhnZRRCJZWUxoEls8X5sMC6Yc2Lp/xUVG5qLFdi31zERUzsxVYNm4Be
 6MeP4qPvWl+gH/igGZwssFuxMoMSQBM1WB9zimTfheKzbKbe0JmQJal6MUrVkMJYxiN3
 ViXVk3OJ1U8G+1VeuGBK+7XBKzO+e3SZ/W4oFd7gcGNASzMVEtIfTmkuUWPySFsfNrJa
 C+YhtJleHSdv5U9/nsoSq6MkPlULpfJCdtooDPIi74AOHvmkCUo6rvNf78Uz2lG6y8wJ
 MAMBwLTbNitrmgfmWZpDqScAOXe3tNWVVyxiufVTW8vRszboNdiI/sfbiifkJbCM/zKL
 aVuw==
X-Gm-Message-State: AOJu0YwXYgmix+v9k/aN+MkmbOcFa5qY+l+XXS4JZVcKHXpsi9sGKrAv
 3eWjPk6uZHKvAOzclIfagrsJgud638uJUQ==
X-Google-Smtp-Source: AGHT+IFo5VtjmWblO6J6etWjqdhsVBTBSdejvu/1Waws+hjMfpj/KyRr6EU2mS//ojn2x6Fkr9vORQ==
X-Received: by 2002:a05:6a20:1692:b0:19a:5b2f:b516 with SMTP id
 q18-20020a056a20169200b0019a5b2fb516mr1086740pzc.2.1705091971569; 
 Fri, 12 Jan 2024 12:39:31 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:2ad6:e985:c1c8:a4fc:508?
 ([2001:8004:2728:2ad6:e985:c1c8:a4fc:508])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a17090b005200b0028d70a8d854sm6951542pjt.54.2024.01.12.12.39.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 12:39:31 -0800 (PST)
Message-ID: <03a2ae5d-8958-43d8-bb4d-00d8e9d117b3@linaro.org>
Date: Sat, 13 Jan 2024 07:39:24 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] hw/hppa/machine: Disable default devices with
 --nodefaults option
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20240112102927.35406-1-deller@kernel.org>
 <20240112102927.35406-3-deller@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240112102927.35406-3-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 1/12/24 21:29, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> Recognize the qemu --nodefaults option, which will disable the
> following default devices on hppa:
> - lsi53c895a SCSI controller,
> - artist graphics card,
> - LASI 82596 NIC,
> - tulip PCI NIC,
> - second serial PCI card,
> - USB OHCI controller.
> 
> Adding this option is very useful to allow manual testing and
> debugging of the other possible devices on the command line.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   hw/hppa/machine.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

