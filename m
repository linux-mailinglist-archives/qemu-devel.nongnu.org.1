Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C49397C86FE
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 15:38:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrILr-00066m-JL; Fri, 13 Oct 2023 09:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrILn-00066V-P2
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:37:11 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrILl-00043b-AS
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:37:11 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6c665b2469dso1301605a34.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 06:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697204228; x=1697809028; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QJ7wL+OPCRjOLVH1St5e3C5N4Ed5IJlK8adXtiFc9yg=;
 b=lsvMwGXmzGnz5w1XFfPboNGyT/ZJiXrfTgEC7Bhe8+X36uV8UDX6Zb0Nf0Jjo9DYaq
 5FLmPHWZMNPra1gx9NnSkhWVcZ7RijK5I0yitZsNMRXJ44jfkkNUWHAZDZp+r6TNzf9D
 oI6ZG+b0GOQZNFFzbKuFhIE9N+cDqjOEw07sw5ihQ4VFyr/BNs2h7w/DBF6EdpkPsttK
 J14QCoY+uHdDan9A9poqzZCqhvPDdVFCHvw3SoikWw6xEv+35FelrRZMLKZ2NTLJU65d
 CjXsM0PvrpSYfDL3Q7isLOO4jLNwrtdKtc07JygTxCfhvv/mcUXsb/F+woeeHAtaJ2YZ
 XtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697204228; x=1697809028;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QJ7wL+OPCRjOLVH1St5e3C5N4Ed5IJlK8adXtiFc9yg=;
 b=XTldlETWW0CBVDIPUazXWomSlpySQudS1pYiuvS0Rvd3JUo66jAbtKrZGT4vyMXrvn
 ITIfDd6tmtFXYS3O6/MHASBd6xZ/GD3jLtmgA/qnnh5QLpseQz6Qkn72GwtJIwh7i+tc
 JErAfOIW1Qt9pBxl//rYcfb+ObGV0hJYjY3r+zqzdA2smcaFEQsVa3fuFIEGNuihe/oD
 lQJ3HPOk/shLAQAdhYUQyieY7JLsE++C5M3ZLiBshp8vzmkkRT5J085qntToz1vf4weC
 SvK1Aie42pzTqu+zccufYBsAW3VNjsI7iWhwtUhrFg9qFa108NbC1h985PEPKDI5eTdA
 6XaQ==
X-Gm-Message-State: AOJu0Yy77ByN254HqAO/ndDVhlEihFfaT3Ys6VG4wTctUEsao+1g/nE/
 FNdqaKa0D2cSdIQqtasw/hzYzA==
X-Google-Smtp-Source: AGHT+IHCNoiSgAwtBarMUAhHOcYqr0biymTkE/h7KKEFPw7MlclrV7OK2agfupgYpSncqdHAfmcAVA==
X-Received: by 2002:a9d:7c99:0:b0:6bf:1925:13a0 with SMTP id
 q25-20020a9d7c99000000b006bf192513a0mr32138807otn.33.1697204227922; 
 Fri, 13 Oct 2023 06:37:07 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 s5-20020a625e05000000b006b3b342f37fsm1237513pfb.178.2023.10.13.06.37.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 06:37:07 -0700 (PDT)
Message-ID: <7af692cf-2208-49ff-bf90-78889e009b7e@linaro.org>
Date: Fri, 13 Oct 2023 06:37:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] target/ppc: Move PowerPCCPUClass definition to 'cpu.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231013125630.95116-1-philmd@linaro.org>
 <20231013125630.95116-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231013125630.95116-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

On 10/13/23 05:56, Philippe Mathieu-Daudé wrote:
> The OBJECT_DECLARE_CPU_TYPE() macro forward-declares the
> PowerPCCPUClass type. This forward declaration is sufficient
> for code in hw/ to use the QOM definitions. No need to expose
> the structure definition. Keep it local to target/ppc/ by
> moving it to target/ppc/cpu.h.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/ppc/ppc.h |  2 +-
>   target/ppc/cpu-qom.h | 56 --------------------------------------------
>   target/ppc/cpu.h     | 51 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 52 insertions(+), 57 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

