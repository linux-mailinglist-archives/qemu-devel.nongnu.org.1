Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E75797291
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:07:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEe6-0004En-T2; Thu, 07 Sep 2023 09:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdi-0003h8-6I
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEde-0007Re-Hg
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WgNpBuRZhKdrrSPMd3wYRYwFLY/kG5N6eWJAhKeC32o=;
 b=NuTw4tM0omTMz9PUBqZhfSTI5bI6tTkREnC1gzZvf3lrplpZruE7eQpuZdXUmnovX6OUrK
 KlLZxGUQOzie7JnoFjtINlMkkxrPrFm/6b1ZkAIEK3II/ACtpZusHKohJSOi5/AuqpqYHP
 cTtmXB2VOeXH18SALSrxIz7X5oKonQ0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-JoJxpVuFN66OMTp06xAg_w-1; Thu, 07 Sep 2023 09:01:32 -0400
X-MC-Unique: JoJxpVuFN66OMTp06xAg_w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-401db0c9d3eso6895685e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091684; x=1694696484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WgNpBuRZhKdrrSPMd3wYRYwFLY/kG5N6eWJAhKeC32o=;
 b=iHqOuq819unGxFH6tuxziFJ/mF6HFqdfzr53UAkfvAZCXBkpaO9rPTiR0M6QMwQRzT
 9iGK3BvuginFXr8Lg+x7LdnCVx/2ODQ6k1kHe9jA3ZPdd1YpKWEmCOVd/ap5Hqd+Iexi
 HhJRvFXXtghnSWMFQnD3FqXrtPc3yr5WxutzGw7hqm/t/stXJzaKCYeHfyD2CE95wPqP
 fRAv8Vd+Wo4U74wQi5tcDm1tOCB6B8BvRzarZ3IIwv3n9zBqeCmmUYx0t0LtdNWClPzb
 5K11HYFbWjTOUuW+5z/AJddAEUzvwJNKqC0Q5900Hw4Wz2KNHDhGb8Xd2nnaX/XOjeYD
 hOSA==
X-Gm-Message-State: AOJu0YxCa8J8cP0DYn509iOtp7CecLd2LglbW952lten60wqpk766QR6
 wwT6cULsEBZdvXZA+fc0SAU0N9orE1l/cT/SG6vMYArZ0Pm9N6KMcaX+SveXVOJe1rvv3gNvKlZ
 Zh7YoHKssl7ln5ia5LOQzjwPhPwulQbVupyejWO8bTAR2R7YUwdteAfpTe9ZIJV/5cpUv2iM8aC
 I=
X-Received: by 2002:a05:600c:3641:b0:401:bf87:9898 with SMTP id
 y1-20020a05600c364100b00401bf879898mr5167750wmq.25.1694091684504; 
 Thu, 07 Sep 2023 06:01:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrlKY2TvzHPkpNdgmVDoIdakdgiUpS8jDigqGvgN+3iRLvRtGAYkwly6XG33acEs3M/Xj/BA==
X-Received: by 2002:a05:600c:3641:b0:401:bf87:9898 with SMTP id
 y1-20020a05600c364100b00401bf879898mr5167717wmq.25.1694091683907; 
 Thu, 07 Sep 2023 06:01:23 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 n10-20020adffe0a000000b003140f47224csm23191913wrr.15.2023.09.07.06.01.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/51] configure: remove dead code
Date: Thu,  7 Sep 2023 14:59:42 +0200
Message-ID: <20230907130004.500601-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/configure b/configure
index ef085376922..48ae0fc05ab 100755
--- a/configure
+++ b/configure
@@ -1126,14 +1126,6 @@ else
     done
 fi
 
-# see if system emulation was really requested
-case " $target_list " in
-  *"-softmmu "*) softmmu=yes
-  ;;
-  *) softmmu=no
-  ;;
-esac
-
 if test "$tcg" = "auto"; then
   if test -z "$target_list"; then
     tcg="disabled"
-- 
2.41.0


