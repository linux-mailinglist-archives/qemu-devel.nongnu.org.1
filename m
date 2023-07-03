Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4268874569E
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 10:00:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGETR-0003zJ-25; Mon, 03 Jul 2023 03:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGETP-0003z9-30
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:59:51 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGETN-0001hU-DK
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:59:50 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-313f3a6db22so4793886f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 00:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688371188; x=1690963188;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PY6zjZrUtWvhlvWSfzEnSjNNOETp3y9Va8Ua7/CNRmE=;
 b=J1S0iherOA2V/5QeFLswNloi3pZwGrNj3RiJmalEXv2vxpu9lcpB7D1PpdX+2xcU9j
 dreodRSIhZuNwEyDkVKwFRtbzwsXXuTgEbYHDqyUAHiUOyFDnPRp2AtnaoQU3oML3wwp
 2+ObzwmE2XNjIYYgLhDsXzeVgwi8N7BdpNeQCF/PmirLudVRTO4+RB+xJhQRXBGzD0Ib
 9ptnflVw4XWveNe9j3ZLtlreMxAPAPiQsLHeSK8b4QI/EP4droITnqH12Qj8qRIAtaxo
 3P6RYkPsghYXEVXop+ZecHcdWs8FZFJudhloRk8vBJt/76rWu22ydaoX1nWlkj/cdXH7
 +W7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688371188; x=1690963188;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PY6zjZrUtWvhlvWSfzEnSjNNOETp3y9Va8Ua7/CNRmE=;
 b=aee+Rj/vEPWu/5V7nohNgFP5jNMIBYEJjEbkObVt4VBee3Oi1M8A/sXMMGuT0kSkAM
 JA3mOl9QxdPQWj4mhMl/p2n1MIg75404ADLGiLUvd7eRzmSzA5gVVwPXe/3mXNRzGFOQ
 8gnZXArqJ4zbu6LMlg6ggjnChOP7Ut3XFs8K7I1gdxrIYqGN3Ho4OMROr8e9P1MMCk2N
 TGXK1aCJF7xymuKDZwdNvgBolMV4AnUB1O3sR1zLgqmNpVKNCYQl8fRDXMZzh+DtkjqW
 VqM8mGrvdfSzTl4Q0drECycMN2wFuxfzNY9fO/k9rWBrm72H6GerIaeh1T0S9T29VN54
 bnrQ==
X-Gm-Message-State: ABy/qLYI8xtS7BsNApvtX297vp7miOmpEGPZ/9uEM/VWX0At3Oyzz3Us
 inX6Rh0wkeC8wAhegVvVIi6uXA==
X-Google-Smtp-Source: APBJJlFQZTuyJWBrnoKtNQWbnEPQccfWLXowJ4OLuq0Gy+RwtBs4EngC/ECd9dTDfY6RUDjblXtD1w==
X-Received: by 2002:a05:6000:1806:b0:30e:3da5:46e5 with SMTP id
 m6-20020a056000180600b0030e3da546e5mr8753791wrh.59.1688371188031; 
 Mon, 03 Jul 2023 00:59:48 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 f2-20020a5d5682000000b00313ec7dd652sm21967296wrv.44.2023.07.03.00.59.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 00:59:47 -0700 (PDT)
Message-ID: <faf0f3e3-d231-9c10-cc81-bd8830dca770@linaro.org>
Date: Mon, 3 Jul 2023 09:59:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 15/38] tests/docker: convert riscv64-cross to lcitool
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230630180423.558337-1-alex.bennee@linaro.org>
 <20230630180423.558337-16-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630180423.558337-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/30/23 20:04, Alex Bennée wrote:
> We still need to base this on Debian Sid until riscv64 is promoted to
> a release architecture (or another distro provides a full cross
> compile target). We use the new qemu-minimal project description to
> avoid bringing in all the extra dependencies because every extra
> package is another chance for sid to fail.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> 
> ---
> v4
>    - moved qemu-minimal changes to previous commit
> ---
>   .../dockerfiles/debian-riscv64-cross.docker   | 119 +++++++++++-------
>   tests/lcitool/refresh                         |  10 +-
>   2 files changed, 83 ins

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

