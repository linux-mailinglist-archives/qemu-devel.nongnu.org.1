Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 737C67E2BA6
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:08:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0416-0005Rj-Mh; Mon, 06 Nov 2023 13:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0415-0005PZ-1X
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:08:03 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0413-0002Av-IK
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:08:02 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2802b744e52so4615643a91.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699294079; x=1699898879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1gPU0A29XAiPXrTlUwbf/xXW7MpVVfJdj3etL05916A=;
 b=uDekKp+FqQH7Ff14QHRwd5FWTGDWwOFs4xZ5AQhb/wbL0drw8HVOMjktquw+5qPpIs
 Bsa+U+EcZCe6RNcnwqLJTQGKTyWM1WTct1WlMBMCtjbtymB1v/E8FeFu8xRUfqaW8lHX
 +8OMGIuXLmsNjGOk6dxL4vsMUtdq/+OASIzOZBfPZKmBkq6eOc4BLe9GK5sdeaF17Q8Z
 6s3lSsUxyGFSLZYGxwj7U+fWfw3zh6wb97PR8UC1CGxizKhNXTVPfu4O8R0gxJYmlVdD
 0eQde5TR7XItOsapBPdO461Aurb5dgphVzs0tTurO+mZbhX3nhn1kXCrnWbx2IhetNgS
 S3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699294079; x=1699898879;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1gPU0A29XAiPXrTlUwbf/xXW7MpVVfJdj3etL05916A=;
 b=nRVXfqmfypUPIzZAXhMIiS36UoZIU3eAqI9HW4P/J5T+eUGxvGzI48XLgfN246zcHK
 bvEUlNwhxmIo7DuqlmgnclqonOyPNRO37ETxAAcu55hLoBsw3dV/uHyDbetaw5ynkgex
 mDR6vMId0yCeM1oAYZIwjB2iDJbRLG/7xnWQ+Gi1rIFpetgfKOSdxxU5y4IZJ7D0Edoz
 ocYEV2nYWn8hdppauecVY6RYCaeHqOZDf3B845MvI1XohV4W5eDKNdK1m8kQ+RJRP8wI
 IJ4WYqIqqE3nHMuKAGqf/LyKIOx/eRozovqDw6JAAOW7Cq/uW93LOyq0qyXqo4bbMJlI
 k9dQ==
X-Gm-Message-State: AOJu0YyoRrs6MqSKEIih9amJukkXRhw5xfftybnPdqlOIfuYWDRvT3uA
 mbNBGjTBqMgzovA3y7aT5MoaO0UH9spux+nP5+A=
X-Google-Smtp-Source: AGHT+IGK/Se8apT9TphEs6MQYStFMw2mjRalRhSm2VSXJY4vncEo6kGs0sgieEI7wGkZIpxqVNmVtQ==
X-Received: by 2002:a17:90b:3ec4:b0:280:963d:9c5 with SMTP id
 rm4-20020a17090b3ec400b00280963d09c5mr331622pjb.21.1699294078904; 
 Mon, 06 Nov 2023 10:07:58 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ge13-20020a17090b0e0d00b0026801e06ac1sm5753693pjb.30.2023.11.06.10.07.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 10:07:58 -0800 (PST)
Message-ID: <10bcb5fa-8fed-47d8-8e5a-05849efd367c@linaro.org>
Date: Mon, 6 Nov 2023 10:07:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/35] tcg/sparc64: Implement tcg_out_extrl_i64_i32
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-stable@nongnu.org
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-20-richard.henderson@linaro.org>
 <eb6b92d4-4ae8-4e38-2369-4e9420f4d138@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <eb6b92d4-4ae8-4e38-2369-4e9420f4d138@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 11/6/23 07:05, Philippe Mathieu-Daudé wrote:
> On 28/10/23 21:45, Richard Henderson wrote:
>> Build fix for missing symbol.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: b8b94ac6753 ("tcg: Split out tcg_out_extrl_i64_i32")
> 
> Commit b8b94ac6753 looks correct, don't we want:
> Fixes: dad2f2f5af ("tcg/sparc64: Disable TCG_TARGET_HAS_extr_i64_i32")
> ?

You're right -- I thought the TCG_TARGET_HAS_extr_i64_i32 cleanup came first, but not so.


r~

