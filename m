Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA63577A788
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 17:36:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVD7j-00034c-AH; Sun, 13 Aug 2023 11:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qVD7h-00031L-Dw
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 11:35:21 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qVD7e-0008KH-Q0
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 11:35:21 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bdba48eccdso18429005ad.3
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 08:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691940917; x=1692545717;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+EiUyGiwLmUKJuDa0Ex1aH7UQsVUIor1Cx9yAxMzYKA=;
 b=gMipshXPwGjL2/9wsdvItJeOZyM7G0W5NF6XXRxqo3Tmt+Mu9UnJ3aRGTSJrt943Ab
 MSzyK4tk3S/d1n5mIaOSL8XLLNaQZ1ervdCLB9VBD+WF4KfpJrMDEi7t/JCKxnOhseAa
 skmdoA7NiZUJsIBc3YSdMiD5P9mH+feXIbhbdeWfCXS5mmxNZXrRYux1SRJh/NMVvAbz
 FMRHHIqGt/Kc9C86NJHImDzsH/a0IK161ZolgTRnXvLB7g9kEWVoezD+GGraMFpbIQqP
 L19tPROZKlUjuW2qCqRglIGuGcaxKvk5gg/y1TteDSd4unY4qh1jLq/4GGbr1jGeqL3a
 whyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691940917; x=1692545717;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+EiUyGiwLmUKJuDa0Ex1aH7UQsVUIor1Cx9yAxMzYKA=;
 b=egi46oQKj01AC3lYzOTfRQYf9LKB4tiAA38Cw6cbLrk4Jnae8ngpcILC8PRYaBsoK+
 XdhzU9AZ3ptqF4PHDROm9kqPDgPPlXU8PvJ1VP2JceBSYRPZNhLlcwZdSpqEjztYudYS
 Uw5QU/QSGcNtX9Ld84TMp7AWIL4AmLgGx2iGLJFAAAZcVH41ToFpbdI3l43qNCusfle8
 31QaG5DHZYeEzGeBizxbX30YRdc0KE7FaQCrp3lVGaYTF238NsYhpg1uXqT9WzfYXZ8b
 42FojYkhFbYijfgfQNsyDytAwOVJ6625OHtbSD/28h/SQnWbh8jD5bHR+c4Ar0ipKG+n
 N+7A==
X-Gm-Message-State: AOJu0YxtPW9EtxCNEZNMnjdnuz7mzAeKhGXUAdrPOXOoOK3HEcq32GOF
 k5uWW8NDI5K4N3KR3c3TWp7fBL1Mt487ulVRIR0=
X-Google-Smtp-Source: AGHT+IGIkBiMWq9SFI7DF9rdubH4MwE2uPDlpI/NSLiMk/hV02qVx/gc/CKsVVaqytNtlpYEFIz2pQ==
X-Received: by 2002:a17:902:6ac9:b0:1a9:b8c3:c2c2 with SMTP id
 i9-20020a1709026ac900b001a9b8c3c2c2mr6754990plt.37.1691940917183; 
 Sun, 13 Aug 2023 08:35:17 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:8022:692c:81e3:39db?
 ([2602:47:d483:7301:8022:692c:81e3:39db])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a170902c1cd00b001bde440e693sm359544plc.44.2023.08.13.08.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Aug 2023 08:35:16 -0700 (PDT)
Message-ID: <4da6ac00-d041-255b-cf58-ecb9a65ed27f@linaro.org>
Date: Sun, 13 Aug 2023 08:35:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 07/32] Add structs target_freebsd11_nstat and
 target_freebsd11_statfs to bsd-user/syscall_defs.h
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
 <20230813031013.1743-8-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230813031013.1743-8-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.359,
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

On 8/12/23 20:09, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/syscall_defs.h | 64 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 64 insertions(+)

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

