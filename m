Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BB0713390
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 11:02:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2pn8-0004Ef-8N; Sat, 27 May 2023 05:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q2pmz-0004EQ-9V
 for qemu-devel@nongnu.org; Sat, 27 May 2023 05:00:41 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q2pmx-0002Qu-5v
 for qemu-devel@nongnu.org; Sat, 27 May 2023 05:00:40 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 36AAC8CD1;
 Sat, 27 May 2023 12:00:16 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A156A7CDA;
 Sat, 27 May 2023 12:00:15 +0300 (MSK)
Message-ID: <b70ce1ef-32c6-b645-be61-bd9a2e204952@tls.msk.ru>
Date: Sat, 27 May 2023 12:00:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Mauro Matteo Cascella <mcascell@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH] hw/sd/sdhci: reset data count in
 sdhci_buff_access_is_sequential()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, FAKE_REPLY_A1=0.001,
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

Mon, 7 Nov 2022 11:35:10 +0100, you wrote:
 > Make sure to reset data_count if it's equal to (or exceeds) block_size.
 > This prevents an off-by-one read / write when accessing s->fifo_buffer
 > in sdhci_read_dataport / sdhci_write_dataport, both called right after
 > sdhci_buff_access_is_sequential.
 >
 > Fixes: CVE-2022-3872

..

Has this been forgotten, or maybe a better fix is needed?

https://lists.nongnu.org/archive/html/qemu-devel/2022-11/msg01068.html

Thanks,

/mjt

