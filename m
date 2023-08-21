Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A607823E6
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 08:48:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXyha-0002bD-R3; Mon, 21 Aug 2023 02:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXyhG-0002ZC-M5
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:47:32 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXyhC-0003TR-E2
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:47:30 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31963263938so2651831f8f.2
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 23:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692600444; x=1693205244;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OeSKY9EbrNqkqK4DVBFbSkKcS32wuuWXrvivI4DnKjY=;
 b=wvQ7S5J2UZRnF1H3yrfi5I1pStGOUk/gtPsI3J/ImO/CrEATBBR2VNX/wKoDU8LoPh
 WHyuVduhV9bCTsKvC0CNhcK/ce/vDrzJsx58/w9MnbH/H8iX7BIGkSfqdBStAlu1Yyxv
 po0juvJV/tDUiu3aGhkATG1MMKO9yZ0Gf2VHp013JY97zXcIohPSj1J/Hf5n0aRduz+q
 WVikdf9UbHZonqVV3VdK2aBOPqgmfn0GjheKnLUHjqPHcGieMrHkXWJYCxVgo7LxcVbR
 LTqramIot9bhkfgccPOKnVZDeZwGee7ICBk4DFBrgFE9tas6c9njrjmrFv++cv0xsNss
 RXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692600444; x=1693205244;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OeSKY9EbrNqkqK4DVBFbSkKcS32wuuWXrvivI4DnKjY=;
 b=AAcPsFMNosTbSypvmKCQODHC9y+vlKEMbVXLxz6XjToz1YvsVaxphcu1ci//fdBjzw
 EENivYW/gTaPGKneyRGvYgBQdmvyXYZrA9QJWDHQB8ZPz0YlQGw2pX+weHcqzcDP89g9
 AJ0p5Tcru1xGQrGmTY4uCQvIGFtg7uuvyhKy8Ne7O4z5HnSF3TdhvcLhaGF5GMlR7Bnh
 VVI91w+4/PRAQuC4Tu3cZW4D9HxzsfiGBJnbUyc3zzbrxUkeCFWrxxx6tfIzx3T7XUy/
 2PcKuOJS0aN0eDfn96QtM3wJrIrRrwS17ArVUvjDcBNJvgkjXux8m6V3wArs1D6AHTpC
 A5Hw==
X-Gm-Message-State: AOJu0Yy5i7BsPoemf2LKhb+JhJK+mXvEwoWaBxaEBeM69dLPTX+R0YCw
 QD0v346blwNHe+2znFa74h5Cqw==
X-Google-Smtp-Source: AGHT+IHMx3o3Yhv3MVLQEzSINe1Ac+SCQMKEj9Y/qD2fcKvq/Xp8+uZ0MtkhjFQMWz48OItf4hK+dA==
X-Received: by 2002:a5d:5452:0:b0:317:759a:8ca8 with SMTP id
 w18-20020a5d5452000000b00317759a8ca8mr3776980wrv.67.1692600444350; 
 Sun, 20 Aug 2023 23:47:24 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 o1-20020a5d58c1000000b003180155493esm11208094wrf.67.2023.08.20.23.47.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 23:47:23 -0700 (PDT)
Message-ID: <a0a7d5db-d094-8a08-84bd-af35ff805479@linaro.org>
Date: Mon, 21 Aug 2023 08:47:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 17/33] linux-user: Move some mmap checks outside the lock
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230818171227.141728-1-richard.henderson@linaro.org>
 <20230818171227.141728-18-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818171227.141728-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 18/8/23 19:12, Richard Henderson wrote:
> Basic validation of operands does not require the lock.
> Hoist them from target_mmap__locked back into target_mmap.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 107 +++++++++++++++++++++++-----------------------
>   1 file changed, 53 insertions(+), 54 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


