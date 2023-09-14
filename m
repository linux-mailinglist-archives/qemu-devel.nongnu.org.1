Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 457227A0D8D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:53:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgrSk-0004VM-6Z; Thu, 14 Sep 2023 14:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgrSe-0004Uv-6j
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:53:09 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgrSb-0005mb-CZ
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:53:07 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c336f3f449so10999915ad.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 11:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694717582; x=1695322382; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wy7itTZlkPKa8bpVg5vwOWaOikACXIWpVgb/kYRt73s=;
 b=fOOY5c7ehWF+Akk4C4GCxe+yUz6hX0hw+Ugywi6plmcw9Toy6vTKTVtSytkqwuu/bc
 AsjFCHhqnYjrXkHC5MxT5PPoByvKm9se0VBhodCExyJ4IDTfbd6Cw6aO9jzHKyCkCd2m
 WC4Dp411XKBdUe/mYyK8XWfYUrWGRZ300SWGWYovl7lgIcBItUjZs1eOSaWarPfFuMPa
 32/AjzFnvaBPlX7buueLZmMHd0oSdLMgh5nffRD3E+8RucXb+xrRR+fYWNG1dlnHCmax
 3PIHYtxZJrRthrjqqPh08kZsUCxJvFcfllABWb5OndNh5MU9WvY9hjBp57jx1dLtDv5z
 biAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694717582; x=1695322382;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wy7itTZlkPKa8bpVg5vwOWaOikACXIWpVgb/kYRt73s=;
 b=cg9jK07V+S8JjkPE8XqmYto/f1Wd5419oRs8qYlVavqqs67j41UIg6nQl+qMrtxDae
 ZvvCI9lXX3AGDC1smCmD22N4mQM7CrROQr5K4oiJ6R14HgQ0jbUpnMvT14VahQBP87D0
 /Lq3qx9NVmJDqRvsTLMfszqunFqH0C0immmMzVt3udns6cYPR91wOXTU4a0TfSTmLjxy
 wOWXg58yG+PNGVR6TUGY0/beY8ti4e02qI1p6KVNHoX3u/31+r/EdUxD1KBNfpyCgb+L
 r31q1ZVV0fV2x/xoQwHQNABubLhAILf7d0awCGvi8ZAzDQEC2J+gKoOgj3O16T8IhZKr
 gCuw==
X-Gm-Message-State: AOJu0YxS6BnfIvJa3BeY015OVEywD3HmklEMSqDDVEgnDd9gGwYPT98N
 yG4yorJrGv9RaL0EHk1QTiGm0Q==
X-Google-Smtp-Source: AGHT+IHqgY2o5fOYsRMuCpNBiPlAhIr+gWW2KcnK+setYl1dn5LSjpK85YPpEG1KFjd01zOlJ/xssg==
X-Received: by 2002:a17:902:8693:b0:1c0:cbaf:6930 with SMTP id
 g19-20020a170902869300b001c0cbaf6930mr5964938plo.54.1694717582320; 
 Thu, 14 Sep 2023 11:53:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a170902ea0b00b001bdd68b3f52sm1917111plg.302.2023.09.14.11.53.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 11:53:01 -0700 (PDT)
Message-ID: <1242f2f8-6881-5caf-7cae-593e6e6f7ebb@linaro.org>
Date: Thu, 14 Sep 2023 11:53:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 13/24] accel/tcg: Replace CPUState.env_ptr with
 cpu_env()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: anjo@rev.ng, ale@rev.ng
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-14-richard.henderson@linaro.org>
 <c606e0d9-c164-11da-8ae1-9a602459961c@linaro.org>
 <a4ab6acb-3db0-23db-b728-b779698f1ab0@linaro.org>
 <a4a69a18-01cc-7817-c842-f4a7bc4a9502@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a4a69a18-01cc-7817-c842-f4a7bc4a9502@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 9/14/23 11:38, Philippe Mathieu-Daudé wrote:
>> I presume this is --disable-tcg, since I saw the same thing in CI testing.
> 
> Yes (I didn't even noticed, I was testing my kvm_only setup).
> 
>> No, we don't remove the check (that would explicit assumptions elsewhere), we adjust the 
>> alignment of CPUNegativeOffsetState.
> 
> I'm not sure I understand, should we guard with #ifdef CONFIG_TCG?

No.  I'll fix in v3.


r~

