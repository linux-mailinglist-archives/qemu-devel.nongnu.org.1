Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF307A0ED3
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:12:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsgM-0002Kp-IY; Thu, 14 Sep 2023 16:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgpKc-00059T-1K
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:36:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgpKY-0000g5-2S
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694709396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/Omk7Ni+qBeGd+i5XKCDqwQQWbpXDsCe9OBzkcgD8LA=;
 b=FjR9GyXVKuSziTMyZB7bVcDhU9BqrB4QNllogGt2rXb+UFXtABc+Yt+SEKjPUr0zDicaoB
 PrdslKieAq4apyN7+pbzrg/FQFTRis4WsJJuAXQUZINm7Sq+UVtX+y0fXpvZXs5kWH9scb
 mNmrRgWuIymXsn0U1AguwqamCZxH3pc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-I03DXLnGM3mjXDMfigI0tw-1; Thu, 14 Sep 2023 12:35:23 -0400
X-MC-Unique: I03DXLnGM3mjXDMfigI0tw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76ef50e2513so143470185a.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 09:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694709322; x=1695314122;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Omk7Ni+qBeGd+i5XKCDqwQQWbpXDsCe9OBzkcgD8LA=;
 b=MHMrTt6QUXqBrNUVp5oIWS1yX2e3S4OqUEAE3PDdM+Vy/s/qCL3aJ8+9fhRI1K+b+c
 hjS//Qt0p0sdx7MM3GmH08LssV/4Oymkb670r7vj4YHvhUIFjTd1PnSfKNMSEndGvxA2
 PfbQqBG1HyZvI3Xv8ZmHwBgNo/TWsgYqBbg2y1GisIEFMb0WjrGUJgSLtLCQZoTEr88Z
 iD7jktgWECMfZpjoruGre0u5l6rrjCiIbFIkvbht0tYJUtIFOj1ArqhOf7ATGcL5xFVr
 NDty85NJy5Of0UmI7K5jpvtxiRIccwxrK5J8ZbvnRlHoyMiQKOpAsLXnyOuSdzJjrqVe
 UTfw==
X-Gm-Message-State: AOJu0Yzxf1dOK/i0Q4FpdX4XuIW924DWolrkaSANc1tavtvspmzQOqI+
 2L+TiR6YWS+sELS4IWSOzbeFgnPV1dIfLbRWVynWcz1o+ad0oL31wO8C+PI7jfUnlb9oSL8oPHy
 oslfdYtUDW+DKi3RXsnzng/fzaSU5UK7WwXeLfHj3xCcz6gZb4zKOvBNs5gC7cVAguVwN3D/MMB
 gkUA==
X-Received: by 2002:a05:620a:4514:b0:76d:a89c:1e15 with SMTP id
 t20-20020a05620a451400b0076da89c1e15mr7682387qkp.59.1694709321935; 
 Thu, 14 Sep 2023 09:35:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZU9GMuvkdNtW/BC1aNJ2fI+p5xledm5O44JESz/ocki2kRHL8xbbLwGj9V3re6tcxFhxp2g==
X-Received: by 2002:a05:620a:4514:b0:76d:a89c:1e15 with SMTP id
 t20-20020a05620a451400b0076da89c1e15mr7682362qkp.59.1694709321658; 
 Thu, 14 Sep 2023 09:35:21 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 l11-20020ae9f00b000000b007677347e20asm577244qkg.129.2023.09.14.09.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:35:20 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH 0/8] i386/sev: Use C API of Rust SEV library
Date: Thu, 14 Sep 2023 12:33:51 -0400
Message-Id: <20230914163358.379957-1-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tfanelli@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 14 Sep 2023 16:11:08 -0400
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

These patches are submitted as an RFC mainly because I'm a relative
newcomer to QEMU with no knowledge of the community's views on
including Rust code, nor it's preference of using library APIs for
ioctls that were previously implemented in QEMU directly.

Recently, the Rust sev library [0] has introduced a C API to take
advantage of the library outside of Rust.

Should the inclusion of the library as a dependency be desired, it can
be extended further to include the firmware/platform ioctls, the
attestation report fetching, and more. This would result in much of
the AMD-SEV portion of QEMU being offloaded to the library.

This series looks to explore the possibility of using the library and
show a bit of what it would look like. I'm looking for comments
regarding if this feature is desired.

[0] https://github.com/virtee/sev

Tyler Fanelli (8):
  Add SEV Rust library as dependency with CONFIG_SEV
  i386/sev: Replace INIT and ES_INIT ioctls with sev library equivalents
  i386/sev: Replace LAUNCH_START ioctl with sev library equivalent
  i386/sev: Replace UPDATE_DATA ioctl with sev library equivalent
  i386/sev: Replace LAUNCH_UPDATE_VMSA ioctl with sev library equivalent
  i386/sev: Replace LAUNCH_MEASURE ioctl with sev library equivalent
  i386/sev: Replace LAUNCH_SECRET ioctl with sev library equivalent
  i386/sev: Replace LAUNCH_FINISH ioctl with sev library equivalent

 meson.build                   |   7 +
 meson_options.txt             |   2 +
 scripts/meson-buildoptions.sh |   3 +
 target/i386/meson.build       |   2 +-
 target/i386/sev.c             | 311 ++++++++++++----------------------
 target/i386/sev.h             |   4 +-
 target/i386/trace-events      |   1 +
 7 files changed, 123 insertions(+), 207 deletions(-)

-- 
2.40.1


