Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEF5811452
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 15:10:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDPw1-0003LF-AD; Wed, 13 Dec 2023 09:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDPw0-0003L7-9p
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 09:10:00 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDPvy-0003ah-Pu
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 09:10:00 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40c2bb872e2so65182045e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 06:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702476597; x=1703081397; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gNawU6o/SvjCX7EzoeKEF/qpHrKnVdxw/MCicI5ApRA=;
 b=mbJ/DOEGjRTAkPbeb9gVcF5gFAc3l2WwG7Sqes0wG4eWDp8X2plpPK9jx6A3ztOCV3
 443HqpHoR7FexRRYZ6Ti+gZn2dlfTVL15V1wHBF7/jPfLAhL5JJQnS0O+g4z9jJAXil1
 HOWSZzztyThnAEP4NpTSTZxLxW5g4awvFkue8E3OcjgnZpnBSQAJUNYkS6VB0QBkX832
 eDcHkw1FnJe3FPm/ZsXB1mWutk080EuuPNs8wrCGSYlJ/71WQw1AsOSgtuhvZ0dyOeml
 GOo7Xa6n+orke+u96mPp8RgysgXTVPqUt6XUveMaENxLSCadNgcY2wfjenIB5hPTj1AV
 OZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702476597; x=1703081397;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gNawU6o/SvjCX7EzoeKEF/qpHrKnVdxw/MCicI5ApRA=;
 b=jaRQ89zzEIIBf/UVTsNuucev9V7foBSrOLrF8NesWnW24wxTDVTaBR0SOPmh3e56By
 qGY6R3lkgPh1ChY6ZW8rjgHoIVEbQTwXcAC0dAABRFVcqRTN6JmM4hos0/e1HIXgD/yT
 8i3/Bu+eAOncTh37XZpjhzIeU9MxBFWbG/xS99C9GmbstUdPfhhemzwZ56z+CzyVSFQ1
 baXUW60OgA5gLbEGpHrOSDlaiBEKVk0VLlkzajGYLp02HB5+nYXc7BX5h1mg815WVy7a
 rFiuy4azIC3GAHvz6NnlK3OsKENmkpqsBpIA47g7wVF2nslZUuFE/MOCrkcfUtExp0Dp
 7HJQ==
X-Gm-Message-State: AOJu0YxK2MUzsEqI6harW4TmRblplWsiRGFpEiylRZsg9ThXdida2oSl
 Jruj+5SavUyxZv8z/HLfwX1v68nSqov6e/7GJCeR3A==
X-Google-Smtp-Source: AGHT+IGomJIvmqI/0Q314DHwQmrp4xntkbqnIGC4jpvyKizprwbflmeOCoTge43grr+2/CMaReiYAg==
X-Received: by 2002:a05:600c:1c1f:b0:40b:385f:24b5 with SMTP id
 j31-20020a05600c1c1f00b0040b385f24b5mr2026630wms.15.1702476596984; 
 Wed, 13 Dec 2023 06:09:56 -0800 (PST)
Received: from [10.123.141.145] (sncfv6-vip-ucpctl.hotspot.hub-one.net.
 [213.174.99.133]) by smtp.gmail.com with ESMTPSA id
 bi8-20020a05600c3d8800b0040c43be2e52sm13149461wmb.40.2023.12.13.06.09.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 06:09:56 -0800 (PST)
Message-ID: <ea3bcdff-47d7-4002-bb73-c24264f4e973@linaro.org>
Date: Wed, 13 Dec 2023 15:09:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] tcg: Mark tcg_gen_op* as noinline
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231029210848.78234-1-richard.henderson@linaro.org>
 <20231029210848.78234-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231029210848.78234-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 29/10/23 22:08, Richard Henderson wrote:
> Encourage the compiler to tail-call rather than inline
> across the dozens of opcode expanders.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


