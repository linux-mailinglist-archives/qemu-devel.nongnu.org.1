Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CB6720AF8
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 23:30:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5CL7-0008Np-4F; Fri, 02 Jun 2023 17:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5CKm-0008KS-0L
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:29:20 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5CKi-0002dM-VI
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:29:19 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30ae901a9ffso2329634f8f.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685741355; x=1688333355;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p9LdlfuO1oOCraFe4CVDHLR1DPXJuyOKh2NIcjLzG5g=;
 b=JSEyiK7uhak36YhdVoVtzUxMyK7mMSaikDNhYEwAypwADv+QkjtzOgVs0firfM3/SS
 hDiwZkywtcdW6AbD5VgxQfVMfVYJrwjeSqiX7zsWYjeLkgCYC5Ozr0SDY3Sx2PY/UqQe
 h4v+V4HAoMxDx6Fbp5Dnf9LaUI1q4arZuLlMPeGmKZQ9xGRTRCRoGHDP1stvMlT3hV3F
 AekZqAN5GV1JOQBO44ApJxe6KWWToc3m74rw8KTaLchjW3gb/K+wi90r4oTg/vGDRJQ6
 wbQpfsoP5vHi9MEE4JaZT1vH2XJr9YWtyoQvNJ6oo5iLkS+F/c2QLXjAu2r9JO7Og+as
 0+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685741355; x=1688333355;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p9LdlfuO1oOCraFe4CVDHLR1DPXJuyOKh2NIcjLzG5g=;
 b=Msv0r3hbHibYuIDyf0Md/an4Ncp12xeEPeAt+O4t+2sObeSOThRGWLaSLiUSLMJerr
 fVVel0BADUYmlJBCM2lmNzbf7M4pjc3nSblXwcao76uS0+p/8jGQ7jAL84E8arGYsY2e
 bLiHL7cOuObAoBk16QiXKcm5IbjutwJXCPE6LcXGh+hHmJHoWNUwuhrJu0Ty3AcOY64B
 rWZhwnT1T6ZzeuUMCdrOd5vVUXpkkBRHKqqNm3R+uh7qD0pVZi91f4LGKsRhfhGjl767
 vp6kmyA15lEReak9mM51cPtpyMuYCUZrjdPvQVbfLSxQdaqpa/KyNHk4rEp8kFEZ9vnJ
 4C7g==
X-Gm-Message-State: AC+VfDz+bezdZIc6EuKZuSiZ4rVtqKKkxe1ChUrruQVrmp6f63/Vje1V
 PpzVTVFvZZSLrpy4VzB2q1FyGWewkMNepwDrRM8=
X-Google-Smtp-Source: ACHHUZ4RillXXWsLP1l7+DawPa0nl47F9OcV7DSTxxAdlK9J+wt1WW7nXM5mc5S33DIESnnwtDlpig==
X-Received: by 2002:a5d:50cd:0:b0:30a:e09d:572d with SMTP id
 f13-20020a5d50cd000000b0030ae09d572dmr953583wrt.32.1685741355192; 
 Fri, 02 Jun 2023 14:29:15 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 d8-20020adff848000000b0030ae849c70csm2678918wrq.37.2023.06.02.14.29.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 14:29:14 -0700 (PDT)
Message-ID: <5c824199-6da0-85b6-cadf-587eb46294e6@linaro.org>
Date: Fri, 2 Jun 2023 23:29:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 15/48] tcg: Split tcg/tcg-op-common.h from tcg/tcg-op.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-16-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 31/5/23 06:02, Richard Henderson wrote:
> Create tcg/tcg-op-common.h, moving everything that does not concern
> TARGET_LONG_BITS or TCGv.  Adjust tcg/*.c to use the new header
> instead of tcg-op.h, in preparation for compiling tcg/ only once.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h |  996 ++++++++++++++++++++++++++++++++++
>   include/tcg/tcg-op.h        | 1004 +----------------------------------
>   tcg/optimize.c              |    2 +-
>   tcg/tcg-op-gvec.c           |    2 +-
>   tcg/tcg-op-ldst.c           |    2 +-
>   tcg/tcg-op-vec.c            |    2 +-
>   tcg/tcg-op.c                |    2 +-
>   tcg/tcg.c                   |    2 +-
>   tcg/tci.c                   |    3 +-
>   9 files changed, 1007 insertions(+), 1008 deletions(-)

Trivial review using 'git-diff --color-moved=dimmed-zebra'.

