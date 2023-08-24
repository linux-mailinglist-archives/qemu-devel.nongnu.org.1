Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6879578670D
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 07:18:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ2iI-00013w-JA; Thu, 24 Aug 2023 01:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qZ2i1-000116-I4
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 01:16:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qZ2hx-0001dl-T6
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 01:16:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5F5BD1C7F5;
 Thu, 24 Aug 2023 08:16:44 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 38B46216A4;
 Thu, 24 Aug 2023 08:16:24 +0300 (MSK)
Message-ID: <26ee7b25-c92d-ddca-5257-cfc12b54d18e@tls.msk.ru>
Date: Thu, 24 Aug 2023 08:16:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] softmmu: Fix dirtylimit memory leak
Content-Language: en-US
To: alloc.young@outlook.com, yong.huang@smartx.com
Cc: qemu-devel@nongnu.org
References: <SA1PR11MB67606FB284BF14ED9F11D436F51CA@SA1PR11MB6760.namprd11.prod.outlook.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <SA1PR11MB67606FB284BF14ED9F11D436F51CA@SA1PR11MB6760.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.684,
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

23.08.2023 10:47, alloc.young@outlook.com wrote:
> From: "alloc.young" <alloc.young@outlook.com>
> 
> Fix memory leak in hmp_info_vcpu_dirty_limit,use g_autoptr
> handle memory deallocation, alse use g_free to match g_malloc
> && g_new functions.

"..use g_autoptr TO handle.." ("to" is missing).
"alse" - I guess should be "Also".

I think it is better to split this into two parts, one fixing
the memleak and another converting to g_free().

/mjt

