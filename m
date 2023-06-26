Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE33A73DC6A
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 12:45:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDjii-0007Nx-WD; Mon, 26 Jun 2023 06:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDjic-0007Kp-K1
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 06:45:16 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDjia-0001s5-Ev
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 06:45:14 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b44eddb52dso45748921fa.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 03:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687776310; x=1690368310;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=72dCw6/OQqs7JI0840J/5S+u9WEFf56hu8wK7UopnZI=;
 b=hRQf2i6xHu1PWP9OemKtuTq35uoTBVXMmCTKAUm0xrexjc+C+0xHALd3i4960/ykrk
 SVxZqOlf5HGjNg1CtUSkS5bRMhv9q/5ESqorVVbXFZRC/lFwcx1YAe4a+fOn8qCE1ENz
 M5XX7+w7/LpHr85/C4q8iy7HLkdH8JvYRL5k6uccOTi69UZZTdlgRyp4M/WREfw0mKYF
 JM78d9eF76jNSFCwx1QzRHbUf1stziOCdXvt7sIXEVnmpdhEa9xMJbWj0GTcXmvjGmDx
 V71q10AKP4Krc9biERW1/wcxmEA3tgkjPRsLnTm8o/Iu3p0RH8vZ8HpG7mlydIq0UROn
 zeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687776310; x=1690368310;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=72dCw6/OQqs7JI0840J/5S+u9WEFf56hu8wK7UopnZI=;
 b=TEeCHK/F25z2pF5gz7YWcjUkbNzfKQSJpQhYZ+KeMeb6OmT7IOsb7/y9FKB3YufK6O
 avCX47i6FOxandl4OrjIXgACdDHlhtEfumbE0cSD32LCX4ZlK9xxOxyCGeLMVHMqHoI2
 +ZX/qtTOGufTKZa2c6ZDdlI2lHJvXwZmcgVMwn3SSzBPsbvTHgsHEq277//lCEV43bke
 NKE+6gJO1Wro0/XgsHBHYBL26E+beeqiXJnAVr2QobO8FyC0ISTNVyq8tdidI1VXxBga
 pX//5WR1HBZcSuIcgbi8Un0zqgvcEUxXsRncxB3ggWuhintJc6Z39eNkKh/p4hnF3cHK
 dwAQ==
X-Gm-Message-State: AC+VfDwS4bN3fTsuBKu9uULhH1nrX6S3DikBBbPlYsCNJC9mApq6fHhn
 GboS8AuHRjTlfqOwczjEw1HkGw==
X-Google-Smtp-Source: ACHHUZ7+EP8HXL4iOR4kYT1/msU2dGUgKB+4FrHmYnwOusmfQFuiR1u75maHfKs0G5Klh72gp4CngQ==
X-Received: by 2002:a2e:9c98:0:b0:2b5:82c9:d85f with SMTP id
 x24-20020a2e9c98000000b002b582c9d85fmr9324617lji.11.1687776309889; 
 Mon, 26 Jun 2023 03:45:09 -0700 (PDT)
Received: from [192.168.44.231] (141.pool92-176-132.dynamic.orange.es.
 [92.176.132.141]) by smtp.gmail.com with ESMTPSA id
 u8-20020a05600c00c800b003f70a7b4537sm10204408wmm.36.2023.06.26.03.45.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 03:45:09 -0700 (PDT)
Message-ID: <89fa0689-f5ba-f5b3-16f2-7aa1a50077c0@linaro.org>
Date: Mon, 26 Jun 2023 12:45:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/9] Testing / CI patches
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20230626081415.64615-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230626081415.64615-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/26/23 10:14, Thomas Huth wrote:
> The following changes since commit 79dbd910c9ea6ca38f8e1b2616b1e5e885b85bd3:
> 
>    Merge tag 'hppa-boot-reboot-fixes-pull-request' ofhttps://github.com/hdeller/qemu-hppa  into staging (2023-06-25 08:58:49 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git  tags/pull-request-2023-06-26
> 
> for you to fetch changes up to b197ea8636a18b0e2968b00c3a392bfc641b51a0:
> 
>    tests/qtest/cxl-test: Clean up temporary directories after testing (2023-06-26 09:01:33 +0200)
> 
> ----------------------------------------------------------------
> * Improve gitlab-CI with regards to handling of stable staging branches
> * Add msys2 gitlab-CI artifacts
> * Minor qtest fixes

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


