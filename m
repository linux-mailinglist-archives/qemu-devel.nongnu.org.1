Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7C0716A69
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 19:03:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42jN-0004MR-MJ; Tue, 30 May 2023 13:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q42jI-0004Is-IE
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:01:52 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q42jE-00070z-Mw
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:01:50 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b075e13a5eso3285855ad.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 10:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685466106; x=1688058106;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G1nUS4xIwzAE7dKiRSF+P0Zr6MOWbnhOZhHhPJo9XDQ=;
 b=qM0y33NCcTb9Z468WrXSpdQJoSNsC40mH6u8AvAF4YMylLKr/AWmgwKpOZZBlPztA8
 whycRGdp2xN8qnadSW20CV/uo8k+7RTSOzOZfDEQukTUQij2LQ9Nc/4M20uuaMgN7/+F
 kudlzMf2rCD/3aGAgYpoRO5EsiDYSUdZhoC9C4ZCyqi1n2cMzVXnAreXQaxWUt4Ca93C
 1KTycqxYpIE3Lx6GxrnbrxFtcF7YYXInNSlsSjBKXCwlsxyf/Jo9Q9CrtrBVxyKPUJsI
 GZyyFNo2Hg3r1JjKNMa/eaXJu9Gely6QQF/N00KUKion6xVXs04jYVuFOnKySSn2YCz4
 YyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685466106; x=1688058106;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G1nUS4xIwzAE7dKiRSF+P0Zr6MOWbnhOZhHhPJo9XDQ=;
 b=VAM4cmFFgWsNpmK2iGNOGZALugIBqbMfJEsgTdqU297uzR3KzCNdYJGmaJEw8Iob93
 4ROdWST4S2MxZmWBSWb4Av433NCOY8nRp5YboO3jaN9jxZ8LckHrQdRXaZ4bJ1T54pCD
 xDLit9MFYMP1NHpKRXoqlYtJ3y/FjMJPCDVrUI7wmas/3aHqz5aWhMsy3yazYYvIeDqz
 8c6KX2JoMbyUCR2bf9nrLBoBaSvo1NuqnvjSPL3QRl3DJS3M+9Lf5G16L7WrRI5jRpz3
 Xt3kbhBH7b/9XwruaMtT322AEVB/ZhB33bhXnVHDm2kkQ0CCyFZ7+d2qaPhuZfyRcMe4
 IHcg==
X-Gm-Message-State: AC+VfDzDY7XuteFa22pg1Xb5DHyJdIhEi5AiNlpRYGQ09LifCygthAyo
 dO30e1B86b7AW95BfoxnMd0odA==
X-Google-Smtp-Source: ACHHUZ7F3eVKChPlyfF60xy21faDkCVnsBM6LeVaL7dXcETYbSqJrb8J57wbBielO+/Z4csZ3SrUgg==
X-Received: by 2002:a17:902:8b8a:b0:1aa:d971:4623 with SMTP id
 ay10-20020a1709028b8a00b001aad9714623mr2933874plb.38.1685466105664; 
 Tue, 30 May 2023 10:01:45 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:35a2:c45d:7485:f488?
 ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 z1-20020a170903018100b001b03a1a3151sm4057962plg.70.2023.05.30.10.01.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 10:01:45 -0700 (PDT)
Message-ID: <60036a5c-920e-8407-e030-1dbc1008418b@linaro.org>
Date: Tue, 30 May 2023 10:01:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 04/16] qemu-file: Don't call qemu_fflush() for read only
 files
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20230530122813.2674-1-quintela@redhat.com>
 <20230530122813.2674-5-quintela@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230530122813.2674-5-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 5/30/23 05:28, Juan Quintela wrote:
> This was the only caller for read only files.  So change the test for
> an assert in qemu_fflush().


Not a fan, as fflush(stdin) is well-defined.


r~

