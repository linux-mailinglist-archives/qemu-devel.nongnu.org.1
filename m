Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA217C9F95
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:32:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsH8i-0003tL-34; Mon, 16 Oct 2023 02:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8f-0003sQ-P4
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8e-0005RV-3R
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P/65hish4h+ImSzGo/R7iAwPvFu/GpagzDRiJtmjaPI=;
 b=NSvzrMVTfpCwggmGAazLbufQ0Z6Zn6FCCCKTBMXQXTe9YnltxUocJOyll/f9RLbnS5KaLv
 ZnezmSVB/1jQQ4CqJOu+cvvUnMGyatsbrrfEJZPC2uBrqjua3RXZBQxheVdh53eqqFHjT2
 FOrY2XGMZ75EVolDyqXMh5HHl+blGKw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-YOCIWuZXOy-nsB_XhhaPlw-1; Mon, 16 Oct 2023 02:31:33 -0400
X-MC-Unique: YOCIWuZXOy-nsB_XhhaPlw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9a681c3470fso298169566b.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437891; x=1698042691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P/65hish4h+ImSzGo/R7iAwPvFu/GpagzDRiJtmjaPI=;
 b=QF+/smCSzSDFZzNJIbyl+IEbisXo+9UEXvt59v57VCOEGGr96krhXZ59QXcVezj3Dt
 6gnyrm7P3EvuebjigWblMvyq0ZYc15QXps9/Yh8Mnci+GiOS4SepTLLsVNqXTLbHFVX2
 MhfyQaz0yu0BroRb6XNLBGLWdhDjpf+cKjdrn1TXuHjym6jsAdp8XKTK3fnipzQ4t5tv
 WwYuxLedsZ6kkFDQDRSdzxeRkycDPf7PlfJE04eSNnw0SYqQHTUa9deWIk8k4MkHMDfT
 xWUMcxyvDxzSpjmyWvmENLQH3jpf/iXW/tRFk0HnZCCX5+YJFfn6+OjPIRu2Gt/aKSle
 24vQ==
X-Gm-Message-State: AOJu0YxW3R7ZRvTxqbBYkZQz436cUvapjv7J3MO1h7dFGrLBwJ8i1vAz
 dLrChMv8tfjP/f4OwdkCDUUrqozyqYsyd3nNt5Jcg2slVbjuLeGfP0nnmQ9OItfN2v76lNClmcw
 iJ7dsOfMhNzXCWSIwOxn4v893DpvfBxjCiqq2U98Qj4Yq+qQ3hq7ZxO/cxXkWPZpM2ovZo/bCwV
 8=
X-Received: by 2002:a17:906:57:b0:9bd:931e:30d8 with SMTP id
 23-20020a170906005700b009bd931e30d8mr8273166ejg.14.1697437891412; 
 Sun, 15 Oct 2023 23:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUCXVSxXg/jSqUvg0c5Xh4HJm1WJvB7Ax6+AdUCSo1qFiTc6i0bkVxntRNaWv8wraDkFckDg==
X-Received: by 2002:a17:906:57:b0:9bd:931e:30d8 with SMTP id
 23-20020a170906005700b009bd931e30d8mr8273151ejg.14.1697437890942; 
 Sun, 15 Oct 2023 23:31:30 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 17-20020a170906029100b009786c8249d6sm3431135ejf.175.2023.10.15.23.31.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:31:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/17] meson: do not build shaders by default
Date: Mon, 16 Oct 2023 08:31:11 +0200
Message-ID: <20231016063127.161204-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016063127.161204-1-pbonzini@redhat.com>
References: <20231016063127.161204-1-pbonzini@redhat.com>
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

They are not needed when building user-mode emulators.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/shader/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/shader/meson.build b/ui/shader/meson.build
index 592bf596b9a..3137e65578e 100644
--- a/ui/shader/meson.build
+++ b/ui/shader/meson.build
@@ -10,5 +10,6 @@ foreach e : shaders
                 output: output,
                 capture: true,
                 input: files('@0@.@1@'.format(e[0], e[1])),
+                build_by_default: false,
                 command: [shaderinclude, '@INPUT0@'])
 endforeach
-- 
2.41.0


