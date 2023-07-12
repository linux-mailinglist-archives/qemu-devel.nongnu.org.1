Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD2C7509DD
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 15:45:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJa8W-0002Wi-H7; Wed, 12 Jul 2023 09:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJa8U-0002W2-Qw
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 09:44:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJa8T-0002Z5-DF
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 09:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689169444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=96wEyYN0Z+b6OClospyJHM1Fg47fqANd/PtPhNav49g=;
 b=Xg8pnwGDv5zbZqaYz3ZUv2HKz06ic8PSPcpPqfxceVuisKkK7udbgmmUMGBL4uoRFtFEjo
 VXy2diwk5QtWofq2/bVshJ8IbnJoXgMxxPls1uky4EKhj3BoYha5hvZO/OswPpFAbn26gP
 NGHj9fdEY4evaWAggGHd6k2YL73d01w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-p1z5Uas3Nk6T6PtXnTerbw-1; Wed, 12 Jul 2023 09:44:03 -0400
X-MC-Unique: p1z5Uas3Nk6T6PtXnTerbw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-98df34aa83aso99610966b.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 06:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689169440; x=1691761440;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=96wEyYN0Z+b6OClospyJHM1Fg47fqANd/PtPhNav49g=;
 b=gRMsKzUaG/sKrctH49SUTwKoldrX5uWJC+jdI4fLbshTpHqtatMcwSW35Z4aFiLqVq
 7Tu4GE4Nm97qZONTw/ojayBIFbKTaO1DvbJaIAjcPjv1jl0DOXILMaWWu5VyjBkDhhfx
 MK5uNrmnF/0o8lxPsuyiMb9ihj1MsCJcg3TNF2o91FexDzy7IAZ9v2Vvbd0CBs8+DbAr
 EqqyJYyZYfWOiJQu5DKdi7GaFzacCxJOLTFwldDJr87K6jskxXBE5Uo82YfEC87gdihs
 Badez8UvzHrau10Y7pbOm4sq7k9+E/Rgml4rz2WwxleyKS583pghcV2I0qdAVg1EzEjN
 2F0g==
X-Gm-Message-State: ABy/qLYB672/tCi/XWjDLlIMv++1EZkVjloAf+hwKI2Jpk5gBYm/4uV2
 VKmNl3ky6wg28+SaP6OKPOw04hVPVqaQdZdGN+eCnvsK7QL2LaikBs/o+BXxOichHqvpVmqlI7H
 uv4GGDhKj7HK5LLvmMbdzI7kU0QMi2JW2duOhI94APkj6SqZ/GdXVZzX142k/eh2I1oeN1nksVk
 k=
X-Received: by 2002:aa7:cd78:0:b0:51d:a2d9:85a3 with SMTP id
 ca24-20020aa7cd78000000b0051da2d985a3mr2756888edb.8.1689169440150; 
 Wed, 12 Jul 2023 06:44:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFusmewubVW+X9ASozBBkYIXuVJ2bdDG/81D10TQJLI8nd2TdGm4tahHAMdinzEFExRM068gw==
X-Received: by 2002:aa7:cd78:0:b0:51d:a2d9:85a3 with SMTP id
 ca24-20020aa7cd78000000b0051da2d985a3mr2756851edb.8.1689169439600; 
 Wed, 12 Jul 2023 06:43:59 -0700 (PDT)
Received: from localhost.localdomain
 (host-82-53-134-6.retail.telecomitalia.it. [82.53.134.6])
 by smtp.gmail.com with ESMTPSA id
 l16-20020a056402125000b0051a4c1dc813sm2781845edw.82.2023.07.12.06.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 06:43:58 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mike Christie <michael.christie@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, Fam Zheng <fam@euphon.net>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 0/3] scsi: fix issue with Linux guest and unit attention
Date: Wed, 12 Jul 2023 15:43:49 +0200
Message-ID: <20230712134352.118655-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

This series tries to fix a problem highlighted by the commit 8cc5583abe
("virtio-scsi: Send "REPORTED LUNS CHANGED" sense data upon disk hotplug
events").

We initially thought about reverting that commit, but now we have found
a pre-existing issue introduced by commit 1880ad4f4e ("virtio-scsi:
Batched prepare for cmd reqs"). More details in the discussion of the
reverting tentative [1].

Thanks to Thomas for identifying the commit that highlighted the problem
and providing an easy way to reproduce the issue, Stefan for his useful
comments, Mike for the scsi logs, and a big thanks to Paolo for his help
in preparing this series!

Stefano

[1] https://lore.kernel.org/qemu-devel/i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx/

Stefano Garzarella (3):
  scsi: fetch unit attention when creating the request
  scsi: cleanup scsi_clear_unit_attention()
  scsi: clear unit attention only for REPORT LUNS commands

 include/hw/scsi/scsi.h |  1 +
 hw/scsi/scsi-bus.c     | 78 ++++++++++++++++++++++--------------------
 2 files changed, 41 insertions(+), 38 deletions(-)

-- 
2.41.0


