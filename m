Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA44820AD2
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 10:40:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJsIb-0003bE-Bg; Sun, 31 Dec 2023 04:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJsIL-0003MY-2B
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:39:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJsI7-0001OC-EW
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 04:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704015570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1c96BjheazGo4YMKAvzbPpuQjCYDWNWgeWZsIAdMWSM=;
 b=UF7+6Y8n+QSZOTVkOojj2clNjE6W12T/S9k5K2s1yd1JXG/SAzvmrQeK0xmCsJGedAs8DS
 ePvB2Bx1EMEstYgK0lWnFfjGw448FOuXcvXBvEcJtQ5eBtXzH/vP29aR7LRCfnUrV67PU8
 ZaPBKh7KvpRykPYvdInqRGywD7nbL78=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-2iZEpps0M1uSTdANmftl7w-1; Sun, 31 Dec 2023 04:39:23 -0500
X-MC-Unique: 2iZEpps0M1uSTdANmftl7w-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3368698f0caso5836135f8f.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 01:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704015561; x=1704620361;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1c96BjheazGo4YMKAvzbPpuQjCYDWNWgeWZsIAdMWSM=;
 b=A3gt/o4DUkzlvNSfLvGprtujbI2qYDXMfhKDdCCxqcYl08NJ0w1wumRYv5pI3FBtJF
 mRFy3PvphTr8xTM7yO3/R6qNldnC5SjuqsA7j36Dc3EB0iXmPrwM9q/GvxFHpqwwHrRi
 Mom2+/shA3eEFkB9Ga4U60EgB9ZHTnQTBJd328dym/ciSodwf7OMFJqlnHi0OD930uAU
 sDYTDTXxUoDCTJ8LKHPeLmHe6rFdaxaLmbY7vUIPOGiIpXleVxdGYYd+6FNhkIBDyaiS
 3S4u5o3dByHOrg2vPetonvxRTi/+RtYdHPktth9SCneyzlw8fyqIP3BTb5+CzWTS/luc
 sfLw==
X-Gm-Message-State: AOJu0Yw3tIGR3rgipqu5k58iOi5v/NwOodRIOV/xpRbY3zUgkes0f5g5
 QkemSu0J2vj6s3mIL8PzwwYkj2M8jMIX8Slc2VvyMAjMmJA0aS288DS++gihTw/TYpsro044M/W
 sbbKKYAgp27MMXKBmxTpk4EXAVll1XDtiqwZPIcYC2QFho/ggTgwTB/0yA2J+zXCOHbCqWgD7el
 BSML35BNg=
X-Received: by 2002:a05:6000:904:b0:336:e1c0:755a with SMTP id
 cw4-20020a056000090400b00336e1c0755amr2351705wrb.216.1704015561138; 
 Sun, 31 Dec 2023 01:39:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGumbRKy6WR5P/xbUoWD1FefO9c3quyXPewHgLtcOG06QI58yZv/SGWy/YoY86588NWejYOLQ==
X-Received: by 2002:a05:6000:904:b0:336:e1c0:755a with SMTP id
 cw4-20020a056000090400b00336e1c0755amr2351700wrb.216.1704015560810; 
 Sun, 31 Dec 2023 01:39:20 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 y8-20020a056000108800b0033642a9a1eesm23148729wrw.21.2023.12.31.01.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 01:39:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: [PATCH 0/8] vga: improve emulation fidelity
Date: Sun, 31 Dec 2023 10:39:10 +0100
Message-ID: <20231231093918.239549-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
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

This implements horizontal pel panning, which is used by games such as
the Commander Keen series, and also reimplements word and odd/even modes
so that they work in graphics modes; this mostly fixes Jazz Jackrabbit's
graphics.

There are still some issues with Cirrus VGA, and also Keen expects the
display parameters to be latched in ways that I don't fully understand
and that seem to differ between Keen 1 (EGA) and 4 (VGA).  So there is
still a bit of tearing, but I have been sitting on these patches since
the Christmas holidays of 2014, so let's flush this first part.

Paolo

Paolo Bonzini (8):
  vga: remove unused macros
  vga: introduce VGADisplayParams
  vga: mask addresses in non-VESA modes to 256k
  vga: implement horizontal pel panning in graphics modes
  vga: optimize horizontal pel panning in 256-color modes
  vga: reindent memory access code
  vga: use latches in odd/even mode too
  vga: sort-of implement word and double-word access modes

 hw/display/cirrus_vga.c  |  28 +--
 hw/display/vga-helpers.h | 121 +++++++++---
 hw/display/vga.c         | 418 +++++++++++++++++++++------------------
 hw/display/vga_int.h     |  18 +-
 hw/display/vga_regs.h    |   4 +
 5 files changed, 347 insertions(+), 242 deletions(-)

-- 
2.43.0


