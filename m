Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 140A27DAD48
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 17:48:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx8wr-00071Z-Ca; Sun, 29 Oct 2023 12:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qx8wm-00070U-Vt
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 12:47:33 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qx8wl-0005yx-Ab
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 12:47:32 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6b1ef786b7fso3661432b3a.3
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698598049; x=1699202849; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JrglV5ytlUpXURMA5jD7BVri9z1pZLEF3hZHwhuggAU=;
 b=hslzWlLaA3DOYuywQ1rnLEBKrOaewRQ5TsZHUGivkg1BiHcbWLASNkKjhhyMJkmuPz
 JkcJ3aHhq3bJicMOaHqEGP3j7/ra6bB/p+S5/wiLBXJ2rO1g1PdR1ydZtf0GrDoktT3Q
 tmSRXTNTzwFHdpO1FCr5CGPR1eaLz6psz5W33Sz0jVtQlNCVpotKXPaqxJpSX80bhjBV
 x452ELL/1D/33tjysrbd7BTBMjzCifjfRRQkxrbxQMK5hTXwK1urIUN9Q49t2HWcmol4
 giNXZA4IqpAj1nXZjpwXZIQbtoV0Mt3uMUGy7K4F4SlrSKyDiqx4G6mmT7ayuQACLgIy
 SG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698598049; x=1699202849;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JrglV5ytlUpXURMA5jD7BVri9z1pZLEF3hZHwhuggAU=;
 b=JLjvo73Tpl//L73dR6X4OYgKj4Faed02HTzAAUIc1vUqN5Rb+P0wMnZ2d0TchrcsM2
 U15bCi4LiAwGiyZPMhKUmKVk5+kl5fI0AR5BJBMSJhp1i+IKZ/v6WdXGMBg5izrU2Gxg
 5Iit7UyogBAcnT4GllFgoKMyGLBAF2xV0J3N1EZ1Ug/PiKn7C4u5hvP8CCVXS8eY3snw
 WarmQf8Aq+n63CaCJHvH+YfR2zgQZaEuhiwymoyxs9uMrkVG2vJN6N8X28/c9eZvZmrw
 /4xZXKNUTLMPYqVHwzSi8Qdeu9a3z4BBMcYIdUW1USosyFangt7UQ3xnjnk0uRijy9QT
 nb/Q==
X-Gm-Message-State: AOJu0YxCdQVeiGCfbNcT5CEQrxCWbw+PcVge50x49f/O9J5E5W/N2cYR
 GY8j+PH4LrxPWdAmKHvAyFG6og==
X-Google-Smtp-Source: AGHT+IFqN0xbKfK/asbceL0O2rdDAF3jhQ+/BW0VWRslpwIKRPkB/UfaoXTPxd6kuU2o957MOKH0FA==
X-Received: by 2002:a05:6a00:3a28:b0:68f:cd71:45d5 with SMTP id
 fj40-20020a056a003a2800b0068fcd7145d5mr8953921pfb.3.1698598048821; 
 Sun, 29 Oct 2023 09:47:28 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a62ae14000000b006934a1c69f8sm4475376pff.24.2023.10.29.09.47.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 09:47:28 -0700 (PDT)
Message-ID: <7e44c8cf-0256-4c79-83a6-30642a072628@linaro.org>
Date: Sun, 29 Oct 2023 09:47:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/19] gitlab: split alpha testing into a legacy
 container
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231029145033.592566-1-alex.bennee@linaro.org>
 <20231029145033.592566-4-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231029145033.592566-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/29/23 07:50, Alex Bennée wrote:
> The current bookworm compiler doesn't build the static binaries due to
> bug #1054412 and it might be awhile before it gets fixed. The problem
> of keeping older architecture compilers running isn't going to go away
> so lets prepare the ground. Create a legacy container and move some
> tests around so the others can get upgraded.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231028103311.347104-4-alex.bennee@linaro.org>
> 
> ---
> v2
>    - split other softmmu patches into a new patch
> ---
>   .gitlab-ci.d/buildtest.yml                    | 19 ++++++--
>   .gitlab-ci.d/container-cross.yml              |  6 +++
>   .../dockerfiles/debian-all-test-cross.docker  |  4 +-
>   .../debian-legacy-test-cross.docker           | 46 +++++++++++++++++++
>   4 files changed, 69 insertions(+), 6 deletions(-)
>   create mode 100644 tests/docker/dockerfiles/debian-legacy-test-cross.docker

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

