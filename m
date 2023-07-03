Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 528D1745B77
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 13:46:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGI0X-0001sF-1j; Mon, 03 Jul 2023 07:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1qGI0J-0001qk-Qz
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 07:46:04 -0400
Received: from esa2.hc2706-39.iphmx.com ([216.71.152.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1qGI0H-0006Kr-1X
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 07:46:03 -0400
X-IronPort-RemoteIP: 209.85.219.200
X-IronPort-MID: 288861607
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:kP/cbqspqfvBUblGsRyOny/TXOfnVOhcMUV32f8akzHdYApBsoF/q
 tZmKWvSP6rYNzGjLdhxOt7k9UxSscOEm9VjHQZl/CA8FykU9ZOVVN+UEBzMMnLJJKUvbq7GA
 +byyDXkBJppJpMJjk71atANlVEliefTAOK6ULWeUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8teTb8XuDgNyo4GlD5gNmPqgS1LPjvyJ94Kw3dPnZw0TQH9E88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IPM0SQqkEqSh8ai87XAMEhhXJ/0F1lqTzQJ
 OJl7vRcQS9xVkHFdX90vxNwSkmSNoUfkFPLzOTWXWV+ACQqflO1q8iCAn3aMqUR+qFXBUER2
 MA3Azc1QDSGurmS/pyCH7wEasQLdKEHPasas3BkiCDTVLMoG8ibBarN4tBc0XE7gcUm8fT2P
 ZJIL2oyKk6ZMlsVYg9/5JEWxY9EglH2dy1epEi9r7dx7mTOpOB0+OK9YIqLI4LSGq25mG7H/
 m/C1X77Cyg9McS98gqiwy2Al6jAyHaTtIU6UefQGuRRqESew3FWBBAIWF+Tp/6/hUijHdVFJ
 CQpFjEGqKEz8Am6RIC4UUfg+DiLuRkTX9cWGOo/gO2Q9pfpD8+iLjBsZlZ8hBYO7qfamRRCO
 oe1ou7U
IronPort-HdrOrdr: A9a23:XT9mXKH3nGQf03oupLqEJMeALOsnbusQ8zAXPo5KOHtom+ij5r
 2TdZMgpGPJYVcqKQsdcLW7UpVoLkmsl6KdjbNhWItKGTOWx1dAT7sSlrcKoQeQYhEWn9Q1vc
 wQEJSWSueAdWSS5fyb3ODSKadH/DDoytHNuc7ui11Ad0VFUZ1B0itOIjqnMyRNNXd77FkCeK
 Z0JPArm9NtQxoqhw2AaRg4Y9Q=
X-Talos-CUID: 9a23:NMh95G5C8Wa8U3NHeNss/U5TOsQFLVDh41zXG2GcDFsybIO7cArF
X-Talos-MUID: =?us-ascii?q?9a23=3AjgV4uQwRGzRdWoofs+pnzrxrsnKaqPv2BUQni5c?=
 =?us-ascii?q?Pgu6BLQ5LCxCs0ximBYByfw=3D=3D?=
Received: from mail-yb1-f200.google.com ([209.85.219.200])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Jul 2023 07:45:53 -0400
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-c22664c3df7so6465452276.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 04:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1688384753; x=1690976753;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fSRfBuyrsL7XJZ8uPrCMAqvK5I64SaYjAiR9dkud9aA=;
 b=M53A/ojZw+bAoeyLf4ng8BX53emgxmzhDCouYyfPkeEPp3qjNeToxl0PDU+6/YTcuR
 +jGPnLmEGpCW0fG5OtQH29zBp22grI0RZ8I21SZZGZga59lwuK/kADS+G6P777AXwmHD
 M7Pxt0Az0PMaKVhxkHWpzwrKqRymyia2WyZ3LBXXYiBNM0xESZaiPUiunpkT5YuGe44o
 haz6ww9i0lgvm6GsWenFikQu7tu8U9Dgio/ZzLkoXMl6sNHPNeI17CXVSFTQDo7po/Lh
 FyLR0Wkn0E0yUNc/66k1MOzBFQojniM5CN35dHKjI7QkOtClL6gx8aeHjO4ZiVWISvCh
 piDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688384753; x=1690976753;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fSRfBuyrsL7XJZ8uPrCMAqvK5I64SaYjAiR9dkud9aA=;
 b=OCvoK/aywlbybVCmlr73xN38Uxm2CFvmgUPpnQEzNCwne1zKe5C6YTEY/I9AXqplMb
 dYm7STTiKtbniS/ERr5I1iy8XvuR23S0Y/8t7nP9kHonq+9cjc3fS+/t2wimD1WkmeaE
 IlZrO1IFzeavM3HAVAiA4SXbrMhikcFnElrE5bzwN3iAS0jsiBZesVPJFEFbEPZfpWy0
 cYSwJ8goB3RlxX/4/3HrJl1pTk95l9stuEjAOeFPQxrxHOmaPszADETK/6ALoo/vFqfx
 jnPm/ueJds/8dAGeeeUP5kwEWkN7CgMAP+SklA2i8krbu/RYWtCZ2CjvzAjtHYWv2nTV
 e2PQ==
X-Gm-Message-State: ABy/qLYG/pC+OxCMhf1iUThTxT15byPxeQWPFjgxYjcg2VacPpDFZ0go
 POlShibjL2AChuzVwRRWblVXaC6q+CvDhB4/23tz/M1oTc2zNaSppHkTgi4NWGXNCL5Xwq2A9/a
 mMRt3oJIpT+zKkDWVLQHeCUL1PCM1mw==
X-Received: by 2002:a25:cf8b:0:b0:c3d:eff4:1c39 with SMTP id
 f133-20020a25cf8b000000b00c3deff41c39mr9974554ybg.12.1688384753185; 
 Mon, 03 Jul 2023 04:45:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEPOwGxFaFSMo9WK/shjJcffTRguOYT8p4iiOsa3ejlVjDa0jzh6DSh2iZETTJ5qzL0TLkwfA==
X-Received: by 2002:a25:cf8b:0:b0:c3d:eff4:1c39 with SMTP id
 f133-20020a25cf8b000000b00c3deff41c39mr9974542ybg.12.1688384752923; 
 Mon, 03 Jul 2023 04:45:52 -0700 (PDT)
Received: from mozz.bu.edu (mozz.bu.edu. [128.197.127.33])
 by smtp.gmail.com with ESMTPSA id
 z127-20020a254c85000000b00be5af499cfcsm4311983yba.61.2023.07.03.04.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 04:45:52 -0700 (PDT)
Date: Mon, 3 Jul 2023 07:45:48 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PULL 22/33] virtio-gpu/win32: allocate shareable 2d
 resources/images
Message-ID: <20230703114539.idxv2k3yblrixrg7@mozz.bu.edu>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
 <20230627130231.1614896-23-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230627130231.1614896-23-marcandre.lureau@redhat.com>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.152.49; envelope-from=alxndr@bu.edu;
 helo=esa2.hc2706-39.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 230627 1502, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Allocate pixman bits for scanouts with qemu_win32_map_alloc() so we can
> set a shareable handle on the associated display surface.
> 
> Note: when bits are provided to pixman_image_create_bits(), you must also give
> the rowstride (the argument is ignored when bits is NULL)
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Message-Id: <20230606115658.677673-11-marcandre.lureau@redhat.com>
> ---
>  include/hw/virtio/virtio-gpu.h |  3 +++
>  hw/display/virtio-gpu.c        | 46 +++++++++++++++++++++++++++++++---
>  2 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 2e28507efe..7a5f8056ea 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -48,6 +48,9 @@ struct virtio_gpu_simple_resource {
>      unsigned int iov_cnt;
>      uint32_t scanout_bitmask;
>      pixman_image_t *image;
> +#ifdef WIN32
> +    HANDLE handle;
> +#endif
>      uint64_t hostmem;
>  
>      uint64_t blob_size;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 1f8a5b16c6..347e17d490 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -258,6 +258,16 @@ static uint32_t calc_image_hostmem(pixman_format_code_t pformat,
>      return height * stride;
>  }
>  
> +#ifdef WIN32
> +static void
> +win32_pixman_image_destroy(pixman_image_t *image, void *data)
> +{
> +    HANDLE handle = data;
> +
> +    qemu_win32_map_free(pixman_image_get_data(image), handle, &error_warn);
> +}
> +#endif
> +
>  static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
>                                            struct virtio_gpu_ctrl_command *cmd)
>  {
> @@ -304,12 +314,27 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
>  
>      res->hostmem = calc_image_hostmem(pformat, c2d.width, c2d.height);
>      if (res->hostmem + g->hostmem < g->conf_max_hostmem) {
> +        void *bits = NULL;
> +#ifdef WIN32
> +        bits = qemu_win32_map_alloc(res->hostmem, &res->handle, &error_warn);
> +        if (!bits) {
> +            goto end;
> +        }
> +#endif
>          res->image = pixman_image_create_bits(pformat,
>                                                c2d.width,
>                                                c2d.height,
> -                                              NULL, 0);
> +                                              bits, res->hostmem / c2d.height);

Hello,
This may lead to FPE when c2d.height is 0.
https://gitlab.com/qemu-project/qemu/-/issues/1744
-Alex

