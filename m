Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54041709B5C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:31:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q024K-0003UB-A2; Fri, 19 May 2023 11:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q0243-0003Pl-25
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q023y-00079J-Tb
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684510234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83G9w/O6eXlHjFUbEZTurxe73nDnj7iCk7PhhPF6UXQ=;
 b=aDYxkPbmX9Bk67z+FGxUmqR2N8qrVg63fcsMUDSHwwYe62xc4/lOC/3JLVi8HVlVUR22HS
 mvCS0+P0CqU+p/gCZTABhCjXeYz+3HYd6fSFBIITWjgEvpfFt8yVrv7Qqff6ozMBQm/e7P
 jdLztBjFwHQSRsPgRHN8BAwqDGuNX8E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-SYV7svltPci4NReBVCknUg-1; Fri, 19 May 2023 11:30:33 -0400
X-MC-Unique: SYV7svltPci4NReBVCknUg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-61b6f717b6eso6492136d6.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684510233; x=1687102233;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=83G9w/O6eXlHjFUbEZTurxe73nDnj7iCk7PhhPF6UXQ=;
 b=iHDA7Qi/Ow4mFfeiw2kvZ2VOrD7t9kZ55x9EYFatu/aAJEEGjX6TVveYkmd9s3vFJM
 mfjzP0KfY34G2v0icngY/0WodVKn7MrVkK6JCWnDx+9G7uNV03qI7t1nfVAcNijmC3rL
 QORKuxeBiLuKF2tZhhE0xpsWcF1OdZ24ex9OjuQCGhLjpX3njbIBA+TxIceNphbKheak
 x98JQ9KTMQyrs8opdUcYNTExnhxLLpQk8zATyDBgRE0/1bmA8rEymS90a1xcocUTwJXk
 5RPNiCW06OCNdPCpdvCBsoSIw7RN2XTPPEzbv/Ocl3VLB3Zbh4yoCxA162/g3UGpqVal
 vQkA==
X-Gm-Message-State: AC+VfDywvD36l+L7g51S90/5sVkEYdZdFHfnDH5m1I6QqXS3qTVY0X0E
 1atifl2/7GiD8NwQHyhZ6cMbyftS5x5etizctzLpANEHLwgoCbWfDvKSTm4YJKNCN8qHyl4IBkS
 XX/aiDiNvGBmLAH0=
X-Received: by 2002:a05:6214:4118:b0:622:265e:3473 with SMTP id
 kc24-20020a056214411800b00622265e3473mr4716450qvb.1.1684510232824; 
 Fri, 19 May 2023 08:30:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7J6SINnQ/G882LVQJNxCfxzY2K55h2G+gyDZyufeurzIgamYlm5JYcR/3WcnkBcxODJrh7uQ==
X-Received: by 2002:a05:6214:4118:b0:622:265e:3473 with SMTP id
 kc24-20020a056214411800b00622265e3473mr4716417qvb.1.1684510232594; 
 Fri, 19 May 2023 08:30:32 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 lf9-20020a0562142cc900b0062381fa97c5sm1379690qvb.92.2023.05.19.08.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 08:30:32 -0700 (PDT)
Date: Fri, 19 May 2023 11:30:31 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "quintela@redhat.com" <quintela@redhat.com>,
 "Wang, Lei4" <lei4.wang@intel.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1] migration: fail the cap check if it requires the use
 of deferred incoming
Message-ID: <ZGeWF4lzBldLLH/y@x1n>
References: <20230518160026.57414-1-wei.w.wang@intel.com>
 <ZGZ6Yqx2+dOp+Q73@x1n>
 <DS0PR11MB637350354B0285ABF3FA1BD9DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS0PR11MB637350354B0285ABF3FA1BD9DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Fri, May 19, 2023 at 02:34:57AM +0000, Wang, Wei W wrote:
> On Friday, May 19, 2023 3:20 AM, Peter Xu wrote:
> > On Fri, May 19, 2023 at 12:00:26AM +0800, Wei Wang wrote:
> > > qemu_start_incoming_migration needs to check the number of multifd
> > > channels or postcopy ram channels to configure the backlog parameter (i.e.
> > > the maximum length to which the queue of pending connections for
> > > sockfd may grow) of listen(). So multifd and postcopy-preempt caps
> > > require the use of deferred incoming, that is, calling
> > > qemu_start_incoming_migration should be deferred via qmp or hmp
> > > commands after the cap of multifd and postcopy-preempt are configured.
> > >
> > > Check if deferred incoming is used when enabling multifd or
> > > postcopy-preempt, and fail the check with error messages if not.
> > >
> > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > 
> > IIUC this will unfortunately break things like:
> > 
> >   -global migration.x-postcopy-preempt=on
> > 
> > where the cap is actually applied before incoming starts even with !defer so
> > it should still work.
> 
> Actually the patch doesn’t check "!defer". It just checks if incoming has been started
> or not. It allows the 2 caps to be set only before incoming starts. So I think the above
> should work.

Ah yes indeed it keeps working, because we apply -global bits before setup
sockets. Then it's fine by me since that's the only thing I would still
like to keep it working. :)

If so, can we reword the error message a bit?  Obviously as you said we're
not really checking against -defer, but established channels.  The problem
is if something is established without knowing multifd being there it may
not work for multifd or preempt, not strictly about defer.

How about:

  "Multifd/Preempt-Mode cannot be modified if incoming channel has setup"

?

-- 
Peter Xu


