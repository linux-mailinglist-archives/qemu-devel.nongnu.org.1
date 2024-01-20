Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ECC83370C
	for <lists+qemu-devel@lfdr.de>; Sun, 21 Jan 2024 00:23:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRKf0-0005fQ-Rf; Sat, 20 Jan 2024 18:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRKew-0005dc-Pb
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 18:21:54 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRKev-0002Ms-1T
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 18:21:54 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-337cf4eabc9so1538598f8f.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jan 2024 15:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705792910; x=1706397710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g8+x+6YTmzq6msYI2oiG3fsWHg+Bv/bQ95nPuMcD/nQ=;
 b=zZWc1k3HmODAw32h5lYy3iKe/j2gGEh3HgXjseybOBiBxEcAkbIzZ9q5n38p0w1xT0
 dLBvGLzrsxTFy+KEWUXbXsWt23/ZovUpYVzlFrMJhZFzu2ee5dCqE55mDnrd2+kNiBsC
 lELjLyr5MzyucGh1shPttio/t+b36y8t1ZlbrRGzn3XrR1MledGWsdzklQdxjJiWFwNl
 0Rb2lMyvBreYrF9XCmJ74LWHYfoieOnN8kkVo5tvzdqLtY9rOK7wSW9qM+cg44qC79ck
 ftxvMljkM0YEsIeiaZj2nuyy4WYupNPATCxGwIVLLR2aXmW1hDnHzsRu/ndJ1hCJbv/e
 RAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705792910; x=1706397710;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g8+x+6YTmzq6msYI2oiG3fsWHg+Bv/bQ95nPuMcD/nQ=;
 b=MVjMHSE4N2ZgmGBXnw9gupXslyNFjgVx+C/USdQZBS+5+EOg/mLjHG9dIjIV91Bgv3
 1sih90uR2Rq4ndI8NrtkOAmTP8b5/LMxSGNK/3LwG/0H6yOf3UjTywV+I6lSvRDO8Csh
 Djk13m5EALY2J3QLWD2XUqMsuc9+vSL9bUkyomgsw0WeA+RHnxJ6CFrrnhEnpoo7wbLk
 4X7Cni8l/BrIbcIm/nDqpm6Ral2LFOXRNQjISsNRdYYLrQVbYkyQLJEfUMwD0OJ/FIOf
 UJ2a1bBhRBKNukVqWFWvq/fWZ8AOX+Wx6wDQ1daYKu/hWaRkihfsXs0oqR/6Bc/81yRG
 0K1w==
X-Gm-Message-State: AOJu0YwsjUWkYOnHkO2BAGd11ZY4SpQKI7BIAQHeE3Qc1QXQrfogCxwi
 0XgoqiDd5nwAc51FCcmb5qtkLZdnKljZCM3u1++7SmUGVvj3sELpCRxOgobrwGA=
X-Google-Smtp-Source: AGHT+IEs94jo8P9DCtW2Tr/QGnoAFppgyQupporUC6HzGO3GZlygKU9pD/tRbv75g38eecJ+uclMXw==
X-Received: by 2002:adf:f243:0:b0:337:c527:ad56 with SMTP id
 b3-20020adff243000000b00337c527ad56mr1001501wrp.11.1705792909959; 
 Sat, 20 Jan 2024 15:21:49 -0800 (PST)
Received: from [192.168.1.67] (88-178-114-168.subs.proxad.net.
 [88.178.114.168]) by smtp.gmail.com with ESMTPSA id
 r8-20020adfe688000000b00337d97338b0sm5713452wrm.76.2024.01.20.15.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jan 2024 15:21:49 -0800 (PST)
Message-ID: <b6416543-df65-47f6-aefe-30133012bdda@linaro.org>
Date: Sun, 21 Jan 2024 00:21:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] qapi: Fix malformed "Since:" section tags (again)
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: michael.roth@amd.com, peter.maydell@linaro.org, jsnow@redhat.com
References: <20240120095327.666239-1-armbru@redhat.com>
 <20240120095327.666239-8-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240120095327.666239-8-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 20/1/24 10:53, Markus Armbruster wrote:
> "Since X.Y" is not recognized as a tagged section, and therefore not
> formatted as such in generated documentation.  Fix by adding the
> required colon.
> 
> Previously fixed in commit 433a4fdc420 (qapi: Fix malformed "Since:"
> section tags)
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/block-core.json |  4 ++--
>   qapi/migration.json  | 14 +++++++-------
>   2 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


