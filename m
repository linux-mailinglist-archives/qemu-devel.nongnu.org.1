Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB2E81FB65
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 22:28:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIxuR-00026Y-I4; Thu, 28 Dec 2023 16:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIxuP-00026J-L9
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 16:27:17 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIxuI-0004tJ-SQ
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 16:27:17 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-204a16df055so2413557fac.0
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 13:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703798829; x=1704403629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ayJebykgat4V7VIf72E79ddED+CyvtmwEgEZLs1NcgM=;
 b=diZJgBisvf0IYb7uXtllQMCyath0F1f2DPP5lWiGNdixVk652kiLQ+S+nxa7bdVQAQ
 OcLGAXwLboGY+YgTvtUG0jL9ZoD8rWjy9ZlRsRVlRxf61wwg6U/S2Uyv2XuS8qFGN0k7
 Sfz9gAZFsAUcZ3MZCYzuHqE8YpJUNAtI93WaXqdbFb+xyoiDSAbcpujz3n/UbXgcOCkb
 5hju9sUKbjo2nVnPe0jmbRKN4Q1yNATjr3hDKFav6Ocp+QclE8zCUdV6GUB8LjYa3bH1
 FCVGc9oYQD5o6gaKpu+2LkNq4BzCtWvy33wqfBPjFUnLkc7zPHnVWU394iBjZS5QnRM4
 xbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703798829; x=1704403629;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ayJebykgat4V7VIf72E79ddED+CyvtmwEgEZLs1NcgM=;
 b=f8haAk5jAG7LWsTMawJplRIzfyR+q7JaWPUxSD9+j/CNiUzu75Zp9AqEYYfbDotCvG
 7BUX4ns5s/EU+2jGOOv8naP/e8XHVawnH7uMOEzuRYTmsOyCVWJPKmAF6lF1pReXwIaf
 xp1IIBMWoRz1BfIfSJ1wApqmPfdHyaobNLrQvoLbBEBdJcv1qNGceioP5jz3kAvBHb/7
 t9DiNxcL+XEwTzLOs2FhmsMq5MlGF8MTjOXj85tyL4uf6PRQslF6muEljGEEU/7qbaV/
 eY1AMHrKM78O/FtPzDtcLBLqUoxvyII2VA5HbAQ+6IMnR2OI998sbCVrtoPi0rD4llb5
 66FQ==
X-Gm-Message-State: AOJu0Yx0weT+ODozSGA+Pl+weG+Ccsf4uJ0hGsZnZqxBSz5L3s96HcV+
 63XlTCc4AaczHO3A5+RtqKECAEXkUH4DSA==
X-Google-Smtp-Source: AGHT+IHTBonXLihRndU32c3aOkUlh2+PWr/7IfK41WT6ls70asa7UrcTYkTI1kl8SiceUrDD9vSlpA==
X-Received: by 2002:a05:6870:5591:b0:203:b171:c385 with SMTP id
 qj17-20020a056870559100b00203b171c385mr11557056oac.105.1703798829184; 
 Thu, 28 Dec 2023 13:27:09 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 n37-20020a056a000d6500b006d996ce80a6sm10709356pfv.0.2023.12.28.13.27.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 13:27:08 -0800 (PST)
Message-ID: <b06f7f31-cbcb-4ba6-8ea4-ba1c48183ead@linaro.org>
Date: Fri, 29 Dec 2023 08:27:04 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] target/i386: clean up cpu_cc_compute_all
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-6-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

On 12/23/23 05:15, Paolo Bonzini wrote:
> cpu_cc_compute_all() has an argument that is always equal to CC_OP for historical
> reasons (dating back to commit a7812ae4123, "TCG variable type checking.", 2008-11-17,
> which added the argument to helper_cc_compute_all).  It does not make sense for the
> argumnt to have any other value, so remove it and clean up some lines that are not

argument

> too long anymore.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/cpu.h             |  4 ++--
>   target/i386/tcg/cc_helper.c   |  6 +++---
>   target/i386/tcg/fpu_helper.c  | 10 ++++------
>   target/i386/tcg/int_helper.c  |  8 ++++----
>   target/i386/tcg/misc_helper.c |  2 +-
>   target/i386/tcg/seg_helper.c  |  8 ++++----
>   6 files changed, 18 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

