Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 681B277B225
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 09:13:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVRkx-00023N-1V; Mon, 14 Aug 2023 03:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qVRkt-00023E-HO
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 03:12:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qVRkr-0008Mt-Pw
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 03:12:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 22D2F1A319;
 Mon, 14 Aug 2023 10:12:37 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 63C211E3DB;
 Mon, 14 Aug 2023 10:12:35 +0300 (MSK)
Message-ID: <97d04dd0-6182-9b61-576c-1a29f856e2c4@tls.msk.ru>
Date: Mon, 14 Aug 2023 10:12:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: util/async-teardown.c: is it really needed for --disable-system
 build?
Content-Language: en-US
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <744ac8a7-dd6b-2ce4-3f47-250812241d0e@tls.msk.ru>
 <a2f99abb-7ad6-41b4-1b74-ab7dba3d2424@tls.msk.ru>
 <20230814090108.472547d8@p-imbrenda>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230814090108.472547d8@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -112
X-Spam_score: -11.3
X-Spam_bar: -----------
X-Spam_report: (-11.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.359,
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

14.08.2023 10:01, Claudio Imbrenda wrote:

> I think we could guard the offending item with CONFIG_SOFTMMU for now,
> to immediately fix the issues you raised, and do the refactoring you
> proposed later (e.g. next cycle).

I don't think rushing for the last-minute fix is necessary in this case.
It has real build problem on ia64 only which does not work for several
releases anyway, and the linking of unnecessary pieces happened for a
long time too.

/mjt

