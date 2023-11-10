Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 334857E85E0
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 23:50:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1aJB-0007ht-IO; Fri, 10 Nov 2023 17:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1aJ8-0007ge-Gs
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 17:48:58 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r1aJ5-0000pb-S6
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 17:48:58 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a86b6391e9so31007107b3.0
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 14:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699656534; x=1700261334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QWsTdl2K6+YGQK5bU59O/HCLogegVMrnoVjvMNTDmS8=;
 b=acE3Z6gTkxdnCnc7HtcBUYbeJgwCKpCjoZC9P0OlH3JsRaO1xFCAIfF4RlZazBsQ1C
 OmjdPwIuwaKmeyie5zh9ahznepGfPY+GNiO6m8um+TLBhzbEIj5oIzxXq3D9o2lwyJdL
 CDDUcEqRM9e4GwoqhK5AD6+y52sm3uFA3A6Y/AaG9YHb7s0X1vZs+KD8tuX/GIloVet+
 wW6mZ0YYlD7MSs3j6UBoXFtGlPLjGv7WAjf6BVRHSli6CNhzEsUtn1efTZUNCvzhKUEG
 iHMD0S4jf8ocaWenSWmJcvGjbvZwzPZKGHx0A3SwknkPuGMsN4glfNCZe5f+JHhHjXTB
 R+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699656534; x=1700261334;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QWsTdl2K6+YGQK5bU59O/HCLogegVMrnoVjvMNTDmS8=;
 b=KLJSOMa9SBit3t6thSs7uY6irjunkN+z8D58ftS3ndzE+51gG9a9h4I5if8bu2hHeG
 IQ8peiNSrus3I5seiDQ40/DrO3o7KSTcctfvNZgOhodMjq6IZ4eTIQqkTkTOgjyyNBh0
 QDYq+MlURixuwxFY6gxLjZdUyHgBDfdIQsMKGbGo7v8hXSEMLTcJmC7X2eEsfSwlLh0u
 oymyQ5o5JG+frqSX3hyOvSvLfLSor6CuEpEvRJ7+GDzOATaivBGZExyM1aCpPYecz0SS
 qFLwZMaRlEYo5ZBjRE/7eLJ7EcXHaClVZj1vKkzefLteYSCMHX5TcjRRYd+Gzh0E2wNT
 lgnA==
X-Gm-Message-State: AOJu0YztUabDzIlCrQGoaP8A2ZEendSWtlpkrGK1cuD4SSZT57mZhtJI
 DJfIoefJ9GRacKx7P0bhQ7SNEA==
X-Google-Smtp-Source: AGHT+IG+qaiPuG4vgUz2c+k6qNhLVd/j0BbC3tY+RVpvkzpscKi7DT6UBbf+f4SuM5CeKpbOGJW8tg==
X-Received: by 2002:a81:5489:0:b0:5af:abe1:3d4b with SMTP id
 i131-20020a815489000000b005afabe13d4bmr568110ywb.5.1699656534208; 
 Fri, 10 Nov 2023 14:48:54 -0800 (PST)
Received: from ?IPV6:2607:fb91:9e6:820:96bf:8504:fb4:ae37?
 ([2607:fb91:9e6:820:96bf:8504:fb4:ae37])
 by smtp.gmail.com with ESMTPSA id
 o124-20020a0de582000000b0059b547b167esm125732ywe.98.2023.11.10.14.48.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Nov 2023 14:48:53 -0800 (PST)
Message-ID: <d93beb59-ab19-43ef-8d70-5e63cc6dbe29@linaro.org>
Date: Fri, 10 Nov 2023 14:48:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: Fix possible overflow in TLB size calculation
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <ZU6F/H8CZr3q4pP/@p100>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZU6F/H8CZr3q4pP/@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/10/23 11:35, Helge Deller wrote:
> Coverty found that the shift of TARGET_PAGE_SIZE (32-bit type) might
> overflow.  Fix it by casting TARGET_PAGE_SIZE to a 64-bit type before
> doing the shift (CID 1523902 and CID 1523908).
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

