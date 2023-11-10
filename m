Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 352147E7BC0
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 12:17:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1PUR-00055R-15; Fri, 10 Nov 2023 06:15:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1PUP-00055A-Ab
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 06:15:53 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1PUN-0003Nk-MC
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 06:15:53 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9e1fb7faa9dso324072266b.2
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 03:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699614950; x=1700219750; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TUjkHAsAcJQRPBx9EOAMz18aQaDsB1mBRQKwcytnCag=;
 b=pRbenq0l2731eVwYNLITGBFqn1cD5BL6Ybmo0hZuRoderF8mKCIMBYDS3bVOfgyFlE
 /WJyzYgTj4T5dnLOHlFj3RcfL3//1xUZuOHHSTO22+6TlAJcfCjsq+TqCQDCI3IR4rfr
 W14p/hYB6TAu/CZiC7EytCoFXWlIlvC+++sRC3GiryC/O5TcdfO12OTAvUMQ8ZmZJZ2v
 ecXUkUCs/PIuL1vdPmlnjB2VYxy3nCnWXJ15e7qihMMtvrfeW6DnIUDpvW685xhWEh7Q
 5ems2zrC52d0KEpm96uMnPDelmlS+QHt7GwP+NMW5Wq+msC6GMDBiPs2/sHupBB69D5c
 UGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699614950; x=1700219750;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TUjkHAsAcJQRPBx9EOAMz18aQaDsB1mBRQKwcytnCag=;
 b=sKyPrdJ47y9k0f4RyF66FAwZgLTs+zGjKlSyZmuKD9PM5thiJh8paX4n9WdXtbvnUn
 OHKP0dUOPrRIosR1qxRIbyvoZgO/gBn3T41zzIv/SFHkSeZ/hKk1ootVGOPcyERmhkrC
 PNRN9ge5/BxTuQYbPnFTzdiVqJZbXKCgnr6GFOMfVSy01sFPnEV/zZDA8vlKjNKJ2gB9
 zZBOd7lalcOA30Pg6gA6dwF0y59zdi9uurwXbpFbPs2y4biFh+XPUfvqetRHMO6AoQcj
 4armRbIQwR9ZDjfqbKd81L8KPt/M+1GB/3dzklH0NGUpCey71xjpH04fhgdgoWpgXV0G
 5sBw==
X-Gm-Message-State: AOJu0Yx7qDe77y3YkK6SBpfYYyu8OEWXFDxeS8O97ctvO56MuMwjXif7
 M36HZX2CDh6yKOEq7BNVpagiRA==
X-Google-Smtp-Source: AGHT+IEXwIEEy09zNuCdANXzBztHdDTa+2N4QJXyqZWGisqt0aVYKfpWv+5Tp7m47XeiT0IyrZWOpw==
X-Received: by 2002:a17:907:5cc:b0:9d4:2003:78dd with SMTP id
 wg12-20020a17090705cc00b009d4200378ddmr6100721ejb.70.1699614950126; 
 Fri, 10 Nov 2023 03:15:50 -0800 (PST)
Received: from [192.168.69.115] ([176.187.194.109])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a509511000000b005454b6d4e22sm1002715eda.64.2023.11.10.03.15.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Nov 2023 03:15:49 -0800 (PST)
Message-ID: <f881ad49-38f6-450f-8c0a-0ba40810422b@linaro.org>
Date: Fri, 10 Nov 2023 12:15:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Add QEMU_WARN_UNUSED_RESULT attribute
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <cover.1699606819.git.manos.pitsidianakis@linaro.org>
 <84781fce2c3145a86d043d4c6b3b463af40eeed0.1699606819.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <84781fce2c3145a86d043d4c6b3b463af40eeed0.1699606819.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 10/11/23 10:16, Manos Pitsidianakis wrote:
> This commit adds QEMU_WARN_UNUSED_RESULT, a macro for the gcc function
> attribute `warn_unused_result`. The utility of this attribute is to
> ensure functions that return values that need to be inspected are not
> ignored by the caller.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   include/qemu/compiler.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

> +/*
> + * From GCC documentation:
> + *
> + *   The warn_unused_result attribute causes a warning to be emitted if a
> + *   caller of the function with this attribute does not use its return value.
> + *   This is useful for functions where not checking the result is either a
> + *   security problem or always a bug, such as realloc.
> + */
> +#if __has_attribute(warn_unused_result)
> +# define QEMU_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
> +#else
> +# define QEMU_WARN_UNUSED_RESULT
> +#endif

FWIW I sometimes use:

+#if __has_attribute(nonnull)
+# define QEMU_NONNULL(indexes...) __attribute__((nonnull((indexes))))
+#else
+# define QEMU_NONNULL(indexes...)
+#endif

when doing tree-wide refactors, then remove the attribute because
prototypes become really ugly.

