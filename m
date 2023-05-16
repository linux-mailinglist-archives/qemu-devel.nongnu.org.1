Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F09CC7052BA
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 17:48:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pywtU-00071y-2k; Tue, 16 May 2023 11:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pywtQ-00070g-3Y
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:47:16 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pywtO-0002Mk-FZ
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:47:15 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1aaef97652fso99060065ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684252033; x=1686844033;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zgtAe3iYdDgEd1IETtwimEn9TiKrkqN72Dgwgt/pXdI=;
 b=xC8tzkONPqclA6xnO9m0elyj25Ccgb53qaySKcfpnw60SziuEo1vg1Ek5E0ND9PQSM
 hfJrCOZb8Vg1ihgCLuqZrasvPrCehAWVq2QNIivWoJV378cWwBmuQTb6ggzUmSYUbAdS
 0TkpWuef1G12YuK4lo9wKMiqBCnmJwhXImMyX/EjEBwE7uJNeoCL86iBe9Aw/VYYh9cs
 rWTmDqQkkoZBlPEwR9nu8x0Vyp/eNYV1MVF22LIA+qRBNK6m+b9hz2uJpyKXZI0+tq/R
 HUqcZ8naRCRN9sPMWnGbOCphIzDd4LzE2mDkL9Kq979A4KXKqwwc2nz9GWrvYHguNrOi
 yhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684252033; x=1686844033;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zgtAe3iYdDgEd1IETtwimEn9TiKrkqN72Dgwgt/pXdI=;
 b=VJA3H9hh6E582L667PzqrUvnMHUKUWC/RJMgPHKhSD04UBegd4q9rL8Z9ajuR54/LN
 RhN1IWw/2iKVp+VVSbRlHINRdS9+/K30h7tnH5mmUIxstknZN6PAE4OXP3mC8Eg3J14W
 va1F0uJbDnv8k6sEdRUqJi2+BbPN0jKy9cFp7FnKC7btQ/gZLOhPCffBpgGTckcTUg4x
 53IMpKoPAEdcttRVGF4+WjgriM7JqxqZHLG5mMmQS/JqvbWlhi8iWxppKUSHbOxj5X2x
 SnuASFUyQFKCssjtVNZCuAhAst/+XummVSD3EH7sSf+c18rPG1QprpaVwxUhiTUoWJIL
 w3zQ==
X-Gm-Message-State: AC+VfDx2sHLyPxl0tIVyLqzArG6n9fb3jTbWPBkw027AyWZzWlSN/6Qp
 uvJWuuSIhp7687dvN++VkZyo0A==
X-Google-Smtp-Source: ACHHUZ5zdoNvthJuUTwe/8zvo0daLUZ3TQ7DCbkopdyiO+Wlszs2aP8ZMJWszndJ7E7PbRYSz4f2mg==
X-Received: by 2002:a17:902:c945:b0:1a9:8ab1:9f3b with SMTP id
 i5-20020a170902c94500b001a98ab19f3bmr44452903pla.14.1684252032793; 
 Tue, 16 May 2023 08:47:12 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:ec81:440e:33a4:40b9?
 ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 kb14-20020a170903338e00b001ae4d4d2676sm32368plb.269.2023.05.16.08.47.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 08:47:12 -0700 (PDT)
Message-ID: <0ba8da91-985d-4ce7-fe13-4fb435242177@linaro.org>
Date: Tue, 16 May 2023 08:47:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL v2 00/21] Tests, docs, s390x and misc patches
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20230516115455.599584-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230516115455.599584-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.666,
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

On 5/16/23 04:54, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit ab4c44d657aeca7e1da6d6dcb1741c8e7d357b8b:
> 
>    Merge tag 'block-pull-request' ofhttps://gitlab.com/stefanha/qemu  into staging (2023-05-15 13:54:33 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git  tags/pull-request-2023-05-15v2
> 
> for you to fetch changes up to bfa72590df14e4c94c03d2464f3abe18bf2e5dac:
> 
>    tests/tcg/s390x: Test EXECUTE of relative branches (2023-05-16 09:14:18 +0200)
> 
> ----------------------------------------------------------------
> * Various small test updates
> * Some small doc updates
> * Introduce replacement for -async-teardown that shows up in the QAPI
> * Make machine-qmp-cmds.c and xilinx_ethlite.c target-independent
> * Fix s390x LDER instruction
> * Fix s390x EXECUTE instruction with relative branches
> 
> v2: Fix the "sysemu/kvm: Remove unused headers" patch to avoid
>      a compilation failure

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


