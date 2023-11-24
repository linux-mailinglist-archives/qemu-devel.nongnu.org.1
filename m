Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1AD7F72CA
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:34:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6URB-0004sN-7k; Fri, 24 Nov 2023 06:33:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6UR7-0004rk-VY
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:33:31 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6UR5-00071D-V6
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:33:29 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32d9effe314so1189175f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 03:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700825605; x=1701430405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cnIBb0DITQHegPTXKJNxK2KHGT7/5Q8XJ5dSx/6cJ5Y=;
 b=EFoYO0/g34NrqRyMXBGwpNc6dx/6PAUrvohEI5xKOZeCsNREfIXidQ/3vQsBu4AuA0
 Li/21ouOkT2Q84IUxg9QqIQmmmz7lnQTor4erNZ6SQEDH86BLcxSuW9whJRNqdfjRxMU
 +RMgzCj+G96ShFkWVvFf07fGHe8RiJsR0jfGKieuut0yjs6rPHwKcAqslnMvJHGtzb7X
 rW9iR45Kd2fMjZjIZE5SRbIevVVb7nUD84ve6PvAHE91OptEogYWYAu9tcIsq5t998xu
 WsMCaCskqH3QMyGaxhYQPJh7WVJcPzTbkPqPT1fCZBSt9EKTEx+gZctlJgav3CrxP0s4
 WCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700825605; x=1701430405;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cnIBb0DITQHegPTXKJNxK2KHGT7/5Q8XJ5dSx/6cJ5Y=;
 b=nmyhLdLs9i7tzsnr6a1InUEiVPTh7ayuW7+sAZnQD7ttOiOcXE2NlHMb4LdYx6tqig
 e6fa1ktn/Uhl0JFVjM0GcQYYvHcUsBWFzddFRkncZygA/+KefT1XuJ/L6XcoHTuD/qBN
 pQK/8O3Hx8R178aBjoO/lqe3ecp7ZA5vL9Mv8+2U/iFkcvn8KXGBsodHSUCloy/obJKP
 OTBML9gsz60y/wZ3jtVnJyProt1WY26YnFSc8dPP2xN+JTEN8KwtAB6r+R51jTVZxTkK
 JcQMRphqOSMVBFTgT/XZWffRY9yxdC0+M3cRhQDAwCH3BkylznusfYpDj5h4JvNt70hO
 FtZw==
X-Gm-Message-State: AOJu0YzzT0y+XQSeh+pNzcrck3ge2MkkBKzuBZ+3yhC5bIbpof7A4ob6
 jdv27s+8jobtbqlsEDWXHjaRhIQ8ooB3vUqZ8mw=
X-Google-Smtp-Source: AGHT+IFqblTK0bswDa5qs4QGKoqQQvPC01Gmno4q0llo9i2iYJTUg4e8anmxuOuDC3gmAobvTn3ptw==
X-Received: by 2002:a5d:49c7:0:b0:332:d4a6:1143 with SMTP id
 t7-20020a5d49c7000000b00332d4a61143mr1827500wrs.7.1700825605551; 
 Fri, 24 Nov 2023 03:33:25 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a5d504b000000b0032d96dd703bsm4076728wrt.70.2023.11.24.03.33.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 03:33:25 -0800 (PST)
Message-ID: <370db517-466a-418a-b73a-b6d4ffbeff08@linaro.org>
Date: Fri, 24 Nov 2023 12:33:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/21] target/arm/kvm: Unexport kvm_arm_vm_state_change
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-22-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 23/11/23 05:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h | 2 --
>   target/arm/kvm.c     | 2 +-
>   2 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



