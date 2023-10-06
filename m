Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1AB7BB147
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 07:51:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qodii-00007E-RM; Fri, 06 Oct 2023 01:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qodid-00004z-KR
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 01:49:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qodib-0004R9-Sj
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 01:49:47 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4054496bde3so15901295e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 22:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696571384; x=1697176184; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ygTzfWw9MxozQIUZgJ+0e2jiN0S3gvljQChMNzQoZp0=;
 b=JGn7QXoJ8D+P/CAVg8dAEClltXmqrg8FTXC7xyqXRsl6SPW+s1+5BJsH/87bi2nEEu
 ppRXNXytSU4yq1B+vP/8vI+O2SYoO6mbUlVK1m9ZVpnWRI8chvX8UMtq+7rp2naQmH2R
 JCGN3BGtNwlltbMhsUs3G0SLA4HtgM/DaQV3QA4rJIkyMDbtKt78jwh7rXxFLzayPJaz
 8xuClxc0t1W3QlVkxIda/Cgq07zBjadrYMG/Bwuj2JLxeGfDxx239k0hbsbB/1iOR/IZ
 FqFsXaC8S76QVCtTytTH0pP+SaBM+768D7QAfDDAU0U4BN8r2YCyGrwMTBTfjS5AmvGy
 tJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696571384; x=1697176184;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ygTzfWw9MxozQIUZgJ+0e2jiN0S3gvljQChMNzQoZp0=;
 b=kvcJcfL8LtTmEsbGPVVvCIJrKBwfOs3wxyQ3XNrV1CNZa4aSWxdVROVOCDpukYIs8s
 DyKVuqzLCPhvTRrmSVVrv3ckgP8GAQDXlzhvEpxnreWk3exm6q2MyFiHGOpr8jR2Eqx1
 Oz1Q03QcS9JLjUC4buPAhf0eJ6Xy5wd/K5PoFppVaomZtXlo3r/+dh4UK6fMIvjs7iIY
 JS5/Gs4iVL5IpIzieMMt/50crvLTuXELkfEwB0BtScIr6nghVLwdp5CU7NSPDA5zGge6
 wjghelBJ6kj61Bl32EK17I4Kx5M/AzyCjPY+OjVAsYuzQdzRmSbK2zt8dxz3rsv04WYc
 tGZg==
X-Gm-Message-State: AOJu0YwAVCIFZZ6LR/565/PfWJ7P+mVuU2VuLPM/4awlo1QDJeuWN7tB
 w1rf4hudqT60MDdDkzbsVF91Xg==
X-Google-Smtp-Source: AGHT+IF73Kj4dQ/Ks7OjZwnMLQs9jU8qNqQT3QE6siG6g9VZ0losu8wNly+3nua0t00qyMu6qWWNoQ==
X-Received: by 2002:a05:600c:2210:b0:405:3cc5:1105 with SMTP id
 z16-20020a05600c221000b004053cc51105mr6740030wml.8.1696571384256; 
 Thu, 05 Oct 2023 22:49:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.115.173])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a5d68cd000000b0031ae8d86af4sm778967wrw.103.2023.10.05.22.49.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 22:49:43 -0700 (PDT)
Message-ID: <45707b6e-6835-421f-e89b-6c1b0c50e35f@linaro.org>
Date: Fri, 6 Oct 2023 07:49:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/3] target/hexagon: fix some occurrences of
 -Wshadow=local
To: Brian Cain <bcain@quicinc.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, quic_mathbern@quicinc.com, stefanha@redhat.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com
References: <20231005222206.2784853-1-bcain@quicinc.com>
 <20231005222206.2784853-3-bcain@quicinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231005222206.2784853-3-bcain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
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

On 6/10/23 00:22, Brian Cain wrote:
> Of the changes in this commit, the changes in `HELPER(commit_hvx_stores)()`
> are less obvious.  They are required because of some macro invocations like
> SCATTER_OP_WRITE_TO_MEM().
> 
> e.g.:
> 
>      In file included from ../target/hexagon/op_helper.c:31:
>      ../target/hexagon/mmvec/macros.h:205:18: error: declaration of ‘i’ shadows a previous local [-Werror=shadow=compatible-local]
>        205 |         for (int i = 0; i < sizeof(MMVector); i += sizeof(TYPE)) { \
>            |                  ^
>      ../target/hexagon/op_helper.c:157:17: note: in expansion of macro ‘SCATTER_OP_WRITE_TO_MEM’
>        157 |                 SCATTER_OP_WRITE_TO_MEM(uint16_t);
>            |                 ^~~~~~~~~~~~~~~~~~~~~~~
>      ../target/hexagon/op_helper.c:135:9: note: shadowed declaration is here
>        135 |     int i;
>            |         ^
>      In file included from ../target/hexagon/op_helper.c:31:
>      ../target/hexagon/mmvec/macros.h:204:19: error: declaration of ‘ra’ shadows a previous local [-Werror=shadow=compatible-local]
>        204 |         uintptr_t ra = GETPC(); \
>            |                   ^~
>      ../target/hexagon/op_helper.c:160:17: note: in expansion of macro ‘SCATTER_OP_WRITE_TO_MEM’
>        160 |                 SCATTER_OP_WRITE_TO_MEM(uint32_t);
>            |                 ^~~~~~~~~~~~~~~~~~~~~~~
>      ../target/hexagon/op_helper.c:134:15: note: shadowed declaration is here
>        134 |     uintptr_t ra = GETPC();
>            |               ^~
> 
> Reviewed-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---
>   target/hexagon/imported/alu.idef | 6 +++---
>   target/hexagon/mmvec/macros.h    | 6 +++---
>   target/hexagon/op_helper.c       | 9 +++------
>   target/hexagon/translate.c       | 9 ++++-----
>   4 files changed, 13 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


