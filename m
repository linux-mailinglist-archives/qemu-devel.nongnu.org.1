Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 346247CC149
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 12:58:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qshlE-00008H-Gv; Tue, 17 Oct 2023 06:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qshl9-000081-8D
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 06:57:11 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qshl7-0000gr-OU
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 06:57:11 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6c4e38483d2so3858661a34.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 03:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697540228; x=1698145028; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tSJnY8LzXEOWGbbbi2TUYKAfmxX1xwjQ3PeCz2bVJ1I=;
 b=hZ3GsnDiPVP6nYKlQZ2VgSK2NsQUk2FiWttuoeuy2Ky5f8ReLPbakkWzCTxJeRM9pw
 VugNcFij4CFUqu8XLqplpKTCQ/rehPG2jRfOeHCwIgoYx319nVuvjoG5YLME3pt6KjlL
 Tx1k84MWdSvVVsF4i1WXHTvG9WnlVbKFqAVW4rH7FUiU4qO1iG0WKIqCfE3zcdeqezWV
 hvBQu+GkZRTzar5FklulUuEIS6AtAibZja9nvEDvCBlNV6GHvg/jUDtxbUN0yQECHoz/
 Zqc07Aji/N+RUFFkWJ5/wlO9166FyV+xAOSxtXib++EvI8do/gJONd7CpYOsBMqHAnJm
 4tZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697540228; x=1698145028;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tSJnY8LzXEOWGbbbi2TUYKAfmxX1xwjQ3PeCz2bVJ1I=;
 b=OX36L/akRld0/75nYh1Z1PVmdWW3LdwueCf8bDVUGMbPKjPLgnIe5n/mrg4v+65h4R
 LHZgJE12pYfNjOjQ+h1NbMa0aq18Yhk8qSp11yGuxhuHmy/7ZhJlQzRwtJWMBp3No2x2
 EOYlNlC8f+t2Hkr9owMsVPm+sT4zSlinTcz7+sbGKLuKaKmh8sF4WLfzttM7pCGR5NaT
 WsANafrG/czBni4/4yLuYFDbe/2lMrKHnfYkoXrUtdMNivbuX4DQsyi8+7vw++JJ0oXV
 2Sizvd0zT/+HDCO24WkMlzholJwXsYO0Lm4eS7rdzpaQpTx//uKlbqgYMBwydg1/gZxm
 G9HA==
X-Gm-Message-State: AOJu0Yz29BfQw4kVPe+/WmVMPhC230fngDifa1CUEzTpfSzN1q9rhvrX
 F8EDehiSRkFhYZGsNvEm1hHByQGfeoL1e2VWnHw=
X-Google-Smtp-Source: AGHT+IF1cGkmy1yVdW569CPF2AVWHOfLWHV9RZffWz3uwGSsCQfpb7vWmIczypL62BD5EvuafsgRvY5Wy/c4GTdIqew=
X-Received: by 2002:a05:6830:4489:b0:6c6:4843:2ac5 with SMTP id
 r9-20020a056830448900b006c648432ac5mr2146779otv.21.1697540228419; Tue, 17 Oct
 2023 03:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231016083201.23736-1-hreitz@redhat.com>
 <2m60m.9e9wlnnm01vd@linaro.org>
 <20231016103254.7xrnptmwrjnsr3uc@vireshk-i7> <87lec2dc7r.fsf@linaro.org>
 <20231017053638.hhs57axmwqtzbpp6@vireshk-i7>
 <ceeaa1f3-c0ad-65c1-80d1-ec869f976146@redhat.com>
 <20231017075352.2l3htkj46gunyjrm@vireshk-i7>
 <CADSE00JkwkyruO-rhiN7p_T_2efAed8B2Uzp01jVj=YH7Wixmw@mail.gmail.com>
In-Reply-To: <CADSE00JkwkyruO-rhiN7p_T_2efAed8B2Uzp01jVj=YH7Wixmw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 17 Oct 2023 06:56:56 -0400
Message-ID: <CAJSP0QUhc5Ov=gG626gCMq+4V7rpsS2b-8VKzM3bz3VNaZ_3Xg@mail.gmail.com>
Subject: Re: [PATCH] vhost-user: Fix protocol feature bit conflict
To: Albert Esteve <aesteve@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Hanna Czenczek <hreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Garhwal, Vikram" <vikram.garhwal@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 17 Oct 2023 at 04:26, Albert Esteve <aesteve@redhat.com> wrote:
>
> Hi!
>
> Thanks for the patch, and sorry for not noticing the flag had already been assigned. The patch looks good to me!

Hi Albert,
I looked at the shared object code for the first time:
- There are memory leaks in virtio_add_dmabuf() and
virtio_add_vhost_device() when the UUID was added previously.
- The hash table is global and there is no spoofing protection, so
vhost-user devices can hijack known UUIDs. Is it possible to associate
a vhost_dev owner with each shared object and only allow the owner to
remove it?
- Is there cleanup code that removes shared objects from the hash
table when a vhost_dev is destroyed? Otherwise TYPE_VHOST_DEV shared
objects are leaked and their stale vhost_dev pointers could be
dereferenced.
- virtio-dmabuf.h API naming suggests this is a core VirtIODevice API:
virtio_free_resources(), virtio_add_vhost_device(), etc rather than an
API for VirtioSharedObject. Can the names be made more specific:
virtio_dmabuf_*() or virtio_shobj_*() so it's clear these APIs are
related to the dmabufs/shared objects?

Thanks,
Stefan

