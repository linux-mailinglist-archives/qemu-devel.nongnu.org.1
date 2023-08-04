Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2775476F8D8
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 06:13:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRmAx-0000x4-MB; Fri, 04 Aug 2023 00:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRmAw-0000wu-0i
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 00:12:30 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRmAu-0005aE-C7
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 00:12:29 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-686e29b058cso1247068b3a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 21:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691122346; x=1691727146;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pWUh9pfwco1xMxrWkRjtIGhRsUBCo/Amcn+zeqiPIII=;
 b=sKx+5eQR/62+Hbp1FzEptnna1rxXUWUCemXgvB3P3owWCmJqIbmNTR30KNPwDugOpI
 PQv7v8dgxHVDe26ZKS2qDl8hW/OVYOahp3rVI3GQAha3LQ50SqAKI7lt819aTZRMkOZw
 oXkQWxj17914Lv3CqFtR15dMIz7AitkyKIvuHWkDdeMVcONPPhet5M9Nw+v43j7gKtGS
 6WSpx6WPGxzUODkK6f9OeFn2zeXik00M6Abx+V0pTaTKsF+9jsP+yFSQyX5NugFUXHBZ
 CecXVcW5oB1PbWqgENd1PmznhtaSIbq9YUyyg6Lk+znhcH6WPnAKpZx687YH9KUKcial
 nUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691122346; x=1691727146;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pWUh9pfwco1xMxrWkRjtIGhRsUBCo/Amcn+zeqiPIII=;
 b=LO8OppiCWADpg6/R2iZ5hQz0C38O8C8GMuGveh90EJzw8T7lF4tgTbOWiN7AWtcl9I
 TxUDwX1JBZVYjFO9jIDYbmaxv5qQjBLq8LbjYOPfLFr6/HZbquzmyosKDqvPxvENTgdQ
 23YE/zzOK6EqIex9er0sum3vs6unhaROduw87LFf3qUeKwwrPsWPTqYz3UO/MtaU+c+f
 7sKkgtLBPYdonN3uLDsWswgrpW1CJgd34OQwk7t1eBT2uJoudsijl4OjnTwGtUr3v/iN
 7TUsv29nwwwBdm7IVR/s4PMclNOVdSnL0JkyOaQvAPROiLR4kUwWLtsX/j8MB0/E/SwC
 W/fQ==
X-Gm-Message-State: AOJu0YzjaI3bCCj4XXtIiZJKP2Pg95uSDvZkHbHDORD2I8Fi1AYGSoyX
 wS4fYEop1xHqI/hL5GUEN5jypw==
X-Google-Smtp-Source: AGHT+IHSEM68nEDt4p9cpqRem0QgAQ/tEOkHZcmxsfoEli/RPTdgoEADMXQyxBE4pAKWpItt92iZZw==
X-Received: by 2002:a05:6a00:194c:b0:687:8dba:4ca8 with SMTP id
 s12-20020a056a00194c00b006878dba4ca8mr595685pfk.30.1691122346289; 
 Thu, 03 Aug 2023 21:12:26 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:9d52:4fe8:10ce:5c3?
 ([2602:47:d490:6901:9d52:4fe8:10ce:5c3])
 by smtp.gmail.com with ESMTPSA id
 v9-20020aa78509000000b0068285a7f107sm604752pfn.177.2023.08.03.21.12.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 21:12:25 -0700 (PDT)
Message-ID: <f2643e26-a94e-da58-5900-b9231122c0b0@linaro.org>
Date: Thu, 3 Aug 2023 21:12:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/1] Hppa linux user speedup patches
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230803223502.653223-1-deller@gmx.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230803223502.653223-1-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 8/3/23 15:35, Helge Deller wrote:
> The following changes since commit 9ba37026fcf6b7f3f096c0cca3e1e7307802486b:
> 
>    Update version for v8.1.0-rc2 release (2023-08-02 08:22:45 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git  tags/hppa-linux-user-speedup-pull-request
> 
> for you to fetch changes up to f8c0fd9804f435a20c3baa4c0c77ba9a02af24ef:
> 
>    target/hppa: Move iaoq registers and thus reduce generated code size (2023-08-04 00:02:56 +0200)
> 
> ----------------------------------------------------------------
> Generated code size reduction with linux-user for hppa
> 
> Would you please consider pulling this trivial fix, which reduces
> the generated code on x86 by ~3% when running linux-user with
> the hppa target?

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


