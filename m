Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C044E7FD94F
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 15:26:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8LVY-0005W6-5z; Wed, 29 Nov 2023 09:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8LVU-0005Vi-6F
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 09:25:40 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8LVS-00017w-0M
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 09:25:39 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b8412723c4so4321012b6e.0
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 06:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701267936; x=1701872736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NwyCBSEfzposhStJw2wOwucJBi5tSSTMjUc4y44UWrM=;
 b=UWR6Z6nNEmY025PWyn5wCbTpZrzGXzhMRFdfQIpBi3sIONgOTIa98T9fdWwW4NrgXC
 +ukpnESVjzY0F++IxUGUoperPrWjppWwjLZv9oNBJ/Bw2CtBOepo4xGjbfsy+hymUYCg
 ARqV77yKZ5Pr+Ityfq7t73mS6nvKAg+xnaHa4Z8QEAjVwWOSPPs80XabR/GF1zOVeLme
 1rw6+t3mDFFI96pnny8kDTh7mBRP0Yb4e/KN3ck4pqtbzpSYqfWg5+huZVHswQ2gtxhz
 AqZJyNuTJHrfv7DIvV7fXdqtfIc3PcL0CD6cwtrqgoWSBQ5FnHqHabqW4HkC2SS2qmhS
 NL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701267936; x=1701872736;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NwyCBSEfzposhStJw2wOwucJBi5tSSTMjUc4y44UWrM=;
 b=ooqZ+7H2nDbUhQcIAu5HNVVgj5QvCtj7LYW4Vqt+eMvrS/sannCLTpRgPVu3aVL85B
 kGG6EZSjfXc0TTs1bJGoJgm9quDaRxMkBIwYYQnYjVDMsN8iZGXzEZYCiluSCtu72fD/
 PgAT7fIrJanrYFEGXn5vG47C33J21SMgYp0Q1PZmxgbTYZ4G+LWliomeSs3HYcx/zDp4
 OScI0aecvLEUeE8+Q5u29uhnY0gFCld0DoDMVvNK4ajU2IB/wMvtLAvSDrA0rCrD7ak1
 aP2gz1jJiBsMOUfoDAEGR9HlgyQc47O3A3K85/TYjGppm2Q5PAMZBvGalatbBwTQHp4j
 lnrQ==
X-Gm-Message-State: AOJu0Yz8HzxfosAY39AKjOQiStdVt6cPQe8qR/G76vSFIH1VnXVSxPpO
 VJ91uUtSNSYwbM+Mkf3bBmFBug==
X-Google-Smtp-Source: AGHT+IFgWG7JCecYkGNwcG+t4JpMiY7miQybUGvpgaiewvTQJXkjKLqUFQD4vkWwi1eviDNamrCX8g==
X-Received: by 2002:a05:6808:1250:b0:3ae:1b21:fab1 with SMTP id
 o16-20020a056808125000b003ae1b21fab1mr17323237oiv.31.1701267936243; 
 Wed, 29 Nov 2023 06:25:36 -0800 (PST)
Received: from [192.168.174.227] (rrcs-71-42-197-3.sw.biz.rr.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 bj29-20020a056808199d00b003b2f2724c48sm2234178oib.11.2023.11.29.06.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 06:25:35 -0800 (PST)
Message-ID: <3227bed2-ff34-4f88-9f04-e62db65487af@linaro.org>
Date: Wed, 29 Nov 2023 08:25:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] accel/tcg: cpu_exec_longjmp_cleanup: assertion failed: (cpu
 == current_cpu)
To: Petr Cvek <petrcvekcz@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <79bd7607-7590-4809-9412-7cf7276567d6@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <79bd7607-7590-4809-9412-7cf7276567d6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/25/23 07:08, Petr Cvek wrote:
> ERROR:../accel/tcg/cpu-exec.c:546:cpu_exec_longjmp_cleanup: assertion failed: (cpu == current_cpu)
> Bail out! ERROR:../accel/tcg/cpu-exec.c:546:cpu_exec_longjmp_cleanup: assertion failed: (cpu == current_cpu)
> #
> 
> The code fails either with or without -singlestep, the command line:
> 
> /usr/bin/qemu-x86_64 -L /opt/x86_64 -strace -singlestep  /opt/x86_64/alarm.bin
> 
> Source code of QEMU 8.1.1 was modified with patch "[PATCH] qemu/timer: Don't use RDTSC on i486" [1],
> with added few ioctls (not relevant) and cpu_exec_longjmp_cleanup() now prints current pointers of
> cpu and current_cpu (line "0x48874a != 0x3c69e10").


If you try this again with 8.2-rc2, you should not see an assertion failure.
You should see instead

QEMU internal SIGILL {code=ILLOPC, addr=0x12345678}

which I think more accurately summarizes the situation of attempting RDTSC on hardware 
that does not support it.



r~

