Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD61E7C95FE
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 21:03:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrjtW-0006lU-Mb; Sat, 14 Oct 2023 15:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qrjtC-0006lI-Bq
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 15:01:30 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qrjtA-0002uA-EO
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 15:01:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C18C72A5D8
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 22:01:27 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B6AED2F23A
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 22:01:15 +0300 (MSK)
Message-ID: <4e1201e9-2bd4-4af7-aac2-91833284ac1e@tls.msk.ru>
Date: Sat, 14 Oct 2023 22:01:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: sector size = 4096?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi!

I wanted to experiment with sector size = 4096, to see how an OS
reacts.  And naturally, the first instinct is to try it in qemu.
But it turned to be.. difficult.

First, there's no documentation.  But I remember seeing properties
of ide-hd device, like physical_sector_size etc.  Ok.

  $ qemu-img create -f raw img 32G

  $ kvm -machine q35 -drive file=img,format=raw,if=none,id=d \
    -device ide-hd,drive=d,physical_sector_size=4096

This way, the guest see size of the drive as 0.  This is obviously
not right (tm).

Okay, lets try full 4096 sectors:

    -device ide-hd,drive=d,physical_sector_size=4096,logical_sector_size=4096

This fails:

    discard_granularity must be a multiple of logical_block_size

Let's adjust discard_granularity (I think it'd be good if qemu does
this based on physical_sector_size already):

    -device ide-hd,drive=d,physical_sector_size=4096,logical_sector_size=4096,discard_granularity=0

This fails:

   logical_block_size must be 512 for IDE

Huh? Should the tell all the sata Advanced-Format (AF) drives manufacturers
their drives does not exist, or what? :)


Ok.  Tried the same with nvme.  There, sector sizes seems to be entirely
ignored, - no matter which values I choose, guest always see them as
512.


What's the proper way to run guest with 4096-byte sector size in qemu?

Thanks,

/mjt

