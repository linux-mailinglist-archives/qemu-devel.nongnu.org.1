Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEE870F8E4
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 16:39:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pdi-0007vl-Q5; Wed, 24 May 2023 10:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1pdd-0007rY-G3
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:38:54 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1pdb-000858-Qn
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:38:53 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ae4baa77b2so2621485ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684939130; x=1687531130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EOkOFySqro5gSmR8qPZh0BYA3rYAuOHx36cBQHbVFn8=;
 b=fWVwB/mZBcvI9AeVx2RFB4jv7Jg+f1aPVFTeQQ9BQqwxXfdC5cP3ana4jJYrCmRzQJ
 hD2mCNFZyTnsCi5rRYAwLIVR8tA42iiZYvzbvlRQ+HeSxmyPW2R7FI/L6r4G4us+072A
 yR8ynRi6jFsCHXVhSZ80EDzUI61J64C+YdPRUOO/aWY/6bXaES7zuPpZhN9Kv8LFUxCX
 fd9v7jyhqX20wfYQmJaGF9Ow2Fpeb7jzEW8drUMz+mJ9geQtfKRx5LOaVblqD1ymcfjJ
 qtOK4Gxfi23xru9D1RUjbZ4cYPmz4dPZW4Zhm2keQMvEkVDDiLFCcC3a9tcnMVNig0Fl
 1OCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684939130; x=1687531130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EOkOFySqro5gSmR8qPZh0BYA3rYAuOHx36cBQHbVFn8=;
 b=K+E9qmtnn/pyRXDpGE9Rmi8nrwyiVqyoSpuVLN71eUpiyXB+GmfA2GoXiBWWO1mv7d
 oiD24gUPpYL9T/+zm6Nel4HBFoL0SDj+iO5hzGB2TTDOcrhgfIapyFCdQrf3wWxps7zP
 u+YmSlNMjwsDor16TqKY+m0eyACuU8Lop91pj1DAAzg+J7hhgkt7tQ9/d6h/bKSYjdxi
 Yd0tqiDZXbyaThSVJqVTjYkJBI9X3wrT6VYLk65NJHpui8q8UQjhyohq6bEX0AoAZcMX
 bcVJZ5jMWVVJtqDFGMQq1FOzAxufrVH+GD2U7ur0unOsjBTzbqWksWTZEQrBW20c3BjU
 xbkw==
X-Gm-Message-State: AC+VfDzHhrFMRawc3rT+57/nLre6e67a24snwSm8xOPYui1KohAwENQd
 oUkCjF82WPzYcbe+t5tTcThBCg==
X-Google-Smtp-Source: ACHHUZ5YhJMby3KiULRfxHfbCqo6qrH9y5JMC3miNxdC0uAIkhYHFE2Yag3yjAvOelKiXlI2N6hxsA==
X-Received: by 2002:a17:903:18b:b0:1ad:d995:54a with SMTP id
 z11-20020a170903018b00b001add995054amr19610438plg.46.1684939130168; 
 Wed, 24 May 2023 07:38:50 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:6b03:9af2:33c1:3d6b?
 ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a170902ed5200b001a967558656sm8817819plb.42.2023.05.24.07.38.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 07:38:49 -0700 (PDT)
Message-ID: <ea52f09a-7558-e9d2-cdef-a0a6c0a96216@linaro.org>
Date: Wed, 24 May 2023 07:38:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hw/arm: Use MachineClass->default_nic in the sbsa-ref
 machine
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>
References: <20230524082037.1620952-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230524082037.1620952-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 5/24/23 01:20, Thomas Huth wrote:
> Mark the default NIC via the new MachineClass->default_nic setting
> so that the machine-defaults code in vl.c can decide whether the
> default NIC is usable or not (for example when compiling with the
> "--without-default-devices" configure switch).
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   hw/arm/sbsa-ref.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

