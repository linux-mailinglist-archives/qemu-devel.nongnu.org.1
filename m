Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 070BDA13EB8
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Jan 2025 17:05:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSLf-0003z4-9B; Thu, 16 Jan 2025 11:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSKy-0003UA-IQ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:18 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSKu-0001Dm-9t
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:16 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso607690f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043390; x=1737648190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7fkCPXOa8A9Xl79fpL/YYXVm1xiiiaH5KvVpCQywK3U=;
 b=l3KhOnra/ebllztPf8lZiKoPSuFutKDaLy24gnm7FUd0Ri9urTMRSTwZJWVmSecI7F
 pX9fQsgO8PWVP3Z1L9E9gogqMSLupzfOHekSR137/vbdIYjFfCOwdtCY5nyOIRPpm3hM
 T1EBCeQnuaBPhSpZWMrM8jNMjKx6xVBbYYm09l4CR5VRewqgGplX4amR8fbFFi//7IHl
 hQOENcSumNPkRWDMGtBQFP1WiOBLrL7E90Je7+HD65knfvubaHo66fFIgiZwP1XBBQd9
 jg37P1lPUN0X1ydt85ugtP2VHqUl+I2b1MRo7rrFaiUSp6gqUBe9CPElIVrUYUFyopiy
 v+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043390; x=1737648190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fkCPXOa8A9Xl79fpL/YYXVm1xiiiaH5KvVpCQywK3U=;
 b=H9wubZ/SUHbUF76XhkMX+S5/OuqkjtU/JUTMJnsYItpfz9UOxqeh96p1JDGOhZll13
 OKT3aW4iZrFuJJeKLW/CWVVTDzCju8Mdp/j06N7cwG+yUDZwRXeG4aipWNccVSoa3J4Z
 cg2PTrNuspuO8qAMKpOySG8c5qPUeZm53OY7nyAKZHorVPQf6ALX5C12IUwkWZD+BB61
 7vPTQsvFwqp915kRWBuWADNaCcycE8oUy2xi4WoQFahsk9ctVmJqi6GadzJxfwVaag1L
 DJ1vwbnOc+Yy0N8P+xAKPC0pky/nJflDa1QcjV1zygE6XyOj52+iosCAJG/nLZZXxbRN
 BgaQ==
X-Gm-Message-State: AOJu0Yw8s6lujWPgBHGZrGD0DnudnBJcWGJeayMRT3QRq85nRpAKQPZN
 XXrkrhX9UTAbdp/ZxXAB7uwSdZq8xCLEBrHnHva7boNsAlaxKAS4Am5bFSHK9gs=
X-Gm-Gg: ASbGncs7/WjyvlbT/iqt8yX6CFo2dkip0jYSeINOFHV7vLsTery7VhbTaNMLZe48gNz
 XxgBlAa0eBVFXwd85HVa+Ko0KqKLmGExSzQ9ZFjlWyNdNniGr9oZyjzM4tlHpD5KZx5cSrXzEZn
 s16k4L45SNETgiDNHxHpf+NCGKxS37DJVomSiAi2JX+k8c0p0iS8wQlf7BFaOWTobMWgP/8qKjz
 PXYSLXe801RcF1UmMYrgMYuq0AL7YwjXYhw32KAS795JrGoeyydLwQ=
X-Google-Smtp-Source: AGHT+IFa4n+BncQnewR1Jg1djeKaVr4RR2pXWc1CHFzSf5t4d46GkYoAjeRWZ7tTyFjZ3QegYwekIQ==
X-Received: by 2002:a05:6000:184e:b0:385:f560:7911 with SMTP id
 ffacd0b85a97d-38a872c93e3mr31122860f8f.10.1737043388342; 
 Thu, 16 Jan 2025 08:03:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf32754f5sm203303f8f.79.2025.01.16.08.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:03:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C6CE760853;
 Thu, 16 Jan 2025 16:03:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 04/37] semihosting/uaccess: Include missing
 'exec/cpu-all.h' header
Date: Thu, 16 Jan 2025 16:02:33 +0000
Message-Id: <20250116160306.1709518-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

TLB_INVALID_MASK is defined in "exec/cpu-all.h".
Include it in order to avoid when refactoring:

  ../semihosting/uaccess.c:41:21: error: use of undeclared identifier 'TLB_INVALID_MASK'
     41 |         if (flags & TLB_INVALID_MASK) {
        |                     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250103171037.11265-3-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/uaccess.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index dc587d73bc..382a366ce3 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/cpu-all.h"
 #include "exec/exec-all.h"
 #include "semihosting/uaccess.h"
 
-- 
2.39.5


