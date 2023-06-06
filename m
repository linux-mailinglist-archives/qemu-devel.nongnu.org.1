Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B50C724638
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:34:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xid-00053h-S6; Tue, 06 Jun 2023 10:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xib-00052j-HI
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6XiZ-0001EM-Vx
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lj5av3UWNj/kMdqtmsrtAvKOk0fFWaXs4jRvcp/aN6I=;
 b=bqU2KzhbNps9Atrqa6ZDjScK+7uwtOvFF6U4A6IoU0+2M91BR7oR/utdsw0eGBBtpWAUN3
 QwHFzaDxeXNmQUHbO2xa0F8MwXdY/G4cBf+Ml0MwF+hl3nGpcadkUa4fP+MG/WCTlTsJ3C
 jtIpwThBCznSDt5PkTYGin6Vs1rfzOo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-t-7BObwnMhuVCPaoZ8ifCQ-1; Tue, 06 Jun 2023 10:31:25 -0400
X-MC-Unique: t-7BObwnMhuVCPaoZ8ifCQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a356c74e0so453568566b.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061884; x=1688653884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lj5av3UWNj/kMdqtmsrtAvKOk0fFWaXs4jRvcp/aN6I=;
 b=OWkzwqKVJ0+tZX+IO7bQtchc6kfSG16tL1AsS29f5aEcajqAp43Rw3P3+QkM81emM+
 QiZHEhiGZKqPWojXNJ+doqOpUBzQnGNhIMxGmjMoAQkrWGr55qsErZF6fpG25/n5MmJe
 cU9FUvVyrYPNylPs3bSPwkIBZHbWtF8GhAeg0jKQQCB+UG+fZQ9yjZ4FcfDZTSpu7Pg8
 KumLzMl/awiNCGEO55dCpiI7VxLPUf7hWZNLT+6K9RPm9sosdcCp+sTfe2qylowC1ACt
 2KcWa5QUb2CxidaO94IC3cWLnj78mjljDi4xUb0V4YCvy2KVOv0qlzYjEVj9n3PBZjIS
 FHzw==
X-Gm-Message-State: AC+VfDyrzbV0OaKGt9Xj/BhDYEPSMZYxVvfmQUKyEKJ1smOe/mNjpv2c
 o9G8XAq5I6gZRq/I+/D7ou1OFZ0UoFuOeUD+GzJFfUeK4Jbah/6/yPrCgpD9k+q4KN/MczAJimm
 Km7QWUDalnjwbaTbHyOV9I8ezMG4fSg99nq371l7DfW/P+h/CSx7f1ATdijm1c7EW3I5I2/IDn6
 k=
X-Received: by 2002:a17:907:724c:b0:977:d048:ff9c with SMTP id
 ds12-20020a170907724c00b00977d048ff9cmr2279893ejc.31.1686061884197; 
 Tue, 06 Jun 2023 07:31:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4DVI5uV1xnPukl5n1C+KIV86y9YzmAF2oYd8dyTOV5Az3ldiOux1n1Q/XReJLAJSMDzsxNRg==
X-Received: by 2002:a17:907:724c:b0:977:d048:ff9c with SMTP id
 ds12-20020a170907724c00b00977d048ff9cmr2279876ejc.31.1686061883926; 
 Tue, 06 Jun 2023 07:31:23 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 lu26-20020a170906fada00b009663115c8f8sm5632414ejb.152.2023.06.06.07.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:31:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/21] meson.build: Group the UI entries in a separate summary
 section
Date: Tue,  6 Jun 2023 16:30:59 +0200
Message-Id: <20230606143116.685644-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606143116.685644-1-pbonzini@redhat.com>
References: <20230606143116.685644-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Thomas Huth <thuth@redhat.com>

Let's make it easier for the users to spot UI-related entries in
the summary of the meson output.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230602171832.533739-2-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/meson.build b/meson.build
index 969a84f2a44..cfacd662edb 100644
--- a/meson.build
+++ b/meson.build
@@ -4227,32 +4227,43 @@ summary_info += {'rng-none':          get_option('rng_none')}
 summary_info += {'Linux keyring':     have_keyring}
 summary(summary_info, bool_yn: true, section: 'Crypto')
 
-# Libraries
+# UI
 summary_info = {}
 if targetos == 'darwin'
   summary_info += {'Cocoa support':           cocoa}
-  summary_info += {'vmnet.framework support': vmnet}
 endif
 summary_info += {'SDL support':       sdl}
 summary_info += {'SDL image support': sdl_image}
 summary_info += {'GTK support':       gtk}
 summary_info += {'pixman':            pixman}
 summary_info += {'VTE support':       vte}
-summary_info += {'slirp support':     slirp}
-summary_info += {'libtasn1':          tasn1}
-summary_info += {'PAM':               pam}
-summary_info += {'iconv support':     iconv}
-summary_info += {'curses support':    curses}
-summary_info += {'virgl support':     virgl}
-summary_info += {'blkio support':     blkio}
-summary_info += {'curl support':      curl}
-summary_info += {'Multipath support': mpathpersist}
 summary_info += {'PNG support':       png}
 summary_info += {'VNC support':       vnc}
 if vnc.found()
   summary_info += {'VNC SASL support':  sasl}
   summary_info += {'VNC JPEG support':  jpeg}
 endif
+summary_info += {'spice protocol support': spice_protocol}
+if spice_protocol.found()
+  summary_info += {'  spice server support': spice}
+endif
+summary_info += {'curses support':    curses}
+summary_info += {'brlapi support':    brlapi}
+summary(summary_info, bool_yn: true, section: 'User interface')
+
+# Libraries
+summary_info = {}
+if targetos == 'darwin'
+  summary_info += {'vmnet.framework support': vmnet}
+endif
+summary_info += {'slirp support':     slirp}
+summary_info += {'libtasn1':          tasn1}
+summary_info += {'PAM':               pam}
+summary_info += {'iconv support':     iconv}
+summary_info += {'virgl support':     virgl}
+summary_info += {'blkio support':     blkio}
+summary_info += {'curl support':      curl}
+summary_info += {'Multipath support': mpathpersist}
 if targetos not in ['darwin', 'haiku', 'windows']
   summary_info += {'OSS support':     oss}
   summary_info += {'sndio support':   sndio}
@@ -4267,7 +4278,6 @@ if targetos == 'linux'
 endif
 summary_info += {'Pipewire support':   pipewire}
 summary_info += {'JACK support':      jack}
-summary_info += {'brlapi support':    brlapi}
 summary_info += {'vde support':       vde}
 summary_info += {'netmap support':    have_netmap}
 summary_info += {'l2tpv3 support':    have_l2tpv3}
@@ -4279,10 +4289,6 @@ summary_info += {'PVRDMA support':    have_pvrdma}
 summary_info += {'fdt support':       fdt_opt == 'disabled' ? false : fdt_opt}
 summary_info += {'libcap-ng support': libcap_ng}
 summary_info += {'bpf support':       libbpf}
-summary_info += {'spice protocol support': spice_protocol}
-if spice_protocol.found()
-  summary_info += {'  spice server support': spice}
-endif
 summary_info += {'rbd support':       rbd}
 summary_info += {'smartcard support': cacard}
 summary_info += {'U2F support':       u2f}
-- 
2.40.1


