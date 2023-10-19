Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C497CF661
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQyB-0006YB-7i; Thu, 19 Oct 2023 07:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQy7-0006Lr-JO
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQy3-0004ng-TO
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697714010;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4Y5dG0H6RnOkm0YuveEJwfcj+vyrtTpcunGosddbeME=;
 b=Q13y12c/+a22qoKC77u4Y6mSekTyx9DfsTuAGbBEQLosU986N6LITQ74D1XsbWXkoB6NXc
 i5Z7QUxNCfiZvduJORnIdVCpHiMdA+hV7n+6FHGKU1JQ/A3bOTzRfeP1VcJz20bGlNoElL
 OFRJdHcjsXTYk0AiOsC2WY86gtJEUjg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-iHqfGzayOY6IlzlyQbTNOA-1; Thu, 19 Oct 2023 07:13:27 -0400
X-MC-Unique: iHqfGzayOY6IlzlyQbTNOA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-407d3e55927so15444695e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 04:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697714007; x=1698318807;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Y5dG0H6RnOkm0YuveEJwfcj+vyrtTpcunGosddbeME=;
 b=W+Rf6ykeSxPdFPJGl99iYKOV2AyqIFByIlfqMdZTyQBNGH1BDgKt5jsjfy7DGaMsC4
 CP+xRyKIip7+nv90LKc5hbQI424U/MHAfugZWbNfTX4Rzdek/Bepc/Mqv5oXFEEsLx3X
 huRDKM2fIySVusRKYXMauOmRyUNcNYBAZVBW5oTv4sehEhuRlY2nsDhf6gYWuKSq9zC7
 9UBkKePXH/DKnggfP2uiFl+Q6MbKyFdFtaR2qGueOC2yGnzdqCnx5xSX7AYI2eU/fGK8
 BOoNeaBjQaofZdLvCHlzPk6z9CPDiqICZGz2CCuT7XuNFnc2jhm3WXuNEGL+vYEYk2tf
 cfMA==
X-Gm-Message-State: AOJu0Yy/L9B0k1QhCWAclnCv3RNvhp4+6Yw9ZQKESCNbP4L8dcBBzSyM
 m/J3Nf0jJ/9r0RSGMwrXG5F8jRmF3Lg7BJc0F2fIJjUiKEEW/b892I9DPzKhE0xmEr88CP9wkj7
 6GP+0YmHHNd1kq9g=
X-Received: by 2002:a05:600c:1e11:b0:405:5ffd:21d2 with SMTP id
 ay17-20020a05600c1e1100b004055ffd21d2mr1656826wmb.19.1697714006806; 
 Thu, 19 Oct 2023 04:13:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbxF0Dp4M+XUIv58MwSqVMPrklIu64MFulstTRtgQ7L+yHh/fHZcl4O++EyX3qDxXAUraHag==
X-Received: by 2002:a05:600c:1e11:b0:405:5ffd:21d2 with SMTP id
 ay17-20020a05600c1e1100b004055ffd21d2mr1656804wmb.19.1697714006432; 
 Thu, 19 Oct 2023 04:13:26 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 n11-20020a05600c3b8b00b004068de50c64sm4234986wms.46.2023.10.19.04.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 04:13:25 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: peterx@redhat.com,  farosas@suse.de,  leobras@redhat.com,
 qemu-devel@nongnu.org,  nanhai.zou@intel.com
Subject: Re: [PATCH 0/5] Live Migration Acceleration with IAA Compression
In-Reply-To: <20231018221224.599065-1-yuan1.liu@intel.com> (Yuan Liu's message
 of "Thu, 19 Oct 2023 06:12:19 +0800")
References: <20231018221224.599065-1-yuan1.liu@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 13:13:25 +0200
Message-ID: <87y1fy6f1m.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Yuan Liu <yuan1.liu@intel.com> wrote:
> Hi,
>
> I am writing to submit a code change aimed at enhancing live migration
> acceleration by leveraging the compression capability of the Intel
> In-Memory Analytics Accelerator (IAA).
>
> Enabling compression functionality during the live migration process can
> enhance performance, thereby reducing downtime and network bandwidth
> requirements. However, this improvement comes at the cost of additional
> CPU resources, posing a challenge for cloud service providers in terms of
> resource allocation. To address this challenge, I have focused on offloading
> the compression overhead to the IAA hardware, resulting in performance gains.

Do you have any numbers that you can share?

Thanks, Juan.

> The implementation of the IAA (de)compression code is based on Intel Query
> Processing Library (QPL), an open-source software project designed for
> IAA high-level software programming.
>
> Best regards,
> Yuan Liu
>
> Yuan Liu (5):
>   configure: add qpl meson option
>   qapi/migration: Introduce compress-with-iaa migration parameter
>   ram compress: Refactor ram compression interfaces
>   migration iaa-compress: Add IAA initialization and deinitialization
>   migration iaa-compress: Implement IAA compression
>
>  meson.build                    |   9 +-
>  meson_options.txt              |   2 +
>  migration/iaa-ram-compress.c   | 319 +++++++++++++++++++++++++++++++++
>  migration/iaa-ram-compress.h   |  27 +++
>  migration/meson.build          |   1 +
>  migration/migration-hmp-cmds.c |   8 +
>  migration/migration.c          |   6 +-
>  migration/options.c            |  20 +++
>  migration/options.h            |   1 +
>  migration/ram-compress.c       |  96 ++++++++--
>  migration/ram-compress.h       |  10 +-
>  migration/ram.c                |  68 ++++++-
>  qapi/migration.json            |   4 +-
>  scripts/meson-buildoptions.sh  |   3 +
>  14 files changed, 541 insertions(+), 33 deletions(-)
>  create mode 100644 migration/iaa-ram-compress.c
>  create mode 100644 migration/iaa-ram-compress.h


