Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF4A7B5D6C
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 00:56:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnRpM-0003Tc-9U; Mon, 02 Oct 2023 18:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qnRpI-0003Sz-EX
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 18:55:44 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qnRpB-0003S2-NL
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 18:55:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2D89526E1F;
 Tue,  3 Oct 2023 01:56:19 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 610AE2C45A;
 Tue,  3 Oct 2023 01:55:35 +0300 (MSK)
Message-ID: <1531b1d7-2c8c-4a69-109a-170bd686d894@tls.msk.ru>
Date: Tue, 3 Oct 2023 01:55:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/8] migration fixes
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20230918172822.19052-1-farosas@suse.de>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230918172822.19052-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -91
X-Spam_score: -9.2
X-Spam_bar: ---------
X-Spam_report: (-9.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.321,
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

18.09.2023 20:28, Fabiano Rosas wrote:
> This series contains fixes for the two currently know failures that
> show up in migration tests plus a set of fixes for some theoretical
> race conditions around QEMUFile handling.
> 
> Patch 1 addresses the issue found in the postcopy/preempt/plain test:
> https://gitlab.com/qemu-project/qemu/-/issues/1886
> 
> Patch 7 fixes a rare crash during the postocpy/preempt/recovery/plain test:
> 
>    Thread 7 "return path" received signal SIGSEGV, Segmentation fault.
>        0x00005555560e4893 in qemu_file_get_error_obj (f=0x0, errp=0x0) at ../migration/qemu-file.c:154
>        154         return f->last_error;
> 
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1008652837
> 
> Fabiano Rosas (7):
>    migration: Fix possible race when setting rp_state.error
>    migration: Fix possible races when shutting down the return path
>    migration: Fix possible race when shutting down to_dst_file
>    migration: Remove redundant cleanup of postcopy_qemufile_src
>    migration: Consolidate return path closing code
>    migration: Replace the return path retry logic
>    migration: Move return path cleanup to main migration thread
> 
> Peter Xu (1):
>    migration: Fix race that dest preempt thread close too early
> 
>   migration/migration.c    | 145 +++++++++++++++------------------------
>   migration/migration.h    |  14 +++-
>   migration/postcopy-ram.c |  38 +++++++++-
>   3 files changed, 106 insertions(+), 91 deletions(-)

What can be done for -stable?

At least the whole thing applies cleanly to 8.1.

Thanks,

/mjt

