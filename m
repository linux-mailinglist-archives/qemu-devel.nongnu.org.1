Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C6B726305
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:39:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6uJP-00026y-Bk; Wed, 07 Jun 2023 10:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q6uJJ-000256-71
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:38:54 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q6uJH-0006fd-8M
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:38:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2c24:0:640:73f8:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 5BB9F608F5;
 Wed,  7 Jun 2023 17:38:43 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b5a3::1:2b] (unknown
 [2a02:6b8:b081:b5a3::1:2b])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id gcVass1OpW20-MfXHFk8C; Wed, 07 Jun 2023 17:38:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1686148722; bh=iU3h6j1agIOF1kyMsNJC9MyrecYtj2EC62NefQK+gsc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=EEg+lLQFmGCHGDySvRj1sULbnXoAPKbE0fBsLNSs4RL5vnETxvyeKPr5tUMN94OKX
 gULkBo9tnb/9XEMxIRFcNX16FKQ4N43FqWmqT+kRlcmTf/hE7teMR1pAsAfhI79vj/
 FoALQTAooU/GCuxIn0+3zCvK5HVXO3seX5HndBcU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9be02919-305d-9373-e26c-9d3e9c1a8421@yandex-team.ru>
Date: Wed, 7 Jun 2023 17:38:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] gitlab: Disable io-raw-194 for build-tcg-disabled
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, berrange@redhat.com, jsnow@redhat.com
References: <20230606162556.58110-1-richard.henderson@linaro.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230606162556.58110-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 06.06.23 19:25, Richard Henderson wrote:
> This test consistently fails on Azure cloud build hosts in
> a way that suggests a timing problem in the test itself:
> 
> --- .../194.out
> +++ .../194.out.bad
> @@ -14,7 +14,6 @@
>   {"return": {}}
>   {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>   {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> -{"data": {"status": "postcopy-active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>   {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>   Gracefully ending the `drive-mirror` job on source...
>   {"return": {}}
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   .gitlab-ci.d/buildtest.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 0f1be14cb6..000062483f 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -236,7 +236,7 @@ build-tcg-disabled:
>       - cd tests/qemu-iotests/
>       - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
>               052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 163
> -            170 171 183 184 192 194 208 221 226 227 236 253 277 image-fleecing
> +            170 171 183 184 192 208 221 226 227 236 253 277 image-fleecing
>       - ./check -qcow2 028 051 056 057 058 065 068 082 085 091 095 096 102 122
>               124 132 139 142 144 145 151 152 155 157 165 194 196 200 202
>               208 209 216 218 227 234 246 247 248 250 254 255 257 258


There is actually a bug in the test, I've sent a patch:

<20230607143606.1557395-1-vsementsov@yandex-team.ru>
[PATCH] iotests: fix 194: filter out racy postcopy-active event

-- 
Best regards,
Vladimir


