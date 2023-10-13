Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA6A7C7CAA
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 06:29:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr9mH-0000E6-GO; Fri, 13 Oct 2023 00:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9mE-0000Dc-U4
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:27:54 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9mD-0000Zu-7E
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:27:54 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b0dcbf3672so972050b6e.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 21:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697171272; x=1697776072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cfG5urhWRS1Eu0j0DckVrh97gXDp1nqUET8uftpcu4I=;
 b=SV2F+ibHSGQmsqSpNHbewleiaE1xK8Q41IbBsbroSUkMCyzS40iWE44crK8k22/M3P
 XMD/x1N9eVp2CkoriixJYKRu5hHaj+P55yp/eU2f3hCp5fqktdDG2EpVou4JEYiW3/MA
 DwnBZ94SOgFB58SNLFoR85tT6bflMMiHBOq+zIufAs5CaITFHea/mQmlFcqmZEnevcdJ
 /U/U46mVlbDB/UbciDDSlrc/2yXgXBo9ojAobW+pIR6+Jry92pJLDvt7XuvjJnAN1SIE
 i/1QTPK1eDswdZF9LnyN7ULSi30468E39EMpxmIPOXJUiBUD00BBakj0BCRNtjhb593L
 7GNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697171272; x=1697776072;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cfG5urhWRS1Eu0j0DckVrh97gXDp1nqUET8uftpcu4I=;
 b=oFlLHH7wpaEzB+bZmLzRaSRugBPbjaKnPOscrFnAnvrMbY6IjCZQLo2076grKh2kBk
 6I16w4JKe3szcK6qEpdzXB3K2FhtPRUa3MOn0KSI8hafYl2/QOW9mLnCWnszkRFem6fI
 /tQSN//DY+LimnwmLxV26JcSuo/YeqkRpQE8mFJN1tFk455zMTK8AKxRnieheyO2Dc0b
 NNL7OVcPQ50M7VPXXBgZPSu7VF4pKDnW2xTPIjeeRcW2lWn5A7mjf9BbV36iRu582reo
 +OeIXjyuWPVWiPsvtuQFHcIiuK9gRIDsFdKjtqD4n764LbUVaZO4veSNQV9mDYsL256i
 S0WQ==
X-Gm-Message-State: AOJu0Yxt9m5qVOCmIe/GZ74L92tYuL93uu6WypWAW4AiuObnNCLMZML6
 hFpvNpYLJIHcUtSVDuOd6wpDag==
X-Google-Smtp-Source: AGHT+IG/o8nAoDucEdk0fe7BvHLdEY7deSTjw2+XONYJrRiJFA4QhX1QH8s6KOa1puzF8zusfdeK5A==
X-Received: by 2002:a54:488d:0:b0:3af:79e3:68d7 with SMTP id
 r13-20020a54488d000000b003af79e368d7mr24564027oic.59.1697171271856; 
 Thu, 12 Oct 2023 21:27:51 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 by42-20020a056a0205aa00b005a9da758b89sm464345pgb.24.2023.10.12.21.27.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 21:27:51 -0700 (PDT)
Message-ID: <c580297d-c3cc-4476-a941-6dbc5e11dc43@linaro.org>
Date: Thu, 12 Oct 2023 21:27:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] cpus: Open code OBJECT_DECLARE_TYPE() in
 OBJECT_DECLARE_CPU_TYPE()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231010092901.99189-1-philmd@linaro.org>
 <20231010092901.99189-16-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231010092901.99189-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 10/10/23 02:28, Philippe Mathieu-Daudé wrote:
> Since the OBJECT_DECLARE_CPU_TYPE() macro uses the abstract ArchCPU
> type, when declaring multiple CPUs of the same ArchCPU type we get
> an error related to the indirect G_DEFINE_AUTOPTR_CLEANUP_FUNC()
> use within OBJECT_DECLARE_TYPE():
> 
>    target/mips/cpu-qom.h:31:1: error: redefinition of 'glib_autoptr_clear_ArchCPU'
>    OBJECT_DECLARE_CPU_TYPE(MIPS64CPU, MIPSCPUClass, MIPS64_CPU)
>    ^
>    include/hw/core/cpu.h:82:5: note: expanded from macro 'OBJECT_DECLARE_CPU_TYPE'
>        OBJECT_DECLARE_TYPE(ArchCPU, CpuClassType, CPU_MODULE_OBJ_NAME);
>        ^
>    include/qom/object.h:237:5: note: expanded from macro 'OBJECT_DECLARE_TYPE'
>        G_DEFINE_AUTOPTR_CLEANUP_FUNC(InstanceType, object_unref) \
>        ^
>    /usr/include/glib-2.0/glib/gmacros.h:1371:3: note: expanded from macro 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
>      _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
>      ^
>    /usr/include/glib-2.0/glib/gmacros.h:1354:36: note: expanded from macro '_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
>      static G_GNUC_UNUSED inline void _GLIB_AUTOPTR_CLEAR_FUNC_NAME(TypeName) (TypeName *_ptr)                     \
>                                       ^
>    /usr/include/glib-2.0/glib/gmacros.h:1338:49: note: expanded from macro '_GLIB_AUTOPTR_CLEAR_FUNC_NAME'
>    #define _GLIB_AUTOPTR_CLEAR_FUNC_NAME(TypeName) glib_autoptr_clear_##TypeName
>                                                    ^
>    <scratch space>:54:1: note: expanded from here
>    glib_autoptr_clear_ArchCPU
>    ^
>    target/mips/cpu-qom.h:30:1: note: previous definition is here
>    OBJECT_DECLARE_CPU_TYPE(MIPS32CPU, MIPSCPUClass, MIPS32_CPU)
>    ^
> 
> Avoid that problem by expanding the OBJECT_DECLARE_TYPE() macro
> within OBJECT_DECLARE_CPU_TYPE().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/cpu.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Unfortunate, but I suppose this isn't so bad.

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

