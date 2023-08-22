Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D276784698
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 18:09:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYTwa-00024w-A2; Tue, 22 Aug 2023 12:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYTwY-00024Z-Ad
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:09:22 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYTwW-0007PA-5m
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:09:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bc3d94d40fso36429295ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 09:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692720559; x=1693325359;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MS9EIAW+T0o67WH4zmSjqABrY3sNZx3QPqLBlOzVlDI=;
 b=Gw4SXDecjAojbT9ZOO5KJGN1hlelJDixOp+nii9mRwGMwq4++XjFMCsAPbpuPSMoa0
 7O/SA21FTZYjLQ/z5D06maK8fBDe8gA0oqNtYQZ7wxTG13c92yBwMgXOA3NQiKZCjjb9
 FT3Q/iZqWt6UrYSAnVCbfYNhCkmKRiIZDXwgdJRwtt0JA4McI8D5o/O008rXi+JKwI/1
 AYQGHnjl3VEhenbH0swL1Y/kwfVq36RvLM+Q+vh0ZDPuYxpPJ12h8DfT2CTYafM11sOC
 SIrGV3q5EccpOQGMHvzvmz7Et1e9nqv+adR6Gf2S1e0wwO4D5D8/eSZKp6JcN32ur/r7
 rGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692720559; x=1693325359;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MS9EIAW+T0o67WH4zmSjqABrY3sNZx3QPqLBlOzVlDI=;
 b=V0qlfgiD5yhv1v3ab6ADJIGiq7LGZkIXhfW9NZdjesdZrlWIiGFb2b+nkQJYMmTmxx
 3qsWVuGok0j8nwpAiRGv0pGJeFxwzQlInbfOEQG8lNsV0CPsXwe8AifzcygHjLSq+mqI
 9T2qupRQ0KMWGQvJXf2I7ijKzokjUVKES+xh3KLbgbr6zSPuAHlGxL0gl4PJWvPy8DM9
 qyeZm+w2MFa0uYHscxKXrjGXV6jIIrSOI05e9yA9jMVdTo4e1iWjIDmEKrqHUJ2DIeYi
 3IscC2R3aVnzCz86bRNXmC5DHncKtkX5ly8uBIJvxqrK3qXL1iSyykYVeYYjKFKsGUN9
 DNOA==
X-Gm-Message-State: AOJu0YyZyne5jDU7O//xe9gOe1hMAnlwjpRIbgtdTsIcbOxaJW6EopiA
 G1ZBewRgyRJCGvN6XswTTs9Qag==
X-Google-Smtp-Source: AGHT+IHnUN4UI74Xqf0cQVSOjkLXVe0ljIXCYpbHgnWj3lPS7MUM/5wIl+TXOx6PcnpRXtQAXvsQ+w==
X-Received: by 2002:a17:902:8647:b0:1c0:9b7c:f82a with SMTP id
 y7-20020a170902864700b001c09b7cf82amr1138680plt.53.1692720558758; 
 Tue, 22 Aug 2023 09:09:18 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a170902e74a00b001bbbbda70ccsm9240131plf.158.2023.08.22.09.09.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 09:09:18 -0700 (PDT)
Message-ID: <c6dbfd51-0975-ff42-ee22-937e27aee547@linaro.org>
Date: Tue, 22 Aug 2023 09:09:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] docs/style: permit inline loop variables
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
References: <20230822155004.1158931-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822155004.1158931-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 8/22/23 08:50, Alex Bennée wrote:
> I've already wasted enough of my time debugging aliased variables in
> deeply nested loops. While not scattering variable declarations around
> is a good aim I think we can make an exception for stuff used inside a
> loop.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   docs/devel/style.rst | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

