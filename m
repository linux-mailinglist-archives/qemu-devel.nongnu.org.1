Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D4B7CD6BB
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:39:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt24z-00022E-CZ; Wed, 18 Oct 2023 04:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt24x-00021x-QR
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:38:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt24w-0005UV-6y
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697618337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OrO8K1y8dZnN/NP8xzNkVpIkNtCihXzISvJSBcpQhiE=;
 b=fTMGAmRPpOd6YrIuLO2q3mc59BMS7Cp9MbFSoPayWQvl+W9k/uCH4PIad/yUkjDyawr3Jt
 cjUD6LWjyaCXFYTmVAFHaZz6guU8SQknTiGq+Y4lm4m0VVjQxbVhUNlbaH6MUOJWyP8laF
 0OSdr0axxcp+NLCaqfn7Qb1AGpIpnHM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-Gr3TMBJfMuOFyVV4X1Baqw-1; Wed, 18 Oct 2023 04:38:50 -0400
X-MC-Unique: Gr3TMBJfMuOFyVV4X1Baqw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a681c3470fso481720966b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697618329; x=1698223129;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OrO8K1y8dZnN/NP8xzNkVpIkNtCihXzISvJSBcpQhiE=;
 b=eXKESJhX6SuPRIgE7nW394xYLJKtv94Y8TRSzomt9iOS+uq5nA2pe/R57YZFOud+O+
 +68JxahHQMfXWlEITZnPBHLqlly0g7LgjhjFd4j0JlZEso9G/mp/zwcgajX283EOWUPp
 Lp+fnJuFqeJbj6FBamXumsp13p1upkGTOR6rmHXimaODkCwOSUEUk1Jp/MqgRo44QsXt
 KWh0tEAGhr2tISTcWadaKaRuCf/fqsabY1CDIO797gq+FhQl0iFe7zIkcyU4DDSdCgp5
 uT5o8S3W6Nr/jz1aESvefWuztmy2aRumrnvgPoA2KEpPr+RDAVj7cOzMKPhoBfTCkSdg
 9FIQ==
X-Gm-Message-State: AOJu0YzluWeVm7lJJTpG/wDdIvA/QmN/6omO+niaDTGc3zzN1uwPI1cI
 A7EwE2q7liya5e3cttQcy9stv6FM/XgeDvrxM6MO8fLKlJPwSurmZCz6QaCsESXyHaFiYLGpUK3
 uxjhW8itv2XKXF5w=
X-Received: by 2002:a17:907:3e11:b0:9bf:122a:7db2 with SMTP id
 hp17-20020a1709073e1100b009bf122a7db2mr3997247ejc.66.1697618329713; 
 Wed, 18 Oct 2023 01:38:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeqE2g+qCQrxGy20SsTgWeyI8H05enQCX7VkKUxK2ir03QPRrQXhXIJzuQ9GAhR46vMojOQw==
X-Received: by 2002:a17:907:3e11:b0:9bf:122a:7db2 with SMTP id
 hp17-20020a1709073e1100b009bf122a7db2mr3997230ejc.66.1697618329282; 
 Wed, 18 Oct 2023 01:38:49 -0700 (PDT)
Received: from redhat.com ([193.142.201.38]) by smtp.gmail.com with ESMTPSA id
 e9-20020a17090681c900b00991faf3810esm1214774ejx.146.2023.10.18.01.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:38:48 -0700 (PDT)
Date: Wed, 18 Oct 2023 04:38:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v8 0/5] Implement reconnect for vhost-user-scsi
Message-ID: <20231018043831-mutt-send-email-mst@kernel.org>
References: <20231009044735.941655-1-fengli@smartx.com>
 <9D9DFA75-541B-4EE9-831F-B2FF941B3E41@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9D9DFA75-541B-4EE9-831F-B2FF941B3E41@smartx.com>
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

Queued. Thanks!
On Wed, Oct 18, 2023 at 04:26:10PM +0800, Li Feng wrote:
> Hello Guys,
> 
> Ping… 
> 
> These patches have been waiting for a long time. Can they be merged?
> 
> 
> Best Regards, 
> 
> li
> 
> 
>     On 9 Oct 2023, at 12:46 PM, Li Feng <fengli@smartx.com> wrote:
> 
>     Changes for v8:
>     - [PATCH 3/5] vhost-user-scsi: support reconnect to backend
>      - Fix code style suggested by Manos Pitsidianakis
>     - [PATCH 4/5] vhost-user-scsi: start vhost when guest kicks
>      - Use 'DEVICE()' macro in vhost_user_scsi_handle_output to replace the
>        'parent_obj.parent_obj.parent_obj.parent_obj'.
> 
>     Changes for v7:
>     - [PATCH 3/5] vhost-user-scsi: support reconnect to backend
>      - Add reporting the error in vhost-scsi;
>      - Rebase to master and fix the conflict.
>     - Add "Reviewed-by" tags.
> 
>     Changes for v6:
>     - [PATCH] vhost-user: fix lost reconnect
>      - Fix missing assign event_cb.
> 
>     Changes for v5:
>     - No logic has been changed, just move part of the code from patch 4 to
>     patch 5.
> 
>     Changes for v4:
>     - Merge
>      https://lore.kernel.org/all/20230830045722.611224-1-fengli@smartx.com/ to
>      this series.
>     - Add ERRP_GUARD in vhost_user_scsi_realize;
>     - Reword the commit messages.
> 
>     Changes for v3:
>     - Split the vhost_user_scsi_handle_output to a separate patch;
>     - Move the started_vu from vhost scsi common header to vhost-user-scsi
>     header;
>     - Fix a log print error;
> 
>     Changes for v2:
>     - Split the v1 patch to small separate patchset;
>     - New patch for fixing fd leak, which has sent to reviewers in another
>      mail;
>     - Implement the `vhost_user_scsi_handle_output`;
>     - Add the started_vu safe check;
>     - Fix error handler;
>     - Check the inflight before set/get inflight fd.
> 
>     Li Feng (5):
>      vhost-user-common: send get_inflight_fd once
>      vhost: move and rename the conn retry times
>      vhost-user-scsi: support reconnect to backend
>      vhost-user-scsi: start vhost when guest kicks
>      vhost-user: fix lost reconnect
> 
>     hw/block/vhost-user-blk.c             |   6 +-
>     hw/scsi/vhost-scsi-common.c           |  47 ++---
>     hw/scsi/vhost-scsi.c                  |   6 +-
>     hw/scsi/vhost-user-scsi.c             | 250 +++++++++++++++++++++++---
>     hw/virtio/vhost-user-gpio.c           |   5 +-
>     hw/virtio/vhost-user.c                |  10 +-
>     include/hw/virtio/vhost-scsi-common.h |   2 +-
>     include/hw/virtio/vhost-user-scsi.h   |   6 +
>     include/hw/virtio/vhost-user.h        |   3 +-
>     include/hw/virtio/vhost.h             |   2 +
>     10 files changed, 277 insertions(+), 60 deletions(-)
> 
>     --
>     2.41.0
> 
> 
> 


