Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C79CD7D3B8C
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:57:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxIx-0001XI-3m; Mon, 23 Oct 2023 11:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1quxIu-0001XA-Hk
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1quxIs-00075P-Rq
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698076638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J2ZIxCBUCZSvYebMBNxr9rU6hSdiUCX70dmsOkbWyEI=;
 b=SF/mkJJrRGK3BS/ZtVw4+ZzZFmsd2oaDEpdKJmq6lzGaAn8A31ZZRvvJBpflx3BVoABC9C
 gEPMUaeyknTs9e5Du/dIfKdidRVq/T7gNT7OY0cgpUeOd8qNBzJcxQNaXl9QzG1wasetcC
 q/Q+AhY8gCGRV5088MfaDPNCz+9YzEU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-lW9LnatcPUSB3D7ZiCTtUA-1; Mon, 23 Oct 2023 11:57:10 -0400
X-MC-Unique: lW9LnatcPUSB3D7ZiCTtUA-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3b40deadcb7so487868b6e.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 08:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698076630; x=1698681430;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J2ZIxCBUCZSvYebMBNxr9rU6hSdiUCX70dmsOkbWyEI=;
 b=bzI8FqMMNi7Rzsi18DQK9jFEwxkyxR+Phgc6BJ4CgKyBY4IB29USNX1UQhd7/a2M4q
 Wkw6jHHcet1rRSpGuw1aVD5cG0aLJxg1Q55IIJIInrNyUVK6FwXcyXk/fwl2g40T1zOg
 30mn+FCgMp6EnMe41RRfI5ONRPZ/Aj+aREIXDilvxsOzDimhxl99/CgEq58u0IWQZ1r6
 +UPjO61XWF3JuHbSf4JqLdIVupd77qvThT+u9C/xj0Fi3ZTmXFstg2e9c46cLSsDx/Wq
 F8riIwv2IL6rK8P9WVpnFbejIGNvvH95u/8a1JWMJ7CxCkUvSnKQ6zPFpfL3JExLHahF
 7g+g==
X-Gm-Message-State: AOJu0YwcBiQkaZeJ3vl+n6O5CafEO9v78uOG1wI6yRZmW6+kEeniIG6B
 ZbjCt76jYLj/3JMiFtXeU6zpmI8ZHwfhq/4i684ySi14FSDvFIAUd1emoe6pGjMW1LyNI/CapJl
 McPc6E6iNPSQ/um0=
X-Received: by 2002:a05:6808:14d6:b0:3b2:9c2f:50e0 with SMTP id
 f22-20020a05680814d600b003b29c2f50e0mr10539969oiw.5.1698076629913; 
 Mon, 23 Oct 2023 08:57:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbqdF/3gjlXWDahliSPIVjW4ZlJR9tuqPw/1NV0axL4UYPtmjH8DmndNDgL5qWojqra+APbQ==
X-Received: by 2002:a05:6808:14d6:b0:3b2:9c2f:50e0 with SMTP id
 f22-20020a05680814d600b003b29c2f50e0mr10539955oiw.5.1698076629646; 
 Mon, 23 Oct 2023 08:57:09 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 u12-20020a05621411ac00b0066d5220d860sm2971561qvv.18.2023.10.23.08.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 08:57:09 -0700 (PDT)
Date: Mon, 23 Oct 2023 11:57:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] migration/ram: Fix compilation with -Wshadow=local
Message-ID: <ZTaX00kf3UcQG/AF@x1n>
References: <20231023145044.104866-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023145044.104866-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 23, 2023 at 04:50:44PM +0200, Thomas Huth wrote:
> No need for a new variable here, especially not for one that shadows
> a variable from the beginning of the function scope. With this change
> the code now successfully compiles with -Wshadow=local.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  migration/ram.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 92769902bb..9de9e54fa9 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3238,8 +3238,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>  
>          ram_flush_compressed_data(rs);
>  
> -        int ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
> -        if (ret < 0) {
> +        if (rdma_registration_stop(f, RAM_CONTROL_FINISH) < 0) {

We may need to rename "ret" to something else?  qemu_file_set_error(),
right below, will reference the error returned.

>              qemu_file_set_error(f, ret);   <-----------------

Thanks,

>          }
>      }
> -- 
> 2.41.0
> 

-- 
Peter Xu


