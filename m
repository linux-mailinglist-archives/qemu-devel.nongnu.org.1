Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C16872336D
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 01:00:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6J9t-0001ac-Vx; Mon, 05 Jun 2023 18:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q6J9r-0001aS-Q4
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 18:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q6J9q-00081F-5B
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 18:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686005917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LvE6XqiC85g1R+FRt+SV0RAqVTJyzrLFgVphSehr/Dc=;
 b=NOZOPMrYOu8LWPFvxh8DFqlw3j1f+Wg1UXFt+zqck4tpXxDXaOrcaUxvDPLSA8rTMuyTlt
 WAG6wd2wnVzBlcditHlJaia4/6/SHeZbOiNzxKZqezgPjsdL8bsYEufDtFXSSBkbB6awHy
 BJA0pdvda1TSH1eXx0dbINm0iBYiA9M=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-i-fYJOUiOV6w7_yXJ0m19Q-1; Mon, 05 Jun 2023 18:58:35 -0400
X-MC-Unique: i-fYJOUiOV6w7_yXJ0m19Q-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-7775a282e25so365758839f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 15:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686005915; x=1688597915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LvE6XqiC85g1R+FRt+SV0RAqVTJyzrLFgVphSehr/Dc=;
 b=RPAmq9Ijh7trBY66GD48hc34EryrN6mHxNoiCjdu05EToiVeBFxg8GlaLMfpJKw4Nn
 MFsFbmWJQ69yxEIH+N9rgMLHRZMo/cEsnb9yhIe46aaPvvN1JLNA+VfC/fAfCHCknBGa
 XeRJmZ1kYHkMtPfHxBvxERcT/X+dt71uwmppbmwqipe/Ck3qi1AE4kyF6ycbAJwiqvjP
 ntAMFTWnMD7xKQDVysA95ERBN4fls//7ILws/+dLErJuIHVl/nwohXcV3cMHuVciUuNz
 8T7LYv6EXFYvaguMzZIq5OhjWLHpCh3mCJBnLQJsixL30K2PlWQE26khSTQVcqBg0jmu
 9iZQ==
X-Gm-Message-State: AC+VfDzVzEw/hhtxiV7PJp01xZF9rXl1C0sRrBGJv5UHyVKQhAZ0Phnz
 QjL575A8OKDcGdRHW214WzEhE3X6/GoJcZ66KE39XvzgGX5w/3KTLlszN5AVwnqrpT0U5tEOJXY
 t9+kXCzzz0QjCo8I=
X-Received: by 2002:a05:6602:2759:b0:774:7eca:d9c5 with SMTP id
 b25-20020a056602275900b007747ecad9c5mr603773ioe.2.1686005915245; 
 Mon, 05 Jun 2023 15:58:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7V3+UlzzZ8PKNhSezYV7OGQZ7xULTVKpskuA5snKeV6beQ8tsR8OxSwTgiCnWJ/Bvz38ADkg==
X-Received: by 2002:a05:6602:2759:b0:774:7eca:d9c5 with SMTP id
 b25-20020a056602275900b007747ecad9c5mr603755ioe.2.1686005915000; 
 Mon, 05 Jun 2023 15:58:35 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 l16-20020a6b7010000000b007748f491918sm2785768ioc.40.2023.06.05.15.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 15:58:34 -0700 (PDT)
Date: Mon, 5 Jun 2023 16:58:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Cedric Le Goater <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Philippe Mathieu-Daude <philmd@linaro.org>, Avihai
 Horon <avihaih@nvidia.com>
Subject: Re: [PATCH v4 2/2] hw/vfio: Add number of dirty pages to
 vfio_get_dirty_bitmap tracepoint
Message-ID: <20230605165833.402cfe81.alex.williamson@redhat.com>
In-Reply-To: <20230530180556.24441-3-joao.m.martins@oracle.com>
References: <20230530180556.24441-1-joao.m.martins@oracle.com>
 <20230530180556.24441-3-joao.m.martins@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, 30 May 2023 19:05:56 +0100
Joao Martins <joao.m.martins@oracle.com> wrote:

> Include the number of dirty pages on the vfio_get_dirty_bitmap tracepoint.
> These are fetched from the newly added return value in
> cpu_physical_memory_set_dirty_lebitmap().
>=20
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/vfio/common.c     | 7 ++++---
>  hw/vfio/trace-events | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)


Acked-by: Alex Williamson <alex.williamson@redhat.com>




> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 78358ede2764..fa8fd949b1cf 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1747,6 +1747,7 @@ static int vfio_get_dirty_bitmap(VFIOContainer *con=
tainer, uint64_t iova,
>  {
>      bool all_device_dirty_tracking =3D
>          vfio_devices_all_device_dirty_tracking(container);
> +    uint64_t dirty_pages;
>      VFIOBitmap vbmap;
>      int ret;
> =20
> @@ -1772,11 +1773,11 @@ static int vfio_get_dirty_bitmap(VFIOContainer *c=
ontainer, uint64_t iova,
>          goto out;
>      }
> =20
> -    cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
> -                                           vbmap.pages);
> +    dirty_pages =3D cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap,=
 ram_addr,
> +                                                         vbmap.pages);
> =20
>      trace_vfio_get_dirty_bitmap(container->fd, iova, size, vbmap.size,
> -                                ram_addr);
> +                                ram_addr, dirty_pages);
>  out:
>      g_free(vbmap.bitmap);
> =20
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 646e42fd27f9..cfb60c354de3 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -120,7 +120,7 @@ vfio_region_sparse_mmap_header(const char *name, int =
index, int nr_areas) "Devic
>  vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long =
end) "sparse entry %d [0x%lx - 0x%lx]"
>  vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t=
 subtype) "%s index %d, %08x/%08x"
>  vfio_dma_unmap_overflow_workaround(void) ""
> -vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bit=
map_size, uint64_t start) "container fd=3D%d, iova=3D0x%"PRIx64" size=3D 0x=
%"PRIx64" bitmap_size=3D0x%"PRIx64" start=3D0x%"PRIx64
> +vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bit=
map_size, uint64_t start, uint64_t dirty_pages) "container fd=3D%d, iova=3D=
0x%"PRIx64" size=3D 0x%"PRIx64" bitmap_size=3D0x%"PRIx64" start=3D0x%"PRIx6=
4" dirty_pages=3D%"PRIu64
>  vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iom=
mu dirty @ 0x%"PRIx64" - 0x%"PRIx64
> =20
>  # platform.c


