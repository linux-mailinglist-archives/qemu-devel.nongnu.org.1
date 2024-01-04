Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3402824A92
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 23:00:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLVjM-0001YZ-Ud; Thu, 04 Jan 2024 16:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rLVjL-0001YC-4B
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:58:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rLVjJ-0003Nh-8D
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704405498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+bvkJvRFOuRXzCjwYpeg2JcWtHJGvaxxeGkWut+lc4g=;
 b=VPy+NrqmB5Iu+2lAVA4wZ4W6msoTUhvxvpyyW/0FzySMrsijffugPWP6lUIcbIWQu7T6z2
 8k663ZnPv7oRlKc3MTL+WwlMdNqzUYp8EwTa0tLecIj+9PlqieY7gK/MH41p+4PPX1iF9O
 BJIm75maJiID8JG0gyQlwaan559bm3g=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-hwcg7aN6OsiU4EFh6hO8Pw-1; Thu, 04 Jan 2024 16:58:17 -0500
X-MC-Unique: hwcg7aN6OsiU4EFh6hO8Pw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50e7d1cf532so825238e87.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 13:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704405495; x=1705010295;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+bvkJvRFOuRXzCjwYpeg2JcWtHJGvaxxeGkWut+lc4g=;
 b=v44oIAn6tt4bofzlpVEUmMebrekbP1Yaup8QQTs58tmxvcLP2w8al9ZHfOjGaSMkfh
 w8NSBpfejBjkBUFve4USYILJqIvsmWY4m5pV97KUkAgloCWyKuoFqnLqIEtQpTod5LV5
 ZvQHhx4Cvauj61kDn8FliqRjmtOcnxyd6KbmB6usl2mv8VZUxp8Q0fbWe222GLr1Vtfv
 qZeQLTRCA6YPuN12owGO/nIoCCsMH54ewjwhqpQpNbvrHl4+9BU4tZYVpayu+Yc6PvCz
 LKgn79PmvsF5zwDvO2BvHDKyNXNbO5kWifYq+Z0T6qhzCUkDzae6GfnQR9tlOyZ4IVFK
 TYMQ==
X-Gm-Message-State: AOJu0Yx7vopTEqpSCNSfm49XYiY/s3j5SG2eoBHxmENmfSxl+0WOE3FA
 evr82aLq3n8FStf45bNm2beIyYku0bCj4uqldC+6hxCk3D0YVFpLYD0N2zGeLVUCGxBjUIdNsCM
 JpJSd3/J1R3xoqOpVaigUogLxadlJyXRGLswN/kJlBt8IjTbFR5folO8aBWbUSDTNd8wUOMXSXD
 ff8MbA568=
X-Received: by 2002:a19:6d18:0:b0:50e:7c9b:85da with SMTP id
 i24-20020a196d18000000b0050e7c9b85damr735919lfc.76.1704405495255; 
 Thu, 04 Jan 2024 13:58:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJQoVbi32bLOkmIyvVQ0/kCKajTQGmntsXpFW+PNfCjpsKriDXLfTXLB87vFTQc37oRAI7Rw==
X-Received: by 2002:a19:6d18:0:b0:50e:7c9b:85da with SMTP id
 i24-20020a196d18000000b0050e7c9b85damr735915lfc.76.1704405494843; 
 Thu, 04 Jan 2024 13:58:14 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 x18-20020a170906441200b00a269fdda581sm112304ejo.74.2024.01.04.13.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:58:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH v2 0/8] vga: improve emulation fidelity
Date: Thu,  4 Jan 2024 22:58:03 +0100
Message-ID: <20240104215813.156153-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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

v1->v2: redone patch 1 [inspired by Zoltan]
        cosmetic changes to patches 3 and 8

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


