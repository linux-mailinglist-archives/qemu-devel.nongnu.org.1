Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9C9767750
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 23:01:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPUFd-0006C0-44; Fri, 28 Jul 2023 16:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qPUFc-0006Bq-4i
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 16:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qPUFa-0001Wy-MF
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 16:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690576790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81p6DOLdmN20g4UYFN+8Heye35JklKP8vrZ67N1e9tY=;
 b=bODvFwk6Rr/jLjNkqhGXQG1mrNZkpmnfEnLoMKIOVSIGI6wzA9+Xdu3KmCRramQeeP5Nir
 V0V1wBToEyQcbW86XAAhcqoHWu52SlNxOgimdOdqrQ+FQAct4omJ0MR33FBGWaL0cY1O0k
 PzhODIf+qGV4VSThD6dYSCF9IRGjenk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-zDdTG6BJNZ6MMRHJLAD34A-1; Fri, 28 Jul 2023 16:39:47 -0400
X-MC-Unique: zDdTG6BJNZ6MMRHJLAD34A-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b6fdbe2efdso27900751fa.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 13:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690576786; x=1691181586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81p6DOLdmN20g4UYFN+8Heye35JklKP8vrZ67N1e9tY=;
 b=Bf1TxOueLvlNmyJ+THVQvvWwsX8SVx0sDJxSGxkkEP+fI4Fct2wgVZkl7z/GPQkw9U
 SD2pDI5WFJT+YcxvLqoT0l2O6XBODQcVLrA+U+Y2HA2CxEEI+pjzhfr0RUiin+KUsGUW
 nDyZEUWGcmZWGTwBKIXqHNQxYBHNNPJpxK71OzI33Uib524g7vTidNR42zUDmlNvvKJB
 OBC4jf4BqTcs1jweU3SD3Wkuv42UBewcoxuewGY3Eb/RfPYYi7jgVMWmyQk87O3X73ri
 ugmn6ZwFJXxqaBvMNUAFkydLWampVt5FxhWz7rqYVFznn671AMbyZTiXizBR+Bq3tW2+
 /n9w==
X-Gm-Message-State: ABy/qLZzDl2QeNnrRBHa/hv+0T4Mv3PFoKhO56IDqyDpoS77I7OlRczi
 JL1x7NkSWfyAm09/OCkWoHYTImzkZktw1Mg7efDK0b6eyLsXeucDOy9N4aMBP+SG1Km0B7NRiSC
 aEL0a6ilV8sHRJi2Po8dGP/xvx+h8xfc=
X-Received: by 2002:a19:691c:0:b0:4fd:d213:dfd4 with SMTP id
 e28-20020a19691c000000b004fdd213dfd4mr2205895lfc.20.1690576786161; 
 Fri, 28 Jul 2023 13:39:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGfTPY8jjGi/+WIi5tcIxsgL9+GYwILt81Z96rtj7W2zBssPWsRbPUGWdzzHYTeMZzmiJIOSWlaBco1Kigo7Yw=
X-Received: by 2002:a19:691c:0:b0:4fd:d213:dfd4 with SMTP id
 e28-20020a19691c000000b004fdd213dfd4mr2205892lfc.20.1690576785791; Fri, 28
 Jul 2023 13:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230713055819.30497-1-dongli.zhang@oracle.com>
In-Reply-To: <20230713055819.30497-1-dongli.zhang@oracle.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Jul 2023 00:39:34 +0400
Message-ID: <CAMxuvay=ecSNxa5X38zUgnyRAmutgtSNCww7P8qkAFKfPtbAVw@mail.gmail.com>
Subject: Re: [PATCH 1/1] dump: kdump-zlib data pages not dumped with
 pvtime/aarch64
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, joe.jin@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
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

Hi

On Thu, Jul 13, 2023 at 11:11=E2=80=AFAM Dongli Zhang <dongli.zhang@oracle.=
com> wrote:
>
> The kdump-zlib data pages are not dumped from aarch64 host when the
> 'pvtime' is involved, that is, when the block->target_end is not aligned =
to
> page_size. In the below example, it is expected to dump two blocks.
>
> (qemu) info mtree -f
> ... ...
>   00000000090a0000-00000000090a0fff (prio 0, ram): pvtime KVM
> ... ...
>   0000000040000000-00000001bfffffff (prio 0, ram): mach-virt.ram KVM
> ... ...
>
> However, there is an issue with get_next_page() so that the pages for
> "mach-virt.ram" will not be dumped.
>
> At line 1296, although we have reached at the end of the 'pvtime' block,
> since it is not aligned to the page_size (e.g., 0x10000), it will not bre=
ak
> at line 1298.
>
> 1255 static bool get_next_page(GuestPhysBlock **blockptr, uint64_t *pfnpt=
r,
> 1256                           uint8_t **bufptr, DumpState *s)
> ... ...
> 1294             memcpy(buf + addr % page_size, hbuf, n);
> 1295             addr +=3D n;
> 1296             if (addr % page_size =3D=3D 0) {
> 1297                 /* we filled up the page */
> 1298                 break;
> 1299             }
>
> As a result, get_next_page() will continue to the next
> block ("mach-virt.ram"). Finally, when get_next_page() returns to the
> caller:
>
> - 'pfnptr' is referring to the 'pvtime'
> - but 'blockptr' is referring to the "mach-virt.ram"
>
> When get_next_page() is called the next time, "*pfnptr +=3D 1" still refe=
rs
> to the prior 'pvtime'. It will exit immediately because it is out of the
> range of the current "mach-virt.ram".
>
> The fix is to break when it is time to come to the next block, so that bo=
th
> 'pfnptr' and 'blockptr' refer to the same block.
>
> Fixes: 94d788408d2d ("dump: fix kdump to work over non-aligned blocks")
> Cc: Joe Jin <joe.jin@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  dump/dump.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index 1f1a6edcab..c93e4c572f 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -1293,8 +1293,8 @@ static bool get_next_page(GuestPhysBlock **blockptr=
, uint64_t *pfnptr,
>
>              memcpy(buf + addr % page_size, hbuf, n);
>              addr +=3D n;
> -            if (addr % page_size =3D=3D 0) {
> -                /* we filled up the page */
> +            if (addr % page_size =3D=3D 0 || addr >=3D block->target_end=
) {
> +                /* we filled up the page or the current block is finishe=
d */
>                  break;

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>              }
>          } else {
> --
> 2.34.1
>


