Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCB377D5BE
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 00:03:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW28B-0008Oa-1t; Tue, 15 Aug 2023 18:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW289-0008OC-9D
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW287-0003tl-2n
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692136990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yny8pgs0N/fLAF2XX9SbMMhyCGmKaVQl+5KFhcRr1Xc=;
 b=gCI/3l1AvpogSpttZttwib6NdepJ/RUT3vYS7ABiOx22ZV38TUVk4ss53rSpMqru26c4pk
 Iz95j97S33UfTV485T8CLB/HbpRWFFHGpFOWmvUxHmTsJ+CZ/a54IedmukDd409Kw1/0i4
 KhWIQH2QkRG7foFTi3Ml4ijtM3a7mF8=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-i4KOuoG0PA6KhYfl8C-6gw-1; Tue, 15 Aug 2023 18:03:08 -0400
X-MC-Unique: i4KOuoG0PA6KhYfl8C-6gw-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3a790d46973so895684b6e.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 15:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692136987; x=1692741787;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yny8pgs0N/fLAF2XX9SbMMhyCGmKaVQl+5KFhcRr1Xc=;
 b=bUZhYztMvAkmltjNglydOIHDqHWCLokVYDVCqrr5Efs++mXdD2PPy7/RLI9g8KUVSZ
 teS0pppPn6rwH3LxZVqGtspAPxjg5OiXFIrChuhdwur407BBdp9MoW9vhWwn/6g33gSY
 FukkMEHjX90ekDm3tLdIxsrhK4wZp/ONQcdPgZtT2GD+v11tdKzuB0dOpFgoWZiuuPcz
 TmgeS1kPwVYZHLxDl7aFsdXOgbFUcTHZzKZWRU6xJfbrwjxhEL3kYiDtpHAIJwzZPivV
 YZmxrsqNUfATzsi8jJNXqOrNDtiRMFZNF/ypMk4mQJURGEqAw8LjErdG5ZSvJXLsa7ND
 4fWQ==
X-Gm-Message-State: AOJu0Ywo3ZzCshhphO6l95jlbeL61/10qQuWrta0kaLkrxOZ+443VjgU
 IwT43mjM1+lSUxfz65lFWTD5rnUT4RAn4VEjFrgwWP8fa2qIclf/FMs5NEAzNpekBq06DzWR/Ag
 TWpaUMXfVJSb8m2I=
X-Received: by 2002:a05:6358:9db3:b0:133:8e:4513 with SMTP id
 d51-20020a0563589db300b00133008e4513mr253903rwo.0.1692136987288; 
 Tue, 15 Aug 2023 15:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJHpN6v44Z7WZL6OyEzX5ehqWvhrgo1MeTWmXgM6BobFdp/jbGl+xNr2ZRtbVr5JaeND6ikw==
X-Received: by 2002:a05:6358:9db3:b0:133:8e:4513 with SMTP id
 d51-20020a0563589db300b00133008e4513mr253890rwo.0.1692136986948; 
 Tue, 15 Aug 2023 15:03:06 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 z1-20020ac875c1000000b00401e04c66fesm4074464qtq.37.2023.08.15.15.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 15:03:06 -0700 (PDT)
Date: Tue, 15 Aug 2023 18:02:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 08/10] migration: Move return path cleanup to main
 migration thread
Message-ID: <ZNv2E1jMvnPBoaA3@x1n>
References: <20230811150836.2895-1-farosas@suse.de>
 <20230811150836.2895-9-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811150836.2895-9-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
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

On Fri, Aug 11, 2023 at 12:08:34PM -0300, Fabiano Rosas wrote:
> Now that the return path thread is allowed to finish during a paused
> migration, we can move the cleanup of the QEMUFiles to the main
> migration thread.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


