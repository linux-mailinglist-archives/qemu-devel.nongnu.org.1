Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B17CF7A673C
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 16:48:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qic0m-0001Xb-4P; Tue, 19 Sep 2023 10:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qic0e-0001XD-9I
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 10:47:29 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qic0c-0002Ty-PY
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 10:47:28 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9ad8bf9bfabso760045866b.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695134844; x=1695739644; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bWXLOwUOyH6bM0XqPx5zqImf/Xc9BrT9UPVWhw0CXSU=;
 b=RJojs3dSB2cXAUg36QwBH7JeOM+aEvr5tFXCWYLhuUJGqzCT6zgCj0zcIvXA5/OZek
 dc32+kh37HU7KO39D906eJcqqmEqn0ReBtAsTd002KPxy02Y/sGcjNTenBEzrGPRua9x
 VRvfyH6vSOzViu5qtNIlj2/ovC0EKir2Xv1IHEcO8cyJyVY13fwB9D8+LDUMHUWkLOKS
 i2HxN355lYP4NdFC76bbJ8Iw5bDRsTEY7C61ienEb1FZqbHx8fhMZ+vJXi+0dWT50gQ/
 KywjQhfTVKS+aBN1q+CxGelPSin86pRuuT17TnnjTeO61c+cDRr7FnQqhtj3xsPILKIr
 e0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695134844; x=1695739644;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bWXLOwUOyH6bM0XqPx5zqImf/Xc9BrT9UPVWhw0CXSU=;
 b=qu+jAyOB3qLO8RpSYTyQa97guG///+J2DX1BSXjl9XRtY0TKfQqeE+/Y9wF1g/fEx8
 DiUkO5mOwOdX794fDdCe3VxMl3q8V4aVWUCjj8vCkCGZru0/r1/G6Xg49eM1/GJysa5h
 AiwVY59U6+Vauul5gRAKJTxawyv3UNOm+AUX2+tX/lTuiVMH2NSh9koHNmG62m5rMG5c
 PfCy09Fh+b8tYfRkTPWygqOmcqlhPYcpoxF8pLbhPb1ClLrAaXZkUtK1U1dsNr5sZ73K
 vevGO70hOgKHUSBaF9QBdz7FlGRSYCzqOHZbhGap3kM1dHsBGg4E7oLl/0hOJNCUfWQi
 1ORw==
X-Gm-Message-State: AOJu0YyKQmV05GyfmhUUJ4Iiv7Ko4BvSjM7PjzZNO/m4CPy1ap4hSDKG
 P03tQmhCRSjA9sxh5oYMMYM3ew==
X-Google-Smtp-Source: AGHT+IEole8+hOWFbk6qeSlyoniY3D3l2FFqIkFCIy1dlVT4+GKRtDcNGlPTKYwA++iwntrpe9lnqQ==
X-Received: by 2002:a17:907:6087:b0:9ad:b80c:c19d with SMTP id
 ht7-20020a170907608700b009adb80cc19dmr10374912ejc.56.1695134844185; 
 Tue, 19 Sep 2023 07:47:24 -0700 (PDT)
Received: from [172.20.66.192] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 uz3-20020a170907118300b0099cc36c4681sm7900268ejb.157.2023.09.19.07.47.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 07:47:23 -0700 (PDT)
Message-ID: <3da45238-d1c5-d318-16ab-b03819e35da8@linaro.org>
Date: Tue, 19 Sep 2023 16:47:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/3] accel: Factor tcg_cpu_reset_hold() out of cpu-common.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 Claudio Fontana <cfontana@suse.de>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alessandro Di Federico <ale@rev.ng>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230918104153.24433-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918104153.24433-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/18/23 12:41, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (3):
>    accel/tcg: Declare tcg_flush_jmp_cache() in 'exec/tb-flush.h'
>    accel: Introduce cpu_exec_reset_hold()
>    accel/tcg: Factor tcg_cpu_reset_hold() out

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

