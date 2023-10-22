Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 850457D2250
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:30:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUkT-0003A7-Px; Sun, 22 Oct 2023 05:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUjh-0001lm-3y
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:27:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUjf-000167-MD
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CD+q+G2pfg+G/fTA/dZ5jOXbDYpzOBEKZujAnzbIZdU=;
 b=B0h+1khtCni6JTtXQUTU2t5nlKJ1yWjU/7GtG7evKWHAqT9GE0EC3qKZrwwODyNPzG92Uc
 dWkSXmke/XAHqPyAbraJ+3REvAgXmyMVE1ur5IE6SB4mMOhT6ao+jrx9otWYbOnGtGo4VY
 WopNx6G7gqJHWPhg4RgNnmwkQYnA9g8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-iQK7ol2OPMq4z2TnVs4dZQ-1; Sun, 22 Oct 2023 05:26:52 -0400
X-MC-Unique: iQK7ol2OPMq4z2TnVs4dZQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32d933caa8eso888817f8f.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966810; x=1698571610;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CD+q+G2pfg+G/fTA/dZ5jOXbDYpzOBEKZujAnzbIZdU=;
 b=Da+PuRgZbShBrrOxWibtp2y8lWgbbwxy8gKTqjqCZWcvvAl4t7dW1PodbVAt4cMsfq
 yW7sLkqB3/OuHshkM2X2ueYb8s7ZSbMlkDsUCs3cZbVSM6JfC1BgsvQ4tK36VDR/zn/+
 9S+mrZp+KiWQkKOuCgeWHXMIdenok6v/T6IR9loH0jziCgrcSCJKEsdbqcj3MlcyLdRl
 nvjzaDv7WuaVh2j6Ocli3czmQazYn8fHaazEG4KEQBOswRXhR1TAHFBwxI3qyWlR+MIy
 dAq6/B8nmLArZj6EV9w8k7cRTTc2lqMbeGNDL0t4IDTj/HUwEu8pR6TaXwfOR3/TO0Kr
 Tsew==
X-Gm-Message-State: AOJu0YxM8dPCJ2aQ9Vcop3QErZ8NYncWUStEgrEqhuKG1hF8rkc5EksP
 DpcH5HEZfGCtkHTUTAHMUqw+gdoKEWS81FXbrA6Ats8sVN2GGM13+arREM8670WiW/90rVz3KVN
 2BL+kxA5WSUkMdqbm2Cp04/6VJ+Ts5xQ6BUByzeBGr+Q3vJe3fY/irYwYuHYXvL9zwnu/
X-Received: by 2002:adf:e551:0:b0:31a:d4e4:4f63 with SMTP id
 z17-20020adfe551000000b0031ad4e44f63mr3920720wrm.18.1697966810621; 
 Sun, 22 Oct 2023 02:26:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtxuj+NZl6lMQ8Mkb27V3FZ2tw6ksqO+rw6YsR2+Gm8YnsAremZMoEDLqhpmMQQngCsddd/w==
X-Received: by 2002:adf:e551:0:b0:31a:d4e4:4f63 with SMTP id
 z17-20020adfe551000000b0031ad4e44f63mr3920709wrm.18.1697966810381; 
 Sun, 22 Oct 2023 02:26:50 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 w5-20020adfee45000000b00317a04131c5sm5298711wro.57.2023.10.22.02.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:26:49 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:26:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v3 61/62] MAINTAINERS: Add include/hw/intc/i8259.h to the PC
 chip section
Message-ID: <5e7abc29c56f7823f9a122898685bdfcfac2e522.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Thomas Huth <thuth@redhat.com>

i8259.c is already listed here, so the corresponding header should
be mentioned in this section, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231017152625.229022-1-thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d9fe5aa367..2f435102ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1764,6 +1764,7 @@ F: include/hw/dma/i8257.h
 F: include/hw/i2c/pm_smbus.h
 F: include/hw/input/i8042.h
 F: include/hw/intc/ioapic*
+F: include/hw/intc/i8259.h
 F: include/hw/isa/i8259_internal.h
 F: include/hw/isa/superio.h
 F: include/hw/timer/hpet.h
-- 
MST


