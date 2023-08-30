Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6317678D76B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 18:09:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNjO-0007OI-Tz; Wed, 30 Aug 2023 12:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbNjK-0007Nn-Um
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbNjH-0001sl-VD
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693411658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+pI1hU5A8XzJaRpv3BTYCDsU+K6RjoAx4T0NuNcN/RI=;
 b=CE9T9dlNfJOnbG7liSh9lrIA/HkkZ0qsMLIolkxrG9j/bpT2uTBcdU/+Ku8OCG91sveh27
 9HA9rVhR2h7VOerRa5/gAZSC9jMoya+XsGlrvXNLXg9g5b/29zJmhzTHgrsmraUvwj0WNl
 eXPCGlBOSFQijIBQNrZaIVd341fqSU8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-lbtUIc2iMCq74swNztdMWA-1; Wed, 30 Aug 2023 12:07:37 -0400
X-MC-Unique: lbtUIc2iMCq74swNztdMWA-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6bcaf70250fso2070352a34.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693411657; x=1694016457;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+pI1hU5A8XzJaRpv3BTYCDsU+K6RjoAx4T0NuNcN/RI=;
 b=XLGVxAhSrSKdaOV5LB9tb6p8gjDLY7qbwaQPbILIhEqji9RMy2IFi11c+45jgCini1
 5SBj0LJtXeFPwQWFziay1as0PYot+qCOPN2KAepVqk0+t3JoNvtaY5viGwyhqih/Bx6X
 tOrWJgdMWCYTTfNQkMmu2EKxbrujjBqnxt9vXf1PXBMBQhX47m+tiG47kB8R42yLVaq5
 P9JkJ0NPlHRHiHEeF0FIbeVyFP34h0uQ2HK473Ek0GH/OXTEr8w8fON3eu+2JFhSE+l5
 U+jWtvz6JHg/CTIiH20pQ0PVtqpuU6qjj9vB3gLyihLgFdDH4rJ/ON+OTGEAA95MI2+J
 yUOg==
X-Gm-Message-State: AOJu0YxL0qLICPhzamY+jD+JFG2bFhcustMLYMpT4VzT+GyC/XaaRd/+
 5E7pEOVKOYwPFJSxV3U+xi8lWUPy2LF3Ai+1Zp6d05KfMO7zdOegdzxIfXFORGTfL0fGiAbAa7K
 t52cpn9vIGogo2C8=
X-Received: by 2002:a05:6830:6886:b0:6b8:7653:dd66 with SMTP id
 cv6-20020a056830688600b006b87653dd66mr2516978otb.0.1693411656632; 
 Wed, 30 Aug 2023 09:07:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhX+4fE2mOPKcnHKNrCgg4Ptg53aQkx2G63U6c5FHoG5q2wbUFiUei/0X7PwgH71eEn/PMjg==
X-Received: by 2002:a05:6830:6886:b0:6b8:7653:dd66 with SMTP id
 cv6-20020a056830688600b006b87653dd66mr2516952otb.0.1693411656228; 
 Wed, 30 Aug 2023 09:07:36 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c21-20020ac80095000000b00407ffb2c24dsm2493258qtg.63.2023.08.30.09.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 09:07:35 -0700 (PDT)
Date: Wed, 30 Aug 2023 12:07:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V4 02/11] migration: preserve suspended runstate
Message-ID: <ZO9pRZrxr/aocZjB@x1n>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
 <1693333086-392798-3-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1693333086-392798-3-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, Aug 29, 2023 at 11:17:57AM -0700, Steve Sistare wrote:
> A guest that is migrated in the suspended state automaticaly wakes and
> continues execution.  This is wrong; the guest should end migration in
> the same state it started.  The root cause is that the outgoing migration
> code automatically wakes the guest, then saves the RUNNING runstate in
> global_state_store(), hence the incoming migration code thinks the guest is
> running and continues the guest if autostart is true.
> 
> On the outgoing side, do not call qemu_system_wakeup_request().
> 
> On the incoming side for precopy, prepare to start the vm, but do not
> yet start it.  A future system_wakeup will cause the main loop to resume
> the VCPUs.
> 
> On the incoming side for postcopy, do not wake the guest, and apply the
> the same logic as found in precopy: if autostart and the runstate is
> RUNNING, then vm_start, else prepare to start the vm.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


