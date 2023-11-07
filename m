Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE7F7E3B51
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 12:48:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0KZ5-0004Yg-9v; Tue, 07 Nov 2023 06:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0KZ3-0004YX-JB
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:48:13 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0KZ2-0004LA-2P
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:48:13 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507c5249d55so7287222e87.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 03:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699357690; x=1699962490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qj3AS9SL2giOeYDe2JY+j8efbg8X4C3EoZTMu980FEc=;
 b=geNuu9wdHWNn6FJythOFXIZphig9YJWQnSLxYoa0nxIh/Pplz8zKLjUavIdlDrCev4
 9riacknnZpABUEAXDjM08g5Jbm0uMkC4asbXsdO9611aLq9ycOhIO7ID5lvkxu/ZpOGD
 j29mN73lEemc++0nB2C7a9OodEwwPO4h9v+bV+2vgFcCIgwzsiFD51mhGA78tIL3WUxD
 wW/8wLjkq5YHPSDJIWnEisttz7Uh5x/v8hc0ZXL+GZUVnH7j/PtbmAVozHM4TRW/xwcT
 SkiQMT1nULVhQ/NofZtr0IKdu/mlfT6KkAfXJJGvyX8ZeVIw5dTFc1X/evOI3zuLQaCn
 NXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699357690; x=1699962490;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qj3AS9SL2giOeYDe2JY+j8efbg8X4C3EoZTMu980FEc=;
 b=TFePWdh5ytX/XwMOXddcCz99/DjhW6Onu6rAxf582JRV/jLxIsnYsXgW9d3LCCSBJK
 EqEFPIdTXh9g/PuDW9+djW64fLntIRgXznVSj4HUGaQlsI+p/PSwzVsYjYDbLZoZEwK3
 b2Jy0gaK9Z4I+S7WflqvEDiDUTTHt7sjiErlCDk8FOuevjzXS9Z6aalHSOsJCMZGFvKL
 8fzIHo6Rd30yDktekYom2EYTEBm/lY1/MlPx7Fh7BziCc6nWUmDKC12Lm2afSBvMiVN2
 nlL5sRkdPdHKSbRKvY3lmY46YKCfYZ4J/rUALdp48LUBaJPjq08yeIlAB9Vha/D17Lj6
 PZxw==
X-Gm-Message-State: AOJu0YzY4Y0dI4o2aG8ay15CuOtqTXVo7cMWYnrbteCxdCM4l5bR/Fux
 iA89y4krZvd1R9wyiByYoLJDjg==
X-Google-Smtp-Source: AGHT+IFFlEUXNgl/VYC97AIb8fVySJVJkEJ10J9gV0EPI2e8gdSmEpbTG0f96yYk+9w6A/HYZa+opQ==
X-Received: by 2002:a05:6512:488e:b0:509:d97:c850 with SMTP id
 eq14-20020a056512488e00b005090d97c850mr21917436lfb.31.1699357690075; 
 Tue, 07 Nov 2023 03:48:10 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 o29-20020a05600c511d00b004083996dad8sm15475932wms.18.2023.11.07.03.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 03:48:09 -0800 (PST)
Message-ID: <21eb4e0e-9828-4288-808e-a9ae3b2d417e@linaro.org>
Date: Tue, 7 Nov 2023 12:48:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dump:Add close fd on error return to avoid resource leak
Content-Language: en-US
To: Zongmin Zhou <min_halo@163.com>, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org
Cc: Zongmin Zhou <zhouzongmin@kylinos.cn>
References: <20231107024417.585475-1-min_halo@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231107024417.585475-1-min_halo@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

On 7/11/23 03:44, Zongmin Zhou wrote:
> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
> ---
>   dump/dump.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/dump/dump.c b/dump/dump.c
> index 1c304cadfd..ad5294e853 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -2160,6 +2160,7 @@ void qmp_dump_guest_memory(bool paging, const char *protocol,
>           return;
>       }
>       if (kdump_raw && lseek(fd, 0, SEEK_CUR) == (off_t) -1) {
> +        close(fd);
>           error_setg(errp, "kdump-raw formats require a seekable file");
>           return;
>       }

Since I'm preparing a PR, I'm queuing this patch, thanks!

