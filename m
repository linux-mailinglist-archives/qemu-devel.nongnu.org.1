Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D0B81E710
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 12:19:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI5RA-0003Ow-Tj; Tue, 26 Dec 2023 06:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI5R8-0003OA-MM
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 06:17:26 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI5R7-0008MI-4s
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 06:17:26 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40d4a222818so14945605e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 03:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703589441; x=1704194241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uf/NVyr4TDfZb3BBkFNd5D1h7w1BXrb8WAxzx1hsgZE=;
 b=vp9RPsNtI9T+zmnM+t0WNXrOCN5h92EEGTq5LQgz2KElFRw9LSXwY/p0Vnn9OqMg5Q
 xALU8Jezozs7No9NK3EpkQNs3iwhn9c4vtGE9I+XI8gecWdTGl/Nxkbq+/UHL/sZ5wmN
 lzAC2FwAXMvmMbCo+FgENdZOeYzb1mkWx+QE1cQ8uo0MtTYrxi3+LgjQZU68OqW8JTbx
 KB6I1ElmBDw4xKEAcKEK+oq+94znISVYjt4gtcBsFUqazKbOpRmNM4VG1ostZxh7Lr5Y
 PZSwt08X/st9SETe5dwB+xssWMa+Yd4qkXMGrhFtS4mMgR5LDjGUkIjFw5p0oRHhIdFT
 f16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703589441; x=1704194241;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uf/NVyr4TDfZb3BBkFNd5D1h7w1BXrb8WAxzx1hsgZE=;
 b=RJi0HnPbECUjR7kAaHToKUzY/sa6YiTwCWMLux7FrwKRdjuLbwgt7CgFS5vKcAnQp+
 UvQN1Epb769v4sbwUuT/X/xsRS2V/mh72ActbDlZPdDVeg2/JuSCq85WXG7urpGsc4ac
 04cQOAOsfbhUxqO5B21+nkqsd170IOShtGoBq54bR0O8KVOSODfrWh752rsqOQmnPDJc
 hnMbciaNC+IqZTNisaA7gLNX4rah6e7RTTmW++4KFCuzQbgcQjUlOFRz8RA7b3hKkXkC
 S6/MHDvW8N4X1WVrEDYN4m+9FV9lLiIf+Tw7Q+OsXcDrkZfEdxyKeXzSISuoGMYzQiQf
 J/QQ==
X-Gm-Message-State: AOJu0Yxh0MFlwhUGO/LDN2XpX8DyaMs0+hxZZDWZKteLA/nC/z7KW3bA
 TGULSogUzpAJ3kV5Ouy6rLaD+QjnS2nw1GM1rwBVltH6LWY=
X-Google-Smtp-Source: AGHT+IFxZUs6oO8O9GL/o7wSc3jddPomCybJverqvvCuy40bP50VCH8JaR9X+ASZBU8/jsG98Ts7zQ==
X-Received: by 2002:a05:600c:2807:b0:40c:2a82:3e04 with SMTP id
 m7-20020a05600c280700b0040c2a823e04mr3227967wmb.52.1703589440877; 
 Tue, 26 Dec 2023 03:17:20 -0800 (PST)
Received: from [192.168.96.175] (137.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.137]) by smtp.gmail.com with ESMTPSA id
 b14-20020a05600c4e0e00b0040d5a5c26a9sm1868669wmq.43.2023.12.26.03.17.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Dec 2023 03:17:20 -0800 (PST)
Message-ID: <9814eab3-f50b-4240-acb5-3e0f06154ac4@linaro.org>
Date: Tue, 26 Dec 2023 12:17:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/alpha: Only build sys_helper.c on system
 emulation
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20231207105426.49339-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231207105426.49339-1-philmd@linaro.org>
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

On 7/12/23 11:54, Philippe Mathieu-Daudé wrote:
> Extract helper_load_pcc() to clk_helper.c so we can
> restrict sys_helper.c to system emulation.
> 
> Philippe Mathieu-Daudé (2):
>    target/alpha: Extract clk_helper.c from sys_helper.c
>    target/alpha: Only build sys_helper.c on system emulation
> 
>   target/alpha/clk_helper.c | 32 ++++++++++++++++++++++++++++++++
>   target/alpha/sys_helper.c | 18 ------------------
>   target/alpha/meson.build  |  7 +++++--
>   3 files changed, 37 insertions(+), 20 deletions(-)
>   create mode 100644 target/alpha/clk_helper.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



