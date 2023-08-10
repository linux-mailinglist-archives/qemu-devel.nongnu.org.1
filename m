Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEF4777CAD
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:50:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7vP-0003eW-Fl; Thu, 10 Aug 2023 11:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU7vN-0003ad-45
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:50:09 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU7vL-0006If-Kn
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:50:08 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fe4b45a336so9349275e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691682606; x=1692287406;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bzWRg9t3NBeGgqD2frdxXgTFnImdvBvy/pZ8Bw5TM0Q=;
 b=YUPmdPy0avWTCLsih53YzXQ2G1REDZ5Dc3mL3EkCUcWOApcVO/tSU6Pe8xeA/Ou1rw
 uSA5cAfD0SXznfjMarb/GHFDrNuIOis9LPUa7hMuM4n7+7cTyg2Hkp4KrXgtPz0NVHU4
 FKt0O4Rf0RIrJnz8aWgQVTXtg0wQO8IwpvylxGrItVci1FngJ5gjKXk4GkYDTi5cMZbI
 zLPbOETCcJULjJiPT/2ZBSWRCPNk+gwUZf9i3vo5WJMwT93o7N2+UAyI+b5B8wWNtQUW
 8IuG4uT44dJDp3SIHfoQJ/l2hg785MJiUHSIrek2hTvVSCojVJMCWahptRRPeWYDZUQm
 OkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691682606; x=1692287406;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bzWRg9t3NBeGgqD2frdxXgTFnImdvBvy/pZ8Bw5TM0Q=;
 b=LOrwB+1WkjTXoLyNrUVtluwjIVdHc2KklZR7QQVF9I1jcKU4x89Hf4gFdCbDcPTAhF
 PfRaDk8umrV/3+qU/iXzLi2bB3nP6iW9iC+iFOZgEwPnFf9gaoALClZsp4ytoNLd+SVL
 VE53sPsrHo3lj3DZBcmOCrkQuGNua/GD9dCnxi3b7p5urNx975Tg1DA/Eq34fizH7pJ3
 i56FSrMMQ30DOBKCVojCT+uiplerq+OQfxXtDg+trM98I8Mvn81FWMvtL4rNd9jOa+MK
 fVBnbQ/HkSGJKBJtQ+S7M9YW3KVWIv22gLdqPohfWfLpLckUVM7ZBuxWPi3cLZu2KT1L
 bsDg==
X-Gm-Message-State: AOJu0YznpXWgNtc4vZeNygmmYmnqEaEfIawzBL1AHlSQ2kHd2uQSy4NM
 /ocKxySuVchoyFUuqADwo0DtoA==
X-Google-Smtp-Source: AGHT+IGYKxvfnVLx2tEvZBQWdhrTj0bEbFmZH/mSmzSVoTYms2qQik6dKMN9s0OBWScmyhK/SUb0wA==
X-Received: by 2002:a05:600c:3654:b0:3fb:403d:90c0 with SMTP id
 y20-20020a05600c365400b003fb403d90c0mr2226663wmq.39.1691682605963; 
 Thu, 10 Aug 2023 08:50:05 -0700 (PDT)
Received: from [192.168.69.115] (tre93-h02-176-184-7-255.dsl.sta.abo.bbox.fr.
 [176.184.7.255]) by smtp.gmail.com with ESMTPSA id
 n16-20020a5d6610000000b003179d5aee67sm2543434wru.94.2023.08.10.08.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 08:50:05 -0700 (PDT)
Message-ID: <9816ed3e-28af-508c-62f6-b638827436c4@linaro.org>
Date: Thu, 10 Aug 2023 17:50:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 8/8] gdbstub: don't complain about preemptive ACK chars
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Yonggang Luo
 <luoyonggang@gmail.com>, Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 gdb-patches@sourceware.org
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
 <20230810153640.1879717-9-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230810153640.1879717-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
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

On 10/8/23 17:36, Alex Bennée wrote:
> When starting a remote connection GDB sends an '+':
> 
>    /* Ack any packet which the remote side has already sent.  */
>    remote_serial_write ("+", 1);
> 
> which gets flagged as a garbage character in the gdbstub state
> machine. As gdb does send it out lets be permissive about the handling
> so we can better see real issues.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: gdb-patches@sourceware.org
> ---
>   gdbstub/gdbstub.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


