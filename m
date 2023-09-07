Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B37897972B2
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:12:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEel-0007Rp-Ry; Thu, 07 Sep 2023 09:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEeF-000535-NW
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEeD-0007Ys-EF
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KivVqRpe5KN2+Ci3kMr9KmNlhmNtvTwUcH6R6cGFsIU=;
 b=fGNafF2ZHF4qwwAVknjn/Vvk3u00smHGibgBHHL+PPURITGIkG1U40O0luWIIx8xkvL182
 uGIdTDXpipfhx6Rq9xRoveQU8n18y5YrD1xLja8SLjmfvw3QrZK+sOG1ikavBLogXYklEL
 ZyxQ+Liv1u/Dn3IUNxk4J2RWMKM8VeU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-PZo3rAnmNfqGUkp1Iw6GZg-1; Thu, 07 Sep 2023 09:02:04 -0400
X-MC-Unique: PZo3rAnmNfqGUkp1Iw6GZg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-401d8873904so7464115e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091721; x=1694696521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KivVqRpe5KN2+Ci3kMr9KmNlhmNtvTwUcH6R6cGFsIU=;
 b=BimAtaICn7LNXeRtjgmSwoHnE23pF6VmRBgVujdyY2biLebR2wi9N9Ap7gHppVDqLH
 cQFMnzKleJrE8OHJHaIdyXP4yEYxJDzK8aZouS6cZF/Y8KyPeuXXd6KfZO8UC8zGgfyE
 eICWoDcRShIE+m5QySSv3ebsh35AVR+0MEnpr/VQYcqOdnE+9NCd42jrZXy4IMzfBzsB
 A1pFmik0h5eKpYQrgBlPfchp24nRjf55y9IiMBfHO1IPLyaHfft6ExIEXPqkUW3PKN1m
 BAZ2kr9LdtzLtljmLgXD2u4vq+GtAtjE7PdFX8vK3EguzmFotEdL2hxcWZhoCgQ8um4w
 ROfg==
X-Gm-Message-State: AOJu0YwUYpVDIM3j47vp47id5oTJYVECWeixLZFNMFZu1ceWSZo/S+Jv
 9lUzCLZDFhnML81qXE6bO9VCXMEXSP0PJuP2iF7R7J5CDy5O96NUeip8QEsDdwCCdyRzywK0V5A
 HMQf+/1D9+2gNhkW7z2+aETydJ412b8d2l0CzVlJafMH4NP2gJx0Dsf3vNdDA9ZX5K5xkVXh7OM
 o=
X-Received: by 2002:a05:600c:378c:b0:401:8225:14ee with SMTP id
 o12-20020a05600c378c00b00401822514eemr4715530wmr.41.1694091721775; 
 Thu, 07 Sep 2023 06:02:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoM+3phtLz17MuQIQvLSy4FxMANouEawcZiiwBeWrwe0+3whjCP99GMmqaz7c0AaYFo4laNw==
X-Received: by 2002:a05:600c:378c:b0:401:8225:14ee with SMTP id
 o12-20020a05600c378c00b00401822514eemr4715515wmr.41.1694091721477; 
 Thu, 07 Sep 2023 06:02:01 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 z14-20020adff1ce000000b0031c855d52efsm23174798wro.87.2023.09.07.06.02.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:02:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 50/51] subprojects: add wrap file for libblkio
Date: Thu,  7 Sep 2023 14:59:59 +0200
Message-ID: <20230907130004.500601-51-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This allows building libblkio at the same time as QEMU, if QEMU is
configured with --enable-blkio --enable-download.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 subprojects/libblkio.wrap | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 subprojects/libblkio.wrap

diff --git a/subprojects/libblkio.wrap b/subprojects/libblkio.wrap
new file mode 100644
index 00000000000..f77af72210c
--- /dev/null
+++ b/subprojects/libblkio.wrap
@@ -0,0 +1,6 @@
+[wrap-git]
+url = https://gitlab.com/libblkio/libblkio
+revision = f84cc963a444e4cb34813b2dcfc5bf8526947dc0
+
+[provide]
+blkio = libblkio_dep
-- 
2.41.0


