Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C18CB05310
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Jul 2025 09:26:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uba38-0000KM-ET; Tue, 15 Jul 2025 03:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uba35-0000Jl-6B
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 03:25:59 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uba30-0004ss-Pr
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 03:25:58 -0400
Received: from [10.105.8.218] ([192.51.222.130]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56F7OTRR015997
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 15 Jul 2025 16:24:29 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=9nCJnifq9BE533TzaKfZRThu+mQoxlYg9DpJVBSqeF8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1752564270; v=1;
 b=W0oL2jEsaD1blnThVd4Hbp/LS+l1GFFqY4U4jvfCsiKMIq37UBoosu4DPavEgS24
 jxam+COoG9BUE6qw3Rab4XOrXcB5zCRYm/7bYA4T8k8TSwYma/RnBEj/jamYjjrG
 9JSibfdcwXtY0wIs7gxU/HmPTi4x4vtcYvs3iooCcTF4/1r7xMZeWghrnYu6Xi2G
 7dL6dG7lb47XPknC7OnLzIihA2FZYNUooA7GPiOiQWUde+qkiv+mdbZ13EQ6HOmC
 +p9ayzDv6EcyzrpkG5pLaRGHUdUZ7CbKOrx5bedkx7Gr3zHGxqjMdX8azNa4MIDU
 C0lIzWicPkinhqf+i+ruPg==
Message-ID: <08285c9c-f522-4c64-ba3b-4fa533e42962@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 15 Jul 2025 16:24:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 04/13] virtio: serialize extended features state
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 kvm@vger.kernel.org
References: <cover.1752229731.git.pabeni@redhat.com>
 <d0f97a8157c718dcb0799353394e1469153c6b22.1752229731.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <d0f97a8157c718dcb0799353394e1469153c6b22.1752229731.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/07/11 22:02, Paolo Abeni wrote:
> If the driver uses any of the extended features (i.e. above 64),
> serialize the full features range (128 bits).
> 
> This is one of the few spots that need explicitly to know and set
> in stone the extended features array size; add a build bug to prevent
> breaking the migration should such size change again in the future:
> more serialization plumbing will be needed.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>   - uint128_t -> u64[2]
> ---
>   hw/virtio/virtio.c | 97 ++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 86 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 82a285a31d..6a313313dd 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2954,6 +2954,24 @@ static const VMStateDescription vmstate_virtio_disabled = {
>       }
>   };
>   
> +static bool virtio_128bit_features_needed(void *opaque)
> +{
> +    VirtIODevice *vdev = opaque;
> +
> +    return virtio_features_use_extended(vdev->host_features_array);
> +}
> +
> +static const VMStateDescription vmstate_virtio_128bit_features = {
> +    .name = "virtio/128bit_features",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = &virtio_128bit_features_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64_ARRAY(guest_features_array, VirtIODevice, 2),

We only need to save the second element so it can be reduced to:
VMSTATE_UINT64(guest_features_array[1], VirtIODevice)

> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static const VMStateDescription vmstate_virtio = {
>       .name = "virtio",
>       .version_id = 1,
> @@ -2963,6 +2981,7 @@ static const VMStateDescription vmstate_virtio = {
>       },
>       .subsections = (const VMStateDescription * const []) {
>           &vmstate_virtio_device_endian,
> +        &vmstate_virtio_128bit_features,
>           &vmstate_virtio_64bit_features,
>           &vmstate_virtio_virtqueues,
>           &vmstate_virtio_ringsize,
> @@ -3059,23 +3078,30 @@ const VMStateInfo  virtio_vmstate_info = {
>       .put = virtio_device_put,
>   };
>   
> -static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val)
> +static int virtio_set_features_nocheck(VirtIODevice *vdev, const uint64_t *val)
>   {
>       VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
> -    bool bad = (val & ~(vdev->host_features)) != 0;
> +    uint64_t tmp[VIRTIO_FEATURES_DWORDS];
> +    bool bad;
> +
> +    virtio_features_andnot(tmp, val, vdev->host_features_array);
> +    bad = !virtio_features_is_empty(tmp);

bitmap_andnot() returns a value representing if some bit in the 
resulting bitmap is set. We can remove the virtio_features_is_empty() 
call if virtio_features_andnot() does the same.

> +
> +    virtio_features_and(tmp, val, vdev->host_features_array);
>   
> -    val &= vdev->host_features;
>       if (k->set_features) {
> -        k->set_features(vdev, val);
> +        bad = bad || virtio_features_use_extended(tmp);
> +        k->set_features(vdev, tmp[0]);
>       }
> -    vdev->guest_features = val;
> +
> +    virtio_features_copy(vdev->guest_features_array, tmp);
>       return bad ? -1 : 0;
>   }
>   
>   typedef struct VirtioSetFeaturesNocheckData {
>       Coroutine *co;
>       VirtIODevice *vdev;
> -    uint64_t val;
> +    uint64_t val[VIRTIO_FEATURES_DWORDS];
>       int ret;
>   } VirtioSetFeaturesNocheckData;
>   
> @@ -3094,12 +3120,41 @@ virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev, uint64_t val)
>           VirtioSetFeaturesNocheckData data = {
>               .co = qemu_coroutine_self(),
>               .vdev = vdev,
> -            .val = val,
>           };
> +        virtio_features_from_u64(data.val, val);
>           aio_bh_schedule_oneshot(qemu_get_current_aio_context(),
>                                   virtio_set_features_nocheck_bh, &data);
>           qemu_coroutine_yield();
>           return data.ret;
> +    } else {
> +        uint64_t features[VIRTIO_FEATURES_DWORDS];
> +        virtio_features_from_u64(features, val);
> +        return virtio_set_features_nocheck(vdev, features);
> +    }
> +}
> +
> +static void virtio_set_128bit_features_nocheck_bh(void *opaque)

"128bit" should be omitted for consistency with 
virtio_set_features_nocheck() and for extensibility.

> +{
> +    VirtioSetFeaturesNocheckData *data = opaque;
> +
> +    data->ret = virtio_set_features_nocheck(data->vdev, data->val);
> +    aio_co_wake(data->co);
> +}
> +
> +static int coroutine_mixed_fn
> +virtio_set_128bit_features_nocheck_maybe_co(VirtIODevice *vdev,
> +                                            const uint64_t *val)
> +{
> +    if (qemu_in_coroutine()) {
> +        VirtioSetFeaturesNocheckData data = {
> +            .co = qemu_coroutine_self(),
> +            .vdev = vdev,
> +        };
> +        virtio_features_copy(data.val, val);
> +        aio_bh_schedule_oneshot(qemu_get_current_aio_context(),
> +                                virtio_set_128bit_features_nocheck_bh, &data);
> +        qemu_coroutine_yield();
> +        return data.ret;
>       } else {
>           return virtio_set_features_nocheck(vdev, val);
>       }
> @@ -3107,6 +3162,7 @@ virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev, uint64_t val)
>   
>   int virtio_set_features(VirtIODevice *vdev, uint64_t val)
>   {
> +    uint64_t features[VIRTIO_FEATURES_DWORDS];
>       int ret;
>       /*
>        * The driver must not attempt to set features after feature negotiation
> @@ -3122,7 +3178,8 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
>                         __func__, vdev->name);
>       }
>   
> -    ret = virtio_set_features_nocheck(vdev, val);
> +    virtio_features_from_u64(features, val);
> +    ret = virtio_set_features_nocheck(vdev, features);
>       if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
>           /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
>           int i;
> @@ -3145,6 +3202,7 @@ void virtio_reset(void *opaque)
>   {
>       VirtIODevice *vdev = opaque;
>       VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
> +    uint64_t features[VIRTIO_FEATURES_DWORDS];
>       int i;
>   
>       virtio_set_status(vdev, 0);
> @@ -3171,7 +3229,8 @@ void virtio_reset(void *opaque)
>       vdev->start_on_kick = false;
>       vdev->started = false;
>       vdev->broken = false;
> -    virtio_set_features_nocheck(vdev, 0);
> +    virtio_features_clear(features);
> +    virtio_set_features_nocheck(vdev, features);
>       vdev->queue_sel = 0;
>       vdev->status = 0;
>       vdev->disabled = false;
> @@ -3254,7 +3313,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>        * Note: devices should always test host features in future - don't create
>        * new dependencies like this.
>        */
> -    vdev->guest_features = features;
> +    virtio_features_from_u64(vdev->guest_features_array, features);
>   
>       config_len = qemu_get_be32(f);
>   
> @@ -3333,7 +3392,23 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>           vdev->device_endian = virtio_default_endian();
>       }
>   
> -    if (virtio_64bit_features_needed(vdev)) {
> +    /*
> +     * Serialization needs constant size features array. Avoid
> +     * silently breaking migration should the feature space increase
> +     * even more in the (far away) future

Serialization is not done here and irrlevant.

> +     */
> +    QEMU_BUILD_BUG_ON(VIRTIO_FEATURES_DWORDS != 2);
> +    if (virtio_128bit_features_needed(vdev)) {

There is no need to distinguish virtio_128bit_features_needed() and 
virtio_64bit_features_needed() here.

For the 32-bit case, it will be simpler to have an array here and use 
virtio_set_128bit_features_nocheck_maybe_co() instead of having 
virtio_set_features_nocheck_maybe_co().

> +        uint64_t *val = vdev->guest_features_array;
> +
> +        if (virtio_set_128bit_features_nocheck_maybe_co(vdev, val) < 0) {
> +            error_report("Features 0x" VIRTIO_FEATURES_FMT " unsupported. "
> +                         "Allowed features: 0x" VIRTIO_FEATURES_FMT,
> +                         VIRTIO_FEATURES_PR(val),
> +                         VIRTIO_FEATURES_PR(vdev->host_features_array));
> +            return -1;
> +        }
> +    } else if (virtio_64bit_features_needed(vdev)) {
>           /*
>            * Subsection load filled vdev->guest_features.  Run them
>            * through virtio_set_features to sanity-check them against


