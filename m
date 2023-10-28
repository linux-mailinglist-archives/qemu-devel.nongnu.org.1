Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0A77DA8EE
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:30:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwp0W-0000d2-44; Sat, 28 Oct 2023 15:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwp0R-0000cq-P3
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:29:59 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwp0Q-0001OO-Bm
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:29:59 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc30bf9e22so5453475ad.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698521397; x=1699126197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZU+rdkZ6qP70wqb/34XTOHaG4YNoDR1L2V1v60eIlQA=;
 b=naOmyoRYY+UYGlO0gbnreINgQxtvipwXHlfRO1i58zrpkJMVrj/f1ZjIdmgxYPQl0G
 9Y2R6YDhEYibxcRwrHVEeJHaoBf9S2+MJlAsky3H/LJ+WGAWeSmThykKfrRUNMkGc0ys
 yZbvvUPEpQUp5JK9HdUYMDLFMxeijlwkyuomDwQgF36TjBHZpznExiJ+wG8YHMHg8uwX
 zuXjnlhP3nNCqkEpHFzp1DwGYm9FhgRfQB78cIYPWCSYb8ppUONf8S+jd6xzZ9hB/Pux
 OSloTuiZlKFYbVwQPHaSDTRUFPK6TnSivbIZr405Qqcb6gt3RB8t0+3lbtNcLP5XYtwO
 iItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698521397; x=1699126197;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZU+rdkZ6qP70wqb/34XTOHaG4YNoDR1L2V1v60eIlQA=;
 b=FcvxmenlOdlu/18TMAYox+Nw4Ni7YLGE/jC6hztw0mix4AgRoW7R1r8hew7uT7ihG2
 4fCdq68CtX352CIHqzjJq0aHWQYjlqg0FxYdqb33JU/sRhDa/ly6JlhLYyaX+xnyx2MS
 UEOwnfFPXhLbWqPnGLMoWDGgdYbf2icfWDtKYZ9WtHCodIhd/oS/bKtSUHz60Rc6Wjbj
 nAeX0wyvqbbS0cHPgkHooM4lpzhzEmQXN33oM6zQPm4hhbb/M9Ie3aCQhVf275xjQfsW
 Q83AV/WQse23fqsj8TXeVoK0IV0NlRuouUc9IALi0Bszu2U4064dWeEle7tnFVugB5FK
 pDLA==
X-Gm-Message-State: AOJu0YzegaYXiiI50SK36Rr7oorBcN1EE7Ot2kf/kshk5za9XywV029E
 JLWSEkcBie/WGS8zSTVmgsaLg+IXEakU4VITLNU=
X-Google-Smtp-Source: AGHT+IE909E+v453IntYM/1Oa5fA83kUJTVzHtm5LxlTnD2JvsSOZsmFF8VmdkyZWCUy4dOaEA5U0Q==
X-Received: by 2002:a17:903:22d0:b0:1ca:e16f:a713 with SMTP id
 y16-20020a17090322d000b001cae16fa713mr12665652plg.2.1698521396610; 
 Sat, 28 Oct 2023 12:29:56 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a170902ea8300b001c3267ae317sm2073072plb.165.2023.10.28.12.29.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 12:29:56 -0700 (PDT)
Message-ID: <88f901c6-47c0-428d-ac46-80a06328cb8c@linaro.org>
Date: Sat, 28 Oct 2023 12:29:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] tests/docker: upgrade debian-all-test-cross to
 bookworm
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231028103311.347104-1-alex.bennee@linaro.org>
 <20231028103311.347104-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231028103311.347104-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 10/28/23 03:33, Alex Bennée wrote:
> This requires a few more tweaks than usual as:
> 
>    - the default sources format has changed
>    - bring in python3-tomli from the repos
>    - split base install from cross compilers
>    - also include libclang-rt-dev for sanitiser builds
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .../dockerfiles/debian-all-test-cross.docker  | 20 +++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

