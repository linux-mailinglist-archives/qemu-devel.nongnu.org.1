Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B32FA7266AF
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 19:05:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wZO-0005SR-Tl; Wed, 07 Jun 2023 13:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6wZC-0005SJ-B9
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:03:26 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6wZ8-0002v2-6V
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 13:03:23 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1b01bd7093aso39061125ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 10:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686157399; x=1688749399;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mt0XBzjpnw2hpauC2g4RPo2zk+bXG3YSabLGrU7/d/0=;
 b=nk68ZmPUCQ78cQwFgbMB9WGYHwYdvdhpNBooGKJTXXywFR6cdz5QzsXFD+QU8RNy1M
 QZGmFGT/7gMdrAK7/0F2/6GRu5Bu6/hEA5SfnevUWd0LMl7/xnjv6PINR4YAALkpbUwa
 HU2Je9l1Ix/rTyp1hwd3gXOe0jRTteFerIl89NRv1L29+u/sknsbRcSrwM2jkYFza92y
 PrWhLdAhtrCR0uYv55Pb4Hlyp2/wq9U2ELD94r9pi5PR4JEAGpWohjN32oLRPjOYDbzh
 K7o6xH+9DfestX/tA8IMEGok2efJrTwnNcHN9ErqW7HBMNRJ2GiQ0U5cLrN7RNwwWt3Z
 2+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686157399; x=1688749399;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mt0XBzjpnw2hpauC2g4RPo2zk+bXG3YSabLGrU7/d/0=;
 b=coBIZbMofZ/pbJMwZORC1Dkwxd4fQVj6CPrK3BMvXCRfWoW/SfrenxdqwGCKc0Vuaf
 3JWLp74NoIETocNfXos3wvW2Ccd4EIAodoOUH+cpaozbJlcbflD/EcM5HkWUJcMXPI6A
 YIjwmrkhCADoDfHEExB0mbcmUTJEgqqL+frd+wm+NbWxj1bwbuKVyMwu8UpaHW9lYGy8
 CM3JE6Q6vYF29u+yuiL+wVWRJIjpOQvDg4pnBubRpxOpKnbXYvsKcnSNSCUU/8uWqRma
 kWiYUVw+YnCNBXl6G0XAE6LkF6WfYCekc/JQUcz4y0+2kt60/40sPegpHt7cFQiK7Y5K
 UPkQ==
X-Gm-Message-State: AC+VfDx3nKpFChTcTDbG9/G0VSIaqusCu7YPAt3rJnRq/aQX03DYala8
 9pPu2kZvTY5agtfPFl6xrZ4EuWGQslBMPZnt5/4=
X-Google-Smtp-Source: ACHHUZ4SYTnmuxCSJyRT5PM1vPNE4IfxukedHupRTM6d3TuflaqeiZxwqFZ9s8fgYdwGSycjL2M0gw==
X-Received: by 2002:a17:902:ea11:b0:1b2:e0c:a408 with SMTP id
 s17-20020a170902ea1100b001b20e0ca408mr3721745plg.31.1686157398752; 
 Wed, 07 Jun 2023 10:03:18 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:f25d:ffb3:64e4:8ded?
 ([2602:ae:1598:4c01:f25d:ffb3:64e4:8ded])
 by smtp.gmail.com with ESMTPSA id
 d7-20020a170902cec700b001b05e96d859sm10641516plg.135.2023.06.07.10.03.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 10:03:18 -0700 (PDT)
Message-ID: <49faeaba-3d7e-6d0f-5dae-469462b8319f@linaro.org>
Date: Wed, 7 Jun 2023 10:03:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/5] misc ci fixes
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230607154054.625513-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20230607154054.625513-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 6/7/23 08:40, Richard Henderson wrote:
> The following changes since commit f5e6786de4815751b0a3d2235c760361f228ea48:
> 
>    Merge tag 'pull-target-arm-20230606' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-06-06 12:11:34 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-ci-20230607
> 
> for you to fetch changes up to dcc28ab603f30df5cc8be1f759b423e94ae7d10f:
> 
>    iotests: fix 194: filter out racy postcopy-active event (2023-06-07 08:36:55 -0700)
> 
> ----------------------------------------------------------------
> Fix TCI regressions vs Int128
> Fix Arm build vs --disable-tcg
> Fix iotest 194.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~



