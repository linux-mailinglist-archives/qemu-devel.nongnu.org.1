Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9577FD8D1
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 15:00:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8L6A-00088I-0J; Wed, 29 Nov 2023 08:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <petrcvekcz@gmail.com>)
 id 1r8L60-00087x-Vn
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 08:59:24 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <petrcvekcz@gmail.com>)
 id 1r8L5z-0003gr-6t
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 08:59:20 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-54acdd65c88so7439595a12.2
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 05:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701266357; x=1701871157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0H5zly31sc+usJuaKzIOG1MRfYS5TYlRVZoJmT64rTg=;
 b=ZYba3x3e5d2Sc0rCDOGQ4I8KgK/8jmlu5wuEUUEJk5BPvmqi6CY8Xca3IYbahEsfhf
 FvRSQPNvske05CpbLAev9dabi0kpspR4Y8l2nPAr8VjogxruKtxD3KSUo0ur2XfNJIxh
 2wC9O6o/ZdGLS+I1L98lhhEUI1HAfKoYI54pEAyNDTBaYweD2qdFQ1UclBaHqhwqZH1Z
 ojU0Ahw7obzkkh0csiaKD3L+LDkD2jLkGL23Vr3dafSqRHbzppBbpfPDKXOIY34GxI+0
 hlLNG66JdjOlaRzdGESVdLk3ByMOVPmjxouvIMImPDJ3Pvt+UiVqjnUFyHSoOEeSta9V
 sZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701266357; x=1701871157;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0H5zly31sc+usJuaKzIOG1MRfYS5TYlRVZoJmT64rTg=;
 b=d9uBb251y5RpekGMfmBa3HdKUpI/xcPsfYQXlzL97ra84YSH654as86Nn2rJHbkUGb
 qI6A2gd1zCdTJSorB3mLulnsIgm9dZ7VeL/3i1EHg1ruYQTgQ+rm25Tln9zV2awGpSgJ
 etxvJHwZN4V8Tz9zdxLAAudoXHNIAWiLjs9MrPVjlWKoGWv61aWnZVHGZt6ujgrwPfoF
 I7qpIdxPI7bb9DGKw/Fcez9mldx01Fp4bKETDvaDJ6t/NYivh8qRXhuwEiAA9LAEScUP
 KiCEQOfFzMAAUWWw7CuahLyyhLVNV0jD2NwE2dVVr2FbI+TDroo9MOkopl/P479MlMCv
 5yFA==
X-Gm-Message-State: AOJu0YxUA5uIsDd0UrSJQhpYRtZRPOWQ7BW2M9DyHvEWF2guW5OZ7Mbn
 862yUsRo7+70m+lLf4ujhpo=
X-Google-Smtp-Source: AGHT+IFecEBdkuS6oPhMmh9fpp94q233TP35kn1r8j0pI9Ao84VZjtHyPwXkqPVimy6VvqKOWNaP+g==
X-Received: by 2002:a50:8a88:0:b0:547:9ebd:c0ab with SMTP id
 j8-20020a508a88000000b005479ebdc0abmr13600452edj.13.1701266357205; 
 Wed, 29 Nov 2023 05:59:17 -0800 (PST)
Received: from ?IPV6:2001:1ae9:1e8:b200:ae52:b385:81fe:eeab?
 (2001-1ae9-1e8-b200-ae52-b385-81fe-eeab.ip6.tmcz.cz.
 [2001:1ae9:1e8:b200:ae52:b385:81fe:eeab])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a50f609000000b0054bca15bf7bsm958924edn.3.2023.11.29.05.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 05:59:16 -0800 (PST)
Message-ID: <8683637f-a436-44c5-9370-978f88b072a9@gmail.com>
Date: Wed, 29 Nov 2023 14:59:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] accel/tcg: cpu_exec_longjmp_cleanup: assertion failed: (cpu
 == current_cpu)
Content-Language: en-US, cs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com
References: <79bd7607-7590-4809-9412-7cf7276567d6@gmail.com>
 <CAFEAcA-yvyB_t=JsEAp8eoX01gSKi04aNZ5Fq6F+gneRUMP6_w@mail.gmail.com>
From: Petr Cvek <petrcvekcz@gmail.com>
In-Reply-To: <CAFEAcA-yvyB_t=JsEAp8eoX01gSKi04aNZ5Fq6F+gneRUMP6_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=petrcvekcz@gmail.com; helo=mail-ed1-x52e.google.com
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

Dne 27. 11. 23 v 10:37 Peter Maydell napsal(a):
> On Sat, 25 Nov 2023 at 13:09, Petr Cvek <petrcvekcz@gmail.com> wrote:
>>
>> It seems there is a bug in SIGALRM handling when 486 system emulates x86_64 code.
> 
> 486 host is pretty well out of support currently. Can you reproduce
> this on a less ancient host CPU type ?
> 

It seems it only fails when the code is compiled for i486. QEMU built with the same compiler with -march=i586 and above runs on the same physical hardware without a problem. All -march= variants were executed on ryzen 3600.

>> ERROR:../accel/tcg/cpu-exec.c:546:cpu_exec_longjmp_cleanup: assertion failed: (cpu == current_cpu)
>> Bail out! ERROR:../accel/tcg/cpu-exec.c:546:cpu_exec_longjmp_cleanup: assertion failed: (cpu == current_cpu)
>> 0x48874a != 0x3c69e10
>> **
>> ERROR:../accel/tcg/cpu-exec.c:546:cpu_exec_longjmp_cleanup: assertion failed: (cpu == current_cpu)
>> Bail out! ERROR:../accel/tcg/cpu-exec.c:546:cpu_exec_longjmp_cleanup: assertion failed: (cpu == current_cpu)
> 
> What compiler version do you build QEMU with? That
> assert is there because we have seen some buggy compilers
> in the past which don't correctly preserve the variable
> value as the setjmp/longjmp spec requires them to.
> 

i486 and i586+ code variants were compiled with GCC 13.2.0 (more exactly, slackware64 current multilib distribution).

i486 binary which runs on the real 486 is also GCC 13.2.0 and installed as a part of the buildroot crosscompiler (about two week old git snapshot).

> thanks
> -- PMM

best regards,
Petr

