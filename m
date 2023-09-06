Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC09793528
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 08:10:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdljp-0007TE-Ne; Wed, 06 Sep 2023 02:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdljn-0007T1-MF
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 02:10:03 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdljk-0004lQ-KT
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 02:10:03 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9a648f9d8e3so438041566b.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 23:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693980598; x=1694585398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s1VXt/BW0WBFs8f/+0j0Ih28XlMJTR9dgBK+BeDVh54=;
 b=e66SGgk5jOWQ/DfpiraHmjBsAD4vb3N9KEG+tL+OIcM/pcsBHKUnQhK0jWChSYbZ/p
 uTp1D3ZWKI8uKrONnoJekZUNsJ0qDadidKhd63Al5LnaZ/oXH4fmYdkHQwT8eygnfQB8
 2hn58uvJ6PIXdrvdl/iZka0nJhQTdsTciUWt1cD/lI+ajIC88UXwM6lbF9eg77cVlQWP
 KQlMStl9n+xIXfqxgN4rbRmiVxCROMdB532q6HIVK3gknrNOa6TjevMoi/iUkGHex6H+
 cP6vFX1jo/wBHloTpXqBI6IT3ZjGmOVjlGJa3D/7WfbnmsKLuIYlkB0A6sQvzMPNaEiM
 /gUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693980598; x=1694585398;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s1VXt/BW0WBFs8f/+0j0Ih28XlMJTR9dgBK+BeDVh54=;
 b=O3JDqs4N+UdTbvdy1gN8ECmQp97ayywZzZu3iaNRJdSfU3fyVqH9OT/gQhT+fDqZOi
 NTxyqZ3zEyTAqGgK77rhlFVk1+cxaEVW9vrDMRPu8CwCzGEwAFt8ERIZcNg+9jN4dA09
 7T9e6TQBM55O5nMDaz0UST+1hHMXnwqq2OADW1BqqkH3xvgOZayHqv9rdQHia7kYDQHj
 E8i5CFeD4g0FFrqEvnUkNgg0q5yBB/LisaUfARMtQalIEsA0pvEZNIX7Lk7CqNEF10/B
 glCMxivzjdGwusBuCRyyC5tucVaFndhV3ZYYtjS3+R3i9GCGvG4547PBVaGxaQtnx4bf
 WjiA==
X-Gm-Message-State: AOJu0YzKZL2V2q4OljzjSJBiViNSUCkeCjmwsTJ1ZyUpMHOpQQWk0qA1
 oB3h7JRpajiw1yO9NZo1ENPJEg==
X-Google-Smtp-Source: AGHT+IGAqc8+P1xEPlYdYakZ9Umr7tdKVhFnkYb1/aJjL4GdxptBwuWwZD3sMJenF4Uo5lJzbysmtw==
X-Received: by 2002:a17:906:8a62:b0:9a1:e994:3440 with SMTP id
 hy2-20020a1709068a6200b009a1e9943440mr1545363ejc.4.1693980598633; 
 Tue, 05 Sep 2023 23:09:58 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 rh16-20020a17090720f000b0099cb0a7098dsm8623513ejb.19.2023.09.05.23.09.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 23:09:57 -0700 (PDT)
Message-ID: <f53d7977-3e69-cffb-de28-79f883ef2412@linaro.org>
Date: Wed, 6 Sep 2023 08:09:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v5 3/4] vhost-user: add shared_object msg
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, kraxel@redhat.com, cohuck@redhat.com,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230802090824.91688-1-aesteve@redhat.com>
 <20230802090824.91688-4-aesteve@redhat.com>
 <911eef0c-d04f-2fcf-e78b-2475cd7af8f0@linaro.org>
In-Reply-To: <911eef0c-d04f-2fcf-e78b-2475cd7af8f0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 6/9/23 08:04, Philippe Mathieu-Daudé wrote:
> On 2/8/23 11:08, Albert Esteve wrote:
>> Add three new vhost-user protocol
>> `VHOST_USER_BACKEND_SHARED_OBJECT_* messages`.
>> These new messages are sent from vhost-user
>> back-ends to interact with the virtio-dmabuf
>> table in order to add or remove themselves as
>> virtio exporters, or lookup for virtio dma-buf
>> shared objects.
>>
>> The action taken in the front-end depends
>> on the type stored in the virtio shared
>> object hash table.
>>
>> When the table holds a pointer to a vhost
>> backend for a given UUID, the front-end sends
>> a VHOST_USER_GET_SHARED_OBJECT to the
>> backend holding the shared object.
>>
>> In the libvhost-user library we need to add
>> helper functions to allow sending messages to
>> interact with the virtio shared objects
>> hash table.
>>
>> The messages can only be sent after successfully
>> negotiating a new VHOST_USER_PROTOCOL_F_SHARED_OBJECT
>> vhost-user protocol feature bit.
>>
>> Signed-off-by: Albert Esteve <aesteve@redhat.com>
>> ---
>>   docs/interop/vhost-user.rst               |  57 ++++++++
>>   hw/virtio/vhost-user.c                    | 166 ++++++++++++++++++++++
>>   include/hw/virtio/vhost-backend.h         |   3 +
>>   subprojects/libvhost-user/libvhost-user.c | 118 +++++++++++++++
>>   subprojects/libvhost-user/libvhost-user.h |  55 ++++++-
>>   5 files changed, 398 insertions(+), 1 deletion(-)
> 
> 
>> +static bool
>> +vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
>> +                                  VhostUserPayload *payload)
>> +{
>> +    Error *local_err = NULL;
>> +    struct iovec iov[2];
>> +
>> +    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
>> +        hdr->flags &= ~VHOST_USER_NEED_REPLY_MASK;
>> +    }
>> +    hdr->flags |= VHOST_USER_REPLY_MASK;
>> +
>> +    hdr->size = sizeof(payload->u64);
>> +
>> +    iov[0].iov_base = hdr;
>> +    iov[0].iov_len = VHOST_USER_HDR_SIZE;
>> +    iov[1].iov_base = payload;
>> +    iov[1].iov_len = hdr->size;
>> +
>> +    if (qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), &local_err)) {
>> +        error_report_err(local_err);
> 
> This function could have a 'Error **errp' parameter to propagate
> the error to the caller.
> 
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>> +static bool
>> +vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
>> +                                  VhostUserPayload *payload)
>> +{
>> +    hdr->size = sizeof(payload->u64);
>> +    return vhost_user_send_resp(ioc, hdr, payload);
>> +}
> 
> I'm confused by having two vhost_user_backend_send_dmabuf_fd() functions
> with different body...

This patch doesn't compile:

../../hw/virtio/vhost-user.c:1662:1: error: redefinition of 
‘vhost_user_backend_send_dmabuf_fd’
  1662 | vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, 
VhostUserHeader *hdr,
       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../../hw/virtio/vhost-user.c:1636:1: note: previous definition of 
‘vhost_user_backend_send_dmabuf_fd’ with type ‘_Bool(QIOChannel *, 
VhostUserHeader *, VhostUserPayload *)’
  1636 | vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, 
VhostUserHeader *hdr,
       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../../hw/virtio/vhost-user.c: In function 
‘vhost_user_backend_send_dmabuf_fd’:
../../hw/virtio/vhost-user.c:1666:12: error: implicit declaration of 
function ‘vhost_user_send_resp’; did you mean ‘vhost_user_set_u64’? 
[-Werror=implicit-function-declaration]
  1666 |     return vhost_user_send_resp(ioc, hdr, payload);
       |            ^~~~~~~~~~~~~~~~~~~~
       |            vhost_user_set_u64
../../hw/virtio/vhost-user.c:1666:12: error: nested extern declaration 
of ‘vhost_user_send_resp’ [-Werror=nested-externs]
At top level:
../../hw/virtio/vhost-user.c:1636:1: error: 
‘vhost_user_backend_send_dmabuf_fd’ defined but not used 
[-Werror=unused-function]
  1636 | vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, 
VhostUserHeader *hdr,
       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors


