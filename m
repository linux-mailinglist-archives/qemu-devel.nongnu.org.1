Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3128D70D717
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 10:18:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1NCg-0001iW-5D; Tue, 23 May 2023 04:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q1NCV-0001eV-9Q
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:17:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q1NCS-0004vq-PF
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684829815;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fdp/g9lnifdsUO8tjPCaEoS9vU5bVWWZWFmjxNMAAo0=;
 b=H9PayWid6XOmHRf360FQiN/SafW5CjQTg5496p05AIHmd+SvChpobTYWS9PqGM2aVKAV8x
 GeRc0CO1LwyBzUXgrptzyZRa9hJEB/hTAymS26IMlYrywJvJydu3Zhb3K7nDCCAOM+rOLM
 /Gvp3EHpapSWCct7YZptsi5Pwd8+1ZM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-QtahyG2tObOwGPPBwpV-4w-1; Tue, 23 May 2023 04:16:51 -0400
X-MC-Unique: QtahyG2tObOwGPPBwpV-4w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FAF885A5B5;
 Tue, 23 May 2023 08:16:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EBF0C1ED99;
 Tue, 23 May 2023 08:16:50 +0000 (UTC)
Date: Tue, 23 May 2023 09:16:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mauro Matteo Cascella <mcascell@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com,
 jacek.halon@gmail.com
Subject: Re: [PATCH] ui/cursor: incomplete check for integer overflow in
 cursor_alloc
Message-ID: <ZGx2bzKuwO6e4E2L@redhat.com>
References: <20230508141813.1086562-1-mcascell@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230508141813.1086562-1-mcascell@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, May 08, 2023 at 04:18:13PM +0200, Mauro Matteo Cascella wrote:
> The cursor_alloc function still accepts a signed integer for both the cursor
> width and height. A specially crafted negative width/height could make datasize
> wrap around and cause the next allocation to be 0, potentially leading to a
> heap buffer overflow. Modify QEMUCursor struct and cursor_alloc prototype to
> accept unsigned ints.
> 
I concur with Marc-Andre that there is no code path that can
actually trigger an overflow:


  hw/display/ati.c:        s->cursor = cursor_alloc(64, 64);
  hw/display/vhost-user-gpu.c:            s->current_cursor = cursor_alloc(64, 64);
  hw/display/virtio-gpu.c:            s->current_cursor = cursor_alloc(64, 64);

Not exploitable as fixed size

  hw/display/qxl-render.c:    c = cursor_alloc(cursor->header.width, cursor->header.height);

Cursor header defined as:

  typedef struct SPICE_ATTR_PACKED QXLCursorHeader {
      uint64_t unique;
      uint16_t type;
      uint16_t width;
      uint16_t height;
      uint16_t hot_spot_x;
      uint16_t hot_spot_y;
  } QXLCursorHeader;

So no negative values can be passed to cursor_alloc()


  hw/display/vmware_vga.c:    qc = cursor_alloc(c->width, c->height);

Where 'c' is defined as:

  struct vmsvga_cursor_definition_s {
      uint32_t width;
      uint32_t height;
      int id;
      uint32_t bpp;
      int hot_x;
      int hot_y;
      uint32_t mask[1024];
      uint32_t image[4096];
  };

and is also already bounds checked:

            if (cursor.width > 256
                || cursor.height > 256
                || cursor.bpp > 32
                || SVGA_BITMAP_SIZE(x, y) > ARRAY_SIZE(cursor.mask)
                || SVGA_PIXMAP_SIZE(x, y, cursor.bpp)
                    > ARRAY_SIZE(cursor.image)) {
                    goto badcmd;
            }

> Fixes: CVE-2023-1601
> Fixes: fa892e9a ("ui/cursor: fix integer overflow in cursor_alloc (CVE-2021-4206)")

Given there is no possible codepath that can overflow, CVE-2023-1601
looks invalid to me. It should be clsoed as not-a-bug and these two
Fixes lines removed.

> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> Reported-by: Jacek Halon <jacek.halon@gmail.com>
> ---
>  include/ui/console.h | 4 ++--
>  ui/cursor.c          | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Even though it isn't fixing a bug, the change itself still makes
sense, because there's no reason a negative width/height is ever
appropriate. This protects us against accidentally introducing
future bugs, so with the two CVE Fixes lines removed:

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 2a8fab091f..92a4d90a1b 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -144,13 +144,13 @@ typedef struct QemuUIInfo {
>  
>  /* cursor data format is 32bit RGBA */
>  typedef struct QEMUCursor {
> -    int                 width, height;
> +    uint32_t            width, height;
>      int                 hot_x, hot_y;
>      int                 refcount;
>      uint32_t            data[];
>  } QEMUCursor;
>  
> -QEMUCursor *cursor_alloc(int width, int height);
> +QEMUCursor *cursor_alloc(uint32_t width, uint32_t height);
>  QEMUCursor *cursor_ref(QEMUCursor *c);
>  void cursor_unref(QEMUCursor *c);
>  QEMUCursor *cursor_builtin_hidden(void);
> diff --git a/ui/cursor.c b/ui/cursor.c
> index 6fe67990e2..b5fcb64839 100644
> --- a/ui/cursor.c
> +++ b/ui/cursor.c
> @@ -90,7 +90,7 @@ QEMUCursor *cursor_builtin_left_ptr(void)
>      return cursor_parse_xpm(cursor_left_ptr_xpm);
>  }
>  
> -QEMUCursor *cursor_alloc(int width, int height)
> +QEMUCursor *cursor_alloc(uint32_t width, uint32_t height)
>  {
>      QEMUCursor *c;
>      size_t datasize = width * height * sizeof(uint32_t);
> -- 
> 2.40.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


