Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A23777798
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 13:54:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU4FD-00045P-L2; Thu, 10 Aug 2023 07:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU4FB-00042K-I5
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:54:21 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU4FA-000736-1t
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:54:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe4a89e7efso6706625e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 04:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691668458; x=1692273258;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+qoXEr4xTa17bvr7fUrzb3Ii7Mcxx0mOdg7s5ar7Kgg=;
 b=GDcw0VdkaKLj8Gjq6SrsqG1Yeu+i9SQ8VERJe1XPLMEpJcJmH3pySWUCSzoYMlBrp2
 8C+FgwpHAGz5GNfUdcEXmUQfPWiAmaq0LRaU3OuiZPFd1hmve4DMqbtxawKZollQwIHC
 nZEeUJoE1arQIcQVMA+gQzVVRsdH7iAnIEPDjMGt2QfkBT9XoTTHvQrINvkAghmVY6fe
 jKdxtHjb7SaUuMrljixK2FEtUmlpE5ePDsCDCCB4UjN883WjAERqN+YnU+w+YLgrOY0H
 UbQTfIqfxtgNCupDUdLqVwaOYLiC93RlI7C/yhF3RYU3O0TFIdfs4aIYlZRbrbwYgCG9
 5rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691668458; x=1692273258;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+qoXEr4xTa17bvr7fUrzb3Ii7Mcxx0mOdg7s5ar7Kgg=;
 b=J9fMEFlnuSWj0SZFwVWfqGUhjBRJadWFDobyADfvRKA1V2HEFQPuwVZ11UxMw7jRmV
 bpGUAepGqwi/PPHElFwjB+QajWWwcUGQU1oKqv6anuVSLm/nXolsuN/jHN1TKMTxUhOS
 BlQ8KuDqHiAGVrSv7JTWQw/CTRmJxTIPw65WHmYxcYBrjdABQzRei2cP+3CZyxzU6ORA
 KUhgdFMtBxMywV/sojNfrgeWx1GIjY8UyKOrHd79oGPWsoPGAlgWAKH55B4hxJdgUput
 OA/d/ZzTUk8Hn5R3e0K71pqtjQwgrQdP03jYFQ790mWu3qBm3cFsx0RtGd1f4zxAGbrF
 q+bA==
X-Gm-Message-State: AOJu0Yzn3P/b6owxbN9FKaluUHzyuI/0nYZCojgzH70z5WjWiyHTmDML
 Tmo7BXJNkxgb/9hvwl/S3XiN7A==
X-Google-Smtp-Source: AGHT+IGhZ6Td4qLSi1bf7m266u71Y4sB9j76Jza5BZtboxsChWu7Oc5NK0B9NVe/mEKlVzzagHXgeQ==
X-Received: by 2002:a1c:7c1a:0:b0:3f8:fc2a:c7eb with SMTP id
 x26-20020a1c7c1a000000b003f8fc2ac7ebmr1666006wmc.5.1691668458389; 
 Thu, 10 Aug 2023 04:54:18 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.65])
 by smtp.gmail.com with ESMTPSA id
 h9-20020adffd49000000b003176aa612b1sm1990744wrs.38.2023.08.10.04.54.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 04:54:17 -0700 (PDT)
Message-ID: <4347bd76-f9ab-ce44-32aa-95f2dd2a5c59@linaro.org>
Date: Thu, 10 Aug 2023 13:54:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2] dockerfiles: bump tricore cross compiler
 container to Debian 11
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, alex.bennee@linaro.org
References: <20230809082946.747668-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230809082946.747668-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 9/8/23 10:29, Paolo Bonzini wrote:
> With the release of version 12 on June 10, 2023, Debian 10 is
> not supported anymore.  Modify the cross compiler container to
> build on a newer version.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/docker/dockerfiles/debian-tricore-cross.docker | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>


