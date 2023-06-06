Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1941072482C
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 17:47:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6YtI-0004IM-EN; Tue, 06 Jun 2023 11:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6YtD-0004HI-2a
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:46:31 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6YtA-0002F3-AR
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:46:30 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-65299178ac5so5930013b3a.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 08:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686066387; x=1688658387;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gO3k2yWVPd76GH7s5bSs3qhqCe9rRBKy30yFaIxoClM=;
 b=ZiSJOlhIYY/QXd6Dh21c/lC6W7Mwe0hvBQLyRlN5aMMGJMd9E7or9Y4wBfU5vdiPnL
 Xo/IA+ybdrpXZgoJsRUd+1lgk+6Rjz9mK1mMbpSiAVq8LsasgbqPdUyEG0R0FrK4BdsJ
 p3UtMlykusqlE8lI/hWHPrqg0zORj6e3J5TAOBhDZFEakQ0wb7aY6JviX4NUESi9+l/X
 fbY9PPY7DJSTcCniO2GNrGtEtz289LCqNArIvmHeZp4PZ2IQnenPNVU+sY7BSSm5Y+HF
 3S8uOJZILc+xYac7Rm2D4xvIvbDMU41zG51KE1yqx9Vw39eYeJ08YJIsaBZwl3FV3wo6
 XcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686066387; x=1688658387;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gO3k2yWVPd76GH7s5bSs3qhqCe9rRBKy30yFaIxoClM=;
 b=Qyqe0pNdserM1SIw7DrGw2s8SFFLnCKcAbmXC2oiGCOxLZbqzvzd1B7bwiUVYRhRuX
 KnBn4glqOHnfOAgzBGnWgtnV4Si6hbXNyrVX0cBiL0hbsQTe/VOv5/0Ej7GAwWegErWq
 ivMDl+n5BDQ2W+Q+edgfWIu/bZdpka86X2LD0cUOU/AxMQUVP2IIZcne/KuKxZ4OAFSx
 BuSlPsAnT/HcHt6paQG1EeV3vZLg3XbLJm4hEfdIQvGil4rlD3WUDhvV3JoPwY31MIKW
 or64kmod7KxPIyqd3oeRPkBghaeJCNe5CNkQsH8bZ4p2UNM9Th/4+R7ZcbPCetPlYDU+
 EB7w==
X-Gm-Message-State: AC+VfDw+gACS5kF7TdcNWENK6S4e456D45dZPZ52ggjeuQnHPm0w8z5H
 YA5JmdTQMb2r8nqt3S2RtbJK2w==
X-Google-Smtp-Source: ACHHUZ7tY58/YwCk212TGumOHSbsMRG/0wdS9RjyrT5yll1tMV3KspcYFEuShcbeujOLtOtYFejkHQ==
X-Received: by 2002:a05:6a00:1250:b0:659:7d45:a52c with SMTP id
 u16-20020a056a00125000b006597d45a52cmr2688240pfi.30.1686066386749; 
 Tue, 06 Jun 2023 08:46:26 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b7fa:ce59:1445:805a?
 ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 c10-20020aa781ca000000b0062e0c39977csm7002216pfn.139.2023.06.06.08.46.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 08:46:26 -0700 (PDT)
Message-ID: <108e21f8-94c1-e52d-8027-00150b6f0207@linaro.org>
Date: Tue, 6 Jun 2023 08:46:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/18] s390x and misc patches
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20230606055621.523175-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230606055621.523175-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/5/23 22:56, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit 848a6caa88b9f082c89c9b41afa975761262981d:
> 
>    Merge tag 'migration-20230602-pull-request' of https://gitlab.com/juan.quintela/qemu into staging (2023-06-02 17:33:29 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2023-06-06
> 
> for you to fetch changes up to 1fb9bdaf59719c0d0c28043e58c8e3452fd6d7de:
> 
>    linux-user: Emulate /proc/cpuinfo on s390x (2023-06-05 20:48:34 +0200)
> 
> ----------------------------------------------------------------
> * Fix emulated LCCB, LOCFHR, MXDB and MXDBR s390x instructions
> * Fix the malta machine on s390x (big endian) hosts
> * Emulate /proc/cpuinfo on s390x
> * Remove pointless QOM casts
> * Improve the inclusion logic for libkeyutils and ipmi-bt-test in meson.build

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~



