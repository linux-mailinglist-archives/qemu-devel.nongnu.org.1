Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FCB78AC7A
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 12:41:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaZeK-0003LJ-CM; Mon, 28 Aug 2023 06:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeH-0003IW-8y
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeF-00053a-0l
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693219145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DE8KEyDAizvGEGBdn8fIPPPqDuqn7wOzBh78roRLKU=;
 b=Szr6jAA77GyiUweTDcZuX5asfQboCvcn0dxNCyhf5W15Pq+sD4RJXF/dCQMkhLxXsMsYUL
 OdDSBe5015fWFgcT4iqqnUEGpfv4/6/AjnO4Kr1LrpEECcQZA2pFWc4jLrVqbXXHENVMBf
 bukYuTMk1Ta0hrnzuCezk8pIyJOCHmA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-2xoO5yh_PVuJq4hwiIRh1g-1; Mon, 28 Aug 2023 06:39:04 -0400
X-MC-Unique: 2xoO5yh_PVuJq4hwiIRh1g-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2bcc1e0dfe5so32935881fa.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 03:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693219142; x=1693823942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/DE8KEyDAizvGEGBdn8fIPPPqDuqn7wOzBh78roRLKU=;
 b=Cv4MiaBWuewjZPvoC3oXVxQ45WjXDS7r/s2s7X+AY38QIx7dEQ9y06HmAOpYh9MIMb
 S3z7f2E3PCmgtx7uFB71fv0wMTsxCaR3B1I622vjrGWZd2P4HZQ/Wsf7q1MOv6GsvyKW
 Hpm+iYJAlorhZsTC3dTNpjgJH8vDUJrMAQHk68VZR7Q1DZED8onsN9P5ox0Vc0cvritT
 3lgIrQjm5aCUIejK4/aQoI7JB/S4mcxRPreVBViYypppAkfmdPMHf1fv3suq8MfAaLUu
 XJgoFZDewExvjejYuF9VttG7/+2DJFkJWdBzxzU0w0+M5LpOSNjbDjMZw2ptuu0BFk1z
 GPLA==
X-Gm-Message-State: AOJu0YwToDHfrsdCbhpX4Zyz7+Uxgfi4DZejnWhrj/muBSGnvCTQgXMI
 x1S0Qsz9oXL1YjCRySRJDTSrcT++Zy1aiqBfluOkE7AKIlkUVnU45pLUFdK7F8VSbhl7Wn2Abri
 v4GyRa19MqREG2MFDzPu59ujwMCK75FYHkdAH3AhfZIRTQx883JA0orpVkFVwMRHAQmubnIbbtj
 k=
X-Received: by 2002:a2e:7810:0:b0:2bc:f1e2:9043 with SMTP id
 t16-20020a2e7810000000b002bcf1e29043mr6177931ljc.26.1693219142337; 
 Mon, 28 Aug 2023 03:39:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP5ZEjoXT5SqNL8FUo3IgzPhkc4CDRiIQ79ly8sii029r0ReJa//4h9SdPYL+wBVtEsNjiXg==
X-Received: by 2002:a2e:7810:0:b0:2bc:f1e2:9043 with SMTP id
 t16-20020a2e7810000000b002bcf1e29043mr6177917ljc.26.1693219141865; 
 Mon, 28 Aug 2023 03:39:01 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a5d51ca000000b0031c5dda3aedsm10092947wrv.95.2023.08.28.03.39.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 03:39:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/14] dockerfiles: bump tricore cross compiler container to
 Debian 11
Date: Mon, 28 Aug 2023 12:38:41 +0200
Message-ID: <20230828103856.46031-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828103856.46031-1-pbonzini@redhat.com>
References: <20230828103856.46031-1-pbonzini@redhat.com>
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

With the release of version 12 on June 10, 2023, Debian 10 is
not supported anymore.  Modify the cross compiler container to
build on a newer version.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/debian-tricore-cross.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index 269bfa8d423..5bd1963fb55 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -9,7 +9,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-FROM docker.io/library/debian:buster-slim
+FROM docker.io/library/debian:11-slim
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
-- 
2.41.0


