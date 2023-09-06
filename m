Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B423793EC7
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:27:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtVB-0007fh-6F; Wed, 06 Sep 2023 10:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdtV9-0007fJ-Bv
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:27:27 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdtV6-00047Z-Kx
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:27:27 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-402e7968042so3454055e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 07:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694010443; x=1694615243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xqsZ6dv7B9Pa1o68e1WSpbr5kuavG48utXOcI2kVrng=;
 b=PmtYy0FKojSbDaiWmuUEP3xJZ0z9K4BnaoCu4EYHGlQ6MbNPXZcow+4ol7sMcm/aFP
 Hv3mQpc5MIGADarIgSQPGn2ziitXEV1N++d3G1jUddE9jC5uwEjyqe+x53OInUWy1j2G
 1/jEsl6mIxoRvllNNk886vX7HQD36m/8DMmywOlhboMku5PX4/y7KULlCOh8bzxzkvf9
 0NnH1aATguCUwf2S0N5fH49xjhUZno19NjU7Vu5S+ylVknIZBrb7lAjLT2pmKDt2Ufyc
 F4DTe3qshhnbNXLPx02ORCyC/+ekeI+81yRnpE5PuqqGJYbYtyhZdRUzhbo5THF8f+bQ
 KHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694010443; x=1694615243;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xqsZ6dv7B9Pa1o68e1WSpbr5kuavG48utXOcI2kVrng=;
 b=BLNGzce58+dc8Mgn9p1kwuuVJvYd3weVzv9BsJlpCzGynU7vuNkaHRwcrBR2eat+5k
 ze+vFWRrnRbyW4Lp6nXS6S+OHCOqytpClnVESiViFpo09cWkTx2xesQuzq5hW1+W2k2y
 q6UynC/AgsH8TI8InI1qyquomMPm7D1ndW99ohhQiU/hP+p+S0j14sDsRMbcLfxJX9rP
 Ax0PwLDrt/LyD05+Q7XTtp8znfnbfK1Yz0/Ctu0RWcXNt4iIPThG/4DHS52fhwJA5mPh
 X9ecjiVcaWQL+8m/dwJb+AxN/TajCePQ8fqfPy2JMBtwW4/TIGGNWiMmNNtbiIsVMK/w
 W5Kw==
X-Gm-Message-State: AOJu0Yzy5eJgf934k1aX2GajreFuKnc/GnVuDXW6dPeF/5nWCFP6MSMM
 Tk+X9nE1+LbSi53hS5rplevPnA==
X-Google-Smtp-Source: AGHT+IEA/2ZfnSdsiIDsHGOqHMnwOVRT95pTk1yK6lb6Ci/xKsjSuPTKbSyZL/nl0WebiDf5VsKdOA==
X-Received: by 2002:a05:600c:224e:b0:401:6800:703c with SMTP id
 a14-20020a05600c224e00b004016800703cmr2450863wmm.21.1694010443096; 
 Wed, 06 Sep 2023 07:27:23 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 u8-20020a05600c210800b003fc16ee2864sm19923829wml.48.2023.09.06.07.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 07:27:22 -0700 (PDT)
Message-ID: <9d5377ba-c987-dce3-2813-d9c98f162d3f@linaro.org>
Date: Wed, 6 Sep 2023 16:27:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v6 3/3] vhost-user: add shared_object msg
Content-Language: en-US
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 cohuck@redhat.com, kraxel@redhat.com, marcandre.lureau@gmail.com
References: <20230906111549.357178-1-aesteve@redhat.com>
 <20230906111549.357178-4-aesteve@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230906111549.357178-4-aesteve@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Albert,

On 6/9/23 13:15, Albert Esteve wrote:
> Add three new vhost-user protocol
> `VHOST_USER_BACKEND_SHARED_OBJECT_* messages`.
> These new messages are sent from vhost-user
> back-ends to interact with the virtio-dmabuf
> table in order to add or remove themselves as
> virtio exporters, or lookup for virtio dma-buf
> shared objects.
> 
> The action taken in the front-end depends
> on the type stored in the virtio shared
> object hash table.
> 
> When the table holds a pointer to a vhost
> backend for a given UUID, the front-end sends
> a VHOST_USER_GET_SHARED_OBJECT to the
> backend holding the shared object.
> 
> In the libvhost-user library we need to add
> helper functions to allow sending messages to
> interact with the virtio shared objects
> hash table.
> 
> The messages can only be sent after successfully
> negotiating a new VHOST_USER_PROTOCOL_F_SHARED_OBJECT
> vhost-user protocol feature bit.
> 
> Finally, refactor code to send response message so
> that all common parts both for the common REPLY_ACK
> case, and other data responses, can call it and
> avoid code repetition.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>   docs/interop/vhost-user.rst               |  57 +++++++
>   hw/virtio/vhost-user.c                    | 174 ++++++++++++++++++++--
>   include/hw/virtio/vhost-backend.h         |   3 +
>   subprojects/libvhost-user/libvhost-user.c | 118 +++++++++++++++
>   subprojects/libvhost-user/libvhost-user.h |  55 ++++++-
>   5 files changed, 393 insertions(+), 14 deletions(-)

Almost 400 lines of changes is too much for me to review in a
single patch. Looking at the names, can't we split virtio VS
libvhost-user?

> +static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
> +                                 VhostUserPayload *payload)
> +{
> +    Error *local_err = NULL;
> +    struct iovec iov[] = {
> +        { .iov_base = hdr,      .iov_len = VHOST_USER_HDR_SIZE },
> +        { .iov_base = payload,  .iov_len = hdr->size },
> +    };
> +
> +    hdr->flags &= ~VHOST_USER_NEED_REPLY_MASK;
> +    hdr->flags |= VHOST_USER_REPLY_MASK;
> +
> +    if (qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), &local_err)) {
> +        error_report_err(local_err);
> +        return false;
> +    }
> +
> +    return true;
> +}

I note you  ignored my comment regarding adding a 'Error **' argument in
the previous version:
https://lore.kernel.org/qemu-devel/911eef0c-d04f-2fcf-e78b-2475cd7af8f0@linaro.org/

