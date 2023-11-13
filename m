Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DF37EA281
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:03:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bGE-0007n7-1f; Mon, 13 Nov 2023 13:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2bFq-0007me-Hs; Mon, 13 Nov 2023 13:01:46 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2bFn-0005fm-7j; Mon, 13 Nov 2023 13:01:44 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B09A532D2A;
 Mon, 13 Nov 2023 21:01:45 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 66DD634E4C;
 Mon, 13 Nov 2023 21:01:29 +0300 (MSK)
Message-ID: <7af5d33d-e661-4945-987e-41ac5f623b15@tls.msk.ru>
Date: Mon, 13 Nov 2023 21:01:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Stable-8.1.3 00/55] Patch Round-up for stable 8.1.3, freeze on
 2023-11-19
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
 <5d226848-8af5-41ee-a353-6bc53902085d@ventanamicro.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <5d226848-8af5-41ee-a353-6bc53902085d@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

13.11.2023 20:44, Daniel Henrique Barboza wrote:

> It would be good to have these 2:
> 
> 082e9e4a58 ("target/riscv/kvm: improve 'init_multiext_cfg' error msg")
> 608bdebb60 ("target/riscv/kvm: support KVM_GET_REG_LIST")
> 
> The first is an error msg fix. The second fixes a problem with KVM guests when
> running Linux 6.6 and QEMU 8.1.

Sure.

> This is not a clear cherry-pick though. I'll send both in separate for you
> convenience. Thanks,

Actually both are trivial to cherry-pick. First is a clear c-p, second needs
a trivial context fix (where in the file to place the new functions, that's
kvm_riscv_init_user_properties() thing).  The rest goes as-is.

I've picked up both.  Thank you!

/mjt

