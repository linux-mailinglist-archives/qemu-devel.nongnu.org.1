Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3208071F910
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 06:00:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4vwD-0002Se-Ng; Thu, 01 Jun 2023 23:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4vwC-0002SG-2i
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 23:58:52 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4vwA-0004tZ-9T
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 23:58:51 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-19a13476ffeso1821023fac.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 20:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685678328; x=1688270328;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eemzpZaPRtpMEyrZ5pe4+VKaYaE71azmDbnxxQoXb1s=;
 b=O8vFHMB/+g0bUJ3oLc0XZy1VLtG9YWFOz1PK7xClGa8+zIPzmkht6ylnKCGEAp+NkK
 Flm5z27CaHKT2Q2jtY1ef2csOH4oJfx66tv+oG4ozkD8BzQcxxVC7LUOQknlOp0ldu7o
 /FURuTwSJKBGK3C84r4YUQUjLKo8MfUWRaWsnqshBTDdPX3qjaHB4Lf4ArpEVPyz5TWk
 lH+WBwfyQSGzdDccHCpCi+fpJzAnacwsp+kNgKoVJgTy5khctZftDkmt+wjD91DHMcpd
 UDZqjRqm511lSwzCMOJlhGCchZKJdf57addDqWTmvGzwEmO2KlYQCCCCj4vYy5uQhtd5
 z6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685678328; x=1688270328;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eemzpZaPRtpMEyrZ5pe4+VKaYaE71azmDbnxxQoXb1s=;
 b=EcEQzye0l1/IMf9xWQ4Xz9g9N7weBrodI7GY3RiWdDno8hBXPb+Ukliuxl+6ExxPhj
 Xseh1pNE3rVFJNepaWXesNsjToJqgyJoaI76dTbds5sFMLMbhV9HTcvDw1BqYD3wyAkt
 hglj+e+IPDQpYYlaADnx1rjHfR+XpOzP6DUJMWjQ/wO/WG/iW4801gmWdYkKP+pWIXHi
 7bdg25EEt8iN57T8VfNSWE7P5F/Y1SmRvgc/ly4wxcLs6YRDQZTSPfJrXUFUoVJPuGeE
 IuVJ+lG5crfOc4W7tu4Ri3KPZr1daB6c7MrtbeMUw+meKTB0ICkHwdvkLF/zGedZFYwL
 CD4w==
X-Gm-Message-State: AC+VfDwkqrh5IfyC+v3qcoUDQQNV2aLtew8hv+7F10xiYHevcSQvLsbR
 qYji/NDARe3hmTeIoFVDDPsj6g==
X-Google-Smtp-Source: ACHHUZ5DSH+mhhMWAjXsTj5OJXDiZO8aZPZ2bes1rYBOGbRBj2qVMRlM1mcqmUtbbEAT5vSQBTuOAA==
X-Received: by 2002:a05:6808:3a5:b0:397:f82f:90a4 with SMTP id
 n5-20020a05680803a500b00397f82f90a4mr1507705oie.3.1685678328135; 
 Thu, 01 Jun 2023 20:58:48 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:a70d:ae79:598f:409b?
 ([2602:ae:1598:4c01:a70d:ae79:598f:409b])
 by smtp.gmail.com with ESMTPSA id
 m23-20020aa79017000000b0064fa2fdfa9esm60021pfo.81.2023.06.01.20.58.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 20:58:47 -0700 (PDT)
Message-ID: <1e9840bd-65bc-550b-e031-9fe824aac7e8@linaro.org>
Date: Thu, 1 Jun 2023 20:58:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/21] NBD and miscellaneous patches for 2023-06-01
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20230601220305.2130121-1-eblake@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230601220305.2130121-1-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 6/1/23 15:02, Eric Blake wrote:
> Eric Blake (21):
>        iotests: Fix test 104 under NBD
>        qcow2: Explicit mention of padding bytes
>        test-cutils: Avoid g_assert in unit tests
>        test-cutils: Use g_assert_cmpuint where appropriate
>        test-cutils: Test integral qemu_strto* value on failures
>        test-cutils: Test more integer corner cases
>        cutils: Fix wraparound parsing in qemu_strtoui
>        cutils: Document differences between parse_uint and qemu_strtou64
>        cutils: Adjust signature of parse_uint[_full]
>        cutils: Allow NULL endptr in parse_uint()
>        test-cutils: Add coverage of qemu_strtod
>        test-cutils: Prepare for upcoming semantic change in qemu_strtosz
>        test-cutils: Refactor qemu_strtosz tests for less boilerplate
>        cutils: Allow NULL str in qemu_strtosz
>        numa: Check for qemu_strtosz_MiB error
>        test-cutils: Add more coverage to qemu_strtosz
>        cutils: Set value in all qemu_strtosz* error paths
>        cutils: Set value in all integral qemu_strto* error paths
>        cutils: Use parse_uint in qemu_strtosz for negative rejection
>        cutils: Improve qemu_strtod* error paths
>        cutils: Improve qemu_strtosz handling of fractions

This is failing on Windows (32 and 64-bit):

https://gitlab.com/qemu-project/qemu/-/jobs/4399466166#L3524
https://gitlab.com/qemu-project/qemu/-/jobs/4399466165#L3332

|  21/135 /cutils/qemu_strtol/overflow - 
ERROR:../tests/unit/test-cutils.c:1387:test_qemu_strtol_overflow: assertion failed (res == 
LONG_MIN): (2147483647 == -2147483648) FAIL

It seems to have returned LONG_MAX instead of LONG_MIN.


r~

