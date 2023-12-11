Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC7080DE19
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 23:21:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCoe0-0000zl-LO; Mon, 11 Dec 2023 17:20:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCodq-0000zb-Ok
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 17:20:46 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCodp-0000k4-5F
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 17:20:46 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5c65ca2e1eeso2590358a12.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 14:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702333243; x=1702938043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EpDB/5IQWEPKIWYFlEV7QmJWtmhWTHZzUjZgs7EEOXs=;
 b=Rw5s2jxWZRy+OrZCIC5KoBQUrxc4VplYSBJt/5R4OqkS8gJuuqGdWiCPTSsLKjfWln
 1vgOyGgFhXuoZIifWyqdJCL2nHC3UMPIKMy4rHTwXX0vmDuoAkHL0uOmLEu26kUrnFtM
 zTKBVQitDqat1fMUshy2JVcYwZM7Pq5pFfGYf+gYoHEk9NkYDk4drfJaTZpCbUKWzN7E
 205oRsg9pgUhdvSoJPvEYaabeY6F2eN2L7DFy9a/2/q+xpPfGMkkRJTXfGBGDIUCZLwZ
 Y1fxAWgit5fNPJqkI5tkUDan6X17AVwmAdKBX3qZ/+fMbsmRUYk8npf3lelG4O7jBBBL
 yDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702333243; x=1702938043;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EpDB/5IQWEPKIWYFlEV7QmJWtmhWTHZzUjZgs7EEOXs=;
 b=CCZDuAiDWKketCs3SacQl/A14D2ncO0JQn+mUgwAX64HvhjxkrKmW4bmhCMyYBnypc
 hBIZq9cVdt5zffucciKQnrPHByHRMGOK/3XKAoAQoi04eNcbhgrj8APtTYNmfsOmZ/wE
 DsQYXvCbagbtK9uz63yzDtzP7DaNfCTGntdjEbBfuhjJBy3D/3woKC4G2qU4/QLvH6a1
 SGEexzpKrBSVkkVsgUrmwfdz1O4FouU8SWzCLpjVWLGQ49tCC8A1dIkhNgwOGtaOplYe
 PSuY1xSmOxgf5E9mhjteJG0/i81tb3Q3AEGl3NugNcLD0DQqghXMZEHbhiUTzysA7kVF
 P6jQ==
X-Gm-Message-State: AOJu0YzwH5tO9wz0MyGVeYB/6YnvpQzwKzt9AYtXnX3yQe88WNcNguUa
 Wvc+ejo0tXirpbhr58tQI6iu/ak9xuAVktwy+oOaZQ==
X-Google-Smtp-Source: AGHT+IHNsW2gfn5GJXPVxN615y0aD5yibuSFjZ8rZ3FihjPp/p9QHdkKSEdewW3QyWmi/n91qebJNQ==
X-Received: by 2002:a05:6a20:1455:b0:18f:97c:5b7d with SMTP id
 a21-20020a056a20145500b0018f097c5b7dmr2624552pzi.75.1702333243583; 
 Mon, 11 Dec 2023 14:20:43 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 jm2-20020a17090304c200b001d2ed17751asm6846406plb.261.2023.12.11.14.20.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 14:20:43 -0800 (PST)
Message-ID: <8ea729f2-46e7-40af-aaa2-196c14e10c92@linaro.org>
Date: Mon, 11 Dec 2023 14:20:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/24] accel: Include missing 'exec/cpu_ldst.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231211212003.21686-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 12/11/23 13:19, Philippe Mathieu-Daudé wrote:
> Theses files call cpu_ldl_code() which is declared
> in "exec/cpu_ldst.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/translator.c        | 1 +
>   target/hexagon/translate.c    | 1 +
>   target/microblaze/cpu.c       | 1 +
>   target/microblaze/translate.c | 1 +
>   target/nios2/translate.c      | 1 +
>   5 files changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

