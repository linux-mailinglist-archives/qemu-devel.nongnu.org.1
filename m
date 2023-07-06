Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A3274A3A0
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 20:16:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHTV9-0002X5-3G; Thu, 06 Jul 2023 14:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHTV8-0002Wu-2A
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHTV6-0006kG-JK
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688667283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BEbQ/5CaEKqRSUHGjmXsX9UkZ0cJPEjhHo3ytO2cwFA=;
 b=eCgPC1YtfaaLd/lpaBEYW5UuCcWeYWRLFNX7IbG5sZ8n0gJWZWyvXm6I46ZsYEqAuchd4F
 X1NSRb2FmothwpHSN8QPjqQt1yh7P77KPzU4jVkt4ZEG3TE4AHuh5QnsO6SLqBcBNZJsPK
 z6CyJi2Be1PZ0cP5lq+GzdUYJjDFp3E=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-3Mir3ORDOK2kl18DfwciDw-1; Thu, 06 Jul 2023 14:14:40 -0400
X-MC-Unique: 3Mir3ORDOK2kl18DfwciDw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-40359e38529so2971381cf.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 11:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688667279; x=1691259279;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEbQ/5CaEKqRSUHGjmXsX9UkZ0cJPEjhHo3ytO2cwFA=;
 b=jBHfPFWXEI504UlDR1qM7ZN1t6/0LBG1dlMLzsXxX7B474XjPxQhXTT3jsl4nztXUo
 cVlR01u57kEkxNTdRYNZxMFoaW3ulJ++uOFBOk+BspuNKwdXkIwzusOJoQRW7xOS/y9W
 /lA5gPh4pO1OTfeKvi/x3bh7MPam+2d57HRA4gVHPlHMlC7NC9tLLRGDSV7aZtd4hd8W
 p7CVe78ZhT4Yg/2jB09kFLOz/gpQq2q3w2DduTwtVLDUBrtjyMQUxNBA7QA/1bsdh4P4
 vbLg/IY5jF6vw8x+QxrlNMC3M/MeDXWpK+hGCEOGLflvC+4340j1hv3F6RPvc6OEW2jz
 MxeQ==
X-Gm-Message-State: ABy/qLbcvnynWkBdtihbPB02TPpnUCsnRxFP5i+ZVaawft5C/KpvmRhm
 8XMu1TSpPsBZB/JW8MkKYUEIaEJoMPbUwlr279SHvaAV1Fm6/X1xppXUEbjmsOQgWpQefhHqrur
 DTvY/BXRGLqXUW18=
X-Received: by 2002:a05:622a:1a82:b0:400:84a9:a09c with SMTP id
 s2-20020a05622a1a8200b0040084a9a09cmr3448075qtc.6.1688667279666; 
 Thu, 06 Jul 2023 11:14:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHspwvsxYQPjTKZVZTCRIuMYspdchsbdmuCxG8bRSNM/UtSbcgsbyiSJW7AVxUK8YLm4g9T6w==
X-Received: by 2002:a05:622a:1a82:b0:400:84a9:a09c with SMTP id
 s2-20020a05622a1a8200b0040084a9a09cmr3448063qtc.6.1688667279451; 
 Thu, 06 Jul 2023 11:14:39 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 a25-20020ac84359000000b003fdebf1a634sm850315qtn.75.2023.07.06.11.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 11:14:39 -0700 (PDT)
Date: Thu, 6 Jul 2023 14:14:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Leonardo Bras Soares Passos <leobras@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] pcie: Add hotplug detect state register to cmask
Message-ID: <ZKcEjfTDDgDZWu9Q@x1n>
References: <20230706045546.593605-3-leobras@redhat.com> <ZKbRRt8ESGsMz+o7@x1n>
 <CAJ6HWG4iUX=+7FTCkXitFfc1zFNJ9aR5PzDRyPLSZVq1Kos8fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ6HWG4iUX=+7FTCkXitFfc1zFNJ9aR5PzDRyPLSZVq1Kos8fA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jul 06, 2023 at 03:07:40PM -0300, Leonardo Bras Soares Passos wrote:
> > I asked the same question, and I still keep confused: whether there's a
> > first bad commit?  Starting from when it fails?
> >
> > For example, is this broken on 6.0 binaries too with pc-q35-6.0?
> 
> I tested for qemu 6.0, and it still reproduces, but have not pursued
> this any further.

I see, thanks!

But then do you know why it's never hit before?  I assume it means this bug
has been there for a long time.

-- 
Peter Xu


