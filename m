Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E815D7DA8EC
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:26:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwowy-0007ib-MI; Sat, 28 Oct 2023 15:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwoww-0007hw-7k
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:26:22 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwowu-0000pG-Ml
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:26:21 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-357e783edbdso10764555ab.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698521179; x=1699125979; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KfQbCZohyU45w+hChzmTjn4EzShXMpoEgc2jHdAZDcU=;
 b=WIjqTjE/pIhM2TLPyt4AzKXBzcTXbF9WK1EiHjc0fEXz2xyuuF4q5e8k5PUdfE3YAk
 xErevgYEzKurZClbzJAeOFX4hto07P8kcDmdeKMx4LD46yRL3ZZthAL0wMHvY/apGCbB
 HEzETk9Yq+WCsz9TnUgShXVwItC86TkmG8L1qDmc6QBkY3mCZYbMa8MinD6A+OIa+ehD
 dFVDJfwyZDhVcVUZwv56oVDnj1b2UgahgOJlsewheY0t18VW66lx1sZ9o/Uzn8Y06BgX
 QMut98VoKMzMsFdTGrHWPUW/maJMNpK2ajG3oCQttpn3q4xU6G2Hx35HWnk92s+442ZE
 UXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698521179; x=1699125979;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KfQbCZohyU45w+hChzmTjn4EzShXMpoEgc2jHdAZDcU=;
 b=jMRaWT5eqhr7ac4HT2pLXjGGav4qXA/wBTM07KIrsReoKt91s1f6iwUPAWa5vZDoK9
 QylXEEQiOuwWlLtM4wPk/iUidP+wjxt4PVBDJrEpZ4WIPiuF+wLzMAdFEOqB/jCbi3wP
 Y0zrLL4FnRMYHpcEfoHM/kM6Ty+LWtI7Do0aG7kRHn1g9vLVdRhv2ysmKsLcZBJ9OahO
 2z/CPEnPVL4Sjv8OEEAig6+Skpq2a+8qa9c5p67IC4HwYaD2KJPwFHJtLTSxMUt5udy8
 Rab7ab6RGxCAJSe0fiQyPaw66KbWDxMW9EaTOjDfmKruKY3phhFL8ZDA4N/2rT7kAEP+
 GkWQ==
X-Gm-Message-State: AOJu0YyGnkXdZqVeKc/4wFMD58gmCcSIbjiJw6hWX20sQlxUza6BSVED
 X4kSU9immNODnbKsBm0/H9LW9pUrD56w+xtJfqQ=
X-Google-Smtp-Source: AGHT+IHBI0CcQtSqzlkpuZwXlaiL8idABnTtmhjmFctWA3er9sjn7AuMi7v84pNylByLQ1Fk+jkHww==
X-Received: by 2002:a05:6e02:1a4d:b0:358:266:3dec with SMTP id
 u13-20020a056e021a4d00b0035802663decmr8894887ilv.29.1698521179382; 
 Sat, 28 Oct 2023 12:26:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 fn4-20020a056a002fc400b006b4ac8885b4sm3390045pfb.14.2023.10.28.12.26.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 12:26:18 -0700 (PDT)
Message-ID: <ac149166-968a-42d5-9f28-39caa1098b1f@linaro.org>
Date: Sat, 28 Oct 2023 12:26:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] tests/docker: use debian-all-test-cross for riscv64
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231028103311.347104-1-alex.bennee@linaro.org>
 <20231028103311.347104-12-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231028103311.347104-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x132.google.com
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

On 10/28/23 03:33, Alex Bennée wrote:
> Maintaining two sets of containers for test building is silly. While
> it makes sense for the QEMU cross-compile targets to have their own
> fat containers built by lcitool we might as well merge the other
> random debian based compilers into the same one used on gitlab.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   configure                                     |  4 ++++
>   .gitlab-ci.d/container-cross.yml              |  7 -------
>   tests/docker/Makefile.include                 |  1 -
>   .../debian-riscv64-test-cross.docker          | 19 -------------------
>   4 files changed, 4 insertions(+), 27 deletions(-)
>   delete mode 100644 tests/docker/dockerfiles/debian-riscv64-test-cross.docker

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

