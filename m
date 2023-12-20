Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B3781A8AB
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 22:53:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG4To-0000Gg-6c; Wed, 20 Dec 2023 16:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG4Th-0000FZ-SM
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 16:51:45 -0500
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG4Tf-00038r-7Y
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 16:51:45 -0500
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7810b3c4fa9so91160685a.1
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 13:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703109102; x=1703713902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HeXFg+eDlDTjCXtSc6POnIKN2WGlnkxN8Cyt9H7iyYQ=;
 b=bocpOzunpYfMEU+XEVDJL/zs+goU8WzRW7eTA3ULcnuq/wS/+/yrD9n8ITetMoi9rH
 K2E6ybSSUVGx5KXMzkAmKB/RKkvULEHJa2ghPO/tw2gEKJJm/oD+CosshkwgNUKFpwcY
 ILIgIHnK00KIJYDxXYrHyAZUHZODpDUxJWnVfKsm4B1rsbV2FwPAf75rUhO9qbr4wxmd
 4dGkFg8FF3jMWvUpab6+HAY/oOA/SruREr2zR50qy+gZb16IQG3Ng3D8Xw5lIdH+5DyJ
 ms6yx+V0SVGZiVy9v8ZxpqxcWL11ctB01HGptPNYp95QysC8YUCL42c6voCbocpKyKeu
 Djrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703109102; x=1703713902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HeXFg+eDlDTjCXtSc6POnIKN2WGlnkxN8Cyt9H7iyYQ=;
 b=TgRCAXpnexb11VqEP9kYz1ixZM/979KEEyDF1RPhAa91idEGSVC0pN21sy40SECHsr
 Wl1yUtqRzAja4xbDWtEFEhXVJN/4ilbX2gGZ4IpWCCOAOErPEurQJEvOX+PQgfiugkP2
 9FtyiDl+lmxAvb75XEKTAqbufyhA1dTz50aJnaavFHy+h+AnWl4FVq0pnUl3WTDq9oqC
 V5xPTJwyN42/Nm6PCeo7MJH351HCwwl6rMjqOX5YYknt6Q6cluNPHtnQIj0onCPpk5vh
 cgBHxWGHGDmdNmOEqzZ41zg73fFi/gjUugtUKnTL5bp4GXF5GWKzJU3fezk7Duo8DVpZ
 mv0w==
X-Gm-Message-State: AOJu0Yyk5Tl/c7z6S0Zfh82d+AEoK6kYFTv/AO2zHpexREW4etFRRSBh
 4LcmbpwXxC8hqfZ7vkxP2rXoQxu7ff4Keg==
X-Google-Smtp-Source: AGHT+IH+TJuOybDe2ulSRGGAAAbbcdhLHPRdjcyv4lT3KCWO50QSmm5rIMwzU29kM0kwKy8ec1E71g==
X-Received: by 2002:a05:620a:2902:b0:781:1c53:3250 with SMTP id
 m2-20020a05620a290200b007811c533250mr424796qkp.58.1703109101961; 
 Wed, 20 Dec 2023 13:51:41 -0800 (PST)
Received: from [192.168.4.227] ([172.58.139.164])
 by smtp.gmail.com with ESMTPSA id
 dz7-20020ad45887000000b0067ab9aaaedcsm190263qvb.9.2023.12.20.13.51.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 13:51:41 -0800 (PST)
Message-ID: <bc0694ff-49a7-4fc0-9cd9-ac139f310bd8@linaro.org>
Date: Thu, 21 Dec 2023 08:51:26 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Fix physical address truncation when PAE is
 enabled
Content-Language: en-US
To: Michael Brown <mcb30@ipxe.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <0102018c7d0026c1-fd5f0b50-48fd-4552-be0a-cbb6070b5e14-000000@eu-west-1.amazonses.com>
 <49047cf7-de12-4761-9082-dc5638d249a2@linaro.org>
 <0102018c86e4f17c-5e356421-08c8-4d3a-a149-5897437892ac-000000@eu-west-1.amazonses.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <0102018c86e4f17c-5e356421-08c8-4d3a-a149-5897437892ac-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x731.google.com
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

On 12/20/23 22:03, Michael Brown wrote:
> For the default case, I think it would make sense to unconditionally truncate the address 
> to 32 bits if paging is disabled.  (I am not sure why the original commit 33dfdb5 included 
> a test for long mode, since I do not see how it is possible to get the CPU into long mode 
> with paging disabled.)

You are correct that paging is mandatory for LMA -- indeed, setting CR0.PG is the final 
step in 10.8.5 Initializing IA-32e Mode, which copies EFER.LME to EFER.LMA.

The commit 33dfdb5 that you reference is definitely wrong.

> I do not know what ought to be done in the MMU_NESTED_IDX case, and would appreciate your 
> input on this.

It would be ideal if MMU_NESTED_IDX were only used when virtualization is enabled and 
nested_ctl & SVM_NPT_ENABLED, i.e. when use_stage2 is true.

I can't remember why I added a check for use_stage2 for MMU_NESTED_IDX in 98281984a37.  It 
is possible that, as that patch introduced the feature, I was being cautious.  It's also 
possible that I did see something, but then it was cleaned up somewhere in the rest of 
that rather large patch series.

In any case, current intended behaviour is that MMU_NESTED_IDX with !use_stage2 equates to 
MMU_PHYS_IDX.


r~

