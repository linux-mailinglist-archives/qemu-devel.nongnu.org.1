Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C12791573
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 12:04:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd6QS-00012O-0E; Mon, 04 Sep 2023 06:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qd6QN-0000ze-6H
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qd6QK-0007ok-GM
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693821791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=laLxD8wCfifMQG8O04LlQxeYErwgT18gxIxG+HtWi74=;
 b=TpXBgX+KzIDqjj+EGmSCso88dTu7v3oo9gB3cnGLCIiWYlCYGMy4yKlgzEODZfKqWSV1R5
 ktXtxMHMoKnNaLWhzfCOBBv6GDQtVAXSBtDXnDuAjKtdOksBIq9SJTjotXxz5IpFrjOj66
 RfMIDJPHY3FQ+d8jnc2ZNBaEUZn+w7Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-j9vh8BDcPnyvxGSEhMnDxg-1; Mon, 04 Sep 2023 06:03:10 -0400
X-MC-Unique: j9vh8BDcPnyvxGSEhMnDxg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31aed15ce6fso593349f8f.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 03:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693821788; x=1694426588;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=laLxD8wCfifMQG8O04LlQxeYErwgT18gxIxG+HtWi74=;
 b=LGjBGh++Q4C3GojV2gtAmyEaekZs4wGTl2ryZo1t/pX6WUoO+lG7ap1Kg2ynfsaOS+
 Ax4AM8kyWyxqM4fvK1jJmYyZTZKc74oaoiF5uhhru0iKZFa2omUIWww8Y1l+42r18z3H
 h27RU7K+tyu44Hn8B8ASJD6M7CSHEJWe5MKm78L/j5W6opY/FB+lXZtpy7QjMb+CEzPw
 iX3T9VbbAxjkpajUTp3Dd94zNnNK3IOOBg2oKbTBQwZe0noj2dnMWdMNFjZXyaF43/rd
 3UOCSiOzuPQD4o4a1VhvYTC7x+FAsMfKhAr8Ij5XHiE09qUhI9YjlEckB+V0OM78B+GI
 Qhxw==
X-Gm-Message-State: AOJu0YzyJybihJ5QYS8uF+7ZQNXofMlalO3mkEbpSWYSiCJaQ0yxeXmS
 GQMDnFRMQWrpK6ENTF6XaRtClDW6Sh2o0KBg7UIlrn0+LUNYLOK163XJBYCcyV/r9fAnUP64oxl
 u6x72JezWbPn+JnQtC9fpH8dDE2wj7e4iZX3YtOjGILdNzdTHShCDC/qBETr7zMZIdv8WjwXQ09
 U=
X-Received: by 2002:a5d:4e49:0:b0:319:7787:54a9 with SMTP id
 r9-20020a5d4e49000000b00319778754a9mr6912399wrt.24.1693821788792; 
 Mon, 04 Sep 2023 03:03:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4ZP04yR74lQLb8s1RNrFjgbd5mNbH3Z+Cl5KRwAUrqI9m8aidVWdnJo3fXTXlYogXyuqyhw==
X-Received: by 2002:a5d:4e49:0:b0:319:7787:54a9 with SMTP id
 r9-20020a5d4e49000000b00319778754a9mr6912352wrt.24.1693821788370; 
 Mon, 04 Sep 2023 03:03:08 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 y1-20020adff6c1000000b00317a29af4b2sm13926798wrp.68.2023.09.04.03.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 03:03:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,
	kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH v3 0/4] block: clean up coroutine versions of
 bdrv_{is_allocated, block_status}*
Date: Mon,  4 Sep 2023 12:03:02 +0200
Message-ID: <20230904100306.156197-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Provide coroutine versions of bdrv_is_allocated* and bdrv_block_status*,
since the underlying BlockDriver API is coroutine-based, and use
automatically-generated wrappers for the "mixed" versions.

v2->v3: cleaned up formatting

Paolo Bonzini (4):
  block: rename the bdrv_co_block_status static function
  block: complete public block status API
  block: switch to co_wrapper for bdrv_is_allocated_*
  block: convert more bdrv_is_allocated* and bdrv_block_status* calls to
    coroutine versions

 block/copy-before-write.c |  2 +-
 block/copy-on-read.c      |  8 ++--
 block/io.c                | 98 +++++++++++----------------------------
 block/mirror.c            | 10 ++--
 block/qcow2.c             |  5 +-
 block/replication.c       |  8 ++--
 block/stream.c            |  8 ++--
 block/vvfat.c             | 18 +++----
 include/block/block-io.h  | 29 +++++++-----
 9 files changed, 74 insertions(+), 112 deletions(-)

-- 
2.41.0


