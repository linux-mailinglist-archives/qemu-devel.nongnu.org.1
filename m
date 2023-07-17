Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5F57565F1
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 16:12:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLOxB-0006Lj-SL; Mon, 17 Jul 2023 10:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qLOx3-0006L2-BC
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qLOx1-0008Ky-Uz
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689603106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pfz5MEi52XqlyxCmQL6gvu+oPooRt7UNHD3hmFmEFnU=;
 b=N5vBITu5RXWrex5AhQbmJQ8gTLRcF9uZWbNK7wrcpMfrrcfZWqBp8bDlc20nlAAJk5GcrL
 yEHeIvtnReEDad5pmgxtsrkk9eWEnT5RxNT5p3nOmuXpJbBG4V4sUkRD1D74/B83fNDMly
 3k2mWhNo2J0dXHpxATeQFSfc++GYSXg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-hT4saIQqN5iCqZ9KVDr7Ow-1; Mon, 17 Jul 2023 10:11:45 -0400
X-MC-Unique: hT4saIQqN5iCqZ9KVDr7Ow-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4fbcdca90dcso3731194e87.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 07:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689603103; x=1692195103;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pfz5MEi52XqlyxCmQL6gvu+oPooRt7UNHD3hmFmEFnU=;
 b=DMcckY5oNbEJnT3oEHqWYEFhREj/ICjg6FljI+9iA2lVsyWgubQeKNwQprdMsdg82O
 RHYbx8Z55k6ztfSR+BnqYsZbjTtcenppEE2Af2V6pYWu+l+eJbWiRDgv1/I3Gj6jSh+Z
 GpoJbuioQPoN9o1Z7GfG6RleXlHx3EHVb69h5fa7X4xGI7mNmlYuqQpZsdfezVMLq98s
 UuYPu6xN1pr+YwoUxuTzjK3pjIJt53wZS9cee3pft93l/hUxI4j2HztRTt+74sL5CGWz
 jcOWwqrge+rsgplUPP/JDikAF6zljw4vH+gopCXYTfsLdtwH7BFGxzd0UlTEalYOnxBB
 qpEg==
X-Gm-Message-State: ABy/qLbtz9vFdgTZOPqcMXZFHm16WH8wsP0Bg8E65+FAcS94XNZtcZ+u
 gQjmWMThYYt8X/FwFPkyPMjwazA06fm5Mb1B/A0XLOSRCo5w0NoGZXS6neHVi5QrqZC0RTcUhJi
 plrTf6iTJYS1+nKc=
X-Received: by 2002:ac2:5b4b:0:b0:4f6:1779:b1c1 with SMTP id
 i11-20020ac25b4b000000b004f61779b1c1mr7677362lfp.48.1689603103629; 
 Mon, 17 Jul 2023 07:11:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH/k3GkBI/orPwvE4bn7CDQGxGgXrHncJL/6rniONT0iLIdrH27Ei5cKS5432zPXwHkYdQD4Q==
X-Received: by 2002:ac2:5b4b:0:b0:4f6:1779:b1c1 with SMTP id
 i11-20020ac25b4b000000b004f61779b1c1mr7677344lfp.48.1689603103277; 
 Mon, 17 Jul 2023 07:11:43 -0700 (PDT)
Received: from redhat.com ([2.52.146.77]) by smtp.gmail.com with ESMTPSA id
 a12-20020a5d508c000000b00316f9abf073sm5923970wrt.82.2023.07.17.07.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 07:11:42 -0700 (PDT)
Date: Mon, 17 Jul 2023 10:11:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, cohuck@redhat.com,
 Fam Zheng <fam@euphon.net>, kraxel@redhat.com
Subject: Re: [PATCH v4 3/4] vhost-user: add shared_object msg
Message-ID: <20230717100739-mutt-send-email-mst@kernel.org>
References: <20230626073426.285659-1-aesteve@redhat.com>
 <20230626073426.285659-4-aesteve@redhat.com>
 <20230710150030-mutt-send-email-mst@kernel.org>
 <CADSE00+MYYeTto5CCROpynB2p+FjcCASp6azyxb2FVRm7VhBrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADSE00+MYYeTto5CCROpynB2p+FjcCASp6azyxb2FVRm7VhBrw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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





On Mon, Jul 17, 2023 at 01:42:02PM +0200, Albert Esteve wrote:
> Hi Michael,
> 
> True. It may be a good idea to impose a limit in the number of entries that can
> be added to the table.
> And fail to add new entries once it reaches the limit.
> 
> Not sure what would be a good limit though. For example, https://www.kernel.org
> /doc/html/v4.9/media/uapi/v4l/vidioc-reqbufs.html#c.v4l2_requestbuffers
> does not limit the number of buffers that can be allocated simultaneously, it
> is an unsigned 32-bits value.
> However, I guess 16-bits (65535) would suffice to cover the vast majority of
> usecases. Or even lower, and
> can be adjusted later, as this API gets (more) used.
> 
> Does that make sense?
> 
> Thanks.
> BR,
> Albert

let's not top-post please.

Maybe. Another concern is qemu running out of FDs with a bad backend.

Question: why does qemu have to maintain these UUIDs in its memory?

Can't it query the backend with UUID and get the fd back?

And then, the hash table in QEMU becomes just a cache
to speed up lookups.

-- 
MST


