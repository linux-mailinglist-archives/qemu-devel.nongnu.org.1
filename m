Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28837782467
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:23:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzFF-0000ey-N9; Mon, 21 Aug 2023 03:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXzFB-0000RU-6x
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:22:33 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXzF9-0002Ch-0q
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:22:32 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2bcbfb3705dso7985471fa.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692602549; x=1693207349;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cve/4xLwkOxt2iikRpFmbppmGjP3Dqgnba79nA64ENs=;
 b=pUeQzO3FgFMTQd9Ol7/zsRKqjoAKqbsoS00HFkgGHETAWrjIibPmp9BvuUd8puBxdj
 F2uUaCWx6PoD2jRdmqnywXTo6bEJ7eYT6Ac3nk+oGzxMn+LjQTbpNeprm9fDK2F6eo+O
 5BnNrJgu0UAzKKbPLYqBVDCri+eSZMqFHOa1sEk1PwGMwYS1xtN56FKX8gD/55O4qq4w
 8nzRtRZrR9yM6FAx9QeypbRVbcq41Pl+GgoeDwZ3LMA6uqSP8/ZUzX0g7pW7ws1qnwDk
 o+a3tt78rBOCuH/rfoMsmD9xfBdMsvyNNDfD4vM+F9tOtW/KsLPyEAUFDd9zusHrw6u9
 KLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692602549; x=1693207349;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cve/4xLwkOxt2iikRpFmbppmGjP3Dqgnba79nA64ENs=;
 b=IcUoddxkTm26rc7A21+NEd3qVjfUkpEONGSvpfF8vvAxuXpeUKa0886LjVfGPQ45nV
 Fo6SkLJaNIb/0+ywiRnO8rezbfhVD/77ToH9/pW5EadCM5jwm0aLOSCyl/c2DMOgWFpm
 TNdB/eun7h2NrqVQH8ZgQsRTx6qy9PvWnunJwMgWD7NIQHkhdSBU/ZC3uVxqfcAKHq1s
 dPC9QOgO4iJNEbtlJDrkcIynly+FhU3szp0xZH7OrDZnXuOkE34aVXBSGzWd5NQZKGV0
 fbTgK3xr0urckqvkzTNdxYFSLL3LjnJtnd9QIMaywrccWrDDq/wkCs0w+u4SIaiWw1ax
 Tekw==
X-Gm-Message-State: AOJu0YztkBBsmrmP8VTdG7xrPFrkfk9WzlpHf5hrQgdTjiwmJdjUO5SY
 QzW5AzmZ47bq+1krfxlaKEG0yA==
X-Google-Smtp-Source: AGHT+IHN9PqIptJdeOE6EwZXbrH6VUhjT9dqKuaifbV1oRH3RN/hnS8wIo8QjP4MxGMCqdwPtgEUsw==
X-Received: by 2002:a2e:94d0:0:b0:2b9:da28:c508 with SMTP id
 r16-20020a2e94d0000000b002b9da28c508mr4351031ljh.31.1692602549276; 
 Mon, 21 Aug 2023 00:22:29 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 m10-20020a7bca4a000000b003fe2a40d287sm11719414wml.1.2023.08.21.00.22.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:22:28 -0700 (PDT)
Message-ID: <a6b77f0e-3c2e-1f69-298f-d6193bbd65a5@linaro.org>
Date: Mon, 21 Aug 2023 09:22:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 18/23] tcg/i386: Merge tcg_out_setcond{32,64}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
 <20230818221327.150194-19-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818221327.150194-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 19/8/23 00:13, Richard Henderson wrote:
> Pass a rexw parameter instead of duplicating the functions.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target.c.inc | 24 +++++++-----------------
>   1 file changed, 7 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


