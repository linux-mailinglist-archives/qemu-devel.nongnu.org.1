Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A888A7A1ED3
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 14:36:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh83U-0008L0-0Z; Fri, 15 Sep 2023 08:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qh83G-0008Fp-VT
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:36:03 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qh83F-0004kM-3i
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:36:02 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68fbbb953cfso1776291b3a.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 05:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694781357; x=1695386157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fgpJ3w/ADiltkZwioyu3ddM/yE9G5to5W7znvEJYyzg=;
 b=IVRWpk17/j+TNccIwwvmgC3MmryRXs+VGV3pKxvS2ewS5iSNraq/jpU9WxiPAbLMYn
 Ptk/j5JKN1DP9NW+pgua+vJ5Bb+pEYj+BvR20pc8V8rqumFSTD/mMtJaBgP/zpEs1Jz7
 8d4nusoU/rAdpLUAt8VbhE/TdXQmLe1i6c0N0LovhlVFXOoq4gViLg+ZCvZyhqxBpk2c
 w2yOcSm101Tajh00ltyl3FSHIifTPVfJl91TC67orI0s8KQqVTleo1i549TmpCyp3Ykp
 xkDFOKb5r15wUBqUrjRvlPiTXqnv0HVTyj4boTpncTYXEVnHf8p825O2WgvOR1CR4qQu
 qmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694781357; x=1695386157;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fgpJ3w/ADiltkZwioyu3ddM/yE9G5to5W7znvEJYyzg=;
 b=EobUKUNal+p+V7N382BIKlKUG114egckdJCHXy2hT+f7l7S5bRS8gVDhObDwpWzaco
 oPIabzDDkwtzxBGlKpMR/iZ4BPozPyagUZBCFujEN3zzOvyRILFL8QELEaoxgb53ybVg
 q1/OiReToYesy6Unykt+fEcVIs8T9rJI/65kYFs9z3yL4O7edbie2B3Jzeg468T3ZN6+
 R1/zqemuiLtINlFh6U59Yt3oCzEqbTpEbZkvwrG9JhaQ9mSncQdCGAuGkcIsZx+P9sKH
 rW6cg7cw4tVapYzIJsuTgkON2zwfd7ycyfolYbrUuH8ksedZZFxafjELx/Q53oNBR2W2
 81fQ==
X-Gm-Message-State: AOJu0YyAFKWbuTpRl9PKdM77agFzNsUcDpcN7Wb/xfwnBmnL8DCEBHih
 vWsYlnVflJzuKa4Gg+v6n7B7Xw==
X-Google-Smtp-Source: AGHT+IGUHUpN6elL3anwlk45zXCAhI6mcE8WUdIf7LPlbK5BnPB08Ot/VMmc/GnA68LIkBazBDPGBQ==
X-Received: by 2002:a05:6a00:1a93:b0:68f:cc47:fcd7 with SMTP id
 e19-20020a056a001a9300b0068fcc47fcd7mr1420284pfv.28.1694781357209; 
 Fri, 15 Sep 2023 05:35:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 j20-20020a62b614000000b0068bc6a75848sm2902303pff.156.2023.09.15.05.35.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 05:35:56 -0700 (PDT)
Message-ID: <e084a979-1c0f-e72b-1123-c6dae6268962@linaro.org>
Date: Fri, 15 Sep 2023 05:35:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] fpu: Add conversions between bfloat16 and [u]int8
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: aurelien@aurel32.net, peter.maydell@linaro.org, alex.bennee@linaro.org,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
References: <20230531065458.2082-1-zhiwei_liu@linux.alibaba.com>
 <9aa175fb-24f2-3cd8-7ab4-13a6dc640993@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9aa175fb-24f2-3cd8-7ab4-13a6dc640993@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 9/13/23 02:54, LIU Zhiwei wrote:
> Hi Richard,
> 
> Can you pick it to your tree?

Sure. Queued to tcg-next.


r~

