Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B93714563
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 09:24:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3XDs-0005Ca-Ru; Mon, 29 May 2023 03:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1q3XDc-0005CN-10
 for qemu-devel@nongnu.org; Mon, 29 May 2023 03:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1q3XDa-0005fs-An
 for qemu-devel@nongnu.org; Mon, 29 May 2023 03:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685344980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CenTolzvn+9i3qlP68V9j0flAP7KibN/0R/gU36/ncc=;
 b=dXvat8EU+g9a+x2vNSP6UP2kutq69zhExhOBlSlNnYOSgpHpULER9VO5TLiybv8j0Z9VPj
 6ziI8QGBR18GKXE7I6j92/7YtuuO8wZQ6lb9qMJ5yZX3kc5LnAnhIeYN1bXtG2Qehf/ytx
 GlA7Ni1SFlg4DC/sy9STz/6xwSx60JI=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-pTfEojxMM-myrSG5ErM8Rg-1; Mon, 29 May 2023 03:22:58 -0400
X-MC-Unique: pTfEojxMM-myrSG5ErM8Rg-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-456edcd3990so609626e0c.0
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 00:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685344978; x=1687936978;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CenTolzvn+9i3qlP68V9j0flAP7KibN/0R/gU36/ncc=;
 b=FE97rPtVO6yIsv5IFWnbvSDbEw4NYygQJXf8N8dBpfFAgFSe01uKMqET7opwGTMvIw
 WTFoe52pveQYA/duHnjBVJrFzf/MK6cl60CjeCexEsyX97pTy3fAFb/bm2MzMhfLjZgw
 GiLCatH/+S9HnWbuAZmVHv0jm/Xiz9Jb2MuXVbJ0jwx6nUeyfh57slLlc/GwEwQg953i
 1p8yIeUl0vJJcMkqrGmlxu2Ry9Kc7D/hNtF63kuIPe9zMcqazhMUolRFUVoOEONx4Skd
 P1pleNUG/g6VfVLRENfSubH97eMpcHcYYyTVHx8KvnMWYS2LB/y9Hn20a0f4EZSZ+XME
 pmmw==
X-Gm-Message-State: AC+VfDyhOkAVTFh7UbM33AOebS//v7yVIbQ7rz/S3JfTT0P0x+oXg1Q3
 ULHq6FytnjbEYLSBqHDVpzsutJhZah0Yt+RmftoPkwxpx7wdbXhT5+JholclWaNSNxkHmVK8tm9
 7FKO+MDScuvQB9MDHQ8VZzNCZVGLxTHCqD/hPYt4=
X-Received: by 2002:a1f:d3c7:0:b0:457:2d6a:7b4d with SMTP id
 k190-20020a1fd3c7000000b004572d6a7b4dmr2268436vkg.10.1685344977806; 
 Mon, 29 May 2023 00:22:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4L14UfGh5Joav492MhLxdNFG6IuyhZcEo7qile/GhxxfDg6ey+KfLQF9Q4p+wt79hguA/lzkCjYN7JD0qHIa8=
X-Received: by 2002:a1f:d3c7:0:b0:457:2d6a:7b4d with SMTP id
 k190-20020a1fd3c7000000b004572d6a7b4dmr2268435vkg.10.1685344977524; Mon, 29
 May 2023 00:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <b70ce1ef-32c6-b645-be61-bd9a2e204952@tls.msk.ru>
In-Reply-To: <b70ce1ef-32c6-b645-be61-bd9a2e204952@tls.msk.ru>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Mon, 29 May 2023 09:22:46 +0200
Message-ID: <CAA8xKjXCxmi0kmkHPcT1Z8mQSjUOfhWjz3X6fJy-6g6dP6shRA@mail.gmail.com>
Subject: Re: [PATCH] hw/sd/sdhci: reset data count in
 sdhci_buff_access_is_sequential()
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sat, May 27, 2023 at 11:00=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> w=
rote:
>
> Mon, 7 Nov 2022 11:35:10 +0100, you wrote:
>  > Make sure to reset data_count if it's equal to (or exceeds) block_size=
.
>  > This prevents an off-by-one read / write when accessing s->fifo_buffer
>  > in sdhci_read_dataport / sdhci_write_dataport, both called right after
>  > sdhci_buff_access_is_sequential.
>  >
>  > Fixes: CVE-2022-3872
>
> ..
>
> Has this been forgotten, or maybe a better fix is needed?
>
> https://lists.nongnu.org/archive/html/qemu-devel/2022-11/msg01068.html

There was a better patch proposed by Philippe:
https://lists.nongnu.org/archive/html/qemu-devel/2022-11/msg01161.html

Which was later dropped due to a CI failure:
https://lists.nongnu.org/archive/html/qemu-devel/2022-11/msg01504.html

Not sure what's the current status.

> Thanks,
>
> /mjt
>


--
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


