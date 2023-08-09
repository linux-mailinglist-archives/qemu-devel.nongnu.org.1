Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9661677555E
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 10:31:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTeZq-0001di-H2; Wed, 09 Aug 2023 04:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTeZo-0001be-9K
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTeZm-0000gR-7H
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691569793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/DE8KEyDAizvGEGBdn8fIPPPqDuqn7wOzBh78roRLKU=;
 b=e6/Chbfn4Nc8nibHY/El1n+cBefuZhAOIEIh/2HoqWzwsSiU/0QVvWloEyUKUUiqn0bQ+I
 it5vzurUro6rhBYgjbWnPgMDDs8MFv/KpVW6gXeG6HcGyKZdNaOkjvoQDUnkVu2Nu06M/7
 wl+QmOi+3b6PdsKw7AtcZJ8T6xAjVRY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-4lP34DHONWakDrWXygJ4LA-1; Wed, 09 Aug 2023 04:29:52 -0400
X-MC-Unique: 4lP34DHONWakDrWXygJ4LA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fd0fa4d08cso38551675e9.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 01:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691569790; x=1692174590;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/DE8KEyDAizvGEGBdn8fIPPPqDuqn7wOzBh78roRLKU=;
 b=FTUrbBZm5VZcM9uFlBKAu7uFxnvESTQklhRHgeY/mYg8ebbCAshQL89OJtd7K0eM88
 ENFiFfPq4LbGXfg32zdV01Tmb1wjvyuqEmivGiM0Eq/ST6tWmrUHsNKBfFUIPRcjEsHm
 XSb25UjwB3Q2zYD9qMy/RSWdJy2EhQNviNkWftIAdUqmwvt/1e9PZZeeI/sAvrYf5xfz
 5FjZbvZ7OFO926jU6Bvcfa6ZWmmOh3huwH5asmr3qV4eWafqG68QlXvTE/TcpWX56lSP
 ahlGU9JBBzpALSEjjOhxs65tuyK8O0SQTPbc89g2uuO+ZDOaEmGbHY0rhitDdmSsKWxo
 B0OQ==
X-Gm-Message-State: AOJu0YzDiSKfF4wny1+Kk1TGZyGt0lpfV1hVMZhN1jPhMXLuRklfSK5X
 oNEjcl8XqvqR4iUABvNs32ebaaSrpBhIfqtBKU3taZZS50NCEZgMeMStA4cgY9odUs1ZLdaZrGC
 sGI6OXGDX8+9SRpu5BhTSCKabHOszWV9cVOCfJkXjcMRTRMP//kAEJAmbcWL8S2Xt2d5SWEiW9C
 I=
X-Received: by 2002:a5d:46ce:0:b0:317:6b92:26b5 with SMTP id
 g14-20020a5d46ce000000b003176b9226b5mr1238849wrs.23.1691569790653; 
 Wed, 09 Aug 2023 01:29:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtbLxw0bgI+i3WvxIAFjND3fbftko/lE+8TMzlBQIVk4gE+hjpY+6tNSDHG9tg9JtoN+oatw==
X-Received: by 2002:a5d:46ce:0:b0:317:6b92:26b5 with SMTP id
 g14-20020a5d46ce000000b003176b9226b5mr1238839wrs.23.1691569790373; 
 Wed, 09 Aug 2023 01:29:50 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a5d4489000000b0031411b7087dsm16187704wrq.20.2023.08.09.01.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 01:29:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	alex.bennee@linaro.org
Subject: [PATCH for-8.2] dockerfiles: bump tricore cross compiler container to
 Debian 11
Date: Wed,  9 Aug 2023 10:29:45 +0200
Message-ID: <20230809082946.747668-2-pbonzini@redhat.com>
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


