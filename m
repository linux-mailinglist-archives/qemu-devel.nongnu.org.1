Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69700AA7795
	for <lists+qemu-devel@lfdr.de>; Fri,  2 May 2025 18:44:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtSx-0007nI-Nb; Fri, 02 May 2025 12:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSZ-0007le-Go
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:42:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSX-0006SM-1z
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746204116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J05uCZYDooQWqsbggSNOzykE/w3MbifuSvd/nUion5w=;
 b=L6upVX471uAtHmAlbsPFUh7b/nW5WfyhyHHGOgAxtm7PauABGgImfGpEbHkM2F3YNDqOui
 CQ2GmViEWEW1FPOT7mTsnEjbkaXTcpLkR7K/8yYkrzRgl71HDKjvnc0KxNNk+oax9Vr2xS
 Fne9ZAo6eUJLRzhrf5fKKd6GuUmwOdY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-J-ORlkNONIi7p3gzv8QRGQ-1; Fri, 02 May 2025 12:41:55 -0400
X-MC-Unique: J-ORlkNONIi7p3gzv8QRGQ-1
X-Mimecast-MFC-AGG-ID: J-ORlkNONIi7p3gzv8QRGQ_1746204114
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c3c8f8ab79so342594285a.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 09:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204114; x=1746808914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J05uCZYDooQWqsbggSNOzykE/w3MbifuSvd/nUion5w=;
 b=UcbrH4DjMUr0s09oaYjadmIKx5ZUs2eBJEk4xSLlP0RL4j/Kpk48NqhuXaJDjN9xWs
 itCEiLBcIFf115Sj2/GR+FSO/MjJQL4s5IxasdFdzHJgjjxIN2Ap5BK0r8BlwZ740/+Y
 tREEFpGk0N3w/09nVKxtnTuEkwg9+epzu5Rf93PXFZ9HbFx7oXdV/L+KEw434iw3Kftb
 ydGSlneEf6zTVog8RrLln1RQxB6weEDcVC0OjfHh3DOKtwV6OZad0CvlnBksXdUj7Srj
 bjMvFnSi2etMe+xziFvZAQzXm0XqTc37eBvr7YfF4Nq3lpUsHFF7WYvB2PaAc9dY9bGF
 vF4A==
X-Gm-Message-State: AOJu0YypcVWI/zWu8hzCEV9N9Ajko2HyZ6Q3o+Ba4ao1h4bqOw6Re6xy
 hSUty89jYeg5jpSJrGVSNxfWz093+cNO7sI8cBc8Dc70/QbRQLddkVAp1ecGCE/ctibdEQGmDWm
 +gKC2qx4WK7TezD//4xhjSpAfcxTMvwcnyPXRscsJdcn2mLhvZmRXUC58Bg4PVrJeMXB/Pg5PuH
 a2fN0cJxb5FY27w+MFN2QXDRPtKphnWwlgnA==
X-Gm-Gg: ASbGncsU7J3UG3dYv6um7dRBzzgbEopuT0P8COfutIcmP+g2b+u5ruHjuTZ2MjJ0EBz
 LXJ5LQ9J7/8ft4mSF0RxhcYtndl12i0D32grbfnuCr016CCVyae+oLJDYwEHidrqGep96noIuzL
 ttCCQB2g/BP5hJ1Qxbi8id+wsCgLfJYIabJ2yAC5MoQmGIY+ioJVvSWlhYtE561D5FHdAU0i9jS
 kLi3/09EAdpm05eCrhbg6ZVPAnFcdGwcLxcrm6SO/Gb0UyYs+nQlN2U2sliVJaUbNmAlwbyxa9E
X-Received: by 2002:a05:620a:29c3:b0:7c5:431f:f5e6 with SMTP id
 af79cd13be357-7cad5b572acmr414524585a.33.1746204114151; 
 Fri, 02 May 2025 09:41:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk6jQN/lf01rwuuCQGSrGrpAF221ei7p3mtGsZOyPkRfHNVy0q1akVQjyFJ6mitVp7T+0VmA==
X-Received: by 2002:a05:620a:29c3:b0:7c5:431f:f5e6 with SMTP id
 af79cd13be357-7cad5b572acmr414521785a.33.1746204113817; 
 Fri, 02 May 2025 09:41:53 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cad23d1c8dsm203108385a.60.2025.05.02.09.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:41:52 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 06/14] migration: Fix latent bug in migrate_params_test_apply()
Date: Fri,  2 May 2025 12:41:33 -0400
Message-ID: <20250502164141.747202-7-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502164141.747202-1-peterx@redhat.com>
References: <20250502164141.747202-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Markus Armbruster <armbru@redhat.com>

migrate_params_test_apply() neglects to apply tls_authz.  Currently
harmless, because migrate_params_check() doesn't care.  Fix it anyway.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20250407072833.2118928-1-armbru@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/options.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 4ba8fcb7dc..b6ae95358d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1218,6 +1218,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->tls_hostname = params->tls_hostname->u.s;
     }
 
+    if (params->tls_authz) {
+        assert(params->tls_authz->type == QTYPE_QSTRING);
+        dest->tls_authz = params->tls_authz->u.s;
+    }
+
     if (params->has_max_bandwidth) {
         dest->max_bandwidth = params->max_bandwidth;
     }
-- 
2.48.1


