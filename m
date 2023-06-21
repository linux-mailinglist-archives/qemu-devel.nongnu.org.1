Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B9873864B
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:09:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByVU-0006qt-PG; Wed, 21 Jun 2023 10:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qByVJ-0006pe-Rh
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qByVI-0000Jr-F3
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687356491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1C+e5eI26bMmbj0Hf94jZuKoU/a9xfUQt6Pv8fmsqqU=;
 b=OjaNw6usvGmn6F+2gwXg0EeuW+u+sdP5bEQIR6KRR9Ly1QoTTAxJ7bxoe+uTel2DBwu0FP
 w3ANHYNkmMVkqkbM0NhNFk1ityM/4SMDETtRzv6jtipJF8Yzx2vxJYR+oAyeeC9hiOOqtg
 Z8OLZyom9ot2OeV+2pDxL12WXESExzM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-PMX0NfTwMfyJlfR5pkdv1A-1; Wed, 21 Jun 2023 10:08:02 -0400
X-MC-Unique: PMX0NfTwMfyJlfR5pkdv1A-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5343c1d114cso4600378a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 07:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687356461; x=1689948461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1C+e5eI26bMmbj0Hf94jZuKoU/a9xfUQt6Pv8fmsqqU=;
 b=QJZGcc2MoPuBTHCrDhSmi0G5HgXNtZqWeSfOA1Xb0sn5Hho8EIqBfBtkbEGxiHFds5
 TP1oFZ3CjuPNjKsYNtKXK0UCH6O2F4SdiRJqxHf7M+2RoIZodRmxzDI+vLo4xgLGAncJ
 i1hag03Fn+iRPzY96wj9cP6MROVG9mOwSMLDRIO49HbS3DZZM5FjpkyVzN3Pv3UvR6P/
 7OPdC6KJ1SZmgsRrYDh/hrFVckZJJVy3SvJhdy0FCRK2fhPKquwYWp3luFIMglGacMuL
 NG21qwTM1O4HnZ1K8Y0qOWQWLTe/1SBn40EgqNO4JiT0NHq6+u30CuXSgTbzgoX9STKC
 M8Kw==
X-Gm-Message-State: AC+VfDwm4alvgkwefLTubSRfA5z2vWktHpHf/XT8SPDbB1IR+aqhzf3i
 MUM/gvYg3igOxP6AphZ5XtlyWIBPmCNAoeIfekk6HHivmZ0bfqqD7aOLveTcl+0n+YnD/Oli0jF
 8pXaMHosT8JW0bGM=
X-Received: by 2002:a17:902:dad0:b0:1b6:8b70:328f with SMTP id
 q16-20020a170902dad000b001b68b70328fmr4969878plx.6.1687356461404; 
 Wed, 21 Jun 2023 07:07:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7L1KcHZqm24I4nzBNDCYtBOeiPqs37utwHdW77W/N+4dUKsxT+rEkeaO2aMQ68dpCKGeK7Ww==
X-Received: by 2002:a17:902:dad0:b0:1b6:8b70:328f with SMTP id
 q16-20020a170902dad000b001b68b70328fmr4969839plx.6.1687356460959; 
 Wed, 21 Jun 2023 07:07:40 -0700 (PDT)
Received: from localhost.localdomain ([115.96.199.101])
 by smtp.googlemail.com with ESMTPSA id
 y7-20020a17090322c700b001b4fee3ea25sm3502427plg.277.2023.06.21.07.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 07:07:40 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, mst@redhat.com, imammedo@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 0/3] fix bios-tables-test
Date: Wed, 21 Jun 2023 19:37:20 +0530
Message-Id: <20230621140723.462220-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fix test so that devices do not use non-zero slots on the pcie root
ports. PCIE ports only have one slot, so PCIE devices can only be
plugged into slot 0 on a PCIE port.

CC: mst@redhat.com
CC: imammedo@redhat.com
CC: qemu-devel@nongnu.org

Ani Sinha (3):
  tests/acpi: allow changes in DSDT.noacpihp table blob
  tests/acpi/bios-tables-test: use the correct slot number on
    pcie-root-port
  tests/acpi/bios-tables-test: update acpi blob q35/DSDT.noacpihp

 tests/data/acpi/q35/DSDT.noacpihp | Bin 8248 -> 8241 bytes
 tests/qtest/bios-tables-test.c    |   4 ++--
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.39.1


