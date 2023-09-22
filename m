Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6027AB4E0
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:38:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiEQ-000555-1Z; Fri, 22 Sep 2023 11:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjiEN-0004u0-Db
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:38:11 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjiEL-0001ig-VX
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:38:11 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32157c8e4c7so2228990f8f.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695397088; x=1696001888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i8Zh9/3x4DnRqh/6bnvahbjfL/ZVTviF6p8gd36Zex4=;
 b=ln65Y1Yzr12OaUTmoh/SCrOW7MOl6e8Czu/KUtdSoqF5VRO4mjYPIbaieku7Ss/BKV
 B22oEANA6OyzhiNCBkaDBpO2UPnNURRMdPqQyj/0O5gfS37U6iIF2vHihBt91vm4Nbxa
 h3f47dcBmBuGcZV/hOUym12oFT6Zqok8Wq2hQyAwEgQxhOOqQ/Q2ClILTsv+veA6wGG8
 fYYPbm6ZzAFGg3AmZ+xH62GbbSQpYTsrBzqVIHx7FFvxQgr041qtgByfbAa6U0k/kxsS
 Hs2iZJz9dAHaA3xI+hsVvfQ18Nlt4I55Ms4LoFpMDUggqkPBEJHtvtz/86OlGdqsw051
 vMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695397088; x=1696001888;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i8Zh9/3x4DnRqh/6bnvahbjfL/ZVTviF6p8gd36Zex4=;
 b=KFfm79eKP4lsOdE8oaJrjKkI5cUL2salZCMqZVfbLnqBUAnuAZvUVF9mTGXw/zgV8t
 o5XrIovYaCZgmqXlxE9cKUF57LyTY/ybSWFsRIjhN9+K0FzshvQmWFN2qbguMXqo1WdD
 f2KD3NAPaKzKLEVNDOM4Ujg0cLPmixKo7SchtgVksU8ClajTnOozxH6LlCE4bkizxS7v
 XGA+K14LAav1JDjltkb/SIgoiZLv2PCviaw6ql13uIYi5vS9krSYL5JXTkYtRQ/3DdnO
 6kbcXDZLGF+RJ3/AXjgYzk04Yqeu5zgBXkUiuKH4tncdt3ZR7jNpDuNGhG5/Zybqwi0z
 XVDw==
X-Gm-Message-State: AOJu0YzKANDtYpDgW8Jx+cwNMixY0Ropl6xfkMqyT8J+RDLn6TETX5JB
 8jwDx06tIP5wDVZNfBPQx8oxMQ==
X-Google-Smtp-Source: AGHT+IGaIIQDijmXUfbcIoqM8sK1uOiHjuE/1vCNMIHSv9aLTlpQ6k33QdCnOAtLjDAvZKMf/F3x+A==
X-Received: by 2002:a5d:58e1:0:b0:31f:fed4:d79d with SMTP id
 f1-20020a5d58e1000000b0031ffed4d79dmr25137wrd.30.1695397088105; 
 Fri, 22 Sep 2023 08:38:08 -0700 (PDT)
Received: from [192.168.250.175] (234.red-88-28-23.dynamicip.rima-tde.net.
 [88.28.23.234]) by smtp.gmail.com with ESMTPSA id
 k6-20020adfe3c6000000b003196e992567sm4719289wrm.115.2023.09.22.08.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 08:38:07 -0700 (PDT)
Message-ID: <6d0d88ac-66a3-cc57-25bb-3c9092679326@linaro.org>
Date: Fri, 22 Sep 2023 17:38:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] hw/intc/arm_gicv3_its: Avoid shadowing variable in
 do_process_its_cmd()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230922152944.3583438-1-peter.maydell@linaro.org>
 <20230922152944.3583438-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230922152944.3583438-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/9/23 17:29, Peter Maydell wrote:
> Avoid shadowing a local variable in do_process_its_cmd():
> 
> ../../hw/intc/arm_gicv3_its.c:548:17: warning: declaration of ‘ite’ shadows a previous local [-Wshadow=compatible-local]
>    548 |         ITEntry ite = {};
>        |                 ^~~
> ../../hw/intc/arm_gicv3_its.c:518:13: note: shadowed declaration is here
>    518 |     ITEntry ite;
>        |             ^~~
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv3_its.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


