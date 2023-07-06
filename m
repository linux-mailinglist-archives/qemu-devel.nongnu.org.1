Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2BD749719
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:08:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHK1J-0006ha-GW; Thu, 06 Jul 2023 04:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHK1B-0006h2-VC
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:07:15 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHK1A-0005eE-0z
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:07:13 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3142970df44so285986f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688630830; x=1691222830;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z3n3NXzsfDpAbC8sSkXt9i4KZdHisQmtG892sioNbSM=;
 b=lCneo2JmDX/hd0RFIdycqdfTcnHUjK5tvAoVo393SkSCSTSLyQ3vYyJojbvl53QKJn
 c1d7Z0R3IrzAyt3ubDqUNL446ET7qm2qWfdvvMcmUV/03a82B6v9STNK5zYLCzEnW0Rq
 azkvzmrzgjqWNjFhaxKFY3dNejoWey12hgH3lG/Fief3+6m2qx3xduNbKu4SCI7NUi4u
 oM/o0/csnnussfS3nfdK/DCdhLgxCIMeFOBU+guh+rEh7Yr9yprcP8M5y9Ji8kWpkUao
 lJPe40mt/vGLc7wGlDk72TtI6y8Z6GsMOe54AYCraq/cwiTQZL0a+SYoG0+wYnO2v8tN
 PIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688630830; x=1691222830;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z3n3NXzsfDpAbC8sSkXt9i4KZdHisQmtG892sioNbSM=;
 b=Rq1TOSfHiRlC31ybQQ6jrgGNn4NDoIbEOccxddF0STCu5J/WgDxukZ4OBHkWqnFxvL
 1FNC/oTzpJUEuxrc/ASW0hO5BIMJm8OzwKq0twpkT+fb6HszgPvcHtPeo3vsWtPNHaU7
 cVBriDklRkJplWLAjyZwLnTF0/Ch9v7hVe45mAwSlIjSuHyU4fupYK3rBfbmHm6po5/G
 1ah5qTOVdLSoS+slZtIhNDz0La+3hmATxzT2uliFXZt/CR+hyeq4+rH6dXKIvabS8S7n
 BgiCevu6j/tIC2U0hei9bYiLQNOrQq8DC0t39+J+e6TrabKMRYkOi8LrCJhSahAJZ7pc
 22gg==
X-Gm-Message-State: ABy/qLamhYa+55txzqPPkVbHYqKntprFgNV6JsmTgaD7/RFfHkzQa27H
 YF0wYs9WAAsPJ2Xw6M3gO02Pvg==
X-Google-Smtp-Source: APBJJlHQO5PpxGluw6t7SSxvE41sEE7nvuEzudlVLVsFIzjiqZIdDHlk5iqQr46o7Eo89FCukGj3bA==
X-Received: by 2002:adf:f809:0:b0:314:421f:532f with SMTP id
 s9-20020adff809000000b00314421f532fmr838981wrp.44.1688630829837; 
 Thu, 06 Jul 2023 01:07:09 -0700 (PDT)
Received: from [192.168.82.227] ([91.209.212.17])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a5d5908000000b0031437ec7ec1sm1194476wrd.2.2023.07.06.01.07.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 01:07:09 -0700 (PDT)
Message-ID: <30be90c8-ad32-10fd-d821-49a355536f88@linaro.org>
Date: Thu, 6 Jul 2023 09:07:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] linux-user/syscall: Implement execve without execveat
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, sir@cmpwn.com, philmd@linaro.org
References: <20230705121023.973284-1-pierrick.bouvier@linaro.org>
 <4e5a77e3-17bc-f4bf-b0d3-476469b768c2@linaro.org>
 <696064fd-0509-b4d9-ff93-f60385fb00d0@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <696064fd-0509-b4d9-ff93-f60385fb00d0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/6/23 08:30, Pierrick Bouvier wrote:
>> I guess we'll quickly get a build-time error if there's no host execve syscall
>> (which looks to be, eventually, compat-only).
>>
> 
> Out of curiosity, is there any plan for deprecation (or removal) of execve on a specific 
> architecture? I thought it had to stay there, just for backward compatibility.

Not on an existing architecture, but the next new one could in theory only implement 
execveat.  Compare with open, which is not implemented by aarch64 and newer, only openat.


r~

