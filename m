Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCCB7FB2C5
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 08:32:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7sZ1-0002B1-Av; Tue, 28 Nov 2023 02:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r7sYy-0002As-GB
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 02:31:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r7sYv-0006yG-Uu
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 02:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701156673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KF5KHqjSCpq86mXYKTR3S/M5fPhDDijPQtAVFimFQUE=;
 b=hgq9CIOZE14qDRaZJzFiPBvYFPw0gfKnhcixxF2gJGQweXk7KJCYuoCzWnuIklDxTrciR3
 DSaRLhOw0RvrZ0wZA2nnqgq/qYJH5z0+Y8bqogCzV1vTk/AZdXwE0GboQhwhCvkBlQR3ZC
 XlL/LkdrAKfOmZ8SC0sfpOBgI87olXg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-dZdGfmGGNDaQqH5c8OUMBA-1; Tue, 28 Nov 2023 02:31:11 -0500
X-MC-Unique: dZdGfmGGNDaQqH5c8OUMBA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c9afe7337fso3205781fa.3
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 23:31:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701156670; x=1701761470;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KF5KHqjSCpq86mXYKTR3S/M5fPhDDijPQtAVFimFQUE=;
 b=mwKDdo7tF43AyEy46h91qhy6os7B0utsVh9msdq9VqX+zhMOLW+OZsz25ExcK0eEpg
 OJpU+6sPjDvKQ1oNQEUJc+OXdfVq20mjGle0UjLHcHXY3t0+MuZPFdkPgfPizgQdTFMY
 BYZuFbFJuikP+mEszJynnxEXpVqUGbOP83APA0tEuBGGu3BhCQTf8v76RjIvsxfLLv7X
 gu/39MUrYzkuvqcJHRr6IfbTg+MFc7HRu5zFK4tUrkACjP1s8cePgclE8Funob1sHFWX
 p0YIy+11t99AdPzfJb5wPlAZBKmqJAIQzNwwNSwv6CqUfzVvMbJ3i2rsWntQXDpEs1Jv
 2w1Q==
X-Gm-Message-State: AOJu0Yxx55sN7TXHCL+8a7Dt+5rDYYDcNyqegugcIh2x+plbn9sfA6lr
 Dw7rCo3ehGtTviQM60QnHqpX6eZ/4VHVSNq+nLKzsih627AqlsyO3DFeLwqDV8ayGYGIO0+ymkO
 E4dWCA5zcZTampU0=
X-Received: by 2002:a2e:b744:0:b0:2c9:a022:63da with SMTP id
 k4-20020a2eb744000000b002c9a02263damr4394174ljo.19.1701156670538; 
 Mon, 27 Nov 2023 23:31:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7W/T8pK5ROL69NjikBC7KmkpHDxfe8XtL+LFSGUFbpRdFl6f62PQA/YAXwiLN12vsXvS8Uw==
X-Received: by 2002:a2e:b744:0:b0:2c9:a022:63da with SMTP id
 k4-20020a2eb744000000b002c9a02263damr4394153ljo.19.1701156670116; 
 Mon, 27 Nov 2023 23:31:10 -0800 (PST)
Received: from redhat.com ([2a06:c701:73d3:9e00:54b2:c4e1:3f55:8d23])
 by smtp.gmail.com with ESMTPSA id
 i12-20020a05600c354c00b004060f0a0fd5sm16307142wmq.13.2023.11.27.23.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 23:31:09 -0800 (PST)
Date: Tue, 28 Nov 2023 02:31:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, linux-cxl@lore.kernel.org,
 qemu-devel@nongnu.org, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v1 0/2] A Fixup for "QEMU: CXL mailbox rework and
 features (Part 1)"
Message-ID: <20231128023052-mutt-send-email-mst@kernel.org>
References: <20231127105830.2104954-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127105830.2104954-1-42.hyeyoo@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Mon, Nov 27, 2023 at 07:58:28PM +0900, Hyeonggon Yoo wrote:
> Hi, this is a fixup for the recent patch series "QEMU: CXL mailbox rework and
> features (Part 1)" [1].


To clarify do you plan v2 of this?

> This fixes two problems:
> 
>    1. Media Status in memory device status register not being correctly
>       read as "Disabled" while sanitation is in progress.
> 
>    2. QEMU assertion failure when it issues an MSI-X interrupt
>       (indicating the completion of the sanitize command).
> 
> [1] https://lore.kernel.org/linux-cxl/20231023160806.13206-1-Jonathan.Cameron@huawei.com
> 
> Hyeonggon Yoo (2):
>   hw/cxl/device: read from register values in mdev_reg_read()
>   hw/mem/cxl_type3: allocate more vectors for MSI-X
> 
>  hw/cxl/cxl-device-utils.c   | 17 +++++++++++------
>  hw/mem/cxl_type3.c          |  2 +-
>  include/hw/cxl/cxl_device.h |  4 +++-
>  3 files changed, 15 insertions(+), 8 deletions(-)
> 
> -- 
> 2.39.1


