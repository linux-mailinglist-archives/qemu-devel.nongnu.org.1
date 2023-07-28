Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1A8766324
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 06:25:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPEhU-0007Lp-0F; Fri, 28 Jul 2023 00:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qPEhO-0007LX-JE
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 00:03:31 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qPEhK-0002mD-Ga
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 00:03:28 -0400
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-77acb04309dso71984539f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 21:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1690517002; x=1691121802;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cUh5OG4SXHmOHxqjUbe0euxjJ57/QRakIMuG34+l22s=;
 b=TN7s/y7kwg4NZTUdPWxSqRys6nKgPyqzKe8JC3yhANWRJeSQJuwHzCSvSvba9nKYI9
 gAt7dDLyCuyO6o4eSZgD5bjIBr6ek7w036bDGBX8rCVo2cjk7HTmHJ220PgB42SicyrI
 MojS60rqaD0B++U08eXMrucxXlM1pstEZK2pXb5jZBFm5BRShO/8ZJSnF3AtbYY7lS2s
 famYMc9Cvfc27rPRhMN9IpNj4PeTAQSwmYSabIilVFiqYOqh2ulwoCOmesTL1u44tQnd
 BmoTZC0POuAL+n3eOtQIjPv93tfGajxNAYrDQU8Jak6axMVriq4Be2AYsnZw5YD/qhTy
 D3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690517002; x=1691121802;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cUh5OG4SXHmOHxqjUbe0euxjJ57/QRakIMuG34+l22s=;
 b=lBEwMXviwW4GQlijsAw14Kq0O1mq/pq5/vyedPraz1Nkej5SRp91TdzOkT+y543Okx
 Mhz22sn+MA21dKr7LsdA2E9zvu78gJtCpDudPK9HDu5WudaeKzYUHnPtUO6F4111QkJk
 t9cR9iJU6oX5qw4s/etj9Bf5RYN+6f/Ajg3IZAkh33RepTV6GpvgBm7idK3ovh60GOPt
 wP4yhthzV2SG8GfqzSRur0Igz6lF9SPHESsSUJshZMJ7OlVElAb4OwF94+UQCuxXQ6Oz
 +1vyMJHdymkVPjbLoSs1dSwHf+gW/CsWlP9nZ3dGWBrodBwF/MEHo5VP0KwtI415p4gR
 u65A==
X-Gm-Message-State: ABy/qLagaU0ftmMJ128PLxoBF7EGF3NAQTNcdqj5zHBuvoACUnL1BaBy
 tUKfqcNJris1AYJrAPcS0S9P3mYLBNgqG8afAAM5wA==
X-Google-Smtp-Source: APBJJlHapwrH8lBV/RWbpn+aC05o/ycOfBKwvR+JFNZAkk44KR43YGIJvCcjgfffLLUtstA62mGfvw==
X-Received: by 2002:a5d:9f44:0:b0:787:34d:f1ea with SMTP id
 u4-20020a5d9f44000000b00787034df1eamr1698867iot.8.1690517002635; 
 Thu, 27 Jul 2023 21:03:22 -0700 (PDT)
Received: from dune.bsdimp.com.bsdimp.com
 (50-253-99-174-static.hfc.comcastbusiness.net. [50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a056638018a00b0042b599b224bsm864437jaq.121.2023.07.27.21.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 21:03:22 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, richard.henderson@linaro.org,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH] bsd-user: Specify host page alignment if none specified
Date: Thu, 27 Jul 2023 21:54:56 -0600
Message-Id: <20230728035456.99066-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d29;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We're hitting an assert when we pass in alignment == 0 since that's not
a power of two. so pass in the ideal page size.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 74ed00b9fe3..e3ce4ab1fc7 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -260,7 +260,7 @@ static abi_ulong mmap_find_vma_aligned(abi_ulong start, abi_ulong size,
 
     if (reserved_va) {
         return mmap_find_vma_reserved(start, size,
-            (alignment != 0 ? 1 << alignment : 0));
+            (alignment != 0 ? 1 << alignment : qemu_host_page_size));
     }
 
     addr = start;
-- 
2.40.0


