Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1483770CAF1
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 22:27:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1C6y-00061I-8M; Mon, 22 May 2023 16:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q1C6m-0005q6-Pm; Mon, 22 May 2023 16:26:21 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q1C6h-0004xK-Qm; Mon, 22 May 2023 16:26:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2c24:0:640:73f8:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 4874660BEA;
 Mon, 22 May 2023 23:26:04 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b50f::1:35] (unknown
 [2a02:6b8:b081:b50f::1:35])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 3Qodgh2OmW20-QWEBRGZ2; Mon, 22 May 2023 23:26:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1684787163; bh=qjJCSlccghjDut0sTVTMT/Z61cXvKx0QmPG9tt4Ltlo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=w6cm+b12CXD+qQHUtlDntWkRCnHgVnYLJejRdr13DG7eLvzP6zTYgP//APn1cEu2S
 ociO21xZpiQkdaPivLmD8uT8VmTyV3USygwDSthq6ghOLUG4oK/fi3Di8LwXl6wVqv
 Rcq/qwS+LRdED0XpeVmuveZj4EY1gGEmmv7rixUQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b4127b37-1be6-91f5-aa76-429ef4e97a11@yandex-team.ru>
Date: Mon, 22 May 2023 23:26:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] qcow2: Explicit mention of padding bytes
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:qcow2" <qemu-block@nongnu.org>
References: <20230522184631.47211-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230522184631.47211-1-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 22.05.23 21:46, Eric Blake wrote:
> Although we already covered the need for padding bytes with our
> changes in commit 3ae3fcfa, commit 66fcbca5 (both v5.0.0) added one
> byte and relied on the rest of the text for implicitly covering 7
> padding bytes.  For consistency with other parts of the header (such
> as the header extension format listing padding from n - m, or the
> snapshot table entry listing variable padding), we might as well call
> out the remaining 7 bytes as padding until such time (as any) as they
> gain another meaning.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> ---
> 
> Spring cleaning my old branches.
> 
> v3: reviving an old patch; v2 was:
> https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg00687.html
> ---
>   docs/interop/qcow2.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index e7f036c286b..2c4618375ad 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -226,6 +226,7 @@ version 2.
>                       <https://www.zlib.net/> in QEMU. However, clusters with the
>                       deflate compression type do not have zlib headers.
> 
> +        105 - 111:  Padding, contents defined below.
> 


-- 
Best regards,
Vladimir


