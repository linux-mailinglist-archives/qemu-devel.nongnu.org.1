Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA51A722673
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:54:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69jB-0006rn-EY; Mon, 05 Jun 2023 08:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69j8-0006rU-6E
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:54:26 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69j6-0006lq-IC
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:54:25 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30af159b433so4813419f8f.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 05:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685969663; x=1688561663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zhow8pAlhAG2pXb2ktT9111ni8mzIQKOC0PmI+vts8I=;
 b=NqifluZOVSGyDer9nDvrwaEU4MWBltNyKyA/XIgKG2t/xrfajpq/ZW0iykaZpq86md
 tHyYySSSmhSK8Qj5xAOm9yv6uUmiJkjfhyfZtQ8QYv3eqlAhRJF/2rGpFkiqdNC2rIcO
 lKfst3l//WoFRHy+JmGO5kZB/H+46N9J7NLO6PiGLFE8Y0rX363CLhNnLng9LZSgBQ+1
 ET9PDEzxB1rIm4ReBDPMbypAt2eo/SMhoijMJeKgslW1ZLaIhKMkAR1E277xx1YBiIe7
 taL5MIVMAxO5cgKzSmnK8ZOy2yO9E6f0+hAWX4pjQylRVI1JOQ18ivabRIQtjgil7JAZ
 7OWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685969663; x=1688561663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zhow8pAlhAG2pXb2ktT9111ni8mzIQKOC0PmI+vts8I=;
 b=HLw2Mp2YF0Wu15m0OA4P6bBEUJevfS0G4ZftEZowdqqv17C/V7PWRb7AI0qkd1n9M4
 O7UrYK3nH3Tvb/5jet7ow9FKi6E2VzaY3hqqIgJxNJdie6ERcp3pJrRuWF1CLHtoi5Wr
 PrremuUnnsscxmCkFnElA3CfAHrIugei9z8xaQ+0wCjjzU3M+JNzefeuudab2LHofUDG
 FXNMe8YlouQ9E+65OmFUH7TWwYtNNhtSBdSHAEdsOeo1dV515EaUu3zGhF7Qofx4SBU8
 QM4Dcu08bKzoagcSj3kxtPnd45As7ihm8bU91ce3zhl1+oRuh5UHbpblfF9iDNrOoxbt
 KjlQ==
X-Gm-Message-State: AC+VfDwTNtAKsDyukPGQ/MK52H7M1h5MKcXRqCFH55DlmN1pZ39NG93Q
 xgGp7GTaEc6wRv4isvyG6BziMw==
X-Google-Smtp-Source: ACHHUZ4c/0M+fErKiiIiJ1FcBVQ4U0+FfsOm1YwH0SW7CYdzUnDZvvGhtp0oHucZfgR4YiAJ/qCOUg==
X-Received: by 2002:a5d:434a:0:b0:30a:e435:63a6 with SMTP id
 u10-20020a5d434a000000b0030ae43563a6mr6709090wrr.4.1685969662996; 
 Mon, 05 Jun 2023 05:54:22 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a7bc386000000b003f7310a3ffasm7261421wmj.2.2023.06.05.05.54.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 05:54:22 -0700 (PDT)
Message-ID: <bcd362c1-9fb8-13cf-61b9-a0ce37b1071b@linaro.org>
Date: Mon, 5 Jun 2023 14:54:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 06/15] linux-user: Use abi_llong not int64_t in
 syscall_defs.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
 <20230603222355.1379711-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230603222355.1379711-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 4/6/23 00:23, Richard Henderson wrote:
> Be careful not to change linux_dirent64, which is a host structure.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall_defs.h | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


