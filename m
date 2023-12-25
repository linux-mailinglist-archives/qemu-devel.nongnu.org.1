Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2ED81E177
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 16:57:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHnJf-0006N8-NT; Mon, 25 Dec 2023 10:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rHnJb-0006Md-LF
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 10:56:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rHnJW-0003IN-2J
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 10:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703519781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDlRnIarkql0VgOGNm29+8JAyFhigT2pkjAsB4WYzjM=;
 b=iLjKo2KU0bA+4TAsvPBa4mZ5dZz4cbO3TAkLWK4BLlRHdfd3aaM1CEenFJKSxpP6ELZJv8
 d1jr7IHWzXlqH4kgvqNbBunSqo78O6p1xu+sCgPuh2hKE1SBsoTWG1JPGQiXWBag7/MM/y
 B85J93xGkJ7cum6+HnpS+vgzM5Z9VRY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-CEd33bX9OvicwDTv0wA4FA-1; Mon, 25 Dec 2023 10:56:19 -0500
X-MC-Unique: CEd33bX9OvicwDTv0wA4FA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3368698f0caso2604794f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Dec 2023 07:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703519778; x=1704124578;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pDlRnIarkql0VgOGNm29+8JAyFhigT2pkjAsB4WYzjM=;
 b=XBTEuuZq5vCQXP1NPTdzremFdFv2wUxbE7cfosip22A9JsrpyS2fi34s2xUj4NT0RU
 2YeUn/XAQA+QSNkrxRrFL5ZDQav/NXWGVB2Pj1miVpePeU3JLxFlIOWqCVLalBOy5Hul
 PwLXVdT3BlL8uLx1hyMO8j85qxC8ZhRN5GImoLChfptlTwm7fpPvzdSvCdVH/uim8GBz
 dOTIk+sWJ0Ptq64oUCqe73KoJKGKpKGntIkZgGStc9JKNJ7OfFKsAINZ6SGM0p7U0u1H
 +TtHm5Rnp6ZzWqiDBaKUDEES4cmPLm2+tFLeXu8UwmEkDQM8OzGFPhljObqAKojNiZUA
 RQCg==
X-Gm-Message-State: AOJu0YzAVhJc9ge4edhjClZNEY8XlgAj3i0iUqmd0dnpunugpjwG56Qh
 8FodfXBTVZaQIeaiMHm2Ejs7jkfw0ceaynzucSF5rVzmdvLEbnQNa17aKnhcNs5TR8DXfpbs4Yk
 DYsY2cDVWOsMIlAbsQCv1VS8=
X-Received: by 2002:a05:600c:45d2:b0:40d:3043:81c with SMTP id
 s18-20020a05600c45d200b0040d3043081cmr1636208wmo.353.1703519778421; 
 Mon, 25 Dec 2023 07:56:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpWNeZWyG+7jSt3AKKIIFO0vPViMFaSBTuoie9+H9Oi+8uVWgrPGNlX1RoE2D+MNRtQJcFVg==
X-Received: by 2002:a05:600c:45d2:b0:40d:3043:81c with SMTP id
 s18-20020a05600c45d200b0040d3043081cmr1636204wmo.353.1703519778020; 
 Mon, 25 Dec 2023 07:56:18 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
 by smtp.gmail.com with ESMTPSA id
 az42-20020a05600c602a00b0040d4a7f2778sm11554265wmb.32.2023.12.25.07.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 07:56:17 -0800 (PST)
Date: Mon, 25 Dec 2023 10:56:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 0/6] migration: check required entries and sections
 are loaded
Message-ID: <20231225105554-mutt-send-email-mst@kernel.org>
References: <20231106113601.2052601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231106113601.2052601-1-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
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

On Mon, Nov 06, 2023 at 03:35:54PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> Surprisingly, the migration code doesn't check that required migration entries
> and subsections are loaded. Either optional or required sections are both
> ignored when missing. According to the documentation a "newer QEMU that knows
> about a subsection can (with care) load a stream from an older QEMU that didn't
> send the subsection". I propose this behaviour to be limited to "optional"
> sections only.
> 
> This series has a few preliminary fixes, add new checks that entries are
> loaded once and required ones have been loaded, add some tests and
> documentation update.
> 
> thanks


series:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

merge through migration tree.

> v3:
>  - rebased, drop RFC status
>  - switch from tracepoint + returning an error to report for missing
>    subsections, as we worry about potential regressions
>  - add r-b tags
> 
> v2:
>  - add "migration: rename vmstate_save_needed->vmstate_section_needed"
>  - add "migration: set file error on subsection loading"
>  - add subsection tests
>  - update the documentation
> 
> Marc-André Lureau (6):
>   block/fdc: 'phase' is not needed on load
>   virtio: make endian_needed() work during loading
>   migration: check required subsections are loaded, once
>   migration: check required entries are loaded, once
>   test-vmstate: add some subsection tests
>   docs/migration: reflect the changes about needed subsections
> 
>  docs/devel/migration.rst  |  17 +++---
>  hw/block/fdc.c            |   5 ++
>  hw/virtio/virtio.c        |   6 +-
>  migration/savevm.c        |  43 ++++++++++++++
>  migration/vmstate.c       |  40 ++++++++++++-
>  tests/unit/test-vmstate.c | 116 ++++++++++++++++++++++++++++++++++++++
>  6 files changed, 215 insertions(+), 12 deletions(-)
> 
> -- 
> 2.41.0


