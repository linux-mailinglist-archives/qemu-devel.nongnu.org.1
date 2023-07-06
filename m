Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63971749754
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:19:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKCk-0005Kv-Jl; Thu, 06 Jul 2023 04:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHKCf-0005Ex-RH
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:19:06 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHKCd-0000GQ-Rh
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:19:05 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3142ee41fd2so312983f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688631542; x=1691223542;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GtKKyEkgV14EoIncNyDv5Bcn/wcGOYCw9/TVGiEKiug=;
 b=P2xmRzN7cPO/oi8tp3h0/7PhgG8WeTapM87UfwGcGKUE5QfkrCYjXe0VfNRGhDm40d
 AOrXRwMVnBCzfr/pQKT4BZ9zjYsGW6D2WznRKzCcGlyvcxjKsCUuRkK/nRX0SV2cZoZd
 gGtc+fbIDKN8Zk2Ex2uSAord46mYXzMtefx2FNVLl1XX/jI7sGD6o8++ixFScWURZuLs
 bJKXTW5hE/6GDkl6xvUXY1mBgKHdgRyYbIxrM8IsP73qyHFzEAgphF1YSaNcSzRIU17I
 rAzLje3cEmAFDQotal1dvtvZPfmar6jQCA4Vyc5eGBXZauLDeFnOpNIT44shN2ZVt9+n
 JaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688631542; x=1691223542;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GtKKyEkgV14EoIncNyDv5Bcn/wcGOYCw9/TVGiEKiug=;
 b=jNBj5WnGW1vdM2MJOwJTM2iy1rHFbUGdlDXLFfJP+JQvumiHk3f27rfi6vYQgrpHf8
 HuV2RgXAoq05h+O3ohMkz1iqO4xW2fVLzsyGu8Y8HG3WQVC07VrDwoe1JWdBK47TG+GN
 nFd1bGu2RsvyA7E02cgMMYp1RLGzC6/Xnt55/eGdCRgFFNwAMGSU0vp461C5Qd01fR41
 eNd+7IW+gznyzLc85ay8rsAnhSIJZn49BGy2ACx8IodI84k3fziHP59J1VJAgjic8ekv
 xdj0G2N6Hg33mTB+9II+5XczbX0xbq/VmccID5939+UD80R/jfivpatKku2P7LTKiRIt
 wUUQ==
X-Gm-Message-State: ABy/qLbBg0y+LVT/Vcn1Y77QRVRuuWWmT0Hf0g3+sAN8AoA1do2p1/TB
 6YMQmltdTEfLfNY66ldF3mUX1pmJiO+KwuqnbPk=
X-Google-Smtp-Source: APBJJlFq8dyaZlGexCgOL7aYHO0w4qq2SOlzLN45k7ZkjSsd8F6439g5TzjSKRrKGtn7H/8P5Ezgrw==
X-Received: by 2002:adf:e689:0:b0:313:e2c4:7bc9 with SMTP id
 r9-20020adfe689000000b00313e2c47bc9mr921055wrm.31.1688631541751; 
 Thu, 06 Jul 2023 01:19:01 -0700 (PDT)
Received: from [192.168.82.227] ([91.209.212.17])
 by smtp.gmail.com with ESMTPSA id
 q24-20020a056000137800b00314172ba213sm1165568wrz.108.2023.07.06.01.19.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 01:19:01 -0700 (PDT)
Message-ID: <eb12e0c6-7c13-e00e-6ba3-dbd589b65553@linaro.org>
Date: Thu, 6 Jul 2023 09:18:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 13/46] target/loongarch: Implement xvadda
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-14-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-14-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/30/23 08:58, Song Gao wrote:
> +    len = (simd_oprsz(v) == 16) ? LSX_LEN : LASX_LEN;       \
> +    for (i = 0; i < len / BIT; i++) {                       \

Likewise.


r~

