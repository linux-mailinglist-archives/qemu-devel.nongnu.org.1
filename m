Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB61761B0C
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:11:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOIjf-0003DG-4e; Tue, 25 Jul 2023 10:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIjZ-0003Co-GF; Tue, 25 Jul 2023 10:09:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIjX-0007ED-RR; Tue, 25 Jul 2023 10:09:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D5E1E16162;
 Tue, 25 Jul 2023 17:09:50 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 953E5194FA;
 Tue, 25 Jul 2023 17:09:48 +0300 (MSK)
Message-ID: <df32d67b-58be-71e9-e37f-fe288f7bd8fa@tls.msk.ru>
Date: Tue, 25 Jul 2023 17:09:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Stable-8.0.4 00/31] Patch Round-up for stable 8.0.4, freeze on
 2023-08-05
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
 <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

25.07.2023 16:45, Michael Tokarev wrote:
...

Also these 4 commits which I forgot to include:

32 c34ad459926f Thomas Huth:
    target/loongarch: Fix the CSRRD CPUID instruction on big endian hosts
33 206e91d14330 Viktor Prutyanov:
    virtio-pci: add handling of PCI ATS and Device-TLB enable/disable
34 ee071f67f7a1 Viktor Prutyanov:
    vhost: register and change IOMMU flag depending on Device-TLB state
35 cd9b83468843 Viktor Prutyanov:
    virtio-net: pass Device-TLB enable/disable events to vhost

/mjt

