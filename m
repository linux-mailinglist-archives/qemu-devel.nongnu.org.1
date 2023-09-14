Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC43B7A0C21
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:00:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgqc3-0003Ju-Hm; Thu, 14 Sep 2023 13:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgqc1-0003JL-Ji
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgqbz-0002Dg-DU
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694714322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/Omk7Ni+qBeGd+i5XKCDqwQQWbpXDsCe9OBzkcgD8LA=;
 b=hS3enm9jDY3cS7jzoSKaaOZxGb7DBSAbsjdnz32IrEpL7ELT9OTbIF8Q7yW+CZsCtR0r8h
 wwCikr8hl+bKaXS9oAv58eI1PZS9ARw3XfBsP6FZlT5QfjqR+AmWPH6TGEkeo/wrf6a0lW
 IbZexRF03UZvytmnp+i6RAHSCgtOQ0c=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-MFyuALoJNcq6CLIjWSGOOg-1; Thu, 14 Sep 2023 13:58:41 -0400
X-MC-Unique: MFyuALoJNcq6CLIjWSGOOg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-655d8978597so14092246d6.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694714319; x=1695319119;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Omk7Ni+qBeGd+i5XKCDqwQQWbpXDsCe9OBzkcgD8LA=;
 b=Urhrd6vVXpmCXQPpyaA5ZPbd9QZe1kvBDHfAC8/3cCGeMcIun409peXrK08WXgLRB7
 loCrOU5IRei0abRYskirrifpKyUmT8p0RGmhwsLaWAYlXDi6eaJVQVHOUW0s6ItOQNBs
 LVIDeFVtMhp8lmrj/PAL5gdsC5g70vByUyDG0WN6aOB/BGohRRhhXgg+CSOtNAvF2V7M
 FS1UgshZJ6GjTCF31x8LdDplUqQqrrtfZG4pdlgZE+qYAffJbMkIRs8qehuFYWp3DxSr
 PrPHDKLyMt8I3A7ZPkKG2F33W0yeYCrVQDzeW74I6DelBFDpUm3zUgUb7aJtwmULQUrk
 461Q==
X-Gm-Message-State: AOJu0YyjwS8M/IUzh8Xe1zCuplrzfLc0jt2RLW2o/w3LW18rXmLTdNd+
 lqTlw+qL+hsB9rMcfGGNGDk8q/yv5/Y9pPKKX34llXBDEtUAXMIn+v3SIOUhTWxusmIKfw0ZeUe
 j5Iy6Jyf4mDaOVwAddvr6gQglLyv5U/r6Buzyn66h5IwWUpKpnibiZJm89E5F25r+7bDnXxN3HS
 Bhiw==
X-Received: by 2002:a0c:bf4a:0:b0:655:dc84:d74a with SMTP id
 b10-20020a0cbf4a000000b00655dc84d74amr5602326qvj.46.1694714319598; 
 Thu, 14 Sep 2023 10:58:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXVifnfH43cxw2PevCpeHRw77/2bPIEuAlKOv0AFp41RLtJJ8CUIV4Zfab0jCGzPo3IfZrVg==
X-Received: by 2002:a0c:bf4a:0:b0:655:dc84:d74a with SMTP id
 b10-20020a0cbf4a000000b00655dc84d74amr5602303qvj.46.1694714319302; 
 Thu, 14 Sep 2023 10:58:39 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a0cf0c1000000b0064733ac9a9dsm628489qvl.122.2023.09.14.10.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 10:58:38 -0700 (PDT)
From: Tyler Fanelli <tfanelli@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: [RFC PATCH 0/8] i386/sev: Use C API of Rust SEV library
Date: Thu, 14 Sep 2023 13:58:27 -0400
Message-Id: <20230914175835.382972-1-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tfanelli@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


