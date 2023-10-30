Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA317DBDFC
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 17:34:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxVDG-0003Yg-HV; Mon, 30 Oct 2023 12:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxVDE-0003YA-BE
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxVDC-0002eC-7Z
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698683637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NZjJimosDP92/dLcu1e04G6p242rV/RaawNNVQEkI1k=;
 b=MM01MOzitQifxifDwRNsPP07P4nl89vMF2nV1F9s0c6AV6jS+IJpBLsjPOF2XX/iLGBUMv
 2qmSBtIw+bZWQLUi+oXjk/xF2MNa2mXLbbyS+hl/jZEJcA0ipkrsVbFYDlxGUU72ZbjCm7
 H4a5nrODjkHgnX1Nvt8H2cCJswS8ou8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-29OcpRV6PAimq0KfLy3OQA-1; Mon, 30 Oct 2023 12:33:55 -0400
X-MC-Unique: 29OcpRV6PAimq0KfLy3OQA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-41e1899175eso11347631cf.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 09:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698683635; x=1699288435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NZjJimosDP92/dLcu1e04G6p242rV/RaawNNVQEkI1k=;
 b=Diy7mK1hTTpUWsnbZCbbYbcHFOxSKG9MUd43VmkxWgEvfhTM8XofyKborAHWEXwpzS
 27kWdl/Bez05k+IoF6OvIBQdS6SMyTfjlsUjiO/ImaNYAcKuDT3wp45pJtHS43DQPgAc
 2oOFCcRFU1BU2pK0kGbtuIfSGMLZqDUvvMh2FAr01qLDrc+x5ULg1CLn6bA9MXEz1ZMt
 zzsqQWnrlY08aQd2DitbB8hQeU2AdgY5+Z/DWBqUWa/N2cSJ4mn7MOJWAmGlJXMX4j/7
 +bmQvUAEmX+SeVSG47FPmHtbK9hC3RGJsecJiuIfGUql0sRmCZXTzvfmF6x8RpHyCy5p
 t2dA==
X-Gm-Message-State: AOJu0YypJPwCgDHkNYdINI0sFXOF9Furjfugp7UrxnqDfP+EMB/9DsVW
 ePK6RV1hLf7Cp7PA43oloGVYq5BFikmAU1YiguiGgFN0YJzy4SRrhRQf4TNTySqwkpkUK0UYLBh
 igy32Aw8WwA10Ev70Wr2t4uhjzl9tAuL2kongxy0rptq40qv88O6LT8M1P6uBSc7LXEgZXpL6
X-Received: by 2002:a05:622a:2ca:b0:417:b509:bcec with SMTP id
 a10-20020a05622a02ca00b00417b509bcecmr12307438qtx.2.1698683635217; 
 Mon, 30 Oct 2023 09:33:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXJy0zXgnxPEEqzzFaeheFOhX+f4CXXVZ86iRAt5QeGsNB3p6yFEEF5WEnd5sx5NgANq8NKQ==
X-Received: by 2002:a05:622a:2ca:b0:417:b509:bcec with SMTP id
 a10-20020a05622a02ca00b00417b509bcecmr12307408qtx.2.1698683634806; 
 Mon, 30 Oct 2023 09:33:54 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 l15-20020ac84ccf000000b004198ae7f841sm3531111qtv.90.2023.10.30.09.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 09:33:54 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v2 0/5] migration: Downtime tracepoints
Date: Mon, 30 Oct 2023 12:33:41 -0400
Message-ID: <20231030163346.765724-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

v2:
- Added two more patches (patch 4&5) to add the checkpoints too, it means
  it merges Joao's series into tracepoints, and extend that to dest QEMU.
  - Patch 5: Prefixed checkpoints with "src-" and "dst-"

This small series wants to improve ability of QEMU downtime analysis
similarly to what Joao used to propose here:

  https://lore.kernel.org/r/20230926161841.98464-1-joao.m.martins@oracle.com

But with a few enhancements:

  - Nothing exported yet to qapi, all tracepoints so far

  - Besides major checkpoints, finer granule by providing downtime
    measurements for each vmstate (I made microsecond to be the unit to be
    accurate) alongside.

  - Trace dest QEMU too for either the checkpoints or vmsd load()s

For the last bullet: consider the case where a device save() can be super
fast, while load() can actually be super slow.  Both of them will
contribute to the ultimate downtime, but not a simple addition: when src
QEMU is save()ing on device1, dst QEMU can logically be load()ing on
device2.  So they can run in parallel.  However the only way to figure all
components of the downtime is to record both.

Please have a look, thanks.

Peter Xu (5):
  migration: Set downtime_start even for postcopy
  migration: Add migration_downtime_start|end() helpers
  migration: Add per vmstate downtime tracepoints
  migration: migration_stop_vm() helper
  migration: Add tracepoints for downtime checkpoints

 migration/migration.h  |  2 ++
 migration/migration.c  | 63 +++++++++++++++++++++++++++++++-----------
 migration/savevm.c     | 63 ++++++++++++++++++++++++++++++++++++------
 migration/trace-events |  4 ++-
 4 files changed, 106 insertions(+), 26 deletions(-)

-- 
2.41.0


