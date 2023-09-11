Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C17579A712
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 11:55:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfdd3-0004Kk-M2; Mon, 11 Sep 2023 05:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfdd1-0004KO-5k; Mon, 11 Sep 2023 05:54:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfdcy-0006Gn-0Q; Mon, 11 Sep 2023 05:54:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EA0BA20BD1;
 Mon, 11 Sep 2023 12:54:42 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 24404272F8;
 Mon, 11 Sep 2023 12:54:41 +0300 (MSK)
Message-ID: <cc3e0b0f-e4e1-71d0-bddd-f68aa56aa658@tls.msk.ru>
Date: Mon, 11 Sep 2023 12:54:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 6/7] hw/tpm: spelling fixes
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230909131258.354675-1-mjt@tls.msk.ru>
 <20230909131258.354675-7-mjt@tls.msk.ru>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230909131258.354675-7-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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


Stefan, can you take a quick look please?

https://patchew.org/QEMU/20230909131258.354675-1-mjt@tls.msk.ru/20230909131258.354675-7-mjt@tls.msk.ru/

Most of this is s/Familiy/Family/ in a few places, I guess it's
some copy-paste error.

09.09.2023 16:12, Michael Tokarev:
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   hw/tpm/tpm_tis.h        | 2 +-
>   hw/tpm/tpm_tis_common.c | 2 +-
>   hw/tpm/tpm_tis_i2c.c    | 4 ++--
>   hw/tpm/tpm_tis_isa.c    | 2 +-
>   hw/tpm/tpm_tis_sysbus.c | 2 +-
>   5 files changed, 6 insertions(+), 6 deletions(-)

Thanks,

/mjt


