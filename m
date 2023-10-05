Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA32F7BA2F6
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 17:49:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoQab-00022n-9c; Thu, 05 Oct 2023 11:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qoQaX-0001xo-AE
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:48:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qoQaV-0003M1-T9
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696520910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Agv6ZEbLtjE1f+8G9gEaMXj9eewmDPOVcmntiT1J/Nk=;
 b=LPCflDxt2EWtxu4y+QHVIWSPhekeiI6X/ABpW1q9I81uQn7ZGhJYppbSS4d7OxegFaQtNr
 u6K1MGpX+3dF+ez4rOm+FKpr9COt0KUJKYyPfPbD/XFmE5Itbg477Y5K0YSbbs79djNuP2
 2M+YMAuP1R2ISvDoUMqgaS6U/mFSYK4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-zBDe3_l8MTmOY4nPygNJlg-1; Thu, 05 Oct 2023 11:48:13 -0400
X-MC-Unique: zBDe3_l8MTmOY4nPygNJlg-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5784ef4be4fso1715189a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 08:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696520892; x=1697125692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Agv6ZEbLtjE1f+8G9gEaMXj9eewmDPOVcmntiT1J/Nk=;
 b=UVgjZPF8TA71cz9sfYzYfdK5MKhbjx07+uNAITOBMFUvYFugB2HLjm1DBmEhQV7phy
 JjDK4QWbYghoFKT3PJiAyynQ+oEwkibClYnCsG0HdbuV+HP7/bAj4CzvHsHEvbT25BaH
 guTaNd278aS2qM3yLxF5wRNWSQmWdhhUjCGmvDgxVeLygqX+Zf4aJule5bBT3m+d/Zd9
 4vgf5C/5WDZfk6C6bF796ACfun3Hib8JAlnRrYRJrQgH98w4aIS0qTHoLbfLcn0U20wh
 qO9bVXTwaL0TKk24SR/PXVMTp6HPhiZnoF/X3z5Aq070SZn83+hsDTUpgjN6dZaTTESi
 VidQ==
X-Gm-Message-State: AOJu0YyW3iG/qkhxG/Uy1xhBn/7zRHnHCmewnhvscCYvd5r7UQ4RpE4f
 X1ViAcxTeTIjsEhfumCCfL9ayK3TPObhIu6mQo73tYvCfOepzFhk+NsqKZo9m/CBCob9nvG0jKW
 XUo6fUqJlHPytZu613Dr2K6Eo1rnlIto=
X-Received: by 2002:a17:90b:78e:b0:276:78f2:5d31 with SMTP id
 l14-20020a17090b078e00b0027678f25d31mr4463508pjz.21.1696520892613; 
 Thu, 05 Oct 2023 08:48:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnjWB8ypKWCg2xXzfjlXtryDsd4Ybc8BVa6+b9sddRrMIaFmOU7dLbJxkw1SieFujqz9fCXsn4htgyOljfZ1U=
X-Received: by 2002:a17:90b:78e:b0:276:78f2:5d31 with SMTP id
 l14-20020a17090b078e00b0027678f25d31mr4463492pjz.21.1696520892328; Thu, 05
 Oct 2023 08:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231004120019.93101-1-philmd@linaro.org>
 <20231004120019.93101-3-philmd@linaro.org>
In-Reply-To: <20231004120019.93101-3-philmd@linaro.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 5 Oct 2023 11:48:01 -0400
Message-ID: <CAFn=p-ZcqtGWD+j3tp0AbHxkVRO-sqO-QNGusVMT_DbtCWyQ2g@mail.gmail.com>
Subject: Re: [PATCH v3 02/16] hw/ide/ahci: Clean up local variable shadowing
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 4, 2023 at 8:00=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Fix:
>
>   hw/ide/ahci.c:1577:23: error: declaration shadows a local variable [-We=
rror,-Wshadow]
>             IDEState *s =3D &ad->port.ifs[j];
>                       ^
>   hw/ide/ahci.c:1569:29: note: previous declaration is here
>     void ahci_uninit(AHCIState *s)
>                                 ^
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  hw/ide/ahci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index d0a774bc17..fcc5476e9e 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1622,9 +1622,7 @@ void ahci_uninit(AHCIState *s)
>          AHCIDevice *ad =3D &s->dev[i];
>
>          for (j =3D 0; j < 2; j++) {
> -            IDEState *s =3D &ad->port.ifs[j];
> -
> -            ide_exit(s);
> +            ide_exit(&ad->port.ifs[j]);
>          }
>          object_unparent(OBJECT(&ad->port));
>      }
> --
> 2.41.0
>


