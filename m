Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C3C7472CE
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:36:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGgCL-0003a6-Iy; Tue, 04 Jul 2023 09:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qGgCJ-0003Z9-Kc
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:36:03 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qGgCG-0003Ht-JC
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:36:03 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3142ee41fd2so3133138f8f.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688477758; x=1691069758;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ExHDRwBi66qNTScO9JUMaCCcf4dgB+1xBOOFnoVQWaE=;
 b=lUfPW2hcyWdM83nomZ1+GT1JDgASJajt5Y45Fvd4KYq7Pi20GAHN2LK14lNxXyv6q8
 K+23mfAsBvrFs0gePceQ3kcWQo4yHkLpYJ5VDvng3PD7GGM0hoKl9xpgr0JOpIUaiEij
 O7b9/BOA59BaHGwcOosyqP0vFzhJ/wI7ZuXHUWRVoTTLUMyiYrV5eIicyY/5sa0IQ4Hu
 E/bFgMxOdiCQPTU4xTYFjgVJmzecED/5z4Le/rVum/7PCf3eOtl4Yfdsr+NGKqA2QjzT
 gcDx9lZbQZLCsEqfvK+8Zy7LYkU2ZYNENDsRHdW5hnmvAB5qOqnCflmyKw5peTQhmrO9
 iPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688477758; x=1691069758;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ExHDRwBi66qNTScO9JUMaCCcf4dgB+1xBOOFnoVQWaE=;
 b=Wuv7FaLt++hGAQLASvoMRpMLH0FSi8ubdSygd1WXvtQUDcqggulwlryy2U7G/YruRn
 luPhTFH8AJKfn+D4qJ+DV0KCFPsaTh+LEWXUEWgc5ZCp4kHnzk3n7OOSMTZYTRB9QVpg
 RfCUlDWXAoKhFfcRnHo0hXKxX6s2ZJxDJbZ4hqHXpdnkJPN7m4hVKpnxD8zw9w4mnNWS
 kt9V0slFCLR5Hg49SKVvX5TPv3Dv2InjGUQU+g5TqoNzzvJ5ROJ0YkiyG5vgK0nz2Uce
 kRJLT25LKrcjyuyJQpRktAHQsTb9HZMPx4iNuBrQJrNBP9hbe7WYx4NRwCaNQEKEScRa
 59SQ==
X-Gm-Message-State: ABy/qLY5zueWWwjOKZ1/rK9XtYCOXGAk5xxWnVd9/mkEypFv+6/NFEdd
 FPitjMR57Sp9bgg5C2pV0vs//g==
X-Google-Smtp-Source: APBJJlGyz51vDnXSIfFkHXBdGwr6Ite+cPX1qJrp8yz/MfGfqiagZuH3iaJJMX9loiBt0/MyBrKH5A==
X-Received: by 2002:adf:f504:0:b0:313:ebbf:3696 with SMTP id
 q4-20020adff504000000b00313ebbf3696mr10385878wro.46.1688477757606; 
 Tue, 04 Jul 2023 06:35:57 -0700 (PDT)
Received: from [192.168.200.206] (83.21.151.197.ipv4.supernova.orange.pl.
 [83.21.151.197]) by smtp.gmail.com with ESMTPSA id
 r8-20020a056000014800b003143b032b7asm3994180wrx.116.2023.07.04.06.35.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 06:35:57 -0700 (PDT)
Message-ID: <81e6bf97-b6c6-e09d-51b5-445bdc3a47bb@linaro.org>
Date: Tue, 4 Jul 2023 15:35:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] target/arm: Implement Cortex Neoverse-V1
Content-Language: pl-PL, en-GB, en-HK
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230704130647.2842917-1-peter.maydell@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20230704130647.2842917-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

W dniu 4.07.2023 o 15:06, Peter Maydell pisze:

> This patchset implements the Cortex Neoverse-V1 CPU type, as a
> representative Armv8.3 (+ some extras from 8.4) CPU matching real
> hardware.  The main thing we were waiting for to be able to define
> this was FEAT_LSE2, and that is now supported.

Now I can add "reach SBSA level 4" to todo list as it requires v8.3 cpu 
(I do not count 'max' cpu type).

Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>


