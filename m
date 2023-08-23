Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A30847859F2
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:01:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYoPR-0001yt-Np; Wed, 23 Aug 2023 10:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYoPC-0001vs-Se
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:00:19 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYoPA-0005XI-Bg
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:00:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8962E1C63E;
 Wed, 23 Aug 2023 17:00:29 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 97A6E21538;
 Wed, 23 Aug 2023 17:00:10 +0300 (MSK)
Message-ID: <8d9ab679-240e-7e42-8abc-eff80d2e5893@tls.msk.ru>
Date: Wed, 23 Aug 2023 17:00:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PULL 09/12] include/hw/virtio/virtio-gpu: Fix virtio-gpu with
 blob on big endian hosts
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230823114544.216520-1-thuth@redhat.com>
 <20230823114544.216520-10-thuth@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230823114544.216520-10-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.684,
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

23.08.2023 14:45, Thomas Huth wrpte:
> Using "-device virtio-gpu,blob=true" currently does not work on big
> endian hosts (like s390x). The guest kernel prints an error message
> like:
> 
>   [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* response 0x1200 (command 0x10c)
> 
> and the display stays black. When running QEMU with "-d guest_errors",
> it shows an error message like this:
> 
>   virtio_gpu_create_mapping_iov: nr_entries is too big (83886080 > 16384)
> 
> which indicates that this value has not been properly byte-swapped.
> And indeed, the virtio_gpu_create_blob_bswap() function (that should
> swap the fields in the related structure) fails to swap some of the
> entries. After correctly swapping all missing values here, too, the
> virtio-gpu device is now also working with blob=true on s390x hosts.
> 
> Fixes: e0933d91b1 ("virtio-gpu: Add virtio_gpu_resource_create_blob")
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2230469
> Message-Id: <20230815122007.928049-1-thuth@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

This smells like -stable material. Please let me know if it is not.
e0933d91b1 is 6.1.

Thanks,

/mjt

