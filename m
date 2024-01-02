Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 976F8821639
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:00:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3I-0003KB-OF; Mon, 01 Jan 2024 20:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3G-0003Jg-ND
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:42 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3F-00071R-5N
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:42 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6d98ce84e18so6562281b3a.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160720; x=1704765520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7M01tA40HhYtf6OFCfsrnOQ6yOhmNiUUj7BsAbVg9so=;
 b=Pmg3ki/r0FoBGQ69BDCW0COvKbsNHewTFo3uLo8OuMCMujCD37ybqFiiGi08UCKBWx
 VxHnNXJD217OKVDZzvA37Yh1kj4pr9TvcTcoc2d89laPO83yU96+iuMOe/roMmSLjRrB
 SA75gxlZZqk/eX3a7reNkFzuMB+nrGXYPzWdAMLp6brRbshAvOsPkTpeqxJ2uVxCHesF
 0IQDBCpdyLlJz+bADuiWXm+NTu4cXs91Nb8mSx/2w+RBwhttbe4E5nuq73T3ejXhE0XJ
 qxXQh1YXYhittZQWfbWQ8RgokKpup4xC09d2zf7TcabTyKfugm0HalDGixq8GCXpbKbJ
 z7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160720; x=1704765520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7M01tA40HhYtf6OFCfsrnOQ6yOhmNiUUj7BsAbVg9so=;
 b=hU061zzcY1Kqpof2ZBPupBeM2sy/Iu85ClpjHDD33NP2ufQxg31lBP5wNLhX7YWxmh
 Z6EtQiX+KzkazRUeWfpUE6Ujll1Q8DGHh6Kwy5EzmPtR4YK8K1eDuHn29JHD6AFW44UC
 nrT0OlvyfzLB+F0VhP1F1E5Iq360QChMAGYB8FOh2u1bYGniKXfcmaQ5EYE7pCFnB/QH
 5OMAKrz9L4eW/s7Beji2PhSDHcehz2xud5IxJ2WILHWgYIHDWyFjNKv9xwaMlKJ6Ausn
 cW+qPDvdo+fkWXJSj43hihS1GJNjoB5gnA+FrzNuyxVsg58iN4t2lVeZ27WBM2fxdVr3
 GQeg==
X-Gm-Message-State: AOJu0YyZZufnxwRllrtfN6cyiTM4aadQSCAgmpE0Q8QEVI/uWgNK30sG
 W5uuPvQT40NiMAuSQNNWcs2YBwMUdwAEL77KybT2DfsC9jY=
X-Google-Smtp-Source: AGHT+IG3TefqriWGAQoAbLIW38ItmrM++lpgu+M4VFyWu5luv/3+qbi4nhDU2p9nnpmCBSTEeQ6TcQ==
X-Received: by 2002:a05:6a20:4e16:b0:196:52a5:e2c9 with SMTP id
 gk22-20020a056a204e1600b0019652a5e2c9mr6859811pzb.40.1704160719806; 
 Mon, 01 Jan 2024 17:58:39 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/33] softmmu/physmem: Remove qemu_host_page_size
Date: Tue,  2 Jan 2024 12:57:48 +1100
Message-Id: <20240102015808.132373-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Use qemu_real_host_page_size() instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index a63853a7bc..c09953270f 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3520,7 +3520,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
          *    fallocate works on hugepages and shmem
          *    shared anonymous memory requires madvise REMOVE
          */
-        need_madvise = (rb->page_size == qemu_host_page_size);
+        need_madvise = (rb->page_size == qemu_real_host_page_size());
         need_fallocate = rb->fd != -1;
         if (need_fallocate) {
             /* For a file, this causes the area of the file to be zero'd
-- 
2.34.1


