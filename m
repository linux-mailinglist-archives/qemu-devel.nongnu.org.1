Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2C478D013
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:14:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7np-0001Yw-Co; Tue, 29 Aug 2023 19:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4rf-00024x-EF
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:59:03 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4rc-0007Nq-Qf
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:59:03 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c1f8aaab9aso13051755ad.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693339139; x=1693943939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dqDeXwXi4OzQuPR1dbd2w1nsgE7uaStO9OxYpahxNlk=;
 b=mhunNC3SxcGyur+7WrPX2kKD2QdsgbuT+mDjkqdhG6thkIZpDRRL2gmyCo7zzkpymQ
 p7Fk6bDI/ocbHguiwMqd7Nr5PGLj/LpYEWA0YZAcocXzHjNCzQIBCRHrk/gcdQR1qePs
 XbSPvpqFLnk3BkhSDPthOmtTh/PAyLfhPySj49nJcxfdic7Dfc8orvyTAwDmYLZAnZcV
 +Kyy5PRsW/iZlrQrLhlKSPqAAr0QORFc2jegnnsPO3se0apWsMTzFOzJMoDvTB5rfmqQ
 kQgDtePogWgSD9MBO8+icj72yRY71M11B5px/orJKx+HomOnYPl2dr68Bv4BaH170nHf
 GQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693339139; x=1693943939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dqDeXwXi4OzQuPR1dbd2w1nsgE7uaStO9OxYpahxNlk=;
 b=SFk0/t/KQEJ4hzvoqz3BeN6Dr8I2dInlO7DXZPMndvgnZ+EKcD9N16nmInMrBr6Akd
 7FajIkpcFwIwavhBjBc2FfF4Sk+QZW98rnoXcjdHn0SadBF1rhLf4m7o1rP219sWWc4X
 M4WDLeuBAY9dTailgBg953x3l+N7IwuFvNCHLoIhToLi17pvZZPRdZtBqqI0SKLxRTqZ
 09EnpjJNuZbnZqGC+mcZXbhpcPTIln+tbzXykkCFnllocQP9WDPD72/ZKCud/doqzfxy
 BZ9KbTAAobGQ3p47tjLQS2nAalUgqYctza6fICojwbylSZb4s4jj9Vg05bf1Op0udJ/C
 wWXQ==
X-Gm-Message-State: AOJu0Yyedtn9YkwjOlSOLyEvUKDDJVNVZVez6h6lzLXsPMlD1ZajNrpu
 1LtZmUVMuQuI/IBvLXXd167wmq7XsrVx+HCaYyE=
X-Google-Smtp-Source: AGHT+IEcMejeDWGVMbdEqIIMFw6qd1UEvf0OjLExOh9Bg8zpe6flKfGALEtDHaJnGIUDmYqPoJeq9g==
X-Received: by 2002:a17:902:bd96:b0:1c0:ecbb:182f with SMTP id
 q22-20020a170902bd9600b001c0ecbb182fmr142279pls.5.1693339139522; 
 Tue, 29 Aug 2023 12:58:59 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a170902ed4300b001bdd512df9csm9732109plb.74.2023.08.29.12.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 12:58:58 -0700 (PDT)
Message-ID: <1b9e118a-0ebe-1b27-6d44-c85ab30fe43d@linaro.org>
Date: Tue, 29 Aug 2023 12:58:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 16/32] bsd-user: Implement several get/set system calls:
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-17-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-17-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
> getpid(2), getppid(2), getpgrp(2)
> setreuid(2), setregid(2)
> getuid(2), geteuid(2), getgid(2), getegid(2), getpgid(2)
> setuid(2), seteuid(2), setgid(2), setegid(2), setpgid(2)
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-proc.h           | 90 +++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c | 60 +++++++++++++++++++++++
>   2 files changed, 150 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

