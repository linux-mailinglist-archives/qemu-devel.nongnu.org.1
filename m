Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4238A8010F8
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:17:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r977H-0002ul-Jn; Fri, 01 Dec 2023 12:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r976v-0002pY-C6
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r976r-0007bK-PD
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701450917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HcqmRn12BT+d9v+3hVGltIEaZdiZEdqOlouvfncpm0k=;
 b=TD7zRenJGyNbFMBoJwm1g/hVdTpPDDEsxPws64zYNXLtzbvdKKU5z2U7FQwA/kHsCjgyeF
 Y4/L0+vBJSWjbY8IpWzr57/hOwa/NfD+tc0NJAAp8ONXcKYBpXLYnTwqvSrd33/0FtwJ7T
 pvZapOpOzzC2AG+6UpUI1xmRWXrSQnA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-b5kU4bWbPpWGcR6viWIYmg-1; Fri, 01 Dec 2023 12:15:16 -0500
X-MC-Unique: b5kU4bWbPpWGcR6viWIYmg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40b3dbe99d9so17264545e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701450914; x=1702055714;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcqmRn12BT+d9v+3hVGltIEaZdiZEdqOlouvfncpm0k=;
 b=oijAoO2wXBYZqke3a3dUjUpooNNCcuvc7PBvlRkvg+gSmPHyGGbGPkYrsBSsn2v0Iw
 NNLleqz5Y5I9Ay8txnX9/VQ+9yqSwt7SXksZCy5zRSOyq3BRBLH0yWhr8cXnYni+FUHs
 M3dScgj6OSF28uLwGhTgoOaGImsQaYqL2biOlDbHstvl1nmMfqZfe9q5U+dx3Y2jMpgG
 KieBvDjgsdegPhfxhYMKizGZg81NGPLRDMi1LzAVFER3cjDhbVdUp11F3MOmC6T2LtB9
 ycOwYU2gnh3t9LwvKVY3tVL0iSyb0OUNyHfQNV3SVRpl8kfk9/ai4LRZ9H5JhemdeAFz
 tGGg==
X-Gm-Message-State: AOJu0YzcsabRP58s1+EU1VIfc9D0kc9KrZlDfXK+cDNyd+0mExneqCkZ
 K9HtE6hsaJSF/ypJnVA/+3bDN2HXSsj2RSzq4+k/bYa2xKMhBu0BW0bbV/cmLCrxosYyWBhwyv0
 +chzTLN3BtdkGnr+smXF8Dm+P+JUCOoImkk0rhjonsxHpBJR6PVdl5I+NhVJrexeFQKsi
X-Received: by 2002:a05:600c:a0a:b0:40b:5e21:cc34 with SMTP id
 z10-20020a05600c0a0a00b0040b5e21cc34mr542514wmp.95.1701450914391; 
 Fri, 01 Dec 2023 09:15:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKMUAYwlJscWdCMj9DOg7fjL/7mwTAeBidRLBU1VxhSjtszUcku/Oo/S90/pNqrqxj5NTD4w==
X-Received: by 2002:a05:600c:a0a:b0:40b:5e21:cc34 with SMTP id
 z10-20020a05600c0a0a00b0040b5e21cc34mr542500wmp.95.1701450913845; 
 Fri, 01 Dec 2023 09:15:13 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e1:6f00:c7ce:b553:4096:d504])
 by smtp.gmail.com with ESMTPSA id
 j14-20020a5d464e000000b003330f9287a8sm4708469wrs.51.2023.12.01.09.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 09:15:13 -0800 (PST)
Date: Fri, 1 Dec 2023 12:15:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/15] osdep: add getloadavg
Message-ID: <dc864d3a3777424187280e50c9bfb84dced54f12.1701450838.git.mst@redhat.com>
References: <cover.1701450838.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701450838.git.mst@redhat.com>
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

getloadavg is supported on Linux, BSDs, Solaris.

Following man page:
RETURN VALUE
       If the load average was unobtainable, -1 is returned; otherwise,
       the number of samples actually retrieved is returned.

accordingly, make stub for systems which don't support this function return -1
for consistency.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/qemu/osdep.h | 10 ++++++++++
 meson.build          |  1 +
 2 files changed, 11 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 475a1c62ff..d30ba73eda 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -779,6 +779,16 @@ static inline int platform_does_not_support_system(const char *command)
 }
 #endif /* !HAVE_SYSTEM_FUNCTION */
 
+/**
+ * If the load average was unobtainable, -1 is returned
+ */
+#ifndef HAVE_GETLOADAVG_FUNCTION
+static inline int getloadavg(double loadavg[], int nelem)
+{
+    return -1;
+}
+#endif /* !HAVE_GETLOADAVG_FUNCTION */
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/meson.build b/meson.build
index ec01f8b138..d2c4c2adb3 100644
--- a/meson.build
+++ b/meson.build
@@ -2293,6 +2293,7 @@ config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
 config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependencies: util))
 config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul'))
 config_host_data.set('HAVE_SYSTEM_FUNCTION', cc.has_function('system', prefix: '#include <stdlib.h>'))
+config_host_data.set('HAVE_GETLOADAVG_FUNCTION', cc.has_function('getloadavg', prefix: '#include <stdlib.h>'))
 if rbd.found()
   config_host_data.set('HAVE_RBD_NAMESPACE_EXISTS',
                        cc.has_function('rbd_namespace_exists',
-- 
MST


