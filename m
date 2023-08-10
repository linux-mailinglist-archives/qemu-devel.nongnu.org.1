Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A667781CD
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 21:50:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUBdv-0003Od-W1; Thu, 10 Aug 2023 15:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUBdv-0003OV-3Q
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:48:23 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUBdt-0005BX-9Q
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:48:22 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-26b0b92e190so690988a91.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 12:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691696900; x=1692301700;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V7tUVfJHXlsbQeSzGY39KHcpyy6Mkh9IpG4dq1hyCcw=;
 b=IKBnLbxxBgajTnPRPLd7IpbRnn/RSyx2i9GfB5fmY9BKCFrSOnwBE7tmcPHPw0tAUP
 rMKxdZW8HACXhAEntJqrW19AYxSpX+weLRBCpmwf3PnIBw2ar+cOBOv1yj6gj9uwlxfr
 CowaEMQykUw1IxHHTnx45mpt/QYtgoTK3O0z45sbHGCJbk9lr8gQdO2AMx2QcDo7rtHV
 kE62ghg0Z9hU9CVi1JEeV+83EmbNmnJBWShylJ5nGciD0yZHglExY9m4JHpI1Gs+fFJL
 AJudC6LQuGJHr6Ak0RRAGtLqJM5+H8LjbMrzBco0t1n8bieLK73HdMZVQO6+ZjfOxQgJ
 cFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691696900; x=1692301700;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V7tUVfJHXlsbQeSzGY39KHcpyy6Mkh9IpG4dq1hyCcw=;
 b=YdCPKMSru/V4GTikkOX/oTwXvO4OSKOhLrouLPTLw+54+LNxJujU8rsshC2X0U8TFT
 sWIhQEiUkKUPFTAtGryQVg/dJdo0dIePV2sjBrng04rSjLwf2jLrLnsOvxeDVdSrXSv4
 XcLbP8xkURCNcD6xO3+3iSooLkURQADykpgskTvqRWj9ONGF4pLwJuZgNhoF3oOjiwBX
 JoWfpdEXAtOcjunCshohQ2uX9+pSD6dHYV4d40vNKwY4iLieeewbzHBW6y8AMm2BaJKI
 EKx+69UqnIqOolco9fUEST2pLal7D/PzAYcoxUrG1PUlQn9Mu1/koW8EPRtt5R05ZLFd
 ruiA==
X-Gm-Message-State: AOJu0YzmAOmw18IqqoIV96yrG81vsJTObTDg44cy4FTvkHF64m9pXYM3
 3uKoSPkN1R6Ma5Qzg70SD3qit5HreE5+66w/kqA=
X-Google-Smtp-Source: AGHT+IGAzCvDU8kqu0BA+A8ipZNKX+Xcxxtkv0NtealT5o/wrQrKo9Vtun9SsfnHKJE1zCTp6aqJUw==
X-Received: by 2002:a17:90a:c782:b0:268:808:8e82 with SMTP id
 gn2-20020a17090ac78200b0026808088e82mr4167493pjb.1.1691696899567; 
 Thu, 10 Aug 2023 12:48:19 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:9e4d:b830:d4fd:9164?
 ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 em9-20020a17090b014900b00260cce91d20sm1872808pjb.33.2023.08.10.12.48.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 12:48:19 -0700 (PDT)
Message-ID: <bf83c1f5-4e84-4aa5-fa98-081550584260@linaro.org>
Date: Thu, 10 Aug 2023 12:48:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/4] tcg/gdbstub late fixes
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230810180852.54477-1-richard.henderson@linaro.org>
In-Reply-To: <20230810180852.54477-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 8/10/23 11:08, Richard Henderson wrote:
> The following changes since commit 64d3be986f9e2379bc688bf1d0aca0557e0035ca:
> 
>    Merge tag 'or1k-pull-request-20230809' of https://github.com/stffrdhrn/qemu into staging (2023-08-09 15:05:02 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230810
> 
> for you to fetch changes up to f1b0f894c8c25f7ed24197ff130c7acb6b9fd6e7:
> 
>    gdbstub: don't complain about preemptive ACK chars (2023-08-10 11:04:34 -0700)
> 
> ----------------------------------------------------------------
> accel/tcg: Avoid reading too much in load_atom_{2,4}
> tests/tcg: ensure system-mode gdb tests start stopped
> gdbstub: more fixes for client Ctrl-C handling

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~



