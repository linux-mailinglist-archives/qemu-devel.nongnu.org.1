Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F0C763336
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 12:13:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qObVt-0005KU-1j; Wed, 26 Jul 2023 06:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qObVh-0005KD-UV; Wed, 26 Jul 2023 06:12:50 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qObVg-0004DS-7Z; Wed, 26 Jul 2023 06:12:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 02FBC164A6;
 Wed, 26 Jul 2023 13:12:48 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 280BE197CE;
 Wed, 26 Jul 2023 13:12:44 +0300 (MSK)
Message-ID: <2684d072-c13b-2d12-c7d4-ba987961f2dc@tls.msk.ru>
Date: Wed, 26 Jul 2023 13:12:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Stable-8.0.4 00/31] Patch Round-up for stable 8.0.4, freeze on
 2023-08-05
Content-Language: en-US
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
 <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
 <20230726120727.755b478e.olaf@aepfle.de>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230726120727.755b478e.olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

26.07.2023 13:07, Olaf Hering пишет:
> Tue, 25 Jul 2023 16:45:17 +0300 Michael Tokarev <mjt@tls.msk.ru>:
> 
>> Please respond here or CC qemu-stable@nongnu.org on any additional patches
>> you think should (or shouldn't) be included in the release.
> 
> Consider 497fad38979c16b6412388927401e577eba43d26 ("pc-bios/keymaps: Use the official xkb name for Arabic layout, not the legacy synonym").
> Otherwise it will start to FTBFS in Tumbleweed from now on.

https://gitlab.com/qemu-project/qemu/-/commits/stable-8.0/

This one is included in 8.0.3 and 7.2.4 already, picked up for the previous
stable series/releases.

Thanks,

/mjt


