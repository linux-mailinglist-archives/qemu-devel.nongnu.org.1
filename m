Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F317E3821
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:50:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0IiH-00054f-EB; Tue, 07 Nov 2023 04:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0IiD-00053O-OD
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:49:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0Ii6-0006Tr-5R
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699350563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=etKiI/o/xZaWDyClRDnoI89QL9ZeIohjZV6zY1Yn5W8=;
 b=X46VMWC3Omj7pvQ+0xvzrTkamr6D8MPvyXTgLMMPYjIfQdXlW/xXFQwwt9qihbx4OuH7C6
 Dp2+hB6OohgSHKerQr9LttkfjxVWqlHgmvaIgHG4y7gY1ERxS5NJmAqXrhDw4N1UF+nKx+
 2wZ1drMNWwpjWt/JllVuAbNjEpfCrj4=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-xrL7q9eKOKyNu97K3U36GA-1; Tue, 07 Nov 2023 04:49:22 -0500
X-MC-Unique: xrL7q9eKOKyNu97K3U36GA-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-45d9208e742so1241788137.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 01:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699350561; x=1699955361;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=etKiI/o/xZaWDyClRDnoI89QL9ZeIohjZV6zY1Yn5W8=;
 b=DjH77f5lcXc6b+tdzUurkcCE+nFFK0zG6Wesga8e/t786dohsKjhbte/eU8p8cvhuB
 L2g3mgsMCZ+DtgZQpOFLl1FBNEkGeXg/HiNpbP3AapbXv0sLC/tk69bkbjgAMirpNoyX
 RBTrLpLpndkT4nu6KbuXsYkL/cREUoq88F7FLPpEYdL3Hxj6lLu8Vo9QGbwCCklcWz9k
 ir7bFNMHdmknV79fZepB410cwaRn/Syu2DqXJc0LU6jPR+vE0LaGX+zJR0dFNvF5wMj6
 ji8/52KPBtLNutbyr/gTyM9AftZtnsUQxvU2sfmOLd8t4MKeZ46iwDCqMnsqg+ksBVR6
 wLWA==
X-Gm-Message-State: AOJu0YyV7zWzdm6iRg45+fGpSa5r3501nYejBV0a9+X0yE4fO+BGNlrC
 UtPWlH5GDwUCCNsvo6+E88qjDMzpJhOoFgHJMhAXdAxBFl5btrNSntbkEGslrgAQ/CPclm94rFP
 15Sk9D+DdueaK33wS7BecTBJQl+741IphT8bj0huQHbpZfd+ynHoXUCWFie0OBeV+wwu6
X-Received: by 2002:a05:6102:2087:b0:45f:735d:abd with SMTP id
 h7-20020a056102208700b0045f735d0abdmr1358862vsr.23.1699350561160; 
 Tue, 07 Nov 2023 01:49:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCtM9/HNUCRnAblP4Jxus6+PppEOQ75KDRL3N1jbesWtX9ZOL+J6Klt+sdVtMPEbP04FM9PA==
X-Received: by 2002:a05:6102:2087:b0:45f:735d:abd with SMTP id
 h7-20020a056102208700b0045f735d0abdmr1358850vsr.23.1699350560846; 
 Tue, 07 Nov 2023 01:49:20 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 cp10-20020a05622a420a00b0041811e71890sm4206726qtb.33.2023.11.07.01.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 01:49:20 -0800 (PST)
Date: Tue, 7 Nov 2023 04:49:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PATCH RFC 0/2] dynamic timeout for tests
Message-ID: <cover.1699349799.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
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

so we keep making timeouts longer for CI but one has to stop
somewhere. netdev socket test recently failed for me again
even though it's at 2 minutes already.
here's an experiment for netdev-socket.
if this works well for a while we can generalize to other
tests.

Michael S. Tsirkin (2):
  osdep: add getloadavg
  netdev: set timeout depending on loadavg

 include/qemu/osdep.h        | 10 ++++++++++
 tests/qtest/netdev-socket.c | 28 +++++++++++++++++++++++++++-
 meson.build                 |  1 +
 3 files changed, 38 insertions(+), 1 deletion(-)

-- 
MST


