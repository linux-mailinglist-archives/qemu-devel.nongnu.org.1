Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C92A5719B30
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:52:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqD-0007qa-Hx; Thu, 01 Jun 2023 07:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqB-0007ju-CR
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gq8-0000Ds-Qi
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rOfrZXX16UnAVix2mgLSw7k58wI6+nP7ZDBkc1F6bVs=;
 b=RzT6vh/6O+ewApPYFI2YvwJxnxKOxTgkDR5nHX+GPfHrJ3JehGXMvcmTsKdRmUfMKbHDLo
 I2dNRj35DVU6u7X4SwUBfpXv5NxoDHwTTqHXeeb6P1qxeDr/i6kmwui5ho+P52VLbVpxq7
 9CpULD0bb77ipdYULcw5If75fSunkQ0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-JrZQiH5cNkemN3vJheDu4Q-1; Thu, 01 Jun 2023 07:51:34 -0400
X-MC-Unique: JrZQiH5cNkemN3vJheDu4Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-96f83033b48so54564766b.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620293; x=1688212293;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rOfrZXX16UnAVix2mgLSw7k58wI6+nP7ZDBkc1F6bVs=;
 b=M0qq1aKTFUaG3DYFUpcrPYr145zX7kWYAPAoGQWPL/rLZHMofwW8RYMwd7U04kZR+4
 BAxc/Qw7f2sHUdiKzi+rmSpnMp2u2DluRhfa1SsJWJPMDNmFUoOn3rrzbV0uGfRDn8zw
 Br4q8H0Be/vbNiR8Qywmi6zSkQnovEQFWBlmHTpLG45VCIdBVgWox6m/4E+oyfZbQ6O0
 0voHsJmLr9uCqaPLpLAed9q+ZJRSmL1YDuDqMgvEpcenptdho20/ejDQYHmF1vVAXyYu
 WDqccZMnOAr8bdtYj5QI0P9mmFC4c5nLd6VMFaJlqN2iHUK+o4EFUKbYHmWGJjO2yFvB
 rbnQ==
X-Gm-Message-State: AC+VfDy1wumNeP74mar0TUm0xOErqjH6iWkgFBXBk914kenbQItpmICR
 o9zdddVsul8KwjEJQa/bac5EZbd8JztST3QjAjehdIxglJ+j5vhoyu0ef5n2999q5uHKKZ/KMIW
 awFmAWAS8ALi/4FILNUX6vD3UF32y3c3a2G+y6KIxUP/ZeCFjPusaYyJLPLsNpnHEDWSM2S5eBi
 I=
X-Received: by 2002:a17:906:eecd:b0:96f:7d09:7deb with SMTP id
 wu13-20020a170906eecd00b0096f7d097debmr8602842ejb.69.1685620292841; 
 Thu, 01 Jun 2023 04:51:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4GeSf+jtfOpWnNrZC3DFd20HIVRU1ecRdGPBtQ8Vi4MPwj69NTh0rRhHQtyB357S/RNjIg3w==
X-Received: by 2002:a17:906:eecd:b0:96f:7d09:7deb with SMTP id
 wu13-20020a170906eecd00b0096f7d097debmr8602819ejb.69.1685620292533; 
 Thu, 01 Jun 2023 04:51:32 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 qo14-20020a170907212e00b0096f937b0d3esm10435130ejb.3.2023.06.01.04.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:51:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH v2 0/4] block: clean up coroutine versions of
 bdrv_{is_allocated, block_status}*
Date: Thu,  1 Jun 2023 13:51:27 +0200
Message-Id: <20230601115131.196234-1-pbonzini@redhat.com>
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

Provide coroutine versions of bdrv_is_allocated* and bdrv_block_status*,
since the underlying BlockDriver API is coroutine-based, and use
automatically-generated wrappers for the "mixed" versions.

Paolo

v1->v2: rename the old bdrv_co_block_status to bdrv_co_do_block_status


Paolo Bonzini (4):
  block: rename the bdrv_co_block_status static function
  block: complete public block status API
  block: switch to co_wrapper for bdrv_is_allocated_*
  block: convert more bdrv_is_allocated* and bdrv_block_status* calls to
    coroutine versions

 block/copy-before-write.c |  2 +-
 block/copy-on-read.c      |  8 ++--
 block/io.c                | 96 ++++++++++-----------------------------
 block/mirror.c            | 10 ++--
 block/qcow2.c             |  5 +-
 block/replication.c       |  8 ++--
 block/stream.c            |  8 ++--
 block/vvfat.c             | 18 ++++----
 include/block/block-io.h  | 30 +++++++-----
 9 files changed, 73 insertions(+), 112 deletions(-)

-- 
2.40.1


