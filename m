Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC397A0438
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:45:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgliK-0008HB-8n; Thu, 14 Sep 2023 08:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qgliI-0008Fc-Cw
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:44:54 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qgliG-0001lw-P0
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:44:54 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3a812843f0fso463703b6e.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 05:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694695491; x=1695300291; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XrfYQgSAyghvsIOzlf2/LH4h44ubPen0F7aKPTh/KZA=;
 b=B3Xz3wZqc8uO+xLI/3kQKEWikG++2gIsKjw29H7deUzaNnYhep6Dvq6EN7VyZwF4en
 FEaMGOi4A8kyNSa8U9w05XDge7wiWgunA0+qE/xjsVZoobd6aRu1eNUCiTkg37BdFROy
 DBBZ2a4kxK0TE0/tnDjkkvRLGsNhU/ut+RXW1MeX104gnJbyJXu8zp6CUN5J1bDKiGFy
 VkkSlZyXKlPNKkwoAZJ5hEyNsQEVIY3C6ddzgM0XRI8psBUN2egCmOXJYE1OFe23nPEm
 Y6btgizfIXLJZdU6pQP7SB3Ht4kK+sZ6wcnjluU9jpEtWxCKxo2+sm4b8w5Nft6hWAo9
 HzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694695491; x=1695300291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XrfYQgSAyghvsIOzlf2/LH4h44ubPen0F7aKPTh/KZA=;
 b=Ye3yZAT+H+6deYUjd3el1tqLEeh+s+L4w1c9HJKHDpDO1jMbeJ6q5pf4cidj8+3hIP
 ggoW7u0oREW9jdq5+tMzqtvttaff7/Duu9ikW85Phks7J2LGIkKhmdi+acNYdQd63IsC
 90n3FpWH/nJ065BQb3q3RZhkvS+1S+/xWogjp63CaYpf08GKte+IK7JbcDTKlBgb/Jos
 8rD6+ZI4lRs4cNhz9Jfcoow2j/bbv8tzwTu/tyhZD8qJn4Pry6dVenEzguxPLNLPlZsG
 RzUZ0xKRmnwKkszgXjXZsPGmSyy7TyJzk1PE3hZQAyU8VJY9qBB2e7XOCV7MMpozxpsd
 0zKA==
X-Gm-Message-State: AOJu0YwWfWsIXc96vff5s99BcI97vrqCEvcEYpFrGB/4fMi2cWVO0QQJ
 KEiGn7zXL41UPEhrGA1vjsHz9RKcld4Ej6r1f3fU0kTv
X-Google-Smtp-Source: AGHT+IGrrGaBBYV/hv550WR6HeQv75BCmiXrzR+v8dugx4+d48uvmOgCQXDlCjOJtErDfO9P0BcDu8lp7RLOPwvg5/k=
X-Received: by 2002:a05:6808:5c9:b0:3a9:b9eb:998e with SMTP id
 d9-20020a05680805c900b003a9b9eb998emr5313357oij.51.1694695491307; Thu, 14 Sep
 2023 05:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230803195115.2367293-1-stefanha@redhat.com>
In-Reply-To: <20230803195115.2367293-1-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 14 Sep 2023 08:44:38 -0400
Message-ID: <CAJSP0QUO+=01pxry2v71p3c+W2q2uRvUusmDU5ym6L6SFW0n4g@mail.gmail.com>
Subject: Re: [PATCH] qdev-properties: alias all object class properties
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x235.google.com
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

Paolo: ping?

On Thu, 3 Aug 2023 at 15:51, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> qdev_alias_all_properties() aliases a DeviceState's qdev properties onto
> an Object. This is used for VirtioPCIProxy types so that --device
> virtio-blk-pci has properties of its embedded --device virtio-blk-device
> object.
>
> Currently this function is implemented using qdev properties. Change the
> function to use QOM object class properties instead. This works because
> qdev properties create QOM object class properties, but it also catches
> any QOM object class-only properties that have no qdev properties.
>
> This change ensures that properties of devices are shown with --device
> foo,\? even if they are QOM object class properties.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/core/qdev-properties.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 357b8761b5..fbf3969d3c 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -959,16 +959,18 @@ void device_class_set_props(DeviceClass *dc, Property *props)
>  void qdev_alias_all_properties(DeviceState *target, Object *source)
>  {
>      ObjectClass *class;
> -    Property *prop;
> +    ObjectPropertyIterator iter;
> +    ObjectProperty *prop;
>
>      class = object_get_class(OBJECT(target));
> -    do {
> -        DeviceClass *dc = DEVICE_CLASS(class);
>
> -        for (prop = dc->props_; prop && prop->name; prop++) {
> -            object_property_add_alias(source, prop->name,
> -                                      OBJECT(target), prop->name);
> +    object_class_property_iter_init(&iter, class);
> +    while ((prop = object_property_iter_next(&iter))) {
> +        if (object_property_find(source, prop->name)) {
> +            continue; /* skip duplicate properties */
>          }
> -        class = object_class_get_parent(class);
> -    } while (class != object_class_by_name(TYPE_DEVICE));
> +
> +        object_property_add_alias(source, prop->name,
> +                                  OBJECT(target), prop->name);
> +    }
>  }
> --
> 2.41.0
>
>

