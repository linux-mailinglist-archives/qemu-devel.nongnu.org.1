Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02398746BC0
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:20:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbGE-0003x0-JM; Tue, 04 Jul 2023 04:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGbGB-0003va-T0
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:19:44 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGbG9-0003T7-WD
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:19:43 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fb7b2e3dacso8239899e87.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688458780; x=1691050780;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x3vgLRPjiF8VP3UXFGmQRiPjLhQ1O+u+Zvn9JPyzQEU=;
 b=SbfQCi4nxJfEb2BVDs/U6CrKQTToYCbhVnUu67g4+lpPrINYxkvS0ifezGnFDfmg3D
 CiUmom1P+EJTNCpVB8YzoIfMSe17OpCM3m+aylVaXN0uWqMcz5qIzVsfz50RwZVQblks
 BQR6ykQ6wBP2FXAgEVh2TFvqTa4gBLQ9pA0mYsIZq5F4vPYtV+tApCpAmY4ah9cGgfN5
 ablw7zj+6y3mT80KDGyEMDRnRA744yo0A6jftMuW11FupGJlpMR5UcUDUE+ebUcPMTb7
 F4b1JY9/mCGZoJS0VwMqVaBQ8TpwMkKnb+ymfiZ81X7nXafrTIJkNPJtv9jMF27dYLnZ
 Iiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688458780; x=1691050780;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x3vgLRPjiF8VP3UXFGmQRiPjLhQ1O+u+Zvn9JPyzQEU=;
 b=PwswdMfA0NqJDEPAq27RhvOxbgm1Vx6h04FD9j3VuQGaixn9bm+vlApg3TQbBl+Aba
 0o2/7zsFzRbq/pALjyinVAoOrwEH3IfcZs9ktarAkW8MWta4K4nX8r3OoFK4DMrCNcoN
 RDZN1ope2gctpZP+MOV0dwLbIzKmwCPst6Nq+e0wLZtAoqmHFEE/7+qO78eK5dAsdL9p
 7S/GfF1naueDZUeMUk8YWsvG7WMbCUhCn16hu53P9RC6yCDgwFiGuFupUm+S4lxQeD7Q
 HutR/5ovEBNB+8yi3UdRZUtKIcwQeD5CdVRZlyglDYdGkGEm4PWi4gfuq+pX28cfH+Ft
 YiXw==
X-Gm-Message-State: ABy/qLZxa5dIjwqvQ2QBQGy6yLs/WgCPm2KYcUyoeh45J/uL6pp5rLq3
 KU1EGFCf7EWEYuMwwzPMtUo9jw==
X-Google-Smtp-Source: APBJJlHajRojrzK+zs5aOQJE9lSbKKBcVHOIatthB11J7Mly0iOMnZYPEyfJbhWRU9UqxLhaQdO+bA==
X-Received: by 2002:a05:6512:3d0f:b0:4f9:586b:dba1 with SMTP id
 d15-20020a0565123d0f00b004f9586bdba1mr9808689lfv.4.1688458779927; 
 Tue, 04 Jul 2023 01:19:39 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 u14-20020a05600c138e00b003f9b3829269sm12164072wmf.2.2023.07.04.01.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 01:19:39 -0700 (PDT)
Message-ID: <2d4812ea-bfe0-6d47-4ba4-56ed8c2a1e26@linaro.org>
Date: Tue, 4 Jul 2023 10:19:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/38] maintainer updates for 8.1: testing, fuzz, plugins, 
 docs, gdbstub
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12e.google.com
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

On 7/3/23 15:43, Alex Bennée wrote:
> The following changes since commit d145c0da22cde391d8c6672d33146ce306e8bf75:
> 
>    Merge tag 'pull-tcg-20230701' ofhttps://gitlab.com/rth7680/qemu  into staging (2023-07-01 08:55:37 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git  tags/pull-maintainer-ominbus-030723-1
> 
> for you to fetch changes up to a6341482695e1d15f11915f12dba98724efb0697:
> 
>    tests/tcg: Add a test for info proc mappings (2023-07-03 12:52:38 +0100)
> 
> ----------------------------------------------------------------
> maintainer updates: testing, fuzz, plugins, docs, gdbstub
> 
>   - clean up gitlab artefact handling
>   - ensure gitlab publishes artefacts with coverage data
>   - reduce testing scope for coverage job
>   - mention CI pipeline in developer docs
>   - add ability to add plugin args to check-tcg
>   - fix some memory leaks and UB in tests
>   - suppress xcb leaks from fuzzing output
>   - add a test-fuzz to mirror the CI run
>   - allow lci-refresh to be run in $SRC
>   - update lcitool to latest version
>   - add qemu-minimal package set with gcc-native
>   - convert riscv64-cross to lcitool
>   - update sbsa-ref tests
>   - don't include arm_casq_ptw emulation unless TCG
>   - convert plugins to use g_memdup2
>   - ensure plugins instrument SVE helper mem access
>   - improve documentation of QOM/QDEV
>   - make gdbstub send stop responses when it should
>   - report user-mode pid in gdbstub
>   - add support for info proc mappings in gdbstub

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


