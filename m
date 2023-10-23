Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 205557D3A60
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:09:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwWu-0004Br-U6; Mon, 23 Oct 2023 11:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quwWs-0004BG-Qo
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:07:42 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quwWr-0005n2-8Z
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:07:42 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53fc7c67a41so6784424a12.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 08:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698073659; x=1698678459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jv0A2R3hTJrpeRfnVqPEVT9ArBPEHM4kSpRZVuBTy3o=;
 b=cN279sjKAymxTu5CGVXFs2Xq8Pw5Ps6siDSW0HrD5sqRK5GXJbqcKP1UsRe7RcxDFU
 h2VdqG+6OOXYbVOxaNt8rTOAqZgEonQrw4PieD8JU5VdKhyTvyxxFkhIg+rw6eLnxPBM
 CnFOG6O60r2lZ0IFAiEfDQl6bSNmcPPjOxcyxqNtUx3y4B/xDNQq/yevzWzCLCdXH1u0
 IReie7TlvLPUZwUIoLZ3MRmt8lVhU4rQTNkY5z+7VfTRjjQ+aCQDsHKUbzubd0hHYHK0
 KjebxjCp4SgLuRJtyu5xn/5ocRO110DFVKHwA8GRVvCPjygW+p4P2621ohx8Kd7Io+G9
 Z0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698073659; x=1698678459;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jv0A2R3hTJrpeRfnVqPEVT9ArBPEHM4kSpRZVuBTy3o=;
 b=tOfXcB/K3eALl7ywMAs2hrOY8NwcguGmWOPQOZOkV6UM/+wFjLTvDwy+cojlMyLW4U
 3/HW7JThFFtCNgSqUa2jUCinBx6mjgRsWZhQAdxrwCxN0oX1a8AMsD33lS3QA+6FPceq
 /0TXlOlI1UJWKFA39CImKcyZZkJ4j7pvWkledv/C44Es9RlROETZ8DynDOHYLw2/cprK
 21qHsoWCc8TqLSAAlqonEGrxQVph+eiGKYR6XZsxglmPeoI848HJ0Xxp7RndLBGWVNWO
 pxONLUN44BB94C+iNVqCQOj5TgxIA3hyEbhvkSECIdbjf8Tem15gRD35er0ntFauahkc
 94SQ==
X-Gm-Message-State: AOJu0YzDqV+q0ETzvtGm2HWm10tD5hnRgyyaqB12RTVYD/2EtM/DATcc
 BSDRVX5sbzGNAHtLsNGO78s+gA==
X-Google-Smtp-Source: AGHT+IFee5IaPuyhaER5+kKbMBYNoFusU5FnkaGDaLDpFhRcftbv3APXuHnr88tdW09QDp0O5QeFNw==
X-Received: by 2002:a17:907:9727:b0:9ae:5513:e475 with SMTP id
 jg39-20020a170907972700b009ae5513e475mr9405311ejc.9.1698073659335; 
 Mon, 23 Oct 2023 08:07:39 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-216-159.dsl.sta.abo.bbox.fr. [176.170.216.159])
 by smtp.gmail.com with ESMTPSA id
 hb13-20020a170906b88d00b009c46445fcc7sm6840380ejb.33.2023.10.23.08.07.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 08:07:38 -0700 (PDT)
Message-ID: <00fa1082-6f57-c4a9-c6ae-a5853f9e6dee@linaro.org>
Date: Mon, 23 Oct 2023 17:07:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 6/7] target/tricore: Use tcg_gen_*extract_tl
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-arm@nongnu.org, laurent@vivier.eu,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com
References: <20231019182921.1772928-1-richard.henderson@linaro.org>
 <20231019182921.1772928-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231019182921.1772928-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 19/10/23 20:29, Richard Henderson wrote:
> The EXTR instructions can use the extract opcodes.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/tricore/translate.c | 20 ++++----------------
>   1 file changed, 4 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


