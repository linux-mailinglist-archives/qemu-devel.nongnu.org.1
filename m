Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BC07F9C36
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 10:00:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7XRU-0002if-7E; Mon, 27 Nov 2023 03:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7XRL-0002fu-5N; Mon, 27 Nov 2023 03:58:03 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7XRA-0000JC-AE; Mon, 27 Nov 2023 03:58:01 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-285c3512f37so721256a91.3; 
 Mon, 27 Nov 2023 00:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701075453; x=1701680253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7K9aluml347AFFauR7NohNELKkT/1POWxw6ovnr1s2Q=;
 b=iL5OnR2/CQgLn4HVjgVLQp5220PxMpcPEdGkCqs8Twit0GHXkSBLGjWyu2/DVWSv41
 5c+riCc3OSSN0nKSCGp1n1LgAkWvJjYCaPNbf4+LhAFkkd8xH+pt6B4M0tnaTLbmauxM
 fxBtBrZKH538k6v02VTvtVY7+wX/33HYk4TM9c0d0QU5UVxjnER+UuKfBm2U5PBEGAVB
 wxDaFtCJWknG4zT90rEYAI5PBxS8CE1FSbnfbQETy+m5GSCnw++6lacn4oxLqVkJi0Ax
 pzNRn8N90j0YB5WghYq1wq1G7ZbmI71RrlYRc+XKjqXc8e9WO4uH5QuBimiAQtJlAN30
 U59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701075453; x=1701680253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7K9aluml347AFFauR7NohNELKkT/1POWxw6ovnr1s2Q=;
 b=wpI3sQhc2pE2ErU2rCrFwMSUfaYxL77z/CcH3J4+00F9gbpIPmudgjBNzaUrreOw6U
 sp0Z2hlNs2e6pip7KuxVTSQc6D5+jkv8opKMc6ebsOYNB7MB7kyamuW3mI+3tE/nJlLw
 ailxSxhCIWjlnoGNHoQfYwu99xG5en8XJm6Hvwf1FUs6c8z700jXiUwHahPPgd83i7an
 uEpiJD4TFZNbXPAzRSEmn38Cw7DkUdk4BuWtMYfUl5sZKRXZNsRSk//lTnpLcLgeHb1p
 2lVWreswqVFxCmmK9Fgo5M78BNevBVkc9ytUhhtkFvax4GNIoQqtQkNWyJ6Wa/eoWUTF
 BW/g==
X-Gm-Message-State: AOJu0Ywkjysp23nDmPgk6wKVkFru0fO7lrDpi+HhVcsDfASHdHV6/Mqg
 plB45u6We2eSBwRWTz4DyTdrcL5N2KkwqA==
X-Google-Smtp-Source: AGHT+IG4oNYfIjtkSzUq5mITf2w29DwgqozfzS4iu1Dl+txOQoH7uNuINdM9Om8Q+E7pxoCy7KrujQ==
X-Received: by 2002:a17:90b:180c:b0:285:adb0:de3e with SMTP id
 lw12-20020a17090b180c00b00285adb0de3emr6218988pjb.34.1701075452780; 
 Mon, 27 Nov 2023 00:57:32 -0800 (PST)
Received: from fedlinux.. ([106.84.128.244]) by smtp.gmail.com with ESMTPSA id
 ci8-20020a17090afc8800b0027d0adf653bsm6906901pjb.7.2023.11.27.00.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 00:57:32 -0800 (PST)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org, hare@suse.de, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 dlemoal@kernel.org, Sam Li <faithilikerun@gmail.com>
Subject: [RFC v2 1/7] docs/qcow2: add zd_extension_size option to the zoned
 format feature
Date: Mon, 27 Nov 2023 16:56:35 +0800
Message-Id: <20231127085641.3729-2-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231127085641.3729-1-faithilikerun@gmail.com>
References: <20231127085641.3729-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=faithilikerun@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 docs/interop/qcow2.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 0f1938f056..458d05371a 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -428,6 +428,9 @@ The fields of the zoned extension are:
                    The offset of zoned metadata structure in the contained
                    image, in bytes.
 
+          44 - 51:  zd_extension_size
+                    The size of zone descriptor extension data in bytes.
+
 == Full disk encryption header pointer ==
 
 The full disk encryption header must be present if, and only if, the
-- 
2.40.1


