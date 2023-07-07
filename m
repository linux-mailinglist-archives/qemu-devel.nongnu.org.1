Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC26D74B8A3
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 23:23:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsuw-0000kJ-88; Fri, 07 Jul 2023 17:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsut-0000jb-VD
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 17:23:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsus-0006aV-6U
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 17:23:03 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbea147034so24835425e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 14:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688764980; x=1691356980;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QBAW4COBGWaR52LpIVaS1yMqEZRYp1UsTrPyK9f4pLw=;
 b=TNllVLPpD9eZW80HLCWTaoMDoiRfQ79wNNKBN7sOySHOWjknYob5MpNLhoc2LjKMhW
 y1VrH5XElmqOJhLXH1Dowi2OkTHQlwPBb8aWbplkCreJxwqozWixL/2PxDEStGXlkU8v
 iNMmfGYfCkYsM2kpIS1Z3hnTNoRgK3IO9ar/yJQEJFmz8sTygwAjrKNoSjU77EIDUdhV
 bs6stSMlz+cODL1cbXhR+SPRGltHrUgmtG/NjzFFLPepsmCw99GLrbbv7XnKT0S/NQlF
 Im14V49BeRe9SCMmhvrN1bzJqAj/gk1lqNhuwg6nbPHpisdovbOtFJphBmF+mnGChlGL
 eeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688764980; x=1691356980;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QBAW4COBGWaR52LpIVaS1yMqEZRYp1UsTrPyK9f4pLw=;
 b=VIuA7Spq1gQALQJK6mLNwAK1cRDBd3KQTdsZcT6hjKPxRhM4/nRZiMBJCRkEjP0tSb
 Y78n5gREMFBUj+hPVfj+aIeRLX/46te2ROp+79WfxEoFhYVM2lCdChlECR+l7gSxptbl
 9i8CapIyFlzvkyBL4j9JdLTgSd5NZRSKcVMI6ad4I7dmImW/TXvKo5wo63kQ5F0JnZu3
 BNImlYH2T4qPDdliAUK/Bmc6DkK55c8gMte/YhL2I4dJNsHG4jSnfUhYJArrlR9LoBup
 Xc9svtOkRybBgqbsih90UkotaOPILvMkHxbiVth+MRmasI5FSuVnu7lpNRI9cnkCUA0S
 8Pmg==
X-Gm-Message-State: ABy/qLbTJcAxGEs7X1o2um6kADsD4U07m7PpZGNcOhTgwKfnIoPl2VxL
 J1xh0/juBhTsjctC8u0iKI86pZPJnBSWigIK30w0Sg==
X-Google-Smtp-Source: APBJJlEMwnc0OyecSq7nhl42jXKBAD6G2zAbdduQw2b5S8PeZzdgpILvkniS09flLOKCsfkVBlHnzw==
X-Received: by 2002:a7b:cbd1:0:b0:3fb:d1c1:9b79 with SMTP id
 n17-20020a7bcbd1000000b003fbd1c19b79mr4698954wmi.30.1688764980660; 
 Fri, 07 Jul 2023 14:23:00 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a05600c218e00b003fa96fe2bd9sm3436624wme.22.2023.07.07.14.23.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 14:23:00 -0700 (PDT)
Message-ID: <f0d3bc47-171a-1817-4452-76c608426f50@linaro.org>
Date: Fri, 7 Jul 2023 22:22:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/9] Final batch of patches for QEMU 8.1 soft freeze
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230707140432.88073-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230707140432.88073-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 7/7/23 15:04, Paolo Bonzini wrote:
> The following changes since commit 97c81ef4b8e203d9620fd46e7eb77004563e3675:
> 
>    Merge tag 'pull-9p-20230706' ofhttps://github.com/cschoenebeck/qemu  into staging (2023-07-06 18:19:42 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to 6d5e9694ef374159072984c0958c3eaab6dd1d52:
> 
>    target/i386: Add new CPU model GraniteRapids (2023-07-07 12:52:27 +0200)
> 
> ----------------------------------------------------------------
> * Granite Rapids CPU model
> * Miscellaneous bugfixes

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


