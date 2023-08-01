Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A23B76BF7F
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:47:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQxCn-0008He-3o; Tue, 01 Aug 2023 17:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxCk-0008HI-Rh
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:46:59 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxCi-0002C7-B4
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:46:58 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8deso67365435e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690926414; x=1691531214;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SSJ1HgtRK+EyNzyYnpHryTxSdQGypZxamiI8Bk0bBlk=;
 b=V5Q1myWcfB2xdMaZ5iW0mRAMzY3rmkFsW3muNnKeQTj3ITjegdumCm51guMbgLubXK
 hqAYeR1zLVb6uDaEW9Djek42hx9elCluHRLDQ09VeNEfUh9CYIX9kPv4W84mk6rdOPdK
 /NygW9feGZZpqMu9Q3kl1sRcc2s5GJsDmg4JIKG1yijKBeK5W8ZMPYKU1t1FDzWWzWzG
 V3BX7Hg7xjw95ZYsYTzEJZybTUC6kPr1yLa2z3gt/eBdyJCfjBAj6Xzr1vM3IHx8AlLx
 23NrRs+ZknTQc56kJTxhxqV4OhJt2KCh8AQi/Cqc5Ij+ISkbXeqn+Ai6t41X8pjdbGbB
 k+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690926414; x=1691531214;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SSJ1HgtRK+EyNzyYnpHryTxSdQGypZxamiI8Bk0bBlk=;
 b=TKAtfM4irBst5sVpvauk0fUxRywBHcC3EiXUuJK15mHvJC7dkqgnTfCJiCYiKkpNpv
 HGEMgCAVgKAMDiXS8wIosluUs7n6OeTFSCVxb9awioS4dF1MV5enBkaDryLQMohuVKkM
 nLPnBAfKKdD8Q8XB+f9UrVxWO0cWhtvI6C1eIkdaIZIvACvYGHhb2t/Ws2qFx9TMiAv5
 Y3za6FRmSNw2aHMkFgPLqXxFNGm3QNtGTy6QFlqBOdUXGJDu+oyhfD7siCTwmIEIKhL2
 cPIzaSfGLBCiSWJeabnyaXwGMZixvFeXw6x2JlS3uYXwJvBOGIL6AzvpndKhIsJal6AO
 5dqw==
X-Gm-Message-State: ABy/qLaaWaD+l5TtjIJ8eTBfJe9BQ9rsM12nw5fSosllURMEh7PwdmQL
 Zy2TgCmyGfPkY9jRyrOGvwzQXFnHkfT80KsXMWY=
X-Google-Smtp-Source: APBJJlFODPXmVE32DvBZ7ttvr1TkRrevFAZACCB16T+5MeVYBugbpVquGNcpEM3Nq0zQfUSM0iIokw==
X-Received: by 2002:a7b:c850:0:b0:3fc:80a:cf63 with SMTP id
 c16-20020a7bc850000000b003fc080acf63mr3573865wml.38.1690926414622; 
 Tue, 01 Aug 2023 14:46:54 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 u25-20020a7bcb19000000b003fe1cac37d8sm13022wmj.11.2023.08.01.14.46.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 14:46:54 -0700 (PDT)
Message-ID: <748863fb-38ef-b782-8263-1bc137151271@linaro.org>
Date: Tue, 1 Aug 2023 23:46:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] target/nios2: Fix semihost lseek offset computation
Content-Language: en-US
To: Keith Packard <keithp@keithp.com>, qemu-devel@nongnu.org
Cc: Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>
References: <20230731235245.295513-1-keithp@keithp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230731235245.295513-1-keithp@keithp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 1/8/23 01:52, Keith Packard via wrote:
> The arguments for deposit64 are (value, start, length, fieldval); this
> appears to have thought they were (value, fieldval, start,
> length). Reorder the parameters to match the actual function.
> 
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>   target/nios2/nios2-semi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, queued via misc-fixes.

