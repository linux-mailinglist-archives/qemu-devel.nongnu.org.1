Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1E1777CA5
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7tT-0000xG-Kj; Thu, 10 Aug 2023 11:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU7tR-0000py-IV
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:48:09 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU7tO-0005tc-4N
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:48:09 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-56dd683e9b3so588114eaf.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691682484; x=1692287284;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J/Ucxb3WSoVPLf997Na58DsmtEvlKSQcrIx6PUuqvrY=;
 b=CSfEc8o1yWzFFidn/JW8AKYIUn5Bqlj9kYzEiAh3kUHXBnY1jRAVVDdMBc5H7NrvTC
 SYMCrvnUnPVtS4xUzSD5uDk27K5P827oExuN1NPXDlWno48q58KNKjdXJV13/y5sBYe2
 isDxBv+O9XlF3LUpqWLcecEy9fU6HSwZhMdMAHUZTXcQ+I6BSpl0c2nmIqACgTod3RaK
 66ZJ3V8Ov1Y5dO7WFqHy72u4fszMmtB+yPz/1jC4lFiRVXSmNWycRvpZghVhI5hiQmb8
 3oMcQZgtYRP/IUyIonRu+CF3t9KeVx6lQMAEFtrJdZFVRHfaBGQJ08q+ei+DAxDCJ+5a
 ghDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691682484; x=1692287284;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J/Ucxb3WSoVPLf997Na58DsmtEvlKSQcrIx6PUuqvrY=;
 b=YHTlYG17VIUSkhbYXeUh6cl08TbtYQjEtuDgZZXJYApd9OCh6vACdfyp0o6aOOXJSX
 89XIE00aBax/0Ax85VmGNfAqmWIBwsCLGN+USOVcLM+UhK1x9pLqWdG/blkfo7RmCbPc
 aeLxqCT/iJ9wFfeB+mWt0TkXrlxmhb7K/yHwUJiktG6fZ4kFbH1MIYo9IRVCLuDu7KBD
 eZte2vJlEtNNVVzs4kZHdmWHGrbk6jiK0eP1nBzWwR2zvbXa4pQyDHg4AEJmDYhJfKaF
 Ie3CIEZ03ar8hcjfeAljVAixe2YxR0p2TwWrb24f31WhCBmihVp3jsnf07CyqFO2NTXb
 u5iA==
X-Gm-Message-State: AOJu0YyXJfyPrNmQlP9sbNBdbSgVvHWtf/yHgC+xOrsqYWwURI1Izg4m
 fGKfbNGIjuvmLDmIlBVATgPcT0mw8tQaZNoyaU4=
X-Google-Smtp-Source: AGHT+IEVJmw7bQFZ5nYjTCaMh/iRwLzuyEeJWZ5wpZcDyAjEetzu+xQQTlDj0jT+Al3niWerqqpl1Q==
X-Received: by 2002:a05:6358:52d3:b0:139:55de:329 with SMTP id
 z19-20020a05635852d300b0013955de0329mr2126871rwz.27.1691682484670; 
 Thu, 10 Aug 2023 08:48:04 -0700 (PDT)
Received: from [192.168.69.115] (tre93-h02-176-184-7-255.dsl.sta.abo.bbox.fr.
 [176.184.7.255]) by smtp.gmail.com with ESMTPSA id
 f19-20020ac84993000000b004053bcffe49sm576958qtq.9.2023.08.10.08.48.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 08:48:04 -0700 (PDT)
Message-ID: <c2bc8d1a-87e0-4e7d-e4e2-99021b633da4@linaro.org>
Date: Thu, 10 Aug 2023 17:47:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 5/8] tests/tcg: clean-up gdb confirm/pagination settings
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Yonggang Luo
 <luoyonggang@gmail.com>, Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
 <20230810153640.1879717-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230810153640.1879717-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=philmd@linaro.org; helo=mail-oo1-xc2e.google.com
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

On 10/8/23 17:36, Alex Bennée wrote:
> We can do this all in the run-test.py script so remove the extraneous
> bits from the individual tests which got copied from the original
> non-CI gdb tests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/guest-debug/run-test.py                         | 2 ++
>   tests/tcg/aarch64/gdbstub/test-sve-ioctl.py           | 3 ---
>   tests/tcg/aarch64/gdbstub/test-sve.py                 | 3 ---
>   tests/tcg/multiarch/gdbstub/memory.py                 | 3 ---
>   tests/tcg/multiarch/gdbstub/sha1.py                   | 4 ----
>   tests/tcg/multiarch/gdbstub/test-proc-mappings.py     | 4 ----
>   tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py   | 4 ----
>   tests/tcg/multiarch/gdbstub/test-thread-breakpoint.py | 4 ----
>   tests/tcg/s390x/gdbstub/test-signals-s390x.py         | 4 ----
>   tests/tcg/s390x/gdbstub/test-svc.py                   | 4 ----
>   10 files changed, 2 insertions(+), 33 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


