Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B98780DE17
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 23:18:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCobS-0008Ov-8O; Mon, 11 Dec 2023 17:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCobK-0008OT-Qg
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 17:18:10 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCobJ-0008Qa-Bm
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 17:18:10 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so4167699a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 14:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702333088; x=1702937888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vfttfDW2o0r3ZHxmhl7mo+KlrcLIFItJRCMpYQaKJ1A=;
 b=IBmqy+TpF8g09rpdZaWGBz9PZyyyfx4/gQ/OSwd8TtpPfIHLpdRp6oP3EShc+ZNvuq
 Tg3QZG4mgJ2+Ly1yCQ9Rc73HbGD7LJL0c3St7e4d7uPLXcuoZdVxjMHoZkO7IeYqpU7E
 EFqFVv9dvphQHGs0u5ux5r9I6NT2c/8T3HxFi4ORs8R1gHfEh1SnnRED7axiVpZRnfyU
 lr5vO0dKtx5WCzqElqVDY7YEDr7+KizUPXB/LiMJiYSdYwDIjT5SgSr4k5cba8woliQS
 KKGvRNeYL8ZVE6IEOL+pUoZQ6SrbbSVcknJA4UrUhBledbEh3uYfz8noIPm7Cf2vY0+x
 ETJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702333088; x=1702937888;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vfttfDW2o0r3ZHxmhl7mo+KlrcLIFItJRCMpYQaKJ1A=;
 b=hgjYimDnhEKhJkpH2JJpzqJLvm85NTnY0rDW6NEKv30vz8C61uUL7eV+G6Y9roatKo
 4Q+N17zqZgYjxU9sgR4IwKkQIqeOPe4AYSVsor1IeRVs/d5ALbK+795ac1hVZwRF3xzP
 D1OE6ZIHUwCrQgZ17ApbZgN0J0xjVXQ3xkuTOMNxmUlkj4RjjKlUau/ON9l3HI6ElTXS
 UL324laTX17Aes/HhyjHzq2cVSMj2yDDgcwcKg/U6hjsGOrC11V6KTRdJkT/XhIKk4er
 HZbhuY9uvNjrBtTW9e0C7xlFgBBpyTQ/Or8vqnMPRFPigdl0g2+Cqw38LjZhgItjB4xu
 1BQg==
X-Gm-Message-State: AOJu0Yx287x+/acI5dqGHep38F0LrygagDO3hWmpVQisLgHF6uslvblo
 uKvsive172/JSaQUQlw1SfxYfwfIzRvBnXMVrTp1rA==
X-Google-Smtp-Source: AGHT+IGckpcIP+b2OXkVflxAN+EcKgv9DbTLXZnL1b6itgbUb/KJxsajNbuTsf9KlifIVDwIDvx4UA==
X-Received: by 2002:a17:90a:9c0e:b0:28a:464d:5ec8 with SMTP id
 h14-20020a17090a9c0e00b0028a464d5ec8mr3807678pjp.41.1702333087906; 
 Mon, 11 Dec 2023 14:18:07 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 27-20020a17090a031b00b00286c1303cdasm8227255pje.45.2023.12.11.14.18.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 14:18:07 -0800 (PST)
Message-ID: <caadef4b-ea56-4f56-8e06-aa0107886262@linaro.org>
Date: Mon, 11 Dec 2023 14:18:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/24] target: Define TCG_GUEST_DEFAULT_MO in 'cpu-param.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231211212003.21686-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
> accel/tcg/ files requires the following definitions:
> 
>    - TARGET_LONG_BITS
>    - TARGET_PAGE_BITS
>    - TARGET_PHYS_ADDR_SPACE_BITS
>    - TCG_GUEST_DEFAULT_MO
> 
> The first 3 are defined in "cpu-param.h". The last one
> in "cpu.h", with a bunch of definitions irrelevant for
> TCG. By moving the TCG_GUEST_DEFAULT_MO definition to
> "cpu-param.h", we can simplify various accel/tcg includes.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

