Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A34078E27F
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 00:46:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbTvd-00052R-VY; Wed, 30 Aug 2023 18:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbTvc-00052J-MQ
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:44:48 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbTva-0000ex-HP
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:44:48 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5694a117254so236518a12.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 15:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693435485; x=1694040285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QWHBcuonO53KwWQJec5LV7KUHQ1SmCtKI4OFxGrmXTM=;
 b=GsNl2Io5H5tEkZ8/uTrhjBz2MBbXssw4LzBtEq2IX7BlA3+ENjVB4DbhLX12WWIn2N
 2iqhoInDI81HcjKwd7VqLrue2sn6ttLt9abMNQmxGWc9MWZ/1vC5XvERH7klbzBQKjup
 qJgHyu8Ui+UP11PkVWXs3iNl4nMQT5efGzQ36iFYDNibg/aSn7rHC2u6ns1k1qaQCsHt
 4FhAfFGUZWJnX8IeUSrcIMgaWbsdkitKFzppil6CMKizkSY4CjUqqR9e+m1iGQHEAvTA
 Kjm+yzvukHMI4rs13DW3jRPeMaginUB5ea11CQ6Gf+PbVyXdVRawDT0IRZgahWDI9mTU
 Fzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693435485; x=1694040285;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QWHBcuonO53KwWQJec5LV7KUHQ1SmCtKI4OFxGrmXTM=;
 b=BuYEEEVGmpQFTLXPSu33xwIo+OTszK9BRFDqc1GzLngYDpvyHT9j1NrBxA3mnnBfz6
 fV3db918Nr9550w6stDMzuR4OLbyjgETA7zlFX8OltMwepPdP7Su7HaB5bps7lR0o0dt
 /eNWPK0HfonleszLFAD/PHazodecl5VFJOYf0bI7ez+X0c/5BA+zoCZKJd8W5dzKHz4A
 1kPF9fRQJDLQWeFogh9t57EnNyho/jN4eRQR4uNM/o1XZzmhOklCVG+nIs+kZeutDPT4
 pKZEcoP/fEXTkgH8CDsqxKSjY4wgXl8odjp4/BSRRmgMGEqYnhP7kvoBqfekglZ2VzQd
 8IUw==
X-Gm-Message-State: AOJu0Yxk6TXwe5ZvsOklT+0wmOvX9UTdG9PgeQbRVRk+LPMVufhANH5k
 o69uzu0eRW8A+U0oBCaqqmWQ5Q==
X-Google-Smtp-Source: AGHT+IGH2NF9X08SdVsL4TNU3t0WE5G8B4d8YVdGal3DvsRvXVI6e/yLOiN8RZqzu2kKsLuUTYP+8w==
X-Received: by 2002:a05:6a20:d419:b0:14c:c986:d105 with SMTP id
 il25-20020a056a20d41900b0014cc986d105mr3171042pzb.45.1693435484830; 
 Wed, 30 Aug 2023 15:44:44 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a656a8f000000b00553dcfc2179sm88955pgu.52.2023.08.30.15.44.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 15:44:44 -0700 (PDT)
Message-ID: <cb9a0a83-d794-a633-6497-b46baa39ff12@linaro.org>
Date: Wed, 30 Aug 2023 15:44:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 24/48] target/loongarch: Implement
 xvmskltz/xvmskgez/xvmsknz
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-25-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-25-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 01:48, Song Gao wrote:
> This patch includes:
> - XVMSKLTZ.{B/H/W/D};
> - XVMSKGEZ.B;
> - XVMSKNZ.B.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insns.decode                |  7 ++
>   target/loongarch/disas.c                     |  7 ++
>   target/loongarch/vec_helper.c                | 80 ++++++++++++++------
>   target/loongarch/insn_trans/trans_lasx.c.inc |  7 ++
>   4 files changed, 76 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

