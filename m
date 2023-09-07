Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D764379729C
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:09:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdP-0003EK-Ks; Thu, 07 Sep 2023 09:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcv-0002py-Qb
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcs-0007HA-7w
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVEgJtYPmZuVdcSMpVwNKTJ5Fk4pgDhwPpWaXsj8Fow=;
 b=Pt5atFomUjttjizjpIta/+eKjYoDhtQts16Z3uXOci2mgS2K43dIl/1rfqcPIM0Qek6eeD
 ST5jgc6P+8mTuSjH/hJTC76UUElWZOo8zVpYboNS7B4YGW5mafXeQoOQtO2qX3YddZv4/Z
 GEXtIgG5TozMxNfZk040VvpRb9G9WI4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-AUbLWZ1EN1atZRXnkcgo9w-1; Thu, 07 Sep 2023 09:00:34 -0400
X-MC-Unique: AUbLWZ1EN1atZRXnkcgo9w-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2bce272ebdfso10791761fa.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091631; x=1694696431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LVEgJtYPmZuVdcSMpVwNKTJ5Fk4pgDhwPpWaXsj8Fow=;
 b=l8MQOsicqkyHKdfilhr0nkIYD/BZDNBn8j3pXw62ZWug2AsZ3vXk0eR7vL2Ts1xVVD
 TgU1YIc8Ik59i1b5S77qOb18OijGa7Lp34wWPbqMMk7yQzQ5LUVULXU+GN13VzxPBw0F
 AwRlremf6dFfq61rCRFifP+G4bLlKd5uUnuUMhsZYD2m2eoZ1qBh4f4uqoS3S5ChO2vO
 9tlp9pDTpplpCk44rM3LUaWqhs81YP923gZXiMWyOGLeJxmdKT2Jc4PBxAoFhSREJCIK
 5XRqEfq+uc4jcZ6bCRpmCLavwT7irZQvB7XfoEeg07nfFZJOi0GVv9VvgRDdQ/ir6fin
 Cajg==
X-Gm-Message-State: AOJu0Yy2PJM9w06Mw76xiaaEThp52/MD7Ec9qKFqEby6coha0TS7JmWK
 sEpHpnpcmPoqVQ4gIWhOdS8xGZZ5J08RUFG2TRiQx5iqwuNck+ruT8HOl7mqeOui2n013Pi3t/f
 LO2OMFeTDgRbsPejJ3FRtQcApY+JnwEoHkmqyt9HHy+cCAwrWSK93H3L629U2+Gn1S+1WJ+dwIm
 s=
X-Received: by 2002:a05:6512:118f:b0:4fe:15b5:a5f9 with SMTP id
 g15-20020a056512118f00b004fe15b5a5f9mr6124300lfr.54.1694091631554; 
 Thu, 07 Sep 2023 06:00:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLzZrNgik3gJQQoMMrcT1kSbfywFG9u11hjDOiAq0ygxpWOiTTWrRWUbz5KXZ2knu7tYyo8A==
X-Received: by 2002:a05:6512:118f:b0:4fe:15b5:a5f9 with SMTP id
 g15-20020a056512118f00b004fe15b5a5f9mr6124270lfr.54.1694091631198; 
 Thu, 07 Sep 2023 06:00:31 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a7bc4d1000000b003fc02e8ea68sm2497859wmk.13.2023.09.07.06.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 11/51] os-posix.c: remove unneeded #includes
Date: Thu,  7 Sep 2023 14:59:20 +0200
Message-ID: <20230907130004.500601-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

From: Michael Tokarev <mjt@tls.msk.ru>

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-ID: <20230901101302.3618955-7-mjt@tls.msk.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 os-posix.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/os-posix.c b/os-posix.c
index a8e38c02988..f90dfda9b0d 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -29,8 +29,6 @@
 #include <grp.h>
 #include <libgen.h>
 
-/* Needed early for CONFIG_BSD etc. */
-#include "net/slirp.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "sysemu/runstate.h"
-- 
2.41.0


