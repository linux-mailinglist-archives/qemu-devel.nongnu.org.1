Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE457042F1
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 03:33:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyjYF-0005hJ-1s; Mon, 15 May 2023 21:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1pyjYC-0005gm-KK
 for qemu-devel@nongnu.org; Mon, 15 May 2023 21:32:28 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1pyjY7-0007LU-ND
 for qemu-devel@nongnu.org; Mon, 15 May 2023 21:32:28 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64ab2a37812so1841552b3a.1
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 18:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1684200733; x=1686792733;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RpFS+o596UuNCRTC6zMx1HZJFi7BEMF9vR79SS1IHd0=;
 b=dFZn7O6GsUjqhZDwOiFnQiDV0oVMbBjQFOtuukq2CPqdsYX5XbU6YgkkM3TQVSQDOg
 XSqsbR1MNA6ABAlhMZLyMHOA8wxn0z9D4FZhTGJi4boEduXuy/0+YZbWoLKEC2VrT3NX
 gR8Xo9YxI2Z4Z2vt7ZzQ0QVa5U2h5MNm1jTNFuu3XghMjV3QvWaY+mHPtGzw4Ka/qZwv
 /VkoiKAvED5BK468+vI0w2kDQK10mArZeWNdTwI09XgADwgxYSw32VXSAcwuzugPVgDs
 PUPVrZJNCbHE3wGO8Oz/9no4aRbaYzP+BjvG+ttJSie9Km4QWzMZersFQwfaxZ0405bc
 4e9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684200733; x=1686792733;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RpFS+o596UuNCRTC6zMx1HZJFi7BEMF9vR79SS1IHd0=;
 b=Tw9e4+wKn9XZjBOehb35EZPKfEvhhPW6t240pMQaGj/HNUyf3AXbsgOrrCWl+rKj+P
 ew3dIp9xw3p43CeVAMgdy3/MR1kJ5cU6tr1K5G4J8J1qp9PdXU51t0urAVQB1fx15k4O
 JFu6vqhHjW8bTUEwnAUVgYI82v87aRl+TyTcavsJ6UX3RrV9+XdEkRdJM8KmgW8usT+i
 vFm7mZYAqmFcagO4iKCe13jGCg+4cUZHZa6EFZcLPZ5LZfzOtPq9Jx6ij4eEQOYg1T0y
 FuoLqsxVFmOakngF5KyXpjrzdekzDiaOLFK/z8QqKe+O1ospIrqY5LaLvr2gK4tB4wu+
 pnCQ==
X-Gm-Message-State: AC+VfDwqlyFo02gXHM9Ufaio8keXm/ibhGI7h3NFBcCbhoq5qWDRzL1N
 GTrv9ynmMIRNu+Fz+dGqJN+xtQ==
X-Google-Smtp-Source: ACHHUZ7Lpr/1mKjk/q0aDRF5+1UfcwYSwqBMle8lkRQ+p9HC+qbCwXv8JP8ruj4EE8WXYPStzEOJ8g==
X-Received: by 2002:a17:903:1c6:b0:1a9:581b:fbb1 with SMTP id
 e6-20020a17090301c600b001a9581bfbb1mr39894905plh.32.1684200732930; 
 Mon, 15 May 2023 18:32:12 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.6]) by smtp.gmail.com with ESMTPSA id
 n10-20020a170902e54a00b001ac741dfd29sm14157221plf.295.2023.05.15.18.32.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 May 2023 18:32:12 -0700 (PDT)
Message-ID: <07cb08d2-6c31-1c96-50e9-499386d01b5a@bytedance.com>
Date: Tue, 16 May 2023 09:30:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] cryptodev-vhost-user: add asymmetric crypto support
Content-Language: en-US
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Anoob Joseph <anoobj@marvell.com>
References: <20230514065519.2335265-1-gmuthukrishn@marvell.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20230514065519.2335265-1-gmuthukrishn@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.811,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 5/14/23 14:55, Gowrishankar Muthukrishnan wrote:
> Add asymmetric crypto support in vhost_user backend.
> 
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> ---
>   backends/cryptodev-vhost-user.c |  9 +++---
>   hw/virtio/vhost-user.c          | 52 ++++++++++++++++++++++++---------
>   2 files changed, 43 insertions(+), 18 deletions(-)
> 
> diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
> index b1d9eb735f..c3283ba84a 100644
> --- a/backends/cryptodev-vhost-user.c
> +++ b/backends/cryptodev-vhost-user.c
> @@ -232,9 +232,9 @@ static void cryptodev_vhost_user_init(
>       backend->conf.max_auth_key_len = VHOST_USER_MAX_AUTH_KEY_LEN;
>   }
>   
> -static int64_t cryptodev_vhost_user_sym_create_session(
> +static int64_t cryptodev_vhost_user_crypto_create_session(
>              CryptoDevBackend *backend,
> -           CryptoDevBackendSymSessionInfo *sess_info,
> +           CryptoDevBackendSessionInfo *sess_info,
>              uint32_t queue_index, Error **errp)
>   {
>       CryptoDevBackendClient *cc =
> @@ -266,18 +266,17 @@ static int cryptodev_vhost_user_create_session(
>              void *opaque)
>   {
>       uint32_t op_code = sess_info->op_code;
> -    CryptoDevBackendSymSessionInfo *sym_sess_info;
>       int64_t ret;
>       Error *local_error = NULL;
>       int status;
>   
>       switch (op_code) {
>       case VIRTIO_CRYPTO_CIPHER_CREATE_SESSION:
> +    case VIRTIO_CRYPTO_AKCIPHER_CREATE_SESSION:
>       case VIRTIO_CRYPTO_HASH_CREATE_SESSION:
>       case VIRTIO_CRYPTO_MAC_CREATE_SESSION:
>       case VIRTIO_CRYPTO_AEAD_CREATE_SESSION:
> -        sym_sess_info = &sess_info->u.sym_sess_info;
> -        ret = cryptodev_vhost_user_sym_create_session(backend, sym_sess_info,
> +        ret = cryptodev_vhost_user_crypto_create_session(backend, sess_info,
>                      queue_index, &local_error);
>           break;
>   
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index e5285df4ba..c3f5ecd112 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -11,6 +11,7 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "hw/virtio/vhost.h"
> +#include "hw/virtio/virtio-crypto.h"
>   #include "hw/virtio/vhost-user.h"
>   #include "hw/virtio/vhost-backend.h"
>   #include "hw/virtio/virtio.h"
> @@ -173,13 +174,24 @@ typedef struct VhostUserConfig {
>   
>   #define VHOST_CRYPTO_SYM_HMAC_MAX_KEY_LEN    512
>   #define VHOST_CRYPTO_SYM_CIPHER_MAX_KEY_LEN  64
> +#define VHOST_CRYPTO_ASYM_MAX_KEY_LEN  1024
>   
>   typedef struct VhostUserCryptoSession {
> +    uint64_t op_code;
> +    union {
> +        struct {
> +            CryptoDevBackendSymSessionInfo session_setup_data;
> +            uint8_t key[VHOST_CRYPTO_SYM_CIPHER_MAX_KEY_LEN];
> +            uint8_t auth_key[VHOST_CRYPTO_SYM_HMAC_MAX_KEY_LEN];
> +        } sym;
> +        struct {
> +            CryptoDevBackendAsymSessionInfo session_setup_data;
> +            uint8_t key[VHOST_CRYPTO_ASYM_MAX_KEY_LEN];
> +        } asym;
> +    } u;
> +
>       /* session id for success, -1 on errors */
>       int64_t session_id;
> -    CryptoDevBackendSymSessionInfo session_setup_data;
> -    uint8_t key[VHOST_CRYPTO_SYM_CIPHER_MAX_KEY_LEN];
> -    uint8_t auth_key[VHOST_CRYPTO_SYM_HMAC_MAX_KEY_LEN];
>   } VhostUserCryptoSession;
>   
>   static VhostUserConfig c __attribute__ ((unused));
> @@ -2366,7 +2378,7 @@ static int vhost_user_crypto_create_session(struct vhost_dev *dev,
>       int ret;
>       bool crypto_session = virtio_has_feature(dev->protocol_features,
>                                          VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
> -    CryptoDevBackendSymSessionInfo *sess_info = session_info;
> +    CryptoDevBackendSessionInfo *backend_info = session_info;
>       VhostUserMsg msg = {
>           .hdr.request = VHOST_USER_CREATE_CRYPTO_SESSION,
>           .hdr.flags = VHOST_USER_VERSION,
> @@ -2380,16 +2392,30 @@ static int vhost_user_crypto_create_session(struct vhost_dev *dev,
>           return -ENOTSUP;
>       }
>   
> -    memcpy(&msg.payload.session.session_setup_data, sess_info,
> -              sizeof(CryptoDevBackendSymSessionInfo));
> -    if (sess_info->key_len) {
> -        memcpy(&msg.payload.session.key, sess_info->cipher_key,
> -               sess_info->key_len);
> -    }
> -    if (sess_info->auth_key_len > 0) {
> -        memcpy(&msg.payload.session.auth_key, sess_info->auth_key,
> -               sess_info->auth_key_len);
> +    if (backend_info->op_code == VIRTIO_CRYPTO_AKCIPHER_CREATE_SESSION) {
> +        CryptoDevBackendAsymSessionInfo *sess_info = &backend_info->u.asym_sess_info;
> +        memcpy(&msg.payload.session.u.asym.session_setup_data, sess_info,
> +               sizeof(CryptoDevBackendAsymSessionInfo));
> +        if (sess_info->keylen) {
> +            memcpy(&msg.payload.session.u.asym.key, sess_info->key,
> +                   sess_info->keylen);
> +        }

Hi,

Could you please test the length of msg.payload.session.u.asym.key and 
sess_info->keylen to avoid buffer overflow? and so does the following codes.

> +    } else {
> +        CryptoDevBackendSymSessionInfo *sess_info = &backend_info->u.sym_sess_info;
> +        memcpy(&msg.payload.session.u.sym.session_setup_data, sess_info,
> +               sizeof(CryptoDevBackendSymSessionInfo));
> +        if (sess_info->key_len) {
> +            memcpy(&msg.payload.session.u.sym.key, sess_info->cipher_key,
> +                   sess_info->key_len);
> +        }
> +        if (sess_info->auth_key_len > 0) {
> +            memcpy(&msg.payload.session.u.sym.auth_key, sess_info->auth_key,
> +                   sess_info->auth_key_len);
> +        }
>       }
> +
> +    msg.payload.session.op_code = backend_info->op_code;
> +    msg.payload.session.session_id = backend_info->session_id;
>       ret = vhost_user_write(dev, &msg, NULL, 0);
>       if (ret < 0) {
>           error_report("vhost_user_write() return %d, create session failed",

-- 
zhenwei pi

