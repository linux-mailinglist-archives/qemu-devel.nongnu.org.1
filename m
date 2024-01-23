Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 432688388BE
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 09:21:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSC1x-0001RG-OM; Tue, 23 Jan 2024 03:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSC1u-0001Pj-VJ
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:21:10 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSC1s-0000NZ-Dd
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:21:10 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40eacb4bfa0so19931805e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 00:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705998066; x=1706602866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vgXaw/jt6H2vmMlwijH9Eh5yEEx14Kw5bUFUTrmJmuY=;
 b=lLlQpJ9KX95TbNNYSM8AmEU+ABI3/DIgy/OXGeO7yOsgQ1c2txGM/XYICKmV6Qujqm
 rrUaLIPPz0a55C0b5f9uZlPEduUUBRIfD3y+fgS4wBMDl0GAolR0otx5tY7Hb+qLLrnq
 pSMNTaSxaIOGGLWxR1E1U1UV+cPhVfBV4yfdVBBVhZqcgqJJVomf2eModwR/BrQlkT8x
 P2/gTuEU4f7Zwtz8cszeJKq8SV+WfvpE4hXSS6JmBtzKC/tvde8lLzxRdRyN50MMGOX4
 zotRmWYEjDyJaUhfmY2pxlh43Uoc5gE/RqKylECHmnei3ejo//xOe+y2RQEmAReDtuuW
 ypjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705998066; x=1706602866;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vgXaw/jt6H2vmMlwijH9Eh5yEEx14Kw5bUFUTrmJmuY=;
 b=lGdmsPdYy5j3Xtm7Ex5xGxelLiseFdD23ebnQu5GXSvMLOv3DjZB7AuZbWEM9pMqQ6
 /PFga8J0uJUBayyUeauHsRh9E2UNZqyg4lnKBuoRRq3N473pqiTd1TuXJSidcyQzwem/
 uwHMIhXDSljP9j7Z7gqogFssECg0GdlarZD3cAk24tqt6rwNER1h519nVBw18d9A70qn
 ypM98GshU0VDtETKXLer2Zx+Jy02qnz8rBfkVQNaKhN36YRl5Ql2lhHqeB+f2Lan40+M
 gSVVeTSmBF7nBQMdwGoRIe7VB/z1mt8KFsUjLnKInoBZmpZWBmbDgetdEoBrU906Gd8m
 X/qg==
X-Gm-Message-State: AOJu0YwiCFQoRWBv540hopK9+FFaypoECUoPUe1mdm8/LkyEyNosRStJ
 GUCw8ikJ6iTbe6PzNNAh3gZkIUdiuZib7cvvG0/9UdCY0Y/3iNisZSo8RwFT/ZyO5ZUDgujPE98
 4x9U=
X-Google-Smtp-Source: AGHT+IEzphcX6EYIcFaSPITiZbjm9JS50GyoJwXSUrl3LJaHiU/XdiuDzptnA6bWmNKsvESYkF6LUQ==
X-Received: by 2002:a7b:cb87:0:b0:40e:42ce:f28b with SMTP id
 m7-20020a7bcb87000000b0040e42cef28bmr292949wmi.52.1705998066247; 
 Tue, 23 Jan 2024 00:21:06 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 n22-20020a05600c4f9600b0040e53f24ceasm41477156wmq.16.2024.01.23.00.21.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 00:21:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] mailmap: Fix Stefan Weil email
Date: Tue, 23 Jan 2024 09:21:04 +0100
Message-ID: <20240123082104.36208-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Commit 5204b499a6 ("mailmap: Fix Stefan Weil author email")
corrected authorship for patch received at qemu-devel@nongnu.org,
correct now for patch received at qemu-trivial@nongnu.org.

Update other authorship email for Stefan's commits.

Suggested-by: Stefan Weil <sw@weilnetz.de>
Fixes: d819fc9516 ("virtio-blk: Fix potential nullptr read access")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 .mailmap | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.mailmap b/.mailmap
index d94572af05..88fb68143e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -36,6 +36,8 @@ Marek Dolata <mkdolata@us.ibm.com> mkdolata@us.ibm.com <mkdolata@us.ibm.com>
 Michael Ellerman <mpe@ellerman.id.au> michael@ozlabs.org <michael@ozlabs.org>
 Nick Hudson <hnick@vmware.com> hnick@vmware.com <hnick@vmware.com>
 Timothée Cocault <timothee.cocault@gmail.com> timothee.cocault@gmail.com <timothee.cocault@gmail.com>
+Stefan Weil <sw@weilnetz.de> <weil@mail.berlios.de>
+Stefan Weil <sw@weilnetz.de> Stefan Weil <stefan@kiwi.(none)>
 
 # There is also a:
 #    (no author) <(no author)@c046a42c-6fe2-441c-8c8c-71466251a162>
@@ -60,6 +62,7 @@ Ian McKellar <ianloic@google.com> Ian McKellar via Qemu-devel <qemu-devel@nongnu
 Julia Suvorova <jusual@mail.ru> Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
 Justin Terry (VM) <juterry@microsoft.com> Justin Terry (VM) via Qemu-devel <qemu-devel@nongnu.org>
 Stefan Weil <sw@weilnetz.de> Stefan Weil via <qemu-devel@nongnu.org>
+Stefan Weil <sw@weilnetz.de> Stefan Weil via <qemu-trivial@nongnu.org>
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com> Andrey Drobyshev via <qemu-block@nongnu.org>
 BALATON Zoltan <balaton@eik.bme.hu> BALATON Zoltan via <qemu-ppc@nongnu.org>
 
@@ -98,6 +101,7 @@ Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@redhat.com>
 Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@fungible.com>
 Roman Bolshakov <rbolshakov@ddn.com> <r.bolshakov@yadro.com>
 Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
+Stefan Weil <sw@weilnetz.de> Stefan Weil <stefan@weilnetz.de>
 Taylor Simpson <ltaylorsimpson@gmail.com> <tsimpson@quicinc.com>
 Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 
-- 
2.41.0


