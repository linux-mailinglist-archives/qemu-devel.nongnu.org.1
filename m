Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EAA79240E
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 17:45:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdYFK-00060o-5R; Tue, 05 Sep 2023 11:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdYFB-0005sY-53
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:45:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdYF7-0006s4-GE
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693928725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+4xiA/1sT2uhp5PXNVgh02a4FWZih/ePEeX2DqW3AKY=;
 b=GtnW/JiUm43ONjjSAur68Czm6sVZGxOhyec7aHcwaum5UxtCRQoTuTQsRP6mLjQPUuopis
 x9uRYkR0dpFQKjop1ROHyea1YPCBNmy13SznX2SspVqET1RbeOi0nld6RobtO7V+FEld05
 Ohbhb5wuO1e+0WCaibZd3OzI8MWALmg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-H39AekHePdmPFUTBYVkyGg-1; Tue, 05 Sep 2023 11:45:18 -0400
X-MC-Unique: H39AekHePdmPFUTBYVkyGg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-411f4a7ddbdso9006911cf.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 08:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693928716; x=1694533516;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4xiA/1sT2uhp5PXNVgh02a4FWZih/ePEeX2DqW3AKY=;
 b=ZcBvGmQZuUM0W9R7PepDB5hVwCGmhD6k87smTSggg7Ug5ZlpAaNaGG34yBze041GoE
 DV7ViRKKEfL+KkBSijghVxkWwp7W/vsyBWBn7hju81N8V5OZpb/Si/1Gi2W2DSTtfZ+7
 aZnDSsC7LgH87kF2JfEpRiY9y1+gJGS9Bn5xhtN+/k5cf/rH1m5hItioXUHO5+JcDz31
 kpVgJeZ5ct4kmLD2U1QYwJFyQ9UWeDTBlY1NvaNxV9oKeF7fbLbAvPE0VlrFj+UUl0S4
 85ROjVIskvZ4MKb6XPGZ2RpWJuKdxOuo4vDeo8yEC5+EmPDhRt/9CEMdjBErJG/SatUC
 2Lcw==
X-Gm-Message-State: AOJu0YwUzI7Y8DiMqTLdnmY0LqT3bgL+OdOSvpUQcfxSH5hWXWyypDS1
 njfFsKclyg4nS51vWQ4HXlZ4UesGth6mJgnp3Ep0EWq9ZwX8YxLdS2uZVjQ4wMK6qoirId4aph0
 NdWx68qnnLiddKKM=
X-Received: by 2002:a05:6214:d08:b0:641:8d4a:1a83 with SMTP id
 8-20020a0562140d0800b006418d4a1a83mr14975201qvh.3.1693928716520; 
 Tue, 05 Sep 2023 08:45:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc0sdomABCCe61QVBgI2YZ0AefUDlOnD8FR1DquG13U+KmDesCDMTjpe33xlU6oDyp2i0k0g==
X-Received: by 2002:a05:6214:d08:b0:641:8d4a:1a83 with SMTP id
 8-20020a0562140d0800b006418d4a1a83mr14975186qvh.3.1693928716257; 
 Tue, 05 Sep 2023 08:45:16 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 g25-20020a0caad9000000b0064f778c8165sm4537686qvb.64.2023.09.05.08.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 08:45:16 -0700 (PDT)
Date: Tue, 5 Sep 2023 11:45:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] iothread: Set the GSource "name" field
Message-ID: <ZPdNCkLk4icmtxf0@x1n>
References: <20230904144811.4218-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230904144811.4218-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Mon, Sep 04, 2023 at 11:48:11AM -0300, Fabiano Rosas wrote:
> @@ -189,11 +193,14 @@ static void iothread_init(EventLoopBase *base, Error **errp)
>          return;
>      }
>  
> +    thread_name = g_strdup_printf("IO %s",
> +                        object_get_canonical_path_component(OBJECT(base)));
> +
>      /*
>       * Init one GMainContext for the iothread unconditionally, even if
>       * it's not used
>       */
> -    iothread_init_gcontext(iothread);
> +    iothread_init_gcontext(iothread, thread_name);
>  
>      iothread_set_aio_context_params(base, &local_error);
>      if (local_error) {

I think thread_name might be leaked if error here.  Thanks,

-- 
Peter Xu


