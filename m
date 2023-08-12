Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8243A779EAE
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 11:49:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUlEU-0007LF-M8; Sat, 12 Aug 2023 05:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qUlEL-0007Ky-Bm
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 05:48:21 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qUlEJ-0004Ze-JX
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 05:48:21 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 46C4F19F8F;
 Sat, 12 Aug 2023 12:48:25 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C9A431DF52;
 Sat, 12 Aug 2023 12:48:14 +0300 (MSK)
Message-ID: <a2f99abb-7ad6-41b4-1b74-ab7dba3d2424@tls.msk.ru>
Date: Sat, 12 Aug 2023 12:48:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: util/async-teardown.c: is it really needed for --disable-system
 build?
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
To: QEMU Developers <qemu-devel@nongnu.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <744ac8a7-dd6b-2ce4-3f47-250812241d0e@tls.msk.ru>
In-Reply-To: <744ac8a7-dd6b-2ce4-3f47-250812241d0e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -78
X-Spam_score: -7.9
X-Spam_bar: -------
X-Spam_report: (-7.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.972,
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

12.08.2023 12:38, Michael Tokarev wrote:
...
> It smells like, at the very least, os-posix.c should be split. We shouldn't include
> a ton of qemu-system functionality (like very specific option parsing) into qemu-nbd
> for example.
> 
> How about splitting os-posix.c into a few files in util/ (not in the root dir), and
> adding them to util_ss in case of posix-os?  Ditto for os-win32.c, I guess, but I
> haven't looked at this.
> 
> And for the question in $subj, this one needs to be guarded by CONFIG_SOFTMMU.

Or maybe better yet, put the softmmu-specific functions (one very good example here
is os_parse_cmd_args() function - it clearly belongs to softmmu/, it should never
has been in global os-foo.c but in some softmmu-os-foo.c instead.  This way,
async-teardown.c is moved to softmmu/ too, maybe os-linux-async-teardown.c.

/mjt

