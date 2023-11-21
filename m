Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B21657F2488
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 04:12:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5HAF-0002Fe-5N; Mon, 20 Nov 2023 22:11:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5HAA-0002FQ-Bd
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 22:10:58 -0500
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5HA7-0005qK-R1
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 22:10:57 -0500
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7c41793213fso357394241.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 19:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700536252; x=1701141052; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Td1duypqnjBJlwqmkHdFAWqtfSQ2J30Mk98XbFv+Q4=;
 b=GOkRkvzpyLiXbkoC5nruHjBE/PBaLmJDW6UJol7oLWVthznR8v4g5kOBFwvJEgUpJ2
 PMST1z1WcTamwefemYDD1Bv3u9q5Vj2oNL1mEtyJeL59aViaBpvLJ2x42WxkWTuJzXn2
 BbUUupohOR5Wfws3jSGX7t5lhnPqMZA28uDq9QrJQ9ONl95hsu30aiR0hvqAmbMqQncO
 L3XuHHJUvY9DI0L46Az8OffVGEdkUm2XYywGOXOfN/qapfBRf6SKgosDTvwKjcpi8hqz
 zCj8I0PYCZJNELGhRmOz2ZZXGCK08LASBUQvYrJgzyaBdLq9Wjp3z4qWgw+pCXIUq6ut
 X4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700536252; x=1701141052;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Td1duypqnjBJlwqmkHdFAWqtfSQ2J30Mk98XbFv+Q4=;
 b=ggRYG5qu7yd3NFIpvR1hSRDyWQLkP8RJFnHgXAH2vjMEIiHwuGWwKUQKkJEFS8zYjW
 gCtCJGHB8ZjRKkrprCxr+EGcKK3C5QhesI2+wA0N4FHsI7dkI3FJttfW7cfACLrPocv1
 ArkjJwrz51dUdiFflH6wPikE1lLgWwUeGQi+Mh2H1QnRVj4XBMxLEhh7bM4tFXjc0npo
 9uLCJ7u3+JcgfqQ3FIUBFBtuBSYNjY/+IRZvKY6kpYfgZSM6FyWP7zd1l19Zc4WRzZmR
 adJbx6PY+7P+IiA7FUz8WjPJxhU40uCPSFImItgxbd+Xh0rIIEd/jzzlncCMwfHBaYXn
 p/8g==
X-Gm-Message-State: AOJu0Yx1sZjUrf//04eVODrAFU4szLfrs0lf1asKX7H+BtGqr+y6wsLQ
 x1PEQtxcUn4VI6CPy9Q08gc0ZbjNYVgXQP+uXag=
X-Google-Smtp-Source: AGHT+IGkExeZYLp4DAjZVc8KA0lHzcdP+mx58RnBY2VwX/Ap75JSuqbAvmAGKFPMq7qhTKy5azrT8cIKLvSxV1x4KJI=
X-Received: by 2002:a67:c08d:0:b0:45d:86d0:27 with SMTP id
 x13-20020a67c08d000000b0045d86d00027mr8213693vsi.33.1700536252050; 
 Mon, 20 Nov 2023 19:10:52 -0800 (PST)
MIME-Version: 1.0
References: <20231117114457.177308-1-thuth@redhat.com>
 <20231117114457.177308-2-thuth@redhat.com>
In-Reply-To: <20231117114457.177308-2-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Nov 2023 13:10:25 +1000
Message-ID: <CAKmqyKMc0MjRvcXCFG3f4CUT8=i48ZAVSUqSHaiKj+1=4=bX-w@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] docs/system/arm: Fix for rename of type
 "xlnx.bbram-ctrl"
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Fri, Nov 17, 2023 at 9:47=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> From: Markus Armbruster <armbru@redhat.com>
>
> Fixes: b65b4b7ae3c8 (xlnx-bbram: hw/nvram: Use dot in device type name)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> [thuth: Use longhand syntax to avoid problems with the "." in the name]
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  docs/system/arm/xlnx-versal-virt.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-=
versal-virt.rst
> index d2d1b26692..9a4b2ff55f 100644
> --- a/docs/system/arm/xlnx-versal-virt.rst
> +++ b/docs/system/arm/xlnx-versal-virt.rst
> @@ -194,7 +194,7 @@ To use a different index value, N, from default of 0,=
 add:
>
>  .. code-block:: bash
>
> -  -global xlnx,bbram-ctrl.drive-index=3DN
> +  -global driver=3Dxlnx.bbram-ctrl,property=3Ddrive-index,value=3DN
>
>  eFUSE File Backend
>  """"""""""""""""""
> --
> 2.42.0
>
>

