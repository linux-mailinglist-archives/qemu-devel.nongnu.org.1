Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF026710E15
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:17:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Bl5-0004cW-SC; Thu, 25 May 2023 10:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bkv-0004XX-9N
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bkt-0007bO-BT
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=736SfH3YIdCn6Y9xsP6/aOMOIdb4c0bbm/WlLngexMg=;
 b=KrN0y3f90Qt/EpZyXZfQ65mBf2GK/O2M3UnL3xU0+3rk4Ck4ZK2Sm9ds/i6PqKOJkSdleC
 cSysjWu13u8SoLu7ZHY5nh8O2NX8hIlCX6iatjhKVdmdTmuTu0b5RnsS/epSCz4cvbm0Kf
 NXz6PyP92F4jHfLZhL3ZPDmJKQIeFSI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-MlOLFhELMS65yHmvkbt5sA-1; Thu, 25 May 2023 10:15:47 -0400
X-MC-Unique: MlOLFhELMS65yHmvkbt5sA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-96f6944c529so68899166b.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024146; x=1687616146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=736SfH3YIdCn6Y9xsP6/aOMOIdb4c0bbm/WlLngexMg=;
 b=BrxTm77a4ZIhWUUgg7m7eUT3Qi5AvAJedaB+vzWB/a0C+iOmMwqu/znN3nnrnnQG0H
 3XJbsuyqU679uJGwnwjkOb7i88Ub2SCWMF+PyUwYAD+MMtd2jtv/5a9fCU81I9ojP3M/
 ILOMheIUmgPb5PImnpCotA/uovlA72zAotBNrDl0e2y/fQPj8evlXmvwxt5So5c14Vqc
 siFyK/qVSItC9eN8mE4K0XPbyYQwhO0cyooKcRYek+yMF+j6FyZ3WwEd4ip6EnlHhFIx
 TUVXhmhJA8FOAJKUYSLlDjgQr4E7HOAwcGjHEvQArtz0Y/nMyPYyGac7+ZLRq8J0Sewh
 gLSg==
X-Gm-Message-State: AC+VfDyYBgAzNRf4UIvQRoYBDIPuasDMroYFjYOXFccUTm7o3vyIOVl+
 6Lst2T2ayjmxJ1g/AE9uhYp6t2AfkkO1jXCGh23pnCTHv4E9LUGW9Co89PnDfV35LGzXi2urHDi
 /t9CzebUeHptWQPF/CuWeu7ACkazVzjQBkZSHFXXQoN3EQM9kPuA/F4YKSugSRxFR7y0YABjTm4
 U=
X-Received: by 2002:a17:907:5c2:b0:96f:ee6d:fed5 with SMTP id
 wg2-20020a17090705c200b0096fee6dfed5mr1672061ejb.72.1685024145821; 
 Thu, 25 May 2023 07:15:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5lcnqjgkkKwH9z5t9njcXBSqCI4wLqIZasdQpSr8q1oAHK149VIIwh9+fSDEjbN6GUehQMyg==
X-Received: by 2002:a17:907:5c2:b0:96f:ee6d:fed5 with SMTP id
 wg2-20020a17090705c200b0096fee6dfed5mr1672044ejb.72.1685024145554; 
 Thu, 25 May 2023 07:15:45 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a170906838d00b00965d4b2bd4csm910097ejx.141.2023.05.25.07.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:15:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ryan Wendland <wendland@live.com.au>
Subject: [PULL 08/20] usb/ohci: Set pad to 0 after frame update
Date: Thu, 25 May 2023 16:15:20 +0200
Message-Id: <20230525141532.295817-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525141532.295817-1-pbonzini@redhat.com>
References: <20230525141532.295817-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

When the OHCI controller's framenumber is incremented, HccaPad1 register
should be set to zero (Ref OHCI Spec 4.4)

ReactOS uses hccaPad1 to determine if the OHCI hardware is running,
consequently it fails this check in current qemu master.

Signed-off-by: Ryan Wendland <wendland@live.com.au>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1048
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/usb/hcd-ohci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 88d2b4b13c1d..cc5cde698328 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -1239,6 +1239,8 @@ static void ohci_frame_boundary(void *opaque)
     /* Increment frame number and take care of endianness. */
     ohci->frame_number = (ohci->frame_number + 1) & 0xffff;
     hcca.frame = cpu_to_le16(ohci->frame_number);
+    /* When the HC updates frame number, set pad to 0. Ref OHCI Spec 4.4.1*/
+    hcca.pad = 0;
 
     if (ohci->done_count == 0 && !(ohci->intr_status & OHCI_INTR_WD)) {
         if (!ohci->done) {
-- 
2.40.1


