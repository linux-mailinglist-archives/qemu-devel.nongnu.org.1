Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF447F1851
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 17:16:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r56vu-000288-7L; Mon, 20 Nov 2023 11:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r56vs-00027r-OJ
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 11:15:32 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r56vr-0000JK-10
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 11:15:32 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-507a29c7eefso6448468e87.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 08:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700496929; x=1701101729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X51Coc0JPk+6C75WLHrK/vGgz6/3sz6BN/+kyZfLgxI=;
 b=DTqqMgkb4CLzTfgNM59Q3ZVvliGJ3QzFG6gg533ORJMhlWtuZ1SAne9Ymd7YHRNYc9
 tXbojej5lDyel8asAP1ndyUO8DHjeDqScuMvj9YevhnNJMXJmGDMThLoDZYd0tHJisZ3
 GDBf7ACliOj90+Q2gQhDfOlKN3LEp6S4sBJAeXPYoZcqW8gwYdZOJa3aiCJwxlq3rLD/
 TmrN3tpyqYtmZ4wBIh1pevuHrsiEHwpxgdvyR/BwNRCkiVM8ZZa2KfgWTn2P8rNWYOuO
 y43Qw/AzEcClvKgsNUnDqSbNuZvzsS/ZDCFARapKJdcpvjju26J2AP4f3XB1enPvbdHa
 Ac/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700496929; x=1701101729;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X51Coc0JPk+6C75WLHrK/vGgz6/3sz6BN/+kyZfLgxI=;
 b=syMufSBHB/OjUgKOsFLgoBYdJJSMLg2E5uiUJtctfK9nWuHJxRCyh9/yf/81FwTeFA
 mvFhLmKx1IYQVOcErcQbkmhVl6cuOLZ+eL2DHmb4PLgiJTxNB6heVQP/1kZW4pJIL6xD
 DlBnTEHVvI+/T4JmDA9KD3HzZOA4d1Vz9iUkioNcJBNSpZ/t5+9um/138H32iHLrvN8c
 8ryhIr4fU0jJsIzoCmHxH8ym/rEpWKunTZ1fBCf3sZtTjvII6oGqxH80KU/cfuA5t2ER
 2NQZdqvnBcyztEhp4Mo4AY+aK8UsSWoDFEvhl2CrI1nYuxS+N5YZO7+JO7a50nqg7u6c
 EoOQ==
X-Gm-Message-State: AOJu0YwwCVrkD+t/YBmyF4EPn18dDVFLOCBtDVlt0Shf1Ku397x3hin5
 j5Z3zT5jJlOQ5HiHCyTWTIBLyg==
X-Google-Smtp-Source: AGHT+IG+XSp1RpUc6MwGH1hR08nHfX0CgkJXVkWpPhOYNiZ3WYSrJFco2zpSvOVia69opWhXRJxqvA==
X-Received: by 2002:ac2:4469:0:b0:506:9304:570b with SMTP id
 y9-20020ac24469000000b005069304570bmr5426591lfl.14.1700496928763; 
 Mon, 20 Nov 2023 08:15:28 -0800 (PST)
Received: from [192.168.174.227] ([91.223.100.4])
 by smtp.gmail.com with ESMTPSA id
 f11-20020a19380b000000b0050a6f5a186bsm1225823lfa.293.2023.11.20.08.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 08:15:28 -0800 (PST)
Message-ID: <abc9c476-174b-4668-9436-437f20bf1272@linaro.org>
Date: Mon, 20 Nov 2023 08:15:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] docs/system: clarify limits of using gdbstub in
 system emulation
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231120150833.2552739-1-alex.bennee@linaro.org>
 <20231120150833.2552739-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231120150833.2552739-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/20/23 07:08, Alex Bennée wrote:
> It seems some users will try and use the gdbstub to debug userspace
> inside a system emulation. While possible clarify the limitations of
> this approach and direct the users to a less head scratching way of
> debugging user-space.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Clarifies: https://gitlab.com/qemu-project/qemu/-/issues/1274
> ---
>   docs/system/gdb.rst | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

