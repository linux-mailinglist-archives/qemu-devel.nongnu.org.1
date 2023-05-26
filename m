Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EAC712A36
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:09:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Zze-0004CZ-Up; Fri, 26 May 2023 12:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2ZzY-0004BG-5w
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2ZzV-0002cv-Ek
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685117311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PY7zMTVVpyEJMUHIwvD7udn+W7XfH9WjAVo65QyNQzY=;
 b=FZhZF76FJbqdf/4dBQeT0bDJh12XbNUJ2NcxIa/KHjVB0tgpzcq3jqRbaKYQZG70NE7YvQ
 Z2dwAvAgH9jsGA+kCHMHNDvi1u1tJKa7Hu8mNxUAlyPzUewJ0jDRdEJA+M8LVlDyIzQbZ9
 8KK3RaoUj5rMexExjTznIVzC2Sdn3CU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-LwC0YhDzPce_nQvU1JHsyw-1; Fri, 26 May 2023 12:08:30 -0400
X-MC-Unique: LwC0YhDzPce_nQvU1JHsyw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5147d242f01so702592a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685117308; x=1687709308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PY7zMTVVpyEJMUHIwvD7udn+W7XfH9WjAVo65QyNQzY=;
 b=ce1BG4is8Ou5/5Cqc0JqmzsSi/cOkn+8aHLN963ytDMvUf1rKPNN2ke4+xJr1JvNZP
 fU/ekePfLKSckljX69gkZh0GmgsS/FA/rMi+h1cISOystmJeydEqxzYbgO1ex8MEMhJR
 mwQFwQi604gvQJd/UNOm1suZoT3n8zCvlfigbJ1Z8J5i7Tk6oCOBqxm3YCtPsGxgxslV
 /6KQt29pEownZS+K2/3RoFzJmcPEk0U54EB3RGGEcD4wN/OX9IlOL43JB1eZH7AKukuN
 yPW2T3AOBWxl417phERNrYOruqNMuHziCwB/BrI+m9ugWaqhaAUmgcg1eNvKruGgck3k
 Y8HQ==
X-Gm-Message-State: AC+VfDwmHXRwxhlekXM8FI+SpQ1Nao1KMGszwDjZf3G6q2DeNwNrbMAZ
 WuEgsxnc/PvMZvdLDU3y0oe+QYasoo4J7pfqImZpRONGH+LzJRBvY5o0pD9AF5/JyKtSiiZBQK3
 ndqvZ1E3iCken1aJmiKqkfqjZuOmXd64sbNQ+Hi6+SFmcqiG3dH6zVDfdOZnvzZOXDNkEBenmz0
 w=
X-Received: by 2002:a05:6402:5202:b0:4ea:a9b0:a518 with SMTP id
 s2-20020a056402520200b004eaa9b0a518mr6051273edd.17.1685117308455; 
 Fri, 26 May 2023 09:08:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5jvgCTvleaHamdF0M4hD98DGsGGjZNYHsuKRHezRx10YluX4byn5olpWbqUN32zsSeO4ku9Q==
X-Received: by 2002:a05:6402:5202:b0:4ea:a9b0:a518 with SMTP id
 s2-20020a056402520200b004eaa9b0a518mr6051260edd.17.1685117308180; 
 Fri, 26 May 2023 09:08:28 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 g13-20020aa7c58d000000b005141ff430bfsm103315edq.11.2023.05.26.09.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:08:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 01/12] tests/docker: simplify HOST_ARCH definition
Date: Fri, 26 May 2023 18:08:13 +0200
Message-Id: <20230526160824.655279-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526160824.655279-1-pbonzini@redhat.com>
References: <20230526160824.655279-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ARCH is always empty, so just define HOST_ARCH as the result of uname.

Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 94015253254c..142e8605eee9 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -6,7 +6,7 @@ NULL :=
 SPACE := $(NULL) #
 COMMA := ,
 
-HOST_ARCH = $(if $(ARCH),$(ARCH),$(shell uname -m))
+HOST_ARCH = $(shell uname -m)
 USER = $(if $(NOUSER),,$(shell id -un))
 UID = $(if $(NOUSER),,$(shell id -u))
 
-- 
2.40.1


