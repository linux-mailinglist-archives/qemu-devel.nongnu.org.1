Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6867D8651
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 17:54:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw2g7-0005qi-Fy; Thu, 26 Oct 2023 11:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw2g5-0005qZ-Po
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:53:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw2g4-0000s5-6f
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698335622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EubEjJYrW1JjPDOfUgKguHyI93IbKyXLpCXjzhLeAg8=;
 b=KBrkIkUeYo1wIB/uN+7Mmzu134C77FOpBsAsRZ36c95rAkPDF++J0jHxkgnYCvkkG9Ih6W
 S4IpjiOhmeOJzNvaSfIU+BoJfHtK1NkyLszEKbKTick6HH8HCZEbmD2dwdFlYemGBCSDzW
 VUFLqTleZXJCS8uyk4VPIPuwxOpmGpY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-B2J68L-BOOqrXGgw2X-tMw-1; Thu, 26 Oct 2023 11:53:41 -0400
X-MC-Unique: B2J68L-BOOqrXGgw2X-tMw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4197468d5caso2535681cf.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 08:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698335619; x=1698940419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EubEjJYrW1JjPDOfUgKguHyI93IbKyXLpCXjzhLeAg8=;
 b=McEcVsmBowZ2VZDfFm/tVwlIXCLIA008RZqi8Gblk1f+a7FWj3vrZDtG+VYmFgoID9
 AI679dayeKlX0tKjty7VdEZjawDpPPijnHUW9Rf2xvVte06rkZW/Y+7swRJYRsPOYSNg
 WLDhbLkvks0YtKEdK8Gt8/JJVbWDUltEEDtYpz71zTMMTCa0wLhFuWKIFQnSH5aElzbn
 acSfnC/Iam6gXf/+CiE6CNxJ9JJ3msIlJqO2zmG/XnMDCBZihx+j0nYFFCY0fkYAeCT8
 E8XSurP9f2/p8UTydFtpyB7HAF+3L1rDk7OGMM18Cld5Do155z63zsFGM2PpJf/E7VYl
 +4LA==
X-Gm-Message-State: AOJu0YwLIhMeAhA4/xg9J3UUHKvazbP9DSj1FRaxZn6JFxLBI18d1wwm
 DjSOIp2YDNkqzB5K3QrE2UDVn44LqoP19GlrP+z7yr8+WE4LNYlyvxtlKn1gp+HGJteoGnGdYld
 Cg+gFJoA6iN6T1cKwZS3kYeQSXlGQLvmcpwSKmqx5ePz4m2tbBiHIORqQmESP1QMk3uFiZJeR
X-Received: by 2002:ad4:5382:0:b0:651:675b:37f9 with SMTP id
 i2-20020ad45382000000b00651675b37f9mr24983qvv.1.1698335619489; 
 Thu, 26 Oct 2023 08:53:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlP0xaVmvA4BHsCkSeB+wqNig8Wz8Q14nz8NCgYz/GNoO1V0p4GojYB01rXaPTxkCfz00PsA==
X-Received: by 2002:ad4:5382:0:b0:651:675b:37f9 with SMTP id
 i2-20020ad45382000000b00651675b37f9mr24957qvv.1.1698335619063; 
 Thu, 26 Oct 2023 08:53:39 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 f15-20020ac840cf000000b004181f542bcbsm5066580qtm.11.2023.10.26.08.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 08:53:38 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH 0/3] migration: Downtime tracepoints
Date: Thu, 26 Oct 2023 11:53:34 -0400
Message-ID: <20231026155337.596281-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

This small series (actually only the last patch; first two are cleanups)
wants to improve ability of QEMU downtime analysis similarly to what Joao
used to propose here:

  https://lore.kernel.org/r/20230926161841.98464-1-joao.m.martins@oracle.com

But with a few differences:

  - Nothing exported yet to qapi, all tracepoints so far

  - Instead of major checkpoints (stop, iterable, non-iterable, resume-rp),
    finer granule by providing downtime measurements for each vmstate (I
    made microsecond to be the unit to be accurate).  So far it seems
    iterable / non-iterable is the core of the problem, and I want to nail
    it to per-device.

  - Trace dest QEMU too

For the last bullet: consider the case where a device save() can be super
fast, while load() can actually be super slow.  Both of them will
contribute to the ultimate downtime, but not a simple summary: when src
QEMU is save()ing on device1, dst QEMU can be load()ing on device2.  So
they can run in parallel.  However the only way to figure all components of
the downtime is to record both.

Please have a look, thanks.

Peter Xu (3):
  migration: Set downtime_start even for postcopy
  migration: Add migration_downtime_start|end() helpers
  migration: Add per vmstate downtime tracepoints

 migration/migration.c  | 38 +++++++++++++++++++++-----------
 migration/savevm.c     | 49 ++++++++++++++++++++++++++++++++++++++----
 migration/trace-events |  2 ++
 3 files changed, 72 insertions(+), 17 deletions(-)

-- 
2.41.0


