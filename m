Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BFD76775E
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 23:02:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPUWM-0006AY-UJ; Fri, 28 Jul 2023 16:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPUWL-0006A4-AO
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 16:57:09 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPUWJ-0007vV-6c
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 16:57:08 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-686f25d045cso1696284b3a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 13:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690577826; x=1691182626;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9iDWGCG/cNRkv+1EhYqolIZnBarC0fFCOKzRzINfRb4=;
 b=amH0hQrsJCSxvX/TVxqopubkv3SyjhYOo/y+Z7abYQTDafN9EhjLLslLy+W6E+V2V4
 yOB1K57BRB8V4DiEB/eybpW5qHfc4t/QOyxdMuvzqI4Kg8eCLCu6O3jlCuE3UsYvczaD
 QjqWGQMQv2w6MQIM97TMMscv1f1Zt4UzW4FV/ZtdaiyehGJ1uVJOdCk/8J1/XX5cMDAT
 6HaJRUDXRwsGyB0oYOFDw1qTBslHzsrZSPoCqb8UxbsWC5XOWhVjt/OwTksSk21whRfH
 dvM3HVR/VItYs5Uiu8LkxMlR98m5vtD3XlWc5EKlfNi1w72GRhyCrJBJSfK/SUPhxCCJ
 3Z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690577826; x=1691182626;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9iDWGCG/cNRkv+1EhYqolIZnBarC0fFCOKzRzINfRb4=;
 b=UUJoGsCHWwEfReAFwzSRnHW4CjZpcZcRrVwNLIHX4jytUn8XD4tHaLmMN2df1ZARSA
 W+0BGWLadSBYgpzR3hyyhc2uepq1MduIcXt06f6i75lezgTr1yxZXJf1sZohMyBMQx3f
 dEU/tryF3/ICVTvLxJuE6JR/6OZ9KRCaVjw2G0Lf7OYaz3xaANAfFxipYtK2yDWqGuGo
 wzHXhFjwWQAtBuGgc+y1OzAyBksTPGqPTTp1WOYl2prVrdvlq6w/ERkOmGsi/BxVJrva
 tjWCbzCpQeunbY9wB7CRXxgr4yHdqAlZ7RueuaLsxZsi8ATnAl2yNT09qVLiyfBleLaE
 2+9A==
X-Gm-Message-State: ABy/qLZPnVZ4sHnSrzfGIC6x4UZC+1T59ji6mwyEj0KhBWlMurmtEOhc
 zDLE39RMlk6nVlo3a6FzrgQNcA==
X-Google-Smtp-Source: APBJJlHtbVkoOjgW5AMbXQgBL/IFPIwkFbMEZNQVnCbEcpJJBTG5WDkJER1Vgp8g42KK896s9gdnxQ==
X-Received: by 2002:a05:6a00:1a87:b0:663:5624:6fde with SMTP id
 e7-20020a056a001a8700b0066356246fdemr3242522pfv.22.1690577825687; 
 Fri, 28 Jul 2023 13:57:05 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:cfba:2f6a:7070:67a9?
 ([2602:ae:154e:c001:cfba:2f6a:7070:67a9])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a63a804000000b005533c53f550sm3983767pgf.45.2023.07.28.13.57.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 13:57:05 -0700 (PDT)
Message-ID: <73d477e3-a647-a166-f735-3d1400e505b0@linaro.org>
Date: Fri, 28 Jul 2023 13:57:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] linux-user/armeb: Fix __kernel_cmpxchg() for armeb
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 John Reiser <jreiser@bitwagon.com>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
References: <ZMQVnqY+F+5sTNFd@p100>
 <b3249b9e-d687-68e1-77b6-9c8703644266@linaro.org>
In-Reply-To: <b3249b9e-d687-68e1-77b6-9c8703644266@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 7/28/23 13:51, Richard Henderson wrote:
> On 7/28/23 12:23, Helge Deller wrote:
>> +    /* endianess-swap if emulating armeb */
>> +    oldval = tswap64(oldval);
>> +    newval = tswap64(newval);
> 
> Oh btw, it's not about arm vs armeb, but guest vs host.
> This also fixes armel on big-endian hosts.

Anyway, I adjusted the comment and queued.


r~


