Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A155774BA3
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 22:51:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTTfM-0001u1-QW; Tue, 08 Aug 2023 16:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTfK-0001to-NT
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 16:50:54 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTfJ-0002kO-0G
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 16:50:54 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-686b9964ae2so4455133b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691527851; x=1692132651;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iyz9OgVtGeMYFF+Cug6ac8vBRxmckEeU505c+EM0mz8=;
 b=niWeAiSW4TIuQRYoklFeB5rui/LJcgr2AWeR3drcQyxKSiNqLheJHdiM3nCLQnQCm/
 HFgryPZ/hRHDsI8DHm93XgFafcMOBClnmBQ6fpyHBiaNbH1hsk/ruJe/wtFU0diymW3G
 gT5O5Svkznf89zV8UW8+E9RD02nKOzH5tGDSQtldwOr4q1rS3uXWqSjg80M4JsdnXAWf
 hVp0SY9j2hWrS+lmFAWlMdysofcmmjD8wX3yFkVXgJ2A+vHe15RWpEqDA3SDyoLY6UQA
 YjPk9OLXj/H2ZlLOYCJvJSwdHpTmI4J5bnzh5ztyqB2t7il+DsVCv5PDDzuBQnmZFRdm
 7xJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691527851; x=1692132651;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iyz9OgVtGeMYFF+Cug6ac8vBRxmckEeU505c+EM0mz8=;
 b=RlgfrRfeBjBDXfQtema+GwBnVN/BPLGjGRBp8ppJgLFPlEUOlc2JuSTYl84LcpqutF
 Odd1QoAffyAUVOS3g02Bc9XVPGfP+ooV2cYtO46LSsRNyO+1Egzl+vddxai2cFhwPK9l
 W7hxyrskM3PXkCN9HCY7ynLPYwWlnmJ2IuFezFSqjzkcvcMkcwG3skJFR+kWq2L2RRpc
 5RLWLSgWjJQA/eoC8BYVdpu1qPXz/9zjyXSwdkUkFlOUt3KNL/UysRTFf7m4+j2vE4Ah
 6Jaziemj4fL0VnF2FgnlBA/gmplaavNgeGQWXU4BfDwk0xJKsrjiSn16icPmFd2S2mUg
 E1Ow==
X-Gm-Message-State: AOJu0Yzu7tR7gipcnWO4YR/r8JMOQqOc86/K8Yem1CfydmZsHkssXjAR
 NpsdVXXFMMYFR2znn/5w7IZNSA==
X-Google-Smtp-Source: AGHT+IHCACHWqW8PBzkjgNNZduO41JVqUASNFgqCHmV/D7V5f1+acRoFXGvcyoYZlPCuxBK/ZU3ohw==
X-Received: by 2002:a05:6a20:244b:b0:138:60e:9c4 with SMTP id
 t11-20020a056a20244b00b00138060e09c4mr718332pzc.23.1691527851427; 
 Tue, 08 Aug 2023 13:50:51 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a170902b7ca00b001b567bbe82dsm9453133plz.150.2023.08.08.13.50.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 13:50:50 -0700 (PDT)
Message-ID: <612acdbb-865d-0e32-9212-df9440a0e8bb@linaro.org>
Date: Tue, 8 Aug 2023 13:50:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/33] Disable clang warnings arising from bsd-user/qemu.h
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-3-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-3-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 23:07, Karim Taha wrote:
> +/*
> + * Tricky points:
> + * - Use __builtin_choose_expr to avoid type promotion from ?:,
> + * - Invalid sizes result in a compile time error stemming from
> + *   the fact that abort has no parameters.
> + * - It's easier to use the endian-specific unaligned load/store
> + *   functions than host-endian unaligned load/store plus tswapN.
> + * - The pragmas are necessary only to silence a clang false-positive
> + *   warning: see https://bugs.llvm.org/show_bug.cgi?id=39113 .
> + * - We have to disable -Wpragmas warnings to avoid a complaint about
> + *   an unknown warning type from older compilers that don't know about
> + *   -Waddress-of-packed-member.
> + * - gcc has bugs in its _Pragma() support in some versions, eg
> + *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83256 -- so we only
> + *   include the warning-suppression pragmas for clang

Perhaps s/in some versions/prior to gcc-13/ ?
At least that's what the bugzilla says, and it
will help when auditing for compiler versions
in a few years when gcc-12 is EOL.

Either way,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

