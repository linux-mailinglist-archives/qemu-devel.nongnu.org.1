Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2197EBAD1
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 02:09:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r34PK-0005M1-Rp; Tue, 14 Nov 2023 20:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34P4-0005Jj-Or
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:09:14 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34P2-0007Ae-Ps
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:09:14 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-565334377d0so4929051a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 17:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700010551; x=1700615351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rovjMZvXHVHxNt4oLB7AcLK534WFmOVJ2uHPzUQdUqk=;
 b=Et2AQqxHP/awdgZ9B43295kx1hh4CSAqSEuVu9QiBpKbi0NsyV7F0rz7ZvIuB9lxpO
 jljjRkrdJExIS14n13sEJjrcFAYe+OW4ntCSsRit3aIbtC5bMy02AnpwP1iNkQoJ/KIw
 /qUucb2RE18Nyd2ZHbtPKjZSfVBxfyZ1frDnd+l8ZqVJZZ3lzmfxdhCpMboxv7PKQZnm
 dKwWDW3Up3ZvpZYXIlOTkyf3c2T6/L7K1ReIwG4OjikEatO3Gz0QHwKBv8AITJNDDZuX
 Smnm4pHy4ANguQyM9xIOfOLXGzvVHHVcm45fhhynOFh2tsLB9YjLWraQpwfKoLt4UpgS
 ArPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700010551; x=1700615351;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rovjMZvXHVHxNt4oLB7AcLK534WFmOVJ2uHPzUQdUqk=;
 b=hFsBN02ac42ra554TuRpTPyGsDJiTdy9gqIU8xs3KZB2RYftMVYHV+WrYRRIlUgIZE
 N33YrJ1SwEdXZHRyZe7/UN0GI3zp0vsJ9tU0VGslj0mmoGjucvihVK/g9ZJM1qjb3D9y
 69Qx8I8wirVaAc/s9tU0TI4nTcdcQILdZEIuz59yRqNZn34IioaTaFRuCWLQ21znigTU
 1RGVpTqRm4p4ORx+4rqBojmxEwrKwwciJvOZlM/N+YFFuR2I+gSwT/+CccJbLMj+S1IZ
 6jNuNMniFBiowVyQRxZOZKb7nrZ25u5LVqmE/oFmrtuF0YJI5+ykyV2Xg/Ock7NmOOuD
 KFeg==
X-Gm-Message-State: AOJu0YyG/gSHZw7E+kA/Ocjz3n6O/iwW1Ob7UWq11OPmQkL44Hucdk+6
 W06iaonFMBxADzWdIGGXEX50DQ==
X-Google-Smtp-Source: AGHT+IEgvlNEIKC5oPmQtENMKZxpULMUu/BMlA/lQAeJG0RzynI2u5cCJPaqIs789uxvKHwt8P5/TQ==
X-Received: by 2002:a17:90b:4ac4:b0:280:729d:98ec with SMTP id
 mh4-20020a17090b4ac400b00280729d98ecmr13034223pjb.47.1700010551300; 
 Tue, 14 Nov 2023 17:09:11 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 26-20020a17090a001a00b0028105e3c7d8sm8707354pja.0.2023.11.14.17.09.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 17:09:10 -0800 (PST)
Message-ID: <a9ba4c0a-45f2-4600-9d4e-9ba7c4a902ad@linaro.org>
Date: Tue, 14 Nov 2023 17:09:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/31] target/tricore: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-21-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-21-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 11/14/23 15:56, Gavin Shan wrote:
> No changes in the output from the following command.
> 
> [gshan@gshan q]$ ./build/qemu-system-tricore -cpu ?
> Available CPUs:
>    tc1796
>    tc1797
>    tc27x
>    tc37x
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/tricore/cpu.h    |  4 ----
>   target/tricore/helper.c | 22 ----------------------
>   2 files changed, 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

