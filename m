Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A81D37C6ED5
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 15:11:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqvS6-0008Al-Jj; Thu, 12 Oct 2023 09:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qqvR7-00075d-6P
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qqvR3-0005UJ-0W
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697116143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AKQrBvpQ5BhFXlkG9LviKUxg1DPybCa3FYN6q1JQiyY=;
 b=Z8/137lYP0w5RARL0H/hVcZTxKhrXY2mX1ZNnVyN8NTz8pbLg6p+e5XfRJL/xwN1aSJzzB
 puWsxI5ULS7au1Cl6CMsvQE31ULVwSppteHjtWbaNWBHINuE5wf0O3DyUaLCrDYcD0UwZG
 C3pYYiloy6wgLoIoB8N4DapLhpY14+I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-CJxMpa2wNLmtmgcyyYC6CQ-1; Thu, 12 Oct 2023 09:09:02 -0400
X-MC-Unique: CJxMpa2wNLmtmgcyyYC6CQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30932d15a30so574544f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 06:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697116141; x=1697720941;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKQrBvpQ5BhFXlkG9LviKUxg1DPybCa3FYN6q1JQiyY=;
 b=hoCop9l7bGK8ap3UD9ad3w4Oo46Oby+dOdnuo+6ffenLSX53tiraPmN9Brjw2dF2cz
 V39Fe9sIM0hCvhZffzewEYgPDJwHRR0X0vg8BvPh7cfxBk0CYEosTpIFUR4hMcDuSJSs
 p/cwd4BgzeMtUc9tn3SQCurpFbEb3frQGwp7du/asrpeNsfNSKV0eKKsj5Zkl9CVSE+H
 35wWu8P3vXIC+fkAfkweOhHM1Pl48fdiEoZi+fJ49ot3VLJ11bQmx5gomCrkEtB4J7C5
 /lVWaMPscbwkd4C6tgfmlaiWmpORsmcsjoTFKyge3qc5W/Dka1iv7+QAMKNSG1P7rgiT
 4gEg==
X-Gm-Message-State: AOJu0Yx9Yglc0M4CcgjYQXWvd6cXqQNZZlIxhVG1HVG7X0VcVsIpUbMi
 tj7gI+mgyO/kYg4uX4J4VEOgmOUAGbNA8UaE3qWIvoDPSa21M+8xxyywCaYReZj+Pi7i7WgnP34
 h8YQDI+965a5iMV8=
X-Received: by 2002:a05:6000:104a:b0:32d:8b1a:31ad with SMTP id
 c10-20020a056000104a00b0032d8b1a31admr2639656wrx.24.1697116141213; 
 Thu, 12 Oct 2023 06:09:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXUejxggEt9FsQgHZ4tUJTywWBv2HwEDQJAI9z1bNCsbV/B326cmkH7NItZEQQmdjQhYLsMQ==
X-Received: by 2002:a05:6000:104a:b0:32d:8b1a:31ad with SMTP id
 c10-20020a056000104a00b0032d8b1a31admr2639574wrx.24.1697116139820; 
 Thu, 12 Oct 2023 06:08:59 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 bv28-20020a0560001f1c00b0032d402f816csm7174551wrb.98.2023.10.12.06.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 06:08:59 -0700 (PDT)
Date: Thu, 12 Oct 2023 09:08:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2] contrib/vhost-user-gpu: Fix compiler warning when
 compiling with -Wshadow
Message-ID: <20231012090829-mutt-send-email-mst@kernel.org>
References: <20231009083726.30301-1-thuth@redhat.com>
 <87h6mwyqxn.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6mwyqxn.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Thu, Oct 12, 2023 at 02:18:44PM +0200, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
> > Rename some variables to avoid compiler warnings when compiling
> > with -Wshadow=local.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  v2: Renamed the variable to something more unique
> >
> >  contrib/vhost-user-gpu/vugpu.h          | 8 ++++----
> >  contrib/vhost-user-gpu/vhost-user-gpu.c | 6 +++---
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugpu.h
> > index 509b679f03..654c392fbb 100644
> > --- a/contrib/vhost-user-gpu/vugpu.h
> > +++ b/contrib/vhost-user-gpu/vugpu.h
> > @@ -164,12 +164,12 @@ struct virtio_gpu_ctrl_command {
> >  };
> >  
> >  #define VUGPU_FILL_CMD(out) do {                                \
> > -        size_t s;                                               \
> > -        s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,  \
> > +        size_t vugpufillcmd_s_ =                                \
> > +            iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,  \
> >                         &out, sizeof(out));                      \
> > -        if (s != sizeof(out)) {                                 \
> > +        if (vugpufillcmd_s_ != sizeof(out)) {                   \
> >              g_critical("%s: command size incorrect %zu vs %zu", \
> > -                       __func__, s, sizeof(out));               \
> > +                       __func__, vugpufillcmd_s_, sizeof(out)); \
> >              return;                                             \
> >          }                                                       \
> >      } while (0)
> 
> v1 renamed to s_ instead, which I find much easier to read.  Michael
> asked you to change it so it's less likely to break if we pass it a
> macro that also uses s_.  Unlikely to happen, and would fail safe: build
> breaks.
> 
> > diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
> > index aa304475a0..bb41758e34 100644
> > --- a/contrib/vhost-user-gpu/vhost-user-gpu.c
> > +++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
> > @@ -834,7 +834,7 @@ vg_resource_flush(VuGpu *g,
> >                  .width = width,
> >                  .height = height,
> >              };
> > -            pixman_image_t *i =
> > +            pixman_image_t *img =
> >                  pixman_image_create_bits(pixman_image_get_format(res->image),
> >                                           msg->payload.update.width,
> >                                           msg->payload.update.height,
> > @@ -842,11 +842,11 @@ vg_resource_flush(VuGpu *g,
> >                                                        payload.update.data),
> >                                           width * bpp);
> >              pixman_image_composite(PIXMAN_OP_SRC,
> > -                                   res->image, NULL, i,
> > +                                   res->image, NULL, img,
> >                                     extents->x1, extents->y1,
> >                                     0, 0, 0, 0,
> >                                     width, height);
> > -            pixman_image_unref(i);
> > +            pixman_image_unref(img);
> >              vg_send_msg(g, msg, -1);
> >              g_free(msg);
> >          }
> 
> I'm going to queue v1.  Michael, if you want me to queue v2 instead, or
> neither of the two, let me know.

Yea I think v2 is better, queue that please.


