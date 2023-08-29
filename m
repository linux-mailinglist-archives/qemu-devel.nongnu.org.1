Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F1278D056
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:21:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mu-0000il-Hv; Tue, 29 Aug 2023 19:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb74K-0001ri-MA
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:20:16 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb74I-0007OG-Gx
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:20:16 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6bd0a0a675dso3737592a34.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 15:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693347613; x=1693952413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fcDYCBRXyApVbmj48QtDZB1H18DZIII8FYc8sjUqZMw=;
 b=Ey05HRKzc5vbQ8WEh1a5/BJqXFQLyAlctWEfpY3ou9fMy18DRISCVwx68VL9SbMWLZ
 6C0HfZQ0vxuCccahbtTmGhdXvXGQnXT/e9sDU2SsLxPz6iS2qZXAlaWWOtGcpkOmwrBB
 KR0/dO5pR+HmaJ+zH/KX7nlMB3REUNI+GKOO+hVj+J5JPLQssSMlySgUSuf/SPhVHQCS
 LRHxeNy3yj/9+pWFabXfAWDreanFwUGdOl7hozzB8s0eLOP5J4CMwgo68MwzyIV/Gf7C
 L2/h60x8F1iZnJQn0t+o8gxffKBs2lKpp9QWPgxdrj5rdddAzsLBZwsq+7JarGfNGU4Q
 ELlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693347613; x=1693952413;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fcDYCBRXyApVbmj48QtDZB1H18DZIII8FYc8sjUqZMw=;
 b=Aa7T0E2DncHpKHPIBXDFOc8CpRNI+jVmt2rFR8ie7+8MGUj883kUaITiNfG9DhJWls
 VXWzJumz9cYJjXK9PAzkvrKFGwculcRofHrNHqPIzUmAOOBQzRcZrMR3EMG+5hO9OpTK
 pbxeS9lbNPEG/4s01cJAvoNghK2oot1ZU7HoaiTFk/ebCs4osvlr+sP4LKMo3nVP6aiQ
 IrDpwz+Du+EqdYM+83T4MAxRdiE4JA9z9zxr0hErhaZ6R659PneRwZwOWX6ZBaFE91KJ
 Pgwc0Ohqf5UtCVOLi+6Ij7axCxGBY+y/0eVCMvXYSdkZeCL7PAITRqXFROTTkSa2SDz6
 WAzg==
X-Gm-Message-State: AOJu0Yw47X/qLVprrFFMwoyA5edtC4Pvn/5GpfmzZXdnaLf5iBGVeuAF
 o8rcUAqpAzrskY2VEZZAZVH+hA==
X-Google-Smtp-Source: AGHT+IHo7q5MdU/aZmGQ2Nz0n6lIWOh3yyArhVjK+kmGCJrGtOYN8q2e7JSdk9rhmETlNlos5FJK2Q==
X-Received: by 2002:a05:6358:33a5:b0:129:c9c0:ca64 with SMTP id
 i37-20020a05635833a500b00129c9c0ca64mr286262rwd.15.1693347613117; 
 Tue, 29 Aug 2023 15:20:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a63b04b000000b00565ec002d14sm9451524pgo.33.2023.08.29.15.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 15:20:12 -0700 (PDT)
Message-ID: <12a64f1e-3c3c-ebcc-d50e-4ac0f1fac815@linaro.org>
Date: Tue, 29 Aug 2023 15:20:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 06/12] tests: remove test-gdbstub.py
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20230829161528.2707696-1-alex.bennee@linaro.org>
 <20230829161528.2707696-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230829161528.2707696-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/29/23 09:15, Alex Bennée wrote:
> This isn't directly called by our CI and because it doesn't run via
> our run-test.py script does things slightly differently. Lets remove
> it as we have plenty of working in-tree tests now for various aspects
> of gdbstub.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   tests/guest-debug/test-gdbstub.py | 177 ------------------------------
>   1 file changed, 177 deletions(-)
>   delete mode 100644 tests/guest-debug/test-gdbstub.py

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

