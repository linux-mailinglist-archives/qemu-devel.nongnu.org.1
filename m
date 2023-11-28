Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9FD7FC0F9
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 19:04:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r82Pv-0000Py-8N; Tue, 28 Nov 2023 13:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r82Po-0000Ob-Dq
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 13:02:34 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r82Pk-0007rF-Bd
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 13:02:31 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50bbc36f767so1302457e87.1
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 10:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701194545; x=1701799345; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2lEzZanP7/CaHmG+Avp5B41ij/SnJl+RpexIA/tsw5E=;
 b=Ud/Hfq3gQ/7fXaJnFQMYK3IJ7Xr5n4DKU3ojow90rgu5A1dBX4KmuDCQya4PCf/cKi
 iAG1F+Rb0GtbZbX5nCD1Tsd7C7KVeNOYzoKmAsIjFqr7NqOowgnEUpkIzvjlsFsq+nsJ
 HrSeNKTcEoj5oRdYYjRCwIniicXKqS0RQHYa30n/MfZDD79aBVkoBRmahlduFaLQ1/fM
 Zpl+j2/uhlttjfOKzwKg0s9yHRFET0ZXrQbnITuDXTWv16tbYM/DLIYuXQPpo4rK4R2d
 DThdKAIcvec6B4/0MQ0wTYkx/XM9k7jrArAnkrHQ6iyPtay6z2ZKUepsdjyHabg3Cn8p
 QgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701194545; x=1701799345;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2lEzZanP7/CaHmG+Avp5B41ij/SnJl+RpexIA/tsw5E=;
 b=Ta7ei08nIV+DnOv9JMT+Z4V+zhT22j9ckDlwPpP77mM4+xmR6huOEW+Ta+r3m3T35N
 55AxcZALT5BiQJX41iwT70GpG8nMZRRZyBFKpyryaybK0joJ2LZVTuclRQTwwYuuwQ0M
 a9bBb77BF8iBdRQtjg0ox+yBjayGC/X7XEmvoxDvVWxsHOmFKZMoK0nNwfig0nqEDqk0
 UpLn7PcxhYObeoeMlNn5Plwi4zkiYOJqPCwPalLjPVEuVyR1LD3T6H5PlRGDy/OlMbXb
 mlKMS+WSG29P3HRk0SbNdCczZCAPRZbkSCuEiTpg6wocQvfQeR4UPtstnJu5ZsL2JGpd
 aHrg==
X-Gm-Message-State: AOJu0YzOmkmYqu2IhEXbneq1AsnRVJ+h+uwUkU4TJzSWtG8/g6ZQoQX6
 ePD5SQ6r3Xut1QPorhCGw3P3pg==
X-Google-Smtp-Source: AGHT+IEaTIYC58ZdB9WrVr1OaKU7isbFghMpm2h7dP7y5wMC6+xBKWcnfOaos2LBkB8EX0Hfh5q0DA==
X-Received: by 2002:a05:6512:3709:b0:50b:ad18:369b with SMTP id
 z9-20020a056512370900b0050bad18369bmr5525910lfr.29.1701194545032; 
 Tue, 28 Nov 2023 10:02:25 -0800 (PST)
Received: from [192.168.174.227] ([91.223.100.55])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a056512350500b0050ba4a21fdfsm1543929lfs.39.2023.11.28.10.02.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 10:02:24 -0800 (PST)
Message-ID: <4a6ed3cf-e714-44c2-b438-44e59b469e7a@linaro.org>
Date: Tue, 28 Nov 2023 12:02:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-8.2] target/arm: Disable SME if SVE is disabled
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20231127173318.674758-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231127173318.674758-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 11/27/23 11:33, Peter Maydell wrote:
> There is no architectural requirement that SME implies SVE, but
> our implementation currently assumes it. (FEAT_SME_FA64 does
> imply SVE.) So if you try to run a CPU with eg "-cpu max,sve=off"
> you quickly run into an assert when the guest tries to write to
> SMCR_EL1:
> 
> #6  0x00007ffff4b38e96 in __GI___assert_fail
>      (assertion=0x5555566e69cb "sm", file=0x5555566e5b24 "../../target/arm/helper.c", line=6865, function=0x5555566e82f0 <__PRETTY_FUNCTION__.31> "sve_vqm1_for_el_sm") at ./assert/assert.c:101
> #7  0x0000555555ee33aa in sve_vqm1_for_el_sm (env=0x555557d291f0, el=2, sm=false) at ../../target/arm/helper.c:6865
> #8  0x0000555555ee3407 in sve_vqm1_for_el (env=0x555557d291f0, el=2) at ../../target/arm/helper.c:6871
> #9  0x0000555555ee3724 in smcr_write (env=0x555557d291f0, ri=0x555557da23b0, value=2147483663) at ../../target/arm/helper.c:6995
> #10 0x0000555555fd1dba in helper_set_cp_reg64 (env=0x555557d291f0, rip=0x555557da23b0, value=2147483663) at ../../target/arm/tcg/op_helper.c:839
> #11 0x00007fff60056781 in code_gen_buffer ()
> 
> Avoid this unsupported and slightly odd combination by
> disabling SME when SVE is not present.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2005
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> '-cpu sve=off,sme=on,sme_fa64=off' crashes in the same way, so just
> turning off FA64 isn't sufficient.  Maybe we should support
> SME-no-SVE, but for 8.2 at least turning off SME is better than
> letting users hit an assertion.

My first reaction was simply to change smcr_write, so that it does not compute SVL unless 
SM (as otherwise the write does not (immediately) change vector length).

However, as I searched for other uses of sve_vqm1_for_el, I immediately ran into other 
places in which are gated solely by isar_feature_aa64_sve.  So I think this simple patch 
is best for 8.2.

I also slightly wonder if SME && !SVE is a useful combination.  AFAIK, while v9 does not 
*require* SVE, SVE2 is intended as a replacement for AdvSIMD, and I believe that so far 
all v9 cpus have at least 128-bit SVE.

In any case, I'll work on any improvements in this area for next cycle.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

