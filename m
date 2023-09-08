Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEFD79919E
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 23:48:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qejK5-0005o2-Ec; Fri, 08 Sep 2023 17:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qejK3-0005no-GY
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 17:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qejK0-0002IT-0R
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 17:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694209641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MVnGqfuMl+3+JinftU/Ghg1NxDT8DsHcRpgrELFxrNo=;
 b=ds9d9ntIMUkguVcwTXXFIpKsFQBSIo1WtcD0Ucn91CeNrvyyw7ts6xmGAInRmahEqKerKT
 t3nK8He8k0HVEVZxtopNLqoF6CEGqt1/+VBQwGtWqlpIhTekpZ7CNsmMVHjp0Oldtp5rR8
 CDS8BJQ2OT4ZSjeg19F9XP/Ljnjyxnc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-4qFGhgiwO82q4SBRLWU1nQ-1; Fri, 08 Sep 2023 17:47:19 -0400
X-MC-Unique: 4qFGhgiwO82q4SBRLWU1nQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-65174aca002so4010486d6.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 14:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694209639; x=1694814439;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MVnGqfuMl+3+JinftU/Ghg1NxDT8DsHcRpgrELFxrNo=;
 b=F+yHt82G7bYV40x8EQgeEZGCApL6HsPYrQuBVoLM9oj3xDmOWQVOpg3B99wZQoBzYm
 FN5MJbakWv4ZeRVERIv2N898KxSnwSm3OP6cp0gZ0nGFCXcP66KLsqmZh3HlYMPWoYnm
 hdZ+NBGdIFG+bf+jwGhOG2UZJ3ucfBhPPLAszl+OnaP7/iW/zsqZeGRDmemzQYJ9h9UT
 /mI5Eg6L7qO3QZTMrFaqD+bdzeySNh6hLkC7sPKs/vIjNgGJBqfTPT59HPYrzs+2itM7
 amm5RqJpGRc6Rli9MN6xfglRNYRD9pEf2jBoF8W58AUTqpYE4NS7dJJoUk9LAZGUF/tW
 6frw==
X-Gm-Message-State: AOJu0Yz2mCaGV5TpGx0fN4XRYivful2xPAtxlrJ15UEuhCOzuVVDy91e
 OMK0zFSOZ0Ka6pM8YNwcV9ORq/AMPII8KtZXUzcbV6JQDtSx+2FoSsRCYV7/7UEXw04/VJtwaEL
 qvv/a1z/rvQA1z2E=
X-Received: by 2002:ad4:5b87:0:b0:653:5880:ed9e with SMTP id
 7-20020ad45b87000000b006535880ed9emr3676596qvp.6.1694209639486; 
 Fri, 08 Sep 2023 14:47:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEn/a2qVw8FE94N7kZwXWUL58RwJAdp7sb3JnVJSElI7iDCTKlKVMGOklTUo8eb/t6aQ3r5A==
X-Received: by 2002:ad4:5b87:0:b0:653:5880:ed9e with SMTP id
 7-20020ad45b87000000b006535880ed9emr3676579qvp.6.1694209639190; 
 Fri, 08 Sep 2023 14:47:19 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 u19-20020a0cdd13000000b006485e76574csm1018434qvk.78.2023.09.08.14.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 14:47:18 -0700 (PDT)
Date: Fri, 8 Sep 2023 17:47:16 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
Subject: Re: [PATCH v3 0/6] vfio/migration: Block VFIO migration with
 postcopy and background snapshot
Message-ID: <ZPuWZAzqh6y+koSn@x1n>
References: <20230906150853.22176-1-avihaih@nvidia.com>
 <9a962af2-1748-017b-9ab3-fdf7d9f84b4b@redhat.com>
 <a79d5831-4ec7-89d4-2b5c-270b80229dc4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a79d5831-4ec7-89d4-2b5c-270b80229dc4@redhat.com>
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

On Thu, Sep 07, 2023 at 11:07:10AM +0200, Cédric Le Goater wrote:
> [ ... ]
> 
> > Applied to vfio-next.
> 
> On that topic I am preparing a PR.
> 
> Juan, Peter, Leonardo, is it ok for you if these migration changes
> go through the VFIO tree ?

All good here.

Thanks,

-- 
Peter Xu


