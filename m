Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CD1799B77
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 23:43:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf5ik-00041n-9g; Sat, 09 Sep 2023 17:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf5ii-0003zy-HY
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 17:42:24 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf5ig-000793-Di
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 17:42:24 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bf092a16c9so27842145ad.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 14:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694295741; x=1694900541; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=75KUs6B1LDy4vXs8LVTddHOdPr7icyTNqIKbLkb7/wI=;
 b=DQRBL+Wz6/HQZq/f43qGF3NcQbc+CbirJqY2/PwScFjgnCa48Vkv/5E4JAGKsO1GMZ
 yuO/LuWArvbIjKJsWN2aH774DjxXggphfF5oiZj1PfwGzQc6nIhY47Yb0AFxfQ1+cD1M
 X042iEzjcEueK6Y4a51TDc3ydCgv9htIFKL48mg+4zDE+6Su8jE1BHceyj4t71bf5csV
 RAmYF8WUGoRyAcYx0Y/Y7K/HgCYyiPnGuM590Dos5I5ELlKHrwR6T27PRLLbs4Kkt+va
 UsQ+UgYCHvOty/9238I18ALnfSEId8u1mOcrVIKyZ4aV+qborZxThS5QOp6zAc70JREB
 ocHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694295741; x=1694900541;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=75KUs6B1LDy4vXs8LVTddHOdPr7icyTNqIKbLkb7/wI=;
 b=QmdYtbBaLdr7gy4dgkm18lyd7fGKkSVbvI4Ub7gzx92Fs/QRorK6KW3mkUGi+BfCoX
 Ape+vsHnpcVYuANTsJEJeyY+aftAw65v/Q4YTNJGvI+14vhb4LB9x1gMvIyQY+O9FIQr
 oYZ2LidT3+bDI4pOCwRJYRRMIDlodW56gd1o/5CIlDL2/JuMn96wEmYSt7ou/XEFeTd3
 YAdAile2t4czw0HPms6YEPFZM2npTZJPUbITtmKBu8/Y136KqV2SlL1gFC0PxGByYkUO
 9EyF4p/ei+9viOb6AfPdtFGKr70oEaqEYjSNU5ng5Xy4Hh5ULQ8UFRXhs5EZQU01WA4I
 Vwbg==
X-Gm-Message-State: AOJu0Yzt0xo/+CvD6Iu5kwqaf1Ngix6D2yHoomMtI1PtblgCpk+jbXuU
 0r7xxzxzxMNDlAMAz9caWsdXsQ==
X-Google-Smtp-Source: AGHT+IE+Bf9JqKcSLV6MZfTP3hnsoDBscKucelJKdismy4Olxz25ty7T2tzWSGf9A15qP462ddTL5w==
X-Received: by 2002:a17:902:d2d1:b0:1bd:c6ca:e0db with SMTP id
 n17-20020a170902d2d100b001bdc6cae0dbmr7421343plc.37.1694295740821; 
 Sat, 09 Sep 2023 14:42:20 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a1709027c8c00b001ba066c589dsm3667651pll.137.2023.09.09.14.42.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 14:42:20 -0700 (PDT)
Message-ID: <f8c7ac9e-cc7d-55b7-3933-2dc65181a70c@linaro.org>
Date: Sat, 9 Sep 2023 14:42:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] util: Delete checks for old host definitions
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 pbonzini@redhat.com, laurent@vivier.eu, qemu-devel@nongnu.org,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Peter Maydell <peter.maydell@linaro.org>
References: <20230810225922.21600-1-akihiko.odaki@daynix.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230810225922.21600-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 8/10/23 15:59, Akihiko Odaki wrote:
> IA-64 and PA-RISC host support is already removed with commit
> b1cef6d02f("Drop remaining bits of ia64 host support").
> 
> Signed-off-by: Akihiko Odaki<akihiko.odaki@daynix.com>
> ---
>   util/async-teardown.c |  3 ---
>   util/oslib-posix.c    | 14 ++------------
>   2 files changed, 2 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

async-teardown.c has since been moved to softmmu/, but I've split
and adjusted the patch to compensate.

Queued to tcg-next.


r~

