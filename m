Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C20579D9F4
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 22:19:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg9r6-0005ho-V9; Tue, 12 Sep 2023 16:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qg9qm-0005hX-9q
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 16:19:08 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qg9qj-0005Mf-Ea
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 16:19:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 01B3A21397;
 Tue, 12 Sep 2023 23:19:08 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6AEAB2797F;
 Tue, 12 Sep 2023 23:19:03 +0300 (MSK)
Message-ID: <b3188e1e-f5ec-ae3d-97de-b5b30f778c5b@tls.msk.ru>
Date: Tue, 12 Sep 2023 23:19:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] tpm: fix crash when FD >= 1024
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230911132551.1421276-1-marcandre.lureau@redhat.com>
 <dcf26f94-4b0b-e992-1207-a1ee73f21508@linux.ibm.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <dcf26f94-4b0b-e992-1207-a1ee73f21508@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

12.09.2023 03:08, Stefan Berger пишет:
> 
> On 9/11/23 09:25, marcandre.lureau@redhat.com wrote:
>> From: Marc-Andr޸ Lureau <marcandre.lureau@redhat.com>
>>
>> Replace select() with poll() to fix a crash when QEMU has a large number
>> of FDs.
>>
>> Fixes:
>> https://bugzilla.redhat.com/show_bug.cgi?id=2020133
> 
> Fixes:  ca64b08638 ("tpm: Move backend code under the 'backends/' directory")

Heh. I noticed this only now.  No, this is not the commit which introduced
the breakage.  It is either

commit 56a3c24ffc11955ddc7bb21362ca8069a3fc8c55
Author: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date:   Tue May 26 16:51:06 2015 -0400

     tpm: Probe for connected TPM 1.2 or TPM 2

which introduced select() in the first place (provided similar select()
hasn't been used in there before.  Or some other commit somewhere else
which allowed to have large number of filedescriptors - provided it wasn't
possible before.  But definitely not a commit which just moved file into
another subdir :)

/mjt

