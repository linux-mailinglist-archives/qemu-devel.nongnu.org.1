Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA1A78D7C1
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 19:02:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbOZN-0004dN-GD; Wed, 30 Aug 2023 13:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbOZ6-0004cc-TG
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 13:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbOZ4-0006G5-Rx
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 13:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693414869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vdUAoJSmkZubytq2wunG86fduER1QX7bEWyf8jtNWp0=;
 b=VfFjN1Wy0tvGtXWU/yfk57IzIRq+q3LBq5pgyxqZ8Dke4RVLDS04MAoWPwcf8ak4vs69kH
 hqlNE0imSVXY9qkS0rL5dulNqEDNlD8Ty8vYLy70m7Wvkye8WRdGc6GMi9mdlUeW3971aX
 lF45Y8uksqjDDdCJOk2AXTeE9ruHE3I=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-jR7VjpqGNve4IdpZsnfOtA-1; Wed, 30 Aug 2023 13:01:04 -0400
X-MC-Unique: jR7VjpqGNve4IdpZsnfOtA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-411f4a7ddbdso16567031cf.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 10:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693414863; x=1694019663;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vdUAoJSmkZubytq2wunG86fduER1QX7bEWyf8jtNWp0=;
 b=OOZ53FCWboGDxg+ffCEWz6Eb+Lv4d9cwKTvAoIvhILqmmqVNTc8E77AANQuPRARuCi
 f2xWGSO8J8zyh9B/buA7Wj+Wo9O7c2mEXxoT1MDd7PBWiaIsVfx1Bd6MnvcYgXOM/NrI
 vfn9Sc73/1EzPgcn6WRU5mqrjyXZph6PHNAyS3HSiyTF8VtcUs1/ucjt4SSqkVRt+rlY
 oE39In/aeqQOEfjfWMDyGY+fb5+qW9CJw4Sq60LxrLKmBs+CN4e01iaFL1EMBgSKOIPT
 scooqiSf5Qrj6sHQX2QHZUKwe9oFIt2yDsYoJbtd6C8tNq1eZFmHM54HIFbfdHDBnHZb
 BVWQ==
X-Gm-Message-State: AOJu0Yx/iBeZ9mSSkQZxnlgxC0UlKzQ1JUkgK2zSFqjPhbP7JmwfEVyZ
 OCu5oLGJQs+mQF8e6QS69HYTqwAp2ECGRk0s4V+uGTMXFPRqKa5AQby66YxFFeaphDBHM+yE8a2
 j80dpriHeX5haxHE=
X-Received: by 2002:a05:622a:1a25:b0:412:2dd3:e0ed with SMTP id
 f37-20020a05622a1a2500b004122dd3e0edmr2826176qtb.0.1693414863293; 
 Wed, 30 Aug 2023 10:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiJQD8ID0sQ2cBKIR7QonggsjS8PF8G4y5mkkKoE7yL8pyaSkoheSQoYE1K8/Mp75iX5MeJA==
X-Received: by 2002:a05:622a:1a25:b0:412:2dd3:e0ed with SMTP id
 f37-20020a05622a1a2500b004122dd3e0edmr2826144qtb.0.1693414862790; 
 Wed, 30 Aug 2023 10:01:02 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 ha8-20020a05622a2b0800b0041087c90049sm3853283qtb.52.2023.08.30.10.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 10:01:02 -0700 (PDT)
Date: Wed, 30 Aug 2023 13:01:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V4 08/11] tests/qtest: option to suspend during migration
Message-ID: <ZO91zAT+5aBG78fb@x1n>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
 <1693333086-392798-9-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1693333086-392798-9-git-send-email-steven.sistare@oracle.com>
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

On Tue, Aug 29, 2023 at 11:18:03AM -0700, Steve Sistare wrote:
> Add an option to suspend the src in a-b-bootblock.S, which puts the guest
> in S3 state after one round of writing to memory.  The option is enabled by
> poking a 1 into the suspend_me word in the boot block prior to starting the
> src vm.  Generate symbol offsets in a-b-bootblock.h so that the suspend_me
> offset is known.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


