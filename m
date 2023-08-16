Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1F777EBBF
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 23:27:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWO1f-0000ni-Va; Wed, 16 Aug 2023 17:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qWO1d-0000m1-RO
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qWO1b-0003hg-ER
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692221154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E2Z/Hodg3h5Pi7FKRtH/+LYkG6SbyVWTh8jVE6o0iuw=;
 b=hsckBU4CFsAEwUCqMVXfM3RQnTXdGQbK9bqlZfLuLki2oCIZr5qWRb9lgY6o/eUg72GWt/
 YaoiU6NpUOpq3zoOwhjWgAkkGX2ypFYX8Nycx6y7p3OjfW0rzbIVyO8l6K9rKukfOivhdk
 kCOOyNUIubTD8yyfscyflZaqki9gAmA=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-cPN8zjqoMsyteOCN31saCg-1; Wed, 16 Aug 2023 17:25:52 -0400
X-MC-Unique: cPN8zjqoMsyteOCN31saCg-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-791f1892efeso17801839f.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 14:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692221152; x=1692825952;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E2Z/Hodg3h5Pi7FKRtH/+LYkG6SbyVWTh8jVE6o0iuw=;
 b=FXlFgSTF6s7b3+cSj57Eld7hUH64p8gW0V2konmi4Zq5ZW9iTkpy0cf4OA8YZLhnD9
 VLbTFQ7CQZvF9AxkE/mwbO6v4skUEQz9tBsBmqzW21yE+qGF9yQM+b1N0mp82BA3RR/D
 BbVJZILA+5WyDvV17HEBUgtpJMEycZpPZfq7eMishI3O8turnVUNoDZwo7r8FPB6a3tD
 VTqBrKtso+ZRWcAGmIamgqCWCaSYL3ddSgyTpscePqnlnTnbstoDPKNvCCWZRY2FhHlg
 M9h7bxORKvjb5QuY81V3TQ4+uW3v40kZ6T1NtTZcaW7yYwA97sWQj8/sFJi3wU0glsVW
 IkOw==
X-Gm-Message-State: AOJu0YwDTyk3zDoERlraGOqaME0s+YCIu7gGTPoEqmmYMjkxjOrqH4hc
 msn+NBhV0ZehsI6ndqh1tacGLcuCZ6Z92AJPnwYJIWXGIVNtBB/Z4B2jAaJLjCnahYFKordKSog
 NJVHus4T3dejuYiQ=
X-Received: by 2002:a05:6e02:dca:b0:346:1185:31d0 with SMTP id
 l10-20020a056e020dca00b00346118531d0mr3472530ilj.9.1692221152150; 
 Wed, 16 Aug 2023 14:25:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6ONAAxFERM7GZ0ZJN55BpoKTLYXmSJz1i4XrBFppS3UEaZUtZk09jemN0IkaTiXkJ8C2oLg==
X-Received: by 2002:a05:6e02:dca:b0:346:1185:31d0 with SMTP id
 l10-20020a056e020dca00b00346118531d0mr3472516ilj.9.1692221151876; 
 Wed, 16 Aug 2023 14:25:51 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 l7-20020a92d947000000b00345e3a04f2dsm4900166ilq.62.2023.08.16.14.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 14:25:51 -0700 (PDT)
Date: Wed, 16 Aug 2023 15:25:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Alex =?UTF-8?B?QmVubsOpZQ==?=
 <alex.bennee@linaro.org>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 richard.henderson@linaro.org, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Wainer dos Santos Moschetta
 <wainersm@redhat.com>, Thomas Huth <thuth@redhat.com>, Eric Blake
 <eblake@redhat.com>, Dongwon Kim <dongwon.kim@intel.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>
Subject: Re: [8.1 regression] Re: [PULL 05/19] virtio-gpu-udmabuf: correct
 naming of QemuDmaBuf size properties
Message-ID: <20230816152549.09cfcece.alex.williamson@redhat.com>
In-Reply-To: <20230816150810.15d90b34.alex.williamson@redhat.com>
References: <20230717124545.177236-1-marcandre.lureau@redhat.com>
 <20230717124545.177236-6-marcandre.lureau@redhat.com>
 <20230816150810.15d90b34.alex.williamson@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
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

On Wed, 16 Aug 2023 15:08:10 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:
> > diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> > index 8f9fbf583e..3d19dbe382 100644
> > --- a/ui/egl-helpers.c
> > +++ b/ui/egl-helpers.c
> > @@ -314,9 +314,9 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
> >      }
> >  
> >      attrs[i++] = EGL_WIDTH;
> > -    attrs[i++] = dmabuf->width;
> > +    attrs[i++] = dmabuf->backing_width;
> >      attrs[i++] = EGL_HEIGHT;
> > -    attrs[i++] = dmabuf->height;
> > +    attrs[i++] = dmabuf->backing_height;
> >      attrs[i++] = EGL_LINUX_DRM_FOURCC_EXT;
> >      attrs[i++] = dmabuf->fourcc;
> >  
> > diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> > index 42db1bb6cf..eee821d73a 100644
> > --- a/ui/gtk-egl.c
> > +++ b/ui/gtk-egl.c
> > @@ -262,9 +262,10 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
> >      }
> >  
> >      gd_egl_scanout_texture(dcl, dmabuf->texture,
> > -                           dmabuf->y0_top, dmabuf->width, dmabuf->height,
> > -                           dmabuf->x, dmabuf->y, dmabuf->scanout_width,
> > -                           dmabuf->scanout_height, NULL);
> > +                           dmabuf->y0_top,
> > +                           dmabuf->backing_width, dmabuf->backing_height,
> > +                           dmabuf->x, dmabuf->y, dmabuf->width,
> > +                           dmabuf->height, NULL);
> >  
> >      if (dmabuf->allow_fences) {
> >          vc->gfx.guest_fb.dmabuf = dmabuf;
> > @@ -284,7 +285,8 @@ void gd_egl_cursor_dmabuf(DisplayChangeListener *dcl,
> >          if (!dmabuf->texture) {
> >              return;
> >          }
> > -        egl_fb_setup_for_tex(&vc->gfx.cursor_fb, dmabuf->width, dmabuf->height,
> > +        egl_fb_setup_for_tex(&vc->gfx.cursor_fb,
> > +                             dmabuf->backing_width, dmabuf->backing_height,
> >                               dmabuf->texture, false);
> >      } else {
> >          egl_fb_destroy(&vc->gfx.cursor_fb);
> > diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> > index a9a7fdf50c..4513d3d059 100644
> > --- a/ui/gtk-gl-area.c
> > +++ b/ui/gtk-gl-area.c
> > @@ -301,9 +301,10 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
> >      }
> >  
> >      gd_gl_area_scanout_texture(dcl, dmabuf->texture,
> > -                               dmabuf->y0_top, dmabuf->width, dmabuf->height,
> > -                               dmabuf->x, dmabuf->y, dmabuf->scanout_width,
> > -                               dmabuf->scanout_height, NULL);
> > +                               dmabuf->y0_top,
> > +                               dmabuf->backing_width, dmabuf->backing_height,
> > +                               dmabuf->x, dmabuf->y, dmabuf->width,
> > +                               dmabuf->height, NULL);
> >  
> >      if (dmabuf->allow_fences) {
> >          vc->gfx.guest_fb.dmabuf = dmabuf;  
> 

I suspect the issues is in these last few chunks where width and height
are replaced with backing_width and backing height, but
hw/vfio/display.c never sets backing_*.  It appears that the following
resolves the issue:

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index bec864f482f4..837d9e6a309e 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -243,6 +243,8 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
     dmabuf->dmabuf_id  = plane.dmabuf_id;
     dmabuf->buf.width  = plane.width;
     dmabuf->buf.height = plane.height;
+    dmabuf->buf.backing_width = plane.width;
+    dmabuf->buf.backing_height = plane.height;
     dmabuf->buf.stride = plane.stride;
     dmabuf->buf.fourcc = plane.drm_format;
     dmabuf->buf.modifier = plane.drm_format_mod;

I'll post that formally, but I really have no idea how dmabuf display
works, so confirmation would be appreciated.  Thanks,

Alex


