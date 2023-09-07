Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C21797282
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:02:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEcl-0002iJ-4D; Thu, 07 Sep 2023 09:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcj-0002hc-4o
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcg-0007EY-96
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKa/HTgjgxw/QaVwksImsBsboXLveUKajuIt62ZHnTE=;
 b=hngdydl6Tz4SnV9d8Lt4cdkou1STORP/rBJw3kvzZrA0V53LyOO5RR4AD0pIimbnVlUnVK
 tcC1ip1Usba7Flmtrfl/peNaeBWcTRPG2RekhEXrLDc+NYZWQgc8aGZ9iBqiLidj3Ao8Dq
 bv3KepA2RS6qfyxh3dxaE5mbRPPueFY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-B3Bp31TdOLWXFs9scuKQjQ-1; Thu, 07 Sep 2023 09:00:31 -0400
X-MC-Unique: B3Bp31TdOLWXFs9scuKQjQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31c5cc3b512so604532f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091621; x=1694696421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dKa/HTgjgxw/QaVwksImsBsboXLveUKajuIt62ZHnTE=;
 b=c4FiMoBr0gu6Mi+ToUapBlFkH/reSyeKSjgISamwCUgg7JG3Cej9lfq45tSv+PleIz
 PH58b6aQUZ8DVduh+w2YV8BZT4SonqsQ4fDcSi+NHog5ngMENDW7QGtMh2NQKFr08LoF
 PFRkQBiaQt2gGSSjiRUcdOG8k1WWPnIZFihOD8AG4xkcCTvyGpr5XmvBMj1aSrUn3o9s
 rjVUn3QCy7MEyVJXFEur7dTREDM8pAi+mqeMhpSWbq3o0jsIhD4cHe4fMop4S+51b3WE
 vE/miwEYfDfLIubSxCJR0Ct6oCg2tfZUH6UoIehuL/aQ70mhSNW3ZgO8M/VjrjLNc9VI
 ofLA==
X-Gm-Message-State: AOJu0YxTzol2MQ/fy0RLI7Ww7YntOW+w8w8H/uQZsKttPMzcRjsEQQ+B
 muOaSGejVQgKwaXzFVSOE59lwROcmc40q+dfbvkOFa4hlQEOzgUXprwl8GCWItKWuBjSvNOUxNk
 Ebc4YG9RW10aKL5xZcvwf3SrRjWuPEUD42Dlu6b2o309fgblPEaHfVafx64yZ+30LyC/rPIsiSd
 k=
X-Received: by 2002:a5d:4d8f:0:b0:319:755c:3c1e with SMTP id
 b15-20020a5d4d8f000000b00319755c3c1emr4222567wru.11.1694091621695; 
 Thu, 07 Sep 2023 06:00:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv4vhKu/v26kqFcgjkP13AcaJpgYaEoffmZll1pnEBYk6Rzg8MO2nVcaXxDnCa/o2IiN9MyQ==
X-Received: by 2002:a5d:4d8f:0:b0:319:755c:3c1e with SMTP id
 b15-20020a5d4d8f000000b00319755c3c1emr4222548wru.11.1694091621380; 
 Thu, 07 Sep 2023 06:00:21 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a056000181200b00317f29ad113sm23119268wrh.32.2023.09.07.06.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 06/51] include/sysemu/os-posix.h: move *daemonize* declarations
 together
Date: Thu,  7 Sep 2023 14:59:15 +0200
Message-ID: <20230907130004.500601-7-pbonzini@redhat.com>
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

From: Michael Tokarev <mjt@tls.msk.ru>

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-ID: <20230901101302.3618955-2-mjt@tls.msk.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/os-posix.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index 1030d39904a..65b9c94e919 100644
--- a/include/sysemu/os-posix.h
+++ b/include/sysemu/os-posix.h
@@ -47,13 +47,12 @@ void os_set_line_buffering(void);
 void os_setup_early_signal_handling(void);
 void os_set_proc_name(const char *s);
 void os_setup_signal_handling(void);
+int os_set_daemonize(bool d);
+bool is_daemonized(void);
 void os_daemonize(void);
 void os_setup_post(void);
 int os_mlock(void);
 
-int os_set_daemonize(bool d);
-bool is_daemonized(void);
-
 /**
  * qemu_alloc_stack:
  * @sz: pointer to a size_t holding the requested usable stack size
-- 
2.41.0


