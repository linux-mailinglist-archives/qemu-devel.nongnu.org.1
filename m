Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 217D87083AD
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:12:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzeMN-0006r0-NQ; Thu, 18 May 2023 10:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzeMK-0006pA-30; Thu, 18 May 2023 10:12:00 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzeME-0005Hf-3S; Thu, 18 May 2023 10:11:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 97D696F6A;
 Thu, 18 May 2023 17:11:50 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9ED8C6436;
 Thu, 18 May 2023 17:11:49 +0300 (MSK)
Message-ID: <399dc9dc-6a82-4468-cdb1-6ba394a6d26c@tls.msk.ru>
Date: Thu, 18 May 2023 17:11:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8.0.1 00/36] Patch Round-up for stable 8.0.1, freeze on
 2023-05-27
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org
References: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
 <jwgbzdtl72ewm2nzsil3fp2ie7f3gysqsfgsw5kr5g7fst2qgb@hc7v7yxk6mci>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <jwgbzdtl72ewm2nzsil3fp2ie7f3gysqsfgsw5kr5g7fst2qgb@hc7v7yxk6mci>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -94
X-Spam_score: -9.5
X-Spam_bar: ---------
X-Spam_report: (-9.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.544,
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

18.05.2023 16:32, Eric Blake wrote:
..
> Here's a trio probably worth including:
> 
> 403d18ae384 migration: Handle block device inactivation fa
> 5d39f44d7ac migration: Minor control flow simplification
> 6dab4c93ecf migration: Attempt disk reactivation in more f
> 
> (the middle one is pointless on its own, but reduces conflict
> resolution in the third)

Picked up. Good stuff.  Especially thank you for the middle one
which reduces the conflict resolution.

Thanks!

/mjt


