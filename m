Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 571BB7E92BC
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 21:38:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2HDJ-00027v-HV; Sun, 12 Nov 2023 15:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2HDH-00027R-P6
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 15:37:47 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2HDF-0003yP-Rl
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 15:37:47 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc5fa0e4d5so33827855ad.0
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 12:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699821462; x=1700426262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KJwigCwQnODeM/MJYbpu7CUZcAfEsZ1lZIpmbiVRMAo=;
 b=zHiX1NiMELreGr1eksfwzkUwUrS0OtNRcu7xjTpgiCPwf3Q+VBSMOCa3WkdY7nRyfF
 sDi+Nje6Yi372pXJX132j7eQ2UQkERNVlKiIAFjjQm7gcwLVyhTiLsVQceZ4LvpqY/Yw
 8k4ChlowSK0XEAHITfgePRzgya0ZEiwtufsMoOSvA9DK0t3JjPOqyYBn5JyCnhkOJ28e
 oHOB8gz2kYL56CzVXiLgXC5taklqnAAmZ/eqvEV3Vnn6ORw+dwj7EvDDJJr7FVsGyHtz
 Th+j5h0x8II01umMM4SfM9+wbG4GSOCs8BduaZJIo7CX88AhGXvq0M4rJVqbjCDzO8pW
 xCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699821462; x=1700426262;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KJwigCwQnODeM/MJYbpu7CUZcAfEsZ1lZIpmbiVRMAo=;
 b=rx2Yk7JgLBbw7PNE/soP6X/ZK/tDK7CLozatS9DGbYS4Ad6LpZSkykyE7sjBIno/AR
 rCQUp7v3gzGXw0rgW2fB28/jY9GOeb7RM1EjJ6nkCUIj2uHIJYxhJnPHayAn6PoeuBbK
 gdx0Y+FeySFjMUs7W0gbqGOkEcykwScQbVZw2nrdOzlD0dEWU6hl7izjcu7+mGguxWoo
 ljrnibmTliRIbYDk+mMlFJXM/K1B9KJOTtHWBVer7Srg9V76RIuZP/SXXGAozXOvLGL3
 ekqtV7SxHjwslo35Cn4O7UtTxprTsLx/UDPVAyWkuVc7bX+fAwz43WlUSQpE7B5L83ss
 DjYQ==
X-Gm-Message-State: AOJu0YxyBzIDHsXJSzeDDsCQUtHXESxxbJjDXZQksDKwkrWczgW5BkED
 39uLDMnImCZty0QIcf2WXKJ4Pw==
X-Google-Smtp-Source: AGHT+IGR7mdAKLhpBhegrzp/AXIPJIVr/XVsG881ZTvct0ziv6iNq+9GmcERAQNg3CrjEdfnRIeiDg==
X-Received: by 2002:a17:902:e849:b0:1cc:53db:f53a with SMTP id
 t9-20020a170902e84900b001cc53dbf53amr6891692plg.8.1699821462480; 
 Sun, 12 Nov 2023 12:37:42 -0800 (PST)
Received: from ?IPV6:2601:1c0:5e02:2a20:527b:de4f:d565:aeba?
 ([2601:1c0:5e02:2a20:527b:de4f:d565:aeba])
 by smtp.gmail.com with ESMTPSA id
 e12-20020a170902d38c00b001a80ad9c599sm2884852pld.294.2023.11.12.12.37.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Nov 2023 12:37:42 -0800 (PST)
Message-ID: <747930b5-f3d4-45d9-9e66-071ad2847996@linaro.org>
Date: Sun, 12 Nov 2023 12:37:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: xtensa: fix signal delivery in FDPIC
Content-Language: en-US
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 qemu-stable@nongnu.org
References: <20231111112252.1387418-1-jcmvbkbc@gmail.com>
 <69b0cb84-329e-4636-b7a0-24ba69fa41b7@linaro.org>
 <CAMo8BfLfqUPrpTrBGnv3rEcyyKByqA-NCP2yP0PtUr9bhH98ZQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAMo8BfLfqUPrpTrBGnv3rEcyyKByqA-NCP2yP0PtUr9bhH98ZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 11/12/23 09:02, Max Filippov wrote:
> On Sun, Nov 12, 2023 at 8:51 AM Richard Henderson
>> However, it does not handle the GOT register for the restorer, like we do on ARM.  That
>> said, I can't find any libc sources for xtensa, or at least that aren't out of date by a
> 
> It's WIP, available at https://github.com/jcmvbkbc/uclibc-ng-xtensa
> branch xtensa-1.0.44-fdpic
> 
>> decade, so I can't tell if libc *knows* the got register won't be loaded, and it doesn't
>> matter because it only uses the sigreturn syscall.
> 
> That's the case. AFAU the restorer field is not for public use and the function
> used as a restorer by the uclibc does not care about the GOT pointer.

Right-o, thanks for the pointer.


r~


