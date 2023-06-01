Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A902C719B2E
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:52:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqL-0008Sq-M7; Thu, 01 Jun 2023 07:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqJ-0008GY-8q
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqH-0000Gt-SS
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5gDo6gRhnvor6PQVhdFMG1bnfIKAfrOm4x58U0jQHcE=;
 b=Nv3myeRCDUjA3wYchbE3j3VNfnXZuEBbAwBXSpIUwq2orJr5/loMNaEsE2zATo0mRu2uoT
 fPh3Oa856JH90OiY2XbzUOTzPhP5tOnxhDr00AManIEmNBt4JIjAkC2Gf6XaDMky72EudA
 AIv3/SkOPXs06yUvaVXxEvhJpNxLXoY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-dHGZ1vY-MXSjK5Bbh64f6w-1; Thu, 01 Jun 2023 07:51:44 -0400
X-MC-Unique: dHGZ1vY-MXSjK5Bbh64f6w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a356c74e0so50873566b.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620302; x=1688212302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5gDo6gRhnvor6PQVhdFMG1bnfIKAfrOm4x58U0jQHcE=;
 b=HnIzso2LgWLHoCBav5tfqhpaJy4K7Ux3o2oRdEsCxLU7JdTsAn/Uryd6gPxCkVOxZQ
 ez2JdL4FWLsAv8r/KZw/CTr5gCYFGUrzL+534es/NYSC23MC3esyiAbQyo/lQFPNMkES
 2QWzOuRDO6rBI7YTvsO3BSNJhPwKE8Qi7c1a0kc4BpKiRWJ6LbhcGY84PdnZzdErBdhT
 XVAAHnR6QJnrIXBSCh9CnNvO4h34mnPwwTrQ+bNiGetHD+xzEqtq5JTtfonXBC9p9rtt
 RL+VJrFFhltrajH7ahBUC7TJPKXPx8DqBenUiTbBCTKdduFUw9oOu7a13R6qOAUbrG4c
 QFNQ==
X-Gm-Message-State: AC+VfDw//lpxiLbReQAjSm3s4PTV6xXh3n0fb8bFixCEaF4KoIDYjSDe
 YzCVIZ+69Q0JiCM50eOL2ZiHTgH5EIsYAJxOiGRCIyq4ZFhrjjL7EQvQCugkpc5+nR+iwfh+dmr
 cbxGhsMi8y1Zgr2F6P1fMaZEy+F4HoyXwoUfawmbA4rYDxrB0ZqJukaCU9fMa70+xOLb4yYN0q8
 U=
X-Received: by 2002:a17:907:d0c:b0:96a:9c44:86d9 with SMTP id
 gn12-20020a1709070d0c00b0096a9c4486d9mr8781030ejc.12.1685620302521; 
 Thu, 01 Jun 2023 04:51:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60C75LqAkDl27yGKwB67uYdzdkUlhpUoRMZIKrN9sisGO1Z929QAeqAgYp7LQPMStLMa3xQw==
X-Received: by 2002:a17:907:d0c:b0:96a:9c44:86d9 with SMTP id
 gn12-20020a1709070d0c00b0096a9c4486d9mr8781015ejc.12.1685620302306; 
 Thu, 01 Jun 2023 04:51:42 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 c19-20020a170906341300b00965f98eefc1sm10466643ejb.116.2023.06.01.04.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:51:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH v2 1/3] block: make assertion more generic
Date: Thu,  1 Jun 2023 13:51:37 +0200
Message-Id: <20230601115139.196369-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601115139.196369-1-pbonzini@redhat.com>
References: <20230601115139.196369-1-pbonzini@redhat.com>
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

.bdrv_needs_filename is only set for drivers that also set bdrv_file_open,
i.e. protocol drivers.

So we can make the assertion always, it will always pass for those drivers
that use bdrv_open.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index dae629075c2c..a1452e747b62 100644
--- a/block.c
+++ b/block.c
@@ -1627,8 +1627,8 @@ bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv, const char *node_name,
     bs->drv = drv;
     bs->opaque = g_malloc0(drv->instance_size);
 
+    assert(!drv->bdrv_needs_filename || bs->filename[0]);
     if (drv->bdrv_file_open) {
-        assert(!drv->bdrv_needs_filename || bs->filename[0]);
         ret = drv->bdrv_file_open(bs, options, open_flags, &local_err);
     } else if (drv->bdrv_open) {
         ret = drv->bdrv_open(bs, options, open_flags, &local_err);
-- 
2.40.1


