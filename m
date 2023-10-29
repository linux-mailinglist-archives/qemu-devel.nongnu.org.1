Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7741D7DADEA
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 20:03:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxB3O-0004Cf-8X; Sun, 29 Oct 2023 15:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxB3M-0004CV-8F
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 15:02:28 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxB3K-0002Xu-MT
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 15:02:28 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b709048d8eso3185333b3a.2
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 12:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698606145; x=1699210945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=963SETn4tvD3VmvuRKRJyu8lkYYEto18CshAKacsBZs=;
 b=OIh2VdvI2NNYnlw3aVGKkMLcH2I5tZnHYSlxoDuN/N6h/BDWJ/wEbEMzpaVnR5t4BD
 gSEZvBt1dfEb4sVwJYmYIfdvhwc63fCSI/NNBe0VfjKCwFvkySCdzytF2IlfBo+lYW1m
 iO9E1Rfl2+t9zjXzVjI/+fiu+JmCHJfPVn9ByBimXr1DET8uf20bW/J/zegpM8x44jKd
 rJnrfPAs3ToDQkfxzW5DYIfGc7sANYSyNmDZQjUdIQt6azw2di2XF3U0hkfdiWMRxskr
 AfhtVleLCA1PNvu/F1SNa+OC0i8WTrFPlN6dAoCWfXcssNGQhjS6Ida6Jg38a6QoUM4Y
 tKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698606145; x=1699210945;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=963SETn4tvD3VmvuRKRJyu8lkYYEto18CshAKacsBZs=;
 b=t1E2k+I2TOz7565hgeogUahGtnncttgIbrjP/ey4TcKyeczgqZfkt5+44eykPkixBH
 CjnEQSbepAyF7wgyqN2J+AAWTIldqS8/EHjVEL0Y3CgUEKlX5bieuVBtXYhrsx/UzjJN
 u1z2dmb3IpuioHNMg6LwKVgPaYL7AGxZr1eDaeTQsyr1Wlh/PeOOlQmMjfNDonoUeanJ
 QZt9W54NVJVr6ISVmtl5DoV8IdBl+yLJHmU6Gkm0Bv52dP+gJ+QnkMhl54ePju6RKeBm
 p5vuE7FX+Nuy3R5bQ+uaS6wCLJFtOa4o7xvzUbk8FIvUwiq6p6Zyu0tI8kVVxa7WQPrZ
 gY3A==
X-Gm-Message-State: AOJu0Yz35eoi6IVPKGWpRhgSKdFzb4WsG1CP8cMopwf6E4LyTVDLV3CW
 FH/tnk2JBDxsgrWYKq0A7ZfTbW5RumcX0PpgbQ4=
X-Google-Smtp-Source: AGHT+IHPJFB465vj78iM3j7TV1YO8nUs+bzLV00mFTIEJNuiLZkTbf0JOPsaKH/E6r427GqmhvO/Ew==
X-Received: by 2002:a17:903:228d:b0:1cc:5296:10e4 with SMTP id
 b13-20020a170903228d00b001cc529610e4mr7880plh.22.1698606144708; 
 Sun, 29 Oct 2023 12:02:24 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a170903111000b001c724732058sm4845273plh.235.2023.10.29.12.02.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 12:02:24 -0700 (PDT)
Message-ID: <195e9dbb-4ae8-4785-9199-954184c54931@linaro.org>
Date: Sun, 29 Oct 2023 12:02:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/19] tests/docker: use debian-all-test-cross for
 sparc64
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231029145033.592566-1-alex.bennee@linaro.org>
 <20231029145033.592566-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231029145033.592566-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
> Maintaining two sets of containers for test building is silly. While
> it makes sense for the QEMU cross-compile targets to have their own
> fat containers built by lcitool we might as well merge the other
> random debian based compilers into the same one used on gitlab.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231028103311.347104-13-alex.bennee@linaro.org>
> 
> ---
> v2
>    - s/debian-test-cross/debian-all-test-cross/
> ---
>   configure                                     |  4 ++++
>   .gitlab-ci.d/container-cross.yml              |  6 ------
>   tests/docker/Makefile.include                 |  1 -
>   .../dockerfiles/debian-sparc64-cross.docker   | 19 -------------------
>   4 files changed, 4 insertions(+), 26 deletions(-)
>   delete mode 100644 tests/docker/dockerfiles/debian-sparc64-cross.docker

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

