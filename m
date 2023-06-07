Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCEA7253BB
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 07:54:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6m77-0006Tu-5H; Wed, 07 Jun 2023 01:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6m74-0006TT-U6
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 01:53:42 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6m73-0007bK-7p
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 01:53:42 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6af6de9fb74so5939608a34.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 22:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686117219; x=1688709219;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g4jfUtxNxGnQM7lIfi/o+6H3r63ipqNVXc1MoJY5LsE=;
 b=Y8ldB6fznK1T3wAphYE/aKCBZbQbcn3nOOv4uC59IJBooptC3Gm71/haCswJx4T0NI
 pYMlexi4gCOa4rD4IBGDSK8/3lxGs6NzDSwmkktXjszF9nyC701RmqooYMw+ArLtYCVI
 UQ8uS5ALQkSxDT+gz98qpE0rQ4ziDTPEnbAv1Uoix6tLr1a1TIwhnms0eqi81dUhRJ3T
 kG9+d6MgmGlvpLQ8BUpec5/zspF38/8AtOVMHtwoJtnhiE7lZnaT2wQWTu+jiCBeeyxq
 uo6j6TJIKl5XKZ90VGv2I/BTyJsM+vH6wcOjs2hCErOFsVUTBqgcOsP2Wla5XysVC6nn
 dH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686117219; x=1688709219;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g4jfUtxNxGnQM7lIfi/o+6H3r63ipqNVXc1MoJY5LsE=;
 b=Slcvsa82LOw9OFO2i7O42DVffzt+iOG4JEnEpCVIJ7yDG4+iV4usHhcKlScEE7wZcH
 VcZ29rsWBzhGS377cAzX4xXirD3K8nbDXWi9p6spKrCkVV9WK5rdWXL1js8O3lhLBfRv
 Bsx1kBLL7iNiH3toBGIjLdaWpxw4LJFdToyRkMr17IiDfLwn4RbL36vTa8vqo6jRmNKW
 /Y8IbJ3Eqtfrp8VkRr7mwqv8arKAyAH3KiCW5u20XyURK+fmX89eWLqkUGtpDG9i6H12
 Wg0tzT9vrwxOhpwqdX/AYDpWC6lDK5mgdYn4O2VVw9v95x9o2orU9Jk5UWslivT5mmJa
 OEnA==
X-Gm-Message-State: AC+VfDwh5k5sNeAFOXLvJFdEUSdmhxbYOQUsyQWtQX1DRAGzW5XI68tE
 OYk6W5Ewqc/7tdLHzn0Xt8cD1hLxb667ynZ1n4U=
X-Google-Smtp-Source: ACHHUZ4XJYoonyynpa3m/o93qC7Hps2h2wD7sKRXtbBpyqoO+HcsyXoGSkfbVV16i767hmlFo+s14w==
X-Received: by 2002:a05:6358:cc22:b0:129:df95:f9a9 with SMTP id
 gx34-20020a056358cc2200b00129df95f9a9mr2577359rwb.2.1686117219364; 
 Tue, 06 Jun 2023 22:53:39 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b7fa:ce59:1445:805a?
 ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 17-20020a17090a199100b002535a337d45sm565547pji.3.2023.06.06.22.53.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 22:53:38 -0700 (PDT)
Message-ID: <98d56274-c104-3ca5-1e03-b149c953c1c6@linaro.org>
Date: Tue, 6 Jun 2023 22:53:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] tcg/tci: Two regression fixes
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de
References: <20230607054654.622010-1-richard.henderson@linaro.org>
In-Reply-To: <20230607054654.622010-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/6/23 22:46, Richard Henderson wrote:
> Two recent regressions, both related to recent tcg changes.
> 
> Our CI does not test TCI with --enable-debug-tcg, which given timeout
> constraints is probably correct, but in this case resulted in an
> infinite loop on aarch64 multiarch/memory.c with FEAT_LSE2 enabled.

To expand on that: with --enable-debug-tcg, assertions fire and catch the bug; without the 
assertions, the generated bytecode is incorrect, which leads to the loop.


r~

