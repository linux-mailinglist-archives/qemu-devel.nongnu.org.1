Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C92C734BF1
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 08:56:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB8na-0000RD-2M; Mon, 19 Jun 2023 02:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB8nX-0000Qs-Cg
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 02:55:35 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB8nU-0003D5-N7
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 02:55:35 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51a4d215e09so1027177a12.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 23:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687157729; x=1689749729;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e2wSBi0dF5p8vs9jfI2IRxAZm1PAtlL5gLn9FCXY9H8=;
 b=TQtHi9LBhQN1s0noedMPDYNhI/my+I9lh/mZHlimAB+igp1HlAQ1Nukw2qc+xyRqaE
 9EvV0wQ0dFutoyQIUYf2FtJGWkuS9lAc8l6MfYGIinVR55p+ga0S5AaFNOvyJ/2PC88g
 SUsvRyeRvQe7hI8NNQLzoKGqzq3ax42Gg0u4bo59j9e++hgI+uOg6E2eYduShhzP9QXa
 RhgfHWwawPk8TKmS7cv2pJJcXeLoGr2gJOrdHuMAK6pM+SKDLIhM6BdQ7XidczpZ2257
 HjAwppGWRs1JtejtcKUtsWdRz2N1DObngZJFPZcOYiUgZb5xtihX/FfbVXJdkTgzUZmj
 posA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687157729; x=1689749729;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e2wSBi0dF5p8vs9jfI2IRxAZm1PAtlL5gLn9FCXY9H8=;
 b=Ifdjx770ztg5vO4RD1LOgAscFZj+LzqbuqAIYWihqo+C/f/HpnR9z/nT+FN+M34oaJ
 UDS+HwYMs8f8zGQ8VH68KDmgc9MosN6u8+tYzq4pPjcFN3UN0JIxy2FnQIbiYEeA2LXs
 EU7hZ0QP6irQcXEii7wN2rV9uyqxc/FRVAsSAW3sdwtBP/sSGsamlgMeQXcSD3jWZWOu
 CJvXukHdedZH+zDPRFbHHEHL+gfMJ+xEP1HnSkeqKEm2V2hpCK+BEcs3qHJCzMWpA9ch
 AnKIqk8VUve3eZI0OdnhocMnkLBzsvtUOLLG+QDPx3k74rZaLbWqUo7Cix8fq5GfH+dz
 AM1A==
X-Gm-Message-State: AC+VfDwqyBPMxdAMPpcJhTO3j/7qoN44/wrMCPsaAXlQ5mSiCGmoDqQD
 Lg+eNc1dKno3f00I+iluR68I8g==
X-Google-Smtp-Source: ACHHUZ5fiEo7EIfodugru0aSFikgJgAV8ggYhj/HHdfKWfDRJNMOLwFhg4OlI4rxoGq1xmEB4VrzrA==
X-Received: by 2002:a05:6402:755:b0:51a:4842:ecdc with SMTP id
 p21-20020a056402075500b0051a4842ecdcmr2806201edy.1.1687157729129; 
 Sun, 18 Jun 2023 23:55:29 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 b4-20020aa7df84000000b0051a26ce312dsm4447576edy.71.2023.06.18.23.55.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jun 2023 23:55:28 -0700 (PDT)
Message-ID: <a26b6e40-886f-495e-cc0c-04f27a2453ac@linaro.org>
Date: Mon, 19 Jun 2023 08:55:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/6] tests/tcg/cris: Fix the coding style
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, qemu-devel@nongnu.org
Cc: Zhangjin Wu <falcon@tinylab.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20230616152737.23545-1-bmeng@tinylab.org>
 <20230616152737.23545-2-bmeng@tinylab.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230616152737.23545-2-bmeng@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/16/23 17:27, Bin Meng wrote:
> The code style does not conform with QEMU's. Correct it so that the
> upcoming commit does not trigger checkpatch warnings.
> 
> Signed-off-by: Bin Meng<bmeng@tinylab.org>
> ---
> 
> (no changes since v1)
> 
>   tests/tcg/cris/libc/check_openpf5.c | 57 ++++++++++++++---------------
>   1 file changed, 27 insertions(+), 30 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

