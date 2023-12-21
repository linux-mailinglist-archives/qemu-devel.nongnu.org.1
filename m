Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA1B81BD20
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:23:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMiT-0007Vz-Bb; Thu, 21 Dec 2023 12:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMiP-0007Vc-84
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMiN-0004SA-Pw
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703179206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qMPfuQKYh8RDla6S4U2P4p48I7GyoAc7S/H6lEUsjtA=;
 b=SdVbcwIbRrcXq6ZxRogKAEkJsuyaElmegWvq6TXB1c9764Z6QMg8WjrU/H5v9XnQ215BY7
 iyJr5SKfid9S5p/I1UR08WJwAixUkecZ1xfV6nd3/ojOGFo76IQkfz6LLH3rpzUN9YtCUX
 HGSR4KB7nY28zL4bH0ZkSxVkNrWMkgs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-zED4vYBvO5ybCmksR4rzQg-1; Thu, 21 Dec 2023 12:20:04 -0500
X-MC-Unique: zED4vYBvO5ybCmksR4rzQg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50e4aa3f7eeso1174428e87.1
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703179202; x=1703784002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qMPfuQKYh8RDla6S4U2P4p48I7GyoAc7S/H6lEUsjtA=;
 b=BzKQS1TQkt64r3vUx2TapqfDaymxvEnKSvvOlD4KIqCi9aBCpx7IOZm0CvsgiGWWfo
 D/rJkcCEi7rxMU9lpGfQFwHzjyGj67qt+xtUJbd/XJWTtSdn+9eH9cCJLWeNtzVGVVhu
 dqKD9XySzXxvlDG+uo6lzKcAzOpgzM4QGu3oFG6VsbjgfD/soV6WexN/9rbKUAf/kbKz
 mYAdWSilSjWNQ0o9GmO8BV/zbhmuSwVRrB3Rk22RtxG71MJnZnPvMGguz+dPA4/oE2Yf
 rAWJBBz8zV9kCEZ4A4du85licp5mfr76BZkJDOtbon7wkPoE4HKwXHBL2NnX2/kHzXUZ
 +c4Q==
X-Gm-Message-State: AOJu0Yw4iS3eexWvWparRqmG3OkT946QiwdD31Zi0btEmBqJktDebHfz
 Ab8BQa6jhiDb8feifqvDRzVCM/oet6mEo6Kn4d07DgMr5gCb7Z7MrJ5JwZ/aAaalcypkv69avmn
 PhvuA8EXIdmVA/I8HxrYS2n6Wsf8g1c6gVVbaK1EUGTvj7CnGryLTcx/zo0kIWVbMhqL11Ft9yW
 riew/TZbI=
X-Received: by 2002:a19:700c:0:b0:50e:433e:c95e with SMTP id
 h12-20020a19700c000000b0050e433ec95emr5253lfc.32.1703179202548; 
 Thu, 21 Dec 2023 09:20:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9WguVIYVPGn/XjS+vmocQZSNIX1XLwgCjy/z3xySaD2EDQg9a1LGs2HLgd91BmL8AQ4S6Yw==
X-Received: by 2002:a19:700c:0:b0:50e:433e:c95e with SMTP id
 h12-20020a19700c000000b0050e433ec95emr5242lfc.32.1703179202042; 
 Thu, 21 Dec 2023 09:20:02 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 m17-20020ac24ad1000000b0050e36ba7a52sm317108lfp.67.2023.12.21.09.20.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:20:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/21] meson: fix type of "relocatable" option
Date: Thu, 21 Dec 2023 18:19:38 +0100
Message-ID: <20231221171958.59350-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221171958.59350-1-pbonzini@redhat.com>
References: <20231221171958.59350-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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


