Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 823378008B9
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 11:44:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r90zF-0005YE-EV; Fri, 01 Dec 2023 05:43:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1r90zB-0005Xv-PP
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:43:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1r90z9-0006zq-Lk
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701427381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=17Dlk/7LthQwG0xNY1PjPBv7XtCWHsmUdbF3wSNzAJs=;
 b=AA+Q4bDaM+lkvZBUt4JOfvqq2SzmDYteN8YoT+VDcuywlLr4J/LgRCci7jetLpkk0fgNoP
 SSsFQSIVKxOr01ImjxNxxcMjv/lcSvz+sSzNcBea+B4DYn9inZhXDez3JjGq9n8cQH1CVc
 YBqJqcxWVZn3vrlHctZzKScttzoLlOY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-5qs9RF8_O4aO7O5ydX8_Ig-1; Fri, 01 Dec 2023 05:41:17 -0500
X-MC-Unique: 5qs9RF8_O4aO7O5ydX8_Ig-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-67a929a9912so9641946d6.2
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 02:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701427277; x=1702032077;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=17Dlk/7LthQwG0xNY1PjPBv7XtCWHsmUdbF3wSNzAJs=;
 b=YVT/Ad48yfWUkzPXPDCKqQ/sJglB6ASjMC/ZbTIkWOwr5jGVYejcUpVkAxA4pk5krE
 NC21AF2FkGg5j2OthaMrvTAOe+IJs8BD25ZtUw809uwrd/+5pH/gCHyKEzefDCfbZBim
 95El1YQFDnnkVxkGK46OLWNhBvL6Wo+EUhWFffK2gw6/Z3YfTuCDzJlq1khVEkJM3X6f
 zjVQT3/2t7TvEmyyDzyWVbod4no0t3QZnjcbbk61BveOn+7U2xocRb9Se+JO0oHwYsTY
 AIYG9V68PwVJ++EJN4cba7+OWux7/kNsJm439oBY3Gk9+8uiqB8PEY667Fjg2BcJklCj
 RQdQ==
X-Gm-Message-State: AOJu0YzhUne9JQ0MK0hbcmuYAijAxVO86UJW/tinDN2sCPbKPaTJC/HL
 CBYSrhA2ec1zPh8GKizLFcgwP0wSVbr8oF11UW+UYsi2okzeatxfjwCa4u9IlXle5h69fd4qj3v
 bWVeyMWq5czFErKI=
X-Received: by 2002:ad4:50cf:0:b0:67a:a20b:1fb7 with SMTP id
 e15-20020ad450cf000000b0067aa20b1fb7mr56903qvq.56.1701427277320; 
 Fri, 01 Dec 2023 02:41:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6HfcQg7KuE4aEIzA6LYTzFUTFrPA7BbnLuftsAbJiFttzFrhxMEyxCQiNH/FyUatyk+t35Q==
X-Received: by 2002:ad4:50cf:0:b0:67a:a20b:1fb7 with SMTP id
 e15-20020ad450cf000000b0067aa20b1fb7mr56890qvq.56.1701427276958; 
 Fri, 01 Dec 2023 02:41:16 -0800 (PST)
Received: from [192.168.100.30] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a0c9c85000000b0067a55e3f97fsm1382648qvf.73.2023.12.01.02.41.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 02:41:16 -0800 (PST)
Message-ID: <3d4add1a-2dcf-4a35-a3f6-c7eca0275a35@redhat.com>
Date: Fri, 1 Dec 2023 11:41:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] qapi/virtio: introduce the "show-bits" argument for
 x-query-virtio-status
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1699793550.git.yong.huang@smartx.com>
 <2f146005c8573814528f4ffb5a0393eb73b154e3.1699793550.git.yong.huang@smartx.com>
 <87h6llep0o.fsf@pond.sub.org>
 <CAK9dgmYTjQRregoseU7S+8WvJsY4R10KP5hVkcEBKBFtHNv0=A@mail.gmail.com>
 <87v89vleqp.fsf@pond.sub.org>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <87v89vleqp.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/21/23 08:58, Markus Armbruster wrote:
> Laurent, there's a question for you at the end.
> 
> Yong Huang <yong.huang@smartx.com> writes:
> 
>> On Thu, Nov 16, 2023 at 10:44 PM Markus Armbruster <armbru@redhat.com>
>> wrote:
>>
>>> Hyman Huang <yong.huang@smartx.com> writes:
>>>
>>>> This patch allows to display feature and status bits in virtio-status.
>>>>
>>>> An optional argument is introduced: show-bits. For example:
>>>> {"execute": "x-query-virtio-status",
>>>>   "arguments": {"path": "/machine/peripheral-anon/device[1]/virtio-backend",
>>>>                 "show-bits": true}
>>>>
>>>> Features and status bits could be helpful for applications to compare
>>>> directly. For instance, when an upper application aims to ensure the
>>>> virtio negotiation correctness between guest, QEMU, and OVS-DPDK, it use
>>>> the "ovs-vsctl list interface" command to retrieve interface features
>>>> (in number format) and the QMP command x-query-virtio-status to retrieve
>>>> vhost-user net device features. If "show-bits" is added, the application
>>>> can compare the two features directly; No need to encoding the features
>>>> returned by the QMP command.
>>>>
>>>> This patch also serves as a preparation for the next one, which implements
>>>> a vhost-user test case about acked features of vhost-user protocol.
>>>>
>>>> Note that since the matching HMP command is typically used for human,
>>>> leave it unchanged.
>>>>
>>>> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
>>>> ---
>>>>   hw/virtio/virtio-hmp-cmds.c |  2 +-
>>>>   hw/virtio/virtio-qmp.c      | 21 +++++++++++++++-
>>>>   qapi/virtio.json            | 49 ++++++++++++++++++++++++++++++++++---
>>>>   3 files changed, 67 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
>>>> index 477c97dea2..3774f3d4bf 100644
>>>> --- a/hw/virtio/virtio-hmp-cmds.c
>>>> +++ b/hw/virtio/virtio-hmp-cmds.c
>>>> @@ -108,7 +108,7 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
>>>>   {
>>>>       Error *err = NULL;
>>>>       const char *path = qdict_get_try_str(qdict, "path");
>>>> -    VirtioStatus *s = qmp_x_query_virtio_status(path, &err);
>>>> +    VirtioStatus *s = qmp_x_query_virtio_status(path, false, false, &err);
>>>>
>>>>       if (err != NULL) {
>>>>           hmp_handle_error(mon, err);
>>>> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
>>>> index 1dd96ed20f..2e92bf28ac 100644
>>>> --- a/hw/virtio/virtio-qmp.c
>>>> +++ b/hw/virtio/virtio-qmp.c
>>>> @@ -718,10 +718,15 @@ VirtIODevice *qmp_find_virtio_device(const char *path)
>>>>       return VIRTIO_DEVICE(dev);
>>>>   }
>>>>
>>>> -VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>>>> +VirtioStatus *qmp_x_query_virtio_status(const char *path,
>>>> +                                        bool has_show_bits,
>>>> +                                        bool show_bits,
>>>> +                                        Error **errp)
>>>>   {
>>>>       VirtIODevice *vdev;
>>>>       VirtioStatus *status;
>>>> +    bool display_bits =
>>>> +        has_show_bits ? show_bits : false;
>>>
>>> Since !has_show_bits implies !show_bits, you can simply use
>>> if (show_bits).
>>>
>> Ok
>>
>>>
>>>>
>>>>       vdev = qmp_find_virtio_device(path);
>>>>       if (vdev == NULL) {
>>>> @@ -733,6 +738,11 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>>>>       status->name = g_strdup(vdev->name);
>>>>       status->device_id = vdev->device_id;
>>>>       status->vhost_started = vdev->vhost_started;
>>>> +    if (display_bits) {
>>>> +        status->guest_features_bits = vdev->guest_features;
>>>> +        status->host_features_bits = vdev->host_features;
>>>> +        status->backend_features_bits = vdev->backend_features;
>>>> +    }
>>>>       status->guest_features = qmp_decode_features(vdev->device_id,
>>>>                                                    vdev->guest_features);
>>>>       status->host_features = qmp_decode_features(vdev->device_id,
>>>> @@ -753,6 +763,9 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>>>>       }
>>>>
>>>>       status->num_vqs = virtio_get_num_queues(vdev);
>>>> +    if (display_bits) {
>>>> +        status->status_bits = vdev->status;
>>>> +    }
>>>>       status->status = qmp_decode_status(vdev->status);
>>>>       status->isr = vdev->isr;
>>>>       status->queue_sel = vdev->queue_sel;
>>>> @@ -775,6 +788,12 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>>>>           status->vhost_dev->n_tmp_sections = hdev->n_tmp_sections;
>>>>           status->vhost_dev->nvqs = hdev->nvqs;
>>>>           status->vhost_dev->vq_index = hdev->vq_index;
>>>> +        if (display_bits) {
>>>> +            status->vhost_dev->features_bits = hdev->features;
>>>> +            status->vhost_dev->acked_features_bits = hdev->acked_features;
>>>> +            status->vhost_dev->backend_features_bits = hdev->backend_features;
>>>> +            status->vhost_dev->protocol_features_bits = hdev->protocol_features;
>>>> +        }
>>>>           status->vhost_dev->features =
>>>>               qmp_decode_features(vdev->device_id, hdev->features);
>>>>           status->vhost_dev->acked_features =
>>>> diff --git a/qapi/virtio.json b/qapi/virtio.json
>>>> index e6dcee7b83..608b841a89 100644
>>>> --- a/qapi/virtio.json
>>>> +++ b/qapi/virtio.json
>>>> @@ -79,12 +79,20 @@
>>>>   #
>>>>   # @vq-index: vhost_dev vq_index
>>>>   #
>>>> +# @features-bits: vhost_dev features in decimal format
>>>
>>> Say "encoded as a number".  The number is decimal just because the
>>> transport is JSON.  We could have another transport some day.  Or
>>> language bindings wrapping around the JSON transport.
>>>
>>>> +#
>>>>   # @features: vhost_dev features
>>>
>>> Double-checking...  @feature-bits provides the exact same information as
>>> @features, only in another encoding.  Correct?
>>
>>
>>> Same for all the other new -bits.  Correct?
>>
>> Yes, all the new fields are only about providing another encoding.
> 
> Why do we want to return the same information in two different
> encodings?  I figure the commit message tries to answer this question:
> 
>       Features and status bits could be helpful for applications to compare
>       directly. For instance, when an upper application aims to ensure the
>       virtio negotiation correctness between guest, QEMU, and OVS-DPDK, it use
>       the "ovs-vsctl list interface" command to retrieve interface features
>       (in number format) and the QMP command x-query-virtio-status to retrieve
>       vhost-user net device features. If "show-bits" is added, the application
>       can compare the two features directly; No need to encoding the features
>       returned by the QMP command.
> 
>       This patch also serves as a preparation for the next one, which implements
>       a vhost-user test case about acked features of vhost-user protocol.
> 
> I guess you're trying to simplify use cases where the QMP client wants
> to compare entire feature sets without caring for individual features.
> 
> The comparison is easy if both sets are represented the same way,
> e.g. both are numbers, or both are lists of symbols.
> 
> With different representations, we first have to map to a common
> representation.  Unfortunately, the design of x-query-virtio-status
> makes this harder than it should be.
> 
> We use QAPI types VirtioDeviceStatus, VhostDeviceProtocols,
> VirtioDeviceFeatures to represent feature sets.  They all work the same
> way: array of strings plus a number.  For each bit QEMU knows, there's a
> string in the array.  Any remaining bits go into the number.
> 
> The format of the string is undocumented.  They look like
> 
>      "WELL_KNOWN_SYMBOL: human readable explanation"
> 
> Mapping from bit to this string in a client would require duplicating
> QEMU's code exactly.
> 
> Mapping both bit and string to just "WELL_KNOWN_SYMBOL" could perhaps be
> done.
> 
> The mapping between symbols and bits is not visible in QMP.  Mapping
> from string to bit requires exploiting the undocumented format: extract
> the well-known symbol and decode it.
> 
> This encoding of feature sets goes back to commit f3034ad71fc (qmp:
> decode feature & status bits in virtio-status) v7.2.  Before that, the
> command returned the bits as a number.
> 
> For example, return value "member "status":
> 
>      Before f3034ad71fc:
> 
>          "status": 15,
> 
>      Since f3034ad71fc:
> 
>          "status": {
>              "statuses": [
>                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
>                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
>                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
>                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
>              ]},
> 
>      With your patch:
> 
>          "status": {
>              "statuses": [
>                  "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found",
>                  "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device",
>                  "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete",
>                  "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"
>              ]},
>          "status-bits": 15,
> 
> Looks like commit f3034ad71fc improved one use case at the expense of
> another, and your patch tries to revert the damage.  Which one exactly
> it improved is unclear; the commit message doesn't tell.  Laurent?
> 
> [...]
> 

The first idea of the series "hmp,qmp: Add commands to introspect virtio devices" 
including commit f3034ad71fc was to help developer to debug virtio devices, so for this 
purpose it was interesting to display the status in a human readable manner.

Of course, if you want to run automatic tests and be able to compare the result to have 
the status bits result seems to be better.

As these are two different use cases, it's understandable to have two different 
representations of the same information.

Thanks,
Laurent



