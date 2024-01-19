Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8C683286C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:11:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQmlS-0004hi-Hv; Fri, 19 Jan 2024 06:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQmlP-0004hX-Sf
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:10:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQmlN-0001r5-Me
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:10:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705662615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6x/Su8UXq1Xm5AT7kvsKBE7DXU/qb4LYQZcDTzHoq8o=;
 b=T91aIibxFq16Y1iEU05nRuunDIVQtf+OQle8FFNYmM1VC8/2ZTsn1KQdTj8yqxgmi8upZR
 FKpIMFp7uQGDGZcI+S3clnEsbRnyrB2BkiTNbbZ91JtywVtVQBN1akOg0E+OWt/iXtMmWX
 bBwVK/HUF7ByeS+o0m06z++TMo5XSjw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-PdVRsbOqO--ijOk_i9MEaA-1; Fri, 19 Jan 2024 06:10:12 -0500
X-MC-Unique: PdVRsbOqO--ijOk_i9MEaA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1d5a4416df4so985845ad.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705662611; x=1706267411;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6x/Su8UXq1Xm5AT7kvsKBE7DXU/qb4LYQZcDTzHoq8o=;
 b=CFurPzKfWifNUEwSqu/pRlv8Sh8C0xu8xkWoaWrJSL1AS5VtUaFPSh6InOK2nLtWL9
 5kCqKfZjG5mpYaa7xaI0AwiXWLXoZEsdB5LH8lFXL+4Ovkdc4AxE1oBCRVYvH4TT2H+G
 dmYPewF7oEbqOD8DsegqgECZcOPIAC3sB6upqTmXYFLq9XTKg2Spm+1S4V01fDGkH5mv
 UoM5jEwZQBxN12CYbXsVvQPTVQbneRP6KM+sTGXJCH5LsUOatzN48E30tzAgGSTdLOOQ
 562uDC7XOkgcuUpCgym2FfBIIIvghgBrVE6zheWpiDlXpI6/qrGroHG9WEK2J0iqC6p/
 elVw==
X-Gm-Message-State: AOJu0YwPuLAFJiAePgrvYBdKYoWw4PCpKVhA05/SB971z29yp0OsBMXO
 DI09JdviefDVKZfpFUAMBNtOAmqsvXgfOdiKvRBEho9y/uDeBNRGWBMBFJh/0Yq1w90kegP2Y7h
 HalvSlASxBZ32adR5Gr9pe1AyYBGHzN2AB1no4GAggaTUgrtAqTfy
X-Received: by 2002:a17:902:ea8b:b0:1d6:f13b:e58e with SMTP id
 x11-20020a170902ea8b00b001d6f13be58emr2181051plb.2.1705662611253; 
 Fri, 19 Jan 2024 03:10:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH44E7eE2N6ktaahnEjaHT/Iqd28/J16s56BsijZPL37ax7BSpcKxI+ftUBBMhU/YDpkA6P4Q==
X-Received: by 2002:a17:902:ea8b:b0:1d6:f13b:e58e with SMTP id
 x11-20020a170902ea8b00b001d6f13be58emr2181032plb.2.1705662610914; 
 Fri, 19 Jan 2024 03:10:10 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 i18-20020a17090332d200b001d54c4184ccsm2796860plr.182.2024.01.19.03.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 03:10:10 -0800 (PST)
Date: Fri, 19 Jan 2024 19:10:02 +0800
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 2/4] reset: Allow multiple stages of system resets
Message-ID: <ZapYii9nr5Tj9ClE@x1n>
References: <20240117091559.144730-1-peterx@redhat.com>
 <20240117091559.144730-3-peterx@redhat.com>
 <CAFEAcA-n3pu6YEaohm_7Wj8yO+oxYB2b6u+T1Jq6Pmi70wU4bg@mail.gmail.com>
 <e9a43ce9-2e2d-4f5e-a3f2-98c958285895@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9a43ce9-2e2d-4f5e-a3f2-98c958285895@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

Hello, Phil, PeterM,

On Thu, Jan 18, 2024 at 04:53:42PM +0100, Philippe Mathieu-Daudé wrote:
> I concur. Devices reset is hard, but bus reset is even harder.
> Having a quick look, the issues tracked by Alex & Peter might
> come from the PCI bridges using the legacy DeviceReset. 

The challenges we're facing with VFIO on vIOMMU are actually listed in
patch 4's large comment I added, here:

https://lore.kernel.org/qemu-devel/20240117091559.144730-5-peterx@redhat.com/

+    /*
+     * vIOMMU reset may require proper ordering with other devices.  There
+     * are two complexities so that normal DeviceState.reset() may not
+     * work properly for vIOMMUs:
+     *
+     * (1) Device depth-first reset hierachy doesn't yet work for vIOMMUs
+     *     (reference: resettable_cold_reset_fn())
+     *
+     *     Currently, vIOMMU devices are created as normal '-device'
+     *     cmdlines.  It means in many ways it has the same attributes with
+     *     most of the rest devices, even if the rest devices should
+     *     logically be under control of the vIOMMU unit.
+     *
+     *     One side effect of it is vIOMMU devices will be currently put
+     *     randomly under qdev tree hierarchy, which is the source of
+     *     device reset ordering in current QEMU (depth-first traversal).
+     *     It means vIOMMU now can be reset before some devices.  For fully
+     *     emulated devices that's not a problem, because the traversal
+     *     holds BQL for the whole process.  However it is a problem if DMA
+     *     can happen without BQL, like VFIO, vDPA or remote device process.
+     *
+     *     TODO: one ideal solution can be that we make vIOMMU the parent
+     *     of the whole pci host bridge.  Hence vIOMMU can be reset after
+     *     all the devices are reset and quiesced.
+     *
+     * (2) Some devices register its own reset functions
+     *
+     *     Even if above issue solved, if devices register its own reset
+     *     functions for some reason via QEMU reset hooks, vIOMMU can still
+     *     be reset before the device. One example is vfio_reset_handler()
+     *     where FLR is not supported on the device.
+     *
+     *     TODO: merge relevant reset functions into the device tree reset
+     *     framework.
+     *
+     * Neither of the above TODO may be trivial.  To make it work for now,
+     * leverage reset stages and reset vIOMMU always at latter stage of the
+     * default.  It means it needs to be reset after at least:
+     *
+     *   - resettable_cold_reset_fn(): machine qdev tree reset
+     *   - vfio_reset_handler():       VFIO reset for !FLR
+     */

What you're asking makes sense to me, because that's also what I would
prefer to consider (and that's why I mentioned my series "slightly ugly" in
the cover letter), even if I don't yet know much on the other reset
challenges QEMU is already facing.

The issue is just like what I mentioned in the cover letter: that complete
solution can be non-trivial and can take a lot of time, and I probably
wouldn't have time at least recently to persue such a solution.

To fix the issue cleanly, I assume we need to start from making sure all
VFIO paths will only use the Resettable interface to reset.

The second part will involve moving vIOMMU device in the QOM tree to be the
parent of whatever it manages.  I didn't follow recent changes in this
area, but currently vIOMMU is probably an anonymous object dangling
somewhere and more or less orphaned, while "-device" is the interface for
now to create the vIOMMU which might be too generic.  I'm not sure whether
we'll need new interface already to create the vIOMMU, e.g., it may ideally
need to be the parent of the root pci bus that it manages, one or multiple.
And we need to make sure the vIOMMU being present when the root pci buses
are created, I think.  IIUC that can be before parsing "-device"s.

For the 2nd issue, I assume the ->hold() phase for VT-d to reset address
spaces might be good enough, as long as the reset is done depth-first, then
VFIO's ->hold()s will be called before that point.  I consider after all
devices' ->hold() kicked off there should have no DMA anymore, so quit()
shouldn't hopefully matter.

However even if hold() works it is still challenging for the hierachy
change.

Considering that this issue so far shouldn't cause any functional breakage,
maybe one option is we gradually fix all above, and before that we declare
it a known issue.

Any other suggestions would also be greatly welcomed.

Thanks,

-- 
Peter Xu


