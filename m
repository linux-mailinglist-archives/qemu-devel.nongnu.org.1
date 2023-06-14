Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F18B730033
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 15:36:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Qdh-0004RX-Dh; Wed, 14 Jun 2023 09:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9Qdf-0004RB-8l
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 09:34:19 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9Qdd-00066X-MG
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 09:34:18 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5149c51fd5bso11159519a12.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 06:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686749649; x=1689341649;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4jHz0/L+mCLjSsW8Q8eVvQKIrcWqbKz5qwa9macGPZg=;
 b=x2IqPvfNOZHTIA39poH89sG5PPUf5hOCJzPqvMlbMuB0QfoFEAg6IYR6jMrlw+R8Tx
 5f+ThCY75POXP56/YWZkWTazWmgeDuRCmq3qJKOJhSVNRNAxu0oeXztaimISfemYjNhd
 T7zDlYsE7YefZ+ygzoDQQTcXe1MPpmcH9tI8Am/nzYw8mpp2m7oGXTZA+OGJ3XL0E6eo
 ODjSdtg/aM/gMgwyVVTRlXXKXynSQZ21CEI+EzwebmkiGLVU8cgqCAbqH/zMI8AV/Cb3
 F+lsugcH1jYTmLJ3xne/nWStx2qC96NLCfXbZWxEQBiWdjojFcWuRErXXo5p/jTnUIKS
 3qBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686749649; x=1689341649;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4jHz0/L+mCLjSsW8Q8eVvQKIrcWqbKz5qwa9macGPZg=;
 b=T/4fMRCJW82Uk8vbwgM97xJ9Uv62mJsz3Ri/ZLCMhAgPEm+NpSZY4YKGTtVjN2h+0R
 kj0iMyTP6xW6gAJ5FPxlLRs4eUGs5uhhVaxptxK0WWlJMMD0qyV12CgJ8LgNBFtz8wow
 XSey2cJ5FVM/iK+F/y0S4k0xgNvBM9tLcENqhlBukhrAfC8C+rzFBGJkkCnG1Td80B3o
 2DYPod6oShSIA1PswYzljB3yM6Ij6Zeay6wvCkPP5laXEvgPxnGM5vmPuRecV/S5YA/r
 GEtf7GgQGfu8VLhWl8ywvA7dL7r81J6SfeNkYeb/w+ZoosvhOsYei8BbkSRq75PiZlFk
 NzVg==
X-Gm-Message-State: AC+VfDx7rN7koEwEldwL/C/m1DukthtB2noFlZNBOZDQDrurs0aoSi+U
 dAd5g+Y7sPmAkR6kZeh1XUsPbQ==
X-Google-Smtp-Source: ACHHUZ4tgbVnxeGVSRptCUK1M0sNUQ7Q2dhlXCi1ehj/KMZpQ7q9PBUIg7eIcbGofYxo1ZOjGICafQ==
X-Received: by 2002:aa7:db59:0:b0:514:9edb:829e with SMTP id
 n25-20020aa7db59000000b005149edb829emr11124259edt.18.1686749649389; 
 Wed, 14 Jun 2023 06:34:09 -0700 (PDT)
Received: from [10.14.201.121] ([213.175.39.66])
 by smtp.gmail.com with ESMTPSA id
 b24-20020a056402139800b0051827a12b47sm5636862edv.15.2023.06.14.06.34.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 06:34:09 -0700 (PDT)
Message-ID: <606e9884-6ecc-2f34-1aa2-31d093de7191@linaro.org>
Date: Wed, 14 Jun 2023 15:34:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 24/26] target/arm/tcg: Inline 'exec/helper-proto.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230611085846.21415-1-philmd@linaro.org>
 <20230611085846.21415-25-philmd@linaro.org>
 <d4fddb7c-b0a1-6a52-b15d-e86f025c72ee@linaro.org>
 <3f50cb09-1460-522c-dedc-02b1b99ce9a9@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3f50cb09-1460-522c-dedc-02b1b99ce9a9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/14/23 14:50, Philippe Mathieu-Daudé wrote:
> We get:
> 
> ../../target/arm/tcg/vec_helper.c:268:6: error: no previous prototype for function 
> 'helper_gvec_qrdmlah_s16' [-Werror,-Wmissing-prototypes]
> ../../target/arm/tcg/vec_helper.c:293:6: error: no previous prototype for function 
> 'helper_gvec_qrdmlsh_s16' [-Werror,-Wmissing-prototypes]
> ...
> 
> ../../target/arm/vfp_helper.c:511:10: error: no previous prototype for function 
> 'helper_set_rmode' [-Werror,-Wmissing-prototypes]
> ../../target/arm/vfp_helper.c:1127:10: error: no previous prototype for function 
> 'helper_fjcvtzs' [-Werror,-Wmissing-prototypes]
> ...
> 
> ../../target/arm/tcg/m_helper.c:581:9: error: call to undeclared function 
> 'helper_exception_internal'; ISO C99 and later do not support implicit function 
> declarations [-Wimplicit-function-declaration]
> 
> ../../target/arm/tcg/helper-a64.c:831:9: error: call to undeclared function 
> 'helper_rebuild_hflags_a32'; ISO C99 and later do not support implicit function 
> declarations [-Wimplicit-function-declaration]
> 
> ../../target/arm/tcg/psci.c:174:9: error: call to undeclared function 'helper_wfi'; ISO 
> C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> 
> ../../target/arm/tcg/tlb_helper.c:168:6: error: no previous prototype for function 
> 'helper_exception_pc_alignment' [-Werror,-Wmissing-prototypes]
> 
> ../../target/arm/tcg/crypto_helper.c:73:12: error: function cannot return function type 
> 'void (void *, void *, void *, uint32_t)' (aka 'void (void *, void *, void *, unsigned int)')
> void HELPER(crypto_aese)(void *vd, void *vn, void *vm, uint32_t desc)
> 
> Do we need more tcg/helper-foo.h.inc?
> - gvec / simd / crypto
> - exception / wfi

crypto, pauth, mte, for sure.

gvec could go with vfp.
fjcvtzs is definitely vfp.

I doubt a separate header for exceptions would pay off.


r~

