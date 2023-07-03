Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23075746051
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 18:04:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGM1O-00061R-Rt; Mon, 03 Jul 2023 12:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1qGM1C-00060X-Ji
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:03:14 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1qGM1A-0006Ky-On
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:03:14 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc59de0e2so44273615e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 09:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688400190; x=1690992190;
 h=content-transfer-encoding:cc:to:subject:content-language:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8033MmEtT4zPI0Os0MY45EAKYtlFHfrAGI/JvV9tjVs=;
 b=JLhdAmkz/LNHepvnUJp/nnmrZ+3ZxJiNS0A58aT9i296HgxQhqCVcvj+IRJWWuhDVw
 bn4pB6WwRxc66Sy+Ybttx4YXjD8uQSCtiBW60Kk+cDOhQtEV4gZs2GKg5ZG74A5gSelR
 7Sk9RjyPfOwiFSJMxXPlgRU7If+J7tdi6RE1LtiYWxsOcIIFWkAl1kg9qmhWbjfRwng/
 UqaX+SGuMRrGcGFp8TWicOEUtZA8lgSHkIiepjv+vcAnlG7ZeaTrTIIUiwwm7zyj7ydG
 q/KB+ZUm3eUm4kqLsVk/HlsT8MVpiblvOPel4usQju9B9hnCEWvzt8jhXywL07Zv85fw
 PcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688400190; x=1690992190;
 h=content-transfer-encoding:cc:to:subject:content-language:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8033MmEtT4zPI0Os0MY45EAKYtlFHfrAGI/JvV9tjVs=;
 b=Q1iyA/b6pbFEgZh7wPcT09UFdExLoHW2mLsGxSvXAuHJejgFIgS9PxgbffVLwBWXaz
 VmEICs3Rxa3rd+CFdzMZAID6KCL9TJh1erjiT8Pm8BSwONIbMr5AzEFQOVnLVz6Hcfw+
 T7Y1rvLDdlp7yCzRCWcoW8j2n/bBRxywLN5VDVgAmRHTceOz+ZC391PTjwsiU7VgFUt9
 IyiqeiZJsYsOMH/SRpeacZ+Vj6hFrOlvphFA3dlR5xgyWT+201QLyowhb3xDIJ4TDU8b
 uhsUGG1h2bps5BrGgBq1AdOZaypKRXCkv5L101b00sJTjtIc89SF2X4zJqOHFpG/S6YR
 ZEbw==
X-Gm-Message-State: AC+VfDyBldj8uT+8DF6IN5Jo92up7iigsz+Se2GK+tIBdabp5Uh/nMGt
 sMuhgOQiUiADUmCL1Yym7jU0xvWTEy5ScHURqNU=
X-Google-Smtp-Source: ACHHUZ620rNqMENZDZk7L1S0P4qG0RwvdGpw508IjDTIpJOCg/tR0yV5hF0GMPvtnFNpKsrxykjXqg==
X-Received: by 2002:a7b:ce87:0:b0:3f7:aad8:4e05 with SMTP id
 q7-20020a7bce87000000b003f7aad84e05mr9655577wmj.11.1688400190057; 
 Mon, 03 Jul 2023 09:03:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:5cc:caa0:6d79:3eab:6444:9cd4?
 ([2a01:e0a:5cc:caa0:6d79:3eab:6444:9cd4])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a05600c0ac100b003fba6a0c881sm18119550wmr.43.2023.07.03.09.03.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 09:03:09 -0700 (PDT)
Message-ID: <c0a35ed3-7e4a-aea6-a3bd-9f0e4079f4e0@linaro.org>
Date: Mon, 3 Jul 2023 18:03:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Subject: qemu-user self emulation broken with default CPU on x86/x64
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 laurent@vivier.eu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi everyone,

Recently (in d135f781 [1], between v7.0.0 and v8.0.0), qemu-user default 
cpu was updated to "max" instead of qemu32/qemu64.

This change "broke" qemu self emulation if this new default cpu is used.

$ ./qemu-x86_64 ./qemu-x86_64 --version
qemu-x86_64: ../util/cacheflush.c:212: init_cache_info: Assertion 
`(isize & (isize - 1)) == 0' failed.
qemu: uncaught target signal 6 (Aborted) - core dumped
Aborted

By setting cpu back to qemu64, it works again.
$ ./qemu-x86_64 -cpu qemu64 ./qemu-x86_64  --version
qemu-x86_64 version 8.0.50 (v8.0.0-2317-ge125b08ed6)
Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers

Commenting assert does not work, as qemu aligned malloc fail shortly after.

I'm willing to fix it, but I'm not sure what is the issue with "max" cpu 
exactly. Is it missing CPU cache line, or something else?
Any guidance would be welcome.

I know it's not the most important problem on earth, but it's still 
surprising to meet this when you try to use qemu to emulate itself.

Regards,
Pierrick

[1] 
https://gitlab.com/qemu-project/qemu/-/commit/d135f781405f7c78153aa65e0327b05a4aa72e50

