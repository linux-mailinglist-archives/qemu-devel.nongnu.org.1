Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 913E782EC21
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 10:50:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPg50-0003nq-IJ; Tue, 16 Jan 2024 04:49:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPg4y-0003nN-Iz
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 04:49:56 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPg4w-0004gL-MF
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 04:49:56 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50e7f58c5fbso12969105e87.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 01:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705398593; x=1706003393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ldUmKscrpaJnyXOy9sFVnojhALv7lIHQYN+Oy6fQZL0=;
 b=B2N1I9FCn51/IErFDw2kVTs3Tq6RhuxXX1S7o6AGc04w50rHM0rct+M7Guh8rNSMMG
 f452Dm9jMnY1cJJuUi6oDlyx1UTBbaTPLzijMhLgDsnLsajN/bPENZAInIPlfc2/qPKn
 Fdg792kGrZ0HxAo5LpX1IMa5QqENKP1Y5h4s01Yv/evfgLnpPw9iSeHnnRSlU/6mTgGl
 4tl3MeJbkA5ZoCGpHtnUYwdb6elUcIAniIXXIpeFGJP35rgPUzZ4R1TNUWns1qFEbPuE
 LHPnELf+X5S7Fw+tKAjSNYiffvzZTuyWZl1juC1t4YzZ5RbALY5B507N63tbza4WFZKb
 M6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705398593; x=1706003393;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ldUmKscrpaJnyXOy9sFVnojhALv7lIHQYN+Oy6fQZL0=;
 b=E+wt6OWHXv0d6GLYvXsbjan2QNeYgNvCcZuXTVPvZU7vTa9i3ESLTCRnwIZonEuo4g
 2gaVuldcYAUzljP9dOju5ufF1XLjMYrZ3k4vmVYa5ygfBf6KFmLoL2ie/kSM/sUz4o68
 fEsVsnKmpriFcMJyhmk3mWTE62zCdzyRtSlI9OR8xXvdcxFEzn7RTHNgVsQi6ZbyhZUL
 MnbaKcoeLNgzYlne6sbE2jjudSqqH7icyyucvoD7O6sFKaP97zaNdfgIFKqbTEXxdaNX
 EKTCiViN6kBN4F/0suUXbVSB9vVkbIDCyleIXN6taZxvP+6xmwHqZ5/hF9sMXfcmeJT0
 CkaA==
X-Gm-Message-State: AOJu0Yxop/jIBTPss6XePoxNRL+8h5gvXa8+wjULTKRORhGYH6AEDJ1i
 dutQZEitxlUjGgHVhF23ku6tAalqFE8FQQ==
X-Google-Smtp-Source: AGHT+IEIzyfVuYe7bBWkEiSEXOJqsoMyPkTVprgVMsPxqM27r9PYhIn09SItknnebIZttbyN8FhIAA==
X-Received: by 2002:a05:6512:3ba2:b0:50e:6b4f:9808 with SMTP id
 g34-20020a0565123ba200b0050e6b4f9808mr4573053lfv.96.1705398593088; 
 Tue, 16 Jan 2024 01:49:53 -0800 (PST)
Received: from [192.168.69.100] ([176.187.209.30])
 by smtp.gmail.com with ESMTPSA id
 cw8-20020a170907160800b00a2cd72af9cesm5042193ejd.146.2024.01.16.01.49.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 01:49:52 -0800 (PST)
Message-ID: <686a8079-8ffd-4fed-a818-9d46a7bec0bf@linaro.org>
Date: Tue, 16 Jan 2024 10:49:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configure: Add linux header compile support for
 LoongArch
Content-Language: en-US
To: Bibo Mao <maobibo@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20240116013952.264474-1-maobibo@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240116013952.264474-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

On 16/1/24 02:39, Bibo Mao wrote:
> When compiling qemu with system KVM mode for LoongArch, header files
> in directory linux-headers/asm-loongarch should be used firstly.
> Otherwise it fails to find kvm.h on system with old glibc, since
> latest kernel header files are not installed.
> 
> This patch adds linux_arch definition for LoongArch system so that
> header files in directory linux-headers/asm-loongarch can be included.
> 
> Fixes: 714b03c125 ("target/loongarch: Add loongarch kvm into meson build")
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Changes in v2:
>   1. Add Fixes label for commit 714b03c125

Thanks Bibo, no need to respin for tags such 'Fixes' or 'Reviewed-by',
git tools include them directly when applying patches.

Since you haven't Cc'ed Song Gao, I'm queuing this via my tree.

Regards,

Phil.

> ---
>   configure | 1 +
>   1 file changed, 1 insertion(+)


