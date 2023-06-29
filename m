Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BAA742036
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 08:13:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEksb-0007Sq-Vo; Thu, 29 Jun 2023 02:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEksY-0007SO-Hl
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 02:11:42 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEksW-0007zn-R9
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 02:11:42 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-311367a3e12so354305f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 23:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688019099; x=1690611099;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+srMgXYBAGEVnYNjJ/i7pDBh+SQzBTLl4KehVt+0o+o=;
 b=sA8OPkrdK8fJS+r/VNGK69fmWwP0f6VHt5Rd1ugJ01HsGkqjcI8y4aR+8y6g+IyA+9
 wUpcMhSCrK/E+W4eC3JQ3/IN+wcdrW4h61sEmwhWQ3+At2GNhrkmthc6D+bxpkxidi+5
 WkC+nPBWvvVCABzOqFLLS5kp+pDUwf53JVmyo0u9I0z5vy7yKr/tF1GEW03trG9IuLhT
 +Xwoa/TsKOgd86og4bE5w0iOYqc2nYnjh29peeViv4BCA80XEjYznSdsZd4yudAwuqj7
 /IxdFwNLQCKIVTXGgpJ54d8gQFoUT3R7IFFjj5Ul76PCDW3TmY2XzXdq5iLITHDkIBxl
 cGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688019099; x=1690611099;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+srMgXYBAGEVnYNjJ/i7pDBh+SQzBTLl4KehVt+0o+o=;
 b=NgaqW/3+hkjFjgtoCuhKVg7/b/0wGrzcRI2dX6l2hZOGQELMsYuw7FrhoQ3PSIx8Jp
 Bk6s0xYdFMmilZOMZIw4z1Z8g4cz4kGBmoxxDx8sHCjq+kjIRU0wI/No1a9E+TGaDajZ
 TNFNFebjq3Det9gqNf1oqNa9ID7RjhQAVaBjvMIzSAHGFEo31+1Aw902aOkE+UKGSvqe
 1oQBtaND7G81XdrTHa+XBDiw+/BieH7Omu1RT31zsZKh/QywYt5/IDz3RiQuMQqnd2jS
 Zc41zwXD0BiVOohlhpOtgeazRmBs8YnFX+LEEZN/10urGHI4NZxUhgmVTj+6PzUH9Ynn
 8nkA==
X-Gm-Message-State: AC+VfDwdsmk8zBZDzNG9raABvPgtmsMs9oP4YHqE4WuYUe5BpFnUDlq/
 IPP8atexR/YPu3wp9U+YSleSpQ==
X-Google-Smtp-Source: ACHHUZ5ksLaDAQdNeyksjCiuCMwcMn+nS0M7INHm7CBS9KdVkbbvTgMmhI6fDBwm4cAdwU/59uL7Lw==
X-Received: by 2002:adf:ffce:0:b0:311:1dba:ca65 with SMTP id
 x14-20020adfffce000000b003111dbaca65mr33737068wrs.51.1688019099006; 
 Wed, 28 Jun 2023 23:11:39 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a5d50cd000000b0030647d1f34bsm15229458wrt.1.2023.06.28.23.11.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 23:11:38 -0700 (PDT)
Message-ID: <61e95083-96ad-e8fc-ec7e-420d5c0f3e69@linaro.org>
Date: Thu, 29 Jun 2023 08:11:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/23] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20230628141526.293104-1-kwolf@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230628141526.293104-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/28/23 16:15, Kevin Wolf wrote:
> The following changes since commit 52ed34cbddde1cb89b2ac263e758e349a77f21e1:
> 
>    Merge tag 'pull-request-2023-06-26' ofhttps://gitlab.com/thuth/qemu  into staging (2023-06-26 10:38:41 +0200)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git  tags/for-upstream
> 
> for you to fetch changes up to 17362398ee1a7f04e8006a46333145d8b707fd35:
> 
>    block: use bdrv_co_debug_event in coroutine context (2023-06-28 09:46:34 +0200)
> 
> ----------------------------------------------------------------
> Block layer patches
> 
> - Re-enable the graph lock
> - More fixes to coroutine_fn marking

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~



