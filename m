Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE05A777ECE
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 19:09:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU99q-0003a3-Ik; Thu, 10 Aug 2023 13:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU99m-0003Z9-Dd
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:09:06 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU99j-0006cy-Jv
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:09:06 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bda00e7543so5742025ad.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 10:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691687342; x=1692292142;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w0uPLphW8LC/jvwJiZeCt7jQpI3ur+tbnXpH6rkpk2Y=;
 b=Z/ENrknFJocR0dvbDvKWkcziIg1JB6x4e7av5lIq/X2tWuOmI3WcAD2JS/vOmIMkEb
 oT4Rrs/nphVo9EJ4AOrh0yY0N2lEqAuZ3euGp7enRqh9SoJrYHFbzxYy3cYE5qosC+fy
 BRXZu95VS/tklPaq8D2BadbhmAqzrK+gB4mh+1iELmBbNRFNgnUKRzX9nkUglQc4zAWz
 hd+5yzNIiNmVm2FOsX+Lc0ZvVL8REI8iqqaBaRJnrG4hY0NrNN6OXrkMvLahzfBLOCgP
 rtNUUBABy1TPSZjUKYGdZqlC+NhsgrmEjfcz1KgYhKHzrLiBccDsoXT4qzb4+ZK3vE/s
 3bYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691687342; x=1692292142;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w0uPLphW8LC/jvwJiZeCt7jQpI3ur+tbnXpH6rkpk2Y=;
 b=M21KioOx6Swdw/RJ2cjcEJS1ENCmOboedwIOEEHofwVkHqZ0xepJxpVmFqBsVawPcl
 wdg1iGZnb/I1xku95aFUAOauYBhT0z666dJQWq2hOwI2n5/JKwyQ/I0rAKIsKT9LeTp4
 bkeyHtPAoRfO8lF8SPkg10WEIU17DCF09QVg+oB/dayF20vF5M9LZjUK+mjlVXyj1Qto
 guCjmDrAhIHinLACSqVC6lE97Vylnk5JOUydkI/hUki4aS8F3d6Kr+TYEETx1DJxMeEu
 ZVEXGOaQ2rYPWTiRHybPZ/ie8j+1tB0QhngI+p8EDm+RAgf38u2CSYlMjI6Qmv/vH/4r
 PaMw==
X-Gm-Message-State: AOJu0YzJY2u5991CsL9lt+Ba1fD+EuoS45eaZaSqUb0e4926E6YC0ZiT
 vdbPxc8IENf22jXekTw/4mQtTQ==
X-Google-Smtp-Source: AGHT+IHRf/FfJnHOqqu9i/EMEAMRJTwwTS6SMvefJlZwP/N6o2W/7Kfx9ONIFhA+pZ49wZW4DPo2Kg==
X-Received: by 2002:a17:903:44c:b0:1bc:6e8c:eef9 with SMTP id
 iw12-20020a170903044c00b001bc6e8ceef9mr2001201plb.51.1691687341756; 
 Thu, 10 Aug 2023 10:09:01 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:9e4d:b830:d4fd:9164?
 ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a1709026ac400b001b8062c1db3sm2021363plt.82.2023.08.10.10.09.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 10:09:01 -0700 (PDT)
Message-ID: <ae63cc47-9a7e-1b89-f412-4b3d470b79d2@linaro.org>
Date: Thu, 10 Aug 2023 10:08:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/8] tests/tcg: clean-up gdb confirm/pagination settings
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Yonggang Luo
 <luoyonggang@gmail.com>, Beraldo Leal <bleal@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
 <20230810153640.1879717-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230810153640.1879717-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
> We can do this all in the run-test.py script so remove the extraneous
> bits from the individual tests which got copied from the original
> non-CI gdb tests.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

