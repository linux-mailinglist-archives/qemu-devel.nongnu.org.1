Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53461776375
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 17:11:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTkpb-0006QL-CD; Wed, 09 Aug 2023 11:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTkpV-0006Pj-Rd
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:10:36 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTkpT-0007xa-Mw
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:10:32 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bbc64f9a91so58446895ad.0
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 08:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691593830; x=1692198630;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jfAbdbP+lNzWWVkLPvs4YNUHAxn9NY/LE5yLd2IKNIc=;
 b=R6DnTI0rUre/hwgI5EHDo/4++f400XiL8X9hkvUFMm9xbRATEeEf5pcaYyBOgPM2Hs
 TV5AWWg/Bijs4NlXDfDeTDnFPBSVto7a103KOVYLgehmlg+hC/kEYshzwQhGWnO3BqRB
 IGTPSti08LspXkeKkIe0epo8/4n2FerQMoDTHkwc1/LnObVEw/c+dWIU1zgb6G2RTW7J
 CwgSg7Z/muEXvuvnw8jRCswB6eb4aq2UswX3NKSVt6xQmZkMvfxdjtvFrGyF0hPUG4RE
 /ethH6Mns5Be77NYGu2v2Xh0Y2wQRUJDHGPn8VIS+T4lTXJ8+0DGhoiDvGDJrDMn4C6E
 tYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691593830; x=1692198630;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jfAbdbP+lNzWWVkLPvs4YNUHAxn9NY/LE5yLd2IKNIc=;
 b=F0IRY/5IyUkFRcAsc3o5rO8n350B1ps+xvNe/HEoYRCR8n/YimDHd3crDaUMVVHMLf
 w9vn+1XgkRdBtMJ6QJkPZeGBKlpQ2jIlSYd5wVZh/vvJyVjOA802RzsOjKZfyS+tsDgz
 J31b3pFJey0eubnWz+wwf5gxKwPQd9xli2Qi3F+tJxDO8uPj+P26fFiHcE3n2qBXHOQR
 2On7ljcKQIQKIcRU0QZvST5dsOpVBndu5BJ8gTYtUYfbVnxxJMaEl4mtttVo2S+wf9re
 OKQhqMvHXKLJJQwqukflsJ32C0ErlnDn/xixZo0kGJhosp5KpWaVd8SLmXsoSKEsYJ1j
 Ez+w==
X-Gm-Message-State: AOJu0Yxxun9BQFqLR38zW3QMuQw2NhYklRXB8USea5FR7kAHJA9Upg9o
 tPx/WRAc7XcIoglehu1nig4VyA==
X-Google-Smtp-Source: AGHT+IGCI3gmcveU1MvfWMrFh/39kZuNz7jLA+/iTe98skJxiEH4Inl3qq48rsXFQGO9pP5bxnvohQ==
X-Received: by 2002:a17:902:aa05:b0:1bb:8f37:dd0b with SMTP id
 be5-20020a170902aa0500b001bb8f37dd0bmr2891812plb.52.1691593829700; 
 Wed, 09 Aug 2023 08:10:29 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 r14-20020a170902be0e00b001bb99ea5d02sm11267409pls.4.2023.08.09.08.10.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 08:10:28 -0700 (PDT)
Message-ID: <1b400192-d622-02d9-0a3f-1b6d8dfc7eea@linaro.org>
Date: Wed, 9 Aug 2023 08:10:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 09/11] target/loongarch: Truncate high 32 bits of
 address in VA32 mode
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, gaosong@loongson.cn,
 i.qemu@xen0n.name, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230809083258.1787464-1-c@jia.je>
 <20230809083258.1787464-10-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230809083258.1787464-10-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/9/23 01:26, Jiajie Chen wrote:
> When running in VA32 mode(!LA64 or VA32L[1-3] matching PLV), virtual
> address is truncated to 32 bits before address mapping.
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> Co-authored-by: Richard Henderson<richard.henderson@linaro.org>
> ---
>   target/loongarch/cpu.c                        | 16 ++++----
>   target/loongarch/cpu.h                        |  9 +++++
>   target/loongarch/gdbstub.c                    |  2 +-
>   .../loongarch/insn_trans/trans_atomic.c.inc   |  5 ++-
>   .../loongarch/insn_trans/trans_branch.c.inc   |  3 +-
>   .../loongarch/insn_trans/trans_fmemory.c.inc  | 30 ++++-----------
>   target/loongarch/insn_trans/trans_lsx.c.inc   | 38 +++++--------------
>   .../loongarch/insn_trans/trans_memory.c.inc   | 34 +++++------------
>   target/loongarch/op_helper.c                  |  4 +-
>   target/loongarch/translate.c                  | 32 ++++++++++++++++
>   10 files changed, 85 insertions(+), 88 deletions(-)

Much better, thanks.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

