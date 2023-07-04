Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5368747490
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:55:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhQm-0001cs-SV; Tue, 04 Jul 2023 10:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhQk-0001Yd-8z
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:55:02 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhQi-0004E0-LH
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:55:01 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbc54caad5so52702685e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482498; x=1691074498;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mDL60JMltsMt/Rtg+5wTG42zz2rVVDC3HXHwPSfEEGk=;
 b=guhz6rDvWjuaIhSJ4DIGVbzCkamwJcvl6uEMHn53jeIR8UCf4ilZOydQohvYacoN2+
 SSelyymUEntGuaAYrWzYd/nP1LqkAvHNSsvvcXzWimeVz9ttZ7CgX4aPLFHE8gejQoCL
 nfNIcb4nj4C0+3I7yE0YOZVwea9wjuuALErqeb0EZGrQS+OB/2s2QdVztuldIr3biF9n
 5BQvm6INnlmK46zhaeFt28y0EYJB1MBdP5OCRxLoo4SVxOhq7Xvdqq/mi3//Muyrl5zm
 WIxvWKIf5atcrzo2jrKxG2WN311NFjhcAtw86u0ycLYyrOE9synZwkhK/ZjWrHgiTblB
 NFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482498; x=1691074498;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mDL60JMltsMt/Rtg+5wTG42zz2rVVDC3HXHwPSfEEGk=;
 b=LXwTTjVcA7nvEkBy0QJrajaBWpL/u+knb9CTJz3dVYodbftCS4hdFMFDs/aDXQw0Jb
 A8V0czDmgd1m8hjx55pWFN+0AKafe+hj+fite9zLIN+QApv1C/Fo4ALFwO9gcauMoAh/
 tPyss6yyL9umqtST5Sd/MbF/IN7O38BUn+V51s9wVfDdltO8A6houtGje5IaF6m47fTF
 dfw1uki1oAAkrWcGATmQ41Sk2RBF6cqyKDuUDNqy9gFPwO4QGuOUFX7xAmwT7cRWtnjF
 ZA9ltjGRkQoKw08LkjGXH1bu1peZlyMXUkDMQzT/N6f9bVLRrjLD1rT5GCb3y5ErVu3W
 5dhA==
X-Gm-Message-State: AC+VfDyJBmgF5rjQGO+OZCC/GfZW4kKJHBtBnG6h1RyEYd8PTPocTHNW
 bfBxksO2Xte13dJmzQ4Xy8WvYg==
X-Google-Smtp-Source: ACHHUZ5jJPaROpRVARbRAxeyzE+AfZYh1pK82JQ2I/vp92ja5IXbrIg/4Tk09/YFgKDNJsEBglG8/g==
X-Received: by 2002:a05:600c:3787:b0:3fb:ac73:f7d9 with SMTP id
 o7-20020a05600c378700b003fbac73f7d9mr10543879wmr.32.1688482498454; 
 Tue, 04 Jul 2023 07:54:58 -0700 (PDT)
Received: from [192.168.1.102] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a5d68c5000000b00314283a525bsm10145016wrw.93.2023.07.04.07.54.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 07:54:58 -0700 (PDT)
Message-ID: <488ca2a9-8e1a-3a62-8487-fefaed69ca8b@linaro.org>
Date: Tue, 4 Jul 2023 16:54:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] target/arm: Implement Cortex Neoverse-V1
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230704130647.2842917-1-peter.maydell@linaro.org>
 <81e6bf97-b6c6-e09d-51b5-445bdc3a47bb@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <81e6bf97-b6c6-e09d-51b5-445bdc3a47bb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 4/7/23 15:35, Marcin Juszkiewicz wrote:
> W dniu 4.07.2023 o 15:06, Peter Maydell pisze:
> 
>> This patchset implements the Cortex Neoverse-V1 CPU type, as a
>> representative Armv8.3 (+ some extras from 8.4) CPU matching real
>> hardware.  The main thing we were waiting for to be able to define
>> this was FEAT_LSE2, and that is now supported.
> 
> Now I can add "reach SBSA level 4" to todo list as it requires v8.3 cpu 
> (I do not count 'max' cpu type).

Do we need to introduce machine variants, such sbsa-lvl3-ref and
sbsa-lvl4-ref? Or simply sbsa-level3/sbsa-level4?


