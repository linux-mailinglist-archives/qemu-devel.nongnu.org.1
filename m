Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBF37DC131
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 21:27:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxYpP-0002AB-QN; Mon, 30 Oct 2023 16:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxYpM-00029L-HC
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 16:25:36 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxYpJ-0005Nn-SV
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 16:25:36 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b709048f32so4247756b3a.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 13:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698697527; x=1699302327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8k8RBnPDBgrNqHkhPuySsfa6lNW8Zo1B3smWIKtHzW4=;
 b=kADqAC/YkCaynP/HSibIc9N6mFiKHJFhNmWgnyZ3fb58dNjle5e+bQH7Jg4HCkUekz
 CNun1ld3z92fRpXNqqXvEzsta9H2DSpoaoQg1SRv+Dn3HzkWGItL12k7b1n3q2kKm1Y2
 3qUMV25873JDP6foOjbGXl+c5ncsQ82KTR8oD4pugvNftyHFDGOUKnLEapctLVbWYikm
 w6zITL4BDMEhvsKZrAUP9EUK3hCykfPTAcBnyG1pw9JtgmgDBty0svBAND74huDeRkv1
 2jHM6y8Xxx3Ac80lJ2ZX9YxN2sA2gnlUx/vbQCHRIdIB3bxIPcat0EJ4vsigmau7Zo/T
 hw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698697527; x=1699302327;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8k8RBnPDBgrNqHkhPuySsfa6lNW8Zo1B3smWIKtHzW4=;
 b=mu/50v/4d5nk/m7cQBPpXORtZd4q3UZcfA4MuaU8xVl2UwOGspGbpwb7eURXQXXD0F
 F7cyVybsw+rhWbdd/8Pu6n/djisWMJFHhHM33a1+L4OT7oEBxvKRZnJAYkFAvexzIx2M
 rJvkKitheYXh2dOwsmZnEJw84tGI3LFOb4axu7K6Lo28eWD1R5nEFMQMslBYARk6+Xee
 PhH/6p5wRki8MPAW2GvH6NF0obJmfiYAUSk3iIAq4UPVFro589SUPSNG4HesfypfOT0r
 bnY8QTSbb7Uz/TLZ7pjvgJ4TqMYoSsfLDp8JKL23AzAWvCFIbSC5YwNzf0s29sEIpZ77
 z53A==
X-Gm-Message-State: AOJu0Ywpuen6wgbdKXeOboZABHnDQQei/hrfWZeEOFqPHWouTfGT9fs0
 9UpaOfX0XrKwVQB1mX4IPVW/Bg==
X-Google-Smtp-Source: AGHT+IEFlSxfNVWAsPMOOAy8aw4s5iG/rb3i42O/G5e7wL57QVuYUvcy5A8AooOGxaY8VrN9umP2Pw==
X-Received: by 2002:a05:6a00:14d2:b0:6bd:254a:8876 with SMTP id
 w18-20020a056a0014d200b006bd254a8876mr10057403pfu.23.1698697526934; 
 Mon, 30 Oct 2023 13:25:26 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 x25-20020a056a00271900b006c03d1ba03asm6243440pfv.220.2023.10.30.13.25.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 13:25:26 -0700 (PDT)
Message-ID: <32498e2d-ffac-4b5c-943f-883517685e2e@linaro.org>
Date: Mon, 30 Oct 2023 13:25:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/docker: move sh4 to use debian-legacy-test-cross
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <9427da20-92c4-4d98-9073-3f7050d7f7c0@linaro.org>
 <20231030135715.800164-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231030135715.800164-1-alex.bennee@linaro.org>
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

On 10/30/23 06:57, Alex Bennée wrote:
> sh4 is another target which doesn't work with bookworm compilers. To
> keep on buster move across to the debian-legacy-test-cross image and
> update accordingly.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231029145033.592566-8-alex.bennee@linaro.org>
> ---
>   configure                                     |  4 ++++
>   .gitlab-ci.d/buildtest.yml                    |  4 ++--
>   .gitlab-ci.d/container-cross.yml              |  6 ------
>   tests/docker/Makefile.include                 |  2 +-
>   .../dockerfiles/debian-all-test-cross.docker  |  4 +---
>   .../debian-legacy-test-cross.docker           |  5 ++++-
>   .../dockerfiles/debian-sh4-cross.docker       | 19 -------------------
>   7 files changed, 12 insertions(+), 32 deletions(-)
>   delete mode 100644 tests/docker/dockerfiles/debian-sh4-cross.docker

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

