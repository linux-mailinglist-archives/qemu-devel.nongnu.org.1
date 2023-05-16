Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC64705315
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 18:06:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyxAT-0008Pv-IU; Tue, 16 May 2023 12:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjongsma@redhat.com>)
 id 1pyxAL-0008Ot-Md
 for qemu-devel@nongnu.org; Tue, 16 May 2023 12:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjongsma@redhat.com>)
 id 1pyxAH-0006CC-9I
 for qemu-devel@nongnu.org; Tue, 16 May 2023 12:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684253075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cLGU7KNPeQurLyotGO1Y2rN63Iu1bXv4fuEcktRQ5NE=;
 b=bskpX/ji4OPfpxIx1kOvr0pxpxFJaFqkVTJb1sDWDfU+tjzXsjwFpMrYnu3fGluEbPEfjT
 xlyGXLB44ryqW3hbnLyTgcmUwR89B3p+7cOq8JnIP6klBob9p11JRsT/YblJR6vxgz46MG
 yhj/3wI5owOwRTigOaTotH7UTe6ZL9Y=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-P5NEXBPAOaaNqL7NTFyzmA-1; Tue, 16 May 2023 12:04:32 -0400
X-MC-Unique: P5NEXBPAOaaNqL7NTFyzmA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7578369dff3so411952485a.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 09:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684253063; x=1686845063;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cLGU7KNPeQurLyotGO1Y2rN63Iu1bXv4fuEcktRQ5NE=;
 b=L0w0L0MbKPnhYWkQJyoOYQqX6AIJaC4iPxrviJwu1WKjK546oooteObqg3SV5qwXzN
 7K/TEEnLMB7tnVxuLmcWp4ju74sOwvI6ZFkY4qgfp4zmLl33Wlwkcc9SQbYvN0X6FlJY
 Fnm1KvTUOGvrqkUFecdYYlwGnfbbUmWW2V4DVYiGatfbVJYWlzUna7yR21igOOmNUR4c
 w1am3xlOYPWh12uSTo3UdEJnUxKdE21+fiCA3oQOi0CKSAyY9mPrDEIAbF11oHAO7hRC
 40yosNECoovWT/ppFcR8DucsI5dARVQdPcmmwDURZp8nxSkDUiad4EsjCxDpc7LTXE19
 XOow==
X-Gm-Message-State: AC+VfDzyP/P352xiJgf1NNbtJMx83NASQoNScsxx++HDdF3zv64eW7S2
 omL9LF+nnUix+Pe0ApJGw9ffiHdM87nBm67NsCaZlkmFNtX3pOe1itqwXw4kHFmGnLA/SveQlxa
 4TUvdH1o+7OGuBM4=
X-Received: by 2002:a05:622a:151:b0:3f5:1d97:1922 with SMTP id
 v17-20020a05622a015100b003f51d971922mr16947778qtw.2.1684253063413; 
 Tue, 16 May 2023 09:04:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4e7kTN28K6xsOC1wpSt9dOM/uNg/K0GtPvVPd2e7BLQ01tTpPrKQwbZazJzCUJXbsIrNV1Fg==
X-Received: by 2002:a05:622a:151:b0:3f5:1d97:1922 with SMTP id
 v17-20020a05622a015100b003f51d971922mr16947727qtw.2.1684253063117; 
 Tue, 16 May 2023 09:04:23 -0700 (PDT)
Received: from [192.168.0.245] (207-153-48-138.fttp.usinternet.com.
 [207.153.48.138]) by smtp.gmail.com with ESMTPSA id
 h4-20020a37c444000000b007595df328dcsm675416qkm.115.2023.05.16.09.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 09:04:22 -0700 (PDT)
Message-ID: <e8fcb4cf-3667-2bdf-a163-d81bdfb71bfa@redhat.com>
Date: Tue, 16 May 2023 11:04:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/1] block/blkio: use qemu_open() to support fd passing
 for virtio-blk
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
References: <20230511091527.46620-1-sgarzare@redhat.com>
 <20230511091527.46620-2-sgarzare@redhat.com>
 <1a89ee2e-2368-4051-f9ec-018641721484@redhat.com>
 <q2odwrndg3gt6z25hdxb3t2xxavd64hkp4b23zhzycevhrwx64@25r5r6sidyok>
From: Jonathon Jongsma <jjongsma@redhat.com>
In-Reply-To: <q2odwrndg3gt6z25hdxb3t2xxavd64hkp4b23zhzycevhrwx64@25r5r6sidyok>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jjongsma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.666, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/15/23 5:10 AM, Stefano Garzarella wrote:
> On Thu, May 11, 2023 at 11:03:22AM -0500, Jonathon Jongsma wrote:
>> On 5/11/23 4:15 AM, Stefano Garzarella wrote:
>>> The virtio-blk-vhost-vdpa driver in libblkio 1.3.0 supports the new
>>> 'fd' property. Let's expose this to the user, so the management layer
>>> can pass the file descriptor of an already opened vhost-vdpa character
>>> device. This is useful especially when the device can only be accessed
>>> with certain privileges.
>>>
>>> If the libblkio virtio-blk driver supports fd passing, let's always
>>> use qemu_open() to open the `path`, so we can handle fd passing
>>> from the management layer through the "/dev/fdset/N" special path.
>>>
>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>> ---
>>>
>>> Notes:
>>>     v3:
>>>     - use qemu_open() on `path` to simplify libvirt code [Jonathon]
>>
>>
>> Thanks
>>
>> The one drawback now is that it doesn't seem possible for libvirt to 
>> introspect whether or not qemu supports passing an fd to the driver or 
>> not.
> 
> Yep, this was because the libblkio library did not support this new way.
> 
>> When I was writing my initial patch (before I realized that it was 
>> missing fd-passing), I just checked for the existence of the 
>> virtio-blk-vhost-vdpa device. But we actually need to know both that 
>> this device exists and supports fd passing.
> 
> Yep, this was one of the advantages of using the new `fd` parameter.
> Can't libvirt handle the later failure?

Not very well. libvirt tries to provide useful errors to the user. So 
for example if the qemu executable doesn't support a device, we would 
want to provide an error indicating that the device is not supported 
rather than a possibly-inscrutable qemu error.

For example, in this scenario, we would want an error such as:

error: unsupported configuration: vhostvdpa disk is not supported with 
this QEMU binary

Instead of:

error: internal error: qemu unexpectedly closed the monitor: 
2023-05-16T15:17:36.666129Z qemu-system-x86_64: -blockdev 
{"driver":"virtio-blk-vhost-vdpa","path":"/dev/fdset/0","node-name":"libvirt-1-storage","cache":{"direct":true,"no-flush":false},"auto-read-only":true,"discard":"unmap"}: 
blkio_connect failed: Failed to connect to vDPA device: Input/output error

And we can only do that if we can determine that the binary has the 
proper support for fds.

> 
>> As far as I can tell, versions 7.2.0 and 8.0.0 include this device but 
>> won't accept fds.
> 
> Right.
> 
> How do you suggest to proceed?

I need some way to determine that the particular qemu binary can accept 
a /dev/fdset/ path for vdpa block devices. libvirt uses a variety of 
methods to determine capabilities for a given qemu binary, including 
querying the qmp schema, commands, object types, specific device/object 
properties, etc. For example, right now I can determine (via querying 
the qmp schema) whether virtio-blk-vhost-vdpa is a valid type for the 
blockdev-add command by querying the qmp schema. I need something more 
than that but I'm not sure how to do it without introducing a separate 
'fd' parameter. Any ideas?

Thanks,
Jonathon


