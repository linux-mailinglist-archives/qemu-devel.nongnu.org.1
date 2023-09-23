Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CA67ABF0A
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 10:57:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjyQQ-0002xs-75; Sat, 23 Sep 2023 04:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyQO-0002xX-2C
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyQM-0000aY-OE
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695459338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3JK2tj7whN8l41R/kMQ/GZt9XPUjOpzPaF7tlFY13Pw=;
 b=axShES/LFsl9a5cGnIJvvUoIuXD8424eUPBdB6ZyjSWgKDVIZDTL9dCCsIh95bL7bcfVdT
 U8MkUZhdz0Zai0A7GZy7dIH6Sg8Sh60SD5/pj94iAfSC5oytoZpdFiQ5YLsH7x15d4OU/b
 27MdtEZxX2PoiuENgk1n9lcRFaA+T6E=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-Wyoz4CKdO2uKeBjybqgNxA-1; Sat, 23 Sep 2023 04:55:36 -0400
X-MC-Unique: Wyoz4CKdO2uKeBjybqgNxA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5030ed95acdso4637112e87.2
 for <qemu-devel@nongnu.org>; Sat, 23 Sep 2023 01:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695459334; x=1696064134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JK2tj7whN8l41R/kMQ/GZt9XPUjOpzPaF7tlFY13Pw=;
 b=NPlV1EzFjxslXj26F/b0xdPE5jj1k/43MXLvHsSf2+patmAhI8WwXn9/qdQ0ew/Aj/
 jkJcOKSq8zTUI1Fri9wbKG9HpKEBbtfN9B7IkyBoZvVVnSEbJG1YEYvIBPdW5v/MLN+Y
 HXLSvA9gkoKaCpB8Jv+6b1yESmaAq/zpvgec5CPu2k9kRMzPNvffIavAja3vkOKp4FeE
 +ZTco/g3kHXA7+HIdqwXopSq0sqK8AFS+fgnIHaZA3+Z14W6snHBZYhDSB7A41i1TNTV
 PV7dqcX1HKBfSVtEXxe08d3KCetwAuQMupcxrfxBjlCLYZ8Kn17bVX73k4bY58o3woS7
 PesA==
X-Gm-Message-State: AOJu0Yyf+YKr2EthtZWi/UVgrz7l7KImoBvPJ9DBbT5+pQ7FPo76M7+G
 zNi6wOzBnpMJEERKMXKyeFHyuup8YnqiTX3GHpwhA29SR3GrKQYjQbNYM+o4ZXgEY2ifdWAqmov
 DrX7T9vk7Foym/4Aice4FwcB+x2r7IJMhMHjZTzhQah7R2nngeoO/Mg7MDUxSmx1t+tn6U2wzD3
 0=
X-Received: by 2002:a19:4f10:0:b0:503:8fa:da21 with SMTP id
 d16-20020a194f10000000b0050308fada21mr1561736lfb.43.1695459334350; 
 Sat, 23 Sep 2023 01:55:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiU+OE/a92jGODlRI6oSj0hoIw1caDPCOv6fuKXH3oIi5W1pE6cNe/aG8aFmIH2JOOrRLpzQ==
X-Received: by 2002:a19:4f10:0:b0:503:8fa:da21 with SMTP id
 d16-20020a194f10000000b0050308fada21mr1561727lfb.43.1695459334065; 
 Sat, 23 Sep 2023 01:55:34 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 z8-20020adff748000000b0031fedb25b85sm6420699wrp.84.2023.09.23.01.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 01:55:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com,
	vr_qemu@t-online.de,
	balaton@eik.bme.hu
Subject: [PATCH 13/13] audio: forbid default audiodev backend with -nodefaults
Date: Sat, 23 Sep 2023 10:55:06 +0200
Message-ID: <20230923085507.399260-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230923085507.399260-1-pbonzini@redhat.com>
References: <20230923085507.399260-1-pbonzini@redhat.com>
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

Now that all callers support setting an audiodev, forbid using the default
audiodev if -nodefaults is provided on the command line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index 7dd95018a05..3489fd07b20 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1804,7 +1804,7 @@ static AudioState *audio_init(Audiodev *dev)
 bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp)
 {
     if (!card->state) {
-        if (!QSIMPLEQ_EMPTY(&audiodevs)) {
+        if (!QSIMPLEQ_EMPTY(&audiodevs) || !defaults_enabled()) {
             error_setg(errp, "No audiodev specified for %s", name);
             return false;
         }
-- 
2.41.0


