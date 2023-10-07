Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D26F7BC588
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 09:25:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp1ep-000336-1v; Sat, 07 Oct 2023 03:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qp1em-00032h-Eq
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 03:23:24 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qp1ej-0004K7-OV
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 03:23:24 -0400
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso506646466b.0
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 00:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696663399; x=1697268199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xXhSTCjdeCDFfiFN3lw42wFJF7AHAFkavX1+BWvFrpU=;
 b=O30oWnGvVPyw80fjx7qd+xv59XlisOWGhp5R95KON6pCguupWHfPpAW2dOi2YIdIdB
 vCBWf2MJX3yopcttyJ0NLXchpID5hxYWY2fUerQX+Rw8HLD70iii8ABOHtKbw0kU/dG0
 Xulm/el3yjnQcpgCzdEdNZL3AUGz/eC7ziMHSE2QDVN6B8GveEcoxvHDgkFDaVcZ/ok0
 sV9osHbwqB3o3fDFs7dyjZNORyE33/mh0bRPy3mBNJXajBdCz4iCWLHdvixJN4TRZqz7
 f8kmMYlwzwbWJruJSADnxXxPfCGJfWNxJciYCkuhvOk3ggheMHNVdbxKCcKKn1H0gOQ2
 UeNg==
X-Gm-Message-State: AOJu0YwjNMI9AL8pBF4ra2MyZ/DTK55Imu02dNWRNKnyEQdU6bcrB3+P
 x4KNhwSLQzAhhTPlIMicp2FOWAvXnEU=
X-Google-Smtp-Source: AGHT+IEr402NA9422kmkYIykMhOBVdcRa3xE2lz6gKN6oY70VfFowdNEJd+dg+qQOs93wDRGsWAbUQ==
X-Received: by 2002:a17:906:31c7:b0:9ae:673a:88c8 with SMTP id
 f7-20020a17090631c700b009ae673a88c8mr9434370ejf.21.1696663399476; 
 Sat, 07 Oct 2023 00:23:19 -0700 (PDT)
Received: from fedora.. (ip-109-43-176-27.web.vodafone.de. [109.43.176.27])
 by smtp.gmail.com with ESMTPSA id
 fi10-20020a170906da0a00b009ad8796a6aesm3909162ejb.56.2023.10.07.00.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 00:23:19 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] docs/about: Deprecate the 'next-cube' m68k machine
Date: Sat,  7 Oct 2023 09:23:13 +0200
Message-ID: <20231007072313.22108-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.51; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f51.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The machine is incomplete, and unfortunately the hoped-for improvements
never happened. So it's maybe best if we mark this machine as deprecated
and finally remove it again in case it gets into the way of a code
refactoring or other reasons.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 docs/about/deprecated.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 3b074b9ed4..2f6dadd12f 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -253,6 +253,14 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
+``next-cube`` m68k machine (since 8.2)
+''''''''''''''''''''''''''''''''''''''
+
+The machine never got fully implemented and can only show the firmware prompt.
+Given the incomplete state and slow progress on improvements, it might get
+removed again without replacement.
+
+
 Backend options
 ---------------
 
-- 
2.41.0


