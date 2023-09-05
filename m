Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44775792F18
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 21:39:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdbsI-0007ia-Qn; Tue, 05 Sep 2023 15:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdbsH-0007iC-LB
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 15:38:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdbsF-0004ef-GT
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 15:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693942686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NKQyuRM+4RkiIB+5qBHJovWaDO/5YWkenjAcs+8la9s=;
 b=fq6YSc/c7fRnTobgd3+TlML4wpAAKr2ALv2hBXBxZAL8vi4RtWzs0uOzf2KiWRPKrzNFjq
 FMbrYtNgm4MYSQGMa9nog+wwBn07dwGyIbNUdqlgslEtrbcOquB5/zR2fbZjwbUnLuQjrz
 isEM+b79KDSuiTz3ZS1TklMVOQ+lJ9A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-4MrYkBPMMhKW6MRV8THTcg-1; Tue, 05 Sep 2023 15:38:05 -0400
X-MC-Unique: 4MrYkBPMMhKW6MRV8THTcg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6515b44388fso4321736d6.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 12:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693942684; x=1694547484;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NKQyuRM+4RkiIB+5qBHJovWaDO/5YWkenjAcs+8la9s=;
 b=ZIqS+U1hUXMJa7ttAXWdH9KBkQvKaXYerKQTDBNfmyCXUCsHZCRkwB4z1tD3gsYgG9
 8bbUl7y2jEmdSDnDzayLm5sKzGEmJ+lnBfE3p0PuYZLkzM9NckYFkmCMkviS7Qlt8e3B
 hpFP5WcORSDgt33kRPBn4lUPICoMtHW4Vhr64QR5f2LkYX2aLbIkjMkfEIVzR0Vk2Mq6
 nIL1euy8RKpzuCLU9X9q8eGrAqNrEcgOmRKjTFZB+3wCcF6Ks7GU98Fw5rBUgEUctqqk
 KR5Yvvk+o7WKCI6oZXHBt52HVaiT83/OzqJHCvDjjg2KKKyG/j4LO563HFITD15iDFV+
 qtvw==
X-Gm-Message-State: AOJu0Yzq+VWcrX80GEoanMLQSbsxX0O8tdHgoQFCNCucCN779LqpShFq
 ksMy2xQCMJBxcqcb3J0JRegZI0QGIgxlRGU4ENo+eqP5By15/6y6iia7VlS+QkQ5W+YGTjWRT9C
 mr5pb/MOcC7ij7eHWUEmG48LKt6UCx6lIHeJeaN9CP5drbaPbgrH3wAHo+c3B5HYgUmForrZx
X-Received: by 2002:a0c:eda4:0:b0:653:576d:1e4 with SMTP id
 h4-20020a0ceda4000000b00653576d01e4mr15577010qvr.1.1693942684424; 
 Tue, 05 Sep 2023 12:38:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHnJQKz5lsV0ULwZppw8hKHGMur1rfq1PTkpbDScPqZOj/8lsFIa/ww25omnYd/hBFEQV54w==
X-Received: by 2002:a0c:eda4:0:b0:653:576d:1e4 with SMTP id
 h4-20020a0ceda4000000b00653576d01e4mr15576973qvr.1.1693942684038; 
 Tue, 05 Sep 2023 12:38:04 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a05620a074200b007676f3859fasm4332780qki.30.2023.09.05.12.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 12:38:03 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>,
 Chensheng Dong <chdong@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, Fabiano Rosas <farosas@suse.de>,
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, lei4.wang@intel.com
Subject: [PATCH v3 0/1] migration: Add avail-switchover-bandwidth parameter
Date: Tue,  5 Sep 2023 15:38:01 -0400
Message-ID: <20230905193802.250440-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

This single-patch series is based on:

[PATCH v3 0/4] qapi/migration: Dedup migration parameter objects and fix tls-authz crash
Based-on: <20230905162335.235619-1-peterx@redhat.com>

I still added a cover letter to make sure the "Based-on" will be parsed all
right for e.g. patchew.

v3:
- Rebased to above patchset, dropped the 1st patch
- Renamed the parameter from "max-switchover-bandwidth" to
  "avail-switchover-bandwidth"
- Fixed calculation [Joao]

For more information on the new parameter and why we need it, please read
commit message in the patch.

Please have a look, thanks.

Peter Xu (1):
  migration: Allow user to specify available switchover bandwidth

 qapi/migration.json            | 11 +++++++++++
 migration/migration.h          |  2 +-
 migration/options.h            |  2 ++
 migration/migration-hmp-cmds.c | 14 ++++++++++++++
 migration/migration.c          | 24 +++++++++++++++++++++---
 migration/options.c            | 25 +++++++++++++++++++++++++
 migration/trace-events         |  2 +-
 7 files changed, 75 insertions(+), 5 deletions(-)

-- 
2.41.0


