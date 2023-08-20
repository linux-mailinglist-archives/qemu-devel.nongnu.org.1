Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC96781E17
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 16:22:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXjJD-0000T6-Lp; Sun, 20 Aug 2023 10:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjJ9-0000Si-E4
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:21:35 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjJ7-0006Aw-Bb
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:21:35 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68a3b66f350so639796b3a.3
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 07:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692541292; x=1693146092;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c7w1MmIyB9IGOavYU3Qc/d93lwaESyT0kNXd2onAnMw=;
 b=CRrGNRBOBuZ04MK8/nJQHDcMIlYnLjKpelcCmhTEBN/gs1/2Rj29u7BRn2ZmDWFYNU
 oAAE1sO8km40pN7fjKOL1KTRSJTNXh4aIWKL+FgWjs41f3KOZZ8pGRqrDSHcsgFLc53c
 fEh3Vm82fYrqO3SV12ceqcBbs2LfymtdI7nziNqafNJIQCWE+wg1DmKfNXGVMysQ3xAP
 YB2qiDO03Nca6YN+pcewOiBFqTjQQ982pyxzkDyhdzBRUxbRuNou6fD7fAJ9DrSfrDrC
 CjqXjJ3GgkElusJrZa5pPzw6Ho2Hz6RqalJjy8d33HWzEp+WJea9oDX/gKhXPJZ20mht
 bhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692541292; x=1693146092;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c7w1MmIyB9IGOavYU3Qc/d93lwaESyT0kNXd2onAnMw=;
 b=LYk0t/YQZaQDGYpBQF88U20VBeLFyMdYvBaeUcfmgSEadAU/Dvu4tsJFjs9DG9on9T
 ZaCQENFqdwaaHfn55koM1xEUJCWY7OCeyi88mW4/b4XeGP5nPLY19PFUivLksjbstyDn
 rESZacMFa97ajnGPaDmTedPoekyLYuL/VyMjN69Cgm9hkcIZSXjqS6b6RlB2gs2hKUDg
 cZRUTegHwcdrLgtfpcbd2cwwk+HaSwh4KqW5o+QK4s/9WOTMqUeHR4+6zcq9av9ACowi
 RrR1tCu9I9csd9jwZu/g/Q3es7LdGSY48mI7k8kp+5gyGP6xEY0qFBTlUw4pMswwIncy
 tjhA==
X-Gm-Message-State: AOJu0YyYkPPE0ZMubrB0h+tr86lwGqlv5Wm3CrLRp3DUk0qxQVFYXuOa
 vCzITYWDLOmLlq80fQhinNfrDw==
X-Google-Smtp-Source: AGHT+IHDWy+HkG/UvbRiA3n0zhUdTma7U6XVbhPsbqqbzSp9cKToquFlGfjJqtYTAClkPaG+xBR96g==
X-Received: by 2002:a05:6a00:22d4:b0:686:babd:f5c1 with SMTP id
 f20-20020a056a0022d400b00686babdf5c1mr6164097pfj.25.1692541291911; 
 Sun, 20 Aug 2023 07:21:31 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a62b415000000b00682bec0b680sm4514902pfn.89.2023.08.20.07.21.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 07:21:31 -0700 (PDT)
Message-ID: <93a32de5-ffb4-5c96-a14f-c43ed9105a6b@linaro.org>
Date: Sun, 20 Aug 2023 07:21:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/22] Introduce bsd-mem.h to the source tree
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-12-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-12-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 8/19/23 02:47, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> To preserve the copyright notice and help with the 'Author' info for
> subsequent changes to the file.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-mem.h            | 65 +++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  1 +
>   2 files changed, 66 insertions(+)
>   create mode 100644 bsd-user/bsd-mem.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

