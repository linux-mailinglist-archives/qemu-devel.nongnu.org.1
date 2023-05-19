Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8738A70920C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:50:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvoK-0007t2-OT; Fri, 19 May 2023 04:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzvoH-0007pd-9T
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzvoF-0007Al-Jc
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684486199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sAIqcNSg1jUS/ZZ6Q74aglsapI+xga8RTTWMs46LGnk=;
 b=gTXE3PTGA0p4aTfDbnFV3thqBoRwj/4pqx8eSmxaJJcWcuuJJj6hqqw9goxc+k8BIghOrq
 1eTYtH7/tM1VNN1MDaSQCLmigk7pmZeYjzbGmJL23WxQUFkpQ/mfXmcNb1T5b9GbHWtC+V
 2ITRwbCJmDcUVurg+lt1sYcsiS3mkZ8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-fmjagw4aOeW3JLYjTNfdCg-1; Fri, 19 May 2023 04:49:57 -0400
X-MC-Unique: fmjagw4aOeW3JLYjTNfdCg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2af207a45bfso5375451fa.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 01:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684486195; x=1687078195;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sAIqcNSg1jUS/ZZ6Q74aglsapI+xga8RTTWMs46LGnk=;
 b=Hh6+AMoWPofQdX+vGgR30STvT6eN3XorEzkxJuSFG6s0bNr8uIJeUpP6wxTztZAGCV
 ExL97aPH3u9dpPMPLl/7hzVpZCWsfLH9iHuzthCBpQC4upW845fgy9R69FDRHmi7Oti8
 fjT38YVy6QrmfrEq3riQYYKFsw+Da2kx5gri5ZpYdQxc0Gg30yFfhB//KuBJ8uU/xKXH
 IdkBGwEJr5O3in0/IIuedlGt7Xwl2AQykl9CxnahCsqiiMpaYsZqByJDRHMHXyVv3PgX
 mVkOhSGnXlQaW2RwzKUHUWSVEaZFv/A3qRaFwRy2B4Ok/aFeGzkTa2Gzll46BBt9b4V3
 HyEA==
X-Gm-Message-State: AC+VfDzec7jxPeckINMFvltqMwESR/nlSofeWk9LD6BCuFeAmnDWBGDw
 2zxM+TCPkDzN5nqADSChwzQR0ADJiig3jXkNMVZNieaKJyBX0fg1TIuLvzvhZwjprTY6FpzhlfE
 3oqDay9gSkY95w/w=
X-Received: by 2002:a2e:9c41:0:b0:2a7:6e37:ee68 with SMTP id
 t1-20020a2e9c41000000b002a76e37ee68mr419747ljj.12.1684486195653; 
 Fri, 19 May 2023 01:49:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4h/RBMG4WF9ve5fBx7mJkNNme62aR0mw5ncO+jQ7BcZhAczwljFZif6SBGvR1rjHcvG+Y9nQ==
X-Received: by 2002:a2e:9c41:0:b0:2a7:6e37:ee68 with SMTP id
 t1-20020a2e9c41000000b002a76e37ee68mr419737ljj.12.1684486195312; 
 Fri, 19 May 2023 01:49:55 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:3e4d:6703:27b9:6f74:5282])
 by smtp.gmail.com with ESMTPSA id
 b7-20020a2e9887000000b002a9ec7c0b4csm718736ljj.10.2023.05.19.01.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 01:49:54 -0700 (PDT)
Date: Fri, 19 May 2023 04:49:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org, linuxarm@huawei.com,
 Ira Weiny <ira.weiny@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 0/6] hw/cxl: Poison get, inject, clear
Message-ID: <20230519030942-mutt-send-email-mst@kernel.org>
References: <20230423162013.4535-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423162013.4535-1-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, Apr 23, 2023 at 05:20:07PM +0100, Jonathan Cameron wrote:
> v5: More details in each patch.
>  - Simpler algorithm to find entry when clearing.
>  - Improvements to debugability and docs for 24 bit endian functions.
>  - Use of ROUND_DOWN() to simplify the various alignment questions.
>  - Use CXL_CACHELINE_SIZE define to explain the mysterious 64 byte
>    granularity
>  - Use memory_region_size() instead of direct accesses.


picked first 3 but dropped the rest for now due to build errors.

> Many of the precursors listed for v4 have now been applied, but
> a few minor fixes have come up in the meantime so there are still
> a few precursors including the volatile support left from v4
> precursors.
> 
> Depends on 
> [PATCH 0/2] hw/cxl: CDAT file handling fixes.
> [PATCH v2 0/3] hw/cxl: Fix decoder commit and uncommit handling
> [PATCH 0/3] docs/cxl: Gathering of fixes for 8.0 CXL docs.
> [PATCH v5 0/3] hw/mem: CXL Type-3 Volatile Memory Support
>  
> Based on: Message-ID: 20230421132020.7408-1-Jonathan.Cameron@huawei.com
> Based on: Message-ID: 20230421135906.3515-1-Jonathan.Cameron@huawei.com
> Based on: Message-ID: 20230421134507.26842-1-Jonathan.Cameron@huawei.com
> Based on: Message-ID: 20230421160827.2227-1-Jonathan.Cameron@huawei.com
> 
> The kernel support for Poison handling is currently in the cxl/pending
> branch and hopefully should be in the CXL pull request next week.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=pending
> 
> This code has been very useful for testing and helped identify various
> corner cases.
> 
> Updated cover letter.
> 
> The series supports:
> 1) Injection of variable length poison regions via QMP (to fake real
>    memory corruption and ensure we deal with odd overflow corner cases
>    such as clearing the middle of a large region making the list overflow
>    as we go from one long entry to two smaller entries.
> 2) Read of poison list via the CXL mailbox.
> 3) Injection via the poison injection mailbox command (limited to 64 byte
>    entries - spec constraint)
> 4) Clearing of poison injected via either method.
> 
> The implementation is meant to be a valid combination of impdef choices
> based on what the spec allowed. There are a number of places where it could
> be made more sophisticated that we might consider in future:
> * Fusing adjacent poison entries if the types match.
> * Separate injection list and main poison list, to test out limits on
>   injected poison list being smaller than the main list.
> * Poison list overflow event (needs event log support in general)
> * Connecting up to the poison list error record generation (rather complex
>   and not needed for currently kernel handling testing).
> * Triggering the synchronous and asynchronous errors that occur on reads
>   and writes of the memory when the host receives poison.
> 
> As the kernel code is currently fairly simple, it is likely that the above
> does not yet matter but who knows what will turn up in future!
> 
> 
> Ira Weiny (2):
>   hw/cxl: Introduce cxl_device_get_timestamp() utility function
>   bswap: Add the ability to store to an unaligned 24 bit field
> 
> Jonathan Cameron (4):
>   hw/cxl: rename mailbox return code type from ret_code to CXLRetCode
>   hw/cxl: QMP based poison injection support
>   hw/cxl: Add poison injection via the mailbox.
>   hw/cxl: Add clear poison mailbox command support.
> 
>  docs/devel/loads-stores.rst |   1 +
>  hw/cxl/cxl-device-utils.c   |  15 ++
>  hw/cxl/cxl-mailbox-utils.c  | 289 ++++++++++++++++++++++++++++++------
>  hw/mem/cxl_type3.c          |  93 ++++++++++++
>  hw/mem/cxl_type3_stubs.c    |   6 +
>  include/hw/cxl/cxl.h        |   1 +
>  include/hw/cxl/cxl_device.h |  23 +++
>  include/qemu/bswap.h        |  25 ++++
>  qapi/cxl.json               |  18 +++
>  9 files changed, 429 insertions(+), 42 deletions(-)
> 
> -- 
> 2.37.2


