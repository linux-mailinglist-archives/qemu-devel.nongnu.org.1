Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7CE82DA07
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 14:24:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPMvY-0001en-EV; Mon, 15 Jan 2024 08:22:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPMvW-0001eJ-0r
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 08:22:54 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPMvU-00047n-GQ
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 08:22:53 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a29058bb2ceso932567266b.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 05:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705324970; x=1705929770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UknHYhSRyGy4RvyFMtWD7/d30rc1VGzl1cFZqKy6om4=;
 b=wbx/NfJUsWW7EEsm8F4tybf7H2Z2MTaFO/jo72EVlqXL04ZwBSCeLaYl83Ph598xEl
 4La+8zn6pM6msF82KgVOeCZLCpbUYtHUfh2r79cmHr9yXFhC0SHmnom7aX+S5rlzHptP
 2yEpXMelDAb4xLqdm4v3Uak4p0F0zctkDSUkvvWxSN9XiR7SMaHv192wI2hGBVgm+dOJ
 ddNNRYQgkoBUYWV51GwrXszNRwkFYk54VwsQaMOKwmi1nT3ayc4tI8sFpifZIifH2je9
 7r1H6tF0sVM6LCVlu6hw4KWppIYsH0FQzueSXgaER8tJqPh0b08RXafnsJRI804ScdA7
 7fSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705324970; x=1705929770;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UknHYhSRyGy4RvyFMtWD7/d30rc1VGzl1cFZqKy6om4=;
 b=HNnLQsvdmdiGlJLWo/SNVSjQesFZqP5VNcxjVApY7Z+NQ2LfqDsIGor5M9BwhLNXYs
 zXmO0puIYEVdGyom3SHoJT0Cb4i6qowY4RBTM8f0CqqIWOFIZ17C/NXyh63eVOiRnMep
 z+WWGXrsrW02M/LMXrIbpBDHG4Q10XHv89WRbyAJ2qV0F89jRzVUkbn9TvSYIbvMoogC
 DWr7+D9epvr4kuZDYcwa3DhiP5qYOK7hiphVxSduQsJjIqKhwfVtyL2340TCksM4CJN8
 swG7S00+oggh1liGxXVgDXZ2A8xOS+0NloqU22zwh2YhwIo1gjfZ392FTP8isWE3JhPH
 qltA==
X-Gm-Message-State: AOJu0YzJrKvMLZdkmNwmtgN6oxNdE2sJ2x4YFMgsr0qUsKlQEr5o0KfZ
 b/nW7TDuNpYucAA1X6z2153Qxyn5dU/0qQ==
X-Google-Smtp-Source: AGHT+IHLaFWW16AvI8Qxtzk8AuXg9HA0IyClRsWWW5o5ySXhDzorM8C+UNlIddYYAr9UgtvmYSKdSA==
X-Received: by 2002:a17:906:ae83:b0:a2c:5ed3:626f with SMTP id
 md3-20020a170906ae8300b00a2c5ed3626fmr1788715ejb.161.1705324970645; 
 Mon, 15 Jan 2024 05:22:50 -0800 (PST)
Received: from [192.168.69.100] ([176.187.209.30])
 by smtp.gmail.com with ESMTPSA id
 lb10-20020a170906adca00b00a2930696259sm5304871ejb.71.2024.01.15.05.22.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 05:22:50 -0800 (PST)
Message-ID: <7825f8a0-c896-45a9-86c3-9a30e89ecd06@linaro.org>
Date: Mon, 15 Jan 2024 14:22:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: Add linux header compile support for LoongArch
Content-Language: en-US
To: Bibo Mao <maobibo@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20240115073101.174113-1-maobibo@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240115073101.174113-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 15/1/24 08:31, Bibo Mao wrote:
> When compiling qemu with system KVM mode for LoongArch, header files in
> directory linux-headers/asm-loongarch should be used firstly. Otherwise it
> fails to find kvm.h on system with old glibc, since latest kernel header
> files are not installed.
> 
> This patch adds linux_arch definition for LoongArch system so that header
> files in directory linux-headers/asm-loongarch can be included.
> 

Fixes: 714b03c125 ("target/loongarch: Add loongarch kvm into meson build")

> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   configure | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



