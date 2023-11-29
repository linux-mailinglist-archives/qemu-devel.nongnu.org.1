Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C407FD8AD
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 14:52:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8KxQ-00067s-7i; Wed, 29 Nov 2023 08:50:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <petrcvekcz@gmail.com>)
 id 1r8KxM-00067E-Q7
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 08:50:24 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <petrcvekcz@gmail.com>)
 id 1r8KxL-00024U-1z
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 08:50:24 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3331752d2b9so511985f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 05:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701265821; x=1701870621; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0/XAIfTUykBIIaH3mYJP/8XDhlpzu1hM3TyD0Wtv/PE=;
 b=QiieKFOuAQ90ST2ivfXu0qQPrXWihfx54BmFMcxuwq2q0r9Yiu6a6r6DmYb5kRYcA0
 W5HNEKKmJpeFNnlxDisDMKf6ZZjQvaSGuP5+nH2xoFhZtrgTmg5LgwHOmcKEMjkNG0iU
 b0Wknro/kMRPNGZ4KY8NtHA64ACuPJhjTDzQom7jOLRbqsOC7K8w5eBLsKjV3NjVyXmf
 YCRNpleGtFwrh1ID9B78XXtAvwbTarSxRaOob74ZfxMclomtagEhRrc0nSN9J63yieAm
 TNo/bXbzDU3VdCjnaAe/55L8EWmpdke+8EBC8FLHeeiM8CD+xhqXUGhJ0zj2B8yPucoX
 qQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701265821; x=1701870621;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0/XAIfTUykBIIaH3mYJP/8XDhlpzu1hM3TyD0Wtv/PE=;
 b=Ko96RWTMgT8vPCjjOqWn2KPySNrDCHKANpJCOGhW3AcA5fLe+PX36ALy6m7jDvDOq9
 5gOeQAz+VetKDrLwgJR9S1wU4zZSXYqr1rQzBhOa3lPjRh6G5Px3Zdbd/nioU0GBDrlL
 y2TYtkuc4sfUySzzt3GKXregeqBx3bXKC2I0agw1laPvJ8DzjfUWQ+sHqhVF0jUz89gI
 TSFxLNst9I82u+v85xn3yPmWqegFOST+54KiNVv0PVtI3uNrKwd5YFFg7VGDwlLcZWFD
 HTiT23CfMRQbhUDdCi/1HXMhrlQYaKZm92QE0AXh1JuFSp+XTXI9sOK4cII7WXgCuVoW
 FKIQ==
X-Gm-Message-State: AOJu0Yz+ZhNHNRLrjaBfjbjNFTZCy5CQA4jL8bVQoRGQBlAWJVx9KPyF
 mmxeaqVqtQynz/E6MARsugk=
X-Google-Smtp-Source: AGHT+IHu9iBR+akiDYvV10qap3a2J35JUocIXyQATnEoIHi+UyA/eGbv0kBYa9pSVzdnn1E5k+LOsA==
X-Received: by 2002:a05:6000:1966:b0:333:135f:a7f0 with SMTP id
 da6-20020a056000196600b00333135fa7f0mr2746295wrb.54.1701265820539; 
 Wed, 29 Nov 2023 05:50:20 -0800 (PST)
Received: from ?IPV6:2001:1ae9:1e8:b200:ae52:b385:81fe:eeab?
 (2001-1ae9-1e8-b200-ae52-b385-81fe-eeab.ip6.tmcz.cz.
 [2001:1ae9:1e8:b200:ae52:b385:81fe:eeab])
 by smtp.gmail.com with ESMTPSA id
 v5-20020a5d6105000000b0032f7fab0712sm17903354wrt.52.2023.11.29.05.50.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 05:50:20 -0800 (PST)
Message-ID: <7ac7d010-a984-48bf-b254-02f87324be83@gmail.com>
Date: Wed, 29 Nov 2023 14:50:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu/timer: Don't use RDTSC on i486
Content-Language: en-US, cs
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "S. Tsirkin, Michael" <mst@redhat.com>
References: <6826113a-d428-401e-b5a3-56ad5d8fbaa4@gmail.com>
 <CABgObfabW_WKdfGFgao0BJ0wHYHRx6KzMsLzvqUvzu3ZMx5Bdw@mail.gmail.com>
 <5717e259-7d0f-42bf-8d5a-43120bdb0284@linaro.org>
From: Petr Cvek <petrcvekcz@gmail.com>
In-Reply-To: <5717e259-7d0f-42bf-8d5a-43120bdb0284@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=petrcvekcz@gmail.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

I can agree that binary compiled for i486 doesn't contain cmpxchg8b and works OK with exception of setjmp bug I described in another thread [1]. glxgears which doesn't use signals works without problem. 64bit atomic operations seems to be emulated in util/atomic64.c.

However I've found out the compilation for i386 seems to fail during configure due to the lack of i386 atomic instructions in my GCC 13.2.0 version. If this is normal behavior, I guess __tune_i386__ check doesn't make sense to add. 

[1] [BUG] accel/tcg: cpu_exec_longjmp_cleanup: assertion failed: (cpu == current_cpu)

Petr

Dne 28. 11. 23 v 16:52 Richard Henderson napsal(a):
> On 11/26/23 09:56, Paolo Bonzini wrote:
>>
>>
>> Il sab 25 nov 2023, 13:23 Petr Cvek <petrcvekcz@gmail.com <mailto:petrcvekcz@gmail.com>> ha scritto:
>>
>>     GCC defines __i386__ for i386 and i486, which both lack RDTSC instruction.
>>     The i386 seems to be impossible to distinguish, but i486 can be identified
>>     by checking for undefined __i486__.
>>
>>
>> As far as I know QEMU cannot be run on i486 anyway since TCG assumes the presence of CPUID. Have you actually tried?
> 
> TCG does not assume CPUID.
> 
> We might have problems without cmpxchg8b, but if so that's in accel/tcg/ not tcg/.
> 
> 
> r~

