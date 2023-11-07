Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5D27E3824
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:50:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Iid-0005hd-GU; Tue, 07 Nov 2023 04:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0Iib-0005hD-VF
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:49:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0Iia-0006Wd-Gk
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:49:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699350595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lSp5s88JqE53+iDjE9NMtQoVBixzW55KFUTn7dS46ns=;
 b=LLm+/0fJhcLZ4TZfGdcPmd00vvu+ddc7gOA5HCn25WAhImNcvrzjMW4aw66q4+SWzoH48k
 3GBcg9myMcXy2pi9MY2jUDg+SxYE03b8eUaNihYiJ/ekz5rtEIMl2Fe2tb4+cvEIvMJfHl
 TllbDzWdpNLKF95IyqemYjagW0Iri78=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-MDA83HpHPUWHRwrCJxuJyA-1; Tue, 07 Nov 2023 04:49:28 -0500
X-MC-Unique: MDA83HpHPUWHRwrCJxuJyA-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-581e2609a5dso7569267eaf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 01:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699350567; x=1699955367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lSp5s88JqE53+iDjE9NMtQoVBixzW55KFUTn7dS46ns=;
 b=PbLC1CbxF6vROmL+1Je88HK9Ys+7Pk7Rvk25x6EuL2OnSe7XgkTUyEDO1+BKr91SBT
 +qM1HB6K06I7YxqsWod6UFamh3H5HAI4hlu6YP6uuYphZ6TPAEn6/F4XWevzTLTYGScM
 zvu0dnKVpKSRDXDVCase/jSZ2EtW1mv3ewLWQA6MpzvCUjSUvwmi895mm8Mrj0+qFabe
 Ri5X6utj0GHUAo7bZdiMV55omyUYteK1gieLqbQlHn25+gfyhah5JSxCqCuEhy7oknsZ
 sogIgmDILfEnEgG1ikLhnSb7gp5B9DTBgD9RFE1mB3DHatW8echw3PnBWgM00wAJX9T0
 qWRA==
X-Gm-Message-State: AOJu0YzPOBB2l7JgoakiX6XXhki/0wLF/85WhkU0uJi2U7KFeU47/Lbe
 ImocxF2a/F1MG1s5bCtS4DYafrwJ6d3rxul5RjYL7QoMQP/sBYxUi6WbQSccMBGPtt3sV0VPGv3
 mwAd7IMx7TWapXXefmRVGrpaX/DySZ0oR4sRDzSqPJihYcwRBh80cyhHicx38Sh9VnYtF
X-Received: by 2002:a05:6820:1a08:b0:56c:d297:164c with SMTP id
 bq8-20020a0568201a0800b0056cd297164cmr36842215oob.4.1699350567799; 
 Tue, 07 Nov 2023 01:49:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENaIS9ovKdllFytI+yEPFYxBqgWKM5cVBIIzHYrq7obj2WNYQm5/VN3ExxF82c9tTYleQHfA==
X-Received: by 2002:a05:6820:1a08:b0:56c:d297:164c with SMTP id
 bq8-20020a0568201a0800b0056cd297164cmr36842201oob.4.1699350567500; 
 Tue, 07 Nov 2023 01:49:27 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 c5-20020a4ad8c5000000b0057b38a94f38sm1898827oov.12.2023.11.07.01.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 01:49:26 -0800 (PST)
Date: Tue, 7 Nov 2023 04:49:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH RFC 1/2] osdep: add getloadavg
Message-ID: <1e64d2a47b63ba7d7f49a23c02c2be91ff5c15fe.1699350487.git.mst@redhat.com>
References: <cover.1699349799.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699349799.git.mst@redhat.com>
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
index dcef8b1e79..7f333cb80e 100644
--- a/meson.build
+++ b/meson.build
@@ -2254,6 +2254,7 @@ config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
 config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependencies: util))
 config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul'))
 config_host_data.set('HAVE_SYSTEM_FUNCTION', cc.has_function('system', prefix: '#include <stdlib.h>'))
+config_host_data.set('HAVE_GETLOADAVG_FUNCTION', cc.has_function('getloadavg', prefix: '#include <stdlib.h>'))
 if rbd.found()
   config_host_data.set('HAVE_RBD_NAMESPACE_EXISTS',
                        cc.has_function('rbd_namespace_exists',
-- 
MST


