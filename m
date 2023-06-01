Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6DD719B3C
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:53:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqN-0000JK-NA; Thu, 01 Jun 2023 07:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqK-0008Qq-J5
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqJ-0000H5-2u
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YXEe06JAbMDBS1nhj+Paz5uQgltlqJjEJ1VTJTPf4mU=;
 b=EF7ZQQtqZGliLBfr1Mu/q7zyVo86nvVJYjZmNcGga8Sh978ieGJlk07aQpuGfjMOp7SBpX
 nJYEAlVAup7c9PFvgOHASPeLNgRHymvtJ+pw7j/fTWaLDj8xQdIsU/S7m4iaFE5DzqstUd
 /b/JWup3uc6V1mBD05EA2A1gmU+qjbs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-Wo45SkzeMZqBooxzwOgE3g-1; Thu, 01 Jun 2023 07:51:42 -0400
X-MC-Unique: Wo45SkzeMZqBooxzwOgE3g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a341efd9aso56228866b.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620301; x=1688212301;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YXEe06JAbMDBS1nhj+Paz5uQgltlqJjEJ1VTJTPf4mU=;
 b=dQkXT87Tnj/EeQv5sdhgiPr2ewoYQdkJVyb4w6qfU/BuxHVZyh3QLNHgoL+B0dTMmj
 StQlrDVSvkWZCUVJuJZCbN7m8o8POKLQnvR/em25Ws4ta52J+e74d5vephvZIZJmaxab
 u6/nq4kG2dQgP/1Nz3QDJ2JUgBxLfrGujUkMwp93iEaDopd69jmpvoePGTc+17+X1V39
 uIN0j7navz1hyNnGsGCl3zXXkmoktBzxKFK18eM60rO94pfbu3api0uvKcb/gOdpl935
 BV5mLHoOwYLN4m2qybjTOABZhF5Q8TgG8dUTf+NOoeOAGfDzlEWZ0nViUJICIDp8GErU
 uYww==
X-Gm-Message-State: AC+VfDz5amI2jPE8S8smn4QIolYEuWzfFA1ZNdvB81uQVTfeoHuHPxn/
 ZOCWYx9YFh3zMofYN0r/dv8ktej1kU9i4kVLBMZp1WrIHvsroQ8q4JYRIekXe65sRuIMlyaQewB
 4sz92lujNMmv4MrtNwGfj05vy9ixOCu5onhnRE1h+hDK54LhOYp7cCUI+JSc9iIQbArsdFWeZMc
 E=
X-Received: by 2002:a17:907:86ab:b0:966:37b2:7354 with SMTP id
 qa43-20020a17090786ab00b0096637b27354mr2689296ejc.31.1685620301003; 
 Thu, 01 Jun 2023 04:51:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5FJw7mCwVXbGQEYepAD2czc/3GVYSQ+71VC3JaI167Z/a05HFdZ15FOwZtQ1c4KkgCckUrQQ==
X-Received: by 2002:a17:907:86ab:b0:966:37b2:7354 with SMTP id
 qa43-20020a17090786ab00b0096637b27354mr2689280ejc.31.1685620300759; 
 Thu, 01 Jun 2023 04:51:40 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 br7-20020a170906d14700b00965b5540ad7sm10603299ejb.17.2023.06.01.04.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:51:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH v2 0/3] block: remove separate bdrv_file_open callback
Date: Thu,  1 Jun 2023 13:51:36 +0200
Message-Id: <20230601115139.196369-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The value of the bdrv_file_open is sometimes checked to distinguish
protocol and format drivers, but apart from that there is no difference
between bdrv_file_open and bdrv_open.

However, they can all be distinguished by the non-NULL .protocol_name
member.  Change the checks to use .protocol_name instead of .bdrv_file_open,
and unify the two callbacks.

Paolo

v1->v2: fix bisectability

Paolo Bonzini (3):
  block: make assertion more generic
  block: do not check bdrv_file_open
  block: remove separate bdrv_file_open callback

 block.c                          | 17 +++++++----------
 block/blkdebug.c                 |  2 +-
 block/blkio.c                    |  2 +-
 block/blkverify.c                |  2 +-
 block/curl.c                     |  8 ++++----
 block/file-posix.c               |  8 ++++----
 block/file-win32.c               |  4 ++--
 block/gluster.c                  |  8 ++++----
 block/iscsi.c                    |  4 ++--
 block/nbd.c                      |  6 +++---
 block/nfs.c                      |  2 +-
 block/null.c                     |  4 ++--
 block/nvme.c                     |  2 +-
 block/rbd.c                      |  3 ++-
 block/ssh.c                      |  2 +-
 block/vvfat.c                    |  2 +-
 include/block/block_int-common.h |  3 ---
 17 files changed, 37 insertions(+), 42 deletions(-)

-- 
2.40.1


