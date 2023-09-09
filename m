Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E795B799C09
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 01:30:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf7Od-0000mQ-MZ; Sat, 09 Sep 2023 19:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf7Ob-0000mD-Sd
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 19:29:45 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf7OZ-0007yC-La
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 19:29:45 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c328b53aeaso27986775ad.2
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 16:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694302181; x=1694906981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8hpk6Vv6gEk/esh7ofxD7YQWCy3eBDdkfxemfWNFEbQ=;
 b=pusRMF5yp5kJkDH+nFcaG0SwrSBAH9tDa5PkgT5IQusqGIbTq5sJZkgTjF1wr4mBNY
 85gG9cDXHHJiZcWYqwELZXVgjmkrGCKaUhNnNfjeQAW9YXgManK+nWqW40MgrG5DkcUW
 8bk66nBjmXRAMPWUPsKsiDieoYPVxKWJSM8Oy1639u9qiRiY2RLojKu2Ul1DrbMuuJ8w
 2ScuqPYPRlTRtOJmZksHaGxBDY+T865knzwme3yBqc8plqN3YBn3nhEYeRPmIPieC2B4
 INwg9YiF6evOUjWv/S/nBREcnEypswYIAZ7tttXRDpMGliR5xM0wQmVPeykK8Tp9LBUv
 ugtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694302181; x=1694906981;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8hpk6Vv6gEk/esh7ofxD7YQWCy3eBDdkfxemfWNFEbQ=;
 b=bL3m2JPaqoQiNb/Etyd/RuGiYvAom2rEq5RklAXEAGmoRbTbhf5rlt51ydKeuvTrJe
 zy0GcKfGwPBeiH05wU/TBOlLfpGv0UHyJZPHkyoPBTYDXpoZd+4PUI1E6RK/D1yzheM1
 AJeOu7RhAUMIsyV24BibTaWiSyVOKl65KrGvx24yIobjLsasHfpzcnLv8KvQ1bv1kaDk
 jQ1HPvABDa0SM15fy4ONGvStvGhr4prn75amTic1YX+lP1VQzYTtETpwZTNB1srthJKh
 jfhcb3/1LvP+9Rh5HiQ5dtYGfXCRmg4gIMoAW1Hr/CNLKhU/1/D0SldvzCfVw4GIl4TV
 tShQ==
X-Gm-Message-State: AOJu0Yw+EMUB8pTy+M0qXZoczlWxKCHnWj8ZaokI7y11BXQk1J/okhcp
 rMXyScHp7Nis/oSlmabRyMAaow==
X-Google-Smtp-Source: AGHT+IE+CzCL2tKNeddi4iNPtB2WSxGo9DCRACwneV514HJXWis5oBWL3EUep7gudA6Hoocv3EYWOg==
X-Received: by 2002:a17:902:c081:b0:1bc:422a:b9fd with SMTP id
 j1-20020a170902c08100b001bc422ab9fdmr6744555pld.13.1694302180899; 
 Sat, 09 Sep 2023 16:29:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a170903230b00b001bb99ea5d02sm3744234plh.4.2023.09.09.16.29.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 16:29:40 -0700 (PDT)
Message-ID: <b89e3e47-f4a5-735f-010b-6cd6e333e032@linaro.org>
Date: Sat, 9 Sep 2023 16:29:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 01/13] hw/i386/pc: Include missing 'sysemu/tcg.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230904124325.79040-1-philmd@linaro.org>
 <20230904124325.79040-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230904124325.79040-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/4/23 05:43, Philippe Mathieu-Daudé wrote:
> Since commit 6f529b7534 ("target/i386: move FERR handling
> to target/i386") pc_q35_init() calls tcg_enabled() which
> is declared in "sysemu/tcg.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/i386/pc_q35.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

