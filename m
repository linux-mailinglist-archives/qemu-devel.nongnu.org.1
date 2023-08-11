Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA3B778FE3
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 14:50:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qURZl-0008PM-4o; Fri, 11 Aug 2023 08:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qURZi-0008Om-9L
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 08:49:06 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qURZg-0006n9-0g
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 08:49:05 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F4566000C;
 Fri, 11 Aug 2023 12:48:58 +0000 (UTC)
Message-ID: <0e67c8b5-adfe-029a-d999-8aab52e0f7ad@ovn.org>
Date: Fri, 11 Aug 2023 14:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: i.maximets@ovn.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: don't zero out memory region cache for indirect
 descriptors
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230807222847.2837393-1-i.maximets@ovn.org>
 <CACGkMEs8qVpaJCc=1jUyY_8-NE23fsjQBwSrbAn8n3sjihuv5g@mail.gmail.com>
From: Ilya Maximets <i.maximets@ovn.org>
In-Reply-To: <CACGkMEs8qVpaJCc=1jUyY_8-NE23fsjQBwSrbAn8n3sjihuv5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org
Received-SPF: pass client-ip=217.70.183.195; envelope-from=i.maximets@ovn.org;
 helo=relay3-d.mail.gandi.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.972,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/9/23 04:37, Jason Wang wrote:
> On Tue, Aug 8, 2023 at 6:28 AM Ilya Maximets <i.maximets@ovn.org> wrote:
>>
>> Lots of virtio functions that are on a hot path in data transmission
>> are initializing indirect descriptor cache at the point of stack
>> allocation.  It's a 112 byte structure that is getting zeroed out on
>> each call adding unnecessary overhead.  It's going to be correctly
>> initialized later via special init function.  The only reason to
>> actually initialize right away is the ability to safely destruct it.
>> However, we only need to destruct it when it was used, i.e. when a
>> desc_cache points to it.
>>
>> Removing these unnecessary stack initializations improves throughput
>> of virtio-net devices in terms of 64B packets per second by 6-14 %
>> depending on the case.  Tested with a proposed af-xdp network backend
>> and a dpdk testpmd application in the guest, but should be beneficial
>> for other virtio devices as well.
>>
>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> Btw, we can probably remove MEMORY_REGION_CACHE_INVALID.

Good point.  I can include that in the patch.  Or just replace it
with a function, as Stefan suggested.

Best regards, Ilya Maximets.

