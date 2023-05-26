Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C27FB712FB0
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 00:03:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2fVB-0008Ri-8r; Fri, 26 May 2023 18:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2fV5-0008RY-7g
 for qemu-devel@nongnu.org; Fri, 26 May 2023 18:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2fV3-0006By-IA
 for qemu-devel@nongnu.org; Fri, 26 May 2023 18:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685138488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bQSlDH9ntXOQlU7Ll8P1lPCHa234g7C4eC6AaJRMuMQ=;
 b=UZqQJLP4sYQz/tlh6emdAWuoLq5QfMOm7p9F2Q2NbMFd9vESL8dNJGMfS/ikRmeBpkEYPy
 TX3N9XtAKT6eN7daVvcVxp3YC6gQD3s/EZMY/GJ3PfqOlxKwZx3AWoDmAu2yI1s83hY5Z5
 0N+qtbSb4EA3pQ5onWQDsA42ZPYqXr0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-lxWt73w3OviBNgwC5_zGUw-1; Fri, 26 May 2023 18:01:26 -0400
X-MC-Unique: lxWt73w3OviBNgwC5_zGUw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-625891d5ad5so2833796d6.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 15:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685138486; x=1687730486;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQSlDH9ntXOQlU7Ll8P1lPCHa234g7C4eC6AaJRMuMQ=;
 b=VhGGEcMKmPxgPB0Zq+i4XjKanGjWiVcuvylKr2nclweEwM50oMLlnKrr9bMSs4eyZu
 p98b0yIeH2kAmkW7iKW5vjNsxepF/JJtdbJPAJI2sdhk41CmQBXZ+e99Xbdfu+4RVgiK
 H6df3/WdP4WIXr/xoEuGWboEQLWg9CoeE9f6f5+zshE4IyxFXdGbqi05zMHrhXzKD2+l
 qPU1SnkLS1dGYo8r7qqhP2Fc7VjCt5zLpTGYFCk41E3RYa36UGlP4pEVxSKcmvCXitF4
 mhJTkLR1QGW0xBEHGn/UNAcRbtQfADdgtOXwFgcw790h+QhIL1A4q9E9Yw8ae8JMMnIp
 Fwcg==
X-Gm-Message-State: AC+VfDyjS6OTjjOw0fjLyxrQhchVth9/kgfs5vvCi2JzFEGffQZAvzx9
 SgyioGoQodVF6fqRioNxacO//uiTEzDFuKDMbja9ni/i2P1UQyEZWl7k/afYmpYw1trI8oYvEIW
 sruPEJHfq/l4io5Y=
X-Received: by 2002:a05:6214:5199:b0:625:aa48:e50f with SMTP id
 kl25-20020a056214519900b00625aa48e50fmr3219376qvb.6.1685138486234; 
 Fri, 26 May 2023 15:01:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4m1rfQwyXutpbMniEeTEV8HwzGsqeW+l3b+UmaDRJUdPvYDCYW1EYUEoQIRdc7Q0el1tWYNQ==
X-Received: by 2002:a05:6214:5199:b0:625:aa48:e50f with SMTP id
 kl25-20020a056214519900b00625aa48e50fmr3219363qvb.6.1685138485976; 
 Fri, 26 May 2023 15:01:25 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 ez9-20020ad45909000000b0061f7cf8207asm1521270qvb.133.2023.05.26.15.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 15:01:25 -0700 (PDT)
Date: Fri, 26 May 2023 18:01:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, andrey.gruzdev@virtuozzo.com,
 quintela@redhat.com, leobras@redhat.com
Subject: Re: [PATCH] migration: stop tracking ram writes when cancelling
 background migration
Message-ID: <ZHEsNGAPTCGVaps+@x1n>
References: <20230526115908.196171-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230526115908.196171-1-f.ebner@proxmox.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, May 26, 2023 at 01:59:08PM +0200, Fiona Ebner wrote:
> Currently, it is only done when the iteration finishes successfully.
> Not cleaning up the userfaultfd write protection can lead to
> symptoms/issues such as the process hanging in memmove or GDB not
> being able to attach.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

> For the success case, the stuff in between the old call and new call
> site should not depend on tracking to already be stopped, right?

Yes I think so.  There's only device states to be flushed and no guest
memory should be touched.

Even if we'll touch them, since we've finished migrating all of them so
they're already unprotected anyway (actually, even during ram save it's
read-only here from bg thread), so not any problem I can see.

Thanks,

-- 
Peter Xu


