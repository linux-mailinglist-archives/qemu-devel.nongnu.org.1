Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 946F978D03E
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:20:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n5-0000rl-P9; Tue, 29 Aug 2023 19:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4pF-0001sy-9Y
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:56:33 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4pC-0007BL-En
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:56:32 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68a520dba33so3831733b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693338989; x=1693943789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6TaTigwwlzrDYYLLDRWxh4f2cLZdhBtvWyK060DquXs=;
 b=KQjzSX4FlgRju/fBjJeYI/pB5YLcKZVdFVhZWC6KsWp99fWBYayCd/wYLBPPN5/ZG9
 T4FhktWXW3gd+DQgO1+cnOvCL4FYb/CvB6sKOcOEPuELniHXf2N2bkJitd2vDJ/dycaW
 h4lHMuqeEUlgLx68fuNh5qr105V7wEP5oocd3bT7QpdUB/ZNxBTZpP4p76Yue5FS+0Io
 uin2wBvOpj2hAU3YLGrVzFl+5yzIQL6AvL8M7cmndEGacaqjiGaySPvh1oRayOoQLrLd
 niKT5Nxo6s+q991QvG4cQpf3BHnVAYU3JZ8VtO7wLWzn8isTGD7S4Y/ajiXk0t9Zcv/M
 nOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693338989; x=1693943789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6TaTigwwlzrDYYLLDRWxh4f2cLZdhBtvWyK060DquXs=;
 b=hRwfkKC6afV+hkEea5GegLUzreTm99TQZltsPt9Ey5SrKzKVZ8plOUOVpmM2sgQKN2
 f/YSbzDjfBm1a6G5qkE2AyWiAEaGz7DxKbpw/hc8H/L+WZ29bdJ1HYPgQqP23KCh249K
 q5ltq+/c15NUaRv03uT29/cibD+ywx2pABs23xdpG8MCQdihl4xzohitPasV1f1d9dhR
 FRbwmJMoy/l5MDdhjISC7/DP1Wf58/2dl6zkwJQYPZ+g7grTnxfyXTDGVT7Ym1oadaIW
 AZ7zCIn4zjlsnz53vI5AuUXViqHrb/YfBtA8jRx8pLvEEbAZjECPYew6D3XQGbW6kBWs
 7qwg==
X-Gm-Message-State: AOJu0Yw9hNXyzBGyHT4Q8u1eQpwOYMCE1+3vAUDGwnwpvm5i8p0Iwl9+
 obizQByO35HUCQ4ABB+xgqzYbp1kn/VTc7q5858=
X-Google-Smtp-Source: AGHT+IHv9Bo6AMDVP7WVprzrhKeEAySh2bGk5pIeKL4ga0Uu2KYSxyinhsSgt/El55IMU65BuzpRHg==
X-Received: by 2002:a05:6a20:8e26:b0:10f:be0:4dce with SMTP id
 y38-20020a056a208e2600b0010f0be04dcemr423726pzj.8.1693338988874; 
 Tue, 29 Aug 2023 12:56:28 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a62ee11000000b006889601aba4sm8721604pfi.210.2023.08.29.12.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 12:56:28 -0700 (PDT)
Message-ID: <c5bf6016-ec3f-362a-fe8c-6aca53a3d60a@linaro.org>
Date: Tue, 29 Aug 2023 12:56:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 13/32] bsd-user: Implement umask(2), setlogin(2) and
 getlogin(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-14-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-14-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-proc.h           | 39 +++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c | 12 +++++++++++
>   2 files changed, 51 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

