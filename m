Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB89B0B4ED
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Jul 2025 12:43:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udRUi-0001Dh-6V; Sun, 20 Jul 2025 06:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udRUc-00016l-1x
 for qemu-devel@nongnu.org; Sun, 20 Jul 2025 06:42:07 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udRUY-0001au-Pa
 for qemu-devel@nongnu.org; Sun, 20 Jul 2025 06:42:05 -0400
Received: from [157.82.206.39] ([157.82.206.39]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56KAfd8b081764
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 20 Jul 2025 19:41:39 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=mZgNzf33JFv2wFS/bw6FMB23Se8ESvofN4YA7VZBk/s=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1753008099; v=1;
 b=XgxamDUf1+QSX59oMphcRlrdGer+vHGqVRfZv6AUK7VPp3vMe4cB7L3qXbNX7VY6
 gdVqJQCLLpDm194vvNCHYUQoSt3cF77ZAfkd+FJVcUG30Ysnw6qGVwHACYxeT6FU
 5LtSUoWg4GziLNQPkibEgxxaDb5ljU+AajmtZDD1jGEV2yDHRHC5pM8Pfr6ykrwl
 ltFfkJRlzB1hTVorVnuRmvTgkimClTAHKy/ZgdoZQxHKM4KKKdQKGYUwhsbjUK5t
 MckQZS1jViOpP6uV5dQqynZLWGmSIp2ucIvWaLnEgFlzZIK5vDXAMf+s2tdYroGY
 SMJMIpNlUIsm1qe/gGi75g==
Message-ID: <18dd4847-769f-4c5d-8559-8647822d362a@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 20 Jul 2025 19:41:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 03/13] virtio: introduce extended features type
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
 <c1b14368e79fb3fd3cf402d7b03aed4449cdf0a8.1752828082.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <c1b14368e79fb3fd3cf402d7b03aed4449cdf0a8.1752828082.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/07/18 17:52, Paolo Abeni wrote:
> The virtio specifications allows for up to 128 bits for the
> device features. Soon we are going to use some of the 'extended'
> bits features (bit 64 and above) for the virtio net driver.
> 
> Represent the virtio features bitmask with a fixes size array, and
> introduce a few helpers to help manipulate them.
> 
> Most drivers will keep using only 64 bits features space: use union
> to allow them access the lower part of the extended space without any
> per driver change.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
>    - fix preprocessor guard name
>    - use BIT_ULL
>    - add missing parentheses
>    - use memcmp()
>    - _is_empty() -> _empty()
>    - _andnot() returns a bool, true if dst has any non zero bits
>    - _array -> _ex
> 
> v1 -> v2:
>    - use a fixed size array for features instead of uint128
>    - use union with u64 to reduce the needed code churn
> ---
>   include/hw/virtio/virtio-features.h | 123 ++++++++++++++++++++++++++++
>   include/hw/virtio/virtio.h          |   7 +-
>   2 files changed, 127 insertions(+), 3 deletions(-)
>   create mode 100644 include/hw/virtio/virtio-features.h
> 
> diff --git a/include/hw/virtio/virtio-features.h b/include/hw/virtio/virtio-features.h
> new file mode 100644
> index 0000000000..68e326e3e8
> --- /dev/null
> +++ b/include/hw/virtio/virtio-features.h
> @@ -0,0 +1,123 @@
> +/*
> + * Virtio features helpers
> + *
> + * Copyright 2025 Red Hat, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef QEMU_VIRTIO_FEATURES_H
> +#define QEMU_VIRTIO_FEATURES_H
> +
> +#include "qemu/bitops.h"
> +
> +#define VIRTIO_FEATURES_FMT        "%016"PRIx64"%016"PRIx64
> +#define VIRTIO_FEATURES_PR(f)      (f)[1], (f)[0]
> +
> +#define VIRTIO_FEATURES_MAX        128
> +#define VIRTIO_BIT(b)              BIT_ULL((b) % 64)
> +#define VIRTIO_DWORD(b)            ((b) >> 6)
> +#define VIRTIO_FEATURES_WORDS      (VIRTIO_FEATURES_MAX >> 5)
> +#define VIRTIO_FEATURES_DWORDS     (VIRTIO_FEATURES_WORDS >> 1)

These shifts are better to be replaced with division for clarity; 
BIT_WORD() is a good example.

"WORD" and "DWORD" should be avoided due to contradicting definitions 
common in QEMU as described at:
https://lore.kernel.org/qemu-devel/aab8c434-364e-4305-9d8b-943eb0c98406@rsg.ci.i.u-tokyo.ac.jp/

BITS_TO_U32S() is a good example this regard.

> +
> +#define VIRTIO_DECLARE_FEATURES(name)                        \
> +    union {                                                  \
> +        uint64_t name;                                       \
> +        uint64_t name##_ex[VIRTIO_FEATURES_DWORDS];          \
> +    }
> +
> +static inline void virtio_features_clear(uint64_t *features)
> +{
> +    memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_DWORDS);
> +}
> +
> +static inline void virtio_features_from_u64(uint64_t *features, uint64_t from)
> +{
> +    virtio_features_clear(features);
> +    features[0] = from;
> +}
> +
> +static inline bool virtio_has_feature_ex(const uint64_t *features,
> +                                         unsigned int fbit)
> +{
> +    assert(fbit < VIRTIO_FEATURES_MAX);
> +    return features[VIRTIO_DWORD(fbit)] & VIRTIO_BIT(fbit);
> +}
> +
> +static inline void virtio_add_feature_ex(uint64_t *features,
> +                                         unsigned int fbit)
> +{
> +    assert(fbit < VIRTIO_FEATURES_MAX);
> +    features[VIRTIO_DWORD(fbit)] |= VIRTIO_BIT(fbit);
> +}
> +
> +static inline void virtio_clear_feature_ex(uint64_t *features,
> +                                           unsigned int fbit)
> +{
> +    assert(fbit < VIRTIO_FEATURES_MAX);
> +    features[VIRTIO_DWORD(fbit)] &= ~VIRTIO_BIT(fbit);
> +}
> +
> +static inline bool virtio_features_equal(const uint64_t *f1,
> +                                         const uint64_t *f2)
> +{
> +    return !memcmp(f1, f2, sizeof(uint64_t) * VIRTIO_FEATURES_DWORDS);
> +}
> +
> +static inline bool virtio_features_use_extended(const uint64_t *features)

"extended" should be abbreviated as "ex" for consistency.

> +{
> +    int i;
> +
> +    for (i = 1; i < VIRTIO_FEATURES_DWORDS; ++i) {
> +        if (features[i]) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +static inline bool virtio_features_empty(const uint64_t *features)
> +{
> +    return !virtio_features_use_extended(features) && !features[0];
> +}
> +
> +static inline void virtio_features_copy(uint64_t *to, const uint64_t *from)
> +{
> +    memcpy(to, from, sizeof(to[0]) * VIRTIO_FEATURES_DWORDS);
> +}
> +
> +static inline bool virtio_features_andnot(uint64_t *to, const uint64_t *f1,
> +                                           const uint64_t *f2)
> +{
> +    uint64_t diff = 0;
> +    int i;
> +
> +    for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
> +        to[i] = f1[i] & ~f2[i];
> +        diff |= to[i];
> +    }
> +    return diff;
> +}
> +
> +static inline void virtio_features_and(uint64_t *to, const uint64_t *f1,
> +                                       const uint64_t *f2)
> +{
> +    int i;
> +
> +    for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
> +        to[i] = f1[i] & f2[i];
> +    }
> +}
> +
> +static inline void virtio_features_or(uint64_t *to, const uint64_t *f1,
> +                                       const uint64_t *f2)
> +{
> +    int i;
> +
> +    for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
> +        to[i] = f1[i] | f2[i];
> +    }
> +}
> +
> +#endif
> +
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index c594764f23..39e4059a66 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -16,6 +16,7 @@
>   
>   #include "system/memory.h"
>   #include "hw/qdev-core.h"
> +#include "hw/virtio/virtio-features.h"
>   #include "net/net.h"
>   #include "migration/vmstate.h"
>   #include "qemu/event_notifier.h"
> @@ -121,9 +122,9 @@ struct VirtIODevice
>        * backend (e.g. vhost) and could potentially be a subset of the
>        * total feature set offered by QEMU.
>        */
> -    uint64_t host_features;
> -    uint64_t guest_features;
> -    uint64_t backend_features;
> +    VIRTIO_DECLARE_FEATURES(host_features);
> +    VIRTIO_DECLARE_FEATURES(guest_features);
> +    VIRTIO_DECLARE_FEATURES(backend_features);
>   
>       size_t config_len;
>       void *config;


