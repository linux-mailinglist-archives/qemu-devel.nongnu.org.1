Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6328F8333D4
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 12:21:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rR9O9-0001IV-67; Sat, 20 Jan 2024 06:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rR9O6-0001Hg-Kh
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 06:19:46 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rR9O4-0002U5-Oj
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 06:19:46 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e913e3f03so19618965e9.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jan 2024 03:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705749583; x=1706354383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8XxT+zWpinE2KG9kFzoXNAjkwKzRav0ogGN/bs3kOtA=;
 b=L0acavYvbc48RprLlhncwl0jmH+79zoiwxJyCD31tyyv4P31zKsOS/+kdsDwau/+fu
 J7t5soP/EnTp4TY0PYlDzaU+aHRdJJ/CQhXqFFAxcyFiUzlPHjb7cZHDJNdwphfgNLbG
 4jE+ViS2TaIYYTMtnworIazxL++hJL6bggSTZ9h6eC6bw4o9ZEQhQiT07/LhmnOMEe1o
 FtVRdAfOw5EDRU6+IW5DIf/UbTzqEWlRpJ3a0/MrIzGol8TQQGhPXICGY/fHCZUtuD7D
 xxLAa8MFj69kKKT9MFXpLmipT9z99CIrDeEV07izNvZ1O4F/H8ZmZA346XYE10JtKEMU
 yVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705749583; x=1706354383;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8XxT+zWpinE2KG9kFzoXNAjkwKzRav0ogGN/bs3kOtA=;
 b=F+DiFD2/vw0Ld4+oD+BqLqY4+RGhSYeJOtUX7DMKFXh4WPp1IBiWgkhi19fQAFT9lG
 ZTaxC2LJ2E4wo6Ge7voUwLggCp83V57t+p74SDtuAWFS1aKsHwaCWNDCOvsuqYbTJWYy
 eEip3yual9oBKj/Xc9ukALPjdKRUyHQqiTErfa18Db5QvGpcSA/ki2qYrTRD2OJgttJX
 bJPSZb7pOXvBric8/6Aigfv4V8M3sOvK53MEIdxBFxeni9Yl6VCwg0UnJOi4dDAFtC40
 6NZCaf8iRlBgZoKgJ43GylMYCE5P7EKwLOHfqglcBKClihh7fwHuAF0YMnJUc39TShEu
 2ULQ==
X-Gm-Message-State: AOJu0Yx4fx0N0hDGX1XkXTAiHh/9gY5vZvxhREwShfi315YjWI+RWacx
 FPhfo32tacBaDMKJFgD7T/1BHOgifeEIQEdFwWHwNRVCIa5NQ/eJ5IVF4BI4OEE=
X-Google-Smtp-Source: AGHT+IFeRqlQpTVghYSZbIMa2TVn/xfZqF3lbNoW8//VFD+tLWk9RN6sz3C1UsI0fc+046lC5Ql2pg==
X-Received: by 2002:a05:600c:a43:b0:40e:62aa:fa7b with SMTP id
 c3-20020a05600c0a4300b0040e62aafa7bmr718082wmq.111.1705749582784; 
 Sat, 20 Jan 2024 03:19:42 -0800 (PST)
Received: from [192.168.1.67] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c3b9200b0040e4ca7fcb4sm32238107wms.37.2024.01.20.03.19.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jan 2024 03:19:42 -0800 (PST)
Message-ID: <2ce78985-6262-4d9e-9079-24947e62ed85@linaro.org>
Date: Sat, 20 Jan 2024 12:19:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsl-imx6ul: Add various missing unimplemented devices
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>
References: <20240120005356.2599547-1-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240120005356.2599547-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 20/1/24 01:53, Guenter Roeck wrote:
> Add MMDC, OCOTP, SQPI, CAAM, and USBMISC as unimplemented devices.
> 
> This allows operating systems such as Linux to run emulations such as
> mcimx6ul-evk.
> 
> Before commit 0cd4926b85 ("Refactor i.MX6UL processor code"), the affected
> memory ranges were covered by the unimplemented DAP device. The commit
> reduced the DAP address range from 0x100000 to 4kB, and the emulation
> thus no longer covered the various unimplemented devices in the affected
> address range.
> 
> Fixes: 0cd4926b85 ("Refactor i.MX6UL processor code")
> Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> This patch is necessary to boot mcimx6ul-evk with Linux v6.7.
> 
> My apologies for the noise if a similar patch has already been submitted
> and I missed it.
> 
>   hw/arm/fsl-imx6ul.c         | 30 ++++++++++++++++++++++++++++++
>   include/hw/arm/fsl-imx6ul.h |  2 ++
>   2 files changed, 32 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


