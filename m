Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3426D7467C6
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 05:09:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGWOf-0004dL-Am; Mon, 03 Jul 2023 23:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qGWOd-0004d9-DA
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 23:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qGWOb-0005Bq-GI
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 23:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688440084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/hQLS8U3hAhb71t2dwch+gJPJS6zlmMz6cSkxPFVHLE=;
 b=Z5QnPMHgH6CAvLstnvlVKdma1jDyAlFmQdCEygoZJy/qDNribWwHGGe2R9PmYXsA4iOii/
 ea2jYaYohJsIw9u+K8ymK12oO8Yt9X4FoASiBoLiVzKSYa9rL1ZaoBVkG1PwMwzfcCHCFl
 2I/BKuK1otGAKU+DSnWLtASt/YIiuF0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-zE0mBJ1MP0WYp_yADl29Kg-1; Mon, 03 Jul 2023 23:08:02 -0400
X-MC-Unique: zE0mBJ1MP0WYp_yADl29Kg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fb3f3a87d4so2642328e87.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 20:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688440081; x=1691032081;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/hQLS8U3hAhb71t2dwch+gJPJS6zlmMz6cSkxPFVHLE=;
 b=A2bwB8v7iBIxxLAs8G0DbGhZXEjhOyPnOvGv7jE2wJnyaCnyGu5pXfofQfVWk/Yc7e
 tzbG5mnPTKTZTLLDpq+8NZBzV/zyPzWUh03F00+BLCyPKJMjl33TcPCDH0wLH2EhFYFG
 nscpdECtV31KK+GVrDtHaquvGMeNGdULlUmZNUtWDaYFaSE0foDOnkdiaCZsLqOlu1jx
 DJQJnxLFQ5hqT+kPGAv/3QQMrx6Cy1YfNSNrQnmZs0MWnEfZ3+fV/Z+G9iVlA1jUz9xX
 ZoljBmE1eqeIdP54pOcaVBgSCazrqc3tl7q4cA/cJhPvP/YTmXKaehVTHPDE/CL8nzou
 NgCA==
X-Gm-Message-State: ABy/qLaEYKM7geqKQ6ZOjVV/cI0jzhTQq4guXkEQI8mSLSPpUeFv87YL
 DvgWzzbtbD4gvtiVM+qftIWiSyH7iQZh+Diz3h1uzu4HIbJIXUnCOR+EXZMdUtlUqCH4KSyqvU6
 jG/yg0AeiSE2MpGbmJA7BzlJiocOZXro=
X-Received: by 2002:a05:6512:3a8e:b0:4f9:dac6:2f3d with SMTP id
 q14-20020a0565123a8e00b004f9dac62f3dmr4814368lfu.13.1688440081267; 
 Mon, 03 Jul 2023 20:08:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGklQQjEWC6Oze/dLWMfkhsoYqvEZwp1TNQu4Z3JZ4uRyu/2qsT0P3uzY3Bi7D+6xuY5J1p4kz/74G6R5+8aMo=
X-Received: by 2002:a05:6512:3a8e:b0:4f9:dac6:2f3d with SMTP id
 q14-20020a0565123a8e00b004f9dac62f3dmr4814363lfu.13.1688440081007; Mon, 03
 Jul 2023 20:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230620195054.23929-1-lvivier@redhat.com>
 <20230620195054.23929-3-lvivier@redhat.com>
 <CAFEAcA_r31PU1LRka36dSJ6vZ2boP33MB=Ns5hDMRrSTN1Lmag@mail.gmail.com>
 <269b9686-f7df-72de-ae6b-242767feccaa@redhat.com>
In-Reply-To: <269b9686-f7df-72de-ae6b-242767feccaa@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Jul 2023 11:07:49 +0800
Message-ID: <CACGkMEs9L82XyMfnR6ngSio18n=_Baxh1xFtGkNp72eHVtrUeg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm_crb: mark memory as protected
To: Laurent Vivier <lvivier@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 mst@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 marcandre.lureau@redhat.com, eric.auger@redhat.com, 
 Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 22, 2023 at 9:39=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:
>
> On 6/22/23 15:12, Peter Maydell wrote:
> > On Tue, 20 Jun 2023 at 20:51, Laurent Vivier <lvivier@redhat.com> wrote=
:
> >>
> >> This memory is not correctly aligned and cannot be registered
> >> by vDPA and VFIO.
> >
> > Isn't this a vDPA/VFIO problem? There's no requirement
> > for RAM MemoryRegions to be aligned in any way.

It's more about the limitation of the IOMMU which can't do subpage protecti=
on.

> > Code
> > that doesn't want to work with small or weirdly aligned
> > regions should skip them if that's the right behaviour
> > for that particular code IMHO.

We had already had this:

    if ((!memory_region_is_ram(section->mr) &&
         !memory_region_is_iommu(section->mr)) ||
        memory_region_is_protected(section->mr) ||
        /* vhost-vDPA doesn't allow MMIO to be mapped  */
        memory_region_is_ram_device(section->mr)) {
        return true;
    }

> >
>
> Marc-Andr=C3=A9 proposed to modify vDPA code to skip the region but Micha=
l disagreed:
>
> https://lists.nongnu.org/archive/html/qemu-devel/2022-11/msg03670.html
>
> No one wants the modification, so the problem cannot be fixed.
>

Yes, otherwise we end up with explicit check for TPM crb in vhost code...

Thanks

> Thanks,
> Laurent
>


