Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8427799645
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:36:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfV-00012P-Hw; Sat, 09 Sep 2023 00:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfI-00010h-Pk
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:48 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfG-0002wT-MC
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:48 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31c73c21113so2471541f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234025; x=1694838825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iussohd3oOsJrjsaObP8RqGbhTo1pjSye6BxeJlFWe4=;
 b=RQsXmgu8GvA358XYwJNYkX0uAM02RiR48mojE/cXtLZA9cktnAcEdUE6qDWCvetV3N
 mp698zhIN1LhY4leTlAdKJ4tmFSqL5AOeJAIM6syxvgsMGngJvFU6uk73pafe7KxD555
 e2y9U+qAJ7tb1rfssVorIFsDEND1Y0O6rydL56hX4KtZAsZ5B//Ho6zB78fkAQKMJwj7
 VF8yFIQpJxHvB/O1DGoy3FCK5yL6IC/MIafIu4bhr2ktCnssORe7/dhXdlGEKmnqnTFY
 O0YTnZzIKVEEnnE8AKYy4QmHB++Mul6SMspwonlVnELbMHO7pAqnZ/9AeAGEBv6Bqt4h
 ek/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234025; x=1694838825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iussohd3oOsJrjsaObP8RqGbhTo1pjSye6BxeJlFWe4=;
 b=JvMksHX6CId1t+LEd+yxIuEZiksUka6Gw0HAYXO0/l/ygXa7ImjLFEVzeVpr0RDjb0
 pbq80SUMNmnQ+zTdO3QWLLpjs2BE5j56XjYUAjIE8xhNvu2KUAtrJbueCFDZcB2iqyOB
 FuykvYBhHgyrbQ9LOKixjbz3HByrU0B1zJm0ZuKiY5C+JYWStsSvNRPJTJZcDqyGvjOO
 /JPpq7Ev2jTehp8lWe7IqBfPne91jwizmOKD1J6f12S8SHsciS8Wq7DErKQ+0Uo2fV7Q
 MujFe5WE4wWUoq1R7K/ugSwGx2zhEEw1eYG+seLIvDjeOnmHR6D4WIiUp2/SEd3n/9E3
 KTgw==
X-Gm-Message-State: AOJu0Yx93IY50bUYsztC+jM6m+o3IMo7wnBIh5B2VspuQsVgNQ7v9ws+
 MIBPS8BEju/W4zu5NafVWjQqxoLoeAM=
X-Google-Smtp-Source: AGHT+IFf/n6ipjlOpr4wnyG2l+yMejGay7OWyqnmuQ7Fm2KewRwGgVmdekG49kaqRm0/jxyUpxZeug==
X-Received: by 2002:adf:f8d2:0:b0:31c:81ef:f90a with SMTP id
 f18-20020adff8d2000000b0031c81eff90amr3200647wrq.47.1694234024808; 
 Fri, 08 Sep 2023 21:33:44 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:44 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 09/23] bsd-user: Implement ipc_perm conversion between host
 and target.
Date: Thu,  7 Sep 2023 09:42:48 +0200
Message-ID: <20230907074302.79234-10-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
index 8834ab2e58..46cda8eb5c 100644
--- a/bsd-user/bsd-mem.c
+++ b/bsd-user/bsd-mem.c
@@ -30,3 +30,28 @@ void target_set_brk(abi_ulong new_brk)
     target_brk = TARGET_PAGE_ALIGN(new_brk);
     initial_target_brk = target_brk;
 }
+
+void target_to_host_ipc_perm__locked(struct ipc_perm *host_ip,
+                                     struct target_ipc_perm *target_ip)
+{
+    __get_user(host_ip->cuid, &target_ip->cuid);
+    __get_user(host_ip->cgid, &target_ip->cgid);
+    __get_user(host_ip->uid,  &target_ip->uid);
+    __get_user(host_ip->gid,  &target_ip->gid);
+    __get_user(host_ip->mode, &target_ip->mode);
+    __get_user(host_ip->seq,  &target_ip->seq);
+    __get_user(host_ip->key,  &target_ip->key);
+}
+
+void host_to_target_ipc_perm__locked(struct target_ipc_perm *target_ip,
+                                     struct ipc_perm *host_ip)
+{
+    __put_user(host_ip->cuid, &target_ip->cuid);
+    __put_user(host_ip->cgid, &target_ip->cgid);
+    __put_user(host_ip->uid,  &target_ip->uid);
+    __put_user(host_ip->gid,  &target_ip->gid);
+    __put_user(host_ip->mode, &target_ip->mode);
+    __put_user(host_ip->seq,  &target_ip->seq);
+    __put_user(host_ip->key,  &target_ip->key);
+}
+
-- 
2.42.0


