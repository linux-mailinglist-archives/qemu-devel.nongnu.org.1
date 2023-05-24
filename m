Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7151B716FB5
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 23:29:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q46ss-0004OC-79; Tue, 30 May 2023 17:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1q45gr-0005YQ-5P
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:11:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1q45gp-0000NT-NN
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685477491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yRjcQqbdBT6mpokbSXKHWEUehGRJpPqdb2q3kS5Mi0s=;
 b=g4uV5vrLWCIQCE8d46UvgvzqpOf2qZVDNW0i94oVUUvD5ukKuKAYWLLT5Nt46yx6pKBylF
 O52TuEgxcChxEB61Pc6e86IrCTw+OuMm239fOMQ6qoXRBjvwodBfPHd/H+k0+5eStxUxQ7
 bYSKVREDzsRryopcYHC1Xpos1EP2AFs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-u2e5IuchNm2vs9w2KaZ_1w-1; Tue, 30 May 2023 16:08:05 -0400
X-MC-Unique: u2e5IuchNm2vs9w2KaZ_1w-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-513f4c301e8so4892633a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685477284; x=1688069284;
 h=mime-version:user-agent:message-id:references:date:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yRjcQqbdBT6mpokbSXKHWEUehGRJpPqdb2q3kS5Mi0s=;
 b=EWtuikqgu0arWn267MaLovQGxfe+t/u++bqNChR0lqL0C7tq/nnEREoUQWGGw4gMKt
 QvNrJz8CasvYQ4ZXnZLROREX3hIdgRUFxNKUvq0U8ZGqFBHuKycnYY2VY0ol+/3xEgaW
 5XvIF9zIvP/UemPB7iIZBenqguB4oZMlcLIYZHcG7OvG5rNTeiZ1PynQtsNCWqKBh7lw
 daU438K2UazN/iQwKeN1hsIL+Y7AJnjfG2r8WAfqFhhSIia56C66ghVdyEHOl2QWVeKc
 k+Jd/07pUqfCVMuM1BKFHkn111/X3lIARteXsVhK5Y039dOem0DkhpvyE5ArgtnfBl0R
 Bz5g==
X-Gm-Message-State: AC+VfDzo3tQpg++RqBYegtvYFGmFuP7RooLrYCRaaFawTGTCP6gfEGBa
 ZDOVli0LBdvmkGPHEnb2n/aedDZBRPthRVwy1YP1B1SkrIfFte3NEyvVs8k27FksjTRiDFzgHXP
 3QcdQ0Kbk2ioKyJY=
X-Received: by 2002:a17:907:84c:b0:960:ddba:e5bb with SMTP id
 ww12-20020a170907084c00b00960ddbae5bbmr3784993ejb.43.1685477284358; 
 Tue, 30 May 2023 13:08:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7s81ks+9amL6MRlF18yJj0cvu6D9YJ/oN3KQ+EtY2bl2nn3VUISwCEZ9lYtIjQW255ezMNEQ==
X-Received: by 2002:a17:907:84c:b0:960:ddba:e5bb with SMTP id
 ww12-20020a170907084c00b00960ddbae5bbmr3784988ejb.43.1685477284146; 
 Tue, 30 May 2023 13:08:04 -0700 (PDT)
Received: from nuthatch (ip-77-48-47-2.net.vodafone.cz. [77.48.47.2])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a170906179800b00968db60e070sm7758112eje.67.2023.05.30.13.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 13:08:03 -0700 (PDT)
From: Milan Zamazal <mzamazal@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
    stefanha@redhat.com,
    alex.bennee@linaro.org
Subject: [PATCH 3/4] tests/qtest: Fix a comment typo in vhost-user-test.c
In-Reply-To: <cover.1685476786.git.mzamazal@redhat.com>
Date: Wed, 24 May 2023 15:34:04 +0200
References: <cover.1685476786.git.mzamazal@redhat.com>
Message-Id: <89d88ee1cab67b8412617e593ea786f1014d737b.1685476786.git.mzamazal@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mzamazal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.167, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 May 2023 17:28:00 -0400
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

Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
---
 tests/qtest/vhost-user-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index e4f95b2858..8ab10732f8 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -281,7 +281,7 @@ static void read_guest_mem_server(QTestState *qts, TestServer *s)
     /* iterate all regions */
     for (i = 0; i < s->fds_num; i++) {
 
-        /* We'll check only the region statring at 0x0*/
+        /* We'll check only the region starting at 0x0*/
         if (s->memory.regions[i].guest_phys_addr != 0x0) {
             continue;
         }
-- 
2.38.5


