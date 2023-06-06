Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC59724635
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:34:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xif-00054H-E5; Tue, 06 Jun 2023 10:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xid-00053W-3K
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xib-0001Eh-Jb
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmO1dxEW5DiludHAYzbG2AOT8q3ojt10yczPYkAfhME=;
 b=WM4Eyc29VjRUEulhofZuwaBpRzS2o80RtlXLfIOkPWUcCjxTe6OtUxi34Q9yb2WfPXE8zf
 sGGxrbs1N/WbKwGlkP3vsBK/9WqBLbA3DX+mihE0VcaM10cHYhqalOcghiQlXCSYhGA9h+
 s5AQA/6wZSbxcg2gGjbHD1xSwtZqnt8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-luaByrUhOKqsS3QwWo5v8A-1; Tue, 06 Jun 2023 10:31:27 -0400
X-MC-Unique: luaByrUhOKqsS3QwWo5v8A-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5128dcbdfc1so3937464a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061886; x=1688653886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vmO1dxEW5DiludHAYzbG2AOT8q3ojt10yczPYkAfhME=;
 b=ddpdH+KlKhdAiAblmTRJ55CpFJXyjRUEnaLLw0kIGAvKaDgzz4Xj6G68YYzzSiIcXy
 +CRlmJENX2DJN8QREw/dIIHligKorrBNjj+b8cWZyuL0HBarYAw4ynz/b1s1ggnVUsd8
 vCwtOmuDCv9ux/kxUqha9PE6T09qA9FErQ3ZvP7PSwHbQGo3AbRK+aH/uTwKHwUNRAU/
 Ez25q8V7ENfzRrEzm1jRaYH+MIYftMpYJm91rPHsxQ3IO9ItYtLFaqDrjn3jnGxFsaJp
 FP2tbHS/n2U7oA3nGVNk3i0gFDIaniIA3UpR5+mRMg+G/EIEW7R7FoQBWKytDL9ZWqaX
 tgMQ==
X-Gm-Message-State: AC+VfDzoQYZre0F2BCurnMsK1Q8wiQIkZxANivAf/Yj322A8Xa429Kpm
 uxClIGC3/DnF/2XWZfOIfGPk4EDXGwNcFoxz4AxbWAOXSqhbaOZ0wlPw/rob9U7JLsbFgz0yd/g
 nX0tDUpR3CLWkhP4s6M3wd+Sh7zfTb9I03zLCl9nKwCyAbP7n+PpTvieYSsY4sqAFVlwFtEOHGZ
 A=
X-Received: by 2002:aa7:da0c:0:b0:514:7f39:aa81 with SMTP id
 r12-20020aa7da0c000000b005147f39aa81mr1696317eds.20.1686061885772; 
 Tue, 06 Jun 2023 07:31:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/pXQlGFQMfO8JrnvowagJN1u3Y0gWxCkEuWjwNC+2DNXc0DuGSxLREX9IQT83YEb5QFoWow==
X-Received: by 2002:aa7:da0c:0:b0:514:7f39:aa81 with SMTP id
 r12-20020aa7da0c000000b005147f39aa81mr1696303eds.20.1686061885489; 
 Tue, 06 Jun 2023 07:31:25 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 o20-20020aa7dd54000000b00514b044ec41sm5193692edw.35.2023.06.06.07.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:31:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/21] meson.build: Group the network backend entries in a
 separate summary section
Date: Tue,  6 Jun 2023 16:31:00 +0200
Message-Id: <20230606143116.685644-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606143116.685644-1-pbonzini@redhat.com>
References: <20230606143116.685644-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Let's make it easier for the users to spot network-related entries
in the summary of the meson output.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230602171832.533739-3-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index cfacd662edb..b0adf5b4617 100644
--- a/meson.build
+++ b/meson.build
@@ -4251,12 +4251,19 @@ summary_info += {'curses support':    curses}
 summary_info += {'brlapi support':    brlapi}
 summary(summary_info, bool_yn: true, section: 'User interface')
 
-# Libraries
+# Network backends
 summary_info = {}
 if targetos == 'darwin'
   summary_info += {'vmnet.framework support': vmnet}
 endif
 summary_info += {'slirp support':     slirp}
+summary_info += {'vde support':       vde}
+summary_info += {'netmap support':    have_netmap}
+summary_info += {'l2tpv3 support':    have_l2tpv3}
+summary(summary_info, bool_yn: true, section: 'Network backends')
+
+# Libraries
+summary_info = {}
 summary_info += {'libtasn1':          tasn1}
 summary_info += {'PAM':               pam}
 summary_info += {'iconv support':     iconv}
@@ -4278,9 +4285,6 @@ if targetos == 'linux'
 endif
 summary_info += {'Pipewire support':   pipewire}
 summary_info += {'JACK support':      jack}
-summary_info += {'vde support':       vde}
-summary_info += {'netmap support':    have_netmap}
-summary_info += {'l2tpv3 support':    have_l2tpv3}
 summary_info += {'Linux AIO support': libaio}
 summary_info += {'Linux io_uring support': linux_io_uring}
 summary_info += {'ATTR/XATTR support': libattr}
-- 
2.40.1


