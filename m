Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D125C78D7B5
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 18:56:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbOTO-0007SK-RP; Wed, 30 Aug 2023 12:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qbOTK-0007S1-TP
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:55:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qbOTI-0004yK-Ea
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:55:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6DE3D1E018;
 Wed, 30 Aug 2023 19:55:41 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 03C32247F0;
 Wed, 30 Aug 2023 19:55:08 +0300 (MSK)
Message-ID: <aa868e42-334d-50f3-29fb-19ffa6fda72f@tls.msk.ru>
Date: Wed, 30 Aug 2023 19:55:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PULL 1/3] softmmu: Fix dirtylimit memory leak
Content-Language: en-US
To: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
Cc: "alloc.young" <alloc.young@outlook.com>
References: <cover.1693322363.git.yong.huang@smartx.com>
 <ff118704fa5498c64a55d7a732fd42515fdc356c.1693322363.git.yong.huang@smartx.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <ff118704fa5498c64a55d7a732fd42515fdc356c.1693322363.git.yong.huang@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.242,
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

29.08.2023 18:29, Hyman Huang wrote:
> From: "alloc.young" <alloc.young@outlook.com>
> 
> Fix memory leak in hmp_info_vcpu_dirty_limit,use g_autoptr
> to handle memory deallocation.

It does not feel like -stable-worthy, or am I wrong and it should be picked up
for -stable?

Thanks,

/mjt

