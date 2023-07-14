Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3937753B7C
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 15:07:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKIVV-0007eh-QQ; Fri, 14 Jul 2023 09:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKIVG-0007dr-Ls; Fri, 14 Jul 2023 09:06:37 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKIVE-0003PK-6N; Fri, 14 Jul 2023 09:06:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 78BAD13E6F;
 Fri, 14 Jul 2023 16:06:44 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6520B14C19;
 Fri, 14 Jul 2023 16:06:28 +0300 (MSK)
Message-ID: <da54c444-8066-9d06-faf5-f1484e899686@tls.msk.ru>
Date: Fri, 14 Jul 2023 16:06:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH, trivial 01/29] tree-wide spelling fixes in comments and
 some messages: block
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
 <20230714113834.1186117-2-mjt@tls.msk.ru>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230714113834.1186117-2-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

14.07.2023 14:38, Michael Tokarev:

> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -69,3 +69,3 @@ typedef struct BlockCopyCallState {
>       /*
> -     * Fields that report information about return values and erros.
> +     * Fields that report information about return values and errors.
>        * Protected by lock in BlockCopyState.
> @@ -464,3 +464,3 @@ static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
>    *
> - * No sync here: nor bitmap neighter intersecting requests handling, only copy.
> + * No sync here: nor bitmap neither intersecting requests handling, only copy.

This should be reworded too. Fixed in git:

    No sync here: neither bitmap nor intersecting requests handling, only copy.

/mjt

