Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4620D820A7A
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:46:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrRc-00046C-De; Sun, 31 Dec 2023 03:45:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRb-00045w-3Z
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRZ-0000aM-Jr
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nDX18rQzfx3gtQnNpN0Ak1p49HXoO+gMl+0M11BxWl8=;
 b=CGEmJX6ICZCen9bMetDLAvpMY0/waokNIg/j0ZEIs/SdHZtCz/uX7udzzJkRt0vPRdpKVl
 vdpQXmNPrNMxPCpME6uxV7GOP3MBbSthiTb62RHTbgpZOgMTRj6zB+aTYvtFAZ5C26YdtE
 +VXd5T5q+lOm48qF4YdusnIplAccUlE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-2KbePOOwObONDXEK3EkusA-1; Sun, 31 Dec 2023 03:45:10 -0500
X-MC-Unique: 2KbePOOwObONDXEK3EkusA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a27c3388fb7so37779066b.0
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012309; x=1704617109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nDX18rQzfx3gtQnNpN0Ak1p49HXoO+gMl+0M11BxWl8=;
 b=L7n29uF2Y0kgpswlfkmdMclvg/CdLQTvcwe34VJfCJs5FJJMliJQ31zkQDeBr4/JJy
 xbbo4f26kxihEh0KPZxwWXDV5p5djukA5iXna2c63nYtfMHeXGdTxq4Lokp7KWbIV2IL
 699w+ZhtRSvWmxUmjdrAR9U7BUd19iosLBYxZSUDl5zyUbyynCN9l0afgkX/ngu0Trxk
 TVL6HA1JOCslY03MKuIQRLb1RV91emKVRSxwFkeBD2KCMx3gVYHoRxfMboDTxtwOg1P9
 fwdRsPMs2H4n1mv8zQu7odkq6A1j6zCgwHlPMijPkSaE6pg2oZtmziBbBPFrgLIYh/kQ
 vNVg==
X-Gm-Message-State: AOJu0YzM3umpTSVetk/SuoTy31qysGgWq0p+i4K/ndgspdJ1ZF/qsJJE
 lNkosANgi42QI5ZmPrsI7rWptV5I6MTqjJD1AkWYChO/CU1ZglJD+Cb0HIfnNenDw4e+IlW/EnY
 mCRa/TIaU2zMA2/h+DWk3N/b/imgzdWY1gIw6Vg4PuSzzoM/svynNtHi3oxZoLScn9JgSsqgrCY
 p0ulXNWgs=
X-Received: by 2002:a17:906:224c:b0:a27:7c2e:420a with SMTP id
 12-20020a170906224c00b00a277c2e420amr2197793ejr.8.1704012308856; 
 Sun, 31 Dec 2023 00:45:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+CtkTgo/wmVem4gxcVrJaFZ2/Pa16R30yjYgQzHHGvXtw0ky7BWplIi4uI/86XIQiWeQE2Q==
X-Received: by 2002:a17:906:224c:b0:a27:7c2e:420a with SMTP id
 12-20020a170906224c00b00a277c2e420amr2197784ejr.8.1704012308476; 
 Sun, 31 Dec 2023 00:45:08 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 hg2-20020a170906f34200b00a26b361ec0esm8730588ejb.118.2023.12.31.00.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:45:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 01/46] configure: use a native non-cross compiler for linux-user
Date: Sun, 31 Dec 2023 09:44:17 +0100
Message-ID: <20231231084502.235366-2-pbonzini@redhat.com>
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

Commit c2118e9e1ab ("configure: don't try a "native" cross for linux-user",
2023-11-23) sought to avoid issues with using the native compiler with a
cross-endian or cross-bitness setup.  However, in doing so it ended up
requiring a cross compiler setup (and most likely a slow compiler setup)
even when building TCG tests that are native to the host architecture.
Always allow the host compiler in that case.

Cc: qemu-stable@nongnu.org
Fixes: c2118e9e1ab ("configure: don't try a "native" cross for linux-user", 2023-11-23)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index bdda912f362..d7e0926ff19 100755
--- a/configure
+++ b/configure
@@ -1387,8 +1387,8 @@ probe_target_compiler() {
   done
 
   try=cross
-  # For softmmu/roms we might be able to use the host compiler
-  if [ "${1%softmmu}" != "$1" ]; then
+  # For softmmu/roms also look for a bi-endian or multilib-enabled host compiler
+  if [ "${1%softmmu}" != "$1" ] || test "$target_arch" = "$cpu"; then
       case "$target_arch:$cpu" in
         aarch64_be:aarch64 | \
         armeb:arm | \
-- 
2.43.0


