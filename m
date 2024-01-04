Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E4A823B9C
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:58:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFmg-0004U0-Tc; Wed, 03 Jan 2024 23:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFme-0004To-F0
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:56:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFmb-0001jV-50
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:56:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704344199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LjH9M2HU0CdKxk6Fqfin8Bkbz5+9v3tohJgqxPFfYPU=;
 b=IRI6qJjqQxrIabge7E4Y/sLp1duBF5Pagybv+6E6KghBu4+rtQ+q0PYkrfpZl0g/mk24gH
 u7kF4oQdTMKP6758xtvoH81AkdF6wXAVxxseygJoPyZdMbiJo0U9tGySjkcg2niWeR986r
 5R8PF1LbKfijsmBp63PYkutziDI/Mtw=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-fngCTTEkPVqr_9VM_j3AIA-1; Wed, 03 Jan 2024 23:56:38 -0500
X-MC-Unique: fngCTTEkPVqr_9VM_j3AIA-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6dc056af5e5so48253a34.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 20:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704344198; x=1704948998;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LjH9M2HU0CdKxk6Fqfin8Bkbz5+9v3tohJgqxPFfYPU=;
 b=UWzNptgOi/7jyYdMA4Hen3KdSgqlS4Ou4zYOZc43vyNa8e7/GtpaOGNye4NeFGg2Vh
 851cHphVq6BMh52kPBZ7d6GBZa+mveEI0i0ZvwiNZLuKIoG0fas3CtxEGWtFmHU+6h5U
 66VsNJGkqmlsFRg7UQevabHO/AIHx9gtd6ebiE+bHcRr4RlOfIGyYcZ66YPzAlHa6ZdE
 zb1MTtndEqt2ikpnwbFKJVmuspw6xneFwYX9tMzmVZsUeFAZMdyW782YITUQf5cOses7
 ALMTAvfJg438B0EKhyRh4bGG79dXBDeOfVn0Yc8bgSM82oD8d/8Qz7OlysViAq5/9N+R
 Pv6Q==
X-Gm-Message-State: AOJu0Yy3kjZPVsk6yedxcvMQi1vch28kul0137c0PjLJQlVJASr7l8Dn
 BsKBO6XxbLFdw004QfJEAHV9Ao/71gyZlaA8XG5dVQ8pm3++KDgYIhVU5xZY5NwBvyi+xeWJyQj
 32c4DhbmfOOgnPHFOnTN3Kxw=
X-Received: by 2002:a05:6830:4420:b0:6da:3071:2f73 with SMTP id
 q32-20020a056830442000b006da30712f73mr269792otv.2.1704344197839; 
 Wed, 03 Jan 2024 20:56:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxnZIpCvJ2mKnKKzveoYj/hatnpeG0FPgguve/dHJxDwhY5TQn1Vl1YAo1Ylo76WnP/9L3Bg==
X-Received: by 2002:a05:6830:4420:b0:6da:3071:2f73 with SMTP id
 q32-20020a056830442000b006da30712f73mr269782otv.2.1704344197525; 
 Wed, 03 Jan 2024 20:56:37 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 e12-20020a63500c000000b005ce998b9391sm5369816pgb.67.2024.01.03.20.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 20:56:37 -0800 (PST)
Date: Thu, 4 Jan 2024 12:56:32 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v1 0/7] migration cleanups and testing improvements
Message-ID: <ZZY6gNZWZRIvBYp6@x1n>
References: <20231124161432.3515-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231124161432.3515-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
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

On Fri, Nov 24, 2023 at 01:14:25PM -0300, Fabiano Rosas wrote:
> Hi,
> 
> These are some general cleanups and improvements to testing and
> debugging that I collected over the past month.
> 
> Fabiano Rosas (7):
>   migration/multifd: Remove MultiFDPages_t::packet_num
>   migration/multifd: Remove QEMUFile from where it is not needed
>   migration/multifd: Change multifd_pages_init argument
>   migration: Report error in incoming migration
>   tests/qtest/migration: Print migration incoming errors
>   tests/qtest/migration: Add a wrapper to print test names
>   tests/qtest/migration: Use the new migration_test_add

Fabiano,

It seems this doesn't apply anymore, since I queued and tested the other
ones first I left this one for next, my apologies.

Please repost when you have time.

-- 
Peter Xu


