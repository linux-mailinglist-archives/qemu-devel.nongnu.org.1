Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 211F979A766
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 12:45:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfeQ3-0001TO-OT; Mon, 11 Sep 2023 06:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1qfePl-000193-71
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:45:16 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1qfePh-00071b-7b
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:45:08 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31c65820134so3932359f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 03:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1694429097; x=1695033897; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XDlF5YI0/CppNpOQ1vN3K+1CKKPjKeo7ClgielEzmv4=;
 b=Bb+2n4u/YMx54RfWyJ7+jzzSwT+NiwAzbnDWj7CWPYXVhTQ2CKKmb1wDjcDLz8/1U/
 rvqsfUsZHmzwDq8pMCNZm/v4YyMkO81rRaXe9acX8/kxt/QtXfXp/qBzqhgZpNLKLibi
 LNqfyNxukbSABmA4l5X1f2j1LeNJFv0HbYQts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694429097; x=1695033897;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XDlF5YI0/CppNpOQ1vN3K+1CKKPjKeo7ClgielEzmv4=;
 b=ILubqMxg95jTEy2ei0ClDJ74EmSbSGmxKfktBtrdzpIbdGCKfdLt7m44KDC7IQRgiU
 UpQlsZ5MWJ7xXC0B7FoD6rNIRotbUOtq3cxSmw8ZnRXVpOg60zAijUJgNpi7liQ/FRf7
 F9szEBB8GGRQuamf4NPnOTzuCL2BLMtTmdWZAflwplUPhgZh5mH1N/n9JtXJItUeQfaK
 TcPFoWdVURuRGU+ZxScNH8aO6p0LfajJTePOiRsJlYT7L00G0MoFPEHtW3pC5Hxa6qyH
 u1B4NNpwfp6gw7Rdc4Txo40pYGOwkwx1rrfU4gpOLrtKzADzEt76h/7jEBt90dfy7IJA
 MJjw==
X-Gm-Message-State: AOJu0Yz+y6KoAEL7/eZ+35leOxtjNOiGiYCDYSLBESDudpAYOdYaN9RK
 scUu7C/AHHxuTtf6dkny3/VDxg==
X-Google-Smtp-Source: AGHT+IHWYE67ztxyZbze1YyOlCmW0CfRt9nvzhkVd5pPN5yhcvvIeIk5TBpM4vAVfrlPfFPG6ua9eA==
X-Received: by 2002:a5d:684a:0:b0:314:124f:12be with SMTP id
 o10-20020a5d684a000000b00314124f12bemr7099055wrw.3.1694429097334; 
 Mon, 11 Sep 2023 03:44:57 -0700 (PDT)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 b11-20020a5d4d8b000000b0031416362e23sm9780636wru.3.2023.09.11.03.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 03:44:57 -0700 (PDT)
Date: Mon, 11 Sep 2023 11:44:56 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 idryomov@gmail.com, pl@kamp.de, sw@weilnetz.de,
 sstabellini@kernel.org, paul@xen.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, stefanha@redhat.com, fam@euphon.net,
 quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 kraxel@redhat.com, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH 6/7] block: Clean up local variable shadowing
Message-ID: <97895eb8-a44f-4af6-99b1-0075dc68281a@perard>
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-7-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831132546.3525721-7-armbru@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=anthony.perard@cloud.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Aug 31, 2023 at 03:25:45PM +0200, Markus Armbruster wrote:
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index 3906b9058b..a07cd7eb5d 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -369,7 +369,7 @@ static void xen_block_get_vdev(Object *obj, Visitor *v, const char *name,
>      case XEN_BLOCK_VDEV_TYPE_XVD:
>      case XEN_BLOCK_VDEV_TYPE_HD:
>      case XEN_BLOCK_VDEV_TYPE_SD: {
> -        char *name = disk_to_vbd_name(vdev->disk);
> +        char *vbd_name = disk_to_vbd_name(vdev->disk);
>  
>          str = g_strdup_printf("%s%s%lu",
>                                (vdev->type == XEN_BLOCK_VDEV_TYPE_XVD) ?
> @@ -377,8 +377,8 @@ static void xen_block_get_vdev(Object *obj, Visitor *v, const char *name,
>                                (vdev->type == XEN_BLOCK_VDEV_TYPE_HD) ?
>                                "hd" :
>                                "sd",
> -                              name, vdev->partition);
> -        g_free(name);
> +                              vbd_name, vdev->partition);
> +        g_free(vbd_name);
>          break;
>      }
>      default:

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

