Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F34836DE6
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 18:40:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRyHz-0007vv-5Z; Mon, 22 Jan 2024 12:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRyHt-0007tc-Id
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:40:45 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRyHr-0004S3-8e
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:40:44 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-337cf4ac600so3227725f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 09:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705945241; x=1706550041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5iBpbXLf/I89NcN4YOYTD0SsIZ+CEeM9pmCfbAhKbGA=;
 b=UJXv6bhfKFcjujNDXzPLzajsmKIQpA7f8C0zKbaq231RzPl67HUDr7f+s2i3Oyvfwv
 e5NFIUdHOG1sOn3/d3rVNiTA9lyKtcFTUN7ta40uvlFrKAM4KNXlwZeJqOgOjdDsHwIe
 WnEIH2virkCOl9nV9UCixjNze6zrLf3JXFW4xTVEyBNQvPpvbGhObTow8GSPocI+UYQo
 hHt2IEtJMUcbhub36O2fS2NfCfBkNHxr8ae3/DoaBa6zYHkNKjPSQt09nqT6ovfTPdr5
 2AFALFByGmTN7wf13GLh9lzHH3Y4Uzb0V8HYWyZLsA50OSlq5eXu+EmpvbAlMPZr4P53
 uu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705945241; x=1706550041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5iBpbXLf/I89NcN4YOYTD0SsIZ+CEeM9pmCfbAhKbGA=;
 b=KRSWbDhR8fjhGkPPjTuNQrNfBXErq1kKL5sAD34JqoVba6F3pznAHWFZdEM1US6KOH
 6OwKIyhCF4NhQwK01oGqjE/jT2r9H9y/1ITGtZPKKqd0cKSU9TMaSzK9WNFJlA+3vshD
 QDpsSTIzz60owIBq1u/SLAdZD2bgLXDOU3oVzjANNILK+aTOQcNhzQZgmV92xtpGaqSM
 v3XpigDAjOzUfjwWoQFj5sqIGAIIN/WsktuuWpD00AhymwXfsSJn/BGaDoJMUprH+hGj
 k6a3W5N7E5tqR/tgTeT0TE0T6xDHGEv/6gu9zjw3qLjhALhSdZpq9OPExnlWiNoKxmQU
 yEXQ==
X-Gm-Message-State: AOJu0Yyh1U4CTe95R1YV6AwJrHf67d2gR3vx41HMe8EkMkMfloe7l3ZF
 O0fzWYJYlIkZHKHIDt2oeyBO9V1u1D2PPGs2RjXdfw/fQzMt6nb60lNL1A0tmLI=
X-Google-Smtp-Source: AGHT+IEwl1yivr07/emeJfGLFhbipogDKP8jMDv767/YF/382hj55T1kn8rH1oG4TzZvlbJVs2X+lQ==
X-Received: by 2002:adf:9bc9:0:b0:337:be5f:b633 with SMTP id
 e9-20020adf9bc9000000b00337be5fb633mr2244974wrc.104.1705945241489; 
 Mon, 22 Jan 2024 09:40:41 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.57])
 by smtp.gmail.com with ESMTPSA id
 v4-20020a5d6784000000b0033940bc04fesm150031wru.16.2024.01.22.09.40.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 09:40:41 -0800 (PST)
Message-ID: <f0a09fe4-83fc-4573-82e1-e19741d93987@linaro.org>
Date: Mon, 22 Jan 2024 18:40:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bswap.h: Fix const_le64() macro
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Ira Weiny <ira.weiny@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
References: <20240122173735.472951-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240122173735.472951-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 22/1/24 18:37, Peter Maydell wrote:
> The const_le64() macro introduced in commit 845d80a8c7b187 turns out
> to have a bug which means that on big-endian systems the compiler
> complains if the argument isn't already a 64-bit type. This hasn't
> caused a problem yet, because there are no in-tree uses, but it
> means it's not possible for anybody to add one without it failing CI.
> 
> This example is from an attempted use of it with the argument '0',
> from the s390 CI runner's gcc:
> 
> ../block/blklogwrites.c: In function ‘blk_log_writes_co_do_log’:
> ../include/qemu/bswap.h:148:36: error: left shift count >= width of
> type [-Werror=shift-count-overflow]
> 148 | ((((_x) & 0x00000000000000ffU) << 56) | \
> | ^~
> ../block/blklogwrites.c:409:27: note: in expansion of macro ‘const_le64’
> 409 | .nr_entries = const_le64(0),
> | ^~~~~~~~~~
> ../include/qemu/bswap.h:149:36: error: left shift count >= width of
> type [-Werror=shift-count-overflow]
> 149 | (((_x) & 0x000000000000ff00U) << 40) | \
> | ^~
> ../block/blklogwrites.c:409:27: note: in expansion of macro ‘const_le64’
> 409 | .nr_entries = const_le64(0),
> | ^~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Fix this by making all the constants in the macro have the ULL
> suffix.  This will cause them all to be 64-bit integers, which means
> the result of the logical & will also be an unsigned 64-bit type,
> even if the input to the macro is a smaller type, and so the shifts
> will be in range.
> 
> Fixes: 845d80a8c7b187 ("qemu/bswap: Add const_le64()")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Tested 'by hand' on the s390 box that was complaining about
> Kevin's pullreq.
> ---
>   include/qemu/bswap.h | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


