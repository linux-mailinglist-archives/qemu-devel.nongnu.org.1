Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F205830132
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:22:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ1BY-0007ja-I2; Wed, 17 Jan 2024 03:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ1BW-0007iW-NR
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:22:06 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ1BS-000633-6j
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:22:06 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e76626170so30945965e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 00:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705479714; x=1706084514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EmEum774Ua+C6UqJ8Bit+z7AWBLq2AIE2JojPLeEIcc=;
 b=fJ9/HQ6tD+ff37q1bFRwvsvPtA6vrhgUxNkTntjk3PA7kJFr+Drj0G0K8MDcZIcV1i
 yBqI6K3/yRSCglUrhk2l9WMJeYkOmtUjg79aqNuVujlackP6Zx79VpB538YyVjxS38vx
 wYa1kLxX6zKlGGfsuL9vv5THOWskIfz7jMS0zhImDRJFhBxxLR0FgZ2TKHQbwOZGmHB8
 y+HQr33qiR0YkFUbFWRd3r46lKHt+nZYnWNEqPhteTiWXevwLi3bar29kSrH6Oy4BheR
 iPcH0IttYMEnbHiSU0fgLJy/YkqvtAhxkXUIr/5GKu+UsjFMEhFix0dmWr092ovUAyxM
 dKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705479714; x=1706084514;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EmEum774Ua+C6UqJ8Bit+z7AWBLq2AIE2JojPLeEIcc=;
 b=CNKTEi0VdtgonyE0Mr+drXlp/OHtmSKskeAtmqsaGvfqbgyWF87rmOXKdSVTmn+3Xr
 ZNl7FLswP0sRuseKaPCGys8AodOgtbUfMg1dxhsZPli9H8ZkGb6uapPZ6XhSgUcdyzYN
 Sr4PMZnl89SQErwFjAHK4dey+7hwQH/mHp7syGx62VpKmI4Py2f0nRVxLc55w0FRTodP
 SsDeBgSUW+fKfbo5pVvCjDUbXS9PFPFuBrOM9nAANneFFciL7dlcLTLXotJ3dZg253wB
 GgDgmAE43wv0lhrbYvCKqXXa6itJInovFMflbDcFfI7ybxkxzzjdAuTHjvMIP/xs4S8K
 RDSQ==
X-Gm-Message-State: AOJu0YyGEQdkDKqkiK9DuOJn5vTfAxwTusYgFwJBewjq4Y6LIyMHpWdm
 EdQ0snlPM2vvM5vpfVzOwFejVfb1NdUKXa+rl1MtE4XAmDc=
X-Google-Smtp-Source: AGHT+IFPSzPw/kVDyDOP6/WZh25egAVZLnU9Vg1fshvSVNh6J/N0VRAS03THAvLk+MvCySab91HdwQ==
X-Received: by 2002:a05:600c:3551:b0:40e:4806:f42a with SMTP id
 i17-20020a05600c355100b0040e4806f42amr4707119wmq.15.1705479713781; 
 Wed, 17 Jan 2024 00:21:53 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a5d51cd000000b0033673ddd81csm1033645wrv.112.2024.01.17.00.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 00:21:53 -0800 (PST)
Message-ID: <a6146842-4202-4cca-a193-901bee53f1d3@linaro.org>
Date: Wed, 17 Jan 2024 09:21:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] sysemu/replay: Restrict icount to TCG system
 emulation
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231208113529.74067-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231208113529.74067-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/12/23 12:35, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (6):
>    sysemu/cpu-timers: Have icount_configure() return a boolean
>    system/vl: Evaluate icount after accelerator options are parsed
>    sysemu/cpu-timers: Introduce ICountMode enumerator
>    target/arm: Ensure icount is enabled when emulating INST_RETIRED
>    util/async: Only call icount_notify_exit() if icount is enabled
>    sysemu/replay: Restrict icount to system emulation

Thanks, series queued.


