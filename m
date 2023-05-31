Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5057172DC
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 03:09:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4AKJ-0006aE-2s; Tue, 30 May 2023 21:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4AKF-0006OH-GK
 for qemu-devel@nongnu.org; Tue, 30 May 2023 21:08:32 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4AKD-00032b-6T
 for qemu-devel@nongnu.org; Tue, 30 May 2023 21:08:30 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-53482b44007so3271951a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 18:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685495306; x=1688087306;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9QhpqRcXIe0ZOFolarDaHNkExgYWJb05/CLB8/RKs/U=;
 b=F8cwKyeA3aHwLe5Jd5WLk1fI5X8SnI71v2bVVYxdqRWFtS8CXDA3/y+JCIxr9UHJHS
 BGp1Rc9l/E2R8QCm85odAxi/8LnrFM3OxcRPFT4cpmmk1sGSvMCpOCVstk/uO/L9G+dS
 29V0ppTBmTSGGCiSQKgM4O8V5LYLm+ugt3szxA0W6gNlFxOnoDNpqoOoveFyczaLhvXy
 rmMhOgRvexBvlzhvV44ZYi1YAhqMXnJ/ELbpR+ob/RtbD/H/BknJ2SJmONT46LEHb0AO
 INvWMxkdNaQFkm4euFsyxep3JcHviVgXraf9zWLXHyyby0TTb3MlBB2rYrRLr4mD7ZRy
 XZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685495306; x=1688087306;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9QhpqRcXIe0ZOFolarDaHNkExgYWJb05/CLB8/RKs/U=;
 b=bYALjsr4EQxTd/DFQdv0dFv6KkDCfVy0M4iL4LrpIO2M67SrYVHVj4Zaf8ZPongRnA
 XRHPgLv/eZsLWKF5WYzCRthGJJQiAmIIGHz1FN5ol+CcRmri8N2cQ63fA+dckBVqBSYO
 Ue2IAbrKE0HQIIbkTiddgGa8l5vl+I9XfQTm5l7vFCZLlFAJ64pcl55aQZPDuUbsBxAS
 jwORf8CDasiVUrLMc4b5O/sE9l5QyGly6mAlJZg02Z4pf8tDq0l/UsCHjuzSwlcoSkfo
 9+gk779Dh+94841vx3E7DTdUYBYIn7jofEKUqzR8jBVkjTDi7Mv9c8HTdRqEFGtQRIGM
 bsIw==
X-Gm-Message-State: AC+VfDyl6UEr1UEM3gl6CZ95ztAYANyeo18p/xqBR8XZ0Yj3x09gbKcz
 TTwLGroN1hfSRgEVDOgI2nZBJdBFcIqJS5UL1a4=
X-Google-Smtp-Source: ACHHUZ6sHupmFyKzOaoDPz4NENGheY5Sgy60zTgavvEP4uM3ecLO20eHvnu0XjrTsf5ugFnspYvxVQ==
X-Received: by 2002:a05:6a20:d90b:b0:10a:e8b1:34bb with SMTP id
 jd11-20020a056a20d90b00b0010ae8b134bbmr3876792pzb.56.1685495306412; 
 Tue, 30 May 2023 18:08:26 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:35a2:c45d:7485:f488?
 ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a170902690200b001ab0b2dad2fsm324396plk.211.2023.05.30.18.08.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 18:08:25 -0700 (PDT)
Message-ID: <a2fd61cb-190b-9658-c6ef-0252679f1c5c@linaro.org>
Date: Tue, 30 May 2023 18:08:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/27] tcg patch queue
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230530185949.410208-1-richard.henderson@linaro.org>
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 5/30/23 11:59, Richard Henderson wrote:
> The following changes since commit 7fe6cb68117ac856e03c93d18aca09de015392b0:
> 
>    Merge tag 'pull-target-arm-20230530-1' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2023-05-30 08:02:05 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-tcg-20230530
> 
> for you to fetch changes up to 276d77de503e8f5f5cbd3f7d94302ca12d1d982e:
> 
>    tests/decode: Add tests for various named-field cases (2023-05-30 10:55:39 -0700)
> 
> ----------------------------------------------------------------
> Improvements to 128-bit atomics:
>    - Separate __int128_t type and arithmetic detection
>    - Support 128-bit load/store in backend for i386, aarch64, ppc64, s390x
>    - Accelerate atomics via host/include/
> Decodetree:
>    - Add named field syntax
>    - Move tests to meson

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


