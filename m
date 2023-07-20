Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE10D75AD3F
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 13:44:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMS3Y-0002hF-4f; Thu, 20 Jul 2023 07:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMS3T-0002gs-Ov
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 07:42:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMS3S-0006Lc-1N
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 07:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689853364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wn6giSfXH9zqVhih+3rP4ZAMrrUpb8imCd+u5kqNKgA=;
 b=KoFAyhj0OdFoYlBvYoNqxIfzWg3dVMkLjOkwOlBsGe56sm3jzmsQ7rG31dRH4WbCsvCn3m
 Y93VqkR6tJjpFV4NGC3EIcnD1ABrgX8PQtknIxwL9Uq26DZkWglXVFPdxXPct+qU+KL2VY
 yumovRjs1oFiA4onoR67vZvVGCXVZjs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-xkffULI1OAS_9WscTdvtAQ-1; Thu, 20 Jul 2023 07:42:43 -0400
X-MC-Unique: xkffULI1OAS_9WscTdvtAQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9932e8e76b9so61550566b.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 04:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689853362; x=1690458162;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wn6giSfXH9zqVhih+3rP4ZAMrrUpb8imCd+u5kqNKgA=;
 b=hWYKiTaQzW47KSnuiOPKa+U/i2xwDO8G1yCnJgswRnbWb/VjqRhuVg1XARYpXat/lV
 kKt288m5ZMUNwHM+gkOKbr6bUs1lSSK/H15IrL4JHdXTLA8qfjKqDyAKDzgMAVilZ/fN
 z/PCEb0ozNPjPxFXKAsbqDp3bF0D2QsAyRZRjaUNu0qaIXW3XsRnff1rP3H7OlaU3O8m
 E0KLfBtlD8nvgeZ5BCovfgLcOisE7FtPmaUqWwq6NeuKj8rDvpp5qQ0NlgOQzrFDHaAE
 eOr0DsEkNTFqhwxs73aH5kGFlaswIPcM+G1pUn97EhXix05Ig4ZNyFqyyN8x8itJhLaR
 TIgg==
X-Gm-Message-State: ABy/qLY69qweQ2EXUInEgUJAJg3MEGzyLuEZpSatXAGN2hQo/kFI4GUa
 RBpixTcYSfcWAXKQFEeny0wU5qAK7tVLBfmBwfcRciVYWcjiTms3NN1IWnWHsjhk7qZ7cgUBvvk
 oA48Ykxw/csOaqG0=
X-Received: by 2002:a17:907:a065:b0:99b:5a41:a77f with SMTP id
 ia5-20020a170907a06500b0099b5a41a77fmr658764ejc.70.1689853362250; 
 Thu, 20 Jul 2023 04:42:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFflfFPvExB+0HPzmMo/GYCwQTiRR1+jn4jOnTp+3oVt2Z9skLJjG7mE2+ByeFdw73LJe8sqQ==
X-Received: by 2002:a17:907:a065:b0:99b:5a41:a77f with SMTP id
 ia5-20020a170907a06500b0099b5a41a77fmr658752ejc.70.1689853361953; 
 Thu, 20 Jul 2023 04:42:41 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a170906d20a00b00992ed412c74sm581359ejz.88.2023.07.20.04.42.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jul 2023 04:42:41 -0700 (PDT)
Message-ID: <6f42132a-dd93-40bb-5ee3-7d1a23a4b2e1@redhat.com>
Date: Thu, 20 Jul 2023 13:42:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/4] vhost: Add high-level state save/load functions
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 German Maglione <gmaglione@redhat.com>, =?UTF-8?Q?Eugenio_P=c3=a9rez?=
 <eperezma@redhat.com>
References: <20230712111703.28031-1-hreitz@redhat.com>
 <20230712111703.28031-4-hreitz@redhat.com> <20230718184212.GM44841@fedora>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230718184212.GM44841@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 18.07.23 20:42, Stefan Hajnoczi wrote:
> On Wed, Jul 12, 2023 at 01:17:01PM +0200, Hanna Czenczek wrote:
>> vhost_save_backend_state() and vhost_load_backend_state() can be used by
>> vhost front-ends to easily save and load the back-end's state to/from
>> the migration stream.
>>
>> Because we do not know the full state size ahead of time,
>> vhost_save_backend_state() simply reads the data in 1 MB chunks, and
>> writes each chunk consecutively into the migration stream, prefixed by
>> its length.  EOF is indicated by a 0-length chunk.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   include/hw/virtio/vhost.h |  35 +++++++
>>   hw/virtio/vhost.c         | 204 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 239 insertions(+)
>>
>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>> index d8877496e5..0c282abd4e 100644
>> --- a/include/hw/virtio/vhost.h
>> +++ b/include/hw/virtio/vhost.h
>> @@ -425,4 +425,39 @@ int vhost_set_device_state_fd(struct vhost_dev *dev,
>>    */
>>   int vhost_check_device_state(struct vhost_dev *dev, Error **errp);
>>   
>> +/**
>> + * vhost_save_backend_state(): High-level function to receive a vhost
>> + * back-end's state, and save it in `f`.  Uses
> I think the GtkDoc syntax is @f instead of `f`.

OK, I’ll fix the parameter name references!

>> + * `vhost_set_device_state_fd()` to get the data from the back-end, and
>> + * stores it in consecutive chunks that are each prefixed by their
>> + * respective length (be32).  The end is marked by a 0-length chunk.
>> + *
>> + * Must only be called while the device and all its vrings are stopped
>> + * (`VHOST_TRANSFER_STATE_PHASE_STOPPED`).
>> + *
>> + * @dev: The vhost device from which to save the state
>> + * @f: Migration stream in which to save the state
>> + * @errp: Potential error message
>> + *
>> + * Returns 0 on success, and -errno otherwise.
>> + */
>> +int vhost_save_backend_state(struct vhost_dev *dev, QEMUFile *f, Error **errp);
>> +
>> +/**
>> + * vhost_load_backend_state(): High-level function to load a vhost
>> + * back-end's state from `f`, and send it over to the back-end.  Reads
>> + * the data from `f` in the format used by `vhost_save_state()`, and
>> + * uses `vhost_set_device_state_fd()` to transfer it to the back-end.
>> + *
>> + * Must only be called while the device and all its vrings are stopped
>> + * (`VHOST_TRANSFER_STATE_PHASE_STOPPED`).
>> + *
>> + * @dev: The vhost device to which to send the sate
>> + * @f: Migration stream from which to load the state
>> + * @errp: Potential error message
>> + *
>> + * Returns 0 on success, and -errno otherwise.
>> + */
>> +int vhost_load_backend_state(struct vhost_dev *dev, QEMUFile *f, Error **errp);
>> +
>>   #endif
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 756b6d55a8..332d49a310 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -2128,3 +2128,207 @@ int vhost_check_device_state(struct vhost_dev *dev, Error **errp)
>>                  "vhost transport does not support migration state transfer");
>>       return -ENOSYS;
>>   }
>> +
>> +int vhost_save_backend_state(struct vhost_dev *dev, QEMUFile *f, Error **errp)
>> +{
>> +    /* Maximum chunk size in which to transfer the state */
>> +    const size_t chunk_size = 1 * 1024 * 1024;
>> +    void *transfer_buf = NULL;
>> +    g_autoptr(GError) g_err = NULL;
>> +    int pipe_fds[2], read_fd = -1, write_fd = -1, reply_fd = -1;
>> +    int ret;
>> +
>> +    /* [0] for reading (our end), [1] for writing (back-end's end) */
>> +    if (!g_unix_open_pipe(pipe_fds, FD_CLOEXEC, &g_err)) {
>> +        error_setg(errp, "Failed to set up state transfer pipe: %s",
>> +                   g_err->message);
>> +        ret = -EINVAL;
>> +        goto fail;
>> +    }
>> +
>> +    read_fd = pipe_fds[0];
>> +    write_fd = pipe_fds[1];
>> +
>> +    /*
>> +     * VHOST_TRANSFER_STATE_PHASE_STOPPED means the device must be stopped.
>> +     * We cannot check dev->suspended, because the back-end may not support
>> +     * suspending.
>> +     */
>> +    assert(!dev->started);
>> +
>> +    /* Transfer ownership of write_fd to the back-end */
>> +    ret = vhost_set_device_state_fd(dev,
>> +                                    VHOST_TRANSFER_STATE_DIRECTION_SAVE,
>> +                                    VHOST_TRANSFER_STATE_PHASE_STOPPED,
>> +                                    write_fd,
>> +                                    &reply_fd,
>> +                                    errp);
>> +    if (ret < 0) {
>> +        error_prepend(errp, "Failed to initiate state transfer: ");
>> +        goto fail;
>> +    }
>> +
>> +    /* If the back-end wishes to use a different pipe, switch over */
>> +    if (reply_fd >= 0) {
>> +        close(read_fd);
>> +        read_fd = reply_fd;
>> +    }
>> +
>> +    transfer_buf = g_malloc(chunk_size);
>> +
>> +    while (true) {
>> +        ssize_t read_ret;
>> +
>> +        read_ret = read(read_fd, transfer_buf, chunk_size);
>> +        if (read_ret < 0) {
> Is it necessary to handle -EINTR?

Yes, indeed, I do believe so.  I’ll wrap this and the write() in 
RETRY_ON_EINTR().

Hanna


