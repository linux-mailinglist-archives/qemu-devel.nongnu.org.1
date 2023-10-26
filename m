Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F977D8676
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 18:08:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw2tx-0004CS-91; Thu, 26 Oct 2023 12:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qw2tr-00046f-UF
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 12:08:00 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qw2tp-0008Co-Km
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 12:07:59 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6b9af7d41d2so1036590b3a.0
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 09:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698336475; x=1698941275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LKqzCgq3HIrbRoQtMqqZPkekCjwgDjOYN/P5I2DVoUI=;
 b=o2yP4cJikz3ZdyXFhqHRHVCUnsoV9+4sh8ytV7ZpoxeHtI90N7NcnQ5vS9PP2/wCWi
 YBnkRrdCdgYTxIt5KZFLsANRVuYUP9PTylyiygZyVc0DtVyRLJ8Xw4G73/M0Es2Tnt0N
 k2eoB7BvzQbBSmtRJJdAWTZv1rEtctsmgokfA6KuhrlJrXQvjcIULQ7lzKW4qqrH8DYn
 k2KaV2+G/n5DJPnjqwfw8pAmBzEAeEoFlBFi8ckA67WVf/eiYTqCAoG/xbWHAJOL+yw8
 HHwmL0iJLiy6BVL4GTazYLLE4wOUWB2fMfWFPVeih6yDnbuVhNuC7jMTA7BIxNudmDFZ
 Wh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698336475; x=1698941275;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LKqzCgq3HIrbRoQtMqqZPkekCjwgDjOYN/P5I2DVoUI=;
 b=WBqje10Yh5E/Is8FyBqE9UMY7bwcfOhkThs+I961EdjyTl7KpgzjAT3xbqkoDL7MIi
 bfk6mPlaUqfITrYF/ftM5vp0D2zKcmEG+qwNnbl6y0AlrPnbdM7dKd5JrAb+hSjhjAHj
 jE1MH6pmL1zaQGR1u2YaNPDCZxvo+P3uts/gxVhAk7tHPIkZ8GlwgEPL5+bahNj7lvVk
 oTnNXi+k7xNHZTRJyWSr0IHf/8FpDl32idXotoQMDpk/KTpPxv45o0DHHq27zZQ+6GZ6
 YmdnPsxKLs3mCgNpWXnVXxjau3LlmThTnvVePDJYsR/WKlAaE49CKp91+pUXyYaWoNGc
 PVnQ==
X-Gm-Message-State: AOJu0YxghDnfiYhKnPbLBaMVyzyYVDE1j+f1zEq8LTSAZBP3gASyxZiG
 2Aoi6xT326InqbfYoOqQJPOrfQ==
X-Google-Smtp-Source: AGHT+IFow+SlLjnuQfkLUxTK22c7gSuO7YiF2BCfbq3Trm30DExdTydY/DlMKxTc/40t9D3pvtI0nA==
X-Received: by 2002:a17:90a:dc05:b0:27d:c36:e12c with SMTP id
 i5-20020a17090adc0500b0027d0c36e12cmr17115502pjv.9.1698336475352; 
 Thu, 26 Oct 2023 09:07:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a17090a7f0200b0026b3f76a063sm1822291pjl.44.2023.10.26.09.07.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 09:07:54 -0700 (PDT)
Message-ID: <911e39be-8932-4be5-bce2-c23caeb4a376@linaro.org>
Date: Thu, 26 Oct 2023 09:07:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/29] tcg/i386: Support TCG_COND_TST{EQ,NE}
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
 <20231026001542.1141412-27-richard.henderson@linaro.org>
 <1189a017-7cad-45c8-9eb6-5ed6eb8425d2@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <1189a017-7cad-45c8-9eb6-5ed6eb8425d2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 10/26/23 04:29, Paolo Bonzini wrote:
> On 10/26/23 02:14, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
> 
> Also, a TST{EQ,NE} with a one-bit immediate argument can be changed to:
> 
> - a TEST reg, reg + js/jns (or sets/setns, or cmovs/cmovns) when testing bits 7, 15 or 31
> 
> - a BT reg, imm + jc/jnc (or setc/setnc, or cmovc/cmovnc) when testing other bits in the 
> 8..63 range.
> 
> I will take a look at using this to get rid of the mask field in CCPrepare, but I would 
> not mind if someone else took a look at these code generation optimizations in tcg/i386.

I thought about that while working on this series, and is part of the reason why 
tcg_out_cmp now returns a JCC_* value rather than having the caller look it up.

I thought I'd start simpler before adding these optimizations.


r~

