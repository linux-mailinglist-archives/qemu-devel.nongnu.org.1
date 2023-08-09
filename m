Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDBD77643F
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 17:43:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTlKS-0002eZ-Vz; Wed, 09 Aug 2023 11:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTlKQ-0002dC-Jk
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:42:30 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTlKP-0005WM-2w
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:42:30 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-686be28e1a8so4940000b3a.0
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 08:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691595747; x=1692200547;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hhtL7IGvgzsYaF6mhTvgqbU+b90lmSlICguvdIDSBkY=;
 b=bJ6uJYx86P5pux8h6RRQTsd6YltxiFV06n6cPx8oXowlmUYJAkt/Y78vTxQGbSphfi
 p5bU3gAIq8zANXzzvIpQ1wY6L2OPRgN+5Ctbv3ol5Js35bfaRYD2IQT52f0rcJWvjJm1
 pcVfvht8vbz28KkHKpRXdX3m2/tB31vYkzN0nB0eYkJbVBBs6V/GPQ8WDV+mBYWw54Is
 i4j5gPQeI8dABTUwXewMChm+mG5ZDLYPej/A+gWhYMtbmM6cnQvQxI9bu1p82AOkq2pE
 j/khqUr9l60xBO8x+u8twKcAlQR5eZ4IPjYtZIl89r81Kk1snfcKudCoDxjnEE1/5fNc
 LHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691595747; x=1692200547;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hhtL7IGvgzsYaF6mhTvgqbU+b90lmSlICguvdIDSBkY=;
 b=MOOvnCMqlxxs6txGYmPM8Ed5+HcRpxXKIiMLMrPpQO/nUCVJ5daz1Jn0QGh+HpC3NC
 q0QbJznQXlW3bOq5xqn5KCm1RHX01IN76NNnv8Dh84H7slc9pMP4uGKAWkpVUKj77YRw
 b3jRGb2qoFHClLk++tU1K49YdcAawuP10QjfzaRV2LE9L1kIxguaAQ3B6k3r+tgkNQLI
 uGYMClGAOHSP+YJjEY3aDAGEGZtSujNl0WVgV0EE7Q/uvVViZGuUHMtgywinlAOrKPLv
 hUiSPWN2epyj+BexcJ7yZFvujYHJn3pzVUArZVGBrw2cZTCyT0Nzbr/8bOrKvxM8kqRN
 zDlw==
X-Gm-Message-State: AOJu0YwcrhFzP11ASqqgx4Fx7hRVhVfuwevgm65kRHzE3E2jOayPRqG2
 RnjT+d9xdI01hb5xuc8pmYCgou2TiwajHCP0FN0=
X-Google-Smtp-Source: AGHT+IGnjAjySZ+c7sjsNyLI69e4YJr4V9ckNGCNSRyCQDTbimHVSV6ja86xXGbb8XV24yjeT83qnQ==
X-Received: by 2002:a05:6a20:12cd:b0:134:9f4e:623f with SMTP id
 v13-20020a056a2012cd00b001349f4e623fmr3088971pzg.14.1691595747386; 
 Wed, 09 Aug 2023 08:42:27 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a62e311000000b0068790c41ca2sm10113623pfh.27.2023.08.09.08.42.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 08:42:26 -0700 (PDT)
Message-ID: <cd1fa6f2-90f7-c915-8aab-0b8ba2b7a374@linaro.org>
Date: Wed, 9 Aug 2023 08:42:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC v4 04/11] linux-user: Implement native-bypass option support
Content-Language: en-US
To: Yeqi Fu <fufuyqqqqqq@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
 <20230808141739.3110740-5-fufuyqqqqqq@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808141739.3110740-5-fufuyqqqqqq@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/8/23 07:17, Yeqi Fu wrote:
> +#define native_bypass_enabled() native_lib_path ? true : false

Need parenthesis for the expression, and possibly better as

     (native_lib_path != NULL)

rather than ternary expression.

> +#if defined(CONFIG_NATIVE_CALL)
> +    /* Set the library for native bypass  */
> +    if (native_lib_path) {
> +        if (g_file_test(native_lib_path, G_FILE_TEST_EXISTS)) {

G_FILE_TEST_EXISTS may be a directory.
Better with G_FILE_TEST_IS_REGULAR, I guess?


r~

