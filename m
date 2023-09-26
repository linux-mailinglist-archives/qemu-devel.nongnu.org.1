Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9157AF56C
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:42:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlEs8-0007sM-PL; Tue, 26 Sep 2023 16:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlEs6-0007rs-H5
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:41:30 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlEs3-0002qb-KR
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:41:30 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 03ADA6075A;
 Tue, 26 Sep 2023 23:41:24 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b41d::1:39] (unknown
 [2a02:6b8:b081:b41d::1:39])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id MfWkDs0OkmI0-nmfuOQx7; Tue, 26 Sep 2023 23:41:23 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695760883;
 bh=NANvJLQMjCj6I4VeCgW5kxz0erBdJrjdFIUVeL1Mu/E=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ZUMO24QT5+zJD5K/kQLRA32N/esczDZXi7LJZuA21bZbFJfkNkP9YU1IgL4w/knNY
 OiA4zjKTztaJQqdm4MgETvd/Sz4fDq1l9p8w9aC4JmbdQ5eXurQQzy8e/589T+dXJT
 14NrFrRDBlEdzuqAAsRI6HyB8C3an8pRZCyZGmXY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f7ecb5e2-46d1-3e54-39f8-48ea2f845991@yandex-team.ru>
Date: Tue, 26 Sep 2023 23:41:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] i386/a-b-bootblock: zero the first byte of each page
 on start
Content-Language: en-US
To: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru
References: <20230907192944.1609099-1-d-tatianin@yandex-team.ru>
 <20230907192944.1609099-3-d-tatianin@yandex-team.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230907192944.1609099-3-d-tatianin@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 07.09.23 22:29, Daniil Tatianin wrote:
> The migration qtest all the way up to this point used to work by sheer
> luck relying on the contents of all pages from 1MiB to 100MiB to contain
> the same one value in the first byte initially.
> 
> This easily breaks if we reduce the amount of RAM for the test instances
> from 150MiB to e.g 110MiB since that makes SeaBIOS dirty some of the
> pages starting at about 0x5dd2000 (~93 MiB) as it reuses those for the
> HighMemory allocator since commit dc88f9b72df ("malloc: use large
> ZoneHigh when there is enough memory").
> 
> This would result in the following errors:
>      12/60 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 ERROR           2.74s   killed by signal 6 SIGABRT
>      stderr:
>      Memory content inconsistency at 5dd2000 first_byte = cc last_byte = cb current = 9e hit_edge = 1
>      Memory content inconsistency at 5dd3000 first_byte = cc last_byte = cb current = 89 hit_edge = 1
>      Memory content inconsistency at 5dd4000 first_byte = cc last_byte = cb current = 23 hit_edge = 1
>      Memory content inconsistency at 5dd5000 first_byte = cc last_byte = cb current = 31 hit_edge = 1
>      Memory content inconsistency at 5dd6000 first_byte = cc last_byte = cb current = 70 hit_edge = 1
>      Memory content inconsistency at 5dd7000 first_byte = cc last_byte = cb current = ff hit_edge = 1
>      Memory content inconsistency at 5dd8000 first_byte = cc last_byte = cb current = 54 hit_edge = 1
>      Memory content inconsistency at 5dd9000 first_byte = cc last_byte = cb current = 64 hit_edge = 1
>      Memory content inconsistency at 5dda000 first_byte = cc last_byte = cb current = 1d hit_edge = 1
>      Memory content inconsistency at 5ddb000 first_byte = cc last_byte = cb current = 1a hit_edge = 1
>      and in another 26 pages**
>      ERROR:../tests/qtest/migration-test.c:300:check_guests_ram: assertion failed: (bad == 0)
> 
> Fix this by always zeroing the first byte of each page in the range so
> that we get consistent results no matter the initial contents.
> 
> Fixes: ea0c6d62391 ("test: Postcopy")
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>   tests/migration/i386/a-b-bootblock.S |  9 +++++++++
>   tests/migration/i386/a-b-bootblock.h | 16 ++++++++--------
>   2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/migration/i386/a-b-bootblock.S b/tests/migration/i386/a-b-bootblock.S
> index 036216e4a7..6bb9999d60 100644
> --- a/tests/migration/i386/a-b-bootblock.S
> +++ b/tests/migration/i386/a-b-bootblock.S
> @@ -44,6 +44,15 @@ start:             # at 0x7c00 ?
>   
>           # bl keeps a counter so we limit the output speed
>           mov $0, %bl
> +
> +pre_zero:
> +        mov $TEST_MEM_START,%eax
> +do_zero:
> +        movb $0, (%eax)
> +        add $4096,%eax
> +        cmp $TEST_MEM_END,%eax
> +        jl do_zero
> +
>   mainloop:
>           mov $TEST_MEM_START,%eax
>   innerloop:
> diff --git a/tests/migration/i386/a-b-bootblock.h b/tests/migration/i386/a-b-bootblock.h
> index b7b0fce2ee..5b523917ce 100644
> --- a/tests/migration/i386/a-b-bootblock.h
> +++ b/tests/migration/i386/a-b-bootblock.h
> @@ -4,18 +4,18 @@
>    * the header and the assembler differences in your patch submission.
>    */
>   unsigned char x86_bootsect[] = {
> -  0xfa, 0x0f, 0x01, 0x16, 0x78, 0x7c, 0x66, 0xb8, 0x01, 0x00, 0x00, 0x00,
> +  0xfa, 0x0f, 0x01, 0x16, 0x8c, 0x7c, 0x66, 0xb8, 0x01, 0x00, 0x00, 0x00,
>     0x0f, 0x22, 0xc0, 0x66, 0xea, 0x20, 0x7c, 0x00, 0x00, 0x08, 0x00, 0x00,
>     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xe4, 0x92, 0x0c, 0x02,
>     0xe6, 0x92, 0xb8, 0x10, 0x00, 0x00, 0x00, 0x8e, 0xd8, 0x66, 0xb8, 0x41,
>     0x00, 0x66, 0xba, 0xf8, 0x03, 0xee, 0xb3, 0x00, 0xb8, 0x00, 0x00, 0x10,
> -  0x00, 0xfe, 0x00, 0x05, 0x00, 0x10, 0x00, 0x00, 0x3d, 0x00, 0x00, 0x40,
> -  0x06, 0x7c, 0xf2, 0xfe, 0xc3, 0x80, 0xe3, 0x3f, 0x75, 0xe6, 0x66, 0xb8,
> -  0x42, 0x00, 0x66, 0xba, 0xf8, 0x03, 0xee, 0xeb, 0xdb, 0x8d, 0x76, 0x00,
> -  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00,
> -  0x00, 0x9a, 0xcf, 0x00, 0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00,
> -  0x27, 0x00, 0x60, 0x7c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0xc6, 0x00, 0x00, 0x05, 0x00, 0x10, 0x00, 0x00, 0x3d, 0x00, 0x00,
> +  0x40, 0x06, 0x7c, 0xf1, 0xb8, 0x00, 0x00, 0x10, 0x00, 0xfe, 0x00, 0x05,
> +  0x00, 0x10, 0x00, 0x00, 0x3d, 0x00, 0x00, 0x40, 0x06, 0x7c, 0xf2, 0xfe,
> +  0xc3, 0x80, 0xe3, 0x3f, 0x75, 0xe6, 0x66, 0xb8, 0x42, 0x00, 0x66, 0xba,
> +  0xf8, 0x03, 0xee, 0xeb, 0xdb, 0x8d, 0x76, 0x00, 0x00, 0x00, 0x00, 0x00,
> +  0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00, 0x00, 0x9a, 0xcf, 0x00,
> +  0xff, 0xff, 0x00, 0x00, 0x00, 0x92, 0xcf, 0x00, 0x27, 0x00, 0x74, 0x7c,
>     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,


I understand the idea of patch, but don't follow why and how this boot sector is changed. Could you note it in commit message?

-- 
Best regards,
Vladimir


