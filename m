Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B5876EF4C
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 18:23:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRb5P-0007D9-T1; Thu, 03 Aug 2023 12:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRb5N-0007CF-6C
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:22:01 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRb5L-0000Ub-4P
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:22:00 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-686ba29ccb1so803095b3a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 09:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691079717; x=1691684517;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p+ujLplyfnerRqkgD47m9pq/1FjJ3XwTIi2q2Snz4IE=;
 b=Fm7BPaF+1A78dBCCD2ZJyHg0NoBoh35CkWH+24REjdIzuDxccyj42C81sQfKb92ckr
 G/aW8DPeceO0yKZDxjjl1Out5X9UMk+gZ/XzroFmNYrB/9x2jHQPFXs5l5kfZr7du2YN
 0/QWwt6frIKTNEOqweTstE/YV2+MWYKlXliEj8/UfIlfYls9hbywd5gjDlvSVpHZjOQX
 B0E+B6hWTZC2N2ZSrzRld5+4EgaprnwY/itfjy9baxcZgepheYgLc1YetMCtU58tP7SL
 eHaBondzL8N0B6TRmofBlzR1cP0PAUE08HznhUqakdCZD5XpKYxBxAVIt3vEffj0wcGB
 s42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691079717; x=1691684517;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p+ujLplyfnerRqkgD47m9pq/1FjJ3XwTIi2q2Snz4IE=;
 b=Z90XrLDw/Ou1V0JzguVNWDbAhPiUbq4fynbcVY7XixUWTuyzFQ0oEvRxsq+E3/E2+y
 2lKu5/UUJjGfy2JHCBsHD71Ylt4FQQTClcKiPP4oweC1hMDcN3lsIpoq1z42tKY8KapJ
 eIWA4euyNBc77YAy1bJg65u45OCOC/tybDgskQBPv610jZ9T4QHyd9HjjSVaJPMWHSBs
 D/2+zOVMhqRp9PsqStCoTEoEdHivpYONo7PVUtx1MUOqNWCTv+JDUFWH5DmEMiq0oex+
 DzxvasFHhiUBOjPiAXK/Ykczaq9RGn8IO2lEfNhLXQvo/uYu1qaznIHefY5hzpiAV6Sf
 O5UA==
X-Gm-Message-State: ABy/qLbyWrgt9BBpKGlVhETHmFClaVazFbYVP5B/Kjk0U9Yv7edvwWNu
 C0F3Jp8s5K85IQ1y4ekJtlhJmg==
X-Google-Smtp-Source: APBJJlFPuJGuTooNcKteHQ8gEjQSq3ZACdon1IeXKHCJMXdXa0mbNDgYRNZk6jGDdVRyikrMFars6g==
X-Received: by 2002:a05:6a20:7349:b0:13f:13cb:bc50 with SMTP id
 v9-20020a056a20734900b0013f13cbbc50mr5966988pzc.25.1691079717353; 
 Thu, 03 Aug 2023 09:21:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.144.105])
 by smtp.gmail.com with ESMTPSA id
 h14-20020aa786ce000000b006875df47743sm51772pfo.156.2023.08.03.09.21.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 09:21:56 -0700 (PDT)
Message-ID: <104e8420-cfc0-96a9-dc62-36a95c30485b@linaro.org>
Date: Thu, 3 Aug 2023 09:21:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/9] Fixes for 8.1-rc3
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230803110932.341091-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230803110932.341091-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 8/3/23 04:09, Thomas Huth wrote:
> The following changes since commit fb695ae3fdfe34ce7bf2eaa4595d48ca809c8841:
> 
>    Merge tag 'pull-qapi-2023-08-02' of https://repo.or.cz/qemu/armbru into staging (2023-08-02 06:51:53 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2023-08-03
> 
> for you to fetch changes up to f54ba56dad0e9cea275e9802915a293f1a8c7d22:
> 
>    gitlab: disable FF_SCRIPT_SECTIONS on msys jobs (2023-08-03 13:04:48 +0200)
> 
> ----------------------------------------------------------------
> * Fix timeout problems in the MSYS Gitlab CI jobs
> * Fix a problem when compiling with Clang on Windows

Nice: msys2-64bit finished in 63 minutes.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


