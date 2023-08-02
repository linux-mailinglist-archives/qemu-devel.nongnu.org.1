Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA8576D185
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 17:15:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRDYq-00042J-8e; Wed, 02 Aug 2023 11:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRDYm-0003yN-3S
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:14:48 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRDYk-0002dU-DJ
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:14:47 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-686f25d045cso4814958b3a.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 08:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690989285; x=1691594085;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kGaoQ8WcrcEdpC3FWMnLqFA0oYu2Ng04akJN4jkrEvk=;
 b=jQo1y5XFAaTeHxzptbXZyqmtNe1ch5wtpoHqdfBa+RZL33FtsCLmdSJtQrwx/tdoAY
 12RumCL0ssFHpXL9ho3HqVUudSL0oetfrTgZdqKi+QmRFeW0STlImc6z6+9KrQGv5m4o
 Z9EEZeja2w6E3FYLflXb/04nB4g9med0QndpyBK2zwwo+eDt0b3agxbG8l8ziymfGhO5
 vY2IzB12bkO3YPkrQwT0UnzppBWM0lxWSGjP7/yDp7hO+M3Wvc7RaAWlPmy+EEMIfEHi
 VvWkbtttmqQqVeSjJCtDOlOp1e3F4FVYFcPENWtsODf1Qfbi0NFZB6rOADIjf0Niz0QH
 +fZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690989285; x=1691594085;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kGaoQ8WcrcEdpC3FWMnLqFA0oYu2Ng04akJN4jkrEvk=;
 b=OFwPal8Lw1LtUE2Y5l/aAl8vcYY4OIT7T7ZopyqQysfD1bvMV0GwnERaX/JM/2G7mn
 I8thTBTkVn7u7rZa+jjO751YVQ1XEAiscIH3qhZfHiSEUDRupWnZAjaRUAdx7E8/WLbK
 6PqZY+Qugtu4LiegKkvCK6+0N97vDYP5SF61lH936vq5wMFDILv1D7bPHXI0VeWKNxky
 69bmtFOZwJx3vMo3ygeAVoAE6p4HqOnnR93EQxpqaLMcqKbu718ktp7Im1DD83V3qwZS
 iJrq+3nfPcB+m+JZLqHXjuNqSev7GdDG0I1Jpo4yrdOWlIpFcYVWSAg2v+CO1roaW3WC
 V+2g==
X-Gm-Message-State: ABy/qLa+OMTk2J5twq9ab8nR0m0XSOYfeiPNe2imJnQnvudRKg0OCisV
 sulrBmEGJgcKDZBWgQkXS/2hig==
X-Google-Smtp-Source: APBJJlEXco7V1LFMaxtvxxio01r+otxlD0U1FkExHREG3p5YbYRCb/EGJRdZ+YGB8I3pell8zOUZFQ==
X-Received: by 2002:a05:6a00:2d23:b0:66d:514c:cb33 with SMTP id
 fa35-20020a056a002d2300b0066d514ccb33mr18456125pfb.6.1690989285091; 
 Wed, 02 Aug 2023 08:14:45 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:b659:bbad:1a22:7ef9?
 ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 g7-20020aa78187000000b006828ee9fa69sm2478186pfi.206.2023.08.02.08.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 08:14:44 -0700 (PDT)
Message-ID: <fa9791b4-0a5b-5e74-28a8-7cb31309036b@linaro.org>
Date: Wed, 2 Aug 2023 08:14:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 00/10] Misc fixes for 2023-08-01
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-s390x@nongnu.org
References: <20230801215421.60133-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230801215421.60133-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
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

On 8/1/23 14:54, Philippe Mathieu-Daudé wrote:
> The following changes since commit 802341823f1720511dd5cf53ae40285f7978c61b:
> 
>    Merge tag 'pull-tcg-20230731' ofhttps://gitlab.com/rth7680/qemu  into staging (2023-07-31 14:02:51 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git  tags/misc-fixes-20230801
> 
> for you to fetch changes up to 8caaae7319a5f7ca449900c0e6bfcaed78fa3ae2:
> 
>    target/m68k: Fix semihost lseek offset computation (2023-08-01 23:52:23 +0200)
> 
> ----------------------------------------------------------------
> Misc patches queue
> 
> xen: Fix issues reported by fuzzer / Coverity
> misc: Fix some typos in documentation and comments
> ui/dbus: Build fixes for Clang/win32/!opengl
> linux-user: Semihosting fixes on m68k/nios2
> tests/migration: Disable stack protector when linking without stdlib

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


