Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D37767E35AA
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 08:17:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0GJH-0005Vx-6I; Tue, 07 Nov 2023 02:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0GJF-0005VN-1z
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 02:15:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0GJD-0001rX-G9
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 02:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699341334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z4zoI1dFKNzmROQVAcm1ZzeGhhVcUkcDyNlMXv8QQYE=;
 b=b5TsYNkCTwo2lbP9gJDjsi45T7UTCKoJW8uEfgIkKbXCpUMcfoy+OQ/9AX5rtu1MoQ1uxQ
 x5AkNOkBmog6/GREfhggVAUmzONib3Cwi/bAy2F3kfDh4l/0NScDvSbYZfo34N7snQwJhK
 uiXaytMCs6WX+ZFTaUtLALbl5FggW1o=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-HSQhdsCoM7yaJwew4Pg3kg-1; Tue, 07 Nov 2023 02:15:28 -0500
X-MC-Unique: HSQhdsCoM7yaJwew4Pg3kg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c5073588cbso44423341fa.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 23:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699341327; x=1699946127;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z4zoI1dFKNzmROQVAcm1ZzeGhhVcUkcDyNlMXv8QQYE=;
 b=JvsiwnM5ql+YGxc2bkfGiDkKmL5WGGGn4H5/MvAf/rgMl0lLpyJPdG4eM4lLcf/21i
 pi3zEvv0s8WKVKjg0Tp0JbsvmVFi5rXW30Fbn5EqzxcPkMMPbDp+RyXciCcCeB4Jj9kn
 JVQk1YjnAfwd7SA45TnFfv1qznKYFVuo/C7UAaLtwBpd2vQrehyH8ylAHT/EFD8c5PpO
 NU9Zkgl8j/CYAv0Ojzj5ifvPa0Je1zncCiXEdTnGe9y+RmgjL07sbLPO3RmxTE5Kq/1N
 DY6V/q4h/sXeACVgFYy1IgLhdrTpsM3Iv76Eq/1P30bdBjt5tHilUj3E7CXS9ae0Pig7
 MU7A==
X-Gm-Message-State: AOJu0YyuXCFhuMdAL62SccA2k+9ODZdFkl019U+a630p/DNnn1zSYPbI
 xbocWPZoUeZpC4Y4dSiwroaFr4RhXdUIaR+wiS8vRHWpArrQLyPNWL/RkKor2ZKo0c4Y89xgOaV
 4NABCVNKfA7Oq+80=
X-Received: by 2002:a2e:95d7:0:b0:2c5:521:cec3 with SMTP id
 y23-20020a2e95d7000000b002c50521cec3mr25783277ljh.23.1699341326963; 
 Mon, 06 Nov 2023 23:15:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEffMTV18Hx740x/CXz7SXQ1GV6d33E2QWq9gfCdimazDeO9y8H31vpwUcQIJihBGp9Puv8GA==
X-Received: by 2002:a2e:95d7:0:b0:2c5:521:cec3 with SMTP id
 y23-20020a2e95d7000000b002c50521cec3mr25783256ljh.23.1699341326586; 
 Mon, 06 Nov 2023 23:15:26 -0800 (PST)
Received: from redhat.com ([2.55.35.37]) by smtp.gmail.com with ESMTPSA id
 fm15-20020a05600c0c0f00b00405391f485fsm14894195wmb.41.2023.11.06.23.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 23:15:25 -0800 (PST)
Date: Tue, 7 Nov 2023 02:15:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, virtio-fs@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Erik Schilling <erik.schilling@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v6 1/6] virtio: split into vhost-user-base and
 vhost-user-device
Message-ID: <20231107020835-mutt-send-email-mst@kernel.org>
References: <20231106191515.2801863-1-alex.bennee@linaro.org>
 <20231106191515.2801863-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231106191515.2801863-2-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Nov 06, 2023 at 07:15:10PM +0000, Alex Bennée wrote:
> Lets keep a cleaner split between the base class and the derived
> vhost-user-device which we can use for generic vhost-user stubs. This
> includes an update to introduce the vq_size property so the number of
> entries in a virtq can be defined.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231009095937.195728-2-alex.bennee@linaro.org>
> 
> ---
> v5
>   - s/parent/parent_obj/
>   - remove left over vhost-user-device.h
>   - use DEFINE_TYPES
> v6
>   - rebase and set .abstrace = true for vhost-user-device

abstract :)


...


> +static const TypeInfo vub_types[] = {
> +    {
> +        .name = TYPE_VHOST_USER_BASE,
> +        .parent = TYPE_VIRTIO_DEVICE,
> +        .instance_size = sizeof(VHostUserBase),
> +        .class_init = vub_class_init,
> +        .class_size = sizeof(VHostUserBaseClass),
> +        .abstract = true

I suspect it's this change that breaks CI: 

https://gitlab.com/mstredhat/qemu/-/jobs/5472898562

WARNING: qemu received signal 6; command: "./qemu-system-ppc -display none -vga none -chardev socket,id=mon,fd=3 -mon chardev=mon,mode=control -S -machine g3beige,accel=tcg -device vhost-user-device-pci"
CRITICAL: failed: binary=./qemu-system-ppc accel=tcg machine=g3beige device=vhost-user-device-pci
CRITICAL: cmdline: ./qemu-system-ppc -S -machine g3beige,accel=tcg -device vhost-user-device-pci
CRITICAL: log: **
CRITICAL: log: ERROR:../qom/object.c:524:object_initialize_with_type: assertion failed: (type->abstract == false)
CRITICAL: log: Bail out! ERROR:../qom/object.c:524:object_initialize_with_type: assertion failed: (type->abstract == false)
CRITICAL: exit code: -6

146/395 qemu:qtest+qtest-mips / qtest-mips/device-introspect-test             ERROR           1.27s   killed by signal 6 SIGABRT
153/395 qemu:qtest+qtest-xtensa / qtest-xtensa/device-introspect-test         ERROR           1.56s   killed by signal 6 SIGABRT
171/395 qemu:qtest+qtest-riscv32 / qtest-riscv32/device-introspect-test       ERROR           1.40s   killed by signal 6 SIGABRT
184/395 qemu:qtest+qtest-ppc / qtest-ppc/device-introspect-test               ERROR           1.51s   killed by signal 6 SIGABRT
195/395 qemu:qtest+qtest-sparc64 / qtest-sparc64/device-introspect-test       ERROR           1.35s   killed by signal 6 SIGABRT

I dropped this .abstract = true line for now and the part about it in
docs.  Pls send patch on top once pull is merged.

-- 
MST


