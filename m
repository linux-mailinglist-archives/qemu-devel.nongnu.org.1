Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4E4799B7B
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 23:50:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf5pL-0003qC-0C; Sat, 09 Sep 2023 17:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf5pJ-0003pp-KO
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 17:49:13 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf5pH-00082B-Gp
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 17:49:13 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c337aeefbdso29619855ad.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 14:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694296150; x=1694900950; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kzr19gGSE64Ls24LVXaGQkFEX20+HD1ZGI8NjKuYov4=;
 b=r0VlUw5grEqg8FPL6tnw60qHO6hqLu04ii1eRSigievel7vqct9MLDq/BwCJwqjIh3
 LQLgekHNGRIo9kL9kyb36L3STEszP4lHmQGif95mfjsQ61hpzLP9M7/i2pQ4DFpgkcsA
 eSIYgloZP1T9BJ/sKRLwGLwRdi8GwewsW9I9oV/DMyFN83lok67ZI1uoq+YUM3++qNmW
 81qs/YSoqw+hxnrTGLVydkHoIDxxcYSnGfSPULihB/wG7jj8fivLjNH9gmibqxW40k4g
 h9nwBYPOMR8YxcVFE+6AIFTnV3jhEEzzLijmRqOK/6rw7KxIQ+Jy4ZxFFrGYqd7awJx8
 6abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694296150; x=1694900950;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kzr19gGSE64Ls24LVXaGQkFEX20+HD1ZGI8NjKuYov4=;
 b=oZhwxayNtR+PzcWM7c9rzQLcLWcW13WBcGDVE2KwhKJcPoR45QtTfDExHNiboJzxSx
 48+3MSeWa/RrDG3x3k6pweawPtvWxTLd8aTiPHRwGOLiR3n39iEQmSWwb/xbGj/uMQ/6
 R/EmLrsCX/sEGs9evcIg2r+SXeWJXFWZPipRcE3Vv0DCp82DlQjV3ZIPlrUKO/09UJqm
 atU4uZXVlDnBIlBed1s4Y1oh9Qir2AYA6SjXEp/AKYZlGURcFo3rCzgTz/iwEup3fwnV
 TCJ4D8lYhF+WWO0cfMa+CHT2oW/ch4iKthp66CewwchTw5VsyS+7AcfDfdJYJWPyc7ld
 zSZg==
X-Gm-Message-State: AOJu0YyuCFTSRlhBbpBH8duk/aSUtavaM5u8DtWcmEwV1sfqrZhPhlsB
 wyZ+VHOStT0bPWcAcIo29NZK6Q==
X-Google-Smtp-Source: AGHT+IEBW55V1rRyg+1VuIgb/ITsLo6wrZW4ocUd/JHVFAQLHu0ynPiyxN54JGH+NIPOTE4KAoJLgA==
X-Received: by 2002:a17:902:db11:b0:1bc:61d6:5fcc with SMTP id
 m17-20020a170902db1100b001bc61d65fccmr7552158plx.51.1694296149598; 
 Sat, 09 Sep 2023 14:49:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 13-20020a170902c20d00b001b87d3e845bsm3658441pll.149.2023.09.09.14.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 14:49:09 -0700 (PDT)
Message-ID: <dab40b71-8e2e-951b-8c2c-de0e18f0e5f4@linaro.org>
Date: Sat, 9 Sep 2023 14:49:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 05/16] tcg/loongarch64: Lower add/sub_vec to vadd/vsub
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20230908022302.180442-1-c@jia.je>
 <20230908022302.180442-6-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230908022302.180442-6-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/7/23 19:21, Jiajie Chen wrote:
> Lower the following ops:
> 
> - add_vec
> - sub_vec
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   tcg/loongarch64/tcg-target-con-set.h |  1 +
>   tcg/loongarch64/tcg-target-con-str.h |  1 +
>   tcg/loongarch64/tcg-target.c.inc     | 61 ++++++++++++++++++++++++++++
>   3 files changed, 63 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

