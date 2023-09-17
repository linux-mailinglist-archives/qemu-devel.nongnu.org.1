Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C867A353E
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 12:47:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhpIk-0000O2-SR; Sun, 17 Sep 2023 06:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qhpIi-0000Nr-Hc
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 06:46:52 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qhpIg-0002mo-MT
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 06:46:52 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1qhpIR-00050A-FF; Sun, 17 Sep 2023 12:46:35 +0200
Message-ID: <75866f2e-13c3-220e-cea8-bebc983b8cf7@maciej.szmigiero.name>
Date: Sun, 17 Sep 2023 12:46:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 12/16] memory-device, vhost: Support automatic decision
 on the number of memslots
Content-Language: en-US, pl-PL
To: David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Gavin Shan <gshan@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
References: <20230908142136.403541-1-david@redhat.com>
 <20230908142136.403541-13-david@redhat.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
In-Reply-To: <20230908142136.403541-13-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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

On 8.09.2023 16:21, David Hildenbrand wrote:
> We want to support memory devices that can automatically decide how many
> memslots they will use. In the worst case, they have to use a single
> memslot.
> 
> The target use cases are virtio-mem and the hyper-v balloon.
> 
> Let's calculate a reasonable limit such a memory device may use, and
> instruct the device to make a decision based on that limit. Use a simple
> heuristic that considers:
> * A memslot soft-limit for all memory devices of 256; also, to not
>    consume too many memslots -- which could harm performance.
> * Actually still free and unreserved memslots
> * The percentage of the remaining device memory region that memory device
>    will occupy.
> 
> Further, while we properly check before plugging a memory device whether
> there still is are free memslots, we have other memslot consumers (such as
> boot memory, PCI BARs) that don't perform any checks and might dynamically
> consume memslots without any prior reservation. So we might succeed in
> plugging a memory device, but once we dynamically map a PCI BAR we would
> be in trouble. Doing accounting / reservation / checks for all such
> users is problematic (e.g., sometimes we might temporarily split boot
> memory into two memslots, triggered by the BIOS).
> 
> We use the historic magic memslot number of 509 as orientation to when
> supporting 256 memory devices -> memslots (leaving 253 for boot memory and
> other devices) has been proven to work reliable. We'll fallback to
> suggesting a single memslot if we don't have at least 509 total memslots.
> 
> Plugging vhost devices with less than 509 memslots available while we
> have memory devices plugged that consume multiple memslots due to
> automatic decisions can be problematic. Most configurations might just fail
> due to "limit < used + reserved", however, it can also happen that these
> memory devices would suddenly consume memslots that would actually be
> required by other memslot consumers (boot, PCI BARs) later. Note that this
> has always been sketchy with vhost devices that support only a small number
> of memslots; but we don't want to make it any worse.So let's keep it simple
> and simply reject plugging such vhost devices in such a configuration.
> 
> Eventually, all vhost devices that want to be fully compatible with such
> memory devices should support a decent number of memslots (>= 509).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

I would be nice to ultimately allow raising the 509 memslot limit,
considering that KVM had supported 32k memslots for more than two years
now and had a much more scalable implementation since early 2022.

Thanks,
Maciej


