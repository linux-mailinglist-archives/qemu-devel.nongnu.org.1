Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9AE76F909
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 06:38:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRmZe-0000el-Jy; Fri, 04 Aug 2023 00:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qRmZb-0000SQ-Lc
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 00:37:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qRmZZ-0007md-R8
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 00:37:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 94CFA17DE5;
 Fri,  4 Aug 2023 07:38:15 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 476601B544;
 Fri,  4 Aug 2023 07:37:56 +0300 (MSK)
Message-ID: <7be03948-149c-af9f-1ad5-6f020e00571a@tls.msk.ru>
Date: Fri, 4 Aug 2023 07:37:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PULL 13/22] pci: do not respond config requests after PCI device
 eject
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <cover.1691101215.git.mst@redhat.com>
 <348e354417b64c484877354ee7cc66f29fa6c7df.1691101215.git.mst@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <348e354417b64c484877354ee7cc66f29fa6c7df.1691101215.git.mst@redhat.com>
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

04.08.2023 01:21, Michael S. Tsirkin wrote:
> From: Yuri Benditovich <yuri.benditovich@daynix.com>
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2224964
> 
> In migration with VF failover, Windows guest and ACPI hot
> unplug we do not need to satisfy config requests, otherwise
> the guest immediately detects the device and brings up its
> driver. Many network VF's are stuck on the guest PCI bus after
> the migration.
> 
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> Message-Id: <20230728084049.191454-1-yuri.benditovich@daynix.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Is it a stable-8.0 (and stable-7.2) material?

Thanks,

/mjt

