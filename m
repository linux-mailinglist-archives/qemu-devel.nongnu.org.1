Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 583B1743CE0
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:36:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFEHB-00023T-0T; Fri, 30 Jun 2023 09:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFEH4-00022f-EW
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:34:58 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFEH2-0007jn-SV
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:34:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc244d386so13845705e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688132093; x=1690724093;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oy5ApTv+9nVRcaULOtWbQX+Gpdq9UyODq9caVpPqnG8=;
 b=h2GXka8ifZY7Q6pAiMKMm8oc4icb5dvUoBD9pRhEqtErnu6xRLuseR+ZuqFxAyQgxs
 FFMttS0LeqQiEnSvZUyZC27F1UjN95DsSWHp1ljkMAC1qQQrMGtmsuPdXH8pLZDjxzTN
 VbIyyTRGx31QgPMRj2b9zJl6jn47KpWRaQA+zqGy5+Pq6RnWFEmNuOQ9zdCgBe6DTL5E
 FVn1jSpqeSgNLcp0/ZhUcKdOJa8Hej3a08xBt3DDq2sRNVZdfVQNQ6vnD43yPcBAksqR
 MwIHVw2aIamRJfFYzhS7buqIp2YVMwn1m1HkV+VsXTneKsuWYZLlql8g9H+ULq0Ln2RO
 pgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688132093; x=1690724093;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oy5ApTv+9nVRcaULOtWbQX+Gpdq9UyODq9caVpPqnG8=;
 b=LZdsvZKQTH5CO6nQuKgKjRNoFlisI+Y9u52QY3qcW2zkFsX7Ei+O5QQbgOmnKmk/9m
 RwWNjfDSYhnkBzaJHP1hWn6qne4Pq5mJ6zx7urxrwtgk0lNhOjADWt0zi5CrI6Wabmel
 +Sc0HRDoV/0W403dWSXFaGvxxBKoBVIJmAig7ZFwlhpYOmy1GLfuAIShgmXgnIEbYFeA
 xbrnw4oLHEeER18OsX6KYOGtdhf9iU456O4ZMRss/ApUb20BODvca4fE+OzuYs4cWiJy
 fNhrQtqCEyvqR4HwYFHONsJTdfXbI1hJXY6UGWzX2/SZZ7/ZuFTJ5cDqVh1xbXXqeatz
 CYiA==
X-Gm-Message-State: AC+VfDzxJ6icOn61LpkdVOXVPyZxypdB8JLJP33gPjybOj4Deap5aGho
 eJCy5KrBlhks2irrrCPGeliGKg==
X-Google-Smtp-Source: ACHHUZ6xgGvLFzzIPop10f8/+nfpxZSAtcCI6/QG77Fcu0YmZoBwr56V5rgPUfnCxFwbCugwTwY1Sg==
X-Received: by 2002:a7b:ca47:0:b0:3f7:3699:c294 with SMTP id
 m7-20020a7bca47000000b003f73699c294mr1921304wml.29.1688132093656; 
 Fri, 30 Jun 2023 06:34:53 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 14-20020a05600c020e00b003fba92fad35sm6648632wmi.26.2023.06.30.06.34.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 06:34:53 -0700 (PDT)
Message-ID: <f6e8be02-d17a-f711-2875-95a9ca51b134@linaro.org>
Date: Fri, 30 Jun 2023 15:34:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] accel/tcg: fix page invalidation in
 tb_invalidate_phys_range()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, clegoate@redhat.com,
 hsp.cat7@gmail.com, qemu-devel@nongnu.org
References: <20230629082522.606219-1-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230629082522.606219-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

On 6/29/23 10:25, Mark Cave-Ayland wrote:
> This series contains 2 patches: the first is a fix for page invalidation in
> tb_invalidate_phys_range() which resolves the crash reported by Howard and
> Cédric when booting MacOS 9 under qemu-system-ppc -M mac99,via=pmu.
> 
> The second patch adds an assert() to tb_invalidate_phys_page_range__locked()
> which is enabled by --enable-debug-tcg to ensure that both the start and last
> addresses are within the same target page.
> 
> I've confirmed that this assert() is first triggered by the commit that
> initially introduced the bug e506ad6a05 ("accel/tcg: Pass last not end to
> tb_invalidate_phys_range") when building QEMU with --enable-debug and
> doesn't trigger after the series is applied.
> 
> Signed-off-by: Mark Cave-Ayland<mark.cave-ayland@ilande.co.uk>
> 
> 
> Mark Cave-Ayland (2):
>    accel/tcg: fix start page passed to
>      tb_invalidate_phys_page_range__locked()
>    accel/tcg: add assert() check in
>      tb_invalidate_phys_page_range__locked()

Queued to tcg-next, with some wording changes.
And to use tcg_debug_assert instead of the ifdef.


r~

