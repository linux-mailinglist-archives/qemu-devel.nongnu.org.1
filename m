Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C385B70D229
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 05:05:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1IKC-0004Cu-4h; Mon, 22 May 2023 23:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1IK8-0004Cj-VW
 for qemu-devel@nongnu.org; Mon, 22 May 2023 23:04:33 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1IK7-0000Ce-7m
 for qemu-devel@nongnu.org; Mon, 22 May 2023 23:04:32 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ae54b623c2so63832815ad.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 20:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684811069; x=1687403069;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=10AeITzq+wI5/sqH4esWjUt6ZGph+uU9OfhqgYf5Eyw=;
 b=SZU14z5dYvwgxMPwQWnJ5v4gqfml7odsjiBi+AssBSvQnchXhy9il5tnLP0WeshB1I
 OWxyqQSjtuNAltAK8d3GGel0zGKZFwna/HVjs9YcGIYLPZYi/AuogpXUmLQZVxynO7wM
 a1x1au5tCMCqm8dSYL1UpsLo/09FIMN5hgYa0cfg0htv2sC9xYSFFkC+H/PwhQ3c3q+F
 RKB3onpj8VULizCRfKkSSFcXUJx/fI3ZeImqPSHIVja7dM5+zhJ695hWJdxXNnrwBS8D
 bNAu4vjmPfohGsdwQ1o6ZZi7GqQmn+95sLs0YdhuVt2vryVkfkyeea8hi8Fio81Dx7cu
 5VKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684811069; x=1687403069;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=10AeITzq+wI5/sqH4esWjUt6ZGph+uU9OfhqgYf5Eyw=;
 b=VPey1OteHEJTJD5ONuDEkdxCBg0t8alwmonToGDqKu5f0ZGIObBDUH5l39Ok2F1fuc
 ij6gmO4RwypWvNQUQlO2JjtWh/flj2uiDt4J3jWOjkIuC7aPZw3+D284QmA6Wwxlleb3
 btogguoKeboe7ivacr54Q7yCsrxcYMW0KIn6qi0GLqZWFWUdc8NNlrAR/1HFvaTUG1k3
 15gWGW3o3eQhv34H9XNzNrD0hqkTU2nOg41aKmVKqci5DfW5nDsZYMZ2TI2i1bpo6He3
 h35LcDehQU1Qvg70IFPhENwiAM/sdFpgFHrqPCjHtfmWnCdKn+oZQH1GOttrbxJ8IIG1
 EjJg==
X-Gm-Message-State: AC+VfDwNV0xJbS23EQBKZVYGQUM2nntBUfAmK1mUTuLGa/8w/rqUSNHs
 YUrqthZQbhKkAN6Le/ljdfWTQw==
X-Google-Smtp-Source: ACHHUZ40BFOsTJDBDptgw5d1IgT7UCio8AnwGlPRepNjk2yvjbKSca162MArl5jm6LiQssD7PsV2WA==
X-Received: by 2002:a17:902:ed54:b0:1a9:7e44:17 with SMTP id
 y20-20020a170902ed5400b001a97e440017mr11558027plb.17.1684811069239; 
 Mon, 22 May 2023 20:04:29 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86fe:2b34:5897:c8ef?
 ([2602:ae:1598:4c01:86fe:2b34:5897:c8ef])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a17090322c300b001aaf92130afsm5536693plg.116.2023.05.22.20.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 20:04:28 -0700 (PDT)
Message-ID: <2d35a57a-4139-cd5c-f52e-fc84aaf48775@linaro.org>
Date: Mon, 22 May 2023 20:04:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v2 0/4] QAPI patches patches for 2023-05-17
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20230522112022.2075140-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230522112022.2075140-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 5/22/23 04:20, Markus Armbruster wrote:
> The following changes since commit aa222a8e4f975284b3f8f131653a4114b3d333b3:
> 
>    Merge tag 'for_upstream' ofhttps://git.kernel.org/pub/scm/virt/kvm/mst/qemu  into staging (2023-05-19 12:17:16 -0700)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git  tags/pull-qapi-2023-05-17-v2
> 
> for you to fetch changes up to 0ec4468f233c53eb854f204d105d965455deec51:
> 
>    docs/interop: Delete qmp-intro.txt (2023-05-22 10:22:29 +0200)
> 
> ----------------------------------------------------------------
> QAPI patches patches for 2023-05-17

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


