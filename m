Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD62820AA2
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:54:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUo-0007oX-De; Sun, 31 Dec 2023 03:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSv-00057r-Pw
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSn-0000qZ-Jy
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7KHsaL4UQVL7EB67oxOli3jIm09+5F03qAdq+7G5z8A=;
 b=IOf5oxr+05lOFQl1hdU59rgQKyXe3UVtazTcNfmR5qdmSSrTogIS5KJ20bWaQwMc0rlpik
 SNdmSjTF5oH8VvWGtxGbwiVCr19Z7B4CWGRp4Ef1IkkdNbn4C3GG++NStqV75yXI3TH9fV
 3dXTyZfRzPejdyWzXiuoUaZiyYFK1qk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-2O7pk916MBOadHEng1mM0w-1; Sun, 31 Dec 2023 03:46:21 -0500
X-MC-Unique: 2O7pk916MBOadHEng1mM0w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3367c893deeso5697496f8f.2
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012379; x=1704617179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7KHsaL4UQVL7EB67oxOli3jIm09+5F03qAdq+7G5z8A=;
 b=RkLuwNq4dxqafCLu3ibV7ClK4pcXmR4Cw2gL7Oq8c5NNAYJ+QOHAn48oIrQv87xzXH
 66OuWjt0dI0q785rxvXzOzrSu6q7el3BdeEEUD/8yqX1nb79t4K9Htlz6i2CgLyNgboB
 //67pvP9dkrNvCT+aMj9qNYlU+KPJ0fJ5lwvzQVuT215g9Qu0CEmc0Rl5EoaMcKIxqnI
 6hRjCdebGmUS9pVxJdL+pKHvS2xVCLdrezVwVYLt7V10QtO0Myn9k+uFLQo6+Xvmqv2A
 vZ/5UHxl3LpsSxjEsYpYadsRRN8fQqk/aAORExv0DfLp4b6tQu0RC3II6jg+6lp6Ecdi
 3WwQ==
X-Gm-Message-State: AOJu0YyHHMnbcbP+jqzBlBavkdRK4qFs5iIXSUbDfBtJXCFHE9+JdnTi
 iX6D43NurfjutbPpXriuUZ0UzsKLo0LAI8JKrx+TvZAWFjvWfus51sAue2ZZBG1wn6pQXWyFXGY
 qvL6xdC6JtZhWdWFePUPpjs4PVRtneyPRR1geeJ8mMRppp2eF5qOPgvOgGXyMKN+hgD43vhI+5J
 Gn7Z4DXlk=
X-Received: by 2002:adf:f38e:0:b0:336:8589:104e with SMTP id
 m14-20020adff38e000000b003368589104emr5156417wro.57.1704012379646; 
 Sun, 31 Dec 2023 00:46:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9I55UX1NIoTNyOsZpuXKhN6MHExctEPFUqkRWo+nc1YtVE7bVQ0N1/si6fqMZ9qJFuxQ57A==
X-Received: by 2002:adf:f38e:0:b0:336:8589:104e with SMTP id
 m14-20020adff38e000000b003368589104emr5156410wro.57.1704012379322; 
 Sun, 31 Dec 2023 00:46:19 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 h4-20020adff184000000b003368129ecc6sm23029419wro.108.2023.12.31.00.46.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/46] meson: use version_compare() to compare version
Date: Sun, 31 Dec 2023 09:44:43 +0100
Message-ID: <20231231084502.235366-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

While a simple lexicographic comparison usually works, it is less
robust than a more specific algorithm designed to compare versions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qga/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/meson.build b/qga/meson.build
index ff7a8496e48..a6af614891a 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -140,7 +140,7 @@ if targetos == 'windows'
       qemu_ga_msi_vss = ['-D', 'InstallVss']
       deps += qga_vss
     endif
-    if glib.version() < '2.73.2'
+    if glib.version().version_compare('<2.73.2')
       libpcre = 'libpcre1'
     else
       libpcre = 'libpcre2'
-- 
2.43.0


