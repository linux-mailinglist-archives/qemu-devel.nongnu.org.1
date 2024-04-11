Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4398A0AB2
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Apr 2024 09:58:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rupIg-0007gF-BP; Thu, 11 Apr 2024 03:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rupIe-0007fx-5v
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 03:56:48 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rupIc-0001nv-I1
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 03:56:47 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e504f58230so11355965ad.2
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 00:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712822205; x=1713427005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k/+VETl9mNAi6QQPSGS6bukMLcr4tsK6d3+n8KpMA0Q=;
 b=RLgtaoYkTBkDH9X74t8i/y5pDB7Ay1OsOH1yAvdtrNUaYauaFxSKlKXZeC33zNyLSh
 z+nXCkvifFoX1Xyivw0E8kTb/08cL1lZ6MV5/Ml6HEEYc/KpzDwQRaadyfTe30j6m2qB
 Cn0Jh1hOCGy5oTaag5hs09RWNXZUi0LC3j0ykt/+iTxwkQjL5QmkAe4tKc/+3obpRuVQ
 JF9zStER6wLPVeZvVszJUEthdUjxQI6IK0ydOX/PqVpE6JB98cctd5zMjGCCOT7TvrzT
 Stdmm7wvu/7xEYgSycWWNzyuWQZs/JuHy+C6imNQLOZaOYVvc9S94S9NDvCvOz299uuX
 wZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712822205; x=1713427005;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k/+VETl9mNAi6QQPSGS6bukMLcr4tsK6d3+n8KpMA0Q=;
 b=lpLyfpF+/cR8DPoa51JqnlPe04FufEtWnYs4/yixmymQh46sv5QSCDi5n5Y4o3scxL
 7LkEqR5NHcYXOBjIAMstKdVHoSk6LonluRnLZrk1f5pv5bmYB8xMB3wmRDODVsr8J7j/
 An84tbXNJMYSwMUPr5gvipAL+ax3ZnMduBES3RIa4Ye5s2rBLs0yCoBF0SAb2BkC8eIi
 OcfPqh2NLmzqxdXVEn54kZpw8C9EPIPZn2j+42L1+Yi5iRHVK/T9e+FtRXfLAU8ifoPK
 CVF0wyRvZlHTIPZuD4zqBWl79PJjHzwVRMqUNaDrW34sOXN4Ca7kHE46Sol7DT60hz0K
 u/Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw10oTP/rxcNjHLnIUPqRCXNZ31r3oNUicGkjXHekPcA3Fg12pV+ZoHADRhqv54m7VnmIFcsC5+bTytTndrFHOLxFDMcs=
X-Gm-Message-State: AOJu0YxcgHPzKHmxPaFCqADHr8urlg+7vs9tsZmySp2oVyUv4EBAVa13
 0t2F9M1QI55T5011XrouEGUUZ9ZnWbNKemWtaHjlSeNLaXqXuGrqcXmHRRvlQjWzBfaiQqbkVWX
 C
X-Google-Smtp-Source: AGHT+IFRxirin/8Hq8zG408E6F4w17hmlzOVV3zDW2FYvmsy/F6LijIpgyeYv+icS2tOE39NIEPkhg==
X-Received: by 2002:a17:903:948:b0:1e4:a120:14f4 with SMTP id
 ma8-20020a170903094800b001e4a12014f4mr6764358plb.14.1712822204790; 
 Thu, 11 Apr 2024 00:56:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a170902d50600b001e4e8278847sm675266plg.56.2024.04.11.00.56.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 00:56:44 -0700 (PDT)
Message-ID: <b84fd5ed-9bb7-4557-8406-2723febef518@linaro.org>
Date: Thu, 11 Apr 2024 00:56:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 12/19] target/i386: merge and enlarge a few ranges
 for call to disas_insn_new
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-13-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240409164323.776660-13-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/9/24 09:43, Paolo Bonzini wrote:
> Since new opcodes are not going to be added in translate.c, round the
> case labels that call to disas_insn_new(), including whole sets of
> eight opcodes when possible.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

