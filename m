Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B42CB79F905
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 05:48:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgdJZ-0004ou-3S; Wed, 13 Sep 2023 23:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qgdJX-0004oh-3R
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:46:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qgdJV-0008Gg-C0
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694663202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H9JBgLR45+B9TMOZf9SBt8nkknP/A8kyiFzFMcZjWb8=;
 b=RkWanOeEp0uuvvPMYhkyNS/fnY1VKv9aDl/tJc/4iPr9bK+QerHs61UQd1pvw85n7Zn6ai
 moAUou4s6JJModWeBMdr9BQxe5aNaGQX4ZgZpN6SbJiMypjgQ2wkIEqQ+gKZIvYjPzMhom
 DUROC1cU2LT7a5+QRULo+NuDORNhA1g=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-Tpk8KAeGPxKy5PqZ9mrqDg-1; Wed, 13 Sep 2023 23:46:38 -0400
X-MC-Unique: Tpk8KAeGPxKy5PqZ9mrqDg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-501ce5902faso1109775e87.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 20:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694663197; x=1695267997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H9JBgLR45+B9TMOZf9SBt8nkknP/A8kyiFzFMcZjWb8=;
 b=mzc/tvBFe1fW2QoIRZXdXfVd1yJnyCUr55x34zhg3BIDCJCsw1m43lEMMifnITS2Is
 XsDuqS/kiv2brqvcTOFadtbE90XnaW8eR17zy6+1eRTtuAXbV9JAniz3BLi3ETduOuA4
 8Fl5n94xVrZU8aCkkVkvU9FL+BAlovbwQUXyNBvfbaxgxow8WbWzTObP/Rc6sbohm2IE
 tTS7/Wif7/c9R0eVmbqXziaBYnGD+vbXEJbWfms8+vKgEQZdv6hgXOk9378Cgg7q0a1R
 t8lQe9HWTpp/FDmbCoMcvnar5B7gCpBe+pc5M7cwKT1ffypI2JfwPxiMNI71iOGuxQJ3
 492w==
X-Gm-Message-State: AOJu0Yxy+gkMnAvHnXSlf3+TrM47MRwuqOCAlIEqmQn2StHoxKyE+ZR+
 +rhkWnU/DSeGNjqc/bGMNAwNW0UYn7o1b+TuJQZS/Ju2XZPfx51NU53EzcUoXI6MT5fKy7t681R
 Tkk2KiD1hN5LQVq2+i9358l2RAd9YQIs=
X-Received: by 2002:ac2:465a:0:b0:4fe:4896:b6ab with SMTP id
 s26-20020ac2465a000000b004fe4896b6abmr162486lfo.15.1694663197466; 
 Wed, 13 Sep 2023 20:46:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtMPgntrQqggvNXSsy3XyIYTRWL5yf0uQ3IF94omuMpkMKAR5QiP+MCABuETb8dsTSmaaPzfTSJ5OMQ1IxmaA=
X-Received: by 2002:ac2:465a:0:b0:4fe:4896:b6ab with SMTP id
 s26-20020ac2465a000000b004fe4896b6abmr162482lfo.15.1694663197119; Wed, 13 Sep
 2023 20:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230913074657.523530-1-eric.auger@redhat.com>
In-Reply-To: <20230913074657.523530-1-eric.auger@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Sep 2023 11:46:25 +0800
Message-ID: <CACGkMEttFn3eBfTPeumtfLuWnhZs7_4zKh6fP1jzyAb47GuQkQ@mail.gmail.com>
Subject: Re: [PATCH] vhost: Add a defensive check in vhost_commit against
 wrong deallocation
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, mst@redhat.com, qemu-devel@nongnu.org, 
 lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 13, 2023 at 3:47=E2=80=AFPM Eric Auger <eric.auger@redhat.com> =
wrote:
>
> In vhost_commit(), it may happen that dev->mem_sections and
> dev->tmp_sections are equal, in which case, unconditionally
> freeing old_sections at the end of the function will also free
> dev->mem_sections used on subsequent call leading to a segmentation
> fault.
>
> Check this situation before deallocating memory.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Fixes: c44317efecb2 ("vhost: Build temporary section list and deref
> after commit")
> CC: QEMU Stable <qemu-stable@nongnu.org>
>
> ---
>
> This SIGSEV condition can be reproduced with
> https://lore.kernel.org/all/20230904080451.424731-1-eric.auger@redhat.com=
/#r
> This is most probably happening in a situation where the memory API is
> used in a wrong manner but well.

Any chance to move this to the memory API or we may end up with things
like this in another listener?

Thanks

> ---
>  hw/virtio/vhost.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index e2f6ffb446..c02c599ef0 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -545,6 +545,11 @@ static void vhost_commit(MemoryListener *listener)
>      dev->mem_sections =3D dev->tmp_sections;
>      dev->n_mem_sections =3D dev->n_tmp_sections;
>
> +    if (old_sections =3D=3D dev->mem_sections) {
> +        assert(n_old_sections =3D=3D  dev->n_mem_sections);
> +        return;
> +    }
> +
>      if (dev->n_mem_sections !=3D n_old_sections) {
>          changed =3D true;
>      } else {
> --
> 2.41.0
>


