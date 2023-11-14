Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDE27EB2B1
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:43:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2uZc-00045w-QI; Tue, 14 Nov 2023 09:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uZY-0003vS-V8
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:39:25 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uZW-0007rV-6G
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:39:24 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9c3aec5f326so1371853366b.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699972760; x=1700577560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UNMQSJ9n3HwpNaurQlo3tUtiIa6U/WmLwhKlbRCATs0=;
 b=YKir5xkbZMUa5VyeT0M146UG85J6ih46ZG69t0S93uPjoGvaEgLXq22kD0j6gApUON
 9zxxEaiIUIVzS8Do7YmV95p2BV3u/FQc2Xnd44KBUcWROMRwbtvYRluTz1yhN/eIhJQK
 iDARnN1u2yt5/3wKa3chiLQOESvr5GTE+8pySUby2LJqCK4yGMRRwR/951VVrNQnM2jV
 GBQj7Hd5omTgZ/8VZDXhfGQuw84InB8LNeHNEDCspIMsO24vFXdeZOnzxXn5rMZlV0et
 6DksIIwafpB6s5MiVeN6fWRckaKrnksjB+3iOBiq8IwJRo+l3TT/FX3ducwUZK0R6V7L
 BlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699972760; x=1700577560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UNMQSJ9n3HwpNaurQlo3tUtiIa6U/WmLwhKlbRCATs0=;
 b=MjxjEFAPVjX+CArCp7vLHemY6MB31a4bqdjiQ9OerCx4/TwVcIsoB2tQsfylP7TjGC
 oNqki1grb+QxchvGx+/q0eWEh22b83nMZliZb9tUUKfGv0C4WaEDWiJ0jjOgjq7ujl4C
 In1mNWhBudtgsPetVuKilCC/HmlRc+M+pf7ZoGc/z6bTeKgIm2C3UPAOkPFbf+6he4P0
 zbJXywIbA8Hx2jBOMDtqVC5YQTnylpOKkvjPi7Icu60K+l1/LWj07kIYK0DMG7C19TjN
 nePQW8Eppl42y6T/GdS1qPTwkdUMz7ln20M59l2ZfPyYvaOBKkytFRb4AGHI3qts2YRH
 Gm1g==
X-Gm-Message-State: AOJu0YyTiJoJA2gsibe2BxUJZaxlkZED0/MFCNJUGwV9J+nBl+QIuSrc
 deuae8a85M/28Ig6eBlOOJe29A==
X-Google-Smtp-Source: AGHT+IEprkHMikBtwTk6Pc2HglM2aACFqynKnIxKilr0MgI5mWMBku8mpMF5XwofVv89mcZ1ndbJxA==
X-Received: by 2002:a17:906:d7b2:b0:9ef:b466:abe0 with SMTP id
 pk18-20020a170906d7b200b009efb466abe0mr1430110ejb.8.1699972760684; 
 Tue, 14 Nov 2023 06:39:20 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 rp13-20020a170906d96d00b009ddb919e0aasm5622830ejb.138.2023.11.14.06.39.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 06:39:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>, kvm@vger.kernel.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [RFC PATCH-for-9.0 v2 09/19] hw/block/xen_blkif: Align structs with
 QEMU_ALIGNED() instead of #pragma
Date: Tue, 14 Nov 2023 15:38:05 +0100
Message-ID: <20231114143816.71079-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114143816.71079-1-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Except imported source files, QEMU code base uses
the QEMU_ALIGNED() macro to align its structures.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/block/xen_blkif.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/block/xen_blkif.h b/hw/block/xen_blkif.h
index 99733529c1..c1d154d502 100644
--- a/hw/block/xen_blkif.h
+++ b/hw/block/xen_blkif.h
@@ -18,7 +18,6 @@ struct blkif_common_response {
 };
 
 /* i386 protocol version */
-#pragma pack(push, 4)
 struct blkif_x86_32_request {
     uint8_t        operation;        /* BLKIF_OP_???                         */
     uint8_t        nr_segments;      /* number of segments                   */
@@ -26,7 +25,7 @@ struct blkif_x86_32_request {
     uint64_t       id;               /* private guest value, echoed in resp  */
     blkif_sector_t sector_number;    /* start sector idx on disk (r/w only)  */
     struct blkif_request_segment seg[BLKIF_MAX_SEGMENTS_PER_REQUEST];
-};
+} QEMU_ALIGNED(4);
 struct blkif_x86_32_request_discard {
     uint8_t        operation;        /* BLKIF_OP_DISCARD                     */
     uint8_t        flag;             /* nr_segments in request struct        */
@@ -34,15 +33,14 @@ struct blkif_x86_32_request_discard {
     uint64_t       id;               /* private guest value, echoed in resp  */
     blkif_sector_t sector_number;    /* start sector idx on disk (r/w only)  */
     uint64_t       nr_sectors;       /* # of contiguous sectors to discard   */
-};
+} QEMU_ALIGNED(4);
 struct blkif_x86_32_response {
     uint64_t        id;              /* copied from request */
     uint8_t         operation;       /* copied from request */
     int16_t         status;          /* BLKIF_RSP_???       */
-};
+} QEMU_ALIGNED(4);
 typedef struct blkif_x86_32_request blkif_x86_32_request_t;
 typedef struct blkif_x86_32_response blkif_x86_32_response_t;
-#pragma pack(pop)
 
 /* x86_64 protocol version */
 struct blkif_x86_64_request {
-- 
2.41.0


