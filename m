Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DB071F242
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 20:46:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4nHp-0007CO-BC; Thu, 01 Jun 2023 14:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4nHm-00077b-Or
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 14:44:34 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4nHl-0005Bm-2Q
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 14:44:34 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-650bacd6250so632935b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 11:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685645070; x=1688237070;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Cqrl+WClwhxVzZlS3zZOutI5i9NsBX/IJ3KU8h9dYA=;
 b=t2a0gHmPo/9VaM+QSOiuk52+nsEsaGVqlxbvfJZ4l9xuZnCoS74HKpylMbarxKBUfO
 +sN6rtqlBs+l7pEDwvNB3EhH0zpxtk7IoKkBC3wbj9bHrXDqoeUui6jqzLpCGY0Ytdu7
 9IJ4fr3lKHGV8jS42KWECEcylvRK3OU+03FLB2xpETV3hup/g+PNY4PoQKFuBoqHWGWR
 VQIjlPjbIkCTQXV5o7golT1a1JQFWvWhrpB+MlVSpXRYx9kXDRJ6r6cmLaucUhLudFgY
 wbTNmpt9+eHI5Awy2k0VVpqOqiSwdnKg9tONj9fZ2TNDqdIf1HsWDmrwVoFUcFouOTwk
 3KAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685645070; x=1688237070;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Cqrl+WClwhxVzZlS3zZOutI5i9NsBX/IJ3KU8h9dYA=;
 b=XYwW1Yk72TLUDe1RJujrhix7VKzFZESSZxkf+HF4FT+7k+Sl/K+AQhGbgbWf16U9ZD
 1KUd9R4jNM2gouV5JbqQGWyDUQxXXuUhpoxSIHPEmsm7pYgzXQtehB9+5CGQkyYKNOqP
 UE3N6/jHmJY4Uuxpf3nAHgkIeJgyAKWd2ZRuNTpbUxcYUdfgo/wRYerzExn7oKztzIAS
 l4QALXCFVObAq4G97mvDtr27TniwfOu7qmgI5xNIPw5hfelvXCraxU5+P7lynWLzHjqM
 k8ndmFUpn2Lt4mtcvXmfIvgyB+vcEDlYZFuWPz3fthMlMLxLkXqSkFENJwxeqbQ6qchV
 78Rg==
X-Gm-Message-State: AC+VfDwrlYf4Z5na/rVbnAPSeZiKWgFXzssKUemxUpFz18Yjnm7oIqUz
 GfsJxSi6rYTx8gRSUFk9Fxof0Q==
X-Google-Smtp-Source: ACHHUZ6l6QUh6T0B0ZoWFr9vOJMxwmvNRvybVvEttuNI+jrQuAkZdXCbDcRv+ycKmAE+xp6E6W4TLQ==
X-Received: by 2002:a05:6a20:6f03:b0:103:d538:5ea6 with SMTP id
 gt3-20020a056a206f0300b00103d5385ea6mr7110078pzb.48.1685645070543; 
 Thu, 01 Jun 2023 11:44:30 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c935:f07f:4b59:7091?
 ([2602:ae:1598:4c01:c935:f07f:4b59:7091])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a62aa0d000000b0064f7c56d8b7sm5344983pff.219.2023.06.01.11.44.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 11:44:30 -0700 (PDT)
Message-ID: <342a3b0b-05f5-54f2-a544-a1bc732b5c32@linaro.org>
Date: Thu, 1 Jun 2023 11:44:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/6] tests: enable meson test timeouts to improve
 debuggability
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20230601163123.1805282-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230601163123.1805282-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 6/1/23 09:31, Daniel P. Berrangé wrote:
> Daniel P. Berrangé (6):
>    qtest: bump min meson timeout to 60 seconds
>    qtest: bump migration-test timeout to 5 minutes
>    qtest: bump qom-test timeout to 7 minutes
>    qtest: bump aspeed_smc-test timeout to 2 minutes
>    qtest: bump bios-table-test timeout to 6 minutes
>    mtest2make: stop disabling meson test timeouts

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

