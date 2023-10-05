Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FE87B9D26
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 15:00:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNvu-0007Sf-PF; Thu, 05 Oct 2023 08:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNvs-0007RG-FS
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNvq-0007it-RH
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696510702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ed06irNTewW21WPI2pKDoWbJ0mZWVCO4roCwazcqpEM=;
 b=d1NilcgcJJGXcA8PjRiJsTa3HY4iAfvUjDtcLmH3dS9Ffsxciq0Gn4UTl+LZVzXLXUk8If
 7kCia/hDsk4yhaOTxhDVpfV+yXILqNFnz+XfUQNs4ZOTLO0VjNDMyVbEd8I9KmweMiDtSN
 4SAXZnKP7ZhJ7BQFR20sHTuPtkDw7Sc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-QzYPirfHNE2JHgtA9mueJw-1; Thu, 05 Oct 2023 08:58:20 -0400
X-MC-Unique: QzYPirfHNE2JHgtA9mueJw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-99bca0b9234so79970066b.2
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 05:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696510698; x=1697115498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ed06irNTewW21WPI2pKDoWbJ0mZWVCO4roCwazcqpEM=;
 b=WyORhf7Zhn16WxWEF9P3hzKcboZiJF+J9lQIkvzKkNzbylz2uPvIm0K4gG/RqHQbrt
 2GRd/+/XFlcI47VFZpDCG45ETNcgGmLeT3ZFkiT7l/e+gAeKXATNbahdoaJ9VvAi1NoI
 Y42erj3nnYntyvQ4CQ36oCOz0U8BKYJ8v2nrR256MkpcUgoMfyb6YXwSiuxFnvWa5RWH
 eFfNNcx7dFMVTsUewAVw2a1NakgfsS8yixV6viD59rGBQByiAghUGk7UttxI9LUlsYz1
 pzmNrxdLUSivyhpZW1ZaHjrodJIhT5bAoiT+kC0xb0hL4ukzknsN4sexNLnn91NQnECd
 Twnw==
X-Gm-Message-State: AOJu0YzV6MZWeuTaoV66FuzEzve9GORQLNyDBbUwg1rF+HVKhCZfeSWf
 trlOl/conX+RNTaof1Hb5OHqNyFgKjEKvbCCg9t5SQ39NKC++buShE1rxknv7JkXH3hCXZZgYoa
 o2mN/GyID52fnOdrZUZC+QbEgV71q2yI3wlBSCoU6HDNclXWLdpwEn04qi4Lkb9fMyoguelacqB
 I=
X-Received: by 2002:a17:906:74ce:b0:9ad:fcf8:e81b with SMTP id
 z14-20020a17090674ce00b009adfcf8e81bmr4925382ejl.51.1696510698775; 
 Thu, 05 Oct 2023 05:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV51rOF36/nsISJETnOlThXYjP7D1mjvSkqF2hcYjjImLMC6I4h1wvOIcLXjemYjYJKfsZ9Q==
X-Received: by 2002:a17:906:74ce:b0:9ad:fcf8:e81b with SMTP id
 z14-20020a17090674ce00b009adfcf8e81bmr4925368ejl.51.1696510698473; 
 Thu, 05 Oct 2023 05:58:18 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 g20-20020a17090613d400b009b96e88759bsm1211085ejc.13.2023.10.05.05.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 05:58:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	berrange@redhat.com
Subject: [PATCH 1/7] audio: error hints need a trailing \n
Date: Thu,  5 Oct 2023 14:58:09 +0200
Message-ID: <20231005125815.66082-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005125815.66082-1-pbonzini@redhat.com>
References: <20231005125815.66082-1-pbonzini@redhat.com>
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


