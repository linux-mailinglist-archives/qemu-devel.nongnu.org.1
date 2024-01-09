Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 387F7828AC9
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 18:13:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNFeB-0007P7-BT; Tue, 09 Jan 2024 12:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNFe6-0007OQ-Ti
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:12:10 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNFe3-0001j4-UQ
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:12:09 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2043e721daaso2220970fac.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 09:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704820326; x=1705425126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FcH7a3HEDNtcNeDNTDcVX+QEyrxq/bzy9SsOX2YvokI=;
 b=De+L3vqPEoKXMWTejdkjnYFKfE8g4T/CqNgwUMDc1yAAo3EQvs1mxqcw5goYCQhh7S
 KMaeXMLvr4IZB/jmKgQzcXtJQZ1m23vMJPY3J3W9UG0qN1B8MExazoY4l1o3Le7uguEx
 0Gr/CmZEHfd9zB7feVZ7fAfBhuOvko2xlEmlv4BSrKb+LPtuBhIRIk6cnWOAkh59wlNL
 F/9+kjWnM9zQunD0tynfe6acIZ6H+MAMBV/AN3Uz71XaL7QWVUbI9w1NEu2V0asj8RRJ
 g7rTEL9N80OzAQ9gGaOxy/TtchfrVi1yXSQMQvLIXnhkBPxvdmd4bQ5SQs6y8F9bV2wr
 bNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704820326; x=1705425126;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FcH7a3HEDNtcNeDNTDcVX+QEyrxq/bzy9SsOX2YvokI=;
 b=ewuQWDAj10fn9Z6A5K6iALjDXdl6P5MrY5FFewmA5imY0Vt94DcX6LqfeUmke0hKDX
 fRVStz0A5+1bRNpgBXQ7zRXprKXelf4a2P4U6XtxaF7Rxup8mfh9ufta4He95g4wZ4lr
 BqAuXHvXVJHuU3IQMe2Ju9piPpqzj5Fz2K3ajNqlGBnPhTN2mYjfggSrbnFivlI3yQZK
 icbddBayphd/n9+HpAD3f1RWbItchk524g0GM2lM8+IqiNH5PAMQRWjXcXHwlAHAFlOE
 dWMHRV4eFumMlOjmrOjsUciLGox8aDCMcaQlt4nbF6mmo+hH40SnglBcg1P014xnp4dA
 yDTg==
X-Gm-Message-State: AOJu0YwWfgLGAmoPZWaDvdHN02mGGX0ACyQcTrEd9fTHcK4wl+nJap9c
 Q6exGISDGl7RumM14R03ougrVz3IcbKdyg==
X-Google-Smtp-Source: AGHT+IHeUf50nOv4sh65nQaTY7fbIHimAwPJ1LK5mniXEUUpgV0zqjPAjV9yMQ5h/iIyVvPnvqYPUg==
X-Received: by 2002:a05:6870:920d:b0:205:c7cd:6e67 with SMTP id
 e13-20020a056870920d00b00205c7cd6e67mr7629715oaf.46.1704820326360; 
 Tue, 09 Jan 2024 09:12:06 -0800 (PST)
Received: from [192.168.47.227] ([172.58.111.136])
 by smtp.gmail.com with ESMTPSA id
 v24-20020a05683011d800b006dbfdf808dbsm430018otq.0.2024.01.09.09.12.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 09:12:06 -0800 (PST)
Message-ID: <c89b73e4-b966-48d9-867a-75acd74812bc@linaro.org>
Date: Wed, 10 Jan 2024 04:11:55 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: arm_pamax() no longer needs to do feature
 propagation
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240109143804.1118307-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240109143804.1118307-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

On 1/10/24 01:38, Peter Maydell wrote:
> In arm_pamax(), we need to cope with the virt board calling this
> function on a CPU object which has been inited but not realize.
> We used to do propagation of feature-flag implications (such as
> "V7VE implies LPAE") at realize, so we have some code in arm_pamax()
> which manually checks for both V7VE and LPAE feature flags.
> 
> In commit b8f7959f28c4f36 we moved the feature propagation for
> almost all features from realize to post-init. That means that
> now when the virt board calls arm_pamax(), the feature propagation
> has been done. So we can drop the manual propagation handling
> and check only for the feature we actually care about, which
> is ARM_FEATURE_LPAE.
> 
> Retain the comment that the virt board is calling this function
> with a not completely realized CPU object, because that is a
> potential beartrap for later changes which is worth calling out.
> 
> (Note that b8f7959f28c4f36 actually fixed a bug in the arm_pamax()
> handling: arm_pamax() was missing a check for ARM_FEATURE_V8, so it
> incorrectly thought that the qemu-system-arm 'max' CPU did not have
> LPAE and turned off 'highmem' support in the virt board.  Following
> b8f7959f28c4f36 qemu-system-arm 'max' is treated the same as
> 'cortex-a15' and other v7 LPAE CPUs, because the generic feature
> propagation code does correctly propagate V8 -> V7VE -> LPAE.)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

