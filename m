Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 292A5772A10
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:04:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2iV-0000uX-Mj; Mon, 07 Aug 2023 12:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qT2iS-0000nG-KL
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:04:20 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qT2iQ-0003xI-Ph
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:04:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 45F0818B8F;
 Mon,  7 Aug 2023 19:04:17 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 78C6D1C1AE;
 Mon,  7 Aug 2023 19:04:15 +0300 (MSK)
Message-ID: <e4743a2d-35dd-542d-2887-0af0f1790ba8@tls.msk.ru>
Date: Mon, 7 Aug 2023 19:04:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] configure: Fix linux-user host detection for riscv64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>
Cc: qemu-devel@nongnu.org
References: <20230805180214.57198-1-richard.henderson@linaro.org>
 <CACPK8XdWpOhwKrdxh+NoMMkP=63g7ib1PdXSrR8f1snAsLu8Nw@mail.gmail.com>
 <609387ae-de8e-61bf-842a-b277ecfc345c@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <609387ae-de8e-61bf-842a-b277ecfc345c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -86
X-Spam_score: -8.7
X-Spam_bar: --------
X-Spam_report: (-8.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.809,
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

07.08.2023 19:00, Richard Henderson пишет:

> I'll figure out something else.

Paolo already sent a patchset, see "linux-user, configure: fix CPU canonicalization"
> r~
> 


