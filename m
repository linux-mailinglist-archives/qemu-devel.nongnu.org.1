Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB4E7FDECA
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 18:48:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8OeU-0003cZ-Ez; Wed, 29 Nov 2023 12:47:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <petrcvekcz@gmail.com>)
 id 1r8OeK-0003bf-33
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 12:47:00 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <petrcvekcz@gmail.com>)
 id 1r8OeI-0003WY-27
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 12:46:59 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50bbef0e5d5so103404e87.1
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 09:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701280015; x=1701884815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JFDW9aLAaWA5MoBSWT1FL1VLiKJcsOsS9pgudLRw8UA=;
 b=Mt/IamE+0UxKlF3Fl/AveI+vwjTEIqsaUQvJFmbHtGgyTQ6CVUnlcrxtfezLnW24cZ
 BPeW/EEDjaR97vR9CWdeY4iMX7hla1dIdmo+QpCp5nWE+VtVjt98Q2mdGlnN/jWI7SkH
 B3jc7fCUCPnEDn2+oe5K+1X+3aVoIyZpsgbu0SbNo1DnQjBb7Aw3634fG+NEblOkpXZC
 oXJInxL9lWKr1+yS2Njbw9WG5mFm/8BnF0Pg5Cm43c8jyWspoY74L6Ox1KcMY95Dviso
 TCFmGmG30qkflNue5bmmGtWM+8p9Xro0F+w2pjHTOhdETYKFTeEsALUjXoNnFa7rnS8J
 9duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701280015; x=1701884815;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JFDW9aLAaWA5MoBSWT1FL1VLiKJcsOsS9pgudLRw8UA=;
 b=PKWkL4+eVtudMPXFC0ruQtADOYnmKvYcfDpv2Rtd+Y5GnYOM4pBGoWBfV0llbfjmo6
 vSwCKdGLHcgKjJGotOLTWiY33As9V0o8DQxDn2pVzxcvx0wv5Y0E9KqhAdMzcktLLrdZ
 hWIG2c/PfoXYlpt6qNvEWTskeEX9WbFHya9IyavGJn7F9et2jbqKke8WsT0eSmWZjpNK
 oJ+/V5K7eP9RNrs3C7bdzALg/gAPDdORPxJYN8qsuA9ygQefg+WQpg9M936vm22ZbLE8
 fMYs8F7p7ML/Z/JNg56+s/ro3xfhIVLLL3oB2IQKbcv5kLu++sAggJ7cwsf9p/qjpyyK
 GHeA==
X-Gm-Message-State: AOJu0YxKAmZt/zd7Sbg08h5rJBpfOifI6QThYu6BqkgLRvAt/sqDVS8s
 j3Bfe9zwhhfRJHhGR+B1qN0=
X-Google-Smtp-Source: AGHT+IHD/a1/qeB7XbHarTpJJJLPLxFSb+peW4AZUG1vNiY6nlM4NB7EzieQjDY8ze6tfiFvWaN+1w==
X-Received: by 2002:a19:6508:0:b0:50b:bd9c:8b0 with SMTP id
 z8-20020a196508000000b0050bbd9c08b0mr3522534lfb.19.1701280015329; 
 Wed, 29 Nov 2023 09:46:55 -0800 (PST)
Received: from ?IPV6:2001:1ae9:1e8:b200:ae52:b385:81fe:eeab?
 (2001-1ae9-1e8-b200-ae52-b385-81fe-eeab.ip6.tmcz.cz.
 [2001:1ae9:1e8:b200:ae52:b385:81fe:eeab])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a05640217d300b0054bce7dab31sm1022272edy.79.2023.11.29.09.46.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 09:46:54 -0800 (PST)
Message-ID: <87422d23-4d00-427b-be5e-edb9a530271f@gmail.com>
Date: Wed, 29 Nov 2023 18:46:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] accel/tcg: cpu_exec_longjmp_cleanup: assertion failed: (cpu
 == current_cpu)
Content-Language: en-US, cs
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <79bd7607-7590-4809-9412-7cf7276567d6@gmail.com>
 <3227bed2-ff34-4f88-9f04-e62db65487af@linaro.org>
From: Petr Cvek <petrcvekcz@gmail.com>
In-Reply-To: <3227bed2-ff34-4f88-9f04-e62db65487af@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=petrcvekcz@gmail.com; helo=mail-lf1-x132.google.com
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

Dne 29. 11. 23 v 15:25 Richard Henderson napsal(a):
> On 11/25/23 07:08, Petr Cvek wrote:
>> ERROR:../accel/tcg/cpu-exec.c:546:cpu_exec_longjmp_cleanup: assertion failed: (cpu == current_cpu)
>> Bail out! ERROR:../accel/tcg/cpu-exec.c:546:cpu_exec_longjmp_cleanup: assertion failed: (cpu == current_cpu)
>> #
>>
>> The code fails either with or without -singlestep, the command line:
>>
>> /usr/bin/qemu-x86_64 -L /opt/x86_64 -strace -singlestep  /opt/x86_64/alarm.bin
>>
>> Source code of QEMU 8.1.1 was modified with patch "[PATCH] qemu/timer: Don't use RDTSC on i486" [1],
>> with added few ioctls (not relevant) and cpu_exec_longjmp_cleanup() now prints current pointers of
>> cpu and current_cpu (line "0x48874a != 0x3c69e10").
> 
> 
> If you try this again with 8.2-rc2, you should not see an assertion failure.
> You should see instead
> 
> QEMU internal SIGILL {code=ILLOPC, addr=0x12345678}
> 
> which I think more accurately summarizes the situation of attempting RDTSC on hardware that does not support it.
> 
> 

Compilation of vanilla qemu v8.2.0-rc2 with -march=i486 by GCC 13.2.0 and running the resulting binary on ryzen still leads to:

**
ERROR:../accel/tcg/cpu-exec.c:533:cpu_exec_longjmp_cleanup: assertion failed: (cpu == current_cpu)
Bail out! ERROR:../accel/tcg/cpu-exec.c:533:cpu_exec_longjmp_cleanup: assertion failed: (cpu == current_cpu)
Aborted

> 
> r~

Petr

