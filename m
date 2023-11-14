Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6577EB212
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:27:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2uMl-0006zv-MZ; Tue, 14 Nov 2023 09:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2uMc-0006zi-9p
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:26:02 -0500
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2uMa-0005aI-CJ
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:26:02 -0500
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-77784edc2edso350585885a.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699971958; x=1700576758; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oMPtT43wWsN3HgupWW6t/QvmET5ICPsbKK5toIyitLM=;
 b=n5ys5BDHE4Or6+8kQvGKtmkMRGTYzRDtRKlIakGDNJCmiQad8hZCPxmNfla6R1Rmbp
 1OyFtYbQ76aPziWUijlqNwl1aY52ZpVJij7owZ+F9eDVWAYaLe7WkiaFB3wsUe7yoqQO
 dezeIw6xQzUM9sO72ylUP8+izo/mqfktsrZ3zH8FGq78mUcEiQ3zWkJhy7dm9kURecau
 0Dwvy9VNmQ2O1ZIui8WaAO8wJ1LBSiYKNcDM90qaPPE9c3kK0LrG2EeL0KCrEqyEF2qg
 tEpMoIXwOb5oSdRIQwTTdiSgMDN53Jf6jvuv2IP/LEOclFVEB/1DqI8MLPZIAHZWH1el
 fDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699971958; x=1700576758;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oMPtT43wWsN3HgupWW6t/QvmET5ICPsbKK5toIyitLM=;
 b=YKwA7e+n+747xtqOAvv6aQEMiXKQubiNAxHhGSmYb+GQfmtmFXfOOSh6qR0EffY8YC
 B4rgX/Tfe4WqtrG8aWPk3ThLJDewlecPSFc1UeoP6NcT9ilouF4e8JW3RvkI1nNFw+UM
 7vc15wEuMDERvJ8loAYPfA4TB9zvvV17ommTqkdzmGWvf2ICK4DCD15BGdgy3W7NPJmp
 ez/C6C5fwmMIIrd2yQkKaPzSmrApOrHrWmzrol/tK6XGPNnszKp8sZ5yZtQ+gjkNRGam
 uW/9O+Q4WRLq84gyPrz5FiZSfkFIXpGviVMaNfOXnz63AZWdZHPkmBtckGbrRnek95BC
 bymQ==
X-Gm-Message-State: AOJu0YzCRSUvxumFFabaRkC+/uybcymLQwCdF03WkZ7EMpRZE9GdIU3s
 ZFskbugMagjX2NXHXELKSWyYdLMi34NJHSpWGOuVlYCimvU=
X-Google-Smtp-Source: AGHT+IH4U10KZvvVcUHvDvOk/ICOhLn27H/r347mxeum3z50EJuqAorCsBvQRKToJgRx3wU4vz8itQ==
X-Received: by 2002:a05:620a:d8e:b0:77b:cc56:4a02 with SMTP id
 q14-20020a05620a0d8e00b0077bcc564a02mr2700716qkl.11.1699971957964; 
 Tue, 14 Nov 2023 06:25:57 -0800 (PST)
Received: from leoy-huanghe ([12.186.190.2]) by smtp.gmail.com with ESMTPSA id
 n11-20020a05620a294b00b007756c0853a5sm2657757qkp.58.2023.11.14.06.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 06:25:57 -0800 (PST)
Date: Tue, 14 Nov 2023 22:25:55 +0800
From: Leo Yan <leo.yan@linaro.org>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v2 2/4] docs/system: Add vhost-user-input documentation
Message-ID: <20231114142555.GD132024@leoy-huanghe>
References: <20231113190211.92412-1-leo.yan@linaro.org>
 <20231113190211.92412-3-leo.yan@linaro.org>
 <CAJ+F1CJTGWoV2kvzcxMsp6wE-6d_c2OxQfVQ+025DxK3kK3EPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CJTGWoV2kvzcxMsp6wE-6d_c2OxQfVQ+025DxK3kK3EPA@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=leo.yan@linaro.org; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Marc-André,

+ Mathieu for vhost RNG stuff.

On Tue, Nov 14, 2023 at 01:54:50PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Nov 13, 2023 at 11:04 PM Leo Yan <leo.yan@linaro.org> wrote:

[...]

> > @@ -2233,6 +2233,7 @@ L: virtio-fs@redhat.com
> >  virtio-input
> >  M: Gerd Hoffmann <kraxel@redhat.com>
> >  S: Odd Fixes
> > +F: docs/system/devices/vhost-user-input.rst
> >  F: hw/input/vhost-user-input.c
> >  F: hw/input/virtio-input*.c
> >  F: include/hw/virtio/virtio-input.h
> > diff --git a/docs/system/devices/vhost-user-input.rst b/docs/system/devices/vhost-user-input.rst
> 
> You need to include the file in the toctree, in docs/system/device-emulation.rst

Will update the toctree in next version.

[...]

> > +The QEMU invocation needs to create a chardev socket to communicate with the
> > +backend daemon and share memory with the guest over a memfd.
> > +
> > +::
> > +
> > +  host# qemu-system                                                            \
> > +      -chardev socket,path=/tmp/input.sock,id=mouse0                           \
> > +      -device vhost-user-input-pci,chardev=mouse0                              \
> > +      -m 4096                                                                  \
> > +      -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on    \
> > +      -numa node,memdev=mem
> 
> 
> Well, this is not a memfd. This is taken from vhost-user-rng.rst, and
> should probably be adjusted there too.

Yeah, I copied from vhost-user-rng.rst.

To be easier for our life, I will firstly fix this patch for this part,
later we can consider to update vhost-user-rng.rst in a separate patch.
Looped in Mathieu to be awared.

> It needs shared memory, memory-backend-file can provide it and is
> generally more available than memfd, although memfd should be
> preferred as it offers some extra security guarantees. There is
> already some explanations in vhost-user.rst, maybe we should just add
> extra links.

I will update the doc as:

"The QEMU invocation needs to create a chardev socket to communicate with the
backend daemon and access the VirtIO queues with the guest over the
:ref:`_shared_memory_object`."

Thanks,
Leo

