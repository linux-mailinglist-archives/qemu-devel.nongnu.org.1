Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E8C7F65A3
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 18:41:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Dgg-00025m-EE; Thu, 23 Nov 2023 12:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6Dgd-000255-45
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:40:23 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6DgY-0004oD-3E
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:40:22 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-332e42469f0so466060f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 09:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700761214; x=1701366014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zoQw7LR6l5Q+I59aE8lGQNHXwu5AaRNtWtfQmuWK56o=;
 b=TOdIsqWJ3lYkGiF/NRJJwFTNWMdp7/mVq9phkKxOxqKR/u2vJGNQFxn7E3sFUSMkXB
 LFs6ut3cDHK+8RB5l8GB0+C/MOUtUPzx3fmELeRY5VVNUNWWLwiwhQY8rTdkeowKgPo0
 YKpKOYPz8LWWVD9wxV/ULCcSO4rjKYP/GXoqGdWwLT55UKh8UnhKMKPANuBAPdeqNnQN
 pdMYLnnqIBo+NwFCVy3mFwT0CjtEkNg1OL0mGCkb3pQBiiEdF/VjZaJLUwTs1azVqki5
 98qrPRz/RINrxhr921ZT3LevAQ5EQb6Rxb4K0wUCILsINefSoRHfb8eGRIEGgIcjFeLA
 oBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700761214; x=1701366014;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zoQw7LR6l5Q+I59aE8lGQNHXwu5AaRNtWtfQmuWK56o=;
 b=j41QUKD8gWPInxolcRl2Q/O+ZmPPjLeh76uIqyI2SUu2jYlJzmYYhzvfsOatba7Azp
 QadaKk7CWMRvFpzecgVvCJ2+9iyWiMBKqrxUW/wsF3TLA266xTGKWwBsvdIHpOOzTv/W
 tFm5IWIFz/ygHAm8SsmYe8r4N1igoRyCunu0MSq6hx4f4m53YyR6asBxz1RKA1qB3r9T
 zFCtkxlo0cdugiCcfpyAL/fPW6rCQDyQF6SyGzI+dB9g5liT+DDGXtRIw4QKKLCzi/1x
 WxiOvcMF0ny8XwYQl7SF7rxjpoRSo5p4zqXhEBhOq39hFs1RtkRkW72aPGoexmFlOTNv
 4IeA==
X-Gm-Message-State: AOJu0YxI/ANpqkb71LVDYKqmUSFN3e4y76zK9RNVGVcHga052v8eJE4Y
 xwz0p0EMHFjsdwHnIUdtf3073Q==
X-Google-Smtp-Source: AGHT+IF0E9PjAPebK4qXc14BmcPby6mahiXrlqyEDnx7DY/wfmENZya7z8zz2zX4nvm6W0COaie60w==
X-Received: by 2002:adf:ec04:0:b0:32f:7db1:22fb with SMTP id
 x4-20020adfec04000000b0032f7db122fbmr125168wrn.28.1700761214373; 
 Thu, 23 Nov 2023 09:40:14 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a5d4209000000b00332e1fe6ebfsm2232662wrq.111.2023.11.23.09.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 09:40:13 -0800 (PST)
Message-ID: <cb8808dd-00bd-4569-be15-9d8f2e20b1f1@linaro.org>
Date: Thu, 23 Nov 2023 18:40:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 00/21] target/arm: kvm cleanups
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 23/11/23 05:41, Richard Henderson wrote:
> This is primarily concerned with merging kvm64.c with kvm.c
> and then unexporting everything that is not required outside.


>   target/arm/kvm_arm.h   |  203 ------

Unrelated to this series goal, but I notice half of the API takes
CPUState, the other ARMCPU...

$ git grep -F 'CPUState *' target/arm/kvm_arm.h | wc -l
       16
$ git grep -F 'ARMCPU *' target/arm/kvm_arm.h | wc -l
       14

Since this is ARM specific, I'd expect it always take ARMCPU, and
call the generic KVM API casting with the CPU() macro.

