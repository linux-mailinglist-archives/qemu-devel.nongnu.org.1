Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EA17BCC8F
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:21:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNAN-0007Hd-4R; Sun, 08 Oct 2023 02:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpNAL-0007HH-4K
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpNAI-0006sY-MI
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696746081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6sIVJuObwJwztZISAUMT5FXXXqfMAbiWeyXa9z1lMWY=;
 b=fMgpH7XJwQ3ede/nuAgLcsEuoXcYq5z8jxQRxCvhmSuSgAutQ+6Rbtq8QVSTb6N7EzjUWl
 ETP/rR4VcFZutRcKBLbnUArmQLn4logne5f+Eo1oGvSH2y8QVZ2cP8JPLnhwyQUEw2MhDl
 0ZqV7lx1/ZBU1qJqNLbUj2YVvM4KBRc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-L1jmg706P024QfQT53qcKg-1; Sun, 08 Oct 2023 02:21:19 -0400
X-MC-Unique: L1jmg706P024QfQT53qcKg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9adc78b386cso280630466b.0
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 23:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696746078; x=1697350878;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6sIVJuObwJwztZISAUMT5FXXXqfMAbiWeyXa9z1lMWY=;
 b=Ci2ZhkaOE1yV7Dw0VZ4NBdSObe5quS7qtRe3UgBIwVzgQofyhNhB6KENkP126VHAQN
 W51HPvq3YdGQhgsHau2fK/0dGsJOQx5vOClBpr7fhVpckhCptN8DKlioI1GDZNzC87Zi
 WtDJrX56+zP6Cr4szxgkWTuxb6ZZ4l3Hcv54nWehASCV74SgE3ZjNtaIMlrTfyT+37JS
 1Eyetg9DiEd1L44KAEgdatI9f2oyKiY0N8W7VhWQrke3zF0D6kennERIRSr5mKDVOaOq
 QCynvUa3RbLhG6Y/Au00XdLYsjbtWRdrYwquGMLHqs7So+HwnS0QCJdR+Fx75C3bTRUl
 PmeQ==
X-Gm-Message-State: AOJu0Yw0nQUl9tIP+DlphAVHiRp/yDhCYX016PtMKdQtnkNbi4hPqzrk
 kkgizDRGJXKJXhIrWaPjz/NZ42eY4utpmfd7UTWC4sfLFwymp4AXOb5EH95jC1DiDTOmKA1oCoR
 xVNkCAiq3/FuDDTE=
X-Received: by 2002:a17:906:9c1:b0:9b2:89ec:d701 with SMTP id
 r1-20020a17090609c100b009b289ecd701mr11701199eje.27.1696746078598; 
 Sat, 07 Oct 2023 23:21:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3aZ/ookFhPqBrCTk+Y3lAJQ5r0AhJyhXrb/n1dygiKVuOpkNlS576VVwBMnbF70HU3/94zA==
X-Received: by 2002:a17:906:9c1:b0:9b2:89ec:d701 with SMTP id
 r1-20020a17090609c100b009b289ecd701mr11701194eje.27.1696746078402; 
 Sat, 07 Oct 2023 23:21:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:d74e:e6b1:da81:860a:5e9e])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a1709067c4700b0099bd1a78ef5sm5137351ejp.74.2023.10.07.23.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 23:21:17 -0700 (PDT)
Date: Sun, 8 Oct 2023 02:21:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] libvhost-user: Fix compiler warning with -Wshadow=local
Message-ID: <20231008022107-mutt-send-email-mst@kernel.org>
References: <20231006121129.487251-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006121129.487251-1-thuth@redhat.com>
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

On Fri, Oct 06, 2023 at 02:11:29PM +0200, Thomas Huth wrote:
> Rename shadowing variables to make this code compilable
> with -Wshadow=local.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  subprojects/libvhost-user/libvhost-user.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
> index 051a611da3..ea2822a44c 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -870,10 +870,10 @@ vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
>      for (i = 0; i < dev->nregions; i++) {
>          if (reg_equal(&dev->regions[i], msg_region)) {
>              VuDevRegion *r = &dev->regions[i];
> -            void *m = (void *) (uintptr_t) r->mmap_addr;
> +            void *ma = (void *) (uintptr_t) r->mmap_addr;
>  
> -            if (m) {
> -                munmap(m, r->size + r->mmap_offset);
> +            if (ma) {
> +                munmap(ma, r->size + r->mmap_offset);
>              }
>  
>              /*
> @@ -1005,10 +1005,10 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
>  
>      for (i = 0; i < dev->nregions; i++) {
>          VuDevRegion *r = &dev->regions[i];
> -        void *m = (void *) (uintptr_t) r->mmap_addr;
> +        void *ma = (void *) (uintptr_t) r->mmap_addr;
>  
> -        if (m) {
> -            munmap(m, r->size + r->mmap_offset);
> +        if (ma) {
> +            munmap(ma, r->size + r->mmap_offset);
>          }
>      }
>      dev->nregions = memory->nregions;
> -- 
> 2.41.0


