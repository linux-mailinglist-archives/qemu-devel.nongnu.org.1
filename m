Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8727876F72A
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 03:47:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRjsv-0002ge-Fx; Thu, 03 Aug 2023 21:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsk-0002d4-NS
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:38 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsg-0005AM-6U
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:31 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-686bea20652so1482059b3a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 18:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691113527; x=1691718327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxH9JelEzWgR3VpEL1pKK9zkkgodDw/Fd0rqiGsNBAw=;
 b=neI4/4mvMMR0VnMfQV0bAnJSbvlGD+LsbynocbJ03KmUnK2t3ydsOfZwYkqLUzhR0N
 lEPD3XzPUpVAaeIePwDi1AuQh3PXEUUGnUo8blipjwM4h2XM6gZPAuIKVjGWuNmzm4U1
 bLZtawp/gktRad9YLFzNGPLs0d91r+1hfAgNiDw525wWCIWccWGM4o7MS7sKeRePS4n+
 IBJy0CrYkA4RxLVL0yjaXXjiECXMSDBKzcDZVVz4ivdklZZI8IG5gnu1WqZWWyu+CTE6
 GE0o7o3VoZjnkmVPRcZtL9Noea/I/XpwqM3bUnxL8YJZJzHQRAxgMotHHr2JoHGeOZL5
 MofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691113527; x=1691718327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FxH9JelEzWgR3VpEL1pKK9zkkgodDw/Fd0rqiGsNBAw=;
 b=GGDWEtAukcOUuRuosfuKvfw+oRvam9wRKZQpFHiiFbpz1MedS7Uq0E1Qf31iF6rgmB
 7GOD/VNLK6q+BRSjM2/OwgB0k5Z05J3xZAP4lHtwDi+kSNMITXS7iAE/Zk/cUWerDGEd
 8YPqBPd88McWtXkBCl6yyO8SpRIuAmhbTFLZ5KqkS5yamguchU8qf4gGCx886jgNFt42
 G1KIY3LwQykec3SNvbraMoKqRL03YEQoejA24RvfNa/cpz9s++R3XYXeHuEcPIwHlVMB
 NbwiGAUkKst7XaGo0pAZD+ohK/lo6NODyzs97qOIBtvDaSYw7Mi1sPr3vH0A7XoR6UEi
 ALJA==
X-Gm-Message-State: AOJu0YwxUSX6Fjhqc8+INfTRDwP0sn3Jhf1HV34I37CFx6/O4d/D49Kq
 RmoMT2ZePvLtoQdR//e5LjCKQTYMHtS9WEAfRtY=
X-Google-Smtp-Source: AGHT+IGLwzNiAO/hoJx0cFbfO3SbuNerJ6Sh1KqVhAYZGbSwvURRgop6JiS3BxE+xjyXU9cpuRTd3w==
X-Received: by 2002:a05:6a21:7795:b0:126:a80d:4960 with SMTP id
 bd21-20020a056a21779500b00126a80d4960mr316688pzc.30.1691113527293; 
 Thu, 03 Aug 2023 18:45:27 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9d52:4fe8:10ce:5c3])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa78c05000000b0066f37665a63sm456138pfd.73.2023.08.03.18.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 18:45:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: joel@jms.id.au, akihiko.odaki@daynix.com, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH v8 11/17] linux-user: Use MAP_FIXED_NOREPLACE for initial
 image mmap
Date: Thu,  3 Aug 2023 18:45:11 -0700
Message-Id: <20230804014517.6361-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804014517.6361-1-richard.henderson@linaro.org>
References: <20230804014517.6361-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Use this as extra protection for the guest mapping over
any qemu host mappings.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 2aee2298ec..0c64aad8a5 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3146,8 +3146,11 @@ static void load_elf_image(const char *image_name, int image_fd,
     /*
      * Reserve address space for all of this.
      *
-     * In the case of ET_EXEC, we supply MAP_FIXED so that we get
-     * exactly the address range that is required.
+     * In the case of ET_EXEC, we supply MAP_FIXED_NOREPLACE so that we get
+     * exactly the address range that is required.  Without reserved_va,
+     * the guest address space is not isolated.  We have attempted to avoid
+     * conflict with the host program itself via probe_guest_base, but using
+     * MAP_FIXED_NOREPLACE instead of MAP_FIXED provides an extra check.
      *
      * Otherwise this is ET_DYN, and we are searching for a location
      * that can hold the memory space required.  If the image is
@@ -3159,7 +3162,7 @@ static void load_elf_image(const char *image_name, int image_fd,
      */
     load_addr = target_mmap(loaddr, (size_t)hiaddr - loaddr + 1, PROT_NONE,
                             MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
-                            (ehdr->e_type == ET_EXEC ? MAP_FIXED : 0),
+                            (ehdr->e_type == ET_EXEC ? MAP_FIXED_NOREPLACE : 0),
                             -1, 0);
     if (load_addr == -1) {
         goto exit_mmap;
-- 
2.34.1


