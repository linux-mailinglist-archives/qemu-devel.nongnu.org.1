Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD087777E35
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:27:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU8Uw-00007n-Ex; Thu, 10 Aug 2023 12:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU8Uv-00007B-8R
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:26:53 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU8Us-0005fj-O9
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:26:53 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-56401f1da3dso753402a12.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 09:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691684809; x=1692289609;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=px4jMCORn8BkTnGqbwmcdQPd6+jq/StZOLagI2oIQ6g=;
 b=g67sP9whDCA1vrgY2/P/A0GabJVA4ISYYoogp/kUSnW5XTYDA7jUg+o3lUzhrGAv59
 iovEGUXoa9eY+JGhYr1FhkbZ198hI43R9diAXcYEQtXSLu0O65gJVAaic+mBjAclK50t
 8vYGkCOCUZkrmiXP282P1qNp43zZ1ZjUvqAxVp6V+qmGb+hAZqhzXFsCrHExfIRdghbp
 K91NAZJkN78xXfFNkTKus9I0QpRqenKIhrYVlF1nt4sj+kKECJcxy36wB0iH0a5+TMfm
 qcsf0krOvZ0CSL+sggUD1bKFijuJs1hSubzUcv4OtkwlGqvv7H9NwHUUBWQkKqVO4Ag/
 RCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691684809; x=1692289609;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=px4jMCORn8BkTnGqbwmcdQPd6+jq/StZOLagI2oIQ6g=;
 b=bUtKC0PvWutuY3Bt/wLrvQrMYStaasgGOAMd84tMWoavRa21WD79LGtJ2CbIOLLbBq
 kfLS7dSxy7QFxaB2pihp9Lg/J943+9f3Be80ajmaxrF6VbG/hBXvlh7WoAOxfr2+16Gx
 OHh6oDwplUdSbFEkTl4Wtxx67LRm/jq/o50RBD+WQLAkpBo69285izWdw7V5f5fq9RW6
 +zObhHTZPzo7IcuN9jDcnRB3pS3e9ugO5NIJY7qh31vzx6r35ay1SvEiF4/mZ0/XnC4+
 ZP3/H3YiLe3XzCyhfDf5nXIvFDu3wEHXehM8yX5Bfc66pT5/LK37RpKLd3XQg0wSc5Wl
 ERXA==
X-Gm-Message-State: AOJu0YzGg+kgZ9kZzf0UZ+pRG0IX/nHFKhiiLsyVgAtxn9o5ymEeeyif
 JinKZgOOn82F7nIATmJ0qdFSvw==
X-Google-Smtp-Source: AGHT+IEcKIVYgPm/YHDHpCTz19NMa0Y8hxmBQOrDAG9CU8MhoDKTAl71gw+b522eJ1nUtp9/Tv2mDA==
X-Received: by 2002:a17:90a:a88b:b0:263:e133:b9c9 with SMTP id
 h11-20020a17090aa88b00b00263e133b9c9mr2396592pjq.34.1691684809096; 
 Thu, 10 Aug 2023 09:26:49 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:9e4d:b830:d4fd:9164?
 ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a17090a898a00b00263fc1ef1aasm3565912pjn.10.2023.08.10.09.26.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 09:26:48 -0700 (PDT)
Message-ID: <ea1034db-68b6-8644-7fc0-309596ede0e1@linaro.org>
Date: Thu, 10 Aug 2023 09:26:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 7/8] gdbstub: more fixes for client Ctrl-C handling
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Yonggang Luo
 <luoyonggang@gmail.com>, Beraldo Leal <bleal@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
 <20230810153640.1879717-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230810153640.1879717-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
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

On 8/10/23 08:36, Alex Bennée wrote:
> The original fix caused problems with spurious characters on other
> system emulation. So:
> 
>    - instead of spamming output make the warning a trace point
>    - ensure we only allow a stop reply if it was 0x3
> 
> Suggested-by: Matheus Tavares Bernardino<quic_mathbern@quicinc.com>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> Message-Id:<456ed3318421dd7946bdfb5ceda7e05332da368c.1690910333.git.quic_mathbern@quicinc.com>
> ---
>   gdbstub/gdbstub.c    | 5 +++--
>   gdbstub/trace-events | 1 +
>   2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Richard Henderson <richard.henderson@linaro.org>


r~

