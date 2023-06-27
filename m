Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7716F73F87F
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:16:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4nZ-0006h5-LG; Tue, 27 Jun 2023 05:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4nX-0006g5-UG
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:15:43 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4nW-0003yq-5y
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:15:43 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51cb40f13f6so4859801a12.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 02:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687857340; x=1690449340;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PFEd0zhrwYJY7qCIxDXMJcmoXEcNEU+QEtWwXoKDZf8=;
 b=WrKzNketQrc4ShUapLFxABJXYpwpTH15OOyr0vrVnjH34nUeRse+alWey/SARBhj7U
 zh7h8n/qJplcf9RBqVSjRk+1iuVVcR111bffQxFHyzpZW0RkkxZQ1Pit58LRSYgU18D0
 JVEYw3/r4BB8+ymmp3lLv1GCWlezC41bs31ZiRn2iMdOw5s3D/8R5VDk6yriGlZRtrPT
 +N90yqxFLDBvKJSTbijsJKWF0jlV1ygCI9WRBOgVRvQXVLWTvr5OldB4otoUSZsIy+SN
 DF578y9uOCWuOw8uktsNGSUuKk69a4XXhc+rU+5AddzLNJZTnJVYb1qyW1T2B4Tlmejq
 +xeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687857340; x=1690449340;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PFEd0zhrwYJY7qCIxDXMJcmoXEcNEU+QEtWwXoKDZf8=;
 b=Z8iGWp13mQVwVq9edTtslUlxL0lUAsxdMPLyUmaLxrJ+cxxNEJO8/VIFRbLZZ+llgv
 bi7UPzBB3+SZUocGGM9ZFilie66rhXi0ndIItk4wqpcaZyqSmOgNMq1OxyDUI1lVBBOb
 LfVfnIvkBneNrlFTSnN85M4r8CXjUFL4y8m8kUntfUoWzeH904KdKyukNQ4Ncq1W9X28
 c4f0zK4hQorB3WQ4pXT/6doEU4l2oOzfLSVdj1s1LLVy2IMipAOr+MOCySk/IWciUjOf
 BY4M6kpPsRscCqI36Bu/0HbWXu/0ZUUx/ZInoB6zeOVuUCfftrYR9mYWwcuVMo96z2jF
 i3qg==
X-Gm-Message-State: AC+VfDwyhCesRDe8UKxva0kiAXsRM0ahcywFqzSfb7stdAfsz9WT4w2C
 yHLMNBblyTFyX5RW2Z2kVcLHTA==
X-Google-Smtp-Source: ACHHUZ7/YooOJwyl4P4Xqz4F46rV90OT7pmPOJGBIz0vpGg7m6o5CKNEIp69GhuK61MckyE3zjbFgQ==
X-Received: by 2002:aa7:ce01:0:b0:51b:c82a:e10a with SMTP id
 d1-20020aa7ce01000000b0051bc82ae10amr15963859edv.33.1687857340705; 
 Tue, 27 Jun 2023 02:15:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 z24-20020aa7cf98000000b0051bfcd3c4desm3560891edx.19.2023.06.27.02.15.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 02:15:40 -0700 (PDT)
Message-ID: <213a2dbd-d5e6-6454-e8f1-888f08294ef4@linaro.org>
Date: Tue, 27 Jun 2023 11:15:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/4] pc-bios/s390-ccw: Fix indentation in start.S
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 mrezanin@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20230627074703.99608-1-thuth@redhat.com>
 <20230627074703.99608-2-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230627074703.99608-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 27/6/23 09:47, Thomas Huth wrote:
> start.S is currently indented with a mixture of spaces and tabs, which
> is quite ugly. QEMU coding style says indentation should be 4 spaces,
> and this is also what we are using in the assembler files in the
> tests/tcg/s390x/ folder already, so let's adjust start.S accordingly.
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/s390-ccw/start.S | 136 +++++++++++++++++++--------------------
>   1 file changed, 68 insertions(+), 68 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


