Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8191820A89
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:50:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUk-0007HP-4N; Sun, 31 Dec 2023 03:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSf-0004xj-Ka
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSd-0000oJ-V8
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qMPfuQKYh8RDla6S4U2P4p48I7GyoAc7S/H6lEUsjtA=;
 b=X06HNrUOvNr4BiydmIRBuTJeNHTGgLd5EVszFbJUHlYOoZNB2rHO3zdcwwfleJXhAeIZ62
 OMkzuJewtEfnIkM5+keuzolA0lKDys90TcLHNTK7vr1/pldzxjhadLMqgCQnz3wgUPeYUX
 CvZiiKRRCTBLJr9fNqNfJ8n6LNjzpKI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-i_itwihiOwSr4mmL_EJjMg-1; Sun, 31 Dec 2023 03:46:16 -0500
X-MC-Unique: i_itwihiOwSr4mmL_EJjMg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-336862fa1a5so5604198f8f.2
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012375; x=1704617175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qMPfuQKYh8RDla6S4U2P4p48I7GyoAc7S/H6lEUsjtA=;
 b=aA7L0POwYmVP/DsIgdxTTV9w197EaVqvs8wuUjWARKLT+cp7bsrtfzND1ntVemEk4o
 hQiC7W8+dY7bFUBoUwbfTOC9kTpKeyzxjQVC0ir7dDRM4fIh5HJSHSPYuorceO8lyxrz
 2XOH5TGZcj5m6vve92vbIevbchGUByAt5eBDfnCcHq/nvJDFodkZsTiYUU0tHx+mPjLU
 PLd4B1pfOUZ6hcC0mygiB2GSjc1vuLFeqtKM298Sff9D+3tXPskEwPQ7M648lJUA/BM/
 tu4c81onELHdF4bcycLKz/f4cdUr22IdjmYdgCqNZL88oo7zwysLPxAJw5g8IWNfA79S
 TUAA==
X-Gm-Message-State: AOJu0Yzgo7Jw5RPoYiYOT57fD9EbHC/6aXCbkmR3Dr0KyJHVm5hu544b
 DbONP9ZW0rX4wkPJE+Lx5heZbu71Hpxtt3ZXs1jd2qH2hirMzYQrED+iX+GOtVCu05O/da1xNTU
 mKVIJBi5PvVY7QmJFKUCaHEFTMPUZBvz11+muNqXcdm9FwBsI7uejCXAsmvxNRYNEuupDGYSCTX
 C0L6rzI2g=
X-Received: by 2002:a5d:6c6d:0:b0:337:3f72:3de2 with SMTP id
 r13-20020a5d6c6d000000b003373f723de2mr122533wrz.36.1704012374970; 
 Sun, 31 Dec 2023 00:46:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVbxlsM36Xkzyin0NtQFFpaCsne78Dr3e4w0JGduUivJSbDSqzJeM/2ooXRwSpSdWrfuH8Cw==
X-Received: by 2002:a5d:6c6d:0:b0:337:3f72:3de2 with SMTP id
 r13-20020a5d6c6d000000b003373f723de2mr122529wrz.36.1704012374673; 
 Sun, 31 Dec 2023 00:46:14 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 o10-20020adfeaca000000b0033677a4e0d6sm23123229wrn.13.2023.12.31.00.46.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/46] meson: fix type of "relocatable" option
Date: Sun, 31 Dec 2023 09:44:41 +0100
Message-ID: <20231231084502.235366-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Since the option is of boolean type, the default value should be a boolean
rather than a string.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson_options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson_options.txt b/meson_options.txt
index c9baeda6395..0a99a059ec8 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -101,7 +101,7 @@ option('cfi_debug', type: 'boolean', value: false,
        description: 'Verbose errors in case of CFI violation')
 option('multiprocess', type: 'feature', value: 'auto',
        description: 'Out of process device emulation support')
-option('relocatable', type : 'boolean', value : 'true',
+option('relocatable', type : 'boolean', value : true,
        description: 'toggle relocatable install')
 option('vfio_user_server', type: 'feature', value: 'disabled',
        description: 'vfio-user server support')
-- 
2.43.0


