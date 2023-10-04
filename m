Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9527B8E21
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 22:36:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo8Zz-0004EM-D2; Wed, 04 Oct 2023 16:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qo8Zu-0004E3-BT
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qo8Zq-0001wz-Gb
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696451671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=i6JX7kyp/m4KYKNP3CRNGhDeNoZHavA7YSltoyWaCwo=;
 b=OLrePyshsbm7WzJOA5i5+NxBkv0wfl9gv5BDVmuLKKquOgvIC46/3Vl9tBZ4LzSUznladE
 oQZD2f0I9B5ooEAKe4tC2EGifQseHLvgLs1pn/RQ4wlU6UqvOnUgoLmW++mJk89ml4/brC
 MjM4Q/D71ibUcki31BOAkLQSk7p3Rxw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-fplQ6YTfPiWtpa_Y9hqvRw-1; Wed, 04 Oct 2023 16:34:30 -0400
X-MC-Unique: fplQ6YTfPiWtpa_Y9hqvRw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-668f04867deso2579046d6.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 13:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696451668; x=1697056468;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i6JX7kyp/m4KYKNP3CRNGhDeNoZHavA7YSltoyWaCwo=;
 b=wnlw4/BZMaywh2Rmwe6gVoI/2TvgtG25MC2yfAIYvd5YySEfTCdWSz6p6PwuiTbFQn
 o8UP5Y7Xv+1Jk5ZiwxvsZ4h17uhK2z6zjZ02Z6Tdks8cWlVuly+Mw6aPRy/8ThR8Y59G
 NNAYbtsQviHV38yoONhISRQvVtqjHz4J2gpNY3vgzaqcwz62kRhaJrbAE+JbXkHaqsV0
 sq8UeW/A1+vVKiHgnc+CCN/rRFserLZCWeHx7uC+7RoWYNmfbL3mzNUo5dNw6OKWjLsK
 H3GOFkApasLwu3yvOYaVh5ZFZnty0smNIlldLGma59c+vXtOxbv/itMtyDaMpYWc3kgp
 FbOQ==
X-Gm-Message-State: AOJu0YwBuHoH7V6pFgDmwr2sJWOLTElkBslJF/i0k3gd4YfzjlyKDYoR
 jl5EP8mQ5QmmsRvzI6Zbd9snQfWgdPaGK1Hzg2WjQ3P+JGGbNBq/ejqA672tBRnI/hGyfHKCv2H
 kIe08d+CpUjAkJUSNJXeDsIQoJ3t2kpNuTNzxpi81tGmTLrFXmiP65GscYBFnYTMsNUz5pLty7z
 LivA==
X-Received: by 2002:a0c:ec47:0:b0:65b:17e9:1c9d with SMTP id
 n7-20020a0cec47000000b0065b17e91c9dmr3306980qvq.52.1696451668710; 
 Wed, 04 Oct 2023 13:34:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmVI3PWbchd9k8gNEtqiwYJOQ5mGZI8KRVrWu4CgfdT0gQxe0fHw+LZ5v7j1GriiFtgsuiEg==
X-Received: by 2002:a0c:ec47:0:b0:65b:17e9:1c9d with SMTP id
 n7-20020a0cec47000000b0065b17e91c9dmr3306958qvq.52.1696451668399; 
 Wed, 04 Oct 2023 13:34:28 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 i19-20020a0cf393000000b00632209f7157sm1561387qvk.143.2023.10.04.13.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 13:34:27 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 philmd@linaro.org, berrange@redhat.com, marcandre.lureau@gmail.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH v2 0/9] i386/sev: Use C API of Rust SEV library
Date: Wed,  4 Oct 2023 16:34:09 -0400
Message-Id: <20231004203418.56508-1-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tfanelli@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These patches are submitted as an RFC mainly because I'm a relative
newcomer to QEMU with no knowledge of the community's views on
including Rust code, nor it's preference of using library APIs for
ioctls that were previously implemented in QEMU directly.

Recently, the Rust sev library [0] has introduced a C API to take
advantage of the library outside of Rust.

Should the inclusion of the library as a dependency be desired, it can
be extended further to include the firmware/platform ioctls and more.
This would result in much of the AMD-SEV portion of QEMU being offloaded
to the library.

This series looks to explore the possibility of using the library and
show a bit of what it would look like. I'm looking for comments
regarding if this feature is desired.

[0] https://github.com/virtee/sev

NOTE: The required meson changes in the Rust library are not merged yet.
Therefore, the git repository URL in subprojects/sev.wrap points to a
personal fork of the library (for testing purposes). The meson patches
for the library are required before these patches can be merged.

Changes since v1:
- Add sev Rust library as a QEMU subproject, rather than using
  pkg-config for linking
- Rebased to upstream/master
- Use C API for SEV_ATTESTATION_REPORT ioctl

Tyler Fanelli (9):
  Add Rust SEV library as subproject
  i386/sev: Replace INIT and ES_INIT ioctls with sev library equivalents
  i386/sev: Replace LAUNCH_START ioctl with sev library equivalent
  i386/sev: Replace UPDATE_DATA ioctl with sev library equivalent
  i386/sev: Replace LAUNCH_UPDATE_VMSA ioctl with sev library equivalent
  i386/sev: Replace LAUNCH_MEASURE ioctl with sev library equivalent
  i386/sev: Replace LAUNCH_SECRET ioctl with sev library equivalent
  i386/sev: Replace LAUNCH_FINISH ioctl with sev library equivalent
  i386/sev: Replace SEV_ATTESTATION_REPORT with sev library equivalent

 meson.build                   |   8 +
 meson_options.txt             |   2 +
 scripts/meson-buildoptions.sh |   3 +
 subprojects/sev.wrap          |   6 +
 target/i386/meson.build       |   2 +-
 target/i386/sev.c             | 392 +++++++++++-----------------------
 target/i386/sev.h             |   6 +-
 target/i386/trace-events      |   1 +
 8 files changed, 148 insertions(+), 272 deletions(-)
 create mode 100644 subprojects/sev.wrap

-- 
2.40.1


