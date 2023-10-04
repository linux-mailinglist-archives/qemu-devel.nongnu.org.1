Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0FB7B8C34
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 21:02:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo77h-0002xN-0k; Wed, 04 Oct 2023 15:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qo77U-0002sq-M9
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 15:01:22 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qo77Q-0000gr-05
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 15:01:16 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c737d61a00so664075ad.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 12:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696446070; x=1697050870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KmgKvidSmZcdhJLnzRG6qpYlR6QXAnRnRu4OIg91aM0=;
 b=HOBmEF2E4WzkC6Fa4zPiuWBYK3dZMDxoEY/zZ+fXnxsTthR5VgcsOB7jp+fIu8+DCj
 8GwBUScJPj2215eKKTRoo1LK80ZbPGcH/m7SxbOnn8v5P4XiqaxSyAxMs40JkJcmkvSw
 idqacYN7JRw05+FyVX/IkHnWV/+fjj7+sxvuFeBdWmdZzbU6R/eaKaU3ESZtLd9lENDP
 cCoyDK/IgKrowhjZmZpjFthT7CzHBc2cLLTKICfmrGWzKQxfZRNrggGj3iiEY6r9HbR8
 FW8s+ExzNz2WbA3rB/yVwwnnZ14M2wYsNRu84xAV/QqTxOoxF1DE0+dfH7BuWPCMg3GY
 /D8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696446070; x=1697050870;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KmgKvidSmZcdhJLnzRG6qpYlR6QXAnRnRu4OIg91aM0=;
 b=uxl0P9i3nMZYLBsPXEYdrkIjHfsgTTBUfwiYyO/nHE/G52FECdCJV5xsi8rAEnvOiH
 vPBUKbSicdGHq/4CtoUULv4VvgV0/GqDgfuyZByC1aO8MJDoYEXUhieyPJhDWPnPuQAy
 N1WGlBs1ZFtWbgUQ2FgDv8zmvqbpFpsl/+oDgyndn8JeoGrQ/MCIr1dPdItngt3tT0F6
 nVudLfox9oMJleexQlVEaBiZtM8qOyn7JnK3BJz+HYM1JVD0I0S3/cL1ZwxSbVSgycQd
 lNQCPmIRuU/KTmDKBUemC5JkEziMMMqWlO2xxOUK9FQc/rgVScvxRctujaTvkm3vyfTN
 SOSg==
X-Gm-Message-State: AOJu0YxbTzFQJDdGf4JA6oVRccBSujv4tVuet5REsZ54Ng/99FrwmcxV
 zoegGYk1BqWfnHRCJKIyTJ42/g==
X-Google-Smtp-Source: AGHT+IEYulVHaMUWa6MPLICq7OzkSAcC7GqDm6bsgYiZVYou3fX8LyXUeZ6yIasOHVry+/z1hH6aFA==
X-Received: by 2002:a17:903:260c:b0:1c4:4251:68b3 with SMTP id
 jd12-20020a170903260c00b001c4425168b3mr2916924plb.54.1696446070293; 
 Wed, 04 Oct 2023 12:01:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 g20-20020a170902c39400b001c452f827casm4074779plg.257.2023.10.04.12.01.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 12:01:09 -0700 (PDT)
Message-ID: <bd21c124-3f0b-6935-4526-abc6a742753e@linaro.org>
Date: Wed, 4 Oct 2023 12:01:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 00/16] (few more) Steps towards enabling -Wshadow
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20231004120019.93101-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231004120019.93101-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
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

On 10/4/23 05:00, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (16):
>    hw/audio/soundhw: Clean up global variable shadowing
>    hw/ide/ahci: Clean up local variable shadowing
>    net/net: Clean up global variable shadowing
>    os-posix: Clean up global variable shadowing
>    plugins/loader: Clean up global variable shadowing
>    qemu-img: Clean up global variable shadowing
>    qemu-io: Clean up global variable shadowing
>    qom/object_interfaces: Clean up global variable shadowing
>    semihosting: Clean up global variable shadowing
>    ui/cocoa: Clean up global variable shadowing
>    util/cutils: Clean up global variable shadowing in
>      get_relocated_path()
>    util/guest-random: Clean up global variable shadowing
>    semihosting/arm-compat: Clean up local variable shadowing
>    softmmu/vl: Clean up global variable shadowing
>    sysemu/tpm: Clean up global variable shadowing
>    trace/control: Clean up global variable shadowing

Series:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

