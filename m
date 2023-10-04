Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB47A7B8516
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:26:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4hc-0001Ol-Iv; Wed, 04 Oct 2023 12:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo4ha-0001NG-6o
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo4hY-0006Y5-PZ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696436780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rt3KtWsknSNII3Ae+6vUZV7DF/dOA5BFumzZ0dseeWU=;
 b=No82R9TpIH3gVQpILtyLxZLomBfLSNWGrh3uBSRfPBTznqQspzRoxBLmBSBtb5J1rwOmGJ
 cpZvg9AKf+XJJd5AyTuz+0hhHBg7c0APTV5yhEhAU6YfM5s5JOKk6tOxWG6zn1Fa+GqPxi
 dhrcIojZDryce7nDIoyazucrRlgQD+Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-MM0-XxD_MGqoZBNh6RSlDA-1; Wed, 04 Oct 2023 12:26:08 -0400
X-MC-Unique: MM0-XxD_MGqoZBNh6RSlDA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4197878ffe9so6796781cf.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696436768; x=1697041568;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rt3KtWsknSNII3Ae+6vUZV7DF/dOA5BFumzZ0dseeWU=;
 b=aN7ouFg99DdT0PfIHRL/saE/nqCbSjFBlf1nfow1YxAxBRR/T6ZHhGiRM+8OcajJBw
 oe5htKProce94UQ+RWvg7LKTwMfY7VkpXBqBRlLC9yI67RrAd3J6u2+8tlrX7yTp5BKt
 MMap1KT9uv1wDgs/+8bosp930jRarxRBfMMc8zXxBiwbzTybuVcE+iqgv1ZMIF9HQCsN
 OT7Z+gMPbVzMltbdtayKWva4rn+HnchqLhgpR4tU/fvBKiJT5Nw/nJgBkKUaJU4lLgqu
 fq0gm1scOzy4TSkEqVNZ124JPr12jk8nRbzPqQZ8EN5zuP/fmiEiVlQdcffOmaqh+Ir8
 PY3A==
X-Gm-Message-State: AOJu0Yxdpcj3XFm4xwQ5j9ELyiNfVRNC2l7pv2ni5/EkHSkjaR9rgHtw
 dEYEnpz3n4UDoPzDZNY1RpqRDzeXK7Q27aCBtt8qigrG3lmKiuLMsxmoKooJ6D2XD65hLSaDf6a
 qfAdTlbtKWoVyLOo=
X-Received: by 2002:a05:6214:3018:b0:668:deb6:1294 with SMTP id
 ke24-20020a056214301800b00668deb61294mr2934640qvb.2.1696436768425; 
 Wed, 04 Oct 2023 09:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeFu/kT3WbJaqpF9qYsAqbjGBgwDFQHma77JW+R/HS0N7KdsjpXhebJ1YcOZyeCpMyi3dzBw==
X-Received: by 2002:a05:6214:3018:b0:668:deb6:1294 with SMTP id
 ke24-20020a056214301800b00668deb61294mr2934624qvb.2.1696436768115; 
 Wed, 04 Oct 2023 09:26:08 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0ccb03000000b0064f4ac061b0sm1439567qvk.12.2023.10.04.09.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:26:07 -0700 (PDT)
Date: Wed, 4 Oct 2023 12:26:06 -0400
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/5] RFC: migration: check required entries and sections
 are loaded
Message-ID: <ZR2SHnvPGR4xKKQ2@x1n>
References: <20230926155925.1396309-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230926155925.1396309-1-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 26, 2023 at 07:59:20PM +0400, marcandre.lureau@redhat.com wrote:
> Marc-André Lureau (5):
>   block/fdc: 'phase' is not needed on load
>   virtio: make endian_needed() work during loading
>   net/slirp: use different IDs for each instance

First 3 patches are bug fixes, am I right?

It'll be great if they can be acked (or even picked up earlier?) by
subsystem maintainers if so, and copy stable if justified proper.

Thanks,

-- 
Peter Xu


