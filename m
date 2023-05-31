Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA775718216
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:38:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4M18-0002S7-8V; Wed, 31 May 2023 09:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjongsma@redhat.com>)
 id 1q4M0u-0002RR-AR
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjongsma@redhat.com>)
 id 1q4M0s-0007Sk-Cx
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685540237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/dkq6k6orcgofiAXe93Jjv/0SVZd7q+tUisrzzz1wps=;
 b=Cb2AmQjTV6F6EzBoikB5mtTdSa0tYu3n82rnGxpunIhg4a84qTYE35pTDrhTd12mbQR+bL
 5h/hdgFyCcZIZFF9Eg5rqcssB393nDC0NVwh6LaQhqQdK0FTiwyhUhyGGQWUDjsfEitXxC
 /yov/xefh6G8IXQgWgdQO4YlHTp6xEM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-rn1ROHN_PPit4k7JyzRKFg-1; Wed, 31 May 2023 09:37:16 -0400
X-MC-Unique: rn1ROHN_PPit4k7JyzRKFg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6237c937691so6943866d6.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685540235; x=1688132235;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/dkq6k6orcgofiAXe93Jjv/0SVZd7q+tUisrzzz1wps=;
 b=R1x2bx71+VoUJuR5a4dw+tiil6qjSGNfMU3n15aM0UeJGVILc/dz7+o4VyW30eIQvw
 hJbbmk2A/uPnDq0LZ51lXCWuqQH41fltDcOz/7qoziJ/6/aGVjfFZ8fhcGYO/3JzWSIA
 Qw6oPTSwzG+pJGx3JU9naL6NR4RhYOecBkHaVaHvmE+m/voE0rw16stCoM8cAEsRZOi2
 x76wFT6mkoBHkjhs5I3Xx5KvMl/ApJvIKbGgUXjt+q8EnODcYh6lArTzqyr1YrbiDCX5
 ZYExd4yNFipt+qkWW1l5bvNSHZRmqFFpmP05PlGK1yzdWsr2exXP8OsZX5jD2X4gzyRz
 fEaQ==
X-Gm-Message-State: AC+VfDwgP5jvE//u+bTtRCndLAe8VzcnRWhYxl46eayTqdxymZ963nQb
 AvhIqATIZin7iRHMj4pT4cJj7ojh3nfFtXUcIVZt6k4BXQZWZokBudMeFbXffRaqXrijYZ2NTpf
 lFESvlPV5fDnMbFg=
X-Received: by 2002:a05:6214:21a5:b0:626:7e5:ddc5 with SMTP id
 t5-20020a05621421a500b0062607e5ddc5mr5503332qvc.16.1685540235404; 
 Wed, 31 May 2023 06:37:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wvHafzLtHsn3B7gKHH2i6Yy3KYMuPEecf/DLj5x6UgbbYN8yB+N1BKhW3ftibdWYFlyQJrg==
X-Received: by 2002:a05:6214:21a5:b0:626:7e5:ddc5 with SMTP id
 t5-20020a05621421a500b0062607e5ddc5mr5503306qvc.16.1685540235161; 
 Wed, 31 May 2023 06:37:15 -0700 (PDT)
Received: from [192.168.0.245] (207-153-48-138.fttp.usinternet.com.
 [207.153.48.138]) by smtp.gmail.com with ESMTPSA id
 z5-20020ad44145000000b005e37909a7fcsm4030195qvp.13.2023.05.31.06.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:37:14 -0700 (PDT)
Message-ID: <3301427e-0c93-287d-fdfb-3be3c532c9b6@redhat.com>
Date: Wed, 31 May 2023 08:37:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 0/2] block/blkio: support fd passing for
 virtio-blk-vhost-vdpa driver
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
References: <20230530071941.8954-1-sgarzare@redhat.com>
From: Jonathon Jongsma <jjongsma@redhat.com>
In-Reply-To: <20230530071941.8954-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jjongsma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/30/23 2:19 AM, Stefano Garzarella wrote:
> v5:
> - moved `features` to the object level to simplify libvirt code [Jonathon]
> - wrapped a line too long in the documentation [Markus]
> - added Stefan R-b tags
> 
> v4: https://lore.kernel.org/qemu-devel/20230526150304.158206-1-sgarzare@redhat.com/
> - added patch 02 to allow libvirt to discover we support fdset [Markus]
> - modified the commit description of patch 01
> 
> v3: https://lore.kernel.org/qemu-devel/20230511091527.46620-1-sgarzare@redhat.com/
> - use qemu_open() on `path` to simplify libvirt code [Jonathon]
> - remove patch 01 since we are not using monitor_fd_param() anymore
> 
> v2: https://lore.kernel.org/qemu-devel/20230504092843.62493-1-sgarzare@redhat.com/
> - added patch 01 to use monitor_fd_param() in the blkio module
> - use monitor_fd_param() to parse the fd like vhost devices [Stefan]
> 
> v1: https://lore.kernel.org/qemu-devel/20230502145050.224615-1-sgarzare@redhat.com/
> 
> The virtio-blk-vhost-vdpa driver in libblkio 1.3.0 supports the new
> 'fd' property. Let's expose this to the user, so the management layer
> can pass the file descriptor of an already opened vhost-vdpa character
> device. This is useful especially when the device can only be accessed
> with certain privileges.
> 
> Stefano Garzarella (2):
>    block/blkio: use qemu_open() to support fd passing for virtio-blk
>    qapi: add '@fdset' feature for BlockdevOptionsVirtioBlkVhostVdpa
> 
>   meson.build          |  4 ++++
>   qapi/block-core.json |  6 +++++
>   block/blkio.c        | 53 ++++++++++++++++++++++++++++++++++++--------
>   3 files changed, 54 insertions(+), 9 deletions(-)
> 


Looks good from my perspective as a libvirt developer.

Thanks,
Jonathon


