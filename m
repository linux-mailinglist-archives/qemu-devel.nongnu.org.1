Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF927BCD41
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 10:50:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpPTs-0000N1-QN; Sun, 08 Oct 2023 04:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpPTq-0000KU-QX
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 04:49:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpPTp-0004Nf-7K
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 04:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696754980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbyrm/YTfuLwP7ptYUpioKFZPGAIm9Ml+tm2AKb+HLg=;
 b=HTNOfeQdYEfiqW5TAaIQfLTt/zMF8G4JSBe4aehfLg6lREOTV8fpV6MDi83Z7ux3km89At
 fxVeCqT70PLBbYW6fHVMNzrhS7fwCoFMAzgot2xGOiLaSytAaOFZMFKssxLNabWk8VtNev
 P2cYKaBmvyP5cIZa87yr0Osz6vzGiA8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-DkFMlPFSNf-9OOsRHb7m1Q-1; Sun, 08 Oct 2023 04:49:28 -0400
X-MC-Unique: DkFMlPFSNf-9OOsRHb7m1Q-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-997c891a88dso33277366b.3
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 01:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696754968; x=1697359768;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbyrm/YTfuLwP7ptYUpioKFZPGAIm9Ml+tm2AKb+HLg=;
 b=icHwSNZvWUmOv+jBb9cotey/ONbL4A82Vrjr2N9deRGOtbWjkzORXRpUdqYaPR3RsM
 WHfeip1nK/xsy5+lNDLISufXGSb8mP2h4oxRWmrKD7ClQ5JvNHC5r+2wJckBJPKL3yGB
 W9WhknMtLPGgtH3vV4mk8R7dD0onzGCsseDwU0KgVgYdsLkzZB2X0YyOjAWf6VzvAcrV
 RfbGHwPOF2CfBGM/2UgFkoIWX2FbKguxwyYtffgWaffE5RsJtZQ4QfRpyR340abCDsSS
 040VqCug93WVE7tjkK9vMhv3Y5qFltxbNLNi9XGJ7OlA9I83JnuQxw6gum1Icx87wrZ+
 ez0A==
X-Gm-Message-State: AOJu0Yx95k4vHWpc3Y3VJK1UxXJZoFashmmrf1M21JMoQECxUy5DnA8A
 giRYsVuEXqPydw0xzcquXzSEtoqUNwuGiQANzvTF99E9oFDCFSaD+4tXWEDuzb8BymYCYevkjHo
 ZZorEXn/Atr6ouMo=
X-Received: by 2002:a17:907:7850:b0:9ae:75dc:4589 with SMTP id
 lb16-20020a170907785000b009ae75dc4589mr12658605ejc.64.1696754967934; 
 Sun, 08 Oct 2023 01:49:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvAHnTwkeqU4LojILqqyMNM5u0Sg52zzJGPH0Bw13EQxkNMUutYNqL9Lb/fLOxnFBgEFvgMw==
X-Received: by 2002:a17:907:7850:b0:9ae:75dc:4589 with SMTP id
 lb16-20020a170907785000b009ae75dc4589mr12658596ejc.64.1696754967624; 
 Sun, 08 Oct 2023 01:49:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:d74e:e6b1:da81:860a:5e9e])
 by smtp.gmail.com with ESMTPSA id
 i3-20020a1709064ec300b00997d7aa59fasm5392287ejv.14.2023.10.08.01.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 01:49:26 -0700 (PDT)
Date: Sun, 8 Oct 2023 04:49:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 0/5] Implement reconnect for vhost-user-scsi
Message-ID: <20231008044854-mutt-send-email-mst@kernel.org>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230922114625.5786-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922114625.5786-1-fengli@smartx.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Sep 22, 2023 at 07:46:10PM +0800, Li Feng wrote:
> Changes for v6:
> - [PATCH] vhost-user: fix lost reconnect
>   - Fix missing assign event_cb.


Pls don't make vN+1 a reply to vN - start a new thread
with each version please.

> Changes for v5:
> - No logic has been changed, just move part of the code from patch 4 to patch 5.
> 
> Changes for v4:
> - Merge
>   https://lore.kernel.org/all/20230830045722.611224-1-fengli@smartx.com/ to
>   this series.
> - Add ERRP_GUARD in vhost_user_scsi_realize;
> - Reword the commit messages.
> 
> Changes for v3:
> - Split the vhost_user_scsi_handle_output to a separate patch;
> - Move the started_vu from vhost scsi common header to vhost-user-scsi header;
> - Fix a log print error;
> 
> Changes for v2:
> - Split the v1 patch to small separate patchset;
> - New patch for fixing fd leak, which has sent to reviewers in another
>   mail;
> - Implement the `vhost_user_scsi_handle_output`;
> - Add the started_vu safe check;
> - Fix error handler;
> - Check the inflight before set/get inflight fd.
> 
> Li Feng (5):
>   vhost-user-common: send get_inflight_fd once
>   vhost: move and rename the conn retry times
>   vhost-user-scsi: support reconnect to backend
>   vhost-user-scsi: start vhost when guest kicks
>   vhost-user: fix lost reconnect
> 
>  hw/block/vhost-user-blk.c             |   6 +-
>  hw/scsi/vhost-scsi-common.c           |  47 ++---
>  hw/scsi/vhost-scsi.c                  |   5 +-
>  hw/scsi/vhost-user-scsi.c             | 253 +++++++++++++++++++++++---
>  hw/virtio/vhost-user-gpio.c           |   5 +-
>  hw/virtio/vhost-user.c                |  10 +-
>  include/hw/virtio/vhost-scsi-common.h |   2 +-
>  include/hw/virtio/vhost-user-scsi.h   |   4 +
>  include/hw/virtio/vhost-user.h        |   3 +-
>  include/hw/virtio/vhost.h             |   2 +
>  10 files changed, 277 insertions(+), 60 deletions(-)
> 
> -- 
> 2.41.0


