Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5E37BB62C
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:16:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoinP-0008Pp-Kl; Fri, 06 Oct 2023 07:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinJ-0008He-MQ
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinH-0000Ly-2Y
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ed06irNTewW21WPI2pKDoWbJ0mZWVCO4roCwazcqpEM=;
 b=HmhkR7f5NJUS505umkM5S+wrKOz8yZadiN+z0OTyz8S809ls4mmXyGHhVoHQ8JmSe7RWlz
 nJzjqkTMwew6W9WNGG30VuY4FcZ06OZn99w8iaW1oHja/nYxeBmDQi74t9SXLo/l7wVFWT
 /5n2t4M7PViblsl1zIRugyJJuRn7JyQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-ZfT34JYyMuaTVsOB5Ba_bw-1; Fri, 06 Oct 2023 07:14:52 -0400
X-MC-Unique: ZfT34JYyMuaTVsOB5Ba_bw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99c8bbc902eso169941466b.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590890; x=1697195690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ed06irNTewW21WPI2pKDoWbJ0mZWVCO4roCwazcqpEM=;
 b=KPmJgN3bEZv4xXshie1knIi8e/CxN1W2o+celQC6H0vU+SuwKUM/Zhnv+x1XIONNic
 dTr1aQC46tq2akUPoLxBDkfqzyUIDObmrR/X43+Sq55kLYGk3BXHWVvyxlPBiZpSX7UP
 /MxsQR9eH1dwkjctA6SIpfMeRnuO9nZgXyfH4jjTtyf98WS5Se5e53xXoVUkwKTjcyEX
 M+vY9qdjse0+4EPUpE5mLHHDjdJeEmvILJex2wsOWWqTZl/3hgudUxcZKQExsVtOlETs
 nyy8z/btvKwKef0jbUDqSac/DEUZNAQv14FMTBHamff1B72DJVxX7qPHw3PYh4ZEVFBZ
 TTrA==
X-Gm-Message-State: AOJu0Yw1SyZ6D3zZuvn1M5GjrtbZaEYbcMS024YghUi3fmAnLCDV90uz
 X6ZjoFnIG9LrnhZLF+ABEb8q1QqRIWA7JeODW0T8s7ArYoVVBKyXish7TXknreLysUhiO+5Uf6p
 5ff/yqXe8jp2aAMf/4HC7F2CdQCKasSbdw1nT8Da3w2NpIdM9F7HrrNUNWFCNsqUZ0MNQj0IVQ1
 4=
X-Received: by 2002:a17:906:7485:b0:9ae:5fe1:ef03 with SMTP id
 e5-20020a170906748500b009ae5fe1ef03mr6719431ejl.67.1696590890765; 
 Fri, 06 Oct 2023 04:14:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrH7+mKup4N7Sl0mhAU4ShcidSkBp78af976U/2viwOAsgPRLjenOMiF+Oryyk0OK65GWoaA==
X-Received: by 2002:a17:906:7485:b0:9ae:5fe1:ef03 with SMTP id
 e5-20020a170906748500b009ae5fe1ef03mr6719416ejl.67.1696590890419; 
 Fri, 06 Oct 2023 04:14:50 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 ci24-20020a170906c35800b009a2235ed496sm2756205ejb.141.2023.10.06.04.14.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/26] audio: error hints need a trailing \n
Date: Fri,  6 Oct 2023 13:14:06 +0200
Message-ID: <20231006111412.13130-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index 730bf2498dc..98621576d95 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1833,7 +1833,7 @@ bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp)
             card->state = audio_init(NULL, errp);
             if (!card->state) {
                 if (!QSIMPLEQ_EMPTY(&audiodevs)) {
-                    error_append_hint(errp, "Perhaps you wanted to set audiodev=%s?",
+                    error_append_hint(errp, "Perhaps you wanted to set audiodev=%s?\n",
                                       QSIMPLEQ_FIRST(&audiodevs)->dev->id);
                 }
                 return false;
-- 
2.41.0


