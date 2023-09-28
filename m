Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F5D7B2790
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 23:33:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlyd6-0004eO-H6; Thu, 28 Sep 2023 17:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlyd5-0004dy-8J
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 17:33:03 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlyd3-0004x7-Ni
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 17:33:03 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-54290603887so9100373a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 14:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695936780; x=1696541580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T9GYYBkSjuuJtd6UwJNpWZsTEpMdFJMD+rIWUizfU7Q=;
 b=enXZaSuhpnFlYZnQbA9eeS0A9FL4rseT61JGgGIDPn5XbD4ZTaoKoTUF+Tm0e/ayO1
 wc290+4iJZ99j0xu4dhs8CYGdoXXSi2z4CHcTu3uw26i7rHjaSZr1j+HL2sEcY2L3z4b
 FjjS29cVXk/wikpkmGCBRndNJKhwl2sGD/LDnQXfcP16rNv7MjsCNYhX1GXCYK8Nxbn4
 UhCyRNzMu+xHypi6oxb6zaInEvNcGP7eUGTu6+pqQ9D/lJoxFzJB9cG+VD3GjArjVuTm
 2/ZMxX3B0WhVaOS/7QpD2PRp9nwjD3Z4Qy1amfGiKIdbj+iTSc1zMJN2FS1c23qlQqoA
 TrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695936780; x=1696541580;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T9GYYBkSjuuJtd6UwJNpWZsTEpMdFJMD+rIWUizfU7Q=;
 b=dUCVnQZLgLAf+WuiB4YAwb6WC06YxAxuCm/N1VNZAJBXfNm0ABfgsx0/7UrZMlyYHS
 6zz/gY0hLW4/37RH81Gwt+xyzwUx9Qo7sb4MLMABW0TDOYXOUMfYQhxMsAC+OwBq3Deu
 TD3fWUQPg//ZjfRgGCjLmo29W0qezPlBAgL/yt/Vu3UXJte3p7VZewZ5zC3Z9cB+7ZDz
 ffem8Ihqakqx8QMdXbkI5+47xGT7sH/LxsKO40Jtj7GdwblSRwTVAirx9asPHR0kjkIj
 5m+bydTNJFHhnGoVnaC0U8bVE7W61Lb40ZC6ph6Z8g191EFpQdjRqsNGl8Fu2YWR4UEq
 Eakg==
X-Gm-Message-State: AOJu0YytM1nWvt/3/eP81g0JTSnK/VXL4qiaD22OQFx5EwpKPq0xpMn6
 iY9Cc7VkYO9CW/s0k+6m6D8EgQ==
X-Google-Smtp-Source: AGHT+IEzKuOGjgWOtobhzfSndLphhL5W6TYT+RqUTVmxOtzYuksArF93BU/OQPU+hlpYXB9pVnRvlg==
X-Received: by 2002:a05:6a20:971a:b0:147:d861:50e4 with SMTP id
 hr26-20020a056a20971a00b00147d86150e4mr2319394pzc.33.1695936780261; 
 Thu, 28 Sep 2023 14:33:00 -0700 (PDT)
Received: from [192.168.0.4] (174-21-146-124.tukw.qwest.net. [174.21.146.124])
 by smtp.gmail.com with ESMTPSA id
 14-20020a17090a19ce00b00277371fd346sm13176pjj.30.2023.09.28.14.32.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 14:32:59 -0700 (PDT)
Message-ID: <c27164d6-ec12-7516-bc5e-76e744a34a88@linaro.org>
Date: Thu, 28 Sep 2023 14:32:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/8] target/sparc: Fix VIS fmul8x16al instruction.
Content-Language: en-US
To: Nick Bowler <nbowler@draconx.ca>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20230925050545.30912-1-nbowler@draconx.ca>
 <20230925050545.30912-4-nbowler@draconx.ca>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230925050545.30912-4-nbowler@draconx.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 9/24/23 01:03, Nick Bowler wrote:
> On a real UltraSparc II, the fmul8x16al instruction takes two single-
> precision input operands and returns a double-precision result.  For
> the second operand, bits 15:0 are used, and bits 31:16 are ignored.
> 
> However, the emulation is taking two double-precision input operands,
> and furthermore it is using bits 31:16 of the second operand (ignoring
> bits 15:0).  These are unlikely to contain the correct values.
> 
> Even still, the emulator overwrites the second input before all outputs
> are calculated, so even if by chance the data loaded in happens to be
> correct, the results are just garbage except in trivial cases.
> 
> Signed-off-by: Nick Bowler<nbowler@draconx.ca>
> ---
>   target/sparc/helper.h     |  2 +-
>   target/sparc/translate.c  |  2 +-
>   target/sparc/vis_helper.c | 11 ++++++-----
>   3 files changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

