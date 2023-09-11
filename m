Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8C379AA0D
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 18:13:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfjWY-0001aG-3v; Mon, 11 Sep 2023 12:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevans@FreeBSD.org>)
 id 1qfjWU-0001Yo-Jw; Mon, 11 Sep 2023 12:12:26 -0400
Received: from mx2.freebsd.org ([96.47.72.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevans@FreeBSD.org>)
 id 1qfjWR-0003pi-Tj; Mon, 11 Sep 2023 12:12:26 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4RksDh5rPQz4M7F;
 Mon, 11 Sep 2023 16:12:20 +0000 (UTC)
 (envelope-from kevans@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org
 [IPv6:2610:1c1:1:606c::24b:4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4RksDh54spz4J4n;
 Mon, 11 Sep 2023 16:12:20 +0000 (UTC)
 (envelope-from kevans@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1694448740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JGufa+JceiPalZlXuLYd0G31hkCqC3igM/PJvmrYqTo=;
 b=TpJR2XLaXtH+HH9DMD7nuEQktmNJ9A0jtRMYZKKI5YV/JipEA/QzClI9xovzPL5lw86dJP
 lWNa6rffLqZOhoExF/Nr5CRYk7bReGMFw5PZkS/ptfbeDRIqlBTMdHs4TLHWjg75NNnKVk
 zuVs/E3qAE/q3dYnWKv3Mh1McB3U7j6JOKnKkwv8ZG1mxE8Wt9fxAOEI/Oaxgwv/hp/P0P
 W92q740fRGybD0N7PKj5QNSrH5NYN+QDTNDMX1Fe9O6QwS7ILlvEQQ4Kb8O2m2n3Cvz9b1
 akgbvECl/a1JUHAoLo3dFalfYcSwnxDsswHDVKbtUA4+fSevLezBxkzmGA0Rlg==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1694448740; a=rsa-sha256; cv=none;
 b=PV0gbr+rmo61xOooSmQQl39faj8xEmb521/6Jpxv6In3py6iSLjKrzt1W92CgpXAMaHeic
 6AN9cG3vZQ2th8Xo7UGDk6Lrh2vHioDRTrA63wPa4hSHvloVuT0yqIjo/WNt3o+08ojKkd
 7CwDyO2iQgHzngIyaVBYttQx9zTLpgnCZ0rschMqx8tSu6PNydRF+nOAtbu8ZVqEP8yIau
 IT4fty985fNdTrgG19vwQW505iyDZ/TddUFfUUoIeOrEa7f4D2BEmhp7rfwJz5gK8mttRD
 SaWRJq++DmV7rUByvXTi4uMUv3+O/cafQxFRlNGLDKfEr6g0QiBxXIjubQkDuw==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1694448740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JGufa+JceiPalZlXuLYd0G31hkCqC3igM/PJvmrYqTo=;
 b=fEmIG4F4l/xlkMtE+AL5LtBkt06H8EyVVrseVcggm6v2Rherk+mlzS43Sitr9b8/Ax0Td8
 32oNnyz9qmBeMfN5fCzncYhx+wrdBRaXG+CJuU6GrT5uvvXOnDqHc4cO01kW8EM7WqbitM
 ZKHMSmsJZSoJU0t1/TtdErjfMo8B35x5pqfaV8A9S8N6SkEU03ftiqyq++u7n4aGAKQLlV
 1s26kftlWf2wddhsAfSrLn+8ZoxzZSQY0g3Owqrjza2S12e6FEyqRliWw32SNe3zIW5KdS
 8qX84LzBNFSLSE3n4rXzI9Ybzjl36XUYj1iuD2jkuQDz9RpZjo3/0HjGd1IG2A==
Received: from [10.9.4.95] (unknown [209.182.120.176])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 (Authenticated sender: kevans/mail)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4RksDh1Wqxz15d0;
 Mon, 11 Sep 2023 16:12:20 +0000 (UTC)
 (envelope-from kevans@FreeBSD.org)
Message-ID: <e7792841-4ca3-1a14-ecc8-1bfd1afed2e4@FreeBSD.org>
Date: Mon, 11 Sep 2023 11:12:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/7] bsd-user: spelling fixes
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Warner Losh <imp@bsdimp.com>
References: <20230909131258.354675-1-mjt@tls.msk.ru>
 <20230909131258.354675-2-mjt@tls.msk.ru>
 <adda04f3-d19b-a29f-6fbd-6d3d2ccf6357@tls.msk.ru>
From: Kyle Evans <kevans@FreeBSD.org>
In-Reply-To: <adda04f3-d19b-a29f-6fbd-6d3d2ccf6357@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=96.47.72.81; envelope-from=kevans@FreeBSD.org;
 helo=mx2.freebsd.org
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/11/23 03:39, Michael Tokarev wrote:
> Warner, Kyle, can you take a look please?
> 
> https://patchew.org/QEMU/20230909131258.354675-1-mjt@tls.msk.ru/20230909131258.354675-2-mjt@tls.msk.ru/
> 

Hmm, the original for this doesn't seem to have landed in my inbox, but 
these all look OK to me.


> 09.09.2023 16:12, Michael Tokarev:
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>> ---
>>   bsd-user/errno_defs.h                | 2 +-
>>   bsd-user/freebsd/target_os_siginfo.h | 2 +-
>>   bsd-user/freebsd/target_os_stack.h   | 4 ++--
>>   bsd-user/freebsd/target_os_user.h    | 2 +-
>>   bsd-user/qemu.h                      | 2 +-
>>   bsd-user/signal-common.h             | 4 ++--
>>   bsd-user/signal.c                    | 6 +++---
>>   7 files changed, 11 insertions(+), 11 deletions(-)
> 

Reviewed-by: Kyle Evans <kevans@FreeBSD.org>

Thanks,

Kyle Evans


